Return-Path: <linux-fsdevel+bounces-52228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D09AAE053C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 14:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010423A4422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED327230BEC;
	Thu, 19 Jun 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NV+3sdKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477EA3B1AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335320; cv=none; b=Izgm3++EJCb3w87zQM4p1F0Moy5pj0kRh5d3iijKoVXRLWup6DzOk751ulvHBrlkDM++EcJE8QXDIIYHHjgqozO0k2GX6DVxPtD1+mIUMqkxjPoX6Ts/1rRyCmX75svuhL/pEVryQ0gyiCieNjVTQvSOZpCzshUebBdxT8Kn3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335320; c=relaxed/simple;
	bh=nednzduZL8/aUqOyBWC8bpm/e0GKAZD1JKC1sGKeSiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRgIGEN3L0vEkAP++TPmnPBEVPbnE6XCBVITjjAdluMPbjR6gmFFWZJJem2WF+YDlhbehckrLW/JfHPAXu+NZi5wR4U95HpsloZhbojzZ2/KAf30tDQ2DzYxXyop/cA8cNOq/JVr4YVErge/EqaWLr6sgA1bwlxJOEXxqxRHCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NV+3sdKB; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bNJXJ1WW0zrZq;
	Thu, 19 Jun 2025 13:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750333120;
	bh=EiFSSBNguGwOMYsKp/VsBpTuUQhV0U8siDF20WYtiwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NV+3sdKBDOg+U3y/2jS+Azc8/I9i/uXB7FOptYMYZ3JUQZqo8V75jzOzpV26SMbVE
	 gNfib5+hTlN+DyeM65+gxS8WcJCpY4tk6GRAPylP403Tt3CreM/MmIT7P6wjpbsP0g
	 id2LpFjuhlaRVcJDZJwiSeMFqCp/gCDJKjPouVXo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bNJXH4gFkzrBx;
	Thu, 19 Jun 2025 13:38:39 +0200 (CEST)
Date: Thu, 19 Jun 2025 13:38:38 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
Message-ID: <20250619.yohT8thouf5J@digikod.net>
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sat, Jun 14, 2025 at 07:25:02PM +0100, Tingmao Wang wrote:
> This adds a test for the edge case discussed in [1], and in addition also
> test rename operations when the operands are through disconnected paths,
> as that go through a separate code path in Landlock.
> 
> [1]: https://lore.kernel.org/linux-security-module/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org/
> 
> This has resulted in a WARNING, due to collect_domain_accesses() not
> expecting to reach a different root from path->mnt:
> 
> 	#  RUN           layout1_bind.path_disconnected ...
> 	#            OK  layout1_bind.path_disconnected
> 	ok 96 layout1_bind.path_disconnected
> 	#  RUN           layout1_bind.path_disconnected_rename ...
> 	[..] ------------[ cut here ]------------
> 	[..] WARNING: CPU: 3 PID: 385 at security/landlock/fs.c:1065 collect_domain_accesses
> 	[..] ...
> 	[..] RIP: 0010:collect_domain_accesses (security/landlock/fs.c:1065 (discriminator 2) security/landlock/fs.c:1031 (discriminator 2))
> 	[..] current_check_refer_path (security/landlock/fs.c:1205)
> 	[..] ...
> 	[..] hook_path_rename (security/landlock/fs.c:1526)
> 	[..] security_path_rename (security/security.c:2026 (discriminator 1))
> 	[..] do_renameat2 (fs/namei.c:5264)
> 	#            OK  layout1_bind.path_disconnected_rename
> 	ok 97 layout1_bind.path_disconnected_rename

Good catch and thanks for the tests!  I sent a fix:
https://lore.kernel.org/all/20250618134734.1673254-1-mic@digikod.net/

> 
> My understanding is that terminating at the mountpoint is basically an
> optimization, so that for rename operations we only walks the path from
> the mountpoint to the real root once.  We probably want to keep this
> optimization, as disconnected paths are probably a very rare edge case.

