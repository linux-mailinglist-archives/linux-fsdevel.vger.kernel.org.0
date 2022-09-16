Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFE5BB170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 19:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIPRFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIPRFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:05:51 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07272AC58
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 10:05:48 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MTgSV4MfVzMqk2Q;
        Fri, 16 Sep 2022 19:05:46 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MTgST49NYzMpnPl;
        Fri, 16 Sep 2022 19:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663347946;
        bh=+g0WDxlRJBZqGQK4ZL+TW4WEBNF/nErdboJ3nvBELGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m44kfvGmE3IpvKSHpkAIMcc2nangJCH6DfQ68vokAkL0W4HN1uD1soZMmWGJIskON
         rFgQmx9flRniJExTWLyD0EpS8cO4AIl1ZMaIgtmE+EaesJtcCWXfKnbC7xMSpaK9Jo
         I0642VCJklQbzwFMXl2S1WuQ3llExL3UwnQGO374=
Message-ID: <3f3b7798-c3e1-e257-5094-0033e7605062@digikod.net>
Date:   Fri, 16 Sep 2022 19:05:44 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 3/5] selftests/landlock: Selftests for file truncation
 support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-4-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220908195805.128252-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to have tests similar to base_test.c:ruleset_fd_transfer to 
check ftruncate with different kind of file descriptors and 
not-sandboxed processes. That would require some code refactoring to 
reuse the FD passing code.


