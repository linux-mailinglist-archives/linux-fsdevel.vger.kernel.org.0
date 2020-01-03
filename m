Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8472012FBA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgACRai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:30:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgACRai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:30:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so9253498wmf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2020 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jISoPkmGWWrMVg31zCVz3felJe4xdVet0qwlBEKmcM8=;
        b=sN/RjX5sQt4NKyAY5+IWjqlpAGwa9lr+6He2CF+30bAoawMFWONxL2r/wszDopavi9
         kKcqpAOPke2YjM+R2l5Ab7kFStwn5uXQOmVqrWa6w788PchSK0i7xVJGgxCRigptxlvx
         beVF2vWHzQiY8M4GDL7B6huCWeJChMPMLhjWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jISoPkmGWWrMVg31zCVz3felJe4xdVet0qwlBEKmcM8=;
        b=jn9kZq5RIBTfjFgnfH1xc1PSK0iZsRn/Ahus+17cDGuWzq/OMn/6A+t10veXtQGHPM
         5VAdXqIBiKvmU7vyWliVs2OLlXqR6Qsqvtr2idk879ASxgJfLIedNHUQlvw/DzMkpD+v
         Ka0ZMHsG/JGLCr8xfIC+orFn5LjfdpyYR0YfdhjI9+tMYh+OIyALJhB+tFV1rT2IhmZZ
         tl4vqX/bLh4qjksdfaPSvPnO+A65Lw1uuML7XM72XXBBUmiocOjRtqFRwuQdUQC6cczF
         IODj9yBkkc9/24kHwsS2z0yhqTzcUbfQn16TueqZ2/7oXOOxpCzYNH3PEb0e+QBTdz2k
         qGEw==
X-Gm-Message-State: APjAAAVNFPOWNRA2OuNMTpIP1amLHOx0ypG39E3CDXZZgzCJrxew3r4p
        965xwMLDGpDowXAYGouEm0YyuGw4d3bYBg==
X-Google-Smtp-Source: APXvYqy/3cFjBPGSu0XFhxHUUL5fvQvXDK7YwG6L+bS/Pw1HVqS4aD2aiY7XfQhIsmFX5I0jAqp5fQ==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr19191993wml.156.1578072635282;
        Fri, 03 Jan 2020 09:30:35 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:5238])
        by smtp.gmail.com with ESMTPSA id t8sm59264637wrp.69.2020.01.03.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 09:30:34 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:30:34 +0000
From:   Chris Down <chris@chrisdown.name>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <8b9002a73c33f19af09479fb350686a1b42b7d5b.1578072481.git.chris@chrisdown.name>
References: <cover.1578072481.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578072481.git.chris@chrisdown.name>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The default is still set to inode32 for backwards compatibility, but
system administrators can opt in to the new 64-bit inode numbers by
either:

1. Passing inode64 on the command line when mounting, or
2. Configuring the kernel with CONFIG_TMPFS_INODE64=y

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 Documentation/filesystems/tmpfs.txt | 11 +++++
 fs/Kconfig                          | 15 +++++++
 include/linux/shmem_fs.h            |  1 +
 mm/shmem.c                          | 66 ++++++++++++++++++++++++++++-
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/tmpfs.txt b/Documentation/filesystems/tmpfs.txt
index 5ecbc03e6b2f..203e12a684c9 100644
--- a/Documentation/filesystems/tmpfs.txt
+++ b/Documentation/filesystems/tmpfs.txt
@@ -136,6 +136,15 @@ These options do not have any effect on remount. You can change these
 parameters with chmod(1), chown(1) and chgrp(1) on a mounted filesystem.
 
 
+tmpfs has a mount option to select whether it will wrap at 32- or 64-bit inode
+numbers:
+
+inode64   Use 64-bit inode numbers
+inode32   Use 32-bit inode numbers
+
+On 64-bit, the default is set by CONFIG_TMPFS_INODE64. On 32-bit, inode64 is
+not legal and will produce an error at mount time.
+
 So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
 will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
