Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB66EB3D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjDUVod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjDUVoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407EF1FF0;
        Fri, 21 Apr 2023 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QZSPgijKCu3Y3/12/R8LbE206e1fX9dQfHKdMNON/W8=; b=oFywjwINQnJi1wLFD/p2jy2j7L
        YzaKpUjXYeUccWb/Nv5aW9K9NT0ZiPfQ5qLf6tyvltqi0NzPK5Dqiyjep/DwF9A0si0uEBf/bxZ1a
        gC3ggPEPcz4//L5fnHODuyCTOEd+G0oIS3iCLNKOjC8gFEP6lxkUml1fa0r33CKeLmcMdw+EKZ/rz
        EyUHrfWth/uiSWRR9n5AjEBXdeZUg2klO11cMNtkhUKw0bjosgZvqzfu1mlsfgxOhbCOoRLqLq3BB
        w3QKnGmL5aC2RSOu972POaXT0PC9eMLB7F2HwvVQ38UMYkfPO3/V1FNdAdEMLhrhATJUDT86vHTiQ
        0AVSMYmQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btow-2i;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 8/8] shmem: add support to customize block size on multiple PAGE_SIZE
Date:   Fri, 21 Apr 2023 14:44:00 -0700
Message-Id: <20230421214400.2836131-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows tmpfs mounts to use a custom block size. We only allow
block sizes greater than PAGE_SIZE, and these must also be a multiple
of the PAGE_SIZE too.

Only simple tests have been run so far:

time for i in $(seq 1 1000000); do echo $i >> /root/ordered.txt; done

real    0m21.392s
user    0m8.077s
sys     0m13.098s

du -h /root/ordered.txt
6.6M    /root/ordered.txt

sha1sum /root/ordered.txt
2dcc06b7ca3b7dd8b5626af83c1be3cb08ddc76c  /root/ordered.txt

stat /root/ordered.txt
  File: /root/ordered.txt
  Size: 6888896         Blocks: 13456      IO Block: 4096   regular file
Device: 254,1   Inode: 655717      Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-04-21 19:34:20.709869093 +0000
Modify: 2023-04-21 19:34:43.833900042 +0000
Change: 2023-04-21 19:34:43.833900042 +0000
 Birth: 2023-04-21 19:34:20.709869093 +0000

8 KiB block size:

sha1sum /root/ordered.txt
mount -t tmpfs            -o size=10M,bsize=$((4096*2)) -o noswap tmpfs /data-tmpfs/
cp /root/ordered.txt
sha1sum /data-tmpfs/ordered.txt
stat /data-tmpfs/ordered.txt
2dcc06b7ca3b7dd8b5626af83c1be3cb08ddc76c  /root/ordered.txt
2dcc06b7ca3b7dd8b5626af83c1be3cb08ddc76c  /data-tmpfs/ordered.txt
  File: /data-tmpfs/ordered.txt
  Size: 6888896         Blocks: 13456      IO Block: 8192   regular file
Device: 0,42    Inode: 2           Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-04-21 19:31:16.078390405 +0000
Modify: 2023-04-21 19:31:16.070391363 +0000
Change: 2023-04-21 19:31:16.070391363 +0000
 Birth: 2023-04-21 19:31:16.034395676 +0000

64 KiB block size:

sha1sum /root/ordered.txt
mount -t tmpfs            -o size=10M,bsize=$((4096*16)) -o noswap tmpfs /data-tmpfs/
cp /root/ordered.txt /data-tmpfs/; sha1sum /data-tmpfs/ordered.txt
stat /data-tmpfs/ordered.txt
2dcc06b7ca3b7dd8b5626af83c1be3cb08ddc76c  /root/ordered.txt
2dcc06b7ca3b7dd8b5626af83c1be3cb08ddc76c  /data-tmpfs/ordered.txt
  File: /data-tmpfs/ordered.txt
  Size: 6888896         Blocks: 13568      IO Block: 65536  regular file
Device: 0,42    Inode: 2           Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2023-04-21 19:32:14.669796970 +0000
Modify: 2023-04-21 19:32:14.661796959 +0000
Change: 2023-04-21 19:32:14.661796959 +0000
 Birth: 2023-04-21 19:32:14.649796944 +0000

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 740b4448f936..64108c28eebd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -118,11 +118,13 @@ struct shmem_options {
 	int huge;
 	int seen;
 	bool noswap;
+	u64 blocksize;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
 #define SHMEM_SEEN_NOSWAP 16
+#define SHMEM_SEEN_BLOCKSIZE 32
 };
 
 static u64 shmem_default_bsize(void)
