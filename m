Return-Path: <linux-fsdevel+bounces-17277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF18AA806
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 07:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75539B23B68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05883BE4B;
	Fri, 19 Apr 2024 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sqkHsw3l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6761EC121
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 05:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505454; cv=none; b=F7xf55iweO97KiteAeeOU+cfWpA1bJ4ZFWIL8d8lgArxixHRsZSoccWTtqvyUW+09AABmjj9S93h2lGIiFt5/HV+SfPeSgJWULp46r3efuNxSV5ca8yF2UwnAfMXkAHDQ1AbTj3fXeb0NIKSJ1tKf6W0TY7pU9FMNvs9LjuQD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505454; c=relaxed/simple;
	bh=Hx4XvqG0DwG+3cJanyl92buUPACl9Vo4TjC/NT1ol9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdtGLVDZcyrTdj6Y18tbE3Ue91cMff94Ma4hStSiOfY0NlkkXjXJYvqj/PAYRQQPcvvMUOiFJDZPGFF4ao9jBIII8CAvoYVru4Wzq0eiiYS/lKp1tamyklM5W98dOqg+fzVb6lOemdKMY4r0+5aKZQhkNtY/7M49xSXeNBf+l0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sqkHsw3l; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VLNqk3qZ2zvwF;
	Fri, 19 Apr 2024 07:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1713505442;
	bh=Hx4XvqG0DwG+3cJanyl92buUPACl9Vo4TjC/NT1ol9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqkHsw3lxfCiigW38E8Gq066X0XC1dIB988HgWwPKGW/QJJaVP7NYQucOSiUQfIyo
	 kIt5L9BNHYOBd4aK3E4oHcnBbtjC8vhrZgIGOpJ/nJlM+x0Cy+wyciB+kCWMNYJWcK
	 GCZf0SFkyT//ODkdceO4xz6uVbAG7XUj0FK7cWK4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VLNqj3cBzz4L;
	Fri, 19 Apr 2024 07:44:01 +0200 (CEST)
Date: Thu, 18 Apr 2024 22:44:00 -0700
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 03/12] selftests/landlock: Test IOCTL support
Message-ID: <20240418.haet6ahfieH2@digikod.net>
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

> @@ -3831,6 +3842,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
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

test_fs_ioc_getflags_ioctl() should be moved to the next patch where it
is used.