@@ -147,3 +156,5 @@ Updated:
    Hugh Dickins, 4 June 2007
 Updated:
    KOSAKI Motohiro, 16 Mar 2010
+Updated:
+   Chris Down, 2 Jan 2020
diff --git a/fs/Kconfig b/fs/Kconfig
index 7b623e9fc1b0..e74f127df22a 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -199,6 +199,21 @@ config TMPFS_XATTR
 
 	  If unsure, say N.
 
+config TMPFS_INODE64
+	bool "Use 64-bit ino_t by default in tmpfs"
+	depends on TMPFS && 64BIT
+	default n
+	help
+	  tmpfs has historically used only inode numbers as wide as an unsigned
+	  int. In some cases this can cause wraparound, potentially resulting in
+	  multiple files with the same inode number on a single device. This option
+	  makes tmpfs use the full width of ino_t by default, similarly to the
+	  inode64 mount option.
+
+	  To override this default, use the inode32 or inode64 mount options.
+
+	  If unsure, say N.
+
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 7fac91f490dc..8925eb774518 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -35,6 +35,7 @@ struct shmem_sb_info {
 	unsigned char huge;	    /* Whether to try for hugepages */
 	kuid_t uid;		    /* Mount uid for root directory */
 	kgid_t gid;		    /* Mount gid for root directory */
+	bool full_inums;	    /* If i_ino should be uint or ino_t */
 	ino_t next_ino;		    /* The next per-sb inode number to use */
 	struct mempolicy *mpol;     /* default memory policy for mappings */
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
diff --git a/mm/shmem.c b/mm/shmem.c
index 638b1e30625f..a6b43593e852 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -115,11 +115,13 @@ struct shmem_options {
 	kuid_t uid;
 	kgid_t gid;
 	umode_t mode;
+	bool full_inums;
 	int huge;
 	int seen;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
+#define SHMEM_SEEN_INUMS 8
 };
 
 #ifdef CONFIG_TMPFS
@@ -2264,15 +2266,24 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 			 * since max_inodes is always 0, and is called from
 			 * potentially unknown contexts. As such, use the global
 			 * allocator which doesn't require the per-sb stat_lock.
+			 *
+			 * No special behaviour is needed for
+			 * sbinfo->full_inums, because it's not possible to
+			 * manually set on callers of this type, and
+			 * CONFIG_TMPFS_INODE64 only applies to user-visible
+			 * mounts.
 			 */
 			inode->i_ino = get_next_ino();
 		} else {
 			spin_lock(&sbinfo->stat_lock);
-			if (unlikely(sbinfo->next_ino > UINT_MAX)) {
+			if (unlikely(!sbinfo->full_inums &&
+				     sbinfo->next_ino > UINT_MAX)) {
 				/*
 				 * Emulate get_next_ino uint wraparound for
 				 * compatibility
 				 */
+				pr_warn("%s: inode number overflow on device %d, consider using inode64 mount option\n",
+					__func__, MINOR(sb->s_dev));
 				sbinfo->next_ino = 1;
 			}
 			inode->i_ino = sbinfo->next_ino++;
@@ -3409,6 +3420,8 @@ enum shmem_param {
 	Opt_nr_inodes,
 	Opt_size,
 	Opt_uid,
+	Opt_inode32,
+	Opt_inode64,
 };
 
 static const struct fs_parameter_spec shmem_param_specs[] = {
@@ -3420,6 +3433,8 @@ static const struct fs_parameter_spec shmem_param_specs[] = {
 	fsparam_string("nr_inodes",	Opt_nr_inodes),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_flag  ("inode32",	Opt_inode32),
+	fsparam_flag  ("inode64",	Opt_inode64),
 	{}
 };
 
@@ -3444,6 +3459,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	unsigned long long size;
 	char *rest;
 	int opt;
+	const char *err;
 
 	opt = fs_parse(fc, &shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3505,6 +3521,18 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 			break;
 		}
 		goto unsupported_parameter;
+	case Opt_inode32:
+		ctx->full_inums = false;
+		ctx->seen |= SHMEM_SEEN_INUMS;
+		break;
+	case Opt_inode64:
+		if (sizeof(ino_t) < 8) {
+			err = "Cannot use inode64 with <64bit inums in kernel";
+			goto err_msg;
+		}
+		ctx->full_inums = true;
+		ctx->seen |= SHMEM_SEEN_INUMS;
+		break;
 	}
 	return 0;
 
@@ -3512,6 +3540,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	return invalf(fc, "tmpfs: Unsupported parameter '%s'", param->key);
 bad_value:
 	return invalf(fc, "tmpfs: Bad value for '%s'", param->key);
+err_msg:
+	return invalf(fc, "tmpfs: %s", err);
 }
 
 static int shmem_parse_options(struct fs_context *fc, void *data)
@@ -3596,8 +3626,16 @@ static int shmem_reconfigure(struct fs_context *fc)
 		}
 	}
 
