Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B913F7751F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHIEc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 00:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIEc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 00:32:26 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F941BC3
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 21:32:25 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583b3939521so74119437b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 21:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691555545; x=1692160345;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fwvZIfkWxNDBAA2VDHz4cV0MGL3i8yqkmn2UYcR8Z9E=;
        b=5Alg+xenp1VtdRcTTiXegQmvVx8wy8aB4AnR3TYfFwxSSxxPNENMNSt97yEdGrUomF
         NVZb/9pCOJoouoToNfrQBTHhZBj1EesKjIvAxP6VCdurukvN0Q8leXUyfg2LOat9CP31
         Q5FWQVPkNrMwaPA2S0kCOX/DeVEZl+iG2xcwrtiUoANuf8nGtYz5QN7xi0CTGFxuSqbN
         PSRfnYgOr2B3jxdIuMkYej0ebVCRGknFkxX6EnXyoSXhG5MW6xZasEahhgUijN4NRvYh
         V6baPuomPigc6GllJHR8SBcrJsJayUbJgFKFUTJSIvtzrUi6egvr428yal/Y3mjtHP4e
         Zetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691555545; x=1692160345;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwvZIfkWxNDBAA2VDHz4cV0MGL3i8yqkmn2UYcR8Z9E=;
        b=fr54V2KLYZuJIgz2Z77ehqJ+B1XplueOIQvogVW7Oyx875XdHDl7cCH52Bp4aTkTU7
         Crw1w5vsdQxYRVuJGSjDphFA4cCOajoYQZYXGFN7wLp+OiDdwfuOgDlYLywZGykcUiIV
         +iJ28aCo0EtpaUa1ZquRXhr5jCiQxIfQD1iRjsggJtFJ7WEPWwPyke4O7Bujg94Hg59B
         k1+sH4oEwGZSI1KlabQNNd3bnKQKdGWOJfk6k8CwhAD/WLSLkAxS01BlGcdtW2LK7ZiI
         zUMbGxc9RC3GwIZB4HeiWVZJvTRpQebcy+RnMYBME3XZrapvl6JV72WOfUUNBaa8WRfg
         XQlA==
X-Gm-Message-State: AOJu0YyzOwpNKfqNjt9mGl/F701i/5SQES4SR0OpUSQJDWwZphbImoyi
        1JX6usT3h8jxZeKdB6rEREDW5g==
X-Google-Smtp-Source: AGHT+IFRq2+oQxP1jY8hLbXzDUaZNnkuiKMnohvmGHSRa3VzhKzvm1cl65r3lJF2CoEm8sENiDLztQ==
X-Received: by 2002:a0d:dfd7:0:b0:571:bd3e:73ca with SMTP id i206-20020a0ddfd7000000b00571bd3e73camr1696829ywe.16.1691555544708;
        Tue, 08 Aug 2023 21:32:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u62-20020a818441000000b0057a5302e2fesm3768585ywf.5.2023.08.08.21.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 21:32:24 -0700 (PDT)
Date:   Tue, 8 Aug 2023 21:32:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Christian Brauner <brauner@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH vfs.tmpfs 2/5] tmpfs: track free_ispace instead of
 free_inodes
In-Reply-To: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
Message-ID: <4fe1739-d9e7-8dfd-5bce-12e7339711da@google.com>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for assigning some inode space to extended attributes,
keep track of free_ispace instead of number of free_inodes: as if one
tmpfs inode (and accompanying dentry) occupies very approximately 1KiB.

Unsigned long is large enough for free_ispace, on 64-bit and on 32-bit:
but take care to enforce the maximum.  And fix the nr_blocks maximum on
32-bit: S64_MAX would be too big for it there, so say LONG_MAX instead.

Delete the incorrect limited<->unlimited blocks/inodes comment above
shmem_reconfigure(): leave it to the error messages below to describe.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/shmem.c               | 33 +++++++++++++++++----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9b2d2faff1d0..6b0c626620f5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -54,7 +54,7 @@ struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	struct percpu_counter used_blocks;  /* How many are allocated */
 	unsigned long max_inodes;   /* How many inodes are allowed */
-	unsigned long free_inodes;  /* How many are left for allocation */
+	unsigned long free_ispace;  /* How much ispace left for allocation */
 	raw_spinlock_t stat_lock;   /* Serialize shmem_sb_info changes */
 	umode_t mode;		    /* Mount mode for root directory */
 	unsigned char huge;	    /* Whether to try for hugepages */
diff --git a/mm/shmem.c b/mm/shmem.c
index df3cabf54206..c39471384168 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -90,6 +90,9 @@ static struct vfsmount *shm_mnt;
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
+/* Pretend that one inode + its dentry occupy this much memory */
+#define BOGO_INODE_SIZE 1024
+
 /* Symlink up to this size is kmalloc'ed instead of using a swappable page */
 #define SHORT_SYMLINK_LEN 128
 
