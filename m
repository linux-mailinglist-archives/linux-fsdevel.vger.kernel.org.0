Return-Path: <linux-fsdevel+bounces-38155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6E09FD06E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 06:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EBB3A0561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6313665B;
	Fri, 27 Dec 2024 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ac3O0P3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543851876;
	Fri, 27 Dec 2024 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735277384; cv=none; b=raanDqXvshqmKIpT4WtDVg0qeEUkWhkEQYNQwyXFUvzYESGu1NdIdpBEBJ3OAObfJtJRxNnfkkyb1WW8dwJrFqHEGWzVIjNr3tmk0HVX1y27v257K2KCd92QnhQpFTgu5vAgVWAIW62BIAUiSmxlHz52ZfO50Mf2zOEE26byKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735277384; c=relaxed/simple;
	bh=ng4j3YRHs2oRws2y5VLSHSr0q/FUfcOfrjmQkA6PFcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=u2KSWQu6BzCJhSudj5zSxpTb2e9vnN7J5ZsgyW9ynNVXVyeVvBn3HRSxKh2OKIeuUjVtRsvcMhbB2/dCCaaUFL5hLsAyEfBOzbhPrP8Elsgs2bXwiPh6UCTD87MGoQWFRUQa89LeyroYNdWfNxhrxGkj+KemEsvVG8riBO99BWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ac3O0P3G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR3t3jd012756;
	Fri, 27 Dec 2024 05:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cp5rKT
	v/3U5cMQGQDOfSdMxWtsLTJ6wC63vJwb28Gts=; b=Ac3O0P3G2W2ESRX8Ljqbt3
	GlijiEpyiA2Ex4KUfVaHl5bzvAoKHf2cnC+bJ8pUP2vkEJJl5GrCEA07HELW9Jna
	wNzJIHPYVRJxlNVveK8eE11wx0HLkJJInGl3qP1O//POAqLvL1iu2Lg0C2O83Hfx
	4trhW3ql0/u5yR5SzONBVIhi8hnSVTJeUfBkNdGMncFqIdKly0Dc9nXI8a5mE5sf
	KjfxBGqxYMMvKnRw3QQKIqP6B6oOzsYl5UtLNLKzvgUTiBZq2dzogQMxGk5foVxM
	PfeAXXYz+zTeQA2bsD8BvqvsDgpmpVKTGzPYatfKsdO3t14X+pAU0hEdaOo+36SA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43smqc07ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 05:29:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR2ajC6010606;
	Fri, 27 Dec 2024 05:28:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43p90ncp1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 05:28:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BR5Su1j32899734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Dec 2024 05:28:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD1420043;
	Fri, 27 Dec 2024 05:28:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F99B20040;
	Fri, 27 Dec 2024 05:28:54 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com (unknown [9.124.219.178])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Dec 2024 05:28:53 +0000 (GMT)
Message-ID: <7e77d8d1bf4521a727247badd6b6231256abb791.camel@linux.ibm.com>
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, fstests@vger.kernel.org,
        zlang@kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, willy@infradead.org, ojaswin@linux.ibm.com,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Date: Fri, 27 Dec 2024 10:58:53 +0530
In-Reply-To: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: cHYpdIJPtGHdNKErx2wkN0AfhHwhgMTD
X-Proofpoint-GUID: cHYpdIJPtGHdNKErx2wkN0AfhHwhgMTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412270045

On Mon, 2024-12-23 at 10:39 +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial
> page
> zeroing in ext4 which the block size is smaller than the page size
> [1].
> Expand this test to include a zeroing range test that spans two
> partial
> pages to cover this case.
> 
> Link: 
> https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/
>  [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  tests/generic/567     | 50 +++++++++++++++++++++++++--------------
> ----
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
> -# correctly written. This can expose data corruption bugs on
> filesystems
> -# where the block size is smaller than the page size.
> +# Test mapped writes against punch-hole and zero-range to ensure we
> get
> +# the data correctly written. This can expose data corruption bugs
> on
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
Since this test requires block size < page size, do you think it is a
good idea to hard code the _scratch_mkfs parameters to explicitly pass
the block size to < less than zero? This will require less manipulation
with the local.config file. Or maybe have a _notrun to _notrun the test
if the block size is not less than the page size?
>  _scratch_mount
>  
> -# Punch a hole straddling two pages to check that the mapped write
> after the
> -# hole-punching is correctly handled.
> -
> -$XFS_IO_PROG -t -f \
> --c "pwrite -S 0x58 0 12288" \
> --c "mmap -rw 0 12288" \
> --c "mwrite -S 0x5a 2048 8192" \
> --c "fpunch 2048 8192" \
> --c "mwrite -S 0x59 2048 8192" \
> --c "close" 
Minor: isn't the close command redundant? xfs_io will in any case close
the file right?
>      \
> -$testfile | _filter_xfs_io
> -
> -echo "==== Pre-Remount ==="
> -_hexdump $testfile
> -_scratch_cycle_mount
> -echo "==== Post-Remount =="
> -_hexdump $testfile
> +# Punch a hole and zero out straddling two pages to check that the
> mapped
> +# write after the hole-punching and range-zeroing are correctly
> handled.
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
> +
> +	echo "==== Pre-Remount ==="
> +	_hexdump $testfile
> +	_scratch_cycle_mount
> +	echo "==== Post-Remount =="
> +	_hexdump $testfile
Just guessing here: Do you think it is makes sense to test with both
delayed and non-delayed allocation? I mean with and without "msync"?
> +}
> +
> +_straddling_test "fpunch"
> +_straddling_test "fzero"
Minor: Since we are running 2 independant sub-tests, isn't it better to
use 2 different files?

--NR
>  
>  status=0
>  exit
> diff --git a/tests/generic/567.out b/tests/generic/567.out
> index 0e826ed3..df89b8f3 100644
> --- a/tests/generic/567.out
> +++ b/tests/generic/567.out
> @@ -17,3 +17,21 @@ XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX
> ops/sec)
>  002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> 58  >XXXXXXXXXXXXXXXX<
>  *
>  003000
> +wrote 12288/12288 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> 58  >XXXXXXXXXXXXXXXX<
> +*
> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> 59  >YYYYYYYYYYYYYYYY<
> +*
> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> 58  >XXXXXXXXXXXXXXXX<
> +*
> +003000
> +==== Post-Remount ==
> +000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> 58  >XXXXXXXXXXXXXXXX<
> +*
> +000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> 59  >YYYYYYYYYYYYYYYY<
> +*
> +002800 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> 58  >XXXXXXXXXXXXXXXX<
> +*
> +003000


