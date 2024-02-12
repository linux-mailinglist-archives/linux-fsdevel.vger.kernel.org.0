Return-Path: <linux-fsdevel+bounces-11111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F5851306
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 13:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDDF1C21F18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B8A3D0D2;
	Mon, 12 Feb 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LEhPO0Y2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D13D0A8;
	Mon, 12 Feb 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739374; cv=none; b=LXrx1MDm6WZfVyzEYIlyEqAVDrppI4z7aEZDvE9HXY7T27eHeoSdEeV+xwYVvdZE0Bk1AWLKizB4AclNuTvIQQch4bWH9aL11CyM5+LYcm0SaZBFfwKEHh0uGnUF5Lei5rLA0FkLxj/BxUnOlHQSy9mUBNbIZf0o/nyOSQxSXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739374; c=relaxed/simple;
	bh=qTs4pmRhkWrU86rLUbk4gL5rcAV4yNZx6VSPad5e3vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMteucOGZtgFF4dtPBp8HUR7+TNbXsvPE6q9R0S7wxlwiIG8VEIisa1dR1x3QbQES2eFxEMljZ3Me/NwCMEwpSMLuTn9fWROpYc4zTj9wkThujVMa7jEJw6DhG8/p+dYBpbTjNasXUUXjn3rup6smy0Rl3RRvdmCQIKTWA+WRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LEhPO0Y2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBxpc8019223;
	Mon, 12 Feb 2024 12:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YJwOyB26zpENJsbMFuKna5WNVCpfnRlTrcC0jJUIE6I=;
 b=LEhPO0Y2LgHEhBSc2hT2MvSoUOspss/4W+42H4wTvZXpxNugAPXQkLnDhDx4dS5ERovW
 evtrC6nWeJLLUk7t7GCXJzCbLMIVDMscaDm2hMW+WkhpZCGtZoJr4Ol2BHH/w/jjfOff
 WYWweAfSyLGUV7VWuu+GmmyypPJ1FxTllSHZN/Z6HEHkCKaKGENks2ONa6qd7khN0LAq
 HZ3qyPdnCw1LflWEeUVEkeVL5+Ls4vclGPC6QAFpi8LdWA4Bo12RPIWuI66KC7iOAjzG
 W8Lwnr2GSRZaAYzSd32hAJ4+GX2xsZ/bBJWCB0a/l5WMIZthLIDaOHv+YOKJ69KUsVtj UA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jxt8517-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:02:28 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CC07Lu020727;
	Mon, 12 Feb 2024 12:02:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jxt84fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:02:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41C9KOSa032596;
	Mon, 12 Feb 2024 12:01:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kft8nfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 12:01:32 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CC1TE710617556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 12:01:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE2658064;
	Mon, 12 Feb 2024 12:01:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAA1158066;
	Mon, 12 Feb 2024 12:01:21 +0000 (GMT)
Received: from [9.109.198.187] (unknown [9.109.198.187])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 12:01:21 +0000 (GMT)
Message-ID: <76b6067f-109f-464c-97fb-fa519f3d1c56@linux.ibm.com>
Date: Mon, 12 Feb 2024 17:31:20 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] block: Add checks to merging of atomic writes
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-10-john.g.garry@oracle.com>
 <20240212105444.43262-1-nilay@linux.ibm.com>
 <484a449b-5c7e-4766-97d3-36b01c78687c@oracle.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <484a449b-5c7e-4766-97d3-36b01c78687c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B2dfMfSJRgps0Gdgt4dUb_kj3eYMZmpg
X-Proofpoint-GUID: HOcnTpxZ3fhpvWkDTSso8nxFZzTevVO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=979 spamscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120091



On 2/12/24 16:50, John Garry wrote:
> I'm not sure what is going on with your mail client here.

Sorry for the inconvenience, I will check the settings.

>>
>> So is it a good idea to validate here whether we could potentially exceed
>>
>> the atomic-write-max-unit-size supported by device before we allow merging?
> 
> Note that we have atomic_write_max_bytes and atomic_write_max_unit_size, and they are not always the same thing.
> 
>>
>> In case we exceed the atomic-write-max-unit-size post merge then don't allow
>>
>> merging?
> 
> We check this elsewhere. I just expanded the normal check for max request size to cover atomic writes.
> 
> Normally we check that a merged request would not exceed max_sectors value, and this max_sectors value can be got from blk_queue_get_max_sectors().
> 
> So if you check a function like ll_back_merge_fn(), we have a merging size check:
> 
>     if (blk_rq_sectors(req) + bio_sectors(bio) >
>         blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
>         req_set_nomerge(req->q, req);
>         return 0;
>     }
> 
> And here the blk_rq_get_max_sectors() -> blk_queue_get_max_sectors() call now also supports atomic writes (see patch #7):
OK got it. I think I have missed this part.

> 
> @@ -167,7 +167,16 @@ static inline unsigned get_max_io_size(struct bio *bio,
>  {
> ...
> 
> +    if (bio->bi_opf & REQ_ATOMIC)
> +        max_sectors = lim->atomic_write_max_sectors;
> +    else
> +        max_sectors = lim->max_sectors;
> 
> Note that we do not allow merging of atomic and non-atomic writes.
> 
Yeah 

Thanks,
--Nilay

