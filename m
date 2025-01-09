Return-Path: <linux-fsdevel+bounces-38733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0F6A0767E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD2B168321
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628CD217F4E;
	Thu,  9 Jan 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WkDIfdqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E12010FD;
	Thu,  9 Jan 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428038; cv=none; b=iDQiNffDyLJp2GewQsxsf0Jp0i/VwvAMlv5nAUK0mg7DVDHNuxTPqLigt5bbD0KCbpq+vmwJ6OMc6eXLhTZAziNZ/wDNwnMwmmar4yGqITxetI8b1m70LfPMHZVIsccmvUBYiQP1r4i835uYdy8VIfcecs1M/81xjYLEobMLadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428038; c=relaxed/simple;
	bh=jxO0uETgdPlzzyXaDUrzPxUM75Hp+GjXHTRASlrNaRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKLLCP1a287VbWc8mqPiZ+f+T3LOEz/9LeQTbDuMmpn9OegIAkxe7aEs4p/K4+OKoSPQE/xBkw+S9UNA+PwvZwXJAqv3d9Dv+L5FkTjieX3nATId6nBzzfM+E45CvpbR3urf/j16IiyN8xlYF4kP0ZUEPyHVfd2KBN6MZeRGfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WkDIfdqd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093r58J020172;
	Thu, 9 Jan 2025 13:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7SuEC6uAszwAq24gll7+Wo9qhtTze/
	HCGjBgA1GCGO0=; b=WkDIfdqd2ZpXBC/pAgyc3LrrYkcoHB0hzHEohBswCgXb1R
	VvQ2N8AEItDDgERyIWlfrHhxASwxGPw7EKKRHuB6tUO75GOVSBqKAPVRH5femuCb
	O2HruHEVHEra25dNYxRVwRnaU1g0K2XNCE/vIBE3g3F47jMce8EnbEHdKPTuW5im
	Lh6DfrsT9lkqUpLQMMI0p3HmFpLvZSKgZaatSMkPbeq0xMl1o5GOKODFL3PszR5B
	3crt+5bKShhsWzahSNT2vk9/BIHJiNJXg5kRtFxb+UjR5hzSalFzNuZkuQvhxTI8
	rxnqrAK0KkPxeci9xAjNHpDiL8lepnkQSi2B13Hg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xqt7p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:06:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50996lkw015809;
	Thu, 9 Jan 2025 13:06:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm5408-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:06:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509D6h6456361352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 13:06:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1219A2004D;
	Thu,  9 Jan 2025 13:06:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2A8020040;
	Thu,  9 Jan 2025 13:06:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jan 2025 13:06:39 +0000 (GMT)
Date: Thu, 9 Jan 2025 18:36:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        willy@infradead.org, djwong@kernel.org, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v3] generic: add a partial pages zeroing out test
Message-ID: <Z3_J3OLnQkW8LVl6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108084407.1575909-1-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y5gO_WNs7AGQCqzlTDfZEshW2otXLB4f
X-Proofpoint-ORIG-GUID: y5gO_WNs7AGQCqzlTDfZEshW2otXLB4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090104

On Wed, Jan 08, 2025 at 04:44:07PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> This addresses a data corruption issue encountered during partial page
> zeroing in ext4 which the block size is smaller than the page size [1].
> Add a new test which is expanded upon generic/567, this test performs a
> zeroing range test that spans two partial pages to cover this case, and
> also generalize it to work for non-4k page sizes.
> 
> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v3:
>  - Put the verifyfile in $SCRATCH_MNT and remove the overriding
>    _cleanup.
>  - Correct the test name.
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v2: https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> 
>  tests/generic/758     | 68 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..bf0a342b
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. 758
> +#
> +# Test mapped writes against zero-range to ensure we get the data
> +# correctly written. This can expose data corruption bugs on filesystems
> +# where the block size is smaller than the page size.
> +#
> +# (generic/567 is a similar test but for punch hole.)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw zero
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$SCRATCH_MNT/verifyfile
> +testfile=$SCRATCH_MNT/testfile
> +
> +pagesz=$(getconf PAGE_SIZE)
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +_dump_files()
> +{
> +	echo "---- testfile ----"
> +	_hexdump $testfile
> +	echo "---- verifyfile --"
> +	_hexdump $verifyfile
> +}
> +
> +# Build verify file, the data in this file should be consistent with
> +# that in the test file.
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +		$verifyfile | _filter_xfs_io >> /dev/null
> +
> +# Zero out straddling two pages to check that the mapped write after the
> +# range-zeroing are correctly handled.
> +$XFS_IO_PROG -t -f \
> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> +	-c "mmap -rw 0 $((pagesz * 3))" \
> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> +	-c "close"      \
> +$testfile | _filter_xfs_io > $seqres.full
> +
> +echo "==== Pre-Remount ==="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match pre-remount."
> +	_dump_files
> +fi
> +_scratch_cycle_mount
> +echo "==== Post-Remount =="
> +if ! cmp -s $testfile $verifyfile; then
> +	echo "Data does not match post-remount."
> +	_dump_files
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/758.out b/tests/generic/758.out
> new file mode 100644
> index 00000000..d01c1959
> --- /dev/null
> +++ b/tests/generic/758.out
> @@ -0,0 +1,3 @@
> +QA output created by 758
> +==== Pre-Remount ===
> +==== Post-Remount ==
> -- 
> 2.39.2
> 

