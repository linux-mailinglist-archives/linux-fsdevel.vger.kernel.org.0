Return-Path: <linux-fsdevel+bounces-38258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5FA9FE25B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 05:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504C018821B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 04:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3115350B;
	Mon, 30 Dec 2024 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTEwsNRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62F171C9;
	Mon, 30 Dec 2024 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735532245; cv=none; b=qyRnAJWWi43OeAO7As0pBQP+xoLSyXpHzxNQIAFeO78AtWHnp0AW37zhnfTMi5DAAWd2aOY4UtYvMySoGkpP9qRgs94YMux0Uk+V5B5u5VYDxKeW/FGfk/Xb57aJlvWnzXD2MOZnWFDE1XuF2djtURxtCL618W545jz/IE34EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735532245; c=relaxed/simple;
	bh=NLE1O3H4FHga76WxJH0DsaWvVlCO/f3ZOmSdLNGA4zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2G+CVE7cYQxjdu7WY3AqE6UlY6+N9/ii898FtBmqBewQidYbYrQIs9N4FtoIQ6AQlyGV9z+lfeZ+T4mBHz5pfeb/j21Q+PZj7eOXAqFRncA6bfs5/dHPLpP2cuaee+beT0CKK761k0A2qiq2xTcDFbSu7sc5jIbIVyP5REmDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PTEwsNRa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU3qYUc015272;
	Mon, 30 Dec 2024 04:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i+rAYS
	DBFjxdkkJAJF5Sw8fzN0VH7kbJrQHbj5OmlKw=; b=PTEwsNRaHNQYXCIXGz4Xxv
	fY8CApNX2V8mcmRQTa0sf51CE/tNqVViPDwtYFPn+MdXo/rHieHuJQBjW+TiP3Eg
	Q/E9jNT6hMvzYwp3RjItwtBceZNRMtJRd4iW7HjivW1mnereuMdbNjEHeCSHKBLm
	Nrc6utjBfopeVgtZXv0GvrDbzd0DLCd1Q2jAFKhsP678Uv5hFMdSDEaySdtFdy+Y
	VNpHxfS9H80vrL8Z+OQ53mcKBmrt+Q6IDYxv9bDs9lxbddg8FQqi4mSIkJSByVys
	ZCct0p5RobpYyTe/rfzh4L/erKe6mXEd2KVcVTElyP1i9O0821rMl4T/HrUf0cow
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43um0b8272-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 04:16:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU0U5nZ010184;
	Mon, 30 Dec 2024 04:16:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tvnn43ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 04:16:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BU4GP7q35521240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 04:16:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CD4C2004E;
	Mon, 30 Dec 2024 04:16:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6778A20043;
	Mon, 30 Dec 2024 04:16:23 +0000 (GMT)
Received: from [9.109.247.80] (unknown [9.109.247.80])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Dec 2024 04:16:23 +0000 (GMT)
Message-ID: <a1749e83-9c29-45b7-be4c-bca1a32ee85a@linux.ibm.com>
Date: Mon, 30 Dec 2024 09:46:22 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests PATCH] generic/567: add partial pages zeroing out case
To: Zhang Yi <yi.zhang@huaweicloud.com>, fstests@vger.kernel.org,
        zlang@kernel.org
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, willy@infradead.org, ojaswin@linux.ibm.com,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
References: <20241223023930.2328634-1-yi.zhang@huaweicloud.com>
 <7e77d8d1bf4521a727247badd6b6231256abb791.camel@linux.ibm.com>
 <67ae32aa-11e1-4e7f-b911-2546856564c2@huaweicloud.com>
Content-Language: en-US
From: Nirjhar Roy <nirjhar@linux.ibm.com>
In-Reply-To: <67ae32aa-11e1-4e7f-b911-2546856564c2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GyrIubHtt1G-wn5Bn-sKRht7PZbUEm8i
X-Proofpoint-ORIG-GUID: GyrIubHtt1G-wn5Bn-sKRht7PZbUEm8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412300030


