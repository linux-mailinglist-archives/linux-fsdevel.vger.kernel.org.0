Return-Path: <linux-fsdevel+bounces-43286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70301A508C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742C33B0DCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18B2517A0;
	Wed,  5 Mar 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNDq73f5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF61D6DB4;
	Wed,  5 Mar 2025 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198264; cv=none; b=LC0O121ZzFh7d5JAXIsZ7zRCrFbuVxed30Uc/VH5qCGtcd34zQCpxjavJzl3thWNc7HYWf20Zxbs/wFAPV5coWKBfjSDaHDlmcieXaHVQgfQv4iBVeUSSuEo1voYbBBEQJdf+VornqxGwzAKBhK99DjsAFhQEZZIPvNfOmOv84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198264; c=relaxed/simple;
	bh=FM4DhxHq8g9Iok9k8eaIG+G00TsVI/C16wJydBiRPl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksau5BaxF9JbkdH+Kih9210Nj5lkBy8lEhdVvjMyqhSxQyj28Gooy6+K3uKfPEYAtvW8hVAPkKxc6T5+PAzDYYnHeaEVGo29+ZKQ/E7xk5VvIL32D7HbGAgRHbHFfLzLCYG70ZKzsftUck2di4a/7NDxupxNf5Pd0BdxJ6C2epU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNDq73f5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D777C4CEE2;
	Wed,  5 Mar 2025 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198264;
	bh=FM4DhxHq8g9Iok9k8eaIG+G00TsVI/C16wJydBiRPl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QNDq73f5sOvQNqkOgwhEKn/0NsgvEJR30WX9sDp9u3BqLvDm0QKpuOrnIA42778NZ
	 qCpeyaSw5w+n4Qd1WpmreZp/zP7aGPj8/XlP/MZNi2ZobexAMuKPDSOSCNO4DbCFVm
	 gmu7RYFZ0kERYd3Ra9Y3UAeyjTB1VCzoRO8ubULR3ivlgCm2bwDXbDybhItKx0AMND
	 mlb9lvHkxKOXjTZWzgOi3b9/JyW/zznDlPgBf3zfy8M8m3JvO7J8j2K0nSNY1cuz8y
	 Zj+EGNeTcgnY41zXpO6QmwtZsCQGRC4FzYvlD9uhlZzX8aoU89WdkhnwPMOBQvLeaW
	 YtTProARABreQ==
Date: Wed, 5 Mar 2025 10:11:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/3] xfs_io: Add RWF_DONTCACHE support to preadv2
Message-ID: <20250305181103.GH2803749@frogsfrogsfrogs>
References: <cover.1741170031.git.ritesh.list@gmail.com>
 <e071c0bf9acdd826f9aa96a7c2617df8aa262f8e.1741170031.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e071c0bf9acdd826f9aa96a7c2617df8aa262f8e.1741170031.git.ritesh.list@gmail.com>

On Wed, Mar 05, 2025 at 03:57:48PM +0530, Ritesh Harjani (IBM) wrote:
> Add per-io RWF_DONTCACHE support flag to preadv2().
> This enables xfs_io to perform uncached buffered-io reads.
> 
> 	e.g. xfs_io -c "pread -U -V 1 0 16K" /mnt/f1
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  io/pread.c        | 17 +++++++++++++++--
>  man/man8/xfs_io.8 |  8 +++++++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/io/pread.c b/io/pread.c
> index b314fbc7..79e6570e 100644
> --- a/io/pread.c
> +++ b/io/pread.c
> @@ -38,6 +38,9 @@ pread_help(void)
>  " -Z N -- zeed the random number generator (used when reading randomly)\n"
>  "         (heh, zorry, the -s/-S arguments were already in use in pwrite)\n"
>  " -V N -- use vectored IO with N iovecs of blocksize each (preadv)\n"
> +#ifdef HAVE_PREADV2
> +" -U   -- Perform the preadv2() with Uncached/RWF_DONTCACHE\n"

Same comment as the last patch, but otherwise this looks good;
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> @@ -446,6 +454,11 @@ pread_f(
>  		exitcode = 1;
>  		return command_usage(&pread_cmd);
>  	}
> +	if (preadv2_flags != 0 && vectors == 0) {
> +		printf(_("preadv2 flags require vectored I/O (-V)\n"));
> +		exitcode = 1;
> +		return command_usage(&pread_cmd);
> +	}
>  
>  	offset = cvtnum(fsblocksize, fssectsize, argv[optind]);
>  	if (offset < 0 && (direction & (IO_RANDOM|IO_BACKWARD))) {
> @@ -514,7 +527,7 @@ pread_init(void)
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

