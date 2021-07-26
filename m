Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E643D64D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhGZQGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:06:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45454 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbhGZQG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:06:27 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0566820077;
        Mon, 26 Jul 2021 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627318010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=2ymNgL3HPaI/Y/4VueLdgsmWtvpUDU+GH8v3Sanfm3Q=;
        b=KJChXHWgqEoqrfG1+j7ucbGuqbwsVcnK0CcQlqbtpUPUWiOZnoU+lRUSzNAL/J+LpLCS8s
        4HVYeCay4x0AhtYih8Wzo/eiU+cdtLKDEMYOpw3keJQx5zHIaK21OE+vVa7Oct6HjS1IiM
        vzR2KxVEx8zqzZM9p3QY3lKgEkYY020=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627318010;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=2ymNgL3HPaI/Y/4VueLdgsmWtvpUDU+GH8v3Sanfm3Q=;
        b=7+BDS5HI0xXUMbCRDuXkIwcV4wY0ToWFmSVE2n3cdth6RbR4FvOn0oJzWu9hCDgsu43HQV
        BMtpqWvMEXR4veCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 96CA713A91;
        Mon, 26 Jul 2021 16:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id RkI6G/nm/mB3OgAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Mon, 26 Jul 2021 16:46:49 +0000
Date:   Mon, 26 Jul 2021 11:46:47 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH] fs: reduce pointers while using file_ra_state_init()
Message-ID: <20210726164647.brx3l2ykwv3zz7vr@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Simplification.

file_ra_state_init() take struct address_space *, just to use inode
pointer by dereferencing from mapping->host.

The callers also derive mapping either by file->f_mapping, or
even file->f_mapping->host->i_mapping.

Change file_ra_state_init() to accept struct inode * to reduce pointer
dereferencing, both in the callee and the caller.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/free-space-cache.c | 2 +-
 fs/btrfs/ioctl.c            | 2 +-
 fs/btrfs/relocation.c       | 2 +-
 fs/btrfs/send.c             | 2 +-
 fs/nfs/nfs4file.c           | 2 +-
 fs/open.c                   | 2 +-
 fs/verity/enable.c          | 2 +-
 include/linux/fs.h          | 2 +-
 mm/readahead.c              | 4 ++--
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 4806295116d8..c43bf9915cda 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -351,7 +351,7 @@ static void readahead_cache(struct inode *inode)
 	if (!ra)
 		return;
 
-	file_ra_state_init(ra, inode->i_mapping);
+	file_ra_state_init(ra, inode);
 	last_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
 	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5dc2fd843ae3..b3508887d466 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1399,7 +1399,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 	if (!file) {
 		ra = kzalloc(sizeof(*ra), GFP_KERNEL);
 		if (ra)
-			file_ra_state_init(ra, inode->i_mapping);
+			file_ra_state_init(ra, inode);
 	} else {
 		ra = &file->f_ra;
 	}
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index b70be2ac2e9e..4f35672b93a5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2911,7 +2911,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	if (ret)
 		goto out;
 
-	file_ra_state_init(ra, inode->i_mapping);
+	file_ra_state_init(ra, inode);
 
 	ret = setup_extent_mapping(inode, cluster->start - offset,
 				   cluster->end - offset, cluster->start);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bd69db72acc5..3eb8d2277a3d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4949,7 +4949,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 
 	/* initial readahead */
 	memset(&sctx->ra, 0, sizeof(struct file_ra_state));
-	file_ra_state_init(&sctx->ra, inode->i_mapping);
+	file_ra_state_init(&sctx->ra, inode);
 
 	while (index <= last_index) {
 		unsigned cur_len = min_t(unsigned, len,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index a1e5c6b85ded..c810a6151c93 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -385,7 +385,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 	nfs_file_set_open_context(filep, ctx);
 	put_nfs_open_context(ctx);
 
-	file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
+	file_ra_state_init(&filep->f_ra, file_inode(filep));
 	res = filep;
 out_free_name:
 	kfree(read_name);
diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..9c6773a4fb30 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -840,7 +840,7 @@ static int do_dentry_open(struct file *f,
 	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
-	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+	file_ra_state_init(&f->f_ra, inode);
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 77e159a0346b..460d881080ac 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -66,7 +66,7 @@ static int build_merkle_tree_level(struct file *filp, unsigned int level,
 		dst_block_num = 0; /* unused */
 	}
 
-	file_ra_state_init(&ra, filp->f_mapping);
+	file_ra_state_init(&ra, inode);
 
 	for (i = 0; i < num_blocks_to_hash; i++) {
 		struct page *src_page;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..3b8ce0221477 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3260,7 +3260,7 @@ extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 
 
 extern void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
+file_ra_state_init(struct file_ra_state *ra, struct inode *inode);
 extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t no_llseek(struct file *file, loff_t offset, int whence);
 extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
diff --git a/mm/readahead.c b/mm/readahead.c
index d589f147f4c2..3541941df5e7 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -31,9 +31,9 @@
  * memset *ra to zero.
  */
 void
-file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
+file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
 {
-	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+	ra->ra_pages = inode_to_bdi(inode)->ra_pages;
 	ra->prev_pos = -1;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
-- 
2.32.0


-- 
Goldwyn
