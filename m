Return-Path: <linux-fsdevel+bounces-38092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CD9FB9F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 07:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713DE165243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446814B976;
	Tue, 24 Dec 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iuTkJ6f+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7108C07;
	Tue, 24 Dec 2024 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735022748; cv=none; b=t9CSbgAL5euxbHWj975kvByWpuDM+yi4K0h25UDfuHluwLMG+EqBtVp3xyH10xuygsxl2KXmVRGK/xuarRrJiQyjCj4LxlEgcdQFaMIXRkgenTeSdegg3BIZRqHfIGHDKOrLUiZwiMN3naVI2sxWB4NdSPtuXxcX90t88YP0taU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735022748; c=relaxed/simple;
	bh=r9cDYQV1DVMAUtK7deOw0aSe/81QtkVOdbbBkvmCyCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM0nQIsQVwYneLwu8jHKaKrK0FbJaDSGaNj7nGyczuy2nmZ7HaGVr2ilU1wjCrTWR25YZxmqcYQ6u4TQY4/HTgdRRKCnQst8Gj87CJXKQSCclGLH2fXGuNuDcDLpZQmwAAC9dwkq7SjI5hLmic7jcssosPumj4HTYSfFXSuPwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iuTkJ6f+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO3qLAq025502;
	Tue, 24 Dec 2024 06:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yXtHRyzcWuZiacWSfGUX+ZSWLpiC9b
	k7ZPjt5ODnHyg=; b=iuTkJ6f+z/5hzMcUUKrdqPFxRN+CEY5zGHvJ4OQ0jhzlaC
	Y4cyu8pS5tt/vdaMMJLVjvVK7wRKh5shOfndgAh10QpIN4EfXoSvFhzcoStc04F3
	7QoT6ATdxh0hPGVmUbMxold+VAR41xjrQHrPsIpOoyRBncCgNYDYFGEIWp4lW0+y
	JPI5kPd9KgqKEjjJdTKBv7VAyKPGZttyLKAcDFr4eOJOSpplymBhElKb8vsJ+dyF
	rQfi/kE70a1OKhCa2j/4VUeSgDSsQhcvWvKTsCnyqLFoz6K4CAvKGfkAbDFkpoJK
	UMGix4wwBEcTxvDEvwilBcPZ5t2BEHTILDYZA7Ag==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43qnebrj0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 06:45:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO611bW029683;
	Tue, 24 Dec 2024 06:45:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p9gkgw8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 06:45:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BO6jAuM56885566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 06:45:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD2E2004E;
	Tue, 24 Dec 2024 06:45:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 634212004B;
	Tue, 24 Dec 2024 06:45:06 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.25.147])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 24 Dec 2024 06:45:06 +0000 (GMT)
Date: Tue, 24 Dec 2024 12:15:04 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
Message-ID: <Z2pYVqXKLvM2xwKt@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3G0sEF3op7RbfghrizJj16s4v7kGDS0A
X-Proofpoint-GUID: 3G0sEF3op7RbfghrizJj16s4v7kGDS0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=997 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240052

On Mon, Dec 23, 2024 at 10:39:30AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Expand this test to include a zeroing range test that spans two partial
> pages to cover this case.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  tests/generic/567     | 50 +++++++++++++++++++++++++------------------
>  tests/generic/567.out | 18 ++++++++++++++++
>  2 files changed, 47 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/generic/567 b/tests/generic/567
> index fc109d0d..756280e8 100755
> --- a/tests/generic/567
> +++ b/tests/generic/567
> @@ -4,43 +4,51 @@
>  #
>  # FS QA Test No. generic/567
>  #
> -# Test mapped writes against punch-hole to ensure we get the data
> -# correctly written. This can expose data corruption bugs on filesystems
> -# where the block size is smaller than the page size.
> +# Test mapped writes against punch-hole and zero-range to ensure we get
> +# the data correctly written. This can expose data corruption bugs on
> +# filesystems where the block size is smaller than the page size.
>  #
>  # (generic/029 is a similar test but for truncate.)
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw punch
> +_begin_fstest auto quick rw punch zero
>  
>  # Import common functions.
>  . ./common/filter
>  
>  _require_scratch
>  _require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fzero"
>  
>  testfile=$SCRATCH_MNT/testfile
>  
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> -# Punch a hole straddling two pages to check that the mapped write after the
> -# hole-punching is correctly handled.
> -
> -$XFS_IO_PROG -t -f \
> --c "pwrite -S 0x58 0 12288" \
> --c "mmap -rw 0 12288" \
> --c "mwrite -S 0x5a 2048 8192" \
> --c "fpunch 2048 8192" \
> --c "mwrite -S 0x59 2048 8192" \
> --c "close"      \
> -$testfile | _filter_xfs_io
> -
> -echo "==== Pre-Remount ==="
> -_hexdump $testfile
> -_scratch_cycle_mount
> -echo "==== Post-Remount =="
> -_hexdump $testfile
> +# Punch a hole and zero out straddling two pages to check that the mapped
> +# write after the hole-punching and range-zeroing are correctly handled.
> +_straddling_test()
> +{
> +	local test_cmd=$1
> +
> +	$XFS_IO_PROG -t -f \
> +		-c "pwrite -S 0x58 0 12288" \
> +		-c "mmap -rw 0 12288" \
> +		-c "mwrite -S 0x5a 2048 8192" \
> +		-c "$test_cmd 2048 8192" \
> +		-c "mwrite -S 0x59 2048 8192" \
> +		-c "close"      \
> +	$testfile | _filter_xfs_io

Hey Zhang,

While we are at it, can we generalize the test to work for
non-4k page sizes as well.

Regards,
ojaswin
> +
> +	echo "==== Pre-Remount ==="
> +	_hexdump $testfile
> +	_scratch_cycle_mount
> +	echo "==== Post-Remount =="
> +	_hexdump $testfile
> +}
> +
> +_straddling_test "fpunch"
> +_straddling_test "fzero"
>  
>  status=0
>  exit
> diff --git a/tests/generic/567.out b/tests/generic/567.out
> index 0e826ed3..df89b8f3 100644
> --- a/tests/generic/567.out
> +++ b/tests/generic/567.out
> @@ -17,3 +17,21 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
>  *
>  003000
> +wrote 12288/12288 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> +*
> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +003000
> +==== Post-Remount ==
> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> +*
> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> +*
> +003000
> -- 
> 2.46.1
> 

