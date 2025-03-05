Return-Path: <linux-fsdevel+bounces-43285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6DA508DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9186C188687D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0E2517A0;
	Wed,  5 Mar 2025 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+WNn/ZR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC52251786;
	Wed,  5 Mar 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198232; cv=none; b=l1MWXDg0ECDYKN316VYDGNQWKrTqVbfFQpf5/8k4CNJ1oWVpB3tD8ifOVg8dtgELTPwD8NEIX4Yc44ZOlVUAG3mJmx++7FM8euSPg6CGzoXvYTOKdsPP/DhbxDMH/lOSYx6iJlyiiJMCC5ZwIauftARDKAR9LEAp7yF5YRG1/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198232; c=relaxed/simple;
	bh=x9JanNTYgh4rxVG/qsj2iNdQfl5Ec342ONFC4j2O1tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvn0M9baCnwI4MdYlgiHhn5wrO6ZMba5Q0IalSuOkeADj+ODqA0oi9jHjsyI2h2quwX3mnKm7SqX9Sz3HHKken7+IaUSHl23s19uHdbSOiqprSpN5SQ8d4jdZgrcqOMsZy1WV4/oESK5KI8lAZAn0fN2bfJ4LG8Kc4vqCCk2HE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+WNn/ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B28EC4CEE0;
	Wed,  5 Mar 2025 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198232;
	bh=x9JanNTYgh4rxVG/qsj2iNdQfl5Ec342ONFC4j2O1tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+WNn/ZRwu95Xkc1c1tpxbWdlswu3h2iSPYJy6B8nGXgMER9/bRMhRK9zAjL84zra
	 V7g0ha1RsS+5ij2vPUc5EpWWdBF8RbtwvmujKf5fTdjc1A7t99qxQbn5HJMKvH4B8J
	 uxwBn6PulRi4MarmLaQDAfapuvwfFNGojLoBiUK4ByhrOJeilnpKmKbjoefR2c8ISY
	 EHKEXTVvHDbVgjS9NgntmV7pQjOgTqJnzquOydOi4yenQwwAdtYk5BfnCKpSzx4yZ2
	 dxOpkNfoKl2YUhNfY0D7jeKSU61n8V/llXjc/1dN3eSlt1fZFV/4FK+d2svLw9Ti7I
	 Yq0y8Y5OA16Dw==
Date: Wed, 5 Mar 2025 10:10:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/3] xfs_io: Add RWF_DONTCACHE support to pwritev2
Message-ID: <20250305181031.GG2803749@frogsfrogsfrogs>
References: <cover.1741170031.git.ritesh.list@gmail.com>
 <57bd6d327ac8ed2f8e9859f1e42775622a8b9d09.1741170031.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57bd6d327ac8ed2f8e9859f1e42775622a8b9d09.1741170031.git.ritesh.list@gmail.com>