@@ -3779,6 +3781,7 @@ enum shmem_param {
 	Opt_inode32,
 	Opt_inode64,
 	Opt_noswap,
+	Opt_bsize,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3801,6 +3804,7 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
 	fsparam_flag  ("noswap",	Opt_noswap),
+	fsparam_u32   ("bsize",		Opt_bsize),
 	{}
 };
 
@@ -3827,7 +3831,14 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		}
 		if (*rest)
 			goto bad_value;
-		ctx->blocks = DIV_ROUND_UP(size, shmem_default_bsize());
+		if (!(ctx->seen & SHMEM_SEEN_BLOCKSIZE) ||
+		    ctx->blocksize == shmem_default_bsize())
+			ctx->blocks = DIV_ROUND_UP(size, shmem_default_bsize());
+		else {
+			if (size < ctx->blocksize || size % ctx->blocksize != 0)
+				goto bad_value;
+			ctx->blocks = DIV_ROUND_UP(size, ctx->blocksize);
+		}
 		ctx->seen |= SHMEM_SEEN_BLOCKS;
 		break;
 	case Opt_nr_blocks:
@@ -3892,6 +3903,23 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->noswap = true;
 		ctx->seen |= SHMEM_SEEN_NOSWAP;
 		break;
+	case Opt_bsize:
+		ctx->blocksize = result.uint_32;
+		ctx->seen |= SHMEM_SEEN_BLOCKSIZE;
+		/* Must be >= PAGE_SIZE */
+		if (ctx->blocksize < PAGE_SIZE)
+			goto bad_value;
+		/*
+		 * We cap this to allow a block to be at least allowed to
+		 * be allocated using the buddy allocator. That's MAX_ORDER
+		 * pages. So 4 MiB on x86_64.
+		 */
+		if (ctx->blocksize > (1 << (MAX_ORDER + PAGE_SHIFT)))
+			goto bad_value;
+		/* The blocksize must be a multiple of the page size so must be aligned */
+		if (!PAGE_ALIGNED(ctx->blocksize))
+			goto bad_value;
+		break;
 	}
 	return 0;
 
@@ -3963,6 +3991,12 @@ static int shmem_reconfigure(struct fs_context *fc)
 	raw_spin_lock(&sbinfo->stat_lock);
 	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
 
+	if (ctx->seen & SHMEM_SEEN_BLOCKSIZE) {
+		if (ctx->blocksize != shmem_sb_blocksize(sbinfo)) {
+			err = "Cannot modify block size on remount";
+			goto out;
+		}
+	}
 	if ((ctx->seen & SHMEM_SEEN_BLOCKS) && ctx->blocks) {
 		if (!sbinfo->max_blocks) {
 			err = "Cannot retroactively limit size";
@@ -4078,6 +4112,8 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	shmem_show_mpol(seq, sbinfo->mpol);
 	if (sbinfo->noswap)
 		seq_printf(seq, ",noswap");
+	if (shmem_sb_blocksize(sbinfo) != shmem_default_bsize())
+		seq_printf(seq, ",bsize=%llu", shmem_sb_blocksize(sbinfo));
 	return 0;
 }
 
@@ -4115,10 +4151,12 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * but the internal instance is left unlimited.
 	 */
 	if (!(sb->s_flags & SB_KERNMOUNT)) {
+		if (!(ctx->seen & SHMEM_SEEN_BLOCKSIZE))
+			ctx->blocksize = shmem_default_bsize();
 		if (!(ctx->seen & SHMEM_SEEN_BLOCKS))
-			ctx->blocks = shmem_default_max_blocks(shmem_default_bsize());
+			ctx->blocks = shmem_default_max_blocks(ctx->blocksize);
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
-			ctx->inodes = shmem_default_max_inodes(shmem_default_bsize());
+			ctx->inodes = shmem_default_max_inodes(ctx->blocksize);
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
 		sbinfo->noswap = ctx->noswap;
@@ -4127,7 +4165,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
-	sbinfo->blocksize = shmem_default_bsize();
+	sbinfo->blocksize = ctx->blocksize;
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -4155,7 +4193,6 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize = shmem_sb_blocksize(sbinfo);
 	sb->s_blocksize_bits = __ffs(sb->s_blocksize);
-	WARN_ON_ONCE(sb->s_blocksize_bits != PAGE_SHIFT);
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	sb->s_time_gran = 1;
-- 
2.39.2

