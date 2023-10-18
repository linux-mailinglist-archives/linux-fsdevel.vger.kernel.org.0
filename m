Return-Path: <linux-fsdevel+bounces-627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4267CDB7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CB281C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515B341AC;
	Wed, 18 Oct 2023 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDB1F5E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 12:22:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5198;
	Wed, 18 Oct 2023 05:22:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56BE467373; Wed, 18 Oct 2023 14:22:20 +0200 (CEST)
Date: Wed, 18 Oct 2023 14:22:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Stancek <jstancek@redhat.com>
Cc: djwong@kernel.org, willy@infradead.org, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] iomap: fix short copy in iomap_write_iter()
Message-ID: <20231018122220.GB10751@lst.de>
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 10:24:20AM +0200, Jan Stancek wrote:
> Make next iteration retry with amount of bytes we managed to copy.

The observation and logic fix look good.  But I wonder if simply
using a goto instead of the extra variable would be a tad cleaner?
Something like this?

---
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 061f3d14c12001..2d491590795aa4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -881,8 +881,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 
+		bytes = iov_iter_count(i);
+retry:
 		offset = pos & (chunk - 1);
-		bytes = min(chunk - offset, iov_iter_count(i));
+		bytes = min(chunk - offset, bytes);
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
 		if (unlikely(status))
@@ -933,10 +935,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
-				bytes = copied;
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
+			if (copied) {
+				bytes = copied;
+				goto retry;
+			}
 		} else {
 			pos += status;
 			written += status;

