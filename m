Return-Path: <linux-fsdevel+bounces-32403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B19A49F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF07283E01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436B192B67;
	Fri, 18 Oct 2024 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JNnQIEEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615819067C
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293563; cv=none; b=FRIoaDME6ui+bLXehguZ7DfEPJXS4/FrPlSVHLQsK6DvVBdTAiqcs6TKALp5C6Mm9uC0hWEy2jPPZWwTIA83X5nB+3j/XoRoiyJccoBr0jSQMqvaYVjNXnZTc4XJcxLHQaYn0OQ+g30YJry0LYZwCdiuXDyKnBvtWcwujKqfXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293563; c=relaxed/simple;
	bh=Ru7q1KUURm+W0WgriK939NckPsDn7izxaLYEvS43nh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K06ltuHINZHFtPr6KnzquMaSvqLndDoHp0Xxuox7ZurxCf0CJUWdTWoyb50ggRALME/NvDv2PUsCENjE9LLPMuaxO/NfRjqwCneBPozu22Pdq1FgTYiDQmvXHtV3XhsqN48EOahEGCNa7bQPJS+paSu1W3p/1DxkdjGxfe0wswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JNnQIEEC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iHQl9M43iBnscOh6V3WkPFb0AzB91bu+xcFwPk3E4Fs=; b=JNnQIEECCFRmSEgSzU57k3KHI/
	STVwtOmVTUXzSzQCLwMGkt9pBmGbsdeDaldPBABEZlixI9oe8zKULEBzX35lzZu39TYl6uB3fHkHn
	9u16B9p4czUhMhl4qEpmbGtGOfeNqre0wZDVDhG3iqyXefzJqDf+enwk4r+kObKkp+SdfAtlsVZQ7
	O3BqjDvX7i/fOreQ8aMvzOb3SF+gAoOSlVAzEPmk+rpo1Fu4nA330xgSI5f/3GXCOVXugQYTM7t2/
	QBeHUx3tIbnlfEv1wQmMvVbyLnYEwOyG+a3S+R5IFvGUbLtCqUv8QYQMuZD2lf1YwhEOoUWSeBZJi
	mLBJhpjg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E7A-3FO2;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 11/17] clean ufs_trunc_direct() up a bit...
Date: Sat, 19 Oct 2024 00:19:10 +0100
Message-ID: <20241018231916.1245836-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
References: <20241018231428.GC1172273@ZenIV>
 <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

For short files (== no indirect blocks needed) UFS allows the last
block to be a partial one.  That creates some complications for
truncation down to "short file" lengths.  ufs_trunc_direct() is
called when we'd already made sure that new EOF is not in a hole;
nothing needs to be done if we are extending the file and in
case we are shrinking the file it needs to
	* shrink or free the old final block.
	* free all full direct blocks between the new and old EOF.
	* possibly shrink the new final block.

The logics is needlessly complicated by trying to keep all cases
handled by the same sequence of operations.
	if not shrinking
		nothing to do
	else if number of full blocks unchanged
		free the tail of possibly partial last block
	else
		free the tail of (currently full) new last block
		free all present (full) blocks in between
		free the (possibly partial) old last block

is easier to follow than the result of trying to unify these
cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/inode.c | 129 +++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 68 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 71d28561200f..a3475afb3c26 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -878,91 +878,84 @@ static inline void free_data(struct to_free *ctx, u64 from, unsigned count)
 
 #define DIRECT_FRAGMENT ((inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift)
 