+	if ((ctx->seen & SHMEM_SEEN_INUMS) && !ctx->full_inums &&
+	    sbinfo->next_ino > UINT_MAX) {
+		err = "Current inum too high to switch to 32-bit inums";
+		goto out;
+	}
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
+	if (ctx->seen & SHMEM_SEEN_INUMS)
+		sbinfo->full_inums = ctx->full_inums;
 	if (ctx->seen & SHMEM_SEEN_BLOCKS)
 		sbinfo->max_blocks  = ctx->blocks;
 	if (ctx->seen & SHMEM_SEEN_INODES) {
@@ -3637,6 +3675,29 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
 		seq_printf(seq, ",gid=%u",
 				from_kgid_munged(&init_user_ns, sbinfo->gid));
+
+	/*
+	 * Showing inode{64,32} might be useful even if it's the system default,
+	 * since then people don't have to resort to checking both here and
+	 * /proc/config.gz to confirm 64-bit inums were successfully applied
+	 * (which may not even exist if IKCONFIG_PROC isn't enabled).
+	 *
+	 * We hide it when inode64 isn't the default and we are using 32-bit
+	 * inodes, since that probably just means the feature isn't even under
+	 * consideration.
+	 *
+	 * As such:
+	 *
+	 *                     +-----------------+-----------------+
+	 *                     | TMPFS_INODE64=y | TMPFS_INODE64=n |
+	 *  +------------------+-----------------+-----------------+
+	 *  | full_inums=true  | show            | show            |
+	 *  | full_inums=false | show            | hide            |
+	 *  +------------------+-----------------+-----------------+
+	 *
+	 */
+	if (IS_ENABLED(CONFIG_TMPFS_INODE64) || sbinfo->full_inums)
+		seq_printf(seq, ",inode%d", (sbinfo->full_inums ? 64 : 32));
 #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
 	/* Rightly or wrongly, show huge mount option unmasked by shmem_huge */
 	if (sbinfo->huge)
@@ -3684,6 +3745,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 			ctx->blocks = shmem_default_max_blocks();
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
 			ctx->inodes = shmem_default_max_inodes();
+		if (!(ctx->seen & SHMEM_SEEN_INUMS))
+			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
 	} else {
 		sb->s_flags |= SB_NOUSER;
 	}
@@ -3697,6 +3760,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->free_inodes = sbinfo->max_inodes = ctx->inodes;
 	sbinfo->uid = ctx->uid;
 	sbinfo->gid = ctx->gid;
+	sbinfo->full_inums = ctx->full_inums;
 	sbinfo->mode = ctx->mode;
 	sbinfo->huge = ctx->huge;
 	sbinfo->mpol = ctx->mpol;
-- 
2.24.1

