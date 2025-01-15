Return-Path: <linux-fsdevel+bounces-39338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D824A12DD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 22:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957397A262B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39501DB148;
	Wed, 15 Jan 2025 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzd8HZXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57414156F57;
	Wed, 15 Jan 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977035; cv=none; b=irJT+s1b+gPT9VV7umZZp34xja9PDvMAVO8I9Zfht7j9XKwWZIFvtQn+w8LVN7E8TVN9PMyxVYFIHMEQ8cg/fljaarI55C0UgjdJh00NaIxUSwUnXD3CVgoQ4TE8imfMSL1T86qAF4lW6VQuGXjbnbcao6q5d9mQS0IAvg/Vw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977035; c=relaxed/simple;
	bh=zSOPd5LyGcNwTg//cXLR/SMpN+h4usv71b0CMYo9L5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyGpwCjDnFgI5V6f0a9vxe7ClIErfMyP4Fevy2AffS3n/3NfDXc55d9xweC9VDCB8VT7E4khsEq1nSo/I9JYcjdxhfvx06Rorz8PZe6m9xcLWyKaXIDrT/1D9V8Kq4w3HAwkLaZBKAAko7rm8RlDXoh23O6WFGNzU/cPIoIpOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzd8HZXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F06C4CED1;
	Wed, 15 Jan 2025 21:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736977034;
	bh=zSOPd5LyGcNwTg//cXLR/SMpN+h4usv71b0CMYo9L5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hzd8HZXS0iw1Md+VWT4Wx5nhUAxaiQGrLRoS3iiLHXlWE34iaJzhgz+fYAovWCvfx
	 nCI1HcGwvV9ZpkZJatX/FtcgNjAoBqgxPm/iYT88ux1CLJAVTOtD7IxcS0TU6Eraxv
	 p4QSnSLJyFP4tU7+xvEhnuXwdp4ht88DXAfO+tAt92/cbDXoBsI4J+RmKkpd2o6Xi6
	 TKJ8oskgl9d8VSkJw0zt4cdBg5gCOF9wPlEYvGCrtyP2ZBm74EyS7HuwoAkZfnRvL+
	 puOBP1Tx/akH7PdOB9epoRcaNir8nB3uCSZhZVc4rzbAALA8IQ1mY45gpAWaxFqp3D
	 7YFiyGBzZEW6g==
Date: Wed, 15 Jan 2025 13:37:13 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, nirjhar@linux.ibm.com, zlang@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250115213713.GE3557695@frogsfrogsfrogs>
References: <20250115183107.3124743-1-joannelkoong@gmail.com>
 <20250115183107.3124743-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115183107.3124743-2-joannelkoong@gmail.com>

On Wed, Jan 15, 2025 at 10:31:06AM -0800, Joanne Koong wrote:
> Add support for reads/writes from buffers backed by hugepages.
> This can be enabled through the '-h' flag. This flag should only be used
> on systems where THP capabilities are enabled.
> 
> This is motivated by a recent bug that was due to faulty handling of
> userspace buffers backed by hugepages. This patch is a mitigation
> against problems like this in the future.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> ---
>  ltp/fsx.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 108 insertions(+), 11 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..8d3a2e2c 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -190,6 +190,7 @@ int	o_direct;			/* -Z */
>  int	aio = 0;
>  int	uring = 0;
>  int	mark_nr = 0;
> +int	hugepages = 0;                  /* -h flag */
>  
>  int page_size;
>  int page_mask;
> @@ -2471,7 +2472,7 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> +		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
>  	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
>  	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
>  	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> @@ -2484,6 +2485,7 @@ usage(void)
>  	-e: pollute post-eof on size changes (default 0)\n\
>  	-f: flush and invalidate cache after I/O\n\
>  	-g X: write character X instead of random generated data\n\
> +	-h hugepages: use buffers backed by hugepages for reads/writes\n\

If this requires MADV_COLLAPSE, then perhaps the help text shouldn't
describe the switch if the support wasn't compiled in?

e.g.

	-g X: write character X instead of random generated data\n"
#ifdef MADV_COLLAPSE
"	-h hugepages: use buffers backed by hugepages for reads/writes\n"
#endif
"	-i logdev: do integrity testing, logdev is the dm log writes device\n\

(assuming I got the preprocessor and string construction goo right; I
might be a few cards short of a deck due to zombie attack earlier)

