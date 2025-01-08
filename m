Return-Path: <linux-fsdevel+bounces-38645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D5A05771
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 10:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A773A0543
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AFE1F63FE;
	Wed,  8 Jan 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pl/iPMz4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19B17C7B1;
	Wed,  8 Jan 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330138; cv=none; b=JYrDRziM3jkfs7q10H9TEy/xEOXgSnioyufZa45XMFYDp0aMOc3qsTsLkz8rEpfKJ+5OR+MgwIKPUI1EvuCVzwjw+u3Bi6yh3/K0qtKU5gSKgZn86VAh4hGGzYtBo5kN9+rUSovnghhvxJXcbBDuJGRAh3aYxbwaWPIwk+I3Nx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330138; c=relaxed/simple;
	bh=lquRdGAtCnfZY7+a28gJZlXe6nNuHFKwS/7jafmzgYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZXuz7dstGclkoKpeHIKQKGJj2S1dmHE3COtIX8rQCEtqJf2KTkxSdIGINLJdrVTSY3hI3BsAjQNta5bRuwU1onE/EolYTuRm7n+V+YyJTpi5xtq3Yd2GVZseatD3g8D8sed+5BoAD6vHjo10aIQNPHAlKUg39es3psvowWHBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pl/iPMz4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507NaHHW026789;
	Wed, 8 Jan 2025 09:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=b4H80EQwwM7QNRTVgyCkZ9cadWELff
	VMC4axnQ5yO80=; b=Pl/iPMz4s6k6ICfr4U5IA1B3hCKkUN8/kYUL926fwstFz1
	MIr+ZGG5nlofsQWq39pLPWzcDvzTpfc6aWBRkk672qZqrjWVoxwDeslst9GkSmHd
	bamTheXisujIFqXsuLoBcLMQvPwnqO4u3TYhLS9sLGpaoP800mIWIp5LrEGLXhuf
	DcOLJI+ney1r0D/27sDLBQc8roFRO2yY8kLxvW3fTJUpY7kfHq3bLq/qVZQ2L8v9
	NsmZ2zhv9OytGrJfqO0Cs7auSlJm5CaqQ+FN8AQchHVUUo7P4QSSFvAgQgx0ScGZ
	ut8niAQ88igOIuIxwgBth9/neMe9oFJRnsh1jkqA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441e3b26a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 09:55:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5088vp6w008970;
	Wed, 8 Jan 2025 09:55:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyy870-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 09:55:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5089t45J50463050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 09:55:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEFA92004B;
	Wed,  8 Jan 2025 09:55:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06EE720043;
	Wed,  8 Jan 2025 09:55:02 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 09:55:01 +0000 (GMT)
Date: Wed, 8 Jan 2025 15:24:53 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        willy@infradead.org, djwong@kernel.org, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v2] generic: add a partial pages zeroing out test
Message-ID: <Z35LbZohVTVhTl--@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gh9koUuZfSKG9SGalRYBDxHSfQJvaM7b
X-Proofpoint-GUID: gh9koUuZfSKG9SGalRYBDxHSfQJvaM7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080077

On Wed, Dec 25, 2024 at 08:51:20PM +0800, Zhang Yi wrote:
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
> v1->v2:
>  - Add a new test instead of modifying generic/567.
>  - Generalize the test to work for non-4k page sizes.
> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> 
>  tests/generic/758     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/758.out |  3 ++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/generic/758
>  create mode 100644 tests/generic/758.out
> 
> diff --git a/tests/generic/758 b/tests/generic/758
> new file mode 100755
> index 00000000..e03b5e80
> --- /dev/null
> +++ b/tests/generic/758
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test No. generic/758
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
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $verifyfile $testfile
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_test
> +_require_scratch
> +_require_xfs_io_command "fzero"
> +
> +verifyfile=$TEST_DIR/verifyfile
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

Hi Zhang,

Thanks for making it work for non-4k pages. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

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

