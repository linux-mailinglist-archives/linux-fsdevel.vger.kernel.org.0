Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54F58F709
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 06:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiHKEvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiHKEvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:51:13 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5282D6BD73
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 21:51:12 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id p132so20109249oif.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 21:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc;
        bh=m1OXKNq7+DtNWBynhSNEKrKaVxfMrlkQMnFw/pURbg0=;
        b=sTsT9dad5iemvIuEELMDiMVhOE0RThIC2/6RND1+gIR9BG0Tup4Ja0VLAyqCjMUQj9
         +DIZ3WDS2XbbYkIXwp7ii2YLV3uDoUWuyylR8fUDndlLO/U/j+iWnin0bWNBiMfoaBd5
         0Uu8sjJwP6rnNCfDnWxCUBJwpvqg6C5HSK2OdC48sFSdi7wz7GrnanfoD3gGnqd6pGHl
         wR8UWwPrD199kDC4fOjUbz4QaVYVrhkqLe5PknSYTD24vXiE8nQpAdGEIQbuv0VlKFsa
         OAz64t3JK/91dFMW3ucoHT/pHAtA3qbt94QVwPtopQRwyILKHlnFpUfw31PynvuAT1xU
         hZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=m1OXKNq7+DtNWBynhSNEKrKaVxfMrlkQMnFw/pURbg0=;
        b=wfcvygJbAx1aRTLJXuoxCSwU0keoKqvcm2Ud2PwQz0N0NMn8D+s6zNuZnOfRlA1Nkt
         LJ3YqUQD5wehROiHYI5blMJTvAqgTqztimVN8hp+/csltSenNwZwT77zpquivl/YFPgm
         RVf1knJkfvSE1gf/Nu61oWHZODiryNR3NFDH+By1ZPEEOeT1XWaYF4NiLB7kYpeTZB6r
         3MvSsGSzttOIpqWz1h4MrmAHnzIlt5tU23qV7Yo3C1/riaCj2AKOXX78Eo16dtGk35pw
         LwFvp43wOffwyqOQGfvR+Mu2YTJsMj36d6/GRYD9PtAjanTolsz19haMau8XbiQNsnAA
         ji+Q==
X-Gm-Message-State: ACgBeo1uluSZe5NafQNbVF85PrIy5Vp2RiBvXP6gEj2jryV19EC7IBk2
        M+evhofeQ4dAldFa9DjPNbyhqg==
X-Google-Smtp-Source: AA6agR403qDz149yAHlea6yIhxoqoqCqmWgbvz0Cq6UeiC9cA/hbd16184lAZZZ/C/S+0UxZv8hIkA==
X-Received: by 2002:aca:4182:0:b0:343:9d9:1d18 with SMTP id o124-20020aca4182000000b0034309d91d18mr2680250oia.86.1660193471466;
        Wed, 10 Aug 2022 21:51:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c84-20020acab357000000b003358e034f72sm931014oif.7.2022.08.10.21.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:51:11 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:51:09 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Theodore Ts'o <tytso@mit.edu>, Radoslaw Burny <rburny@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/shmem: fix chattr fsflags support in tmpfs
Message-ID: <2961dcb0-ddf3-b9f0-3268-12a4ff996856@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ext[234] have always allowed unimplemented chattr flags to be set,
but other filesystems have tended to be stricter.  Follow the stricter
approach for tmpfs: I don't want to have to explain why csu attributes
don't actually work, and we won't need to update the chattr(1) manpage;
and it's never wrong to start off strict, relaxing later if persuaded.
Allow only a (append only) i (immutable) A (no atime) and d (no dump).

Although lsattr showed 'A' inherited, the NOATIME behavior was not
being inherited: because nothing sync'ed FS_NOATIME_FL to S_NOATIME.
Add shmem_set_inode_flags() to sync the flags, using inode_set_flags()
to avoid that instant of lost immutablility during fileattr_set().

But that change switched generic/079 from passing to failing: because
FS_IMMUTABLE_FL and FS_APPEND_FL had been unconventionally included in
the INHERITED fsflags: remove them and generic/079 is back to passing.