Rename operations can only happen within the same mount point, otherwise
the kernel returns -EXDEV.  The collect_domain_accesses() is called for
the source and the destination of a rename to walk to their common mount
point, if any.  We could maybe improve this walk by doing them at the
same time but because we don't know the depth of each path, I'm not sure
the required extra complexity would be worth it.  The current approach
is simple and opportunistically limits the walks.

> 
> This might need more thinking, but maybe if one of the operands is
> disconnected, we can just let it walk until IS_ROOT(dentry), and also
> collect access for the other path until IS_ROOT(dentry), then call
> is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
> this case is_access_to_paths_allowed will not do any walking and just make
> an access decision.)

If one side is in a disconnected directory and not the other side, the
rename would be denied by the VFS, but Landlock should still log (and
then deny) the side that would be denied anyway.

> 
> Letting the walk continue until IS_ROOT(dentry) is what
> is_access_to_paths_allowed() effectively does for non-renames.
> 
> (Also note: moving the const char definitions a bit above so that we can
> use the path for s4d1 in cleanup code.)
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>

I squashed your patches and push them to my next branch with some minor
changes.  Please let me know if there is something wrong.

> ---
>  tools/testing/selftests/landlock/fs_test.c | 271 ++++++++++++++++++++-
>  1 file changed, 268 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 73729382d40f..d042a742a1c5 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4521,6 +4521,17 @@ TEST_F_FORK(ioctl, handle_file_access_file)
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
>  
> +static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
> +static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
> +/* Move targets for disconnected path tests */
> +static const char dir_s4d1[] = TMP_DIR "/s4d1";
> +static const char file1_s4d1[] = TMP_DIR "/s4d1/f1";
> +static const char file2_s4d1[] = TMP_DIR "/s4d1/f2";
> +static const char dir_s4d2[] = TMP_DIR "/s4d1/s4d2";
> +static const char file1_s4d2[] = TMP_DIR "/s4d1/s4d2/f1";
> +static const char file1_name[] = "f1";
> +static const char file2_name[] = "f2";
> +
>  FIXTURE_SETUP(layout1_bind)
>  {
>  	prepare_layout(_metadata);
> @@ -4536,14 +4547,14 @@ FIXTURE_TEARDOWN_PARENT(layout1_bind)
>  {
>  	/* umount(dir_s2d2)) is handled by namespace lifetime. */
>  
> +	remove_path(file1_s4d1);
> +	remove_path(file2_s4d1);
> +
>  	remove_layout1(_metadata);
>  
>  	cleanup_layout(_metadata);
>  }
>  
> -static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
> -static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
> -
>  /*
>   * layout1_bind hierarchy:
>   *
> @@ -4766,6 +4777,260 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
>  	ASSERT_EQ(0, rename(bind_file1_s1d3, file1_s2d2));
>  }
>  
> +/*
> + * Make sure access to file through a disconnected path works as expected.
> + * This test uses s4d1 as the move target.
> + */
> +TEST_F_FORK(layout1_bind, path_disconnected)
> +{
> +	const struct rule layer1_allow_all[] = {
> +		{
> +			.path = TMP_DIR,
> +			.access = ACCESS_ALL,
> +		},
> +		{},
> +	};
> +
> +	const struct rule layer2_allow_just_f1[] = {
> +		{
> +			.path = file1_s1d3,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{},
> +	};
> +
> +	const struct rule layer3_only_s1d2[] = {
> +		{
> +			.path = dir_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{},
> +	};
> +
> +	/* Landlock should not deny access just because it is disconnected */
> +	int ruleset_fd =
> +		create_ruleset(_metadata, ACCESS_ALL, layer1_allow_all);
> +	/*
> +	 * Create the new ruleset now before we move the dir containing the
> +	 * file

Please use third person for most comments, and end them with a final dot
(for sentences).

> +	 */
> +	int ruleset_fd_l2 =
> +		create_ruleset(_metadata, ACCESS_RW, layer2_allow_just_f1);
> +	int ruleset_fd_l3 =
> +		create_ruleset(_metadata, ACCESS_RW, layer3_only_s1d2);
> +	int bind_s1d3_fd;
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_LE(0, ruleset_fd_l2);
> +	ASSERT_LE(0, ruleset_fd_l3);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));

I'll replace most ASSERT_* with EXPECT_*
ASSERT should only be used when checking a dependency for the following
tests.  It's not apply everywhere but new tests should follow this rule.

> +
> +	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
> +
> +	ASSERT_LE(0, bind_s1d3_fd);
> +	/* Test access is possible before we move */
> +	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +	/* Make it disconnected */
> +	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d1))
> +	{
> +		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d1,
> +		       strerror(errno));
> +	}
> +	/* Test access still possible */
> +	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +	/*
> +	 * Test ".." not possibe (not because of landlock, but just because
> +	 * it's disconnected)
> +	 */
> +	ASSERT_EQ(ENOENT,
> +		  test_open_rel(bind_s1d3_fd, "..", O_RDONLY | O_DIRECTORY));
> +
> +	/* Should still work with a narrower rule */
> +	enforce_ruleset(_metadata, ruleset_fd_l2);
> +	ASSERT_EQ(0, close(ruleset_fd_l2));
> +
> +	ASSERT_EQ(0, test_open(file1_s4d1, O_RDONLY));
> +	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +	ASSERT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
> +
> +	/*
> +	 * But if we only allow access to under the original dir, then it
> +	 * should be denied.
> +	 */
> +	enforce_ruleset(_metadata, ruleset_fd_l3);
> +	ASSERT_EQ(0, close(ruleset_fd_l3));
> +	ASSERT_EQ(EACCES, test_open(file1_s4d1, O_RDONLY));
> +	ASSERT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +}
> +
> +/*
> + * Test that we can rename to make files disconnected, and rename it back,
> + * under landlock.  This test uses s4d2 as the move target, so that we can
> + * have a rule allowing refers on the move target's immediate parent.
> + */
> +TEST_F_FORK(layout1_bind, path_disconnected_rename)
> +{
> +	const struct rule layer1[] = {
> +		{
> +			.path = dir_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_REFER |
> +				  LANDLOCK_ACCESS_FS_MAKE_DIR |
> +				  LANDLOCK_ACCESS_FS_REMOVE_DIR |
> +				  LANDLOCK_ACCESS_FS_MAKE_REG |
> +				  LANDLOCK_ACCESS_FS_REMOVE_FILE |
> +				  LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{
> +			.path = dir_s4d1,
> +			.access = LANDLOCK_ACCESS_FS_REFER |
> +				  LANDLOCK_ACCESS_FS_MAKE_DIR |
> +				  LANDLOCK_ACCESS_FS_REMOVE_DIR |
> +				  LANDLOCK_ACCESS_FS_MAKE_REG |
> +				  LANDLOCK_ACCESS_FS_REMOVE_FILE |
> +				  LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{}
> +	};
> +
> +	const struct rule layer2_only_s1d2[] = {
> +		{
> +			.path = dir_s1d2,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{},
> +	};
> +
> +	ASSERT_EQ(0, mkdir(dir_s4d1, 0755))
> +	{
> +		TH_LOG("Failed to create %s: %s", dir_s4d1, strerror(errno));
> +	}
> +
> +	int ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
> +	int ruleset_fd_l2 = create_ruleset(
> +		_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer2_only_s1d2);
> +	pid_t child_pid;
> +	int bind_s1d3_fd, status;

I'll move variable declarations before mkdir call.

> +
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_LE(0, ruleset_fd_l2);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, bind_s1d3_fd);
> +	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +

I'll add these checks to test ENOENT priority over EACCES for
disconnected directory:

EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, "..", O_DIRECTORY));

> +	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
> +	{
> +		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
> +		       strerror(errno));
> +	}

