Return-Path: <linux-fsdevel+bounces-37915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D49F8D6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 08:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB27A162F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38E41993B7;
	Fri, 20 Dec 2024 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cix61rSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57041C6A;
	Fri, 20 Dec 2024 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734680854; cv=none; b=kFqkZLnuPIeMbnLvyTmu0pdaXbLXEM8yHVqOlEHFl2xut0DKt+u8Y/UuTFQe8ZYaFmlfEVbBMja/ynzlql2rO8wGEKPEv/sWWnzxJ3ETglOaGBoRUmuD0bdXxR2iSVov6g5TTnhDBFYdeipYuNx6MITclHnVkDRmjrQiRHd3s6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734680854; c=relaxed/simple;
	bh=LgvdwZAe0lySK4iAk5x6MGr4z7w1M3ScPRGlv7hxgvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=ufIXcpkgDbJApz/Q1wZGmr3fB3AZW+39B/guX0/JPY3q7KyVTM9oCOWzFQ8d6UASTdGQWtOxcrSJIwxuIR0R9AJqRSmZx1DUpEohTeQJ/D6pOxrIn1PJMJxxCp6+cl2nhjasze4CrN5xcb1AllFI9eXV5Yj+Ahz+73JNNl8xJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cix61rSi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNw9U3002323;
	Fri, 20 Dec 2024 07:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Gcegu
	D2QY3TThEpaHY+FUoOyKw1xz9hRVveW7CASHw=; b=cix61rSiFyCTOCv9/xalWu
	P3rr/4Yg9Vo0ifD3xQZdi92lXWQbsgobYsIz+RSOlynDm1K8eTT/y4hU5BQLa+v5
	7ePdx31sMiouJiNAyEaA4j28I5aHW+FyYVOVOGPFbFhIUQrUytyMOvSPe8x7JXiS
	JNL0l6WgaaFd/gzffqIVIPcd/10/s9k1+9rCbrCpdt332NJhKq5hFH7yMwFHlzfz
	dIzUUjt0mtFvODKnZiF/PhzepJyQzYAbT8oa6+jyXU5ZD1gxkg+x+/5m9C7UFArF
	e2q+OzofgndF1Q4OiAnSB4Y77TpvXhuR0Z+BLdb+TvGsPMv2tpG+mhyFuX3PWMsA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwmhhh0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:47:30 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BK7MiXr018289;
	Fri, 20 Dec 2024 07:47:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwmhhh06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:47:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6repV014383;
	Fri, 20 Dec 2024 07:47:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq220s9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:47:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BK7lRDZ31458016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 07:47:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 222852005A;
	Fri, 20 Dec 2024 07:47:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22BC82004D;
	Fri, 20 Dec 2024 07:47:26 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.39.22.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Dec 2024 07:47:25 +0000 (GMT)
Message-ID: <c74087b50970bf953c78c8756e41d25df28637b1.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] fsx: support reads/writes from buffers backed by
 hugepages
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Joanne Koong <joannelkoong@gmail.com>, fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Fri, 20 Dec 2024 13:17:25 +0530
In-Reply-To: <20241218210122.3809198-2-joannelkoong@gmail.com>
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
	 <20241218210122.3809198-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NL01KBuMqStCMfT0YuN7U4nDjyma30Mp
X-Proofpoint-GUID: K2aFTBkewM2UHbZ9qH6QdAdfwRxEUrIp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200062

On Wed, 2024-12-18 at 13:01 -0800, Joanne Koong wrote:
> Add support for reads/writes from buffers backed by hugepages.
> This can be enabled through the '-h' flag. This flag should only be
> used
> on systems where THP capabilities are enabled.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  ltp/fsx.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++---
> --
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
> +	-h hugepages: use buffers backed by hugepages for
> reads/writes\n\
>  	-i logdev: do integrity testing, logdev is the dm log writes
> device\n\
>  	-j logid: prefix debug log messsages with this id\n\
>  	-k: do not truncate existing file and use its size as upper
> bound on file size\n\
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
Extremely minor: Since str is a fixed string, why not calculate the
length outside the loop and not re-use strlen(str) multiple times?
> +			sscanf(buffer + strlen(str), "%ld",
> &hugepage_size);
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
Minor: << 10 might be faster instead of '*' ?
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
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout
> */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xy
> ABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:x
> yABD:EFJKHzCILN:OP:RS:UWXZ",
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
> +			prt("ignoring write alignment (since -h is
> enabled)");
> +
> +		if (readbdy != 1 && readbdy != hugepage_size)
> +			prt("ignoring read alignment (since -h is
> enabled)");
> +
> +		good_buf = init_hugepages_buf(maxfilelen,
> hugepage_size);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for
> good_buf");
> +			exit(100);
> +		}
> +
> +		temp_buf = init_hugepages_buf(maxoplen, hugepage_size);
> +		if (!temp_buf) {
> +			prterr("init_hugepages_buf failed for
> temp_buf");
> +			exit(101);
> +		}
> +	} else {
> +		good_buf = (char *) malloc(maxfilelen + writebdy);
> +		good_buf = round_ptr_up(good_buf, writebdy, 0);
Not sure if it would matter but aren't we seeing a small memory leak
here since good_buf's original will be lost after rounding up?
> +		memset(good_buf, '\0', maxfilelen);
> +
> +		temp_buf = (char *) malloc(maxoplen + readbdy);
> +		temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> +		memset(temp_buf, '\0', maxoplen);
> +	}
>  	if (lite) {	/* zero entire existing file */
>  		ssize_t written;
>  


