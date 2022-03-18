Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8F4DDFAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiCRRPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiCRRP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:15:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951EE43BD
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 10:14:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s3-20020aa78bc3000000b004fa59ef2a34so2631587pfd.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=khjktHlzowN4ytrgBT5tnlvERq2qJMHYPTSaiHXT/6Y=;
        b=ibFxLwNSYavWXfLITM5cbrq3e/ZgJQ4Mb5r+Cth+53DPTUjNxRUcEedBsAyKVVGKRF
         oJnlKqSZNo040PfgfXFL26JuhIS1D3r7HiBB8Sgdpdm/Il3L27alkd5gJpfrHylcyIx/
         cTZbxyrLcRwpWn4JRWGV7FYtpMuVZTIEwLREmJy/DuRxdJoL9B+lSaVhTp3x0JVQOYVA
         nnEyBhkzg57r4ii1SxFzoN6Th7weC4smOLRIrhev2vgW3uHWw5FDLIGBvyIWHaQW0MCd
         B7iPAS3QERVsgl9HLkxwxRy8X4aF13+SJZ+QgWu2OoAz9trTWzh/ylctx4uYviaALTc7
         Vcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=khjktHlzowN4ytrgBT5tnlvERq2qJMHYPTSaiHXT/6Y=;
        b=bpklR3VFKDISmGMPLlYZEWL0ah3tOL7VVKpF8E3ov1ANKBDOprYtoQbgvLzRt49Qbo
         SoAn6Om42pQGzhY5MUZQ3Cb3hfQqoX5rhaESvCZK2coVXHsgCu+6iT4PMPaQWgFTsoFZ
         ShVQ619lF2frY9ER2KBEA+GGQDmRnaKmDbxThiOlcqlN8XxMlykJFA4QugPUlAr/dHec
         bQtgL4UCfAcQWns08Q+rfwzQsULzXbmKk/IvJwTIJYVk+NzRxKgfe96Suc19K4ZwYmfm
         gpLFWSNpOE6fcKkxyWSHkWJkoeo+/1j17lWSYo/v6mElW+ParVNBJJwwR3cu3f88jIml
         2RTQ==
X-Gm-Message-State: AOAM533zWt1XarWwoSrpKGVOmNMeqFvbIidcdYZnfZ4omAqihuv5khEn
        En3RgULEYAzl8ku3kGsrdD+88TSYiTysgA==
X-Google-Smtp-Source: ABdhPJxJTofTb2ZtXSTPUF4FdRfDb9AnmMw0M+eT+8zMrrpvtqvyJ5K1zYM2UGLwDQOsBYEIBzGLVq+fAyEyTA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:240e:b0:1b9:2963:d5a1 with SMTP
 id nr14-20020a17090b240e00b001b92963d5a1mr22732726pjb.227.1647623649019; Fri,
 18 Mar 2022 10:14:09 -0700 (PDT)