EXPECT_EQ(ENOENT, test_open_rel(bind_s1d3_fd, "..", O_DIRECTORY));

> +
> +	/*
> +	 * Since file is no longer under s1d2, we should not be able to access
> +	 * it if we enforced layer 2.  Do a fork to test this so we don't
> +	 * prevent ourselves from renaming it back later.
> +	 */
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		enforce_ruleset(_metadata, ruleset_fd_l2);
> +		ASSERT_EQ(0, close(ruleset_fd_l2));
> +		ASSERT_EQ(EACCES,
> +			  test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +		ASSERT_EQ(EACCES, test_open(file1_s4d2, O_RDONLY));
> +
> +		/*
> +		 * Test that access widening checks indeed prevents us from
> +		 * renaming it back
> +		 */
> +		ASSERT_EQ(-1, rename(dir_s4d2, dir_s1d3));
> +		ASSERT_EQ(EXDEV, errno);
> +		/*
> +		 * Including through the now disconnected fd (but it should return
> +		 * EXDEV)
> +		 */
> +		ASSERT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
> +				       file1_s2d2));
> +		ASSERT_EQ(EXDEV, errno);
> +		_exit(!__test_passed(_metadata));

I prefer to use _exit(_metadata->exit_code) for the parent to get the
exit code (which would be printed with the ASSERT/EXPECT if unexpected)
and for consistency with other tests.  I'll change that.

