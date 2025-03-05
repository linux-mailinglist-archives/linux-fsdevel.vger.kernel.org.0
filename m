Return-Path: <linux-fsdevel+bounces-43284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E8A50893
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89533A4797
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB912250C1F;
	Wed,  5 Mar 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvaqYHG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC419E7D1;
	Wed,  5 Mar 2025 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198114; cv=none; b=cMMRv3KsvndO/9VBfjDzyLEE+WaA1fqTsJFcZ5AGmaQJ6Xabo7npmDGQudhXlQoo+GcRgylfimxO5yV8u6vNG8SRYcLwr5zh3Au0bnOvj7V+dcz+FaHU9FXgdnZmUgiyacUpfnPPxQ+luAPHyOBHwxX9sn0iHYkaJMOnphAnqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198114; c=relaxed/simple;
	bh=7moQa4zJu5xbGr+oCzyNVTbWhDopHAXqqNKqg0wItKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+yeh38XUKfnjt0Q6XCmURxmBn3c/bqGsGQB9uYPmLpO4XzbZ4ECpA/9TEnxuiZ99YG4zTQiKAx92IX07e8V6Z3HzqblkuU9ctq90oNmkfEoUAzKqwan/xWV0/ArmSLuGZOwnj4Ls+Tl6OoYj70r8VeqI2csiU/oGxPfhd052A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvaqYHG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8E5C4CED1;
	Wed,  5 Mar 2025 18:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198113;
	bh=7moQa4zJu5xbGr+oCzyNVTbWhDopHAXqqNKqg0wItKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvaqYHG362T5fIJ50TYxzWXpkipmBiuczHvWhs8a303atWNp61Gu6+MKcC7cOMFB2
	 nUtyePdvGeKuaRi5eyAqph24HSCzjMsbActvPhVcyv184LXIatGLGGNl6bMDZYkMGM
	 XSSKccY4j0ODj9q91y/DpZnqlDNH7Z4tdj104hB88QTwXh7bPyrwZCjrLhHxTeoL95
	 7ptqH8gRjM3YRibK0L//LCqgvsWG2g8gHjx8efR8iUW3l40KXlDlrIe6keX0ZpUn3g
	 lI/qGAxlR0Ctsg6ME8ieRpRiaQVDhU+qH2Ws4dK8/ZFwQu76qB/eBbTVdT8cpLTFjA
	 DnhWG3XwdiRPA==
Date: Wed, 5 Mar 2025 10:08:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/3] xfs_io: Add support for preadv2
Message-ID: <20250305180833.GF2803749@frogsfrogsfrogs>
References: <cover.1741170031.git.ritesh.list@gmail.com>
 <68b83527415c7c2a74270193f5ffd14363e5de88.1741170031.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b83527415c7c2a74270193f5ffd14363e5de88.1741170031.git.ritesh.list@gmail.com>

On Wed, Mar 05, 2025 at 03:57:46PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds support for preadv2() to xfs_io.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  io/Makefile |  2 +-
>  io/pread.c  | 45 ++++++++++++++++++++++++++++++---------------
>  2 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/io/Makefile b/io/Makefile
> index 8f835ec7..14a3fe20 100644
> --- a/io/Makefile
> +++ b/io/Makefile
> @@ -66,7 +66,7 @@ LLDLIBS += $(LIBEDITLINE) $(LIBTERMCAP)
>  endif
>  
>  ifeq ($(HAVE_PWRITEV2),yes)
> -LCFLAGS += -DHAVE_PWRITEV2
> +LCFLAGS += -DHAVE_PWRITEV2 -DHAVE_PREADV2
>  endif
>  
>  ifeq ($(HAVE_MAP_SYNC),yes)
> diff --git a/io/pread.c b/io/pread.c
> index 62c771fb..b314fbc7 100644
> --- a/io/pread.c
> +++ b/io/pread.c
> @@ -162,7 +162,8 @@ static ssize_t
>  do_preadv(
>  	int		fd,
>  	off_t		offset,
> -	long long	count)
> +	long long	count,
> +	int			preadv2_flags)
>  {
>  	int		vecs = 0;
>  	ssize_t		oldlen = 0;
> @@ -181,8 +182,14 @@ do_preadv(
>  	} else {
>  		vecs = vectors;
>  	}
> +#ifdef HAVE_PREADV2
> +	if (preadv2_flags)
> +		bytes = preadv2(fd, iov, vectors, offset, preadv2_flags);
> +	else
> +		bytes = preadv(fd, iov, vectors, offset);
> +#else
>  	bytes = preadv(fd, iov, vectors, offset);
> -
> +#endif
>  	/* restore trimmed iov */
>  	if (oldlen)
>  		iov[vecs - 1].iov_len = oldlen;
> @@ -195,12 +202,13 @@ do_pread(
>  	int		fd,
>  	off_t		offset,
>  	long long	count,
> -	size_t		buffer_size)
> +	size_t		buffer_size,
> +	int			preadv2_flags)

