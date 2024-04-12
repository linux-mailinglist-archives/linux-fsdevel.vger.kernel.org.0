Return-Path: <linux-fsdevel+bounces-16811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C58A3235
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD286B224A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1114A0BF;
	Fri, 12 Apr 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="yUlpEA8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06891487C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935078; cv=none; b=MM5ftd9n+Szk5IuWyWdKmTEDFitF6G7f58LvVW68niXUPb1GN6w/Icjk0vNLFON82/SApbYgfhvNos5Wox9b+LhR85IE2dD6jlLBW6m031/LAsVw2Q6NB1GIhsgsmcVL2E4F2x6xaTqDUp50kxorbCuPwV+hj/lBnI2TcWXmnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935078; c=relaxed/simple;
	bh=QfzhCJgbZEYZ2ZRESTM5rZk7RiPdTt5oz/HzixTxnNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADm9sfhr0vbmNYWu9jeyJAOCkT+cC3DvCI1C7zkQm7Cj2CIkkDhT1ERVPT5KfwwDNKd8NMbyfHefZpZWpxkyoKiJ5PSgnVT3Y8A97b1zJxyoc9S9o8Dwb3FUfk6GlH7TYQwiRkkRbGk3JwTHpHZ7gMxsPou/r9DK2SI3iq3fVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=yUlpEA8C; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VGKtx3tmmz89k;
	Fri, 12 Apr 2024 17:17:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712935065;
	bh=QfzhCJgbZEYZ2ZRESTM5rZk7RiPdTt5oz/HzixTxnNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yUlpEA8CWAAnZ9KANWNsy7iFqaWJRjfP8IGYauB3/dZwsWydJ2HOG3P6J/nsMGAXt
	 3+kQ1Vs6seQDt/1JGryBXNBTJ62aTfAlKxB0bLpaAbEYX0BnNGM4X2fIBCnnZb83AB
	 VnsU9V77yH/OJEiTpGYkSr15ftSSWP9S9kIwKm1w=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VGKtx0XKBzS7Q;
	Fri, 12 Apr 2024 17:17:45 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:17:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 03/12] selftests/landlock: Test IOCTL support
Message-ID: <20240412.ooteCh1thee0@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405214040.101396-4-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 09:40:31PM +0000, Günther Noack wrote:
> Exercises Landlock's IOCTL feature in different combinations of
> handling and permitting the LANDLOCK_ACCESS_FS_IOCTL_DEV right, and in
> different combinations of using files and directories.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 227 ++++++++++++++++++++-
>  1 file changed, 224 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 418ad745a5dd..8a72e26d4977 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c

> +TEST_F_FORK(ioctl, handle_dir_access_file)
> +{
> +	const int flag = 0;
> +	const struct rule rules[] = {
> +		{
> +			.path = "/dev",
> +			.access = variant->allowed,
> +		},
> +		{},
> +	};
> +	int file_fd, ruleset_fd;
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	file_fd = open("/dev/tty", variant->open_mode);

Why /dev/tty? Could we use /dev/null or something less tied to the
current context and less sensitive?

> +	ASSERT_LE(0, file_fd);
> +
> +	/* Checks that IOCTL commands return the expected errors. */
> +	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
> +	EXPECT_EQ(variant->expected_fionread_result,
> +		  test_fionread_ioctl(file_fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
> +	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
> +
> +	ASSERT_EQ(0, close(file_fd));
> +}
> +
> +TEST_F_FORK(ioctl, handle_dir_access_dir)
> +{
> +	const int flag = 0;
> +	const struct rule rules[] = {
> +		{
> +			.path = "/dev",
> +			.access = variant->allowed,
> +		},
> +		{},
> +	};
> +	int dir_fd, ruleset_fd;
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
> +	dir_fd = open("/dev", O_RDONLY);
> +	if (dir_fd < 0)
> +		return;
> +
> +	/*
> +	 * Checks that IOCTL commands return the expected errors.
> +	 * We do not use the expected values from the fixture here.
> +	 *
> +	 * When using IOCTL on a directory, no Landlock restrictions apply.
> +	 * TCGETS will fail anyway because it is not invoked on a TTY device.
> +	 */
> +	EXPECT_EQ(ENOTTY, test_tcgets_ioctl(dir_fd));
> +	EXPECT_EQ(0, test_fionread_ioctl(dir_fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
> +	EXPECT_EQ(0, ioctl(dir_fd, FIGETBSZ, &flag));
> +
> +	ASSERT_EQ(0, close(dir_fd));
> +}
> +
> +TEST_F_FORK(ioctl, handle_file_access_file)
> +{
> +	const int flag = 0;
> +	const struct rule rules[] = {
> +		{
> +			.path = "/dev/tty0",

Same here (and elsewhere), /dev/null or a similar harmless device file
would be better.

> +			.access = variant->allowed,
> +		},
> +		{},
> +	};
> +	int file_fd, ruleset_fd;
> +
> +	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
> +		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
> +			     "can not be granted on files");

Can we avoid using SKIP() in this case?  Tests should only be skipped
when not supported, in other words, we should be able to run all tests
with the right combination of architecture and kernel options.

> +	}
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	file_fd = open("/dev/tty0", variant->open_mode);
> +	ASSERT_LE(0, file_fd)
> +	{
> +		TH_LOG("Failed to open /dev/tty0: %s", strerror(errno));
> +	}
> +
> +	/* Checks that IOCTL commands return the expected errors. */
> +	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
> +	EXPECT_EQ(variant->expected_fionread_result,
> +		  test_fionread_ioctl(file_fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
> +	EXPECT_EQ(0, ioctl(file_fd, FIGETBSZ, &flag));
> +
> +	ASSERT_EQ(0, close(file_fd));
> +}
> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> -- 
> 2.44.0.478.gd926399ef9-goog
> 
> 

