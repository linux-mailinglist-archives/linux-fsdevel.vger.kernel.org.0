Return-Path: <linux-fsdevel+bounces-10068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07162847782
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449FD1F2AD79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04E150995;
	Fri,  2 Feb 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q67p1Fhk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DE14D45D;
	Fri,  2 Feb 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898769; cv=none; b=mxfXkdtYydc2Vg7xTHjhcU7gO5eqbgSkgib/2e4AIWOOSYMlgWDhdSptrDgjE0CqBKWKvBSUxeB08ep7VNG+DTZDO+WDkYFjuS2QxRMvz+tuI7fFyroBjpw79DpFKTj6M1tJr6GbYqiwfz5hzKAQGb6fMYDjXsFvX1PInVaYB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898769; c=relaxed/simple;
	bh=UfHGiAvFtOSJrv/bEEj+r86zJwcN4KKZKKcctV4SItI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PP/Hqwk84dK4mTNqyuwp/NOUAf0SXzeEoQi3kKUEF8181EjXbH2f9w90eWdL+ZbiYUPN7/2DAUM9T2lDNE+EwdJitVZNLGZqyQH46fEtkvztlkqGsPnPx9H3+s2T18y8MXFe7DRvwbsQZ5O6QDe5dJF0ARukxHaA0G5BIoiq26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q67p1Fhk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412IJ7eS015611;
	Fri, 2 Feb 2024 18:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=d7rLd3L3xZkH1JMO0WTEfKRkCVyUsFbidN3Rs1cTnIs=;
 b=q67p1FhkIOo29wkkSSzqwTHj8GU89lWcoAjxfRHwwuK53C2cxO4sq3LL2J14bU5m51rq
 mf1a8/cWwKQkM8nk5AFthYuV5EMr9tH8QeY9eEVIaMa4bNtBDsebAoL5wLEAGxoJl2/G
 qhMp5v5rs9jraoh+JeGhi90IdVnpXzoESptnU57TynCb7jMJpBYRUOemMHZj6QPoXubU
 YQkUghzN2DM+LHjH6fzS67O4tldwi23an0Vj0AlYvQcshQSblMbK3LFNpmum/ivyvc/o
 kYHOWOD+SO90yxArI3fC/mimluwHFMTEx27Mjctp4o1bT5WSGihMHdKLTkOT1Q0khcZy IA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w13k5ka0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 18:32:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412IL2rp020728;
	Fri, 2 Feb 2024 18:32:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w13k5ka0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 18:32:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412I7uL4010511;
	Fri, 2 Feb 2024 18:32:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pd29f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 18:32:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412IWeQL44434118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 18:32:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA7758056;
	Fri,  2 Feb 2024 18:32:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039A858052;
	Fri,  2 Feb 2024 18:32:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 18:32:39 +0000 (GMT)
Message-ID: <4662633b-47c0-469f-9578-8597bcc65703@linux.ibm.com>
Date: Fri, 2 Feb 2024 13:32:39 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <20240202160509.GZ2087318@ZenIV> <20240202161601.GA976131@ZenIV>
 <063577b8-3d7f-4a7f-8ed7-332601c98122@linux.ibm.com>
 <20240202182732.GE2087318@ZenIV>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240202182732.GE2087318@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1OXQezjmRTsmSX7fE9rqVmzfRwRFsj4K
X-Proofpoint-ORIG-GUID: c83E1WSG1ZgD6oaswru3ro170Qj-P9So
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020134



On 2/2/24 13:27, Al Viro wrote:
> On Fri, Feb 02, 2024 at 12:34:15PM -0500, Stefan Berger wrote:
> 
>> I suppose this would provide a stable name?
>>
>> diff --git a/security/integrity/ima/ima_api.c
>> b/security/integrity/ima/ima_api.c
>> index 597ea0c4d72f..48ae6911139b 100644
>> --- a/security/integrity/ima/ima_api.c
>> +++ b/security/integrity/ima/ima_api.c
>> @@ -244,7 +244,6 @@ int ima_collect_measurement(struct integrity_iint_cache
>> *iint,
>>          const char *audit_cause = "failed";
>>          struct inode *inode = file_inode(file);
>>          struct inode *real_inode = d_real_inode(file_dentry(file));
>> -       const char *filename = file->f_path.dentry->d_name.name;
>>          struct ima_max_digest_data hash;
>>          struct kstat stat;
>>          int result = 0;
>> @@ -313,11 +312,17 @@ int ima_collect_measurement(struct
>> integrity_iint_cache *iint,
>>                  iint->flags |= IMA_COLLECTED;
>>   out:
>>          if (result) {
>> +               struct qstr *qstr = &file->f_path.dentry->d_name;
>> +               char buf[NAME_MAX + 1];
>> +
>>                  if (file->f_flags & O_DIRECT)
>>                          audit_cause = "failed(directio)";
>>
>> +               memcpy(buf, qstr->name, qstr->len);
>> +               buf[qstr->len] = 0;
> 
> 	Think what happens if you fetch ->len in state prior to
> rename and ->name - after.  memcpy() from one memory object
> with length that matches another, UAF right there.
> 
> 	If you want to take a snapshot of the name, just use
> take_dentry_name_snapshot() - that will copy name if it's
> short or grab a reference to external name if the length is
>> = 40, all of that under ->d_lock to stabilize things.

I had exactly what you show below (inspired by overlayfs) but then 
looked around whether there's another way of doing it and I saw copies 
being made.

Thanks.


> 
> 	Paired with release_dentry_name_snapshot(), to
> drop the reference to external name if one had been taken.
> No need to copy in long case (external names are never
> rewritten) and it's kinder on the stack footprint that
> way (56 bytes vs. 256).
> 
> 	Something like this (completely untested):
> 
> fix a UAF in ima_collect_measurement()
> 
> ->d_name.name can change on rename and the earlier value can get freed;
> there are conditions sufficient to stabilize it (->d_lock on denty,
> ->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
> rename_lock), but none of those are met in ima_collect_measurement().
> Take a stable snapshot of name instead.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 597ea0c4d72f..d8be2280d97b 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -244,7 +244,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   	const char *audit_cause = "failed";
>   	struct inode *inode = file_inode(file);
>   	struct inode *real_inode = d_real_inode(file_dentry(file));
> -	const char *filename = file->f_path.dentry->d_name.name;
>   	struct ima_max_digest_data hash;
>   	struct kstat stat;
>   	int result = 0;
> @@ -313,12 +312,16 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   		iint->flags |= IMA_COLLECTED;
>   out:
>   	if (result) {
> +		struct name_snapshot filename;
> +
> +		take_dentry_name_snapshot(&filename, file->f_path.dentry);
>   		if (file->f_flags & O_DIRECT)
>   			audit_cause = "failed(directio)";
>   
>   		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
> -				    filename, "collect_data", audit_cause,
> -				    result, 0);
> +				    filename.name.name, "collect_data",
> +				    audit_cause, result, 0);
> +		release_dentry_name_snapshot(&filename);
>   	}
>   	return result;
>   }

I can take it from here unless you want to formally post it.

    Stefan