On Wed, Mar 05, 2025 at 03:57:47PM +0530, Ritesh Harjani (IBM) wrote:
> Add per-io RWF_DONTCACHE support flag to pwritev2().
> This enables xfs_io to perform uncached buffered-io writes.
> 
> e.g. xfs_io -fc "pwrite -U -V 1 0 16K" /mnt/f1
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  include/linux.h   |  5 +++++
>  io/pwrite.c       | 14 ++++++++++++--
>  man/man8/xfs_io.8 |  8 +++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux.h b/include/linux.h
> index b3516d54..6e83e073 100644
> --- a/include/linux.h
> +++ b/include/linux.h
> @@ -237,6 +237,11 @@ struct fsxattr {
>  #define RWF_ATOMIC	((__kernel_rwf_t)0x00000040)
>  #endif
>  
> +/* buffered IO that drops the cache after reading or writing data */
> +#ifndef RWF_DONTCACHE
> +#define RWF_DONTCACHE	((__kernel_rwf_t)0x00000080)
> +#endif
> +
>  /*
>   * Reminder: anything added to this file will be compiled into downstream
>   * userspace projects!
> diff --git a/io/pwrite.c b/io/pwrite.c
> index fab59be4..5fb0253f 100644
> --- a/io/pwrite.c
> +++ b/io/pwrite.c
> @@ -45,6 +45,7 @@ pwrite_help(void)
>  " -N   -- Perform the pwritev2() with RWF_NOWAIT\n"
>  " -D   -- Perform the pwritev2() with RWF_DSYNC\n"
>  " -A   -- Perform the pwritev2() with RWF_ATOMIC\n"
> +" -U   -- Perform the pwritev2() with Uncached/RWF_DONTCACHE\n"

I would have just said "...with RWF_DONTCACHE" because that's a lot more
precise.

With that shortened, this looks pretty straightforward.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  #endif
>  "\n"));
>  }
> @@ -285,7 +286,7 @@ pwrite_f(
>  	init_cvtnum(&fsblocksize, &fssectsize);
>  	bsize = fsblocksize;
>  
> -	while ((c = getopt(argc, argv, "Ab:BCdDf:Fi:NqRs:OS:uV:wWZ:")) != EOF) {
> +	while ((c = getopt(argc, argv, "Ab:BCdDf:Fi:NqRs:OS:uUV:wWZ:")) != EOF) {
>  		switch (c) {
>  		case 'b':
>  			tmp = cvtnum(fsblocksize, fssectsize, optarg);
> @@ -328,6 +329,9 @@ pwrite_f(
>  		case 'A':
>  			pwritev2_flags |= RWF_ATOMIC;
>  			break;
> +		case 'U':
> +			pwritev2_flags |= RWF_DONTCACHE;
> +			break;
>  #endif
>  		case 's':
>  			skip = cvtnum(fsblocksize, fssectsize, optarg);
> @@ -392,6 +396,12 @@ pwrite_f(
>  		exitcode = 1;
>  		return command_usage(&pwrite_cmd);
>  	}
> +	if (pwritev2_flags != 0 && vectors == 0) {
> +		printf(_("pwritev2 flags require vectored I/O (-V)\n"));
> +		exitcode = 1;
> +		return command_usage(&pwrite_cmd);
> +	}
> +
>  	offset = cvtnum(fsblocksize, fssectsize, argv[optind]);
>  	if (offset < 0) {
>  		printf(_("non-numeric offset argument -- %s\n"), argv[optind]);
> @@ -480,7 +490,7 @@ pwrite_init(void)
>  	pwrite_cmd.argmax = -1;
>  	pwrite_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>  	pwrite_cmd.args =
> -_("[-i infile [-qAdDwNOW] [-s skip]] [-b bs] [-S seed] [-FBR [-Z N]] [-V N] off len");
> +_("[-i infile [-qAdDwNOUW] [-s skip]] [-b bs] [-S seed] [-FBR [-Z N]] [-V N] off len");
>  	pwrite_cmd.oneline =
>  		_("writes a number of bytes at a specified offset");
>  	pwrite_cmd.help = pwrite_help;
> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
> index 59d5ddc5..47af5232 100644
> --- a/man/man8/xfs_io.8
> +++ b/man/man8/xfs_io.8
> @@ -244,7 +244,7 @@ See the
>  .B pread
>  command.
>  .TP
> -.BI "pwrite [ \-i " file " ] [ \-qAdDwNOW ] [ \-s " skip " ] [ \-b " size " ] [ \-S " seed " ] [ \-FBR [ \-Z " zeed " ] ] [ \-V " vectors " ] " "offset length"
> +.BI "pwrite [ \-i " file " ] [ \-qAdDwNOUW ] [ \-s " skip " ] [ \-b " size " ] [ \-S " seed " ] [ \-FBR [ \-Z " zeed " ] ] [ \-V " vectors " ] " "offset length"
>  Writes a range of bytes in a specified blocksize from the given
>  .IR offset .
>  The bytes written can be either a set pattern or read in from another
> @@ -287,6 +287,12 @@ Perform the
>  call with
>  .IR RWF_ATOMIC .
>  .TP
> +.B \-U
> +Perform the
> +.BR pwritev2 (2)
> +call with
> +.IR RWF_DONTCACHE .
> +.TP
>  .B \-O
>  perform pwrite once and return the (maybe partial) bytes written.
>  .TP
> -- 
> 2.48.1
> 
> 

