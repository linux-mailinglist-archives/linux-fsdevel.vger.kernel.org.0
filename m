Return-Path: <linux-fsdevel+bounces-44416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28CA6868A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC27F3AA7DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F20B2505B8;
	Wed, 19 Mar 2025 08:17:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B242A93;
	Wed, 19 Mar 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372257; cv=none; b=rs4qp6DnL6ulhwFE+TDm44nrN38x9jQmSbWWvuhb1pRizY1TB/YiUanPKkoKLN0NjSKxN0u5b89OvjvrkMVHtJWfVBCIMlgRXVHi8Nj8mEKaop1b6MBPW8+fp8gGZdfpFr1wCwtFByuvNLRJN1HyYKbPv9XUdcTgH7bsndpZ9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372257; c=relaxed/simple;
	bh=ZLmBezBDWfIQPFZftRo8pyyejObu0SQitX9Sp2sZav4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFPs6msyXB8+IRGj6nLB1BO+iFfy2CW4OKLt2w0YkOyjemFjfVlnEhbt/Ncgz5TZ5GNXqnKknJBW+m1/L0XvNYTZ+zBN3pwgrvRr8rZxLR2USBbEGvLzmdI1OIh1SkdtXh9DXmRIY6sKOoFV3RA5iHn8Hhdlfei7iQnX13M1eBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C30367373; Wed, 19 Mar 2025 09:17:30 +0100 (CET)
Date: Wed, 19 Mar 2025 09:17:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -next] iomap: fix inline data on buffered read
Message-ID: <20250319081730.GB26281@lst.de>
References: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'd move the iomap_iter_advance into iomap_read_inline_data, just like
we've pushed it down as far as possible elsewhere, e.g. something like
the patch below.  Although with that having size and length puzzles
me a bit, so maybe someone more familar with the code could figure
out why we need both, how they can be different and either document
or eliminate that.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d52cfdc299c4..7858c8834144 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -332,15 +332,15 @@ struct iomap_readpage_ctx {
  * Only a single IOMAP_INLINE extent is allowed at the end of each file.
  * Returns zero for success to complete the read, or the usual negative errno.
  */
-static int iomap_read_inline_data(const struct iomap_iter *iter,
-		struct folio *folio)
+static int iomap_read_inline_data(struct iomap_iter *iter, struct folio *folio)
 {
 	const struct iomap *iomap = iomap_iter_srcmap(iter);
 	size_t size = i_size_read(iter->inode) - iomap->offset;
+	loff_t length = iomap_length(iter);
 	size_t offset = offset_in_folio(folio, iomap->offset);
 
 	if (folio_test_uptodate(folio))
-		return 0;
+		goto advance;
 
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
@@ -349,7 +349,8 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 
 	folio_fill_tail(folio, offset, iomap->inline_data, size);
 	iomap_set_range_uptodate(folio, offset, folio_size(folio) - offset);
-	return 0;
+advance:
+	return iomap_iter_advance(iter, &length);
 }
 
 static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,

