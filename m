Return-Path: <linux-fsdevel+bounces-31317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970729947C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82DE1C24F05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968631DE894;
	Tue,  8 Oct 2024 11:51:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAC1D8DF6;
	Tue,  8 Oct 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388317; cv=none; b=UFsURpltYMXq+1GjgOAau/0Rh+yqJIx2/Nu7Ljfv7TGU9UzWBV5slPu9WJ0vE7iMsZcN7cNJNKxd6M2q1PgxWlo8IL7ih+CyQVEQQ+NHr/8MtMbGAMmQeXmtEm5hRHb1AYVGya/ziw2KAQTdfosOdOB88uRKJ8GKaMQCHY+7a6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388317; c=relaxed/simple;
	bh=pD1UuK9TzGO7wHfJxW6KD6klX9AkmnYXRgKL2KM14/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL6/6T+O927XVr3jSQzGSuGIpfCDnjzTpRZ+h++s1DK4KlvWSmHIkbiI1fLI15vriOZpjbFrlFsLSkKWS2BMNnvenXydLcK+HlqA8sX+KJjwBQiNMRFzu7bmuYnazQewTMc2zixhnKaCMFQFceC4LnOjtvLIzDp/h9QEGzUZBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id D4F82E8010A;
	Tue,  8 Oct 2024 13:41:43 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 2D95A1601D0; Tue,  8 Oct 2024 13:41:40 +0200 (CEST)
Date: Tue, 8 Oct 2024 13:41:40 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fcntl: make F_DUPFD_QUERY associative
Message-ID: <ZwUac8RIaV0E4Jwa@gardel-login>
References: <20241008-duften-formel-251f967602d5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-duften-formel-251f967602d5@brauner>

On Di, 08.10.24 13:30, Christian Brauner (brauner@kernel.org) wrote:

> Currently when passing a closed file descriptor to
> fcntl(fd, F_DUPFD_QUERY, fd_dup) the order matters:
>
>     fd = open("/dev/null");
>     fd_dup = dup(fd);
>
> When we now close one of the file descriptors we get:
>
>     (1) fcntl(fd, fd_dup) // -EBADF
>     (2) fcntl(fd_dup, fd) // 0 aka not equal
>
> depending on which file descriptor is passed first. That's not a huge
> deal but it gives the api I slightly weird feel. Make it so that the
> order doesn't matter by requiring that both file descriptors are valid:
>
> (1') fcntl(fd, fd_dup) // -EBADF
> (2') fcntl(fd_dup, fd) // -EBADF
>
> Fixes: c62b758bae6a ("fcntl: add F_DUPFD_QUERY fcntl()")
> Cc: <stable@vger.kernel.org>
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fcntl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 22dd9dcce7ec..3d89de31066a 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -397,6 +397,9 @@ static long f_dupfd_query(int fd, struct file *filp)
>  {
>  	CLASS(fd_raw, f)(fd);
>
> +	if (fd_empty(f))
> +		return -EBADF;
> +
>  	/*
>  	 * We can do the 'fdput()' immediately, as the only thing that
>  	 * matters is the pointer value which isn't changed by the fdput.

Thanks! LGTM!

Reviewed-By: Lennart Poettering <lennart@poettering.net>

Lennart

--
Lennart Poettering, Berlin

