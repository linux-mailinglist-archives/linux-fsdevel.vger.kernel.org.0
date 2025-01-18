Return-Path: <linux-fsdevel+bounces-39593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E40EA15EB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C91659C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98D1AF4EF;
	Sat, 18 Jan 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKwd6ZCX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AD1373;
	Sat, 18 Jan 2025 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737231441; cv=none; b=FufDo3KhX4FLTrgCE3G7YUmkuyAunNfp9vdmuy9YDy3pUGXm75ZLZcsaBi070DzXVfHCgLkJJM+QgF/UtFmPFG2SyRXgM7S8sDF/VRPsFW3ySmJosOq6WdLQJNWqJbDvibVU8FJxDCgKlVhcm5lnepT+8bG8hgBKrOGi2YRnK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737231441; c=relaxed/simple;
	bh=IYtuDBTjGBul4rBF164o4Ro3Qd7skHxwO4+SWTF801I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE/5zLT62gqBAhNMRYVKj81zwnILU/FwYMgVcUAEt+ZvBVC6QtWk2vt+XyCk0jc7sVTSlck9znXGCGS3sCdkD+heAcYrU3FLV1K8PbdyZsmZSPdXqXFrxNZXXQqyQEUykeijyaozCXAgRp3ZQlhn7SXff/CC7OGgh4AgvK/95Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKwd6ZCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866C1C4CED1;
	Sat, 18 Jan 2025 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737231441;
	bh=IYtuDBTjGBul4rBF164o4Ro3Qd7skHxwO4+SWTF801I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKwd6ZCX624QKluFD1csmg7pQrrgWgvfKmvBkFOwvLkEvy+nwO9wvI5o0eRSYkijY
	 pOZjKmRCWxck26x0tSAZ3jcHurdKD3+JGyfKxGiCCkii8d2o2IdzblXQ/fXTeHmTGL
	 a/CVFtX0k70irMIywBBGbE73dLT66N2xGLk/y170eUFnNVALgbQQg/FrdtOwbswtJw
	 QWH1WsP4bHOhthyyIlcfhLUzVXvXf04tGhRtXpbgY1ebfiWhx2nG6s2JkQzVF+UOQn
	 +8HaXcXbgPrawczKqkswpUVfMrWA+Qzf+N2RITK3SO3Gr7030qaMvRUspSDvfho3j+
	 yidarDonk4dNA==
Date: Sat, 18 Jan 2025 12:17:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com, nirjhar@linux.ibm.com, zlang@redhat.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <20250118201720.GK3557695@frogsfrogsfrogs>
References: <20250118004759.2772065-1-joannelkoong@gmail.com>
 <20250118004759.2772065-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118004759.2772065-2-joannelkoong@gmail.com>

On Fri, Jan 17, 2025 at 04:47:58PM -0800, Joanne Koong wrote:
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
>  ltp/fsx.c | 165 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 152 insertions(+), 13 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..1513755f 100644
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
> @@ -2833,11 +2846,40 @@ __test_fallocate(int mode, const char *mode_str)
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
> +	int interval = 1 << 14; /* 16k */
> +	int ret;
> +
> +	if (numops && (numops & (interval - 1)) == 0) {

I wonder if this could be collapsed to:

	/* re-collapse every 16k fsxops after we start */
	if (!numops || (numops & ((1U << 14) - 1)))
		return;

	ret = madvise(...);

But my guess is that the compiler is smart enough to realize that
interval never changes and fold it into the test expression?

<shrug> Not that passionate either way. :)

> +		ret = madvise(hugepages_info.orig_good_buf,
> +			      hugepages_info.good_buf_size, MADV_COLLAPSE);
> +		if (ret)
> +			prt("collapsing hugepages for good_buf failed (numops=%llu): %s\n",
> +			     numops, strerror(errno));
> +		ret = madvise(hugepages_info.orig_temp_buf,
> +			      hugepages_info.temp_buf_size, MADV_COLLAPSE);
> +		if (ret)
> +			prt("collapsing hugepages for temp_buf failed (numops=%llu): %s\n",
> +			     numops, strerror(errno));
> +	}
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
> @@ -2856,6 +2898,103 @@ keep_running(void)
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
> @@ -2883,7 +3022,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'b':
> @@ -2916,6 +3055,14 @@ main(int argc, char **argv)
>  		case 'g':
>  			filldata = *optarg;
>  			break;
> +		case 'h':
> +#ifndef MADV_COLLAPSE
> +				fprintf(stderr, "MADV_COLLAPSE not supported. "
> +					"Can't support -h\n");
> +				exit(86);

Excessive indenting here.

With those fixed up,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +#endif
> +			hugepages = 1;
> +			break;
>  		case 'i':
>  			integrity = 1;
>  			logdev = strdup(optarg);
> @@ -3229,15 +3376,7 @@ main(int argc, char **argv)
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