Date:   Fri, 18 Mar 2022 17:14:05 +0000
Message-Id: <20220318171405.2728855-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] fuse: fix integer type usage in uapi header
From:   Carlos Llamas <cmllamas@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alessio Balsini <balsini@android.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel uapi headers are supposed to use __[us]{8,16,32,64} defined by
<linux/types.h> instead of 'uint32_t' and similar. This patch changes
all the definitions in this header to use the correct type. Previous
discussion of this topic can be found here:

  https://lkml.org/lkml/2019/6/5/18

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 include/uapi/linux/fuse.h | 509 +++++++++++++++++++-------------------
 1 file changed, 253 insertions(+), 256 deletions(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..c6dc477306c1 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -199,11 +199,7 @@
 #ifndef _LINUX_FUSE_H
 #define _LINUX_FUSE_H
 
-#ifdef __KERNEL__
 #include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
 
 /*
  * Version negotiation:
@@ -238,42 +234,42 @@
    userspace works under 64bit kernels */
 
 struct fuse_attr {
-	uint64_t	ino;
-	uint64_t	size;
-	uint64_t	blocks;
-	uint64_t	atime;
-	uint64_t	mtime;
-	uint64_t	ctime;
-	uint32_t	atimensec;
-	uint32_t	mtimensec;
-	uint32_t	ctimensec;
-	uint32_t	mode;
-	uint32_t	nlink;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	rdev;
-	uint32_t	blksize;
-	uint32_t	flags;
+	__u64	ino;
+	__u64	size;
+	__u64	blocks;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+	__u32	atimensec;
+	__u32	mtimensec;
+	__u32	ctimensec;
+	__u32	mode;
+	__u32	nlink;
+	__u32	uid;
+	__u32	gid;
+	__u32	rdev;
+	__u32	blksize;
+	__u32	flags;
 };
 
 struct fuse_kstatfs {
-	uint64_t	blocks;
-	uint64_t	bfree;
-	uint64_t	bavail;
-	uint64_t	files;
-	uint64_t	ffree;
-	uint32_t	bsize;
-	uint32_t	namelen;
-	uint32_t	frsize;
-	uint32_t	padding;
-	uint32_t	spare[6];
+	__u64	blocks;
+	__u64	bfree;
+	__u64	bavail;
+	__u64	files;
+	__u64	ffree;
+	__u32	bsize;
+	__u32	namelen;
+	__u32	frsize;
+	__u32	padding;
+	__u32	spare[6];
 };
 
 struct fuse_file_lock {
-	uint64_t	start;
-	uint64_t	end;
-	uint32_t	type;
-	uint32_t	pid; /* tgid */
+	__u64	start;
+	__u64	end;
+	__u32	type;
+	__u32	pid; /* tgid */
 };
 
 /**
@@ -562,149 +558,150 @@ enum fuse_notify_code {
 #define FUSE_COMPAT_ENTRY_OUT_SIZE 120
 
 struct fuse_entry_out {
-	uint64_t	nodeid;		/* Inode ID */
-	uint64_t	generation;	/* Inode generation: nodeid:gen must
-					   be unique for the fs's lifetime */
-	uint64_t	entry_valid;	/* Cache timeout for the name */
-	uint64_t	attr_valid;	/* Cache timeout for the attributes */
-	uint32_t	entry_valid_nsec;
-	uint32_t	attr_valid_nsec;
+	__u64	nodeid;		/* Inode ID */
+	__u64	generation;	/* Inode generation: nodeid:gen must
+				 * be unique for the fs's lifetime
+				 */
+	__u64	entry_valid;	/* Cache timeout for the name */
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	entry_valid_nsec;
+	__u32	attr_valid_nsec;
 	struct fuse_attr attr;
 };
 
 struct fuse_forget_in {
-	uint64_t	nlookup;
+	__u64	nlookup;
 };
 
 struct fuse_forget_one {
-	uint64_t	nodeid;
-	uint64_t	nlookup;
+	__u64	nodeid;
+	__u64	nlookup;
 };
 
 struct fuse_batch_forget_in {
-	uint32_t	count;
-	uint32_t	dummy;
+	__u32	count;
+	__u32	dummy;
 };
 
 struct fuse_getattr_in {
-	uint32_t	getattr_flags;
-	uint32_t	dummy;
-	uint64_t	fh;
+	__u32	getattr_flags;
+	__u32	dummy;
+	__u64	fh;
 };
 
 #define FUSE_COMPAT_ATTR_OUT_SIZE 96
 
 struct fuse_attr_out {
-	uint64_t	attr_valid;	/* Cache timeout for the attributes */
-	uint32_t	attr_valid_nsec;
-	uint32_t	dummy;
+	__u64	attr_valid;	/* Cache timeout for the attributes */
+	__u32	attr_valid_nsec;
+	__u32	dummy;
 	struct fuse_attr attr;
 };
 
 #define FUSE_COMPAT_MKNOD_IN_SIZE 8
 
 struct fuse_mknod_in {
-	uint32_t	mode;
-	uint32_t	rdev;
-	uint32_t	umask;
-	uint32_t	padding;
+	__u32	mode;
+	__u32	rdev;
+	__u32	umask;
+	__u32	padding;
 };
 
 struct fuse_mkdir_in {
-	uint32_t	mode;
-	uint32_t	umask;
+	__u32	mode;
+	__u32	umask;
 };
 
 struct fuse_rename_in {
-	uint64_t	newdir;
+	__u64	newdir;
 };
 
 struct fuse_rename2_in {
-	uint64_t	newdir;
-	uint32_t	flags;
-	uint32_t	padding;
+	__u64	newdir;
+	__u32	flags;
+	__u32	padding;
 };
 
 struct fuse_link_in {
-	uint64_t	oldnodeid;
+	__u64	oldnodeid;
 };
 
 struct fuse_setattr_in {
-	uint32_t	valid;
-	uint32_t	padding;
-	uint64_t	fh;
-	uint64_t	size;
-	uint64_t	lock_owner;
-	uint64_t	atime;
-	uint64_t	mtime;
-	uint64_t	ctime;
-	uint32_t	atimensec;
-	uint32_t	mtimensec;
-	uint32_t	ctimensec;
-	uint32_t	mode;
-	uint32_t	unused4;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	unused5;
+	__u32	valid;
+	__u32	padding;
+	__u64	fh;
+	__u64	size;
+	__u64	lock_owner;
+	__u64	atime;
+	__u64	mtime;
+	__u64	ctime;
+	__u32	atimensec;
+	__u32	mtimensec;
+	__u32	ctimensec;
+	__u32	mode;
+	__u32	unused4;
+	__u32	uid;
+	__u32	gid;
+	__u32	unused5;
 };
 
 struct fuse_open_in {
-	uint32_t	flags;
-	uint32_t	open_flags;	/* FUSE_OPEN_... */
+	__u32	flags;
+	__u32	open_flags;	/* FUSE_OPEN_... */
 };
 
 struct fuse_create_in {
-	uint32_t	flags;
-	uint32_t	mode;
-	uint32_t	umask;
-	uint32_t	open_flags;	/* FUSE_OPEN_... */
+	__u32	flags;
+	__u32	mode;
+	__u32	umask;
+	__u32	open_flags;	/* FUSE_OPEN_... */
 };
 
 struct fuse_open_out {
-	uint64_t	fh;
-	uint32_t	open_flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u32	open_flags;
+	__u32	padding;
 };
 
 struct fuse_release_in {
-	uint64_t	fh;
-	uint32_t	flags;
-	uint32_t	release_flags;
-	uint64_t	lock_owner;
+	__u64	fh;
+	__u32	flags;
+	__u32	release_flags;
+	__u64	lock_owner;
 };
 
 struct fuse_flush_in {
-	uint64_t	fh;
-	uint32_t	unused;
-	uint32_t	padding;
-	uint64_t	lock_owner;
+	__u64	fh;
+	__u32	unused;
+	__u32	padding;
+	__u64	lock_owner;
 };
 
 struct fuse_read_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	read_flags;
