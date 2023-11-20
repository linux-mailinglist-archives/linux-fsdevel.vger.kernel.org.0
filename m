Return-Path: <linux-fsdevel+bounces-3265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF77F1E14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BC31F23710
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838041EA74;
	Mon, 20 Nov 2023 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rwKW20YU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07615CF
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 12:41:29 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYztt1kg6zMq66T;
	Mon, 20 Nov 2023 20:41:26 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYztq5KzYzMpnPf;
	Mon, 20 Nov 2023 21:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1700512886;
	bh=xRfkEdADRqHdSbF919XNTTluDlJy6HnfHgKqS6AIcqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwKW20YUQCp3YHhmpIEScOprNUAB5+vbZo9AkOUrrL9HUfeGdJgRDBsPD/wZ+ExZY
	 nMyM0F8I3XTsCcXe6bZfGb6i96EisbMu9601vee9RFeEjWpQwtxfciZhQfUzSyY5UX
	 4GxrlyqRFqcDuMCVOVPVpMX7PeRcYX0U/aR9+ebM=
Date: Mon, 20 Nov 2023 21:41:20 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] selftests/landlock: Test IOCTL support
Message-ID: <20231120.AejoJ2ooja0i@digikod.net>
References: <20231117154920.1706371-1-gnoack@google.com>
 <20231117154920.1706371-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117154920.1706371-4-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 17, 2023 at 04:49:16PM +0100, Günther Noack wrote:
> Exercises Landlock's IOCTL feature in different combinations of
> handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
> LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
> LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
> files and directories.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 423 ++++++++++++++++++++-
>  1 file changed, 420 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 256cd9a96eb7..564e73087e08 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -9,6 +9,7 @@
>  
>  #define _GNU_SOURCE
>  #include <fcntl.h>
> +#include <linux/fs.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
>  #include <sched.h>
> @@ -3380,7 +3381,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
>  			      LANDLOCK_ACCESS_FS_WRITE_FILE;
>  	int ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, handled, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> @@ -3463,7 +3464,7 @@ TEST_F_FORK(layout1, truncate)
>  			      LANDLOCK_ACCESS_FS_TRUNCATE;
>  	int ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, handled, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> @@ -3690,7 +3691,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
>  	};
>  	int fd, ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
>  	ASSERT_LE(0, ruleset_fd);
>  	enforce_ruleset(_metadata, ruleset_fd);
> @@ -3767,6 +3768,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
>  	ASSERT_EQ(0, close(socket_fds[1]));
>  }
>  
> +/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
> +static int test_fs_ioc_getflags_ioctl(int fd)
> +{
> +	uint32_t flags;
> +
> +	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
> +		return errno;
> +	return 0;
> +}
> +
>  TEST(memfd_ftruncate)
>  {
>  	int fd;
> @@ -3783,6 +3794,412 @@ TEST(memfd_ftruncate)
>  	ASSERT_EQ(0, close(fd));
>  }
>  
> +/* clang-format off */
> +FIXTURE(ioctl) {};
> +/* clang-format on */
> +
> +FIXTURE_SETUP(ioctl)
> +{
> +	prepare_layout(_metadata);
> +	create_file(_metadata, file1_s1d1);
> +}
> +
> +FIXTURE_TEARDOWN(ioctl)
> +{
> +	EXPECT_EQ(0, remove_path(file1_s1d1));
> +	cleanup_layout(_metadata);
> +}
> +
> +FIXTURE_VARIANT(ioctl)
> +{
> +	const __u64 handled;
> +	const __u64 permitted;

Why not "allowed" like the rule's field? Same for the variant names.

> +	const mode_t open_mode;
> +	/*
> +	 * These are the expected IOCTL results for a representative IOCTL from
> +	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
> +	 * results here, and treat other errors as 0.

In this case, why not use a boolean instead of a semi-correct error
code?

> +	 */
> +	const int expected_fioqsize_result; /* G1 */
> +	const int expected_fibmap_result; /* G2 */
> +	const int expected_fionread_result; /* G3 */
> +	const int expected_fs_ioc_zero_range_result; /* G4 */
> +	const int expected_fs_ioc_getflags_result; /* other */
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_none) {

You can remove all the variant's "ioctl_" prefixes.

> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_EXECUTE,

You could use 0 instead and don't add the related rule in this case.

> +	.open_mode = O_RDWR,
> +	.expected_fioqsize_result = EACCES,
> +	.expected_fibmap_result = EACCES,
> +	.expected_fionread_result = EACCES,
> +	.expected_fs_ioc_zero_range_result = EACCES,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_i) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_IOCTL,
> +	.open_mode = O_RDWR,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_unhandled) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_EXECUTE,
> +	.permitted = LANDLOCK_ACCESS_FS_EXECUTE,
> +	.open_mode = O_RDWR,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwd_permitted_r) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
> +	.permitted = LANDLOCK_ACCESS_FS_READ_FILE,
> +	.open_mode = O_RDONLY,
> +	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwd_permitted_w) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.open_mode = O_WRONLY,
> +	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_ri_permitted_r) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_READ_FILE,
> +	.open_mode = O_RDONLY,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = EACCES,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_wi_permitted_w) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.open_mode = O_WRONLY,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = EACCES,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_di_permitted_d) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_READ_DIR,
> +	.open_mode = O_RDWR,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = EACCES,
> +	.expected_fionread_result = EACCES,
> +	.expected_fs_ioc_zero_range_result = EACCES,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_rw) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_READ_FILE |
> +		     LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.open_mode = O_RDWR,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_r) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_READ_FILE,
> +	.open_mode = O_RDONLY,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = EACCES,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_ri) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.open_mode = O_RDONLY,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = 0,
> +	.expected_fs_ioc_zero_range_result = EACCES,
> +	.expected_fs_ioc_getflags_result = 0,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_w) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
> +	.open_mode = O_WRONLY,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = EACCES,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = EACCES,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_wi) {
> +	/* clang-format on */
> +	.handled = LANDLOCK_ACCESS_FS_READ_FILE |
> +		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
> +	.open_mode = O_WRONLY,
> +	.expected_fioqsize_result = 0,
> +	.expected_fibmap_result = 0,
> +	.expected_fionread_result = EACCES,
> +	.expected_fs_ioc_zero_range_result = 0,
> +	.expected_fs_ioc_getflags_result = 0,
> +};