On 12/27/24 13:59, Zhang Yi wrote:
> On 2024/12/27 13:28, Nirjhar Roy wrote:
>> On Mon, 2024-12-23 at 10:39 +0800, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> This addresses a data corruption issue encountered during partial
>>> page
>>> zeroing in ext4 which the block size is smaller than the page size
>>> [1].
>>> Expand this test to include a zeroing range test that spans two
>>> partial
>>> pages to cover this case.
>>>
>>> Link:
>>> https://lore.kernel.org/linux-ext4/20241220011637.1157197-2-yi.zhang@huaweicloud.com/
>>>   [1]
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ---
>>>   tests/generic/567     | 50 +++++++++++++++++++++++++--------------
>>> ----
>>>   tests/generic/567.out | 18 ++++++++++++++++
>>>   2 files changed, 47 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/tests/generic/567 b/tests/generic/567
>>> index fc109d0d..756280e8 100755
>>> --- a/tests/generic/567
>>> +++ b/tests/generic/567
>>> @@ -4,43 +4,51 @@
>>>   #
>>>   # FS QA Test No. generic/567
>>>   #
>>> -# Test mapped writes against punch-hole to ensure we get the data
>>> -# correctly written. This can expose data corruption bugs on
>>> filesystems
>>> -# where the block size is smaller than the page size.
>>> +# Test mapped writes against punch-hole and zero-range to ensure we
>>> get
>>> +# the data correctly written. This can expose data corruption bugs
>>> on
>>> +# filesystems where the block size is smaller than the page size.
>>>   #
>>>   # (generic/029 is a similar test but for truncate.)
>>>   #
>>>   . ./common/preamble
>>> -_begin_fstest auto quick rw punch
>>> +_begin_fstest auto quick rw punch zero
>>>   
>>>   # Import common functions.
>>>   . ./common/filter
>>>   
>>>   _require_scratch
>>>   _require_xfs_io_command "fpunch"
>>> +_require_xfs_io_command "fzero"
>>>   
>>>   testfile=$SCRATCH_MNT/testfile
>>>   
>>>   _scratch_mkfs > /dev/null 2>&1
>> Since this test requires block size < page size, do you think it is a
>> good idea to hard code the _scratch_mkfs parameters to explicitly pass
>> the block size to < less than zero? This will require less manipulation
>> with the local.config file. Or maybe have a _notrun to _notrun the test
>> if the block size is not less than the page size?
> Hi, Nirjhar. Thank you for the review!
>
> Although the issue we encountered is on the configuration that block
> size is less than page size, I believe it is also harmless to run this
> test in an environment where the block size is equal to the page size.
> This is a quick and basic test.
Okay makes sense. So with block size equal to page size, the actual 
functionality that we want to test won't be tested(but the test will 
pass), is that what you mean?
>
>>>   _scratch_mount
>>>   
>>> -# Punch a hole straddling two pages to check that the mapped write
>>> after the
>>> -# hole-punching is correctly handled.
>>> -
>>> -$XFS_IO_PROG -t -f \
>>> --c "pwrite -S 0x58 0 12288" \
>>> --c "mmap -rw 0 12288" \
>>> --c "mwrite -S 0x5a 2048 8192" \
>>> --c "fpunch 2048 8192" \
>>> --c "mwrite -S 0x59 2048 8192" \
>>> --c "close"
>> Minor: isn't the close command redundant? xfs_io will in any case close
>> the file right?
> Yes, but this explicit close is from the original text and appears
> harmless, so I'd suggest keeping it.
Okay.
>
>>>       \
>>> -$testfile | _filter_xfs_io
>>> -
>>> -echo "==== Pre-Remount ==="
>>> -_hexdump $testfile
>>> -_scratch_cycle_mount
>>> -echo "==== Post-Remount =="
>>> -_hexdump $testfile
>>> +# Punch a hole and zero out straddling two pages to check that the
>>> mapped
>>> +# write after the hole-punching and range-zeroing are correctly
>>> handled.
>>> +_straddling_test()
>>> +{
>>> +	local test_cmd=$1
>>> +
>>> +	$XFS_IO_PROG -t -f \
>>> +		-c "pwrite -S 0x58 0 12288" \
>>> +		-c "mmap -rw 0 12288" \
>>> +		-c "mwrite -S 0x5a 2048 8192" \
>>> +		-c "$test_cmd 2048 8192" \
>>> +		-c "mwrite -S 0x59 2048 8192" \
>>> +		-c "close"      \
>>> +	$testfile | _filter_xfs_io
>>> +
>>> +	echo "==== Pre-Remount ==="
>>> +	_hexdump $testfile
>>> +	_scratch_cycle_mount
>>> +	echo "==== Post-Remount =="
>>> +	_hexdump $testfile
>> Just guessing here: Do you think it is makes sense to test with both
>> delayed and non-delayed allocation? I mean with and without "msync"?
> Sorry, I don't understand why we need msync. The umount should flush
> the dirty pages to the disk even without msync, I mean this this test
> does not focus on the functionality of msync now.
Okay makes sense.
>
>>> +}
>>> +
>>> +_straddling_test "fpunch"
>>> +_straddling_test "fzero"
>> Minor: Since we are running 2 independant sub-tests, isn't it better to
>> use 2 different files?
>>
> Yes, Darrick had the same suggestion, and I have separated this into
> generic/758 in my v2.
Okay.
>
>    https://lore.kernel.org/fstests/20241225125120.1952219-1-yi.zhang@huaweicloud.com/
>
> Thanks,
> Yi.
>
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