Fixes: e408e695f5f1 ("mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 include/linux/shmem_fs.h | 13 +++-------
 mm/shmem.c               | 54 +++++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 32 deletions(-)

--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -29,15 +29,10 @@ struct shmem_inode_info {
 	struct inode		vfs_inode;
 };
 
-#define SHMEM_FL_USER_VISIBLE FS_FL_USER_VISIBLE
-#define SHMEM_FL_USER_MODIFIABLE FS_FL_USER_MODIFIABLE
-#define SHMEM_FL_INHERITED FS_FL_USER_MODIFIABLE
-
-/* Flags that are appropriate for regular files (all but dir-specific ones). */
-#define SHMEM_REG_FLMASK (~(FS_DIRSYNC_FL | FS_TOPDIR_FL))
-
-/* Flags that are appropriate for non-directories/regular files. */
-#define SHMEM_OTHER_FLMASK (FS_NODUMP_FL | FS_NOATIME_FL)
+#define SHMEM_FL_USER_VISIBLE		FS_FL_USER_VISIBLE
+#define SHMEM_FL_USER_MODIFIABLE \
+	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
+#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
 
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
diff --git a/mm/shmem.c b/mm/shmem.c
index e975fcd9d2e1..bd9b114a8650 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2281,16 +2281,34 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-/* Mask out flags that are inappropriate for the given type of inode. */
-static unsigned shmem_mask_flags(umode_t mode, __u32 flags)
+#ifdef CONFIG_TMPFS_XATTR
+static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
+
+/*
+ * chattr's fsflags are unrelated to extended attributes,
+ * but tmpfs has chosen to enable them under the same config option.
+ */
+static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
+{
+	unsigned int i_flags = 0;
+
+	if (fsflags & FS_NOATIME_FL)
+		i_flags |= S_NOATIME;
+	if (fsflags & FS_APPEND_FL)
+		i_flags |= S_APPEND;
+	if (fsflags & FS_IMMUTABLE_FL)
+		i_flags |= S_IMMUTABLE;
+	/*
+	 * But FS_NODUMP_FL does not require any action in i_flags.
+	 */
+	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE);
+}
+#else
+static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 {
-	if (S_ISDIR(mode))
-		return flags;
-	else if (S_ISREG(mode))
-		return flags & SHMEM_REG_FLMASK;
-	else
-		return flags & SHMEM_OTHER_FLMASK;
 }
+#define shmem_initxattrs NULL
+#endif
 
 static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 				     umode_t mode, dev_t dev, unsigned long flags)
@@ -2319,7 +2337,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 		info->i_crtime = inode->i_mtime;
 		info->fsflags = (dir == NULL) ? 0 :
 			SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
-		info->fsflags = shmem_mask_flags(mode, info->fsflags);
+		if (info->fsflags)
+			shmem_set_inode_flags(inode, info->fsflags);
 		INIT_LIST_HEAD(&info->shrinklist);
 		INIT_LIST_HEAD(&info->swaplist);
 		simple_xattrs_init(&info->xattrs);
@@ -2468,12 +2487,6 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 static const struct inode_operations shmem_symlink_inode_operations;
 static const struct inode_operations shmem_short_symlink_operations;
 
-#ifdef CONFIG_TMPFS_XATTR
-static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
-#else
-#define shmem_initxattrs NULL
-#endif
-
 static int
 shmem_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
@@ -3179,18 +3192,13 @@ static int shmem_fileattr_set(struct user_namespace *mnt_userns,
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
+	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
+		return -EOPNOTSUPP;
 
 	info->fsflags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
-	inode->i_flags &= ~(S_APPEND | S_IMMUTABLE | S_NOATIME);
-	if (info->fsflags & FS_APPEND_FL)
-		inode->i_flags |= S_APPEND;
-	if (info->fsflags & FS_IMMUTABLE_FL)
-		inode->i_flags |= S_IMMUTABLE;
-	if (info->fsflags & FS_NOATIME_FL)
-		inode->i_flags |= S_NOATIME;
-
+	shmem_set_inode_flags(inode, info->fsflags);
 	inode->i_ctime = current_time(inode);
 	return 0;
 }
