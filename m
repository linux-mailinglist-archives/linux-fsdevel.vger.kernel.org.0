Return-Path: <linux-fsdevel+bounces-16812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF498A3236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD21C2304A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3902814A4D1;
	Fri, 12 Apr 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BKN7guZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F39146D57;
	Fri, 12 Apr 2024 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935081; cv=none; b=QUxKnJ5HyafF0m+8oLdPX3MHiLw9P7aP66PA5TY9+I8COUbcrplFKnlxdeAEhfxzOdK0L+Kik9N0YrCxkRFUYsNWHK17MED7E4Zo4QxQ3mrDASSmTPxlmV8HGVe8ouNZODhU3SwZXF6CGkfs+TkispYvWdtB4QMhGRY3Fd7LySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935081; c=relaxed/simple;
	bh=/X9CGrnasVAYurSboZHSVBugYq0Us45DyJpHwCyHgXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf2eoB+IevMFCWZAQt61ElUWVPc7vl4gNiSYW1/wR6jeqgYYR7J/TXyOmLOqsYhj8+VJGMlki7Ihiw2P5jYiBST5rndNSqEaQvcIF+mrEz2eKjcgv2w2MFJJkII+gUr38Dvr2rzzFqKlEMeJSk70IoBwLXLS+Z1qKKzBjW+SZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BKN7guZi; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VGKv769GZz7mx;
	Fri, 12 Apr 2024 17:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712935075;
	bh=/X9CGrnasVAYurSboZHSVBugYq0Us45DyJpHwCyHgXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKN7guZiClrjCtpJY/vxf9CXZZnOTXOzqOQ6ltWtXK2xIUoeaviZk4cf4TZAJG61y
	 T4J6zTIhELW2zzLTp9fPoF1yc/BRZDaULX/VCyXY5m0Yp6UvF80vtBBEE/7A2LrOeX
	 wFHFgYb3ZdJl0MQ3JA/KMIog4YG7VQ2D47pOPp6U=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VGKv72FS9zlQY;
	Fri, 12 Apr 2024 17:17:55 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:17:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 07/12] selftests/landlock: Check IOCTL restrictions
 for named UNIX domain sockets
Message-ID: <20240412.IKoh6rius5ye@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405214040.101396-8-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Apr 05, 2024 at 09:40:35PM +0000, Günther Noack wrote:

Please add a small patch description.  You can list the name of the
test.

> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 215f0e8bcd69..10b29a288e9c 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -20,8 +20,10 @@
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/sendfile.h>
> +#include <sys/socket.h>
>  #include <sys/stat.h>
>  #include <sys/sysmacros.h>
> +#include <sys/un.h>
>  #include <sys/vfs.h>
>  #include <unistd.h>
>  
> @@ -3978,6 +3980,55 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
>  	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
>  }
>  
> +/* For named UNIX domain sockets, no IOCTL restrictions apply. */
> +TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> +{
> +	const char *const path = file1_s1d1;
> +	int srv_fd, cli_fd, ruleset_fd;
> +	socklen_t size;
> +	struct sockaddr_un srv_un, cli_un;
> +	const struct landlock_ruleset_attr attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_IOCTL_DEV,
> +	};
> +
> +	/* Sets up a server */
> +	srv_un.sun_family = AF_UNIX;
> +	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
> +
> +	ASSERT_EQ(0, unlink(path));
> +	ASSERT_LE(0, (srv_fd = socket(AF_UNIX, SOCK_STREAM, 0)));

I'd prefer not to have this kind of assignment and check at the same
time.

> +
> +	size = offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path);
> +	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
> +	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
> +
> +	/* Enables Landlock. */
> +	ruleset_fd = landlock_create_ruleset(&attr, sizeof(attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/* Sets up a client connection to it */
> +	cli_un.sun_family = AF_UNIX;
> +
> +	ASSERT_LE(0, (cli_fd = socket(AF_UNIX, SOCK_STREAM, 0)));

Same here.

> +
> +	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
> +	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
> +
> +	bzero(&cli_un, sizeof(cli_un));
> +	cli_un.sun_family = AF_UNIX;
> +	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
> +	size = offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path);
> +
> +	ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&cli_un, size));
> +
> +	/* FIONREAD and other IOCTLs should not be forbidden. */
> +	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
> +
> +	ASSERT_EQ(0, close(cli_fd));
> +}
> +
>  /* clang-format off */
>  FIXTURE(ioctl) {};
>  
> -- 
> 2.44.0.478.gd926399ef9-goog
> 
> 

