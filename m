Return-Path: <linux-fsdevel+bounces-37800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C69F7D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC55166D47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E522579C;
	Thu, 19 Dec 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxVYuPaI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED4225799
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618460; cv=none; b=n8kRwVHQujC/B4lZLvIlj5b6F4/N6HzjsxH4eO/z7RyKNgkRkv3FVzkFMYtxjbf4DeftzfhZtF9bYC6xmjmsm+Li7ho6urNqnwf9IBPlei64N4oW3gCX2b7D5Gtb15i5rJ4xc0j5g8irBsF6zwKTQKFp/gsdUeec34fGBhOxewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618460; c=relaxed/simple;
	bh=8QE5KfVjxpoTfZKjYIwLH3s2nPdfEW1XRGQHv3pqJYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QArISvg66KhrU/b5GdgViC782VSTOtimegszRZvrmQHr4qUDspw1aDirlrmhbAecG6xrWErdrRS7AIeLNk+Q/so+0b29ujlRzCLLG9XHRz05rs0C683PQBYQXiwe2aqEunPX+LrSOpCl2/XK0UKEy+3if89DDd3uHSSMTnXqtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxVYuPaI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734618457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SM5pjnhH0iRbog20VIIxtk0rFApLrF8qnA9nKzvigrs=;
	b=WxVYuPaIBicCANucjqEVp4AZTTdtDCdGDth8usw8TgFLntHZdHfvitUZjb4pONCul0OQ6C
	wPxF+wp/RTgNs3hw5ZqHnnnJMWz5KYME2FipQ18BYpGhV5DjtiKZYFelE/n0bFlkD0qaBG
	9Vo8pHWJqPEwAQKw4XtI9HVulc67xSM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-WN6aVnAVM8WPBETMsFnNcQ-1; Thu,
 19 Dec 2024 09:27:31 -0500
X-MC-Unique: WN6aVnAVM8WPBETMsFnNcQ-1
X-Mimecast-MFC-AGG-ID: WN6aVnAVM8WPBETMsFnNcQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F1F1955F43;
	Thu, 19 Dec 2024 14:27:30 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A37BE30044C1;
	Thu, 19 Dec 2024 14:27:29 +0000 (UTC)
Date: Thu, 19 Dec 2024 09:29:29 -0500
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Message-ID: <Z2QtyaryQtBZZw7q@bfoster>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Dec 18, 2024 at 01:01:21PM -0800, Joanne Koong wrote:
> Add support for reads/writes from buffers backed by hugepages.
> This can be enabled through the '-h' flag. This flag should only be used
> on systems where THP capabilities are enabled.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Firstly, thanks for taking the time to add this. This seems like a nice
idea. It might be nice to have an extra sentence or two in the commit
log on the purpose/motivation. For example, has this been used to detect
a certain class of problem?

A few other quick comments below...

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

I'm assuming it doesn't matter, but did you want to use buf_size here to
clear the whole buffer?

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

I'm a little unclear on what these warnings mean. The alignments are
still used in the read/write paths afaics. The non-huge mode seems to
only really care about the max size of the buffers in this code.

If your test doesn't actually use read/write alignments and the goal is
just to keep things simple, perhaps it would be cleaner to add something
like an if (hugepages && (writebdy != 1 || readbdy != 1)) check after
option processing and exit out as an unsupported combination..?

BTW, it might also be nice to factor out this whole section of buffer
initialization code (including original_buf) into an init_buffers() or
some such. That could be done as a prep patch, but just a suggestion
either way.

Brian

> +
> +		good_buf = init_hugepages_buf(maxfilelen, hugepage_size);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for good_buf");
> +			exit(100);
> +		}
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


