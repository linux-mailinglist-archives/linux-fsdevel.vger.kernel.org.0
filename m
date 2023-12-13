Return-Path: <linux-fsdevel+bounces-5799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EE8108AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A0C282369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E20DDB5;
	Wed, 13 Dec 2023 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rWS8vDRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371AADC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zceKd/TlPDr/aNSNr3L/G9bEBgVSRQECu2FfNe+Vffk=; b=rWS8vDRdz9ZJh0HCqufgpseKt8
	9sTeEdmGBkSEEpVzPmfU+LnTz47y/8Dm7WekVaVHFadE3Nupt4uDgk92w6R8HXNZZ0UReIDvWfSh+
	uqTxdZfpf35T5uVWX/0sVQ7cMOBBkSjQRhUfN98Qm3mZK5bnqzB2WMUqUVaTWe43h3zR0+UKdDjcy
	33Q+2vt6RrjDPnA3MVABjbqI1Wcp9PIthHjKeShAixCsEtRAoVLPAM1yZfA/9/YkIDBsNExxin5bn
	gPFXE/p6HoTIUfl0VrR0YTcKnS7zhYGdqAtS4YGnS1melyy7kBKyfcRERRErfgRSv74GPrtrysI7j
	PkHOM2sA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDFlV-00BbyQ-2b;
	Wed, 13 Dec 2023 03:18:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 12/12] clean ufs_trunc_direct() up a bit...
Date: Wed, 13 Dec 2023 03:18:27 +0000
Message-Id: <20231213031827.2767531-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
References: <20231213031639.GJ1674809@ZenIV>
 <20231213031827.2767531-1-viro@zeniv.linux.org.uk>
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
		free the tail of (full) new last block
		free all present (full) blocks in between
		free the (possibly partial) old last block

is easier to follow than the result of trying to unify these
cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/inode.c | 124 ++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index e1c736409af8..c573f444afd4 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -875,91 +875,87 @@ static inline void free_data(struct to_free *ctx, u64 from, unsigned count)
 
 #define DIRECT_FRAGMENT ((inode->i_size + uspi->s_fsize - 1) >> uspi->s_fshift)
 
+/*
+ * used only for truncation down to direct blocks.
+ */
 static void ufs_trunc_direct(struct inode *inode)
 {
 	struct ufs_inode_info *ufsi = UFS_I(inode);
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
+	struct super_block *sb = inode->i_sb;
+	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	void *p;
-	u64 frag1, frag2, frag3, frag4, block1, block2;
+	u64 frag1, frag4, block1, block2;
+	unsigned old_partial, new_partial, old_blocks, new_blocks;
 	struct to_free ctx = {.inode = inode};
 	unsigned i, tmp;
 
 	UFSD("ENTER: ino %lu\n", inode->i_ino);
 
-	sb = inode->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
-
 	frag1 = DIRECT_FRAGMENT;
+	// frag1 = first fragment past the new EOF
 	frag4 = min_t(u64, UFS_NDIR_FRAGMENT, ufsi->i_lastfrag);
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
-
-	if (frag1 >= frag2)
-		goto next1;
+	// frag4 = first fragment past the old EOF or covered by indirects
 
-	/*
-	 * Free first free fragments
-	 */
-	p = ufs_get_direct_data_ptr(uspi, ufsi, ufs_fragstoblks(frag1));
-	tmp = ufs_data_ptr_to_cpu(sb, p);
-	if (!tmp )
-		ufs_panic (sb, "ufs_trunc_direct", "internal error");
-	frag2 -= frag1;
-	frag1 = ufs_fragnum (frag1);
+	if (frag1 >= frag4)	 // expanding - nothing to free
+		goto next3;
 
-	ufs_free_fragments(inode, tmp + frag1, frag2);
+	old_partial = ufs_fragnum(frag4);
+	old_blocks = ufs_fragstoblks(frag4);
+	new_partial = ufs_fragnum(frag1);
+	new_blocks = ufs_fragstoblks(frag1);
 
-next1:
-	/*
-	 * Free whole blocks
-	 */
-	for (i = block1 ; i < block2; i++) {
-		p = ufs_get_direct_data_ptr(uspi, ufsi, i);
+	if (old_blocks == new_blocks) {
+		p = ufs_get_direct_data_ptr(uspi, ufsi, new_blocks);
 		tmp = ufs_data_ptr_to_cpu(sb, p);
 		if (!tmp)
-			continue;
-		write_seqlock(&ufsi->meta_lock);
-		ufs_data_ptr_clear(uspi, p);
-		write_sequnlock(&ufsi->meta_lock);
+			ufs_panic (sb, "ufs_trunc_direct", "internal error");
+		if (!new_partial) {
+			write_seqlock(&ufsi->meta_lock);
+			ufs_data_ptr_clear(uspi, p);
+			write_sequnlock(&ufsi->meta_lock);
+		}
+		ufs_free_fragments(inode, tmp + new_partial,
+			old_partial - new_partial);
+	} else {
+		block1 = new_blocks;
+		block2 = old_partial ? old_blocks-1 : old_blocks;
+
+		if (new_partial) {
+			p = ufs_get_direct_data_ptr(uspi, ufsi, new_blocks);
+			tmp = ufs_data_ptr_to_cpu(sb, p);
+			if (!tmp)
+				ufs_panic (sb, "ufs_trunc_direct", "internal error");
+			ufs_free_fragments(inode, tmp + new_partial,
+						uspi->s_fpb - new_partial);
+			block1++;
+		}
+		for (i = block1 ; i < block2; i++) {
+			p = ufs_get_direct_data_ptr(uspi, ufsi, i);
+			tmp = ufs_data_ptr_to_cpu(sb, p);
+			if (!tmp)
+				continue;
+			write_seqlock(&ufsi->meta_lock);
+			ufs_data_ptr_clear(uspi, p);
+			write_sequnlock(&ufsi->meta_lock);
 
-		free_data(&ctx, tmp, uspi->s_fpb);
-	}
+			free_data(&ctx, tmp, uspi->s_fpb);
+		}
 
-	free_data(&ctx, 0, 0);
+		free_data(&ctx, 0, 0);
 
-	if (frag3 >= frag4)
-		goto next3;
+		if (old_partial) {
+			p = ufs_get_direct_data_ptr(uspi, ufsi, old_blocks);
+			tmp = ufs_data_ptr_to_cpu(sb, p);
+			if (!tmp)
+				ufs_panic(sb, "ufs_truncate_direct", "internal error");
+			write_seqlock(&ufsi->meta_lock);
+			ufs_data_ptr_clear(uspi, p);
+			write_sequnlock(&ufsi->meta_lock);
 
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
-
-	ufs_free_fragments (inode, tmp, frag4);
+			ufs_free_fragments(inode, tmp, old_partial);
+		}
+	}
  next3:
-
 	UFSD("EXIT: ino %lu\n", inode->i_ino);
 }
 
-- 
2.39.2


