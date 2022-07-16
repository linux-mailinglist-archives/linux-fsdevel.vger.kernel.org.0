Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59C457700C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 18:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiGPQMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGPQMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 316B61C909
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657987962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sp1lR91V1OP6vCbJqjLa6q9rKvWsS0LZjIGKq5X9t6U=;
        b=G2dvHZmKnsHnC0cYjSbfDtDxVp++7qMoq2is4s1wbhFTduZFv2onH8ETislMhf1EIL1+yZ
        o5DSUuqWzAkryZ0cf5rw4L7eUGQ7JgHAIf81eXT2vcKjo8ioqQ7NUVLWXehaPlib+Weno7
        +Ph3nu27CWE/WdmM/EwOiHV+5tw8/MI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-FMGsNRLFNIuV5xwHwb1yfQ-1; Sat, 16 Jul 2022 12:12:41 -0400
X-MC-Unique: FMGsNRLFNIuV5xwHwb1yfQ-1
Received: by mail-qk1-f197.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso4903984qkp.21
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jul 2022 09:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sp1lR91V1OP6vCbJqjLa6q9rKvWsS0LZjIGKq5X9t6U=;
        b=4aCbwZrGHiZ1g9IYmDKdCgk5+hwenbWLTYlHzACysBiS4ABdm0ZR8KN6E1BKBdyhxt
         8wUJYB5jlGJcDuqrh3uDgwdmHDtUJhx7YObPw7xLYIN2eUkHt6B7dCthbAn7/Qol2922
         GLYwJgAW4TNXIClKIovO+jGsPvExMqoPND9JP0jVZ/LkLJEZTCQgcx7uR0Qs8KfSEGZt
         5FefRMaICcalYjwkh6JFqo/LPg/A3dgin8hjZUdmZUD8ZxJbPJPfP7OzgeKDSEZtiUJX
         js7UHsztl5imSxOdCNxr0shOS6Pvu7IMblOv38YBBbOTxoLhSCkZR7Ys5SFKUt0eJ1Se
         Ts6g==
X-Gm-Message-State: AJIora80Gq7fnh1ej3wZNVikbiXyPepaEZXH3uH+0JVOXBSofQloYkTy
        U+ibGr9ZdUUyBPFLE1qbRxzW8yiIA+1dyAJ5tBrQHwIFLFTSEYSqBXv5FuHlqsqAdiyDApwoI9b
        6UViOishVQhZPxueZSL+2o/6A+g==
X-Received: by 2002:a05:6214:5019:b0:46b:3c50:78ba with SMTP id jo25-20020a056214501900b0046b3c5078bamr15692400qvb.127.1657987960217;
        Sat, 16 Jul 2022 09:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfNs08nUvCoTNWcI2L+A3p6IYzpBZxrHEaiHP06FN8cRDCavwr7QPQffHrxA7W4U2pHVFkOA==
X-Received: by 2002:a05:6214:5019:b0:46b:3c50:78ba with SMTP id jo25-20020a056214501900b0046b3c5078bamr15692372qvb.127.1657987959689;
        Sat, 16 Jul 2022 09:12:39 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r20-20020a05620a299400b006b1a343c2absm6720557qkp.131.2022.07.16.09.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 09:12:39 -0700 (PDT)
Date:   Sun, 17 Jul 2022 00:12:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] vfs: Add new setgid_create_umask test
Message-ID: <20220716161233.wfenjymcivr2rhs2@zlang-mailbox>
References: <1653062664-2125-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653062664-2125-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 21, 2022 at 12:04:23AM +0800, Yang Xu wrote:
> The current_umask() is stripped from the mode directly in the vfs if the
> filesystem either doesn't support acls or the filesystem has been
> mounted without posic acl support.
> 
> If the filesystem does support acls then current_umask() stripping is
> deferred to posix_acl_create(). So when the filesystem calls
> posix_acl_create() and there are no acls set or not supported then
> current_umask() will be stripped.
> 
> This patch is also designed to test kernel patchset behaviour
> "move S_ISGID stripping into the vfs"
> https://patchwork.kernel.org/project/linux-fsdevel/list/?series=635692
> 
> Here we only use umask(S_IXGRP) to check whether inode strip
> S_ISGID works correctly and check whether S_IXGRP mode exists.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

