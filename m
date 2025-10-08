Return-Path: <linux-fsdevel+bounces-63620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D261BC6C28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 00:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D56E4E4832
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54322C1597;
	Wed,  8 Oct 2025 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh7itxjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A53221FDA;
	Wed,  8 Oct 2025 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961381; cv=none; b=m/lGBIwgAwbgJVjIFgrBYB5DC1p5zibwZGn0j61gPn4cEOGQS+Ymf86R24gDOXSvL9burQn9OsqjoAFjlOKbMwV5BGDitvS5+6U+zYqalssm5E2nbRh9YvawNCFJjglwGYyGmBUyFzbda/+g6/XJFpzAo7jS12m37/oddHtnkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961381; c=relaxed/simple;
	bh=tjoL8DPttIC6yxJYjGYZmdTZmlKaUXVFyWCT4sRmGzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSTXrpiqqZ/RxoNfIn5YVLWCDpvIW+fhI0kPasm4nYXyUrHkThikg/byBB/0RZe3/F0egCPTSeCx0QE1EC9kB38eB/WddAQ3+Crqq/WlAMyJcFL9Bw0mPMrNmsG5IBXgAGQXPzBCzQ0uvuOnLgi5Z4iVINzDLt+N6M+BD3irZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh7itxjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3516C4CEF8;
	Wed,  8 Oct 2025 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759961380;
	bh=tjoL8DPttIC6yxJYjGYZmdTZmlKaUXVFyWCT4sRmGzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nh7itxjW9R8ymgo6j1ZCYDwyQlZ3UODIeUuVu8sCcYOKJ8sMi1e2v3EfT/AFbYUNR
	 cCSKqnHwY0cke0oZwnXi4qPJk9ixhP112SW3TpkqQXcqtYhgOYxINYXW3faR4B8GsC
	 c8dHYsDJKfYAhzR72IsqMRSLHhitWE23x5/08NvPP0wNQXGKzPtpQP8HWHJt60EQNL
	 AmtMbAPO8fE2jMt0CzPpvNKxay265oCOFCrmrsR3Hq7nlANDavCtMLlrICYxRoUjgJ
	 Eeqn674jnHmAFIz01TT64U/Fm5u93Vh5/idt6sH8J/wzyFdiXzqg+H9pXTskka2bQD
	 0M1K7z5HmU54w==
Date: Wed, 8 Oct 2025 15:09:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
	joannelkoong@gmail.com
Subject: Re: [PATCH 10/10] libext2fs: add posix advisory locking to the unix
 IO manager
Message-ID: <20251008220940.GB6170@frogsfrogsfrogs>
References: <175798161283.390072.8565583077948994821.stgit@frogsfrogsfrogs>
 <175798161504.390072.1450648323017490117.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175798161504.390072.1450648323017490117.stgit@frogsfrogsfrogs>

On Mon, Sep 15, 2025 at 05:58:43PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add support for using flock() to protect the files opened by the Unix IO
> manager so that we can't mount the same fs multiple times.  This also
> prevents systemd and udev from accessing the device while e2fsprogs is
> doing something with the device.
> 
> Link: https://systemd.io/BLOCK_DEVICE_LOCKING/
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

This actually causes a lot of problems with fstests -- if fuse2fs
flock()s the block device, then udevd will spin in a slow trylock loop
until the bdev can be locked.  Meanwhile, any scripts calling udevadm
settle will block until fuse2fs exits (or it gives up after 2 minutes go
by), because udev still has a uevent that it cannot settle.  This causes
any test that uses udevadm settle to take forever to run.

In general, we don't want to block udev from reading the block device
while fuse2fs has it mounted.  For block devices this is unnecessary
anyway because we have O_EXCL.

However, the advisory locking is still useful for coordinating access to
filesystem images in regular files, so I'll rework this to only do it
for regular files.

--D

> ---
>  lib/ext2fs/unix_io.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> 
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index 068be689326443..55007ad7d2ae15 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -65,6 +65,12 @@
>  #include <pthread.h>
>  #endif
>  
> +#if defined(HAVE_SYS_FILE_H) && defined(HAVE_SIGNAL_H)
> +# include <sys/file.h>
> +# include <signal.h>
> +# define WANT_LOCK_UNIX_FD
> +#endif
> +
>  #if defined(__linux__) && defined(_IO) && !defined(BLKROGET)
>  #define BLKROGET   _IO(0x12, 94) /* Get read-only status (0 = read_write).  */
>  #endif
> @@ -149,6 +155,9 @@ struct unix_private_data {
>  	pthread_mutex_t bounce_mutex;
>  	pthread_mutex_t stats_mutex;
>  #endif
> +#ifdef WANT_LOCK_UNIX_FD
> +	int	lock_flags;
> +#endif
>  };
>  
>  #define IS_ALIGNED(n, align) ((((uintptr_t) n) & \
> @@ -897,6 +906,47 @@ int ext2fs_fstat(int fd, ext2fs_struct_stat *buf)
>  #endif
>  }
>  
> +#ifdef WANT_LOCK_UNIX_FD
> +static void unix_lock_alarm_handler(int signal, siginfo_t *data, void *p)
> +{
> +	/* do nothing, the signal will abort the flock operation */
> +}
> +
> +static int unix_lock_fd(int fd, int flags)
> +{
> +	struct sigaction newsa = {
> +		.sa_flags = SA_SIGINFO,
> +		.sa_sigaction = unix_lock_alarm_handler,
> +	};
> +	struct sigaction oldsa;
> +	const int operation = (flags & IO_FLAG_EXCLUSIVE) ? LOCK_EX : LOCK_SH;
> +	int ret;
> +
> +	/* wait five seconds for the lock */
> +	ret = sigaction(SIGALRM, &newsa, &oldsa);
> +	if (ret)
> +		return ret;
> +
> +	alarm(5);
> +
> +	ret = flock(fd, operation);
> +	if (ret == 0)
> +		ret = operation;
> +	else if (errno == EINTR) {
> +		errno = EWOULDBLOCK;
> +		ret = -1;
> +	}
> +
> +	alarm(0);
> +	sigaction(SIGALRM, &oldsa, NULL);
> +	return ret;
> +}
> +
> +static void unix_unlock_fd(int fd)
> +{
> +	flock(fd, LOCK_UN);
> +}
> +#endif
>  
>  static errcode_t unix_open_channel(const char *name, int fd,
>  				   int flags, io_channel *channel,
> @@ -935,6 +985,16 @@ static errcode_t unix_open_channel(const char *name, int fd,
>  	if (retval)
>  		goto cleanup;
>  
> +#ifdef WANT_LOCK_UNIX_FD
> +	if (flags & IO_FLAG_RW) {
> +		data->lock_flags = unix_lock_fd(fd, flags);
> +		if (data->lock_flags < 0) {
> +			retval = errno;
> +			goto cleanup;
> +		}
> +	}
> +#endif
> +
>  	strcpy(io->name, name);
>  	io->private_data = data;
>  	io->block_size = 1024;
> @@ -1200,6 +1260,10 @@ static errcode_t unix_close(io_channel channel)
>  	if (retval2 && !retval)
>  		retval = retval2;
>  
> +#ifdef WANT_LOCK_UNIX_FD
> +	if (data->lock_flags)
> +		unix_unlock_fd(data->dev);
> +#endif
>  	if (close(data->dev) < 0 && !retval)
>  		retval = errno;
>  	free_cache(data);
> 
> 

