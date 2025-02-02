Return-Path: <linux-fsdevel+bounces-40547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18C4A24E92
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 15:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B55F1884B6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1238B1F9A93;
	Sun,  2 Feb 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmG8saet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B361F9A80
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738506333; cv=none; b=AV4SQZ0cGTudNbKWeHz5TJyub+rUply9EZ7+4TZbkDr1hGi98jPICvizhl6xrsvz5MnRW/Mh9uwHc7SeDc+tWummqAOfvs5myk8OluWOGqKaVuBMvauiS/rbzL7MUmDUw9kFHlcdkOvT2sWkl391REhtzYqjgqbvfmgaXXwA8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738506333; c=relaxed/simple;
	bh=V/4c0udt/+v+Xh/8RmMnbxYwqjB2kktBZlKt+27k2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8CYxaNnD/28gWPPaTSY/Zuuc8wyh2yZCz8cJXZHjxVgJapZxlJQzAXDmv3uJQEg40MOGaLhe1LvIWJ4aGpvuKkDg9fBgjntuH65G3FDP+ZSmGYopobA+fcZhD8BESfHhEWcJG/ORoEqXBn8tzInWlOW4KgrFweEHsEYexa382g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmG8saet; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738506329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7iSzttlOUodK75C/VSs7RT8LdulGLjbAyncahFiE6d0=;
	b=dmG8saetRcM4iXzaJKBrezfx+y/cOTCq3Y/5DoPezeACJ7BW032CRqIgTHcQLS1Ny3+eOZ
	T08k8ZxQ1+vWG6XwcSDba4G+8Oui6sZRtYQsCHMylhq05mqA3hnicUJMoxBt6MtBfE7mW5
	d+MI2X4syRsy6ToEQ5zlycdVEEUKAVc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-zmDIM_8-PtSatFnWbc8aHg-1; Sun, 02 Feb 2025 09:25:26 -0500
X-MC-Unique: zmDIM_8-PtSatFnWbc8aHg-1
X-Mimecast-MFC-AGG-ID: zmDIM_8-PtSatFnWbc8aHg
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2166f9f52fbso113327635ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Feb 2025 06:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738506324; x=1739111124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iSzttlOUodK75C/VSs7RT8LdulGLjbAyncahFiE6d0=;
        b=n8FxnWi2E4N2mc+cZvACWDMWWyLX8ZkWJnFYwcVfZbmKzKgPuFekMRmv6H7nKWELGu
         gKAO6dXqGaL56oM9A8POdk0nSsW8aHAWufKSMiA56GCghGxc/TWT15peGBU7YUhCKo1A
         GGZjS+cKL1NNtHNpTr/IqMLnQtnV5y0koe8PvZILfzsN1RxTubLNpCMsre5m/db+coMu
         7zbSZGQmb8KFUpEO92MEfisolOMYzH5axdL3VjzzqRZbt+wtkh3ArJ/1B+ifpbd7lS7O
         aEN3MhftNrUSkHNqq3CXuLmlG0NW4QDyFZ8l1R82Vv4cRnEOs1Gd/CItTDOokxK9w3Mj
         bcrg==
X-Forwarded-Encrypted: i=1; AJvYcCVJq19abgKF0Z/CBBLGib7mlkvN0uh3mx4XBP6mLlC/vKWxI/CInwztM9XuTSzrl8bti9pctDS4hB0Oy9PO@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMvTqQ/DzhJe+lrwchC/i+Exl24k2ZHGFIFEP++q4j7cES0lV
	Sgcq2Fj3lGorYWoA8HOwywAejnxBY+kQ5J4h4ktkiU9M9fIaMapY/Pkzr+SIZHws+gLIBN2RUro
	HUu+BRkrJA1unZY58/euHzOXzITnHOZWNTQ9K3vqslRTRQqQANsBWP30DUI31hmTnxP/rgAsvMw
	==
X-Gm-Gg: ASbGncvBpAk6C6ibaHhvXYdUVyDsaE5LkknhLkoLUs1IZFvD7dQxBEi3Pt0owd5DKlu
	DtK5SaSjyHFqb0EJYdiphROlGwXEzHiaX9abiol8zVx/yX7VMkNKYa8R3y5eOeZ0n2j7mOrjjpP
	8kKLxgt/fsXL6e/bKFTySn0+FZtD49C2zsjx7eE4phXDvBfbJpM7hRgm6l5bFLG91Qcio68wa7N
	PA3nBymXdQXWW1dzy0W4+kEFW8cEB7qB9+WI2cR3GscUCBmpRg5fjOMavDo3G6q/mu3MYlrXJZr
	8S1QIs6Uit+Zir5rCCDpfCSrmsQJxXhChWTM/5zAFxQA9g==
X-Received: by 2002:a17:903:11cd:b0:215:7719:24f6 with SMTP id d9443c01a7336-21dd7d788ffmr262712115ad.23.1738506323998;
        Sun, 02 Feb 2025 06:25:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2hI+8JEG1vqkXTigzNYfB9dSkTo88eWJNupF1d/cMAf5KQtZR94IJwoxJvgFxw4xXyLb/Sg==
X-Received: by 2002:a17:903:11cd:b0:215:7719:24f6 with SMTP id d9443c01a7336-21dd7d788ffmr262711815ad.23.1738506323560;
        Sun, 02 Feb 2025 06:25:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31edd95sm59489305ad.40.2025.02.02.06.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 06:25:22 -0800 (PST)
Date: Sun, 2 Feb 2025 22:25:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, djwong@kernel.org, nirjhar@linux.ibm.com,
	kernel-team@meta.com
