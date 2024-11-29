Return-Path: <linux-fsdevel+bounces-36127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DA9DC02A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 09:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7604428215D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 08:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419B15C158;
	Fri, 29 Nov 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TcTPMSXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2B155A34;
	Fri, 29 Nov 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867223; cv=none; b=ZCBjpVIPzu/9GLyrimTz9Qw0zx1hUIY44vfspS7dphzlQWpoxtcrHKdcsgDqlU23TlGVHksUEYCeym0wnGEVLlnqOvy83my0uSkjgrF40jkbDtV+C2dmI81pMPaMhLQGDz4Yl5F3iJCqH9mNweZmze5/ukKKZyIjB0fG507s3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867223; c=relaxed/simple;
	bh=EE0j3OFGnsz1j02CT8+neqmdL9qlDUKuUexQuyzC11Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3oRttdx3pkmQxRRxJRAyPg3smEgppIkz1iLxgfbm7C1SeU67Ot3SRfUCS8wbSoKJi6cKZx/VDtghAEqmIHm+WqnCNcsRoVWYAd02VwiYqjHTDeZRkHQ7JTgMCD4FWjcIyvmDAeT/uUkRD9nJ0pjdV0UzN74vPadRwEQqWmsr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TcTPMSXZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT4vZZx001985;
	Fri, 29 Nov 2024 08:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qa5MTM
	AN2Yo7nyBT06WXmdKxAMClxXhx/xz6OBXf3Eg=; b=TcTPMSXZR/owpFN9jiek9D
	VPwwQg0sf+z6NV2MXLssV/P2jqdmt4HHAKgWtCwT2AGe3sh04lRlgzdqRUF19dSf
	ERZw7jxMnRKGcq7EBZI4v5Tt75xAs6/AU1ikq9LCpiTFB/Va6X4lpZCCMxBoc2Kf
	wiVQElUUXOysUTlwFYeYVF1lXWUAuFaRJ1QOpTIkjZi/V5QzZrQ/52JWj6Lbuxbf
	GziBSed9KUUHQnzLOK6lQWZJvvBCQsmFrFTM6BE8cuyvUekkGoVmCcLWnM6iseiu
	tg2mFQKd6yaw0h6vNHlktc1e8qsJKdjnfoPlHENumKFLfJaOr+GG47Wq1jDuHQ4A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436tbec0m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:00:13 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AT7ubTm021316;
	Fri, 29 Nov 2024 08:00:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436tbec0ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:00:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT73SxB009796;
	Fri, 29 Nov 2024 08:00:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43672fjvt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:00:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AT809mJ65405420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 08:00:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7D9320106;
	Fri, 29 Nov 2024 08:00:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F6A220103;
	Fri, 29 Nov 2024 08:00:06 +0000 (GMT)
Received: from [9.61.255.2] (unknown [9.61.255.2])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 08:00:06 +0000 (GMT)
Message-ID: <e5702c85-9e69-4d53-9518-faf037dedad7@linux.ibm.com>
Date: Fri, 29 Nov 2024 13:30:04 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] quota: flush quota_release_work upon quota
 writeback
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20241121123855.645335-1-ojaswin@linux.ibm.com>
 <20241121123855.645335-2-ojaswin@linux.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20241121123855.645335-2-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ajlh7paxQCYScBl7QPZ0BvrJahxtsVJv
X-Proofpoint-ORIG-GUID: FyJAM0YoJt2WaNUMoU-q8LKSyfVdAxJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290064

On 21/11/24 6:08 pm, Ojaswin Mujoo wrote:

One of the paths quota writeback is called from is:

freeze_super()
   sync_filesystem()
     ext4_sync_fs()
       dquot_writeback_dquots()

Since we currently don't always flush the quota_release_work queue in
this path, we can end up with the following race:

  1. dquot are added to releasing_dquots list during regular operations.
  2. FS Freeze starts, however, this does not flush the quota_release_work queue.
  3. Freeze completes.
  4. Kernel eventually tries to flush the workqueue while FS is frozen which
     hits a WARN_ON since transaction gets started during frozen state:

   ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
   __ext4_journal_start_sb+0x64/0x1c0 [ext4]
   ext4_release_dquot+0x90/0x1d0 [ext4]
   quota_release_workfn+0x43c/0x4d0

Which is the following line:

   WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);

Which ultimately results in generic/390 failing due to dmesg
noise. This was detected on powerpc machine 15 cores.

To avoid this, make sure to flush the workqueue during
dquot_writeback_dquots() so we dont have any pending workitems after
freeze.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for the fix patch Ojaswin.
I have tested the patch on powerpc machine, and it fixes the generic/390 test failure.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

---
  fs/quota/dquot.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 3dd8d6f27725..f9578918cfb2 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -688,6 +688,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
  
  	WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));
  
+	flush_delayed_work(&quota_release_work);
+
  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
  		if (type != -1 && cnt != type)
  			continue;


