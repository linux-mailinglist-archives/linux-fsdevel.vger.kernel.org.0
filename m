Return-Path: <linux-fsdevel+bounces-43148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51595A4EB08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F916175A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5327702C;
	Tue,  4 Mar 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYHNCNCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723621D8DEE;
	Tue,  4 Mar 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110840; cv=none; b=V+B1TUIdK9pUQaxPyPrJcBNgxF+cnQqQ4hlU69SGu4g0akZLFCtI/DePRlaFbmDxwizX1iIBDzH3sjVDr3tVJnzSv8RSPKk0hYaJp0YhctN0a29ngpJvZvoSQCgEr2vBeu24BmC4xs61vRqWAk6TUuGdCahjlh4ScLJaKpAobW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110840; c=relaxed/simple;
	bh=PrQzX+0qsapV2/e2Zg5y7FKf/55RYZaOUh2ol2Mul44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnPRe7EKrv3oF3p+/QZOMUYA1odcYivVu1p3MvLvnIgId/mXiJQ4g3uNRJF4zBrf/w+kJrmLxc1pak/RNCS8xZi3SdajWn7RYE2mTzjgOqwiAuLGSpvSoWLKmpjOjjS41q1YfEA8o7QR9xlBQQaF6wHySHc9wXAUisc3F4qeLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYHNCNCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C8C4CEE5;
	Tue,  4 Mar 2025 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110840;
	bh=PrQzX+0qsapV2/e2Zg5y7FKf/55RYZaOUh2ol2Mul44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYHNCNCNJp3zM8YovDRytdqqbF7/GR6P0n7ynqnT94STJxUNszCksm3FbrRfuPVqN
	 NwZx1H3MQuSgKNfa3AsIh45d6jkmCAvtin4znclqRwnMdlG+EwF3sbXn9RITozGhvl
	 7VnG97g4ysNFh/UPDbzapX+T8MknH1K4fspjuAunUnUZQeDzxlx+VTTXH51Ved3irM
	 1vAQ/fFBh+5DzAG68i60SHWo6hEFOTmmipFGIzSIhrX1qS1FM81fh4Kx9ZJ1vQrx41
	 h5DSPxtt8YInAAA3Wiirg60vWQ6l2OdQW8PTB6b79Uy8TE29R9za7BvaSGZm+QUR7+
	 l10tT414IySuQ==
Date: Tue, 4 Mar 2025 09:53:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
Message-ID: <20250304175359.GC2803749@frogsfrogsfrogs>
References: <cover.1741087191.git.ritesh.list@gmail.com>
 <19402a5e05c2d1c55e794119facffaec3204a48d.1741087191.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19402a5e05c2d1c55e794119facffaec3204a48d.1741087191.git.ritesh.list@gmail.com>

On Tue, Mar 04, 2025 at 05:25:37PM +0530, Ritesh Harjani (IBM) wrote:
> Add per-io RWF_DONTCACHE support flag to preadv2()
> This enables xfs_io to perform buffered-io read which can drop the page
> cache folios after reading.
> 
> 	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  io/pread.c        | 12 ++++++++++--
>  man/man8/xfs_io.8 |  8 +++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/io/pread.c b/io/pread.c
> index 782f2a36..64c28784 100644
> --- a/io/pread.c
> +++ b/io/pread.c
> @@ -38,6 +38,9 @@ pread_help(void)
>  " -Z N -- zeed the random number generator (used when reading randomly)\n"
>  "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
>  " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
> +#ifdef HAVE_PWRITEV2

HAVE_PREADV2?

--D

> +" -U   -- Perform the preadv2() with Uncached/RWF_DONTCACHE\n"
> +#endif
>  "\n"
>  " When in \"random\" mode, the number of read operations will equal the\n"
>  " number required to do a complete forward/backward scan of the range.\n"
> @@ -388,7 +391,7 @@ pread_f(
>  	init_cvtnum(&fsblocksize, &fssectsize);
>  	bsize = fsblocksize;
>  
> -	while ((c = getopt(argc, argv, "b:BCFRquvV:Z:")) != EOF) {
> +	while ((c = getopt(argc, argv, "b:BCFRquUvV:Z:")) != EOF) {
>  		switch (c) {
>  		case 'b':
>  			tmp = cvtnum(fsblocksize, fssectsize, optarg);
> @@ -417,6 +420,11 @@ pread_f(
>  		case 'u':
>  			uflag = 1;
>  			break;
> +#ifdef HAVE_PREADV2
> +		case 'U':
> +			preadv2_flags |= RWF_DONTCACHE;
> +			break;
> +#endif
>  		case 'v':
>  			vflag = 1;
>  			break;
> @@ -514,7 +522,7 @@ pread_init(void)
>  	pread_cmd.argmin = 2;
>  	pread_cmd.argmax = -1;
>  	pread_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
> -	pread_cmd.args = _("[-b bs] [-qv] [-i N] [-FBR [-Z N]] off len");
> +	pread_cmd.args = _("[-b bs] [-qUv] [-i N] [-FBR [-Z N]] off len");
>  	pread_cmd.oneline = _("reads a number of bytes at a specified offset");
>  	pread_cmd.help = pread_help;
>  
> diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
> index 47af5232..df508054 100644
> --- a/man/man8/xfs_io.8
> +++ b/man/man8/xfs_io.8
> @@ -200,7 +200,7 @@ option will set the file permissions to read-write (0644). This allows xfs_io to
>  set up mismatches between the file permissions and the open file descriptor
>  read/write mode to exercise permission checks inside various syscalls.
>  .TP
> -.BI "pread [ \-b " bsize " ] [ \-qv ] [ \-FBR [ \-Z " seed " ] ] [ \-V " vectors " ] " "offset length"
> +.BI "pread [ \-b " bsize " ] [ \-qUv ] [ \-FBR [ \-Z " seed " ] ] [ \-V " vectors " ] " "offset length"
>  Reads a range of bytes in a specified blocksize from the given
>  .IR offset .
>  .RS 1.0i
> @@ -214,6 +214,12 @@ requests will be split. The default blocksize is 4096 bytes.
>  .B \-q
>  quiet mode, do not write anything to standard output.
>  .TP
> +.B \-U
> +Perform the
> +.BR preadv2 (2)
> +call with
> +.IR RWF_DONTCACHE .
> +.TP
>  .B \-v
>  dump the contents of the buffer after reading,
>  by default only the count of bytes actually read is dumped.
> -- 
> 2.48.1
> 
> 