This patchset has been stuck at here more than one month. As VFS guys gave it
many review points last time [1]. So cc vfs list to make sure if they have
more concern.

Thanks,
Zorro

[1]
https://lore.kernel.org/fstests/1649763226-2329-4-git-send-email-xuyang2018.jy@fujitsu.com/

>  src/vfs/idmapped-mounts.c | 429 ++++++++++++++++++++++++++++++++++++++
>  src/vfs/idmapped-mounts.h |   1 +
>  src/vfs/utils.c           |  14 ++
>  src/vfs/utils.h           |   1 +
>  src/vfs/vfstest.c         | 205 +++++++++++++++++-
>  tests/generic/691         |  40 ++++
>  tests/generic/691.out     |   2 +
>  7 files changed, 691 insertions(+), 1 deletion(-)
>  create mode 100755 tests/generic/691
>  create mode 100644 tests/generic/691.out
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index 63297d5f..72de52cc 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -7664,6 +7664,425 @@ out:
>  	return fret;
>  }
>  
> +static int setgid_create_umask_idmapped(const struct vfstest_info *info)
> +{
> +	int fret = -1;
> +	int file1_fd = -EBADF, open_tree_fd = -EBADF;
> +	struct mount_attr attr = {
> +		.attr_set = MOUNT_ATTR_IDMAP,
> +	};
> +	pid_t pid;
> +	int tmpfile_fd = -EBADF;
> +	bool supported = false;
> +	char path[PATH_MAX];
> +	mode_t mode;
> +
> +	if (!caps_supported())
> +		return 0;
> +
> +	if (fchmod(info->t_dir1_fd, S_IRUSR |
> +			      S_IWUSR |
> +			      S_IRGRP |
> +			      S_IWGRP |
> +			      S_IROTH |
> +			      S_IWOTH |
> +			      S_IXUSR |
> +			      S_IXGRP |
> +			      S_IXOTH |
> +			      S_ISGID), 0) {
> +		log_stderr("failure: fchmod");
> +		goto out;
> +	}
> +
> +	/* Verify that the sid bits got raised. */
> +	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
> +		log_stderr("failure: is_setgid");
> +		goto out;
> +	}
> +
> +	/* Changing mount properties on a detached mount. */
> +	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> +	if (attr.userns_fd < 0) {
> +		log_stderr("failure: get_userns_fd");
> +		goto out;
> +	}
> +
> +	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
> +				     AT_EMPTY_PATH |
> +				     AT_NO_AUTOMOUNT |
> +				     AT_SYMLINK_NOFOLLOW |
> +				     OPEN_TREE_CLOEXEC |
> +				     OPEN_TREE_CLONE);
> +	if (open_tree_fd < 0) {
> +		log_stderr("failure: sys_open_tree");
> +		goto out;
> +	}
> +
> +	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
> +		log_stderr("failure: sys_mount_setattr");
> +		goto out;
> +	}
> +
> +	supported = openat_tmpfile_supported(open_tree_fd);
> +
> +	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
> +	 * whether has group execute or search permission.
> +	 */
> +	umask(S_IXGRP);
> +	mode = umask(S_IXGRP);
> +	if (!(mode & S_IXGRP))
> +		die("failure: umask");
> +
> +		pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		if (!switch_ids(10000, 11000))
> +			die("failure: switch fsids");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(open_tree_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create directory */
> +		if (mkdirat(open_tree_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(open_tree_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE2, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a whiteout device via mknodat() vfs_mknod */
> +		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 10000, not by gid 11000.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 10000, not by gid 11000.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(open_tree_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(open_tree_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (is_ixgrp(open_tree_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
> +				die("failure: check ownership");
> +			if (unlinkat(open_tree_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	safe_close(attr.userns_fd);
> +	safe_close(file1_fd);
> +	safe_close(open_tree_fd);
> +
> +	return fret;
> +}
> +
> +static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *info)
> +{
> +	int fret = -1;
> +	int file1_fd = -EBADF, open_tree_fd = -EBADF;
> +	struct mount_attr attr = {
> +		.attr_set = MOUNT_ATTR_IDMAP,
> +	};
> +	pid_t pid;
> +	int tmpfile_fd = -EBADF;
> +	bool supported = false;
> +	char path[PATH_MAX];
> +	mode_t mode;
> +
> +	if (!caps_supported())
> +		return 0;
> +
> +	if (fchmod(info->t_dir1_fd, S_IRUSR |
> +			      S_IWUSR |
> +			      S_IRGRP |
> +			      S_IWGRP |
> +			      S_IROTH |
> +			      S_IWOTH |
> +			      S_IXUSR |
> +			      S_IXGRP |
> +			      S_IXOTH |
> +			      S_ISGID), 0) {
> +		log_stderr("failure: fchmod");
> +		goto out;
> +	}
> +
> +	/* Verify that the sid bits got raised. */
> +	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
> +		log_stderr("failure: is_setgid");
> +		goto out;
> +	}
> +
> +	/* Changing mount properties on a detached mount. */
> +	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
> +	if (attr.userns_fd < 0) {
> +		log_stderr("failure: get_userns_fd");
> +		goto out;
> +	}
> +
> +	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
> +				     AT_EMPTY_PATH |
> +				     AT_NO_AUTOMOUNT |
> +				     AT_SYMLINK_NOFOLLOW |
> +				     OPEN_TREE_CLOEXEC |
> +				     OPEN_TREE_CLONE);
> +	if (open_tree_fd < 0) {
> +		log_stderr("failure: sys_open_tree");
> +		goto out;
> +	}
> +
> +	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
> +		log_stderr("failure: sys_mount_setattr");
> +		goto out;
> +	}
> +
> +	supported = openat_tmpfile_supported(open_tree_fd);
> +
> +	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
> +	 * whether has group execute or search permission.
> +	 */
> +	umask(S_IXGRP);
> +	mode = umask(S_IXGRP);
> +	if (!(mode & S_IXGRP))
> +		die("failure: umask");
> +
> +	/*
> +	 * Below we verify that setgid inheritance for a newly created file or
> +	 * directory works correctly. As part of this we need to verify that
> +	 * newly created files or directories inherit their gid from their
> +	 * parent directory. So we change the parent directorie's gid to 1000
> +	 * and create a file with fs{g,u}id 0 and verify that the newly created
> +	 * file and directory inherit gid 1000, not 0.
> +	 */
> +	if (fchownat(info->t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
> +		log_stderr("failure: fchownat");
> +		goto out;
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		if (!caps_supported()) {
> +			log_debug("skip: capability library not installed");
> +			exit(EXIT_SUCCESS);
> +		}
> +
> +		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +			die("failure: switch_userns");
> +
> +		if (!caps_down_fsetid())
> +			die("failure: caps_down_fsetid");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(open_tree_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create directory */
> +		if (mkdirat(open_tree_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(open_tree_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(open_tree_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, FILE2, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a whiteout device via mknodat() vfs_mknod */
> +		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 1000, not by gid 0.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 1000, not by gid 0.
> +		 */
> +		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(open_tree_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(open_tree_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
> +			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(open_tree_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (is_ixgrp(open_tree_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
> +				die("failure: check ownership");
> +			if (unlinkat(open_tree_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	safe_close(attr.userns_fd);
> +	safe_close(file1_fd);
> +	safe_close(open_tree_fd);
> +
> +	return fret;
> +}
> +
>  static const struct test_struct t_idmapped_mounts[] = {
>  	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
>  	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
> @@ -7745,3 +8164,13 @@ const struct test_suite s_setxattr_fix_705191b03d50 = {
>  	.tests = t_setxattr_fix_705191b03d50,
>  	.nr_tests = ARRAY_SIZE(t_setxattr_fix_705191b03d50),
>  };
> +
> +static const struct test_struct t_setgid_create_umask_idmapped[] = {
> +	{ setgid_create_umask_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount",		},
> +	{ setgid_create_umask_idmapped_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount inside userns",	},
> +};
> +
> +const struct test_suite s_setgid_create_umask_idmapped = {
> +	.tests = t_setgid_create_umask_idmapped,
> +	.nr_tests = ARRAY_SIZE(t_setgid_create_umask_idmapped),
> +};
> diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
> index ff21ea2c..a332439f 100644
> --- a/src/vfs/idmapped-mounts.h
> +++ b/src/vfs/idmapped-mounts.h
> @@ -14,5 +14,6 @@ extern const struct test_suite s_fscaps_in_ancestor_userns;
>  extern const struct test_suite s_nested_userns;
>  extern const struct test_suite s_setattr_fix_968219708108;
>  extern const struct test_suite s_setxattr_fix_705191b03d50;
> +extern const struct test_suite s_setgid_create_umask_idmapped;
>  
>  #endif /* __IDMAPPED_MOUNTS_H */
> diff --git a/src/vfs/utils.c b/src/vfs/utils.c
> index 1388edda..6db7a11d 100644
> --- a/src/vfs/utils.c
> +++ b/src/vfs/utils.c
> @@ -809,6 +809,20 @@ bool is_sticky(int dfd, const char *path, int flags)
>  	return (st.st_mode & S_ISVTX) > 0;
>  }
>  
> +/*is_ixgrp - check whether file or directory is S_IXGRP */
> +bool is_ixgrp(int dfd, const char *path, int flags)
> +{
> +	int ret;
> +	struct stat st;
> +
> +	ret = fstatat(dfd, path, &st, flags);
> +	if (ret < 0)
> +		return false;
> +
> +	errno = 0; /* Don't report misleading errno. */
> +	return (st.st_mode & S_IXGRP);
> +}
> +
>  bool switch_resids(uid_t uid, gid_t gid)
>  {
>  	if (setresgid(gid, gid, gid))
> diff --git a/src/vfs/utils.h b/src/vfs/utils.h
> index 7fb702fd..c0dbe370 100644
> --- a/src/vfs/utils.h
> +++ b/src/vfs/utils.h
> @@ -368,6 +368,7 @@ extern bool expected_file_size(int dfd, const char *path, int flags,
>  extern bool is_setid(int dfd, const char *path, int flags);
>  extern bool is_setgid(int dfd, const char *path, int flags);
>  extern bool is_sticky(int dfd, const char *path, int flags);
> +extern bool is_ixgrp(int dfd, const char *path, int flags);
>  extern bool openat_tmpfile_supported(int dirfd);
>  
>  #endif /* __IDMAP_UTILS_H */
> diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
> index 29ac0bec..8448362e 100644
> --- a/src/vfs/vfstest.c
> +++ b/src/vfs/vfstest.c
> @@ -1733,6 +1733,186 @@ out:
>  	return fret;
>  }
>  
> +/* The current_umask() is stripped from the mode directly in the vfs if the
> + * filesystem either doesn't support acls or the filesystem has been
> + * mounted without posic acl support.
> + *
> + * If the filesystem does support acls then current_umask() stripping is
> + * deferred to posix_acl_create(). So when the filesystem calls
> + * posix_acl_create() and there are no acls set or not supported then
> + * current_umask() will be stripped.
> + *
> + * Use umask(S_IXGRP) to check whether inode strip S_ISGID works correctly.
> + */
> +
> +static int setgid_create_umask(const struct vfstest_info *info)
> +{
> +	int fret = -1;
> +	int file1_fd = -EBADF;
> +	int tmpfile_fd = -EBADF;
> +	pid_t pid;
> +	bool supported = false;
> +	mode_t mode;
> +
> +	if (!caps_supported())
> +		return 0;
> +
> +	if (fchmod(info->t_dir1_fd, S_IRUSR |
> +			      S_IWUSR |
> +			      S_IRGRP |
> +			      S_IWGRP |
> +			      S_IROTH |
> +			      S_IWOTH |
> +			      S_IXUSR |
> +			      S_IXGRP |
> +			      S_IXOTH |
> +			      S_ISGID), 0) {
> +		log_stderr("failure: fchmod");
> +		goto out;
> +	}
> +
> +	/* Verify that the setgid bit got raised. */
> +	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
> +		log_stderr("failure: is_setgid");
> +		goto out;
> +	}
> +
> +	supported = openat_tmpfile_supported(info->t_dir1_fd);
> +
> +	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
> +	 * whether has group execute or search permission.
> +	 */
> +	umask(S_IXGRP);
> +	mode = umask(S_IXGRP);
> +	if (!(mode & S_IXGRP))
> +		die("failure: umask");
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		if (!switch_ids(0, 10000))
> +			die("failure: switch_ids");
> +
> +		if (!caps_down_fsetid())
> +			die("failure: caps_down_fsetid");
> +
> +		/* create regular file via open() */
> +		file1_fd = openat(info->t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> +		if (file1_fd < 0)
> +			die("failure: create");
> +
> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> +		 * bit needs to be stripped.
> +		 */
> +		if (is_setgid(info->t_dir1_fd, FILE1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(info->t_dir1_fd, FILE1, 0))
> +			die("failure: is_ixgrp");
> +
> +		if (mkdirat(info->t_dir1_fd, DIR1, 0000))
> +			die("failure: create");
> +
> +		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
> +			/* We're not in_group_p(). */
> +			if (is_setgid(info->t_dir1_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		} else {
> +			/* Directories always inherit the setgid bit. */
> +			if (!is_setgid(info->t_dir1_fd, DIR1, 0))
> +				die("failure: is_setgid");
> +		}
> +
> +		if (is_ixgrp(info->t_dir1_fd, DIR1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a special file via mknodat() vfs_create */
> +		if (mknodat(info->t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(info->t_dir1_fd, FILE2, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(info->t_dir1_fd, FILE2, 0))
> +			die("failure: is_ixgrp");
> +
> +		/* create a character device via mknodat() vfs_mknod */
> +		if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
> +			die("failure: mknodat");
> +
> +		if (is_setgid(info->t_dir1_fd, CHRDEV1, 0))
> +			die("failure: is_setgid");
> +
> +		if (is_ixgrp(info->t_dir1_fd, CHRDEV1, 0))
> +			die("failure: is_ixgrp");
> +
> +		/*
> +		 * In setgid directories newly created files always inherit the
> +		 * gid from the parent directory. Verify that the file is owned
> +		 * by gid 0, not by gid 10000.
> +		 */
> +		if (!expected_uid_gid(info->t_dir1_fd, FILE1, 0, 0, 0))
> +			die("failure: check ownership");
> +
> +		/*
> +		 * In setgid directories newly created directories always
> +		 * inherit the gid from the parent directory. Verify that the
> +		 * directory is owned by gid 0, not by gid 10000.
> +		 */
> +		if (!expected_uid_gid(info->t_dir1_fd, DIR1, 0, 0, 0))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(info->t_dir1_fd, FILE2, 0, 0, 0))
> +			die("failure: check ownership");
> +
> +		if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0))
> +			die("failure: check ownership");
> +
> +		if (unlinkat(info->t_dir1_fd, FILE1, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(info->t_dir1_fd, DIR1, AT_REMOVEDIR))
> +			die("failure: delete");
> +
> +		if (unlinkat(info->t_dir1_fd, FILE2, 0))
> +			die("failure: delete");
> +
> +		if (unlinkat(info->t_dir1_fd, CHRDEV1, 0))
> +			die("failure: delete");
> +
> +		/* create tmpfile via filesystem tmpfile api */
> +		if (supported) {
> +			tmpfile_fd = openat(info->t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
> +			if (tmpfile_fd < 0)
> +				die("failure: create");
> +			/* link the temporary file into the filesystem, making it permanent */
> +			if (linkat(tmpfile_fd, "", info->t_dir1_fd, FILE3, AT_EMPTY_PATH))
> +				die("failure: linkat");
> +			if (close(tmpfile_fd))
> +				die("failure: close");
> +			if (is_setgid(info->t_dir1_fd, FILE3, 0))
> +				die("failure: is_setgid");
> +			if (is_ixgrp(info->t_dir1_fd, FILE3, 0))
> +				die("failure: is_ixgrp");
> +			if (unlinkat(info->t_dir1_fd, FILE3, 0))
> +				die("failure: delete");
> +		}
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	fret = 0;
> +	log_debug("Ran test");
> +out:
> +	safe_close(file1_fd);
> +	return fret;
> +}
> +
>  static int setattr_truncate(const struct vfstest_info *info)
>  {
>  	int fret = -1;
> @@ -1807,6 +1987,7 @@ static void usage(void)
>  	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
>  	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
>  	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
> +	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
>  
>  	_exit(EXIT_SUCCESS);
>  }
> @@ -1825,6 +2006,7 @@ static const struct option longopts[] = {
>  	{"test-btrfs",				no_argument,		0,	'b'},
>  	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
>  	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
> +	{"test-setgid-create-umask",		no_argument,		0,	'u'},
>  	{NULL,					0,			0,	  0},
>  };
>  
> @@ -1850,6 +2032,15 @@ static const struct test_suite s_basic = {
>  	.nr_tests = ARRAY_SIZE(t_basic),
>  };
>  
> +static const struct test_struct t_setgid_create_umask[] = {
> +	{ setgid_create_umask,						0,			"create operations in directories with setgid bit set under umask",				},
> +};
> +
> +static const struct test_suite s_setgid_create_umask = {
> +	.tests = t_setgid_create_umask,
> +	.nr_tests = ARRAY_SIZE(t_setgid_create_umask),
> +};
> +
>  static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
>  {
>  	int i;
> @@ -1947,7 +2138,8 @@ int main(int argc, char *argv[])
>  	bool idmapped_mounts_supported = false, test_btrfs = false,
>  	     test_core = false, test_fscaps_regression = false,
>  	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
> -	     test_setxattr_fix_705191b03d50 = false;
> +	     test_setxattr_fix_705191b03d50 = false,
> +	     test_setgid_create_umask = false;
>  
>  	init_vfstest_info(&info);
>  
> @@ -1989,6 +2181,9 @@ int main(int argc, char *argv[])
>  		case 'j':
>  			test_setxattr_fix_705191b03d50 = true;
>  			break;
> +		case 'u':
> +			test_setgid_create_umask = true;
> +			break;
>  		case 'h':
>  			/* fallthrough */
>  		default:
> @@ -2066,6 +2261,14 @@ int main(int argc, char *argv[])
>  	    !run_suite(&info, &s_setxattr_fix_705191b03d50))
>  		goto out;
>  
> +	if (test_setgid_create_umask) {
> +		if (!run_suite(&info, &s_setgid_create_umask))
> +			goto out;
> +
> +		if (!run_suite(&info, &s_setgid_create_umask_idmapped))
> +			goto out;
> +	}
> +
>  	fret = EXIT_SUCCESS;
>  
>  out:
> diff --git a/tests/generic/691 b/tests/generic/691
> new file mode 100755
> index 00000000..d4875854
> --- /dev/null
> +++ b/tests/generic/691
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Fujitsu Limited. All Rights Reserved.
> +#
> +# FS QA Test No. 691
> +#
> +# Test that idmapped mounts setgid's behave correctly when using
> +# umask(S_IXGRP)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick cap idmapped mount perms rw unlink
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_require_test
> +_require_scratch
> +
> +echo "Silence is golden"
> +
> +$here/src/vfs/vfstest --test-setgid-create-umask \
> +        --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
> +
> +_scratch_mkfs > "$seqres.full" 2>&1
> +export MOUNT_OPTIONS="-o noacl"
> +
> +# If filesystem supports noacl mount option, also test setgid bit whether
> +# was stripped correctly.
> +# noacl will earse acl flag in superblock, so kernel will use current_umask
> +# in vfs directly instead of calling posix_acl_create on underflying
> +# filesystem.
> +_try_scratch_mount >>$seqres.full 2>&1 && \
> +	$here/src/vfs/vfstest --test-setgid-create-umask \
> +        --device "$SCRATCH_DEV" --mount "$SCRATCH_MNT" --fstype "$FSTYP"
> +
> +status=0
> +exit
> diff --git a/tests/generic/691.out b/tests/generic/691.out
> new file mode 100644
> index 00000000..006aef43
> --- /dev/null
> +++ b/tests/generic/691.out
> @@ -0,0 +1,2 @@
> +QA output created by 691
> +Silence is golden
> -- 
> 2.27.0
> 