-	uint64_t	lock_owner;
-	uint32_t	flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u32	size;
+	__u32	read_flags;
+	__u64	lock_owner;
+	__u32	flags;
+	__u32	padding;
 };
 
 #define FUSE_COMPAT_WRITE_IN_SIZE 24
 
 struct fuse_write_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	write_flags;
-	uint64_t	lock_owner;
-	uint32_t	flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u32	size;
+	__u32	write_flags;
+	__u64	lock_owner;
+	__u32	flags;
+	__u32	padding;
 };
 
 struct fuse_write_out {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 #define FUSE_COMPAT_STATFS_SIZE 48
@@ -714,36 +711,36 @@ struct fuse_statfs_out {
 };
 
 struct fuse_fsync_in {
-	uint64_t	fh;
-	uint32_t	fsync_flags;
-	uint32_t	padding;
+	__u64	fh;
+	__u32	fsync_flags;
+	__u32	padding;
 };
 
 #define FUSE_COMPAT_SETXATTR_IN_SIZE 8
 
 struct fuse_setxattr_in {
-	uint32_t	size;
-	uint32_t	flags;
-	uint32_t	setxattr_flags;
-	uint32_t	padding;
+	__u32	size;
+	__u32	flags;
+	__u32	setxattr_flags;
+	__u32	padding;
 };
 
 struct fuse_getxattr_in {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_getxattr_out {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_lk_in {
-	uint64_t	fh;
-	uint64_t	owner;
+	__u64	fh;
+	__u64	owner;
 	struct fuse_file_lock lk;
-	uint32_t	lk_flags;
-	uint32_t	padding;
+	__u32	lk_flags;
+	__u32	padding;
 };
 
 struct fuse_lk_out {
@@ -751,145 +748,145 @@ struct fuse_lk_out {
 };
 
 struct fuse_access_in {
-	uint32_t	mask;
-	uint32_t	padding;
+	__u32	mask;
+	__u32	padding;
 };
 
 struct fuse_init_in {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	max_readahead;
-	uint32_t	flags;
-	uint32_t	flags2;
-	uint32_t	unused[11];
+	__u32	major;
+	__u32	minor;
+	__u32	max_readahead;
+	__u32	flags;
+	__u32	flags2;
+	__u32	unused[11];
 };
 
 #define FUSE_COMPAT_INIT_OUT_SIZE 8
 #define FUSE_COMPAT_22_INIT_OUT_SIZE 24
 
 struct fuse_init_out {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	max_readahead;
-	uint32_t	flags;
-	uint16_t	max_background;
-	uint16_t	congestion_threshold;
-	uint32_t	max_write;
-	uint32_t	time_gran;
-	uint16_t	max_pages;
-	uint16_t	map_alignment;
-	uint32_t	flags2;
-	uint32_t	unused[7];
+	__u32	major;
+	__u32	minor;
+	__u32	max_readahead;
+	__u32	flags;
+	__u16	max_background;
+	__u16	congestion_threshold;
+	__u32	max_write;
+	__u32	time_gran;
+	__u16	max_pages;
+	__u16	map_alignment;
+	__u32	flags2;
+	__u32	unused[7];
 };
 
 #define CUSE_INIT_INFO_MAX 4096
 
 struct cuse_init_in {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	unused;
-	uint32_t	flags;
+	__u32	major;
+	__u32	minor;
+	__u32	unused;
+	__u32	flags;
 };
 
 struct cuse_init_out {
-	uint32_t	major;
-	uint32_t	minor;
-	uint32_t	unused;
-	uint32_t	flags;
-	uint32_t	max_read;
-	uint32_t	max_write;
-	uint32_t	dev_major;		/* chardev major */
-	uint32_t	dev_minor;		/* chardev minor */
-	uint32_t	spare[10];
+	__u32	major;
+	__u32	minor;
+	__u32	unused;
+	__u32	flags;
+	__u32	max_read;
+	__u32	max_write;
+	__u32	dev_major;		/* chardev major */
+	__u32	dev_minor;		/* chardev minor */
+	__u32	spare[10];
 };
 
 struct fuse_interrupt_in {
-	uint64_t	unique;
+	__u64	unique;
 };
 
 struct fuse_bmap_in {
-	uint64_t	block;
-	uint32_t	blocksize;
-	uint32_t	padding;
+	__u64	block;
+	__u32	blocksize;
+	__u32	padding;
 };
 
 struct fuse_bmap_out {
-	uint64_t	block;
+	__u64	block;
 };
 
 struct fuse_ioctl_in {
-	uint64_t	fh;
-	uint32_t	flags;
-	uint32_t	cmd;
-	uint64_t	arg;
-	uint32_t	in_size;
-	uint32_t	out_size;
+	__u64	fh;
+	__u32	flags;
+	__u32	cmd;
+	__u64	arg;
+	__u32	in_size;
+	__u32	out_size;
 };
 
 struct fuse_ioctl_iovec {
-	uint64_t	base;
-	uint64_t	len;
+	__u64	base;
+	__u64	len;
 };
 
 struct fuse_ioctl_out {
-	int32_t		result;
-	uint32_t	flags;
-	uint32_t	in_iovs;
-	uint32_t	out_iovs;
+	__s32	result;
+	__u32	flags;
+	__u32	in_iovs;
+	__u32	out_iovs;
 };
 
 struct fuse_poll_in {
-	uint64_t	fh;
-	uint64_t	kh;
-	uint32_t	flags;
-	uint32_t	events;
+	__u64	fh;
+	__u64	kh;
+	__u32	flags;
+	__u32	events;
 };
 
 struct fuse_poll_out {
-	uint32_t	revents;
-	uint32_t	padding;
+	__u32	revents;
+	__u32	padding;
 };
 
 struct fuse_notify_poll_wakeup_out {
-	uint64_t	kh;
+	__u64	kh;
 };
 
 struct fuse_fallocate_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint64_t	length;
-	uint32_t	mode;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u64	length;
+	__u32	mode;
+	__u32	padding;
 };
 
 struct fuse_in_header {
-	uint32_t	len;
-	uint32_t	opcode;
-	uint64_t	unique;
-	uint64_t	nodeid;
-	uint32_t	uid;
-	uint32_t	gid;
-	uint32_t	pid;
-	uint32_t	padding;
+	__u32	len;
+	__u32	opcode;
+	__u64	unique;
+	__u64	nodeid;
+	__u32	uid;
+	__u32	gid;
+	__u32	pid;
+	__u32	padding;
 };
 
 struct fuse_out_header {
-	uint32_t	len;
-	int32_t		error;
-	uint64_t	unique;
+	__u32	len;
+	__s32		error;
+	__u64	unique;
 };
 
 struct fuse_dirent {
-	uint64_t	ino;
-	uint64_t	off;
-	uint32_t	namelen;
-	uint32_t	type;
+	__u64	ino;
+	__u64	off;
+	__u32	namelen;
+	__u32	type;
 	char name[];
 };
 
 /* Align variable length records to 64bit boundary */
 #define FUSE_REC_ALIGN(x) \
-	(((x) + sizeof(uint64_t) - 1) & ~(sizeof(uint64_t) - 1))
+	(((x) + sizeof(__u64) - 1) & ~(sizeof(__u64) - 1))
 
 #define FUSE_NAME_OFFSET offsetof(struct fuse_dirent, name)
 #define FUSE_DIRENT_ALIGN(x) FUSE_REC_ALIGN(x)
@@ -907,106 +904,106 @@ struct fuse_direntplus {
 	FUSE_DIRENT_ALIGN(FUSE_NAME_OFFSET_DIRENTPLUS + (d)->dirent.namelen)
 
 struct fuse_notify_inval_inode_out {
-	uint64_t	ino;
-	int64_t		off;
-	int64_t		len;
+	__u64	ino;
+	__s64	off;
+	__s64	len;
 };
 
 struct fuse_notify_inval_entry_out {
-	uint64_t	parent;
-	uint32_t	namelen;
-	uint32_t	padding;
+	__u64	parent;
+	__u32	namelen;
+	__u32	padding;
 };
 
 struct fuse_notify_delete_out {
-	uint64_t	parent;
-	uint64_t	child;
-	uint32_t	namelen;
-	uint32_t	padding;
+	__u64	parent;
+	__u64	child;
+	__u32	namelen;
+	__u32	padding;
 };
 
 struct fuse_notify_store_out {
-	uint64_t	nodeid;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	padding;
+	__u64	nodeid;
+	__u64	offset;
+	__u32	size;
+	__u32	padding;
 };
 
 struct fuse_notify_retrieve_out {
-	uint64_t	notify_unique;
-	uint64_t	nodeid;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	padding;
+	__u64	notify_unique;
+	__u64	nodeid;
+	__u64	offset;
+	__u32	size;
+	__u32	padding;
 };
 
 /* Matches the size of fuse_write_in */
 struct fuse_notify_retrieve_in {
-	uint64_t	dummy1;
-	uint64_t	offset;
-	uint32_t	size;
-	uint32_t	dummy2;
-	uint64_t	dummy3;
-	uint64_t	dummy4;
+	__u64	dummy1;
+	__u64	offset;
+	__u32	size;
+	__u32	dummy2;
+	__u64	dummy3;
+	__u64	dummy4;
 };
 
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
-#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, __u32)
 
 struct fuse_lseek_in {
-	uint64_t	fh;
-	uint64_t	offset;
-	uint32_t	whence;
-	uint32_t	padding;
+	__u64	fh;
+	__u64	offset;
+	__u32	whence;
+	__u32	padding;
 };
 
 struct fuse_lseek_out {
-	uint64_t	offset;
+	__u64	offset;
 };
 
 struct fuse_copy_file_range_in {
-	uint64_t	fh_in;
-	uint64_t	off_in;
-	uint64_t	nodeid_out;
-	uint64_t	fh_out;
-	uint64_t	off_out;
-	uint64_t	len;
-	uint64_t	flags;
+	__u64	fh_in;
+	__u64	off_in;
+	__u64	nodeid_out;
+	__u64	fh_out;
+	__u64	off_out;
+	__u64	len;
+	__u64	flags;
 };
 
 #define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
 #define FUSE_SETUPMAPPING_FLAG_READ (1ull << 1)
 struct fuse_setupmapping_in {
 	/* An already open handle */
-	uint64_t	fh;
+	__u64	fh;
 	/* Offset into the file to start the mapping */
-	uint64_t	foffset;
+	__u64	foffset;
 	/* Length of mapping required */
-	uint64_t	len;
+	__u64	len;
 	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
-	uint64_t	flags;
+	__u64	flags;
 	/* Offset in Memory Window */
-	uint64_t	moffset;
+	__u64	moffset;
 };
 
 struct fuse_removemapping_in {
 	/* number of fuse_removemapping_one follows */
-	uint32_t        count;
+	__u32	count;
 };
 
 struct fuse_removemapping_one {
 	/* Offset into the dax window start the unmapping */
-	uint64_t        moffset;
+	__u64	moffset;
 	/* Length of mapping required */
-	uint64_t	len;
+	__u64	len;
 };
 
 #define FUSE_REMOVEMAPPING_MAX_ENTRY   \
 		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
 
 struct fuse_syncfs_in {
-	uint64_t	padding;
+	__u64	padding;
 };
 
 /*
@@ -1016,8 +1013,8 @@ struct fuse_syncfs_in {
  * fuse_secctx, name, context
  */
 struct fuse_secctx {
-	uint32_t	size;
-	uint32_t	padding;
+	__u32	size;
+	__u32	padding;
 };
 
 /*
@@ -1027,8 +1024,8 @@ struct fuse_secctx {
  *
  */
 struct fuse_secctx_header {
-	uint32_t	size;
-	uint32_t	nr_secctx;
+	__u32	size;
+	__u32	nr_secctx;
 };
 
 #endif /* _LINUX_FUSE_H */
-- 
2.35.1.894.gb6a874cedc-goog