+/*
+ * used only for truncation down to direct blocks.
+ */
 static void ufs_trunc_direct(struct inode *inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
-	void *p;
-	u64 frag1, frag2, frag3, frag4, block1, block2;
+	struct super_block *sb = inode->i_sb;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
+	unsigned int new_frags, old_frags;
+	unsigned int old_slot, new_slot;
+	unsigned int old_tail, new_tail;
 	struct to_free ctx = {.inode = inode};
-	unsigned i, tmp;
 
 	UFSD("ENTER: ino %lu\n", inode->i_ino);
 
-	sb = inode->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
-
-	frag1 = DIRECT_FRAGMENT;
-	frag4 = min_t(u64, UFS_NDIR_FRAGMENT, ufsi->i_lastfrag);
-	frag2 = ((frag1 & uspi->s_fpbmask) ? ((frag1 | uspi->s_fpbmask) + 1) : frag1);
-	frag3 = frag4 & ~uspi->s_fpbmask;
-	block1 = block2 = 0;
-	if (frag2 > frag3) {
-		frag2 = frag4;
-		frag3 = frag4 = 0;
-	} else if (frag2 < frag3) {
-		block1 = ufs_fragstoblks (frag2);
-		block2 = ufs_fragstoblks (frag3);
-	}
-
-	UFSD("ino %lu, frag1 %llu, frag2 %llu, block1 %llu, block2 %llu,"
-	     " frag3 %llu, frag4 %llu\n", inode->i_ino,
-	     (unsigned long long)frag1, (unsigned long long)frag2,
-	     (unsigned long long)block1, (unsigned long long)block2,
-	     (unsigned long long)frag3, (unsigned long long)frag4);
+	new_frags = DIRECT_FRAGMENT;
+	// new_frags = first fragment past the new EOF
+	old_frags = min_t(u64, UFS_NDIR_FRAGMENT, ufsi->i_lastfrag);
+	// old_frags = first fragment past the old EOF or covered by indirects
 
-	if (frag1 >= frag2)
-		goto next1;
-
-	/*
-	 * Free first free fragments
-	 */
-	p = ufs_get_direct_data_ptr(uspi, ufsi, ufs_fragstoblks(frag1));
-	tmp = ufs_data_ptr_to_cpu(sb, p);
-	if (!tmp )
-		ufs_panic (sb, "ufs_trunc_direct", "internal error");
-	frag2 -= frag1;
-	frag1 = ufs_fragnum (frag1);
+	if (new_frags >= old_frags)	 // expanding - nothing to free
+		goto done;
 
-	ufs_free_fragments(inode, tmp + frag1, frag2);
+	old_tail = ufs_fragnum(old_frags);
+	old_slot = ufs_fragstoblks(old_frags);
+	new_tail = ufs_fragnum(new_frags);
+	new_slot = ufs_fragstoblks(new_frags);
 
-next1:
-	/*
-	 * Free whole blocks
-	 */
-	for (i = block1 ; i < block2; i++) {
-		p = ufs_get_direct_data_ptr(uspi, ufsi, i);
-		tmp = ufs_data_ptr_to_cpu(sb, p);
+	if (old_slot == new_slot) { // old_tail > 0
+		void *p = ufs_get_direct_data_ptr(uspi, ufsi, old_slot);
+		u64 tmp = ufs_data_ptr_to_cpu(sb, p);
 		if (!tmp)
-			continue;
-		write_seqlock(&ufsi->meta_lock);
-		ufs_data_ptr_clear(uspi, p);
-		write_sequnlock(&ufsi->meta_lock);
+			ufs_panic(sb, __func__, "internal error");
+		if (!new_tail) {
+			write_seqlock(&ufsi->meta_lock);
+			ufs_data_ptr_clear(uspi, p);
+			write_sequnlock(&ufsi->meta_lock);
+		}
+		ufs_free_fragments(inode, tmp + new_tail, old_tail - new_tail);
+	} else {
+		unsigned int slot = new_slot;
 
-		free_data(&ctx, tmp, uspi->s_fpb);
-	}
+		if (new_tail) {
+			void *p = ufs_get_direct_data_ptr(uspi, ufsi, slot++);
+			u64 tmp = ufs_data_ptr_to_cpu(sb, p);
+			if (!tmp)
+				ufs_panic(sb, __func__, "internal error");
 
-	free_data(&ctx, 0, 0);
+			ufs_free_fragments(inode, tmp + new_tail,
+						uspi->s_fpb - new_tail);
+		}
+		while (slot < old_slot) {
+			void *p = ufs_get_direct_data_ptr(uspi, ufsi, slot++);
+			u64 tmp = ufs_data_ptr_to_cpu(sb, p);
+			if (!tmp)
+				continue;
+			write_seqlock(&ufsi->meta_lock);
+			ufs_data_ptr_clear(uspi, p);
+			write_sequnlock(&ufsi->meta_lock);
 
-	if (frag3 >= frag4)
-		goto next3;
+			free_data(&ctx, tmp, uspi->s_fpb);
+		}
 
-	/*
-	 * Free last free fragments
-	 */
-	p = ufs_get_direct_data_ptr(uspi, ufsi, ufs_fragstoblks(frag3));
-	tmp = ufs_data_ptr_to_cpu(sb, p);
-	if (!tmp )
-		ufs_panic(sb, "ufs_truncate_direct", "internal error");
-	frag4 = ufs_fragnum (frag4);
-	write_seqlock(&ufsi->meta_lock);
-	ufs_data_ptr_clear(uspi, p);
-	write_sequnlock(&ufsi->meta_lock);
+		free_data(&ctx, 0, 0);
 
-	ufs_free_fragments (inode, tmp, frag4);
- next3:
+		if (old_tail) {
+			void *p = ufs_get_direct_data_ptr(uspi, ufsi, slot);
+			u64 tmp = ufs_data_ptr_to_cpu(sb, p);
+			if (!tmp)
+				ufs_panic(sb, __func__, "internal error");
+			write_seqlock(&ufsi->meta_lock);
+			ufs_data_ptr_clear(uspi, p);
+			write_sequnlock(&ufsi->meta_lock);
 
+			ufs_free_fragments(inode, tmp, old_tail);
+		}
+	}
+done:
 	UFSD("EXIT: ino %lu\n", inode->i_ino);
 }
 
-- 
2.39.5


