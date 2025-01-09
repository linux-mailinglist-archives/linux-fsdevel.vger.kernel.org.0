Return-Path: <linux-fsdevel+bounces-38734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A1A07680
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A88188A740
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71387217F4E;
	Thu,  9 Jan 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tGTpUg0P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF4BA2E;
	Thu,  9 Jan 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428077; cv=none; b=EJPtSuzkPZIj+sZ8kK/1+CHToTszBeuVrapD+dlov1h6K1j/L8pC8u6KGgF4NvfwlC4jp/5gl/TKsbB0g3RX7ORzcMwRNy+EvzmI1cxF6AXPpa/4CHsnnoL4TsHdKASgBMp8/30BYovySnpV8qXv80bfXdWbRoHkeGYQs4VMgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428077; c=relaxed/simple;
	bh=9C043N7PL0rLFLeXlDQqPD6ln5Dsg5/irMBI8luHc3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDNPXcaAwUsqTvEo3h786IrE5qqKAo0T1bHkbS20/xuwQutKIfNN/AwC//+iSyR84cPH1AVPWM8Ow9Wjp8xJWUQQsBBNDnuwQdUTnVfvBqm/CYShvXJpkoJo+wzZhVMQ3dtLUwEaFlcc201a/dTsJoWPef3lIemeeNNN2ydsTEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tGTpUg0P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509C4ZrN000831;
	Thu, 9 Jan 2025 13:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fgi8Cm5NKa7Yz0My3Ee7jds1+DSEe5
	1LaONjwXokVhQ=; b=tGTpUg0PN9rESwOphso/jwp7ZU9SpiwVwN63HLIDW46TCm
	boVDy/4z681eiAiBQo5UeJ5ien5re7IS43Yed3eYaf/G9nv/zjERPwFX9uMAV5sN
	3QHdylLLbVYwPZEKFleEAP9Snf2eqbzyzHGxFnjoB9TpzgirFEIgVhFcvh16jCVR
	9mLASchxzweElzr2zCUvU/JJxmz7AutyWiAO++BqxgZH+A2CmVsQKX/zyr+mB+kV
	kGUb48UNPNobNp7mkJX4njTgQALYKAALgT0pBGgHYqH2DJFDAskCwskljauRXZSr
	G/g3vYAIT4c2uDgHA+dR9V/4jM7uXjzRfbOw4fAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5n5jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:07:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509A0QM9026195;
	Thu, 9 Jan 2025 13:07:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj12cw42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 13:07:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509D7NuW33423696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 13:07:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D3822004B;
	Thu,  9 Jan 2025 13:07:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8397920040;
	Thu,  9 Jan 2025 13:07:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jan 2025 13:07:20 +0000 (GMT)
Date: Thu, 9 Jan 2025 18:37:15 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        willy@infradead.org, djwong@kernel.org, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [xfstests PATCH v2] generic: add a partial pages zeroing out test
Message-ID: <Z3_KA2ddaUQQiJwl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20241225125120.1952219-1-yi.zhang@huaweicloud.com>
 <Z35LbZohVTVhTl--@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <65cb61dd-e342-412d-91c7-4fb7baa68d5d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb61dd-e342-412d-91c7-4fb7baa68d5d@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EFpH6-L6u6HWZNfKweUTJYJC8YaajJBk
X-Proofpoint-ORIG-GUID: EFpH6-L6u6HWZNfKweUTJYJC8YaajJBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090104

On Wed, Jan 08, 2025 at 08:40:32PM +0800, Zhang Yi wrote:
> On 2025/1/8 17:54, Ojaswin Mujoo wrote:
> > On Wed, Dec 25, 2024 at 08:51:20PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> This addresses a data corruption issue encountered during partial page
> >> zeroing in ext4 which the block size is smaller than the page size [1].
> >> Add a new test which is expanded upon generic/567, this test performs a
> >> zeroing range test that spans two partial pages to cover this case, and
> >> also generalize it to work for non-4k page sizes.
> >>
> >> Link: https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/ [1]
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >> v1->v2:
> >>  - Add a new test instead of modifying generic/567.
> >>  - Generalize the test to work for non-4k page sizes.
> >> v1: https://lore.kernel.org/fstests/20241223023930.2328634-1-yi.zhang@huaweicloud.com/
> >>
> >>  tests/generic/758     | 76 +++++++++++++++++++++++++++++++++++++++++++
> >>  tests/generic/758.out |  3 ++
> >>  2 files changed, 79 insertions(+)
> >>  create mode 100755 tests/generic/758
> >>  create mode 100644 tests/generic/758.out
> >>
> >> diff --git a/tests/generic/758 b/tests/generic/758
> >> new file mode 100755
> >> index 00000000..e03b5e80
> >> --- /dev/null
> >> +++ b/tests/generic/758
> >> @@ -0,0 +1,76 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2024 Huawei.  All Rights Reserved.
> >> +#
> >> +# FS QA Test No. generic/758
> >> +#
> >> +# Test mapped writes against zero-range to ensure we get the data
> >> +# correctly written. This can expose data corruption bugs on filesystems
> >> +# where the block size is smaller than the page size.
> >> +#
> >> +# (generic/567 is a similar test but for punch hole.)
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick rw zero
> >> +
> >> +# Override the default cleanup function.
> >> +_cleanup()
> >> +{
> >> +	cd /
> >> +	rm -r -f $verifyfile $testfile
> >> +}
> >> +
> >> +# Import common functions.
> >> +. ./common/filter
> >> +
> >> +_require_test
> >> +_require_scratch
> >> +_require_xfs_io_command "fzero"
> >> +
> >> +verifyfile=$TEST_DIR/verifyfile
> >> +testfile=$SCRATCH_MNT/testfile
> >> +
> >> +pagesz=$(getconf PAGE_SIZE)
> >> +
> >> +_scratch_mkfs > /dev/null 2>&1
> >> +_scratch_mount
> >> +
> >> +_dump_files()
> >> +{
> >> +	echo "---- testfile ----"
> >> +	_hexdump $testfile
> >> +	echo "---- verifyfile --"
> >> +	_hexdump $verifyfile
> >> +}
> >> +
> >> +# Build verify file, the data in this file should be consistent with
> >> +# that in the test file.
> >> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((pagesz * 3))" \
> >> +		-c "pwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> >> +		$verifyfile | _filter_xfs_io >> /dev/null
> >> +
> >> +# Zero out straddling two pages to check that the mapped write after the
> >> +# range-zeroing are correctly handled.
> >> +$XFS_IO_PROG -t -f \
> >> +	-c "pwrite -S 0x58 0 $((pagesz * 3))" \
> >> +	-c "mmap -rw 0 $((pagesz * 3))" \
> >> +	-c "mwrite -S 0x5a $((pagesz / 2)) $((pagesz * 2))" \
> >> +	-c "fzero $((pagesz / 2)) $((pagesz * 2))" \
> >> +	-c "mwrite -S 0x59 $((pagesz / 2)) $((pagesz * 2))" \
> >> +	-c "close"      \
> > 
> > Hi Zhang,
> > 
> > Thanks for making it work for non-4k pages. Feel free to add:
> > 
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Hello Ojaswin!
> 
> Thank you very much for your review. I made some minor changes
> based on Darrick's comments and sent out v3 earlier today.
> Perhaps you would like to add your review tag to that one.
> 
> https://lore.kernel.org/fstests/20250108084407.1575909-1-yi.zhang@huaweicloud.com/

Thanks for pointing it out Zhang, I've reviewed the v3.

Thanks,
ojaswin
> 
> Thanks,
> Yi.
> 

