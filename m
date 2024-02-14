Return-Path: <linux-fsdevel+bounces-11584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FD854EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DBA1C29892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486E605D1;
	Wed, 14 Feb 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PgkUDikR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3B604A7;
	Wed, 14 Feb 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929197; cv=none; b=VHpopRm+Zk8Ce/Mr+nKyT9Fmg+1xQWVKW5jnPmKYkCEHlZeepR8iqQE/NPzZp+5ktKOyEc2VcQ2Q635iM9QzVJTXUkU557KAGJi3zAyO4DM2ZEMnJWfKfFlKmgGDDPo5sh+Z5kx98e9gEi7HypX/c+3gW00djcb4AEH+ZptbFfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929197; c=relaxed/simple;
	bh=yn5SllOUHmTKd7QRKLP+uTGbxLc0Lgu7inDoJtTRlXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZIHpBU1p3mbOuljrYCaaVGmEScGEseRUysW62ku4T1AFnAA/0w+RGrGB0NiKwWiYQ/tWO7dX9y4DW8siHvbf7pmXObf/FbEUPq4cJlngEYJ0+GOxG5NEeLRcbLmTlfzRXnUWWQ/zbr7NiF6Guu5l7y+jFoV8I89uKqhE1rAMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PgkUDikR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGHqX8020289;
	Wed, 14 Feb 2024 16:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CnFd8ajdxH/cc7VfH42WSgZbWCF+UOq3S7aRofknueM=;
 b=PgkUDikRjBI7x1XiMVyE0fJUYWDpQqAWw6+G4Pyiqbl2T2I1RZ86XjhckO6udra17/M/
 xO6IN7AaFdVFfYDaD3qsrszVlpVR/aziLc5CaLvEERwTPALyRVkd9nVcorjDUXbt8hic
 7mpJuJLmIXxNZfDufey4LX1BFiPGUpQ85e4c+oQUr257ca3vtBjXxjNZ7bzDOPneA7Vc
 GJS8TwZ/4AxlNh+LWmx2BgZSXyiv9+HVpQ0Q+MY8moz6+xX7KENbXsR252mx9jP33rh8
 BqACwl6rJ1QuUcogFxmLXF7onc+wibvex1Zq1CvzKCWTn7P+iNymsZbuB2qFLibyMzsa eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w90wp0t8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:46:05 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EGJgtK025776;
	Wed, 14 Feb 2024 16:46:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w90wp0t7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:46:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EFVq07032572;
	Wed, 14 Feb 2024 16:46:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftq9yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:46:03 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EGk0Oh5047142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 16:46:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 568CF58068;
	Wed, 14 Feb 2024 16:46:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8692558059;
	Wed, 14 Feb 2024 16:45:52 +0000 (GMT)
Received: from [9.171.46.73] (unknown [9.171.46.73])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 16:45:52 +0000 (GMT)
Message-ID: <1b4d5860-8044-4a1f-a801-1c69327076c1@linux.ibm.com>
Date: Wed, 14 Feb 2024 22:15:50 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>
Cc: alan.adamson@oracle.com, axboe@kernel.dk, brauner@kernel.org,
        bvanassche@acm.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        jack@suse.cz, jbongio@google.com, jejb@linux.ibm.com,
        kbusch@kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, ojaswin@linux.ibm.com, sagi@grimberg.me,
        tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-15-john.g.garry@oracle.com>
 <20240214122719.184946-1-nilay@linux.ibm.com>
 <8332ea29-ac17-4b1a-8ed9-e566d03fd220@oracle.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8332ea29-ac17-4b1a-8ed9-e566d03fd220@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xU5wfFpy2PP06fiDP3H7bm7SCO6PKL-V
X-Proofpoint-ORIG-GUID: BUhw35l4XwdwCK0voJZlxVR65GvJzXIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140130



On 2/14/24 18:32, John Garry wrote:
> On 14/02/2024 12:27, Nilay Shroff wrote:
>>
>>
>>
>>> Use following method to calculate limits:
>>
>>> atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
>>
> 
> You still need to fix that mail client to not add extra blank lines.
Yes, I am working on it. I hope it's solved now. 
> 
>>> atomic_write_unit_min = logical_block_size
>>
>>> atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
>>
>>> atomic_write_boundary = NABSPF
>>
>>
>>
>> In case the device doesn't support namespace atomic boundary size (i.e. NABSPF
>>
>> is zero) then while merging atomic block-IO we should allow merge.
>>
>>  
>> For example, while front/back merging the atomic block IO, we check whether
>>
>> boundary is defined or not. In case if boundary is not-defined (i.e. it's zero)
>>
>> then we simply reject merging ateempt (as implemented in
>>
>> rq_straddles_atomic_write_boundary()).
> 
> Are you sure about that? In rq_straddles_atomic_write_boundary(), if boundary == 0, then we return false, i.e. there is no boundary, so we can never be crossing it.
> 
> static bool rq_straddles_atomic_write_boundary(struct request *rq,
> unsigned int front,
> unsigned int back)
> {
>     unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
>     unsigned int mask, imask;
>     loff_t start, end;
> 
>     if (!boundary)
>         return false;
> 
>     ...
> }
> 
> And then will not reject a merge for that reason, like:
> 
> int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
> {
>     ...
> 
>     if (req->cmd_flags & REQ_ATOMIC) {
>         if (rq_straddles_atomic_write_boundary(req,
>             0, bio->bi_iter.bi_size)) {
>             return 0;
>         }
>     }
> 
>     return ll_new_hw_segment(req, bio, nr_segs);
> }
> 
> 
Aargh, you are right. I see that if rq_straddles_atomic_write_boundary() returns true then we avoid merge otherwise the merge is attempted. My bad...

Thanks,
--Nilay

