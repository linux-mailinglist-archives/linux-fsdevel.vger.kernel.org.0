Return-Path: <linux-fsdevel+bounces-38260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208BF9FE28A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 06:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0B41611D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7C15E5BB;
	Mon, 30 Dec 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mw++6R0E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44475A59;
	Mon, 30 Dec 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534855; cv=none; b=rADKaXLg3ItW75iRA/y17xg/gGEShaRVG3DvtC8e4fbAwoWejDpDGs34aqRdxHaVM0xXWEAI7GrGmmByJLtN/JSPIExSKhPJwDgEJkgmz1x4Xh3+jE736RCc16eWiYGSH78cjqCBTg9ye/GyDgRpLFc12q8DlnosFIjXmk/yQLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534855; c=relaxed/simple;
	bh=F9gq7YxOB8hDOzC+TdcEnQuj3qICCS1stpJ9fZne0XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptljhBQl/XeRLEnJay2AqC16ryKlS5cGDS4OpCSq472gs3Tp3ni4rxNnRhsdoIQiE1KsFI0mHVoEux0hmwqmjuO+hdQt54vZ8y3TVOSdJf1v6zD/BYoUJoIV28o8cQEMmUOZcQyWmaR626YZflAlC5atL/Jkde5u0AQ7Ldj1jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mw++6R0E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BTNk4Xl007452;
	Mon, 30 Dec 2024 05:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XrHxNo
	fox0/Y5rlSKIX5NNHY/bYV8xm9fTSy6bzxZLM=; b=Mw++6R0E0lLgevIk2/vYvA
	PpNub3KtvVbI7QDsFWSNhSwBDGbYIKGTi1QLloqojoKTDkdh2AgUGqFTVZG2+b8o
	y5w9nLROWqs9LdFdM/WtfwqhlV+OrlbLClhzv5LZOZkMLSLzhE6+K5Wrqo+Y6JPT
	lGKhgIuH7bojSSlTT3gaQHUuuRK64SIwb1T2WLy02Vc2fOZLtOp4KRkczDrQG1n7
	4N0liwlbNkeSCUXBvhtfVyVgAyOpwUfUYsj9XPe8mbGMj5LSIjNR8jfqb1aVMoXD
	ZddCk4xuRhny7b7D3Sp1z5QiC/Th5O52nJAO+vRUpDskqbR36GiEmbkJxJ97JAMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ug8a0nj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 05:00:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BU50d12028631;
	Mon, 30 Dec 2024 05:00:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ug8a0nj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 05:00:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU0SjSe010067;
	Mon, 30 Dec 2024 05:00:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tvnn46wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 05:00:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BU50akh27525658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 05:00:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82FA020040;
	Mon, 30 Dec 2024 05:00:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 648A720043;
	Mon, 30 Dec 2024 05:00:35 +0000 (GMT)
Received: from [9.109.247.80] (unknown [9.109.247.80])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Dec 2024 05:00:35 +0000 (GMT)
Message-ID: <0763b0c7-8570-4b85-80f6-77ae0b09dde9@linux.ibm.com>
Date: Mon, 30 Dec 2024 10:30:34 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fsx: support reads/writes from buffers backed by
 hugepages
Content-Language: en-US
To: Joanne Koong <joannelkoong@gmail.com>, fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, bfoster@redhat.com, djwong@kernel.org,
        kernel-team@meta.com
References: <20241227193311.1799626-1-joannelkoong@gmail.com>
 <20241227193311.1799626-2-joannelkoong@gmail.com>
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <20241227193311.1799626-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: syAne63DwaWyOuMqMARRBVhL3WNn8CRZ
X-Proofpoint-ORIG-GUID: Vyt8rzGIuFRNi-xRqBM4_3dZOdO7M_Pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300039


On 12/28/24 01:03, Joanne Koong wrote:
> Add support for reads/writes from buffers backed by hugepages.
> This can be enabled through the '-h' flag. This flag should only be used
> on systems where THP capabilities are enabled.
>
> This is motivated by a recent bug that was due to faulty handling of
> userspace buffers backed by hugepages. This patch is a mitigation
> against problems like this in the future.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   ltp/fsx.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 97 insertions(+), 11 deletions(-)
>
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 41933354..fb6a9b31 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -190,6 +190,7 @@ int	o_direct;			/* -Z */
>   int	aio = 0;
>   int	uring = 0;
>   int	mark_nr = 0;
> +int	hugepages = 0;                  /* -h flag */
>   
>   int page_size;
>   int page_mask;
> @@ -2471,7 +2472,7 @@ void
>   usage(void)
>   {
>   	fprintf(stdout, "usage: %s",
> -		"fsx [-dfknqxyzBEFHIJKLORWXZ0]\n\
> +		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
>   	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
>   	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
>   	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
> @@ -2484,6 +2485,7 @@ usage(void)
>   	-e: pollute post-eof on size changes (default 0)\n\
>   	-f: flush and invalidate cache after I/O\n\
>   	-g X: write character X instead of random generated data\n\
> +	-h hugepages: use buffers backed by hugepages for reads/writes\n\
>   	-i logdev: do integrity testing, logdev is the dm log writes device\n\
>   	-j logid: prefix debug log messsages with this id\n\
>   	-k: do not truncate existing file and use its size as upper bound on file size\n\
> @@ -2856,6 +2858,95 @@ keep_running(void)
>   	return numops-- != 0;
>   }
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
Thanks for the change.
> +}
> +
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
> +		prterr("madvise collapse for buf");
> +		free(buf);
> +		return NULL;
> +	}
> +
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
> +			exit(100);
> +		}
> +		good_buf = init_hugepages_buf(maxfilelen, hugepage_size, writebdy);
> +		if (!good_buf) {
> +			prterr("init_hugepages_buf failed for good_buf");
> +			exit(101);
> +		}
> +
> +		temp_buf = init_hugepages_buf(maxoplen, hugepage_size, readbdy);
> +		if (!temp_buf) {
> +			prterr("init_hugepages_buf failed for temp_buf");
> +			exit(101);
> +		}
> +	} else {
> +		unsigned long good_buf_len = maxfilelen + writebdy;
> +		unsigned long temp_buf_len = maxoplen + readbdy;
> +
> +		good_buf = (char *) malloc(good_buf_len);
> +		memset(good_buf, '\0', good_buf_len);
minor:  maybe good_buf = (char *)calloc(1, good_buf_len); So we don't 
need to use memset.
> +		temp_buf = (char *) malloc(temp_buf_len);
> +		memset(temp_buf, '\0', temp_buf_len);
> +	}
> +	good_buf = round_ptr_up(good_buf, writebdy, 0);
> +	temp_buf = round_ptr_up(temp_buf, readbdy, 0);
> +}
> +
>   static struct option longopts[] = {
>   	{"replay-ops", required_argument, 0, 256},
>   	{"record-ops", optional_argument, 0, 255},
> @@ -2883,7 +2974,7 @@ main(int argc, char **argv)
>   	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>   
>   	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:i:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>   				 longopts, NULL)) != EOF)
>   		switch (ch) {
>   		case 'b':
> @@ -2916,6 +3007,9 @@ main(int argc, char **argv)
>   		case 'g':
>   			filldata = *optarg;
>   			break;
> +		case 'h':
> +			hugepages = 1;
> +			break;
>   		case 'i':
>   			integrity = 1;
>   			logdev = strdup(optarg);
> @@ -3229,15 +3323,7 @@ main(int argc, char **argv)
>   			exit(95);
>   		}
>   	}
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
>   	if (lite) {	/* zero entire existing file */
>   		ssize_t written;
>   

-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