@@ -137,7 +140,8 @@ static unsigned long shmem_default_max_inodes(void)
 {
 	unsigned long nr_pages = totalram_pages();
 
-	return min(nr_pages - totalhigh_pages(), nr_pages / 2);
+	return min3(nr_pages - totalhigh_pages(), nr_pages / 2,
+			ULONG_MAX / BOGO_INODE_SIZE);
 }
 #endif
 
@@ -331,11 +335,11 @@ static int shmem_reserve_inode(struct super_block *sb, ino_t *inop)
 	if (!(sb->s_flags & SB_KERNMOUNT)) {
 		raw_spin_lock(&sbinfo->stat_lock);
 		if (sbinfo->max_inodes) {
-			if (!sbinfo->free_inodes) {
+			if (sbinfo->free_ispace < BOGO_INODE_SIZE) {
 				raw_spin_unlock(&sbinfo->stat_lock);
 				return -ENOSPC;
 			}
-			sbinfo->free_inodes--;
+			sbinfo->free_ispace -= BOGO_INODE_SIZE;
 		}
 		if (inop) {
 			ino = sbinfo->next_ino++;
@@ -394,7 +398,7 @@ static void shmem_free_inode(struct super_block *sb)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	if (sbinfo->max_inodes) {
 		raw_spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_inodes++;
+		sbinfo->free_ispace += BOGO_INODE_SIZE;
 		raw_spin_unlock(&sbinfo->stat_lock);
 	}
 }
@@ -3155,7 +3159,7 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 	if (sbinfo->max_inodes) {
 		buf->f_files = sbinfo->max_inodes;
-		buf->f_ffree = sbinfo->free_inodes;
+		buf->f_ffree = sbinfo->free_ispace / BOGO_INODE_SIZE;
 	}
 	/* else leave those fields 0 like simple_statfs */
 
@@ -3815,13 +3819,13 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_nr_blocks:
 		ctx->blocks = memparse(param->string, &rest);
-		if (*rest || ctx->blocks > S64_MAX)
+		if (*rest || ctx->blocks > LONG_MAX)
 			goto bad_value;
 		ctx->seen |= SHMEM_SEEN_BLOCKS;
 		break;
 	case Opt_nr_inodes:
 		ctx->inodes = memparse(param->string, &rest);
-		if (*rest)
+		if (*rest || ctx->inodes > ULONG_MAX / BOGO_INODE_SIZE)
 			goto bad_value;
 		ctx->seen |= SHMEM_SEEN_INODES;
 		break;
@@ -4002,21 +4006,17 @@ static int shmem_parse_options(struct fs_context *fc, void *data)
 
 /*
  * Reconfigure a shmem filesystem.
- *
- * Note that we disallow change from limited->unlimited blocks/inodes while any
- * are in use; but we must separately disallow unlimited->limited, because in
- * that case we have no record of how much is already in use.
  */
 static int shmem_reconfigure(struct fs_context *fc)
 {
 	struct shmem_options *ctx = fc->fs_private;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(fc->root->d_sb);
-	unsigned long inodes;
+	unsigned long used_isp;
 	struct mempolicy *mpol = NULL;
 	const char *err;
 
 	raw_spin_lock(&sbinfo->stat_lock);
-	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
+	used_isp = sbinfo->max_inodes * BOGO_INODE_SIZE - sbinfo->free_ispace;
 
 	if ((ctx->seen & SHMEM_SEEN_BLOCKS) && ctx->blocks) {
 		if (!sbinfo->max_blocks) {
@@ -4034,7 +4034,7 @@ static int shmem_reconfigure(struct fs_context *fc)
 			err = "Cannot retroactively limit inodes";
 			goto out;
 		}
-		if (ctx->inodes < inodes) {
+		if (ctx->inodes * BOGO_INODE_SIZE < used_isp) {
 			err = "Too few inodes for current use";
 			goto out;
 		}
@@ -4080,7 +4080,7 @@ static int shmem_reconfigure(struct fs_context *fc)
 		sbinfo->max_blocks  = ctx->blocks;
 	if (ctx->seen & SHMEM_SEEN_INODES) {
 		sbinfo->max_inodes  = ctx->inodes;
-		sbinfo->free_inodes = ctx->inodes - inodes;
+		sbinfo->free_ispace = ctx->inodes * BOGO_INODE_SIZE - used_isp;
 	}
 
 	/*
@@ -4211,7 +4211,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NOUSER;
 #endif
 	sbinfo->max_blocks = ctx->blocks;
-	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
+	sbinfo->max_inodes = ctx->inodes;
+	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
 	if (sb->s_flags & SB_KERNMOUNT) {
 		sbinfo->ino_batch = alloc_percpu(ino_t);
 		if (!sbinfo->ino_batch)
-- 
2.35.3

