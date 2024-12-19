Return-Path: <linux-fsdevel+bounces-37857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D843D9F82B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E81899C03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E881A3BC8;
	Thu, 19 Dec 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/RXGlzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366BE19CD0E;
	Thu, 19 Dec 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630667; cv=none; b=H0faCOTwnFFSmOfOSGLvY4+NDsaE/93DZMpc3m0fNdi06EfT6tauUfNU0zrbf8Nb51QXB7hi6tT+UPIA7LoqhJVjFnjrYV5gYc7kWmU7WX4M5gY5uAXQjMNvgSGr46CBsD012SyY+0w8SDckD80MGyTuHXuZPlvKjxLxFmNoi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630667; c=relaxed/simple;
	bh=h0NHpDYNGk/tw5e+6LH7gXcndayIy+r6nLGbrzYm398=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQqZCP54lo9iGZjgrmHjsu0tFu4CvYjO+DCBa8atGZkw67m6t7PSo2KeT5UwUmUadIlOZWUcaucTbJYlnWYwR70zxP4sODboFU2ldMXpxGqv9bYixMxCSBIeHnCi/U+0ajW8K3IzG4tWO+Lxto6FSIvLwBWl9nyUAXsmzQ5NJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/RXGlzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B998AC4CED0;
	Thu, 19 Dec 2024 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630666;
	bh=h0NHpDYNGk/tw5e+6LH7gXcndayIy+r6nLGbrzYm398=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/RXGlzIGwqf/8jjxruuSAAij4YwxmV3VHjU6aANmRwlAto49Ogg0Mq9pagvWIJKQ
	 re4K2LGEDG0zZIs3kzYQpk99sgYikVoa4J6qWMqM6poMhZ2tlaRk+Nd/qyNIz4ET0r
	 FrT40Si3hyHlRKhfTP9K+A6mtk+hzCfCHuGo95hflZi/edPf8wXK1A4ybT8gq4aFC1
	 bmXELrQRKWyjWWhtBj5PPAgLPEV2bExFAw8jvzpHy8udQKZgulUXqxmNM9ujD/HBCm
	 G9p8TbqJa0HJrqXw0vYJJSvqxAndXV8oJ1BmuirAgcMxR1B65JXSW6rxK/Yckapqsr
	 xAvcvrR60u2ew==
Date: Thu, 19 Dec 2024 09:51:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20241219175106.GG6160@frogsfrogsfrogs>
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218210122.3809198-2-joannelkoong@gmail.com>

On Wed, Dec 18, 2024 at 01:01:21PM -0800, Joanne Koong wrote:
> Add support for reads/writes from buffers backed by hugepages.
> This can be enabled through the '-h' flag. This flag should only be used
> on systems where THP capabilities are enabled.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 92 insertions(+), 8 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..3656fd9f 100644
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
>  	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>  	-j logid: prefix debug log messsages with this id\n\
>  	-k: do not truncate existing file and use its size as upper bound on file size\n\
> @@ -2856,6 +2858,56 @@ keep_running(void)
>  	return numops-- != 0;
>  }
>  
> +static long
> +get_hugepage_size(void)
> +{
> +	const char *str = "Hugepagesize:";
> +	long hugepage_size = -1;
> +	char buffer[64];
> +	FILE *file;
> +
> +	file = fopen("/proc/meminfo", "r");
> +	if (!file) {
> +		prterr("get_hugepage_size: fopen /proc/meminfo");
> +		return -1;
> +	}
> +	while (fgets(buffer, sizeof(buffer), file)) {
> +		if (strncmp(buffer, str, strlen(str)) == 0) {
> +			sscanf(buffer + strlen(str), "%ld", &hugepage_size);
> +			break;
> +		}
> +	}
> +	fclose(file);
> +	if (hugepage_size == -1) {
> +		prterr("get_hugepage_size: failed to find "
> +			"hugepage size in /proc/meminfo\n");
> +		return -1;
> +	}
> +
> +	/* convert from KiB to bytes  */
> +	return hugepage_size * 1024;
> +}
> +
> +static void *
> +init_hugepages_buf(unsigned len, long hugepage_size)
> +{
> +	void *buf;
> +	long buf_size = roundup(len, hugepage_size);
> +
> +	if (posix_memalign(&buf, hugepage_size, buf_size)) {
> +		prterr("posix_memalign for buf");
> +		return NULL;
> +	}
> +	memset(buf, '\0', len);
> +	if (madvise(buf, buf_size, MADV_COLLAPSE)) {
> +		prterr("madvise collapse for buf");
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	return buf;
> +}
> +
>  static struct option longopts[] = {
>  	{"replay-ops", required_argument, 0, 256},
>  	{"record-ops", optional_argument, 0, 255},
> @@ -2883,7 +2935,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2916,6 +2968,9 @@ main(int argc, char **argv)
>  		case 'g':
>  			filldata = *optarg;
>  			break;
> +		case 'h':
> +			hugepages = 1;
> +			break;
>  		case 'i':
>  			integrity = 1;
>  			logdev = strdup(optarg);
> @@ -3232,12 +3287,41 @@ main(int argc, char **argv)
>  	original_buf = (char *) malloc(maxfilelen);
>  	for (i = 0; i < maxfilelen; i++)
>  		original_buf[i] = random() % 256;
> -	good_buf = (char *) malloc(maxfilelen + writebdy);
> -	good_buf = round_ptr_up(good_buf, writebdy, 0);
> -	memset(good_buf, '\0', maxfilelen);
> -	temp_buf = (char *) malloc(maxoplen + readbdy);
> -	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> -	memset(temp_buf, '\0', maxoplen);
> +	if (hugepages) {
> +		long hugepage_size;
> +
> +		hugepage_size = get_hugepage_size();
> +		if (hugepage_size == -1) {
> +			prterr("get_hugepage_size()");
> +			exit(99);
> +		}
> +
> +		if (writebdy != 1 && writebdy != hugepage_size)
> +			prt("ignoring write alignment (since -h is enabled)");
> +
> +		if (readbdy != 1 && readbdy != hugepage_size)
> +			prt("ignoring read alignment (since -h is enabled)");

What if readbdy is a multiple of the hugepage size?

> +		good_buf = init_hugepages_buf(maxfilelen, hugepage_size);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for good_buf");
> +			exit(100);
> +		}

Why is it necessary for the good_buf to be backed by a hugepage?
I thought good_buf was only used to compare file contents?

--D

> +
> +		temp_buf = init_hugepages_buf(maxoplen, hugepage_size);
> +		if (!temp_buf) {
> +			prterr("init_hugepages_buf failed for temp_buf");
> +			exit(101);
> +		}
> +	} else {
> +		good_buf = (char *) malloc(maxfilelen + writebdy);
> +		good_buf = round_ptr_up(good_buf, writebdy, 0);
> +		memset(good_buf, '\0', maxfilelen);
> +
> +		temp_buf = (char *) malloc(maxoplen + readbdy);
> +		temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> +		memset(temp_buf, '\0', maxoplen);
> +	}
>  	if (lite) {	/* zero entire existing file */
>  		ssize_t written;
>  
> -- 
> 2.47.1
> 
> 