Subject: Re: [PATCH v5 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250202142518.r3xvf7mvfo2nhb7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250121215641.1764359-1-joannelkoong@gmail.com>
 <20250121215641.1764359-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121215641.1764359-2-joannelkoong@gmail.com>

On Tue, Jan 21, 2025 at 01:56:40PM -0800, Joanne Koong wrote:
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
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---

Those two test cases fail on old system which doesn't support
MADV_COLLAPSE:

   fsx -N 10000 -l 500000 -h
  -fsx -N 10000 -o 8192 -l 500000 -h
  -fsx -N 10000 -o 128000 -l 500000 -h
  +MADV_COLLAPSE not supported. Can't support -h

and

   fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
  -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
  -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W -h
  +mapped writes DISABLED
  +MADV_COLLAPSE not supported. Can't support -h

I'm wondering ...

>  ltp/fsx.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 153 insertions(+), 13 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..3be383c6 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -190,6 +190,16 @@ int	o_direct;			/* -Z */
>  int	aio = 0;
>  int	uring = 0;
>  int	mark_nr = 0;
> +int	hugepages = 0;                  /* -h flag */
> +
> +/* Stores info needed to periodically collapse hugepages */
> +struct hugepages_collapse_info {
> +	void *orig_good_buf;
> +	long good_buf_size;
> +	void *orig_temp_buf;
> +	long temp_buf_size;
> +};
> +struct hugepages_collapse_info hugepages_info;
>  
>  int page_size;
>  int page_mask;
> @@ -2471,7 +2481,7 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> +		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
>  	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
>  	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
>  	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> @@ -2483,8 +2493,11 @@ usage(void)
>  	-d: debug output for all operations\n\
>  	-e: pollute post-eof on size changes (default 0)\n\
>  	-f: flush and invalidate cache after I/O\n\
> -	-g X: write character X instead of random generated data\n\
> -	-i logdev: do integrity testing, logdev is the dm log writes device\n\
> +	-g X: write character X instead of random generated data\n"
> +#ifdef MADV_COLLAPSE
> +"	-h hugepages: use buffers backed by hugepages for reads/writes\n"
> +#endif
> +"	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>  	-j logid: prefix debug log messsages with this id\n\
>  	-k: do not truncate existing file and use its size as upper bound on file size\n\
>  	-l flen: the upper bound on file size (default 262144)\n\
> @@ -2833,11 +2846,41 @@ __test_fallocate(int mode, const char *mode_str)
>  #endif
>  }
>  
> +/*
> + * Reclaim may break up hugepages, so do a best-effort collapse every once in
> + * a while.
> + */
> +static void
> +collapse_hugepages(void)
> +{
> +#ifdef MADV_COLLAPSE
> +	int ret;
> +
> +	/* re-collapse every 16k fsxops after we start */
> +	if (!numops || (numops & ((1U << 14) - 1)))
> +		return;
> +
> +	ret = madvise(hugepages_info.orig_good_buf,
> +		      hugepages_info.good_buf_size, MADV_COLLAPSE);
> +	if (ret)
> +		prt("collapsing hugepages for good_buf failed (numops=%llu): %s\n",
> +		     numops, strerror(errno));
> +	ret = madvise(hugepages_info.orig_temp_buf,
> +		      hugepages_info.temp_buf_size, MADV_COLLAPSE);
> +	if (ret)
> +		prt("collapsing hugepages for temp_buf failed (numops=%llu): %s\n",
> +		     numops, strerror(errno));
> +#endif
> +}
> +
>  bool
>  keep_running(void)
>  {
>  	int ret;
>  
> +	if (hugepages)
> +	        collapse_hugepages();
> +
>  	if (deadline.tv_nsec) {
>  		struct timespec now;
>  
> @@ -2856,6 +2899,103 @@ keep_running(void)
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
> +static void *
> +init_hugepages_buf(unsigned len, int hugepage_size, int alignment, long *buf_size)
> +{
> +	void *buf = NULL;
> +#ifdef MADV_COLLAPSE
> +	int ret;
> +	long size = roundup(len, hugepage_size) + alignment;
> +
> +	ret = posix_memalign(&buf, hugepage_size, size);
> +	if (ret) {
> +		prterr("posix_memalign for buf");
> +		return NULL;
> +	}
> +	memset(buf, '\0', size);
> +	ret = madvise(buf, size, MADV_COLLAPSE);
> +	if (ret) {
> +		prterr("madvise collapse for buf");
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	*buf_size = size;
> +#endif
> +	return buf;
> +}
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
> +		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy,
> +					      &hugepages_info.good_buf_size);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for good_buf");
> +			exit(103);
> +		}
> +		hugepages_info.orig_good_buf = good_buf;
> +
> +		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy,
> +					      &hugepages_info.temp_buf_size);
> +		if (!temp_buf) {
> +			prterr("init_hugepages_buf failed for temp_buf");
> +			exit(103);
> +		}
> +		hugepages_info.orig_temp_buf = temp_buf;
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
> @@ -2883,7 +3023,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2916,6 +3056,14 @@ main(int argc, char **argv)
>  		case 'g':
>  			filldata = *optarg;
>  			break;
> +		case 'h':
> +#ifndef MADV_COLLAPSE
> +			fprintf(stderr, "MADV_COLLAPSE not supported. "
> +				"Can't support -h\n");
> +			exit(86);
> +#endif
> +			hugepages = 1;
> +			break;

...
if we could change this part to:

#ifdef MADV_COLLAPSE
	hugepages = 1;
#endif
	break;

to avoid the test failures on old systems.

Or any better ideas from you :)

Thanks,
Zorro

>  		case 'i':
>  			integrity = 1;
>  			logdev = strdup(optarg);
> @@ -3229,15 +3377,7 @@ main(int argc, char **argv)
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


