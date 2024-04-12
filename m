Return-Path: <linux-fsdevel+bounces-16813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777888A3237
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0F2281C8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F9C148313;
	Fri, 12 Apr 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WEF5nnlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F319147C7B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935099; cv=none; b=eS3+trWm+PYA+4Osm7y1/v5O7P4jK8d4BC0znIs9Kk66Mf5N3q9IIzqsR6itf8et9Tk46rtfmnYJCQMire1sfqso9RmjUhmvzmc7NbATObCgh0V42Qza9remM1xza/xbarwFhbvTs088zxTxBFNQIBXTWGYCa/1Q2QGZfuYozvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935099; c=relaxed/simple;
	bh=2annsvWE9nme1Cfdg3mo6FhY1Mt/bx49noMHjngQSsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y09eTurU+9iorRo/ANPHQHtSdPUUZi5GPsNRfwcl41PtwZ9pwrlYF9FkgNd6yiBKox2pLshauj79o4VeMsS0bzqRVmWK8LQuZuyZQhmzmCM0xga0EgL/6O5qRCDsBS1Romse+opbpFlMUkZeU3L376/8iQdgaleV8puhbryyMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WEF5nnlG; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VGKvM5xXHz8mY;
	Fri, 12 Apr 2024 17:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712935087;
	bh=2annsvWE9nme1Cfdg3mo6FhY1Mt/bx49noMHjngQSsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEF5nnlGUVTvVjNxE8fkhRpUY11UbobTBJ6RqhO8LsCVI8uPAqcOuK9R3Eo7sb2kp
	 17HIYVKj+80ylZIuxAlbLMv6ukRGA/jnpfnGAUVK/p7+9jtYe9LqP5KbrFs3OeYV4j
	 xTjnYgsT1+KNXn7hyd4+TjxD7uv06RfGI1kQstdU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VGKvL6S5mzSK5;
	Fri, 12 Apr 2024 17:18:06 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:18:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 08/12] selftests/landlock: Exhaustive test for the
 IOCTL allow-list
Message-ID: <20240412.soo4theeseeY@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-9-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405214040.101396-9-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 09:40:36PM +0000, Günther Noack wrote:
> This test checks all IOCTL commands implemented in do_vfs_ioctl().
> 
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 10b29a288e9c..e4ba149cf6fd 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -10,6 +10,7 @@
>  #define _GNU_SOURCE
>  #include <asm/termbits.h>
>  #include <fcntl.h>
> +#include <linux/fiemap.h>
>  #include <linux/landlock.h>
>  #include <linux/magic.h>
>  #include <sched.h>
> @@ -3937,6 +3938,100 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
>  	ASSERT_EQ(0, close(fd));
>  }
>  
> +/*
> + * ioctl_error - generically call the given ioctl with a pointer to a
> + * sufficiently large memory region
> + *
> + * Returns the IOCTLs error, or 0.
> + */
> +static int ioctl_error(int fd, unsigned int cmd)
> +{
> +	char buf[1024]; /* sufficiently large */

Could we shrink a bit this buffer?

> +	int res = ioctl(fd, cmd, &buf);
> +
> +	if (res < 0)
> +		return errno;
> +
> +	return 0;
> +}
> +
> +/* Define some linux/falloc.h IOCTL commands which are not available in uapi headers. */
> +struct space_resv {
> +	__s16 l_type;
> +	__s16 l_whence;
> +	__s64 l_start;
> +	__s64 l_len; /* len == 0 means until end of file */
> +	__s32 l_sysid;
> +	__u32 l_pid;
> +	__s32 l_pad[4]; /* reserved area */
> +};
> +
> +#define FS_IOC_RESVSP _IOW('X', 40, struct space_resv)
> +#define FS_IOC_UNRESVSP _IOW('X', 41, struct space_resv)
> +#define FS_IOC_RESVSP64 _IOW('X', 42, struct space_resv)
> +#define FS_IOC_UNRESVSP64 _IOW('X', 43, struct space_resv)
> +#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
> +
> +/*
> + * Tests a series of blanket-permitted and denied IOCTLs.
> + */
> +TEST_F_FORK(layout1, blanket_permitted_ioctls)
> +{
> +	const struct landlock_ruleset_attr attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +	};
> +	int ruleset_fd, fd;
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	fd = open("/dev/null", O_RDWR | O_CLOEXEC);
> +	ASSERT_LE(0, fd);
> +
> +	/*
> +	 * Checks permitted commands.
> +	 * These ones may return errors, but should not be blocked by Landlock.
> +	 */
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIOCLEX));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIONCLEX));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIONBIO));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIOASYNC));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIOQSIZE));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIFREEZE));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FITHAW));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_FIEMAP));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIGETBSZ));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FICLONE));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FICLONERANGE));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FIDEDUPERANGE));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSUUID));
> +	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));

Could we check for ENOTTY instead of !EACCES? /dev/null should be pretty
stable.

> +
> +	/*
> +	 * Checks blocked commands.
> +	 * A call to a blocked IOCTL command always returns EACCES.
> +	 */
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FIONREAD));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_GETFLAGS));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_SETFLAGS));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_FSGETXATTR));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_FSSETXATTR));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FIBMAP));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_RESVSP));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_RESVSP64));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_UNRESVSP));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_UNRESVSP64));
> +	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_ZERO_RANGE));

Good!

> +
> +	/* Default case is also blocked. */
> +	EXPECT_EQ(EACCES, ioctl_error(fd, 0xc00ffeee));
> +
> +	ASSERT_EQ(0, close(fd));
> +}
> +
>  /*
>   * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
>   * because they are not character or block devices.
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