On 08/09/2022 21:58, Günther Noack wrote:
> These tests exercise the following truncation operations:
> 
> * truncate() (truncate by path)
> * ftruncate() (truncate by file descriptor)
> * open with the O_TRUNC flag
> * special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.
> 
> in the following scenarios:
> 
> * Files with read, write and truncate rights.
> * Files with read and truncate rights.
> * Files with the truncate right.
> * Files without the truncate right.
> 
> In particular, the following scenarios are enforced with the test:
> 
> * open() with O_TRUNC requires the truncate right, if it truncates a file.
>    open() already checks security_path_truncate() in this case,
>    and it required no additional check in the Landlock LSM's file_open hook.
> * creat() requires the truncate right
>    when called with an existing filename.
> * creat() does *not* require the truncate right
>    when it's creating a new file.
> * ftruncate() requires that the file was opened by a thread that had
>    the truncate right for the file at the time of open(). (The rights
>    are carried along with the opened file.)
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   tools/testing/selftests/landlock/fs_test.c | 280 +++++++++++++++++++++
>   1 file changed, 280 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 87b28d14a1aa..ddc8c7e57e86 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
>   static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
>   
>   static const char dir_s3d1[] = TMP_DIR "/s3d1";
> +static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
>   /* dir_s3d2 is a mount point. */
>   static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
>   static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
> @@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
>    * │           ├── f1
>    * │           └── f2
>    * └── s3d1
> + *     ├── f1
>    *     └── s3d2
>    *         └── s3d3
>    */
> @@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
>   	create_file(_metadata, file1_s2d3);
>   	create_file(_metadata, file2_s2d3);
>   
> +	create_file(_metadata, file1_s3d1);
>   	create_directory(_metadata, dir_s3d2);
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
> @@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
>   	EXPECT_EQ(0, remove_path(file1_s2d2));
>   	EXPECT_EQ(0, remove_path(file1_s2d1));
>   
> +	EXPECT_EQ(0, remove_path(file1_s3d1));
>   	EXPECT_EQ(0, remove_path(dir_s3d3));
>   	set_cap(_metadata, CAP_SYS_ADMIN);
>   	umount(dir_s3d2);
> @@ -3158,6 +3162,282 @@ TEST_F_FORK(layout1, proc_pipe)
>   	ASSERT_EQ(0, close(pipe_fds[1]));
>   }
>   
> +/* Invokes truncate(2) and returns its errno or 0. */
> +static int test_truncate(const char *const path)
> +{
> +	if (truncate(path, 10) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/*
> + * Invokes creat(2) and returns its errno or 0.
> + * Closes the opened file descriptor on success.
> + */
> +static int test_creat(const char *const path)
> +{
> +	int fd = creat(path, 0600);
> +
> +	if (fd < 0)
> +		return errno;
> +
> +	/*
> +	 * Mixing error codes from close(2) and creat(2) should not lead to any
> +	 * (access type) confusion for this test.
> +	 */
> +	if (close(fd) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/*
> + * Exercises file truncation when it's not restricted,
> + * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
> + */
> +TEST_F_FORK(layout1, truncate_unhandled)
> +{
> +	const char *const file_r = file1_s1d1;
> +	const char *const file_w = file2_s1d1;
> +	const char *const file_none = file1_s1d2;
> +	const struct rule rules[] = {
> +		{
> +			.path = file_r,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE,
> +		},
> +		{
> +			.path = file_w,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		/* Implicitly: No rights for file_none. */
> +		{},
> +	};
> +
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE;
> +	int ruleset_fd;
> +
> +	/* Enable Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * Checks read right: truncate and open with O_TRUNC work, unless the
> +	 * file is attempted to be opened for writing.
> +	 */
> +	EXPECT_EQ(0, test_truncate(file_r));
> +	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_creat(file_r));
> +
> +	/*
> +	 * Checks write right: truncate and open with O_TRUNC work, unless the
> +	 * file is attempted to be opened for reading.
> +	 */
> +	EXPECT_EQ(0, test_truncate(file_w));
> +	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_creat(file_w));
> +
> +	/*
> +	 * Checks "no rights" case: truncate works but all open attempts fail,
> +	 * including creat.
> +	 */
> +	EXPECT_EQ(0, test_truncate(file_none));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_creat(file_none));
> +}
> +
> +TEST_F_FORK(layout1, truncate)
> +{
> +	const char *const file_rwt = file1_s1d1;
> +	const char *const file_rw = file2_s1d1;
> +	const char *const file_rt = file1_s1d2;
> +	const char *const file_t = file2_s1d2;
> +	const char *const file_none = file1_s1d3;
> +	const char *const dir_t = dir_s2d1;
> +	const char *const file_in_dir_t = file1_s2d1;
> +	const char *const dir_w = dir_s3d1;
> +	const char *const file_in_dir_w = file1_s3d1;
> +	int file_rwt_fd, file_rw_fd;

These variables are unused now.


> +	const struct rule rules[] = {
> +		{
> +			.path = file_rwt,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file_rw,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{
> +			.path = file_rt,
> +			.access = LANDLOCK_ACCESS_FS_READ_FILE |
> +				  LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = file_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		/* Implicitly: No access rights for file_none. */
> +		{
> +			.path = dir_t,
> +			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
> +		},
> +		{
> +			.path = dir_w,
> +			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +		},
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +			      LANDLOCK_ACCESS_FS_WRITE_FILE |
> +			      LANDLOCK_ACCESS_FS_TRUNCATE;
> +	int ruleset_fd;
> +
> +	/* Enable Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Checks read, write and truncate rights: truncation works. */
> +	EXPECT_EQ(0, test_truncate(file_rwt));
> +	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
> +
> +	/* Checks read and write rights: no truncate variant works. */
> +	EXPECT_EQ(EACCES, test_truncate(file_rw));
> +	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
> +
> +	/*
> +	 * Checks read and truncate rights: truncation works.
> +	 *
> +	 * Note: Files can get truncated using open() even with O_RDONLY.
> +	 */
> +	EXPECT_EQ(0, test_truncate(file_rt));
> +	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY | O_TRUNC));
> +
> +	/* Checks truncate right: truncate works, but can't open file. */
> +	EXPECT_EQ(0, test_truncate(file_t));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
> +
> +	/* Checks "no rights" case: No form of truncation works. */
> +	EXPECT_EQ(EACCES, test_truncate(file_none));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
> +
> +	/*
> +	 * Checks truncate right on directory: truncate works on contained
> +	 * files.
> +	 */
> +	EXPECT_EQ(0, test_truncate(file_in_dir_t));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
> +	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
> +
> +	/*
> +	 * Checks creat in dir_w: This requires the truncate right when
> +	 * overwriting an existing file, but does not require it when the file
> +	 * is new.
> +	 */
> +	EXPECT_EQ(EACCES, test_creat(file_in_dir_w));
> +
> +	ASSERT_EQ(0, unlink(file_in_dir_w));
> +	EXPECT_EQ(0, test_creat(file_in_dir_w));
> +}
> +
> +static void landlock_single_path(struct __test_metadata *const _metadata,
> +				 const char *const path, __u64 handled,
> +				 __u64 permitted)
> +{
> +	const struct rule rules[] = {
> +		{
> +			.path = path,
> +			.access = permitted,
> +		},
> +		{},
> +	};
> +	int ruleset_fd = create_ruleset(_metadata, handled, rules);
> +
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	enforce_ruleset(_metadata, ruleset_fd);
> +
> +	ASSERT_EQ(0, close(ruleset_fd));
> +}
> +
> +/* Invokes ftruncate(2) and returns its errno or 0. */
> +static int test_ftruncate(int fd)
> +{
> +	if (ftruncate(fd, 10) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +TEST_F_FORK(layout1, ftruncate)

Great!

> +{
> +	/*
> +	 * This test opens a new file descriptor at different stages of
> +	 * Landlock restriction:
> +	 *
> +	 * without restriction:                    ftruncate works
> +	 * something else but truncate restricted: ftruncate works
> +	 * truncate restricted and permitted:      ftruncate works
> +	 * truncate restricted and not permitted:  ftruncate fails
> +	 *
> +	 * Whether this works or not is expected to depend on the time when the
> +	 * FD was opened, not to depend on the time when ftruncate() was
> +	 * called.
> +	 */
> +	const char *const path = file1_s1d1;
> +	int fd0, fd1, fd2, fd3;

You can rename them fd_layer0, fd_layer1…


> +
> +	fd0 = open(path, O_WRONLY);
> +	EXPECT_EQ(0, test_ftruncate(fd0));
> +
> +	landlock_single_path(_metadata, path,
> +			     LANDLOCK_ACCESS_FS_READ_FILE |
> +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
> +			     LANDLOCK_ACCESS_FS_WRITE_FILE);

I'd prefer to follow the current way to write rule layers: write all 
struct rule at first and then call each enforcement steps. It is a bit 
more verbose but easier to understand errors. The list of test_ftruncate 
checks are straightforward to follow.


> +
> +	fd1 = open(path, O_WRONLY);
> +	EXPECT_EQ(0, test_ftruncate(fd0));
> +	EXPECT_EQ(0, test_ftruncate(fd1));
> +
> +	landlock_single_path(_metadata, path, LANDLOCK_ACCESS_FS_TRUNCATE,
> +			     LANDLOCK_ACCESS_FS_TRUNCATE);
> +
> +	fd2 = open(path, O_WRONLY);
> +	EXPECT_EQ(0, test_ftruncate(fd0));
> +	EXPECT_EQ(0, test_ftruncate(fd1));
> +	EXPECT_EQ(0, test_ftruncate(fd2));
> +
> +	landlock_single_path(_metadata, path,
> +			     LANDLOCK_ACCESS_FS_TRUNCATE |
> +				     LANDLOCK_ACCESS_FS_WRITE_FILE,
> +			     LANDLOCK_ACCESS_FS_WRITE_FILE);
> +
> +	fd3 = open(path, O_WRONLY);
> +	EXPECT_EQ(0, test_ftruncate(fd0));
> +	EXPECT_EQ(0, test_ftruncate(fd1));
> +	EXPECT_EQ(0, test_ftruncate(fd2));
> +	EXPECT_EQ(EACCES, test_ftruncate(fd3));
> +
> +	ASSERT_EQ(0, close(fd0));
> +	ASSERT_EQ(0, close(fd1));
> +	ASSERT_EQ(0, close(fd2));
> +	ASSERT_EQ(0, close(fd3));
> +}
> +
>   /* clang-format off */
>   FIXTURE(layout1_bind) {};
>   /* clang-format on */