Great tests!

> +
> +static int test_fioqsize_ioctl(int fd)
> +{
> +	size_t sz;
> +
> +	if (ioctl(fd, FIOQSIZE, &sz) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +static int test_fibmap_ioctl(int fd)
> +{
> +	int blk = 0;
> +
> +	/*
> +	 * We only want to distinguish here whether Landlock already caught it,
> +	 * so we treat anything but EACCESS as success.  (It commonly returns
> +	 * EPERM when missing CAP_SYS_RAWIO.)
> +	 */
> +	if (ioctl(fd, FIBMAP, &blk) < 0 && errno == EACCES)
> +		return errno;
> +	return 0;
> +}
> +
> +static int test_fionread_ioctl(int fd)
> +{
> +	size_t sz = 0;
> +
> +	if (ioctl(fd, FIONREAD, &sz) < 0 && errno == EACCES)
> +		return errno;
> +	return 0;
> +}
> +
> +#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
> +
> +static int test_fs_ioc_zero_range_ioctl(int fd)
> +{
> +	struct space_resv {
> +		__s16 l_type;
> +		__s16 l_whence;
> +		__s64 l_start;
> +		__s64 l_len; /* len == 0 means until end of file */
> +		__s32 l_sysid;
> +		__u32 l_pid;
> +		__s32 l_pad[4]; /* reserved area */
> +	} reservation = {};
> +	/*
> +	 * This can fail for various reasons, but we only want to distinguish
> +	 * here whether Landlock already caught it, so we treat anything but
> +	 * EACCES as success.
> +	 */
> +	if (ioctl(fd, FS_IOC_ZERO_RANGE, &reservation) < 0 && errno == EACCES)

What are the guarantees that an error different than EACCES would not
mask EACCES and then make tests pass whereas they should not?

> +		return errno;
> +	return 0;
> +}
> +
> +TEST_F_FORK(ioctl, handle_dir_access_file)
> +{
> +	const int flag = 0;
> +	const struct rule rules[] = {
> +		{
> +			.path = dir_s1d1,
> +			.access = variant->permitted,
> +		},
> +		{},
> +	};
> +	int fd, ruleset_fd;

Please rename fd into something like file_fd.

> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	fd = open(file1_s1d1, variant->open_mode);
> +	ASSERT_LE(0, fd);
> +
> +	/*
> +	 * Checks that IOCTL commands in each IOCTL group return the expected
> +	 * errors.
> +	 */
> +	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
> +		  test_fs_ioc_zero_range_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
> +		  test_fs_ioc_getflags_ioctl(fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
> +
> +	ASSERT_EQ(0, close(fd));
> +}
> +
> +TEST_F_FORK(ioctl, handle_dir_access_dir)
> +{
> +	const char *const path = dir_s1d1;
> +	const int flag = 0;
> +	const struct rule rules[] = {
> +		{
> +			.path = path,
> +			.access = variant->permitted,
> +		},
> +		{},
> +	};
> +	int fd, ruleset_fd;
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * Ignore variant->open_mode for this test, as we intend to open a
> +	 * directory.  If the directory can not be opened, the variant is
> +	 * infeasible to test with an opened directory.
> +	 */
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return;
> +
> +	/*
> +	 * Checks that IOCTL commands in each IOCTL group return the expected
> +	 * errors.
> +	 */
> +	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
> +		  test_fs_ioc_zero_range_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
> +		  test_fs_ioc_getflags_ioctl(fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
> +
> +	ASSERT_EQ(0, close(fd));
> +}
> +
> +TEST_F_FORK(ioctl, handle_file_access_file)
> +{
> +	const char *const path = file1_s1d1;
> +	const int flag = 0;
> +	const struct rule rules[] = {
> +		{
> +			.path = path,
> +			.access = variant->permitted,
> +		},
> +		{},
> +	};
> +	int fd, ruleset_fd;
> +
> +	if (variant->permitted & LANDLOCK_ACCESS_FS_READ_DIR) {
> +		/* This access right can not be granted on files. */
> +		return;
> +	}

You should use SKIP().

> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	fd = open(path, variant->open_mode);
> +	ASSERT_LE(0, fd);
> +
> +	/*
> +	 * Checks that IOCTL commands in each IOCTL group return the expected
> +	 * errors.
> +	 */
> +	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
> +		  test_fs_ioc_zero_range_ioctl(fd));
> +	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
> +		  test_fs_ioc_getflags_ioctl(fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
> +
> +	ASSERT_EQ(0, close(fd));
> +}

Don't you want to create and use a common helper with most of these
TEST_F_FORK blocks? It would highlight what is the same or different,
and it would also enables to extend the coverage to other file types
(e.g. character device).

> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