Too much indenting here ^^ I think?

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  {
>  	if (!vectors)
>  		return pread(fd, io_buffer, min(count, buffer_size), offset);
>  
> -	return do_preadv(fd, offset, count);
> +	return do_preadv(fd, offset, count, preadv2_flags);
>  }
>  
>  static int
> @@ -210,7 +218,8 @@ read_random(
>  	long long	count,
>  	long long	*total,
>  	unsigned int	seed,
> -	int		eof)
> +	int		eof,
> +	int		preadv2_flags)
>  {
>  	off_t		end, off, range;
>  	ssize_t		bytes;
> @@ -234,7 +243,7 @@ read_random(
>  				io_buffersize;
>  		else
>  			off = offset;
> -		bytes = do_pread(fd, off, io_buffersize, io_buffersize);
> +		bytes = do_pread(fd, off, io_buffersize, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			break;
>  		if (bytes < 0) {
> @@ -256,7 +265,8 @@ read_backward(
>  	off_t		*offset,
>  	long long	*count,
>  	long long	*total,
> -	int		eof)
> +	int		eof,
> +	int		preadv2_flags)
>  {
>  	off_t		end, off = *offset;
>  	ssize_t		bytes = 0, bytes_requested;
> @@ -276,7 +286,7 @@ read_backward(
>  	/* Do initial unaligned read if needed */
>  	if ((bytes_requested = (off % io_buffersize))) {
>  		off -= bytes_requested;
> -		bytes = do_pread(fd, off, bytes_requested, io_buffersize);
> +		bytes = do_pread(fd, off, bytes_requested, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			return ops;
>  		if (bytes < 0) {
> @@ -294,7 +304,7 @@ read_backward(
>  	while (cnt > end) {
>  		bytes_requested = min(cnt, io_buffersize);
>  		off -= bytes_requested;
> -		bytes = do_pread(fd, off, cnt, io_buffersize);
> +		bytes = do_pread(fd, off, cnt, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			break;
>  		if (bytes < 0) {
> @@ -318,14 +328,15 @@ read_forward(
>  	long long	*total,
>  	int		verbose,
>  	int		onlyone,
> -	int		eof)
> +	int		eof,
> +	int		preadv2_flags)
>  {
>  	ssize_t		bytes;
>  	int		ops = 0;
>  
>  	*total = 0;
>  	while (count > 0 || eof) {
> -		bytes = do_pread(fd, offset, count, io_buffersize);
> +		bytes = do_pread(fd, offset, count, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			break;
>  		if (bytes < 0) {
> @@ -353,7 +364,7 @@ read_buffer(
>  	int		verbose,
>  	int		onlyone)
>  {
> -	return read_forward(fd, offset, count, total, verbose, onlyone, 0);
> +	return read_forward(fd, offset, count, total, verbose, onlyone, 0, 0);
>  }
>  
>  static int
> @@ -371,6 +382,7 @@ pread_f(
>  	int		Cflag, qflag, uflag, vflag;
>  	int		eof = 0, direction = IO_FORWARD;
>  	int		c;
> +	int		preadv2_flags = 0;
>  
>  	Cflag = qflag = uflag = vflag = 0;
>  	init_cvtnum(&fsblocksize, &fssectsize);
> @@ -463,15 +475,18 @@ pread_f(
>  	case IO_RANDOM:
>  		if (!zeed)	/* srandom seed */
>  			zeed = time(NULL);
> -		c = read_random(file->fd, offset, count, &total, zeed, eof);
> +		c = read_random(file->fd, offset, count, &total, zeed, eof,
> +						preadv2_flags);
>  		break;
>  	case IO_FORWARD:
> -		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof);
> +		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof,
> +						 preadv2_flags);
>  		if (eof)
>  			count = total;
>  		break;
>  	case IO_BACKWARD:
> -		c = read_backward(file->fd, &offset, &count, &total, eof);
> +		c = read_backward(file->fd, &offset, &count, &total, eof,
> +						  preadv2_flags);
>  		break;
>  	default:
>  		ASSERT(0);
> -- 
> 2.48.1
> 
> 

