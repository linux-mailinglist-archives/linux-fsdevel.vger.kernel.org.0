Return-Path: <linux-fsdevel+bounces-40770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E26A274D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C6B7A4156
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8C2139CE;
	Tue,  4 Feb 2025 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvAVUreY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088A20C014;
	Tue,  4 Feb 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680538; cv=none; b=HWS9S/hum/yooX/4eL5/j29mPTPM0g0Asq6hTQ99b6tcMHheTGFzxhi//s27mPL5pJUmjijrJU9ctsJwef1GcZs4JDfgn5bd5Q8MkjIGhXff0y5DsuYZpENEbgQnKn+HgIgx+XLz58Iyw7AkD9WHc+rfjW/HZx3/FfGAgrmNfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680538; c=relaxed/simple;
	bh=8UPki2O89znKK64fQOKi00U1JhOnxcQxvDewxo2cwkA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0dxuQhINGMkyBOrCcRm9X4vgTqPvYHfFZbQgMXF90CSQLp9pkkygHRPA9VlEmodXoY2KSd/qvQajEt6rjGvr7KmSoitYNO0RtlLCZ/Y5gL1a9KiG4M1He/QI7QEP0n/l24ZBU3Q2xAPtk0t5sAtx7niGdKyDU8mOLh6T8d8Jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvAVUreY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE5EC4CEDF;
	Tue,  4 Feb 2025 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680537;
	bh=8UPki2O89znKK64fQOKi00U1JhOnxcQxvDewxo2cwkA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TvAVUreYdkXXN2V15uobIUlY51bO9tIunH5XkK6TDQ4Yajq+E3BHaGvaYHDRW+hq5
	 2ssRy3p7otaN5x6CtQDtqIPi+fWyCev8ev1/pYDEzUFir2dTWQ8aUP6qO8HuK1y1q5
	 9FLCA7fHdG1JLl6NgocIOEV0xFgpfEjuArrSoaInFqekTJeyz8dPyUPKAfYySxlAt8
	 MJwSOnh9zBmp/6FZ480na8uFIDZnmTuKdKFDYhC5E1i/G0HQD/XNAeVBkZMeunANts
	 HG8DZBEJXW4b86gUPVeLogLgaQYLC0OSXKIb7okrT5+voPxRteZwGYjmvRkIpyvgjH
	 V+Yxi7RDy477Q==
Message-ID: <5687dcbf58279aa719224c25c887041d2f5a367e.camel@kernel.org>
Subject: Re: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
From: Jeff Layton <jlayton@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
  Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, "Gautham R. Shenoy"	
 <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Mateusz
 Guzik <mjguzik@gmail.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Oliver Sang	 <oliver.sang@intel.com>, Swapnil Sapkal
 <swapnil.sapkal@amd.com>, WangYuli	 <wangyuli@uniontech.com>,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 09:48:55 -0500