> +		return;
> +	}
> +
> +	ASSERT_NE(-1, child_pid);
> +	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
> +	ASSERT_EQ(1, WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
> +	{
> +		TH_LOG("Failed to rename %s back to %s: %s", dir_s4d1, dir_s1d3,
> +		       strerror(errno));
> +	}
> +
> +	/* Now check that we can access it under l2 */
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		enforce_ruleset(_metadata, ruleset_fd_l2);
> +		ASSERT_EQ(0, close(ruleset_fd_l2));
> +		ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +		ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
> +		_exit(!__test_passed(_metadata));
> +		return;
> +	}
> +	ASSERT_NE(-1, child_pid);
> +	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
> +	ASSERT_EQ(1, WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	/*
> +	 * Also test that we can rename via a disconnected path.  We move the
> +	 * dir back to the disconnected place first, then we rename file1 to
> +	 * file2 through our dir fd.
> +	 */
> +	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
> +	{
> +		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
> +		       strerror(errno));
> +	}
> +	ASSERT_EQ(0,
> +		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name))

Renaming files inside the same directory should always work.  The
following renameat(2) call checks with different directory, as well as
the link tests, so we are good.

> +	{
> +		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
> +		       file1_name, file2_name, bind_dir_s1d3, strerror(errno));
> +	}
> +	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
> +	ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
> +	{
> +		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
> +		       file2_name, file1_s2d2, bind_dir_s1d3, strerror(errno));
> +	}
> +	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
> +	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
> +
> +	/* Move it back using the disconnected path as the target */
> +	ASSERT_EQ(0, renameat(AT_FDCWD, file1_s2d2, bind_s1d3_fd, file1_name))
> +	{
> +		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
> +		       file1_s1d2, file1_name, bind_dir_s1d3, strerror(errno));
> +	}
> +
> +	/* Now make it connected again */
> +	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
> +	{
> +		TH_LOG("Failed to rename %s back to %s: %s", dir_s4d2, dir_s1d3,
> +		       strerror(errno));
> +	}
> +
> +	/* Check again that we can access it under l2 */
> +	enforce_ruleset(_metadata, ruleset_fd_l2);
> +	ASSERT_EQ(0, close(ruleset_fd_l2));
> +	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
> +	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
> +}
> +
>  #define LOWER_BASE TMP_DIR "/lower"
>  #define LOWER_DATA LOWER_BASE "/data"
>  static const char lower_fl1[] = LOWER_DATA "/fl1";
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.49.0
> 
> 

