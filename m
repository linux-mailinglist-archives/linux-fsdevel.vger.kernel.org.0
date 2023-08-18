Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BEF781137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378896AbjHRRGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378886AbjHRRGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:06:18 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8E810C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:06:16 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RS7Yx4rgczMq9pT;
        Fri, 18 Aug 2023 17:06:13 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RS7Yx0LF4z3Z;
        Fri, 18 Aug 2023 19:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692378373;
        bh=veU8UuiuieXnf8zq3eXOrpW58qUrKtaTK5+uzBP4/fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxjIm/gD9EErV441TETRIbFK5UsOIDRdJqs/2yK6k99qX6+zLYC/tNWVkivoxcKTw
         SPtYuQ8RXJFo4uF5r5UFwPmfHuQRFkxFyJ7m/x9wcipKvfp2k4ecKkUiLJyg78ZVwo
         Y1/CicdRhnZmjLkAfLwihZIOQmsnOm1aY7T96kGI=
Date:   Fri, 18 Aug 2023 19:06:07 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/landlock: Test ioctl support
Message-ID: <20230818.HopaLahS0qua@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230814172816.3907299-3-gnoack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814172816.3907299-3-gnoack@google.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:28:13PM +0200, Günther Noack wrote:
> Exercises Landlock's IOCTL feature: If the LANDLOCK_ACCESS_FS_IOCTL
> right is restricted, the use of IOCTL fails with a freshly opened
> file.
> 
> Irrespective of the LANDLOCK_ACCESS_FS_IOCTL right, IOCTL continues to
> work with a selected set of known harmless IOCTL commands.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 96 +++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 09dd1eaac8a9..456bd681091d 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3329,7 +3329,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
>  			      LANDLOCK_ACCESS_FS_WRITE_FILE;
>  	int ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, handled, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> @@ -3412,7 +3412,7 @@ TEST_F_FORK(layout1, truncate)
>  			      LANDLOCK_ACCESS_FS_TRUNCATE;
>  	int ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, handled, rules);
>  
>  	ASSERT_LE(0, ruleset_fd);
> @@ -3639,7 +3639,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
>  	};
>  	int fd, ruleset_fd;
>  
> -	/* Enable Landlock. */
> +	/* Enables Landlock. */
>  	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
>  	ASSERT_LE(0, ruleset_fd);
>  	enforce_ruleset(_metadata, ruleset_fd);
> @@ -3732,6 +3732,96 @@ TEST(memfd_ftruncate)
>  	ASSERT_EQ(0, close(fd));
>  }

We should also check with O_PATH to make sure the correct error is
returned (and not EACCES).

>  
> +/* Invokes the FIOQSIZE ioctl(2) and returns its errno or 0. */
> +static int test_fioqsize_ioctl(int fd)
> +{
> +	loff_t size;
> +
> +	if (ioctl(fd, FIOQSIZE, &size) < 0)
> +		return errno;
> +	return 0;
> +}
> +
> +/*
> + * Attempt ioctls on regular files, with file descriptors opened before and
> + * after landlocking.
> + */
> +TEST_F_FORK(layout1, ioctl)
> +{
> +	const struct rule rules[] = {
> +		{
> +			.path = file1_s1d1,
> +			.access = LANDLOCK_ACCESS_FS_IOCTL,
> +		},
> +		{
> +			.path = dir_s2d1,
> +			.access = LANDLOCK_ACCESS_FS_IOCTL,
> +		},
> +		{},
> +	};
> +	const __u64 handled = LANDLOCK_ACCESS_FS_IOCTL;
> +	int ruleset_fd;
> +	int dir_s1d1_fd, file1_s1d1_fd, dir_s2d1_fd;
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = create_ruleset(_metadata, handled, rules);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	dir_s1d1_fd = open(dir_s1d1, O_RDONLY);

You can use O_CLOEXEC everywhere.

> +	ASSERT_LE(0, dir_s1d1_fd);
> +	file1_s1d1_fd = open(file1_s1d1, O_RDONLY);
> +	ASSERT_LE(0, file1_s1d1_fd);
> +	dir_s2d1_fd = open(dir_s2d1, O_RDONLY);
> +	ASSERT_LE(0, dir_s2d1_fd);
> +
> +	/*
> +	 * Checks that FIOQSIZE works on files where LANDLOCK_ACCESS_FS_IOCTL is
> +	 * permitted.
> +	 */
> +	EXPECT_EQ(EACCES, test_fioqsize_ioctl(dir_s1d1_fd));
> +	EXPECT_EQ(0, test_fioqsize_ioctl(file1_s1d1_fd));
> +	EXPECT_EQ(0, test_fioqsize_ioctl(dir_s2d1_fd));
> +
> +	/* Closes all file descriptors. */
> +	ASSERT_EQ(0, close(dir_s1d1_fd));
> +	ASSERT_EQ(0, close(file1_s1d1_fd));
> +	ASSERT_EQ(0, close(dir_s2d1_fd));
> +}
> +
> +TEST_F_FORK(layout1, ioctl_always_allowed)
> +{
> +	struct landlock_ruleset_attr attr = {

const struct landlock_ruleset_attr attr = {

> +		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL,
> +	};
> +	int ruleset_fd, fd;
> +	int flag = 0;
> +	int n;

const int flag = 0;
int ruleset_fd, test_fd, n;


> +
> +	/* Enables Landlock. */
> +	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	fd = open(file1_s1d1, O_RDONLY);
> +	ASSERT_LE(0, fd);
> +
> +	/* Checks that the restrictable FIOQSIZE is restricted. */
> +	EXPECT_EQ(EACCES, test_fioqsize_ioctl(fd));
> +
> +	/* Checks that unrestrictable commands are unrestricted. */
> +	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
> +	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
> +	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
> +	EXPECT_EQ(0, ioctl(fd, FIONREAD, &n));
> +	EXPECT_EQ(0, n);
> +
> +	ASSERT_EQ(0, close(fd));
> +}
> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
