Return-Path: <linux-fsdevel+bounces-2302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B47E495B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527EB28134A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105136B04;
	Tue,  7 Nov 2023 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyFIZPDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB636AFE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:42:11 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537D184
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mtzc42jL92/A9PanSigtfnK/05Wkzw2xa6Ym8wnoe4o=; b=pyFIZPDqctPbt7Katju0AIszWP
	NJd1Sq4rnvUhPffnwpknxn2EQQrIUmp4mHxyzHhQfwL/c/XSxnqW7/ZjOTy5Y+PgIJO3Qysm7lvOn
	A/vCwRHWN1VNp0moP0OuzzHytuT1ir7EMFSkC3SLGFtyVdPp4mwCqOhawQFyPW5oqweM1ESq77DQ6
	FgrkP4vBD9bZ4NIPFCrXkIhXqyubxD9Uci0ql6d7NcSMoeQnhjDm/5FkQg70QlcRZ5uCrR5vjFGoZ
	StxoJtg8y4XxUxVugVylTKtPji0tzZL9r3xcfc5X5R06UGs1PuO1fOeGjlHcg8+tO/YHmKPzOB/jL
	BmvFpAKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0RxU-00E9l5-0C; Tue, 07 Nov 2023 19:41:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] buffer: Cast block to loff_t before shifting it
Date: Tue,  7 Nov 2023 19:41:51 +0000
Message-Id: <20231107194152.3374087-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231107194152.3374087-1-willy@infradead.org>
References: <20231107194152.3374087-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While sector_t is always defined as a u64 today, that hasn't always been
the case and it might not always be the same size as loff_t in the future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c83bb89b2e24..2f08af3c47a2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2008,7 +2008,7 @@ static int
 iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 		const struct iomap *iomap)
 {
-	loff_t offset = block << inode->i_blkbits;
+	loff_t offset = (loff_t)block << inode->i_blkbits;
 
 	bh->b_bdev = iomap->bdev;
 
-- 
2.42.0


