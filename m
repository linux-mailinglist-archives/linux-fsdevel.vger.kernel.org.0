Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03304FF44D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiDMKBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiDMKB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:01:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16F56438;
        Wed, 13 Apr 2022 02:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B228BB8217B;
        Wed, 13 Apr 2022 09:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406C9C385A3;
        Wed, 13 Apr 2022 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649843945;
        bh=ldbFSGNTBkIFTkAPcFAoicVHvb338QcoanqBzNI6jAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mavmsIPYbgTplfim3SZisoTkZN9aUvuP/f8Qe0dM9OcINyMxTVPcJJWzBX6WasUV9
         KzXHFR/nWfSDs4gDfMz2kYSmeTkZYyKGjRcy5lS1zYc/EgN9tAXIuYk2PJVY8X3EzM
         M4CopndMGCi9JYmos6B3y6MY/sH6pojq5+PzrXzaJVVMm6LnLEi1dflXbJpyTDUhTa
         w/8EGbhCW3JRSnXHD6w9vombYstvV/HRyDbYmzHO6/g3zNGtTzSYb4f2Cle8dmQYvQ
         V4s1FM1tn+8jaIl9g8SvqAcVMiQx8vL6AgiukAG0r+fsDRtEbiCQLnHDrO6xGAeWcT
         rVLAGysTHSo5Q==
Date:   Wed, 13 Apr 2022 11:59:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] idmapped-mounts: Add new setgid_create_umask test
Message-ID: <20220413095901.2s7jeqyefovd7wok@wittgenstein>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649763226-2329-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220413085946.bh2cii5q5isx2odr@wittgenstein>
 <6256A9F2.2030801@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6256A9F2.2030801@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:45:11AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/13 16:59, Christian Brauner wrote:
> > On Tue, Apr 12, 2022 at 07:33:45PM +0800, Yang Xu wrote:
> >> The current_umask() is stripped from the mode directly in the vfs if the
> >> filesystem either doesn't support acls or the filesystem has been
> >> mounted without posic acl support.
> >>
> >> If the filesystem does support acls then current_umask() stripping is
> >> deferred to posix_acl_create(). So when the filesystem calls
> >> posix_acl_create() and there are no acls set or not supported then
> >> current_umask() will be stripped.
> >>
> >> Here we only use umask(S_IXGRP) to check whether inode strip
> >> S_ISGID works correctly.
> >>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >>   src/idmapped-mounts/idmapped-mounts.c | 505 +++++++++++++++++++++++++-
> >>   tests/generic/680                     |  26 ++
> >>   tests/generic/680.out                 |   2 +
> >>   3 files changed, 532 insertions(+), 1 deletion(-)
> >>   create mode 100755 tests/generic/680
> >>   create mode 100644 tests/generic/680.out
> >>
> >> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> >> index 02f91558..e6c14586 100644
> >> --- a/src/idmapped-mounts/idmapped-mounts.c
> >> +++ b/src/idmapped-mounts/idmapped-mounts.c
> >> @@ -14146,6 +14146,494 @@ out:
> >>   	return fret;
> >>   }
> >>
> >> +/* The following tests are concerned with setgid inheritance. These can be
> >> + * filesystem type specific. For xfs, if a new file or directory or node is
> >> + * created within a setgid directory and irix_sgid_inhiert is set then inheritthe
> >> + * setgid bit if the caller is in the group of the directory.
> >> + *
> >> + * The current_umask() is stripped from the mode directly in the vfs if the
> >> + * filesystem either doesn't support acls or the filesystem has been
> >> + * mounted without posic acl support.
> >> + *
> >> + * If the filesystem does support acls then current_umask() stripping is
> >> + * deferred to posix_acl_create(). So when the filesystem calls
> >> + * posix_acl_create() and there are no acls set or not supported then
> >> + * current_umask() will be stripped.
> >> + *
> >> + * Use umask(S_IXGRP) to check whether inode strip S_ISGID works correctly.
> >> + */
> >> +static int setgid_create_umask(void)
> >> +{
> >> +	int fret = -1;
> >> +	int file1_fd = -EBADF;
> >> +	int tmpfile_fd = -EBADF;
> >> +	pid_t pid;
> >> +	bool supported = false;
> >> +	char path[PATH_MAX];
> >> +	mode_t mode;
> >> +
> >> +	if (!caps_supported())
> >> +		return 0;
> >> +
> >> +	if (fchmod(t_dir1_fd, S_IRUSR |
> >> +			      S_IWUSR |
> >> +			      S_IRGRP |
> >> +			      S_IWGRP |
> >> +			      S_IROTH |
> >> +			      S_IWOTH |
> >> +			      S_IXUSR |
> >> +			      S_IXGRP |
> >> +			      S_IXOTH |
> >> +			      S_ISGID), 0) {
> >> +		log_stderr("failure: fchmod");
> >> +		goto out;
> >> +	}
> >> +
> >> +	   /* Verify that the setgid bit got raised. */
> >> +	if (!is_setgid(t_dir1_fd, "", AT_EMPTY_PATH)) {
> >> +		log_stderr("failure: is_setgid");
> >> +		goto out;
> >> +	}
> >> +
> >> +	supported = openat_tmpfile_supported(t_dir1_fd);
> >> +
> >> +	/* Only umask with S_IXGRP because inode strip S_ISGID will check mode
> >> +	 * whether has group execute or search permission.
> >> +	 */
> >> +	umask(S_IXGRP);
> >> +	mode = umask(S_IXGRP);
> >> +	if (!(mode&  S_IXGRP))
> >> +		die("failure: umask");
> >> +
> >> +	pid = fork();
> >> +	if (pid<  0) {
> >> +		log_stderr("failure: fork");
> >> +		goto out;
> >> +	}
> >> +	if (pid == 0) {
> >> +		if (!switch_ids(0, 10000))
> >> +			die("failure: switch_ids");
> >> +
> >> +		if (!caps_down_fsetid())
> >> +			die("failure: caps_down_fsetid");
> >> +
> >> +		/* create regular file via open() */
> >> +		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> >> +		if (file1_fd<  0)
> >> +			die("failure: create");
> >> +
> >> +		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
> >> +		 * bit needs to be stripped.
> >> +		 */
> >> +		if (is_setgid(t_dir1_fd, FILE1, 0))
> >> +			die("failure: is_setgid");
> >
> > This test is wrong. Specifically, it is a false positive. I have
> > explained this in more detail on v2 of this patchset.
> >
> > You want to test that umask(S_IXGRP) + setgid inheritance work together
> > correctly. First, we need to establish what that means because from your
> > patch series it at least seems to me as you're not completely clear
> > about what you want to test just yet.
> >
> > A requested setgid bit for a non-directory object is only considered for
> > stripping if S_IXGRP is simultaneously requested. In other words, both
> > S_SISGID and S_IXGRP must be requested for the new file in order for
> > additional checks such as CAP_FSETID to become relevant.
> Yes, only keep S_IXGRP, then we can run into the next judgement for 
> group and cap_fsetid.
> >
> > We need to distinguish two cases afaict:
> >
> > 1. The filesystem does support ACLs and has an applicable ACL
> > -------------------------------------------------------------
> >
> > umask(S_IXGRP) is not used by the kernel and thus S_IXGRP is not
> > stripped (unless the ACL does make it so) and so when e.g.
> > inode_init_owner() is called we do not expect the file to inherit the
> > setgid bit.
> >
> > This is what your test above is handling correctly. But it is a false
> > positive because what you're trying to test is the behavior of
> > umask(S_IXGRP) but it is made irrelevant by ACL support of the
> > underlying filesystem.
> I test this situation in the next patch as below:
> umask(S_IXGRP);
> snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx,m:rw 
> %s/%s", t_mountpoint, T_DIR1)
> 
> and
> umask(S_IXGRP);
> snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx, 
> %s/%s", t_mountpoint, T_DIR1
> 
> >
> > 2. The filesystem does not support ACLs, has been mounted without
> > -----------------------------------------------------------------
> > support for it, or has no applicable ACL
> > ----------------------------------------
> >
> > umask(S_IXGRP) is used by the kernel and will be stripped from the mode.
> > So when inode_init_owner() is called we expect the file to inherit the
> > setgid bit.
> This is why my kernel patch put strip setgid code into vfs.
> xfs will inherit the setgid bit but ext4 not because the new_inode 
> function and posix_acl_create function order(S_IXGRP mode has been 
> stripped before pass to inode_init_owner).
> >
> > This means the test for this case needs to be:
> >
> > 	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
> > 	if (file1_fd<  0)
> > 		die("failure: create");
> > 	
> > 	/*
> > 	 * S_IXGRP will have been removed due to umask(S_IXGRP) so we expect the
> > 	 * new file to be S_ISGID.
> No No No, see the kernel patch url
> https://patchwork.kernel.org/project/linux-fsdevel/patch/1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com/

Ok, so your testing patches are premised on your kernel patchset. That
wasn't clear to me.

The kernel patchset removes the setgid bit _before_ the umask is applied
which is why you're expecting this file to not be setgid because you
also dropped CAP_FSETID and you'r not in the group of the directory.

(Ok, let's defer that discussion to the updated patchset.)