>  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>  	-j logid: prefix debug log messsages with this id\n\
>  	-k: do not truncate existing file and use its size as upper bound on file size\n\
> @@ -2856,6 +2858,101 @@ keep_running(void)
>  	return numops-- != 0;
>  }
>  
> +static long
> +get_hugepage_size(void)
> +{
> +	const char str[] = "Hugepagesize:";
> +	size_t str_len =  sizeof(str) - 1;
> +	unsigned int hugepage_size = 0;
> +	char buffer[64];
> +	FILE *file;
> +
> +	file = fopen("/proc/meminfo", "r");
> +	if (!file) {
> +		prterr("get_hugepage_size: fopen /proc/meminfo");
> +		return -1;
> +	}
> +	while (fgets(buffer, sizeof(buffer), file)) {
> +		if (strncmp(buffer, str, str_len) == 0) {
> +			sscanf(buffer + str_len, "%u", &hugepage_size);
> +			break;
> +		}
> +	}
> +	fclose(file);
> +	if (!hugepage_size) {
> +		prterr("get_hugepage_size: failed to find "
> +			"hugepage size in /proc/meminfo\n");
> +		return -1;
> +	}
> +
> +	/* convert from KiB to bytes */
> +	return hugepage_size << 10;
> +}
> +
> +#ifdef MADV_COLLAPSE
> +static void *
> +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> +{
> +	void *buf;
> +	long buf_size = roundup(len, hugepage_size) + alignment;
> +
> +	if (posix_memalign(&buf, hugepage_size, buf_size)) {
> +		prterr("posix_memalign for buf");
> +		return NULL;
> +	}
> +	memset(buf, '\0', buf_size);
> +	if (madvise(buf, buf_size, MADV_COLLAPSE)) {

If the fsx runs for a long period of time, will it be necessary to call
MADV_COLLAPSE periodically to ensure that reclaim doesn't break up the
hugepage?

> +		prterr("madvise collapse for buf");
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	return buf;
> +}
> +#else
> +static void *
> +init_hugepages_buf(unsigned len, int hugepage_size, int alignment)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +static void
> +init_buffers(void)
> +{
> +	int i;
> +
> +	original_buf = (char *) malloc(maxfilelen);
> +	for (i = 0; i < maxfilelen; i++)
> +		original_buf[i] = random() % 256;
> +	if (hugepages) {
> +		long hugepage_size = get_hugepage_size();
> +		if (hugepage_size == -1) {
> +			prterr("get_hugepage_size()");
> +			exit(102);
> +		}
> +		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for good_buf");
> +			exit(103);
> +		}
> +
> +		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
> +		if (!temp_buf) {
> +			prterr("init_hugepages_buf failed for temp_buf");
> +			exit(103);
> +		}
> +	} else {
> +		unsigned long good_buf_len = maxfilelen + writebdy;
> +		unsigned long temp_buf_len = maxoplen + readbdy;
> +
> +		good_buf = calloc(1, good_buf_len);
> +		temp_buf = calloc(1, temp_buf_len);
> +	}
> +	good_buf = round_ptr_up(good_buf, writebdy, 0);
> +	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> +}
> +
>  static struct option longopts[] = {
>  	{"replay-ops", required_argument, 0, 256},
>  	{"record-ops", optional_argument, 0, 255},
> @@ -2883,7 +2980,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2916,6 +3013,14 @@ main(int argc, char **argv)
>  		case 'g':
>  			filldata = *optarg;
>  			break;
> +		case 'h':
> +			#ifndef MADV_COLLAPSE

Preprocessor directives should start at column 0, like most of the rest
of fstests.

--D

> +				fprintf(stderr, "MADV_COLLAPSE not supported. "
> +					"Can't support -h\n");
> +				exit(86);
> +			#endif
> +			hugepages = 1;
> +			break;
>  		case 'i':
>  			integrity = 1;
>  			logdev = strdup(optarg);
> @@ -3229,15 +3334,7 @@ main(int argc, char **argv)
>  			exit(95);
>  		}
>  	}
> -	original_buf = (char *) malloc(maxfilelen);
> -	for (i = 0; i < maxfilelen; i++)
> -		original_buf[i] = random() % 256;
> -	good_buf = (char *) malloc(maxfilelen + writebdy);
> -	good_buf = round_ptr_up(good_buf, writebdy, 0);
> -	memset(good_buf, '\0', maxfilelen);
> -	temp_buf = (char *) malloc(maxoplen + readbdy);
> -	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> -	memset(temp_buf, '\0', maxoplen);
> +	init_buffers();
>  	if (lite) {	/* zero entire existing file */
>  		ssize_t written;
>  
> -- 
> 2.47.1
> 
> 