In-Reply-To: <20250204132153.GA20921@redhat.com>
References: <20250204132153.GA20921@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 14:21 +0100, Oleg Nesterov wrote:
> These numbers are visible in fstat() but hopefully nobody uses this
> information and file_accessed/file_update_time are not that cheap.
> Stupid test-case:
>=20
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <unistd.h>
> 	#include <assert.h>
> 	#include <sys/ioctl.h>
> 	#include <sys/time.h>
>=20
> 	static char buf[17 * 4096];
> 	static struct timeval TW, TR;
>=20
> 	int wr(int fd, int size)
> 	{
> 		int c, r;
> 		struct timeval t0, t1;
>=20
> 		gettimeofday(&t0, NULL);
> 		for (c =3D 0; (r =3D write(fd, buf, size)) > 0; c +=3D r);
> 		gettimeofday(&t1, NULL);
> 		timeradd(&TW, &t1, &TW);
> 		timersub(&TW, &t0, &TW);
>=20
> 		return c;
> 	}
>=20
> 	int rd(int fd, int size)
> 	{
> 		int c, r;
> 		struct timeval t0, t1;
>=20
> 		gettimeofday(&t0, NULL);
> 		for (c =3D 0; (r =3D read(fd, buf, size)) > 0; c +=3D r);
> 		gettimeofday(&t1, NULL);
> 		timeradd(&TR, &t1, &TR);
> 		timersub(&TR, &t0, &TR);
>=20
> 		return c;
> 	}
>=20
> 	int main(int argc, const char *argv[])
> 	{
> 		int fd[2], nb =3D 1, loop, size;
>=20
> 		assert(argc =3D=3D 3);
> 		loop =3D atoi(argv[1]);
> 		size =3D atoi(argv[2]);
>=20
> 		assert(pipe(fd) =3D=3D 0);
> 		assert(ioctl(fd[0], FIONBIO, &nb) =3D=3D 0);
> 		assert(ioctl(fd[1], FIONBIO, &nb) =3D=3D 0);
>=20
> 		assert(size <=3D sizeof(buf));
> 		while (loop--)
> 			assert(wr(fd[1], size) =3D=3D rd(fd[0], size));
>=20
> 		struct timeval tt;
> 		timeradd(&TW, &TR, &tt);
> 		printf("TW =3D %lu.%03lu TR =3D %lu.%03lu TT =3D %lu.%03lu\n",
> 			TW.tv_sec, TW.tv_usec/1000,
> 			TR.tv_sec, TR.tv_usec/1000,
> 			tt.tv_sec, tt.tv_usec/1000);
>=20
> 		return 0;
> 	}
>=20
> Before:
> 	# for i in 1 2 3; do /host/tmp/test 10000 100; done
> 	TW =3D 8.047 TR =3D 5.845 TT =3D 13.893
> 	TW =3D 8.091 TR =3D 5.872 TT =3D 13.963
> 	TW =3D 8.083 TR =3D 5.885 TT =3D 13.969
> After:
> 	# for i in 1 2 3; do /host/tmp/test 10000 100; done
> 	TW =3D 4.752 TR =3D 4.664 TT =3D 9.416
> 	TW =3D 4.684 TR =3D 4.608 TT =3D 9.293
> 	TW =3D 4.736 TR =3D 4.652 TT =3D 9.388
>=20
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/pipe.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 94b59045ab44..baaa8c0817f1 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -247,6 +247,11 @@ static inline unsigned int pipe_update_tail(struct p=
ipe_inode_info *pipe,
>  	return tail;
>  }
> =20
> +static inline bool is_pipe_inode(struct inode *inode)
> +{
> +	return inode->i_sb->s_magic =3D=3D PIPEFS_MAGIC;
> +}
> +
>  static ssize_t
>  pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  {
> @@ -404,7 +409,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  	if (wake_next_reader)
>  		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM)=
;
>  	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -	if (ret > 0)
> +	if (ret > 0 && !is_pipe_inode(file_inode(filp)))

pipe_read and pipe_write are the read_iter / write_iter ops for pipefs
inodes. Is there ever a situation where is_pipe_inode() will be false
here?

>  		file_accessed(filp);
>  	return ret;
>  }
> @@ -604,11 +609,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *fro=
m)
>  	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>  	if (wake_next_writer)
>  		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM=
);
> -	if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
> -		int err =3D file_update_time(filp);
> -		if (err)
> -			ret =3D err;
> -		sb_end_write(file_inode(filp)->i_sb);
> +	if (ret > 0 && !is_pipe_inode(file_inode(filp))) {

Ditto.

> +		if (sb_start_write_trylock(file_inode(filp)->i_sb)) {
> +			int err =3D file_update_time(filp);
> +			if (err)
> +				ret =3D err;
> +			sb_end_write(file_inode(filp)->i_sb);
> +		}
>  	}
>  	return ret;
>  }
> @@ -1108,7 +1115,7 @@ static void wake_up_partner(struct pipe_inode_info =
*pipe)
>  static int fifo_open(struct inode *inode, struct file *filp)
>  {
>  	struct pipe_inode_info *pipe;
> -	bool is_pipe =3D inode->i_sb->s_magic =3D=3D PIPEFS_MAGIC;
> +	bool is_pipe =3D is_pipe_inode(inode);

Same here: In what case is is_pipe() ever false here?

>  	int ret;
> =20
>  	filp->f_pipe =3D 0;

--=20
Jeff Layton <jlayton@kernel.org>

