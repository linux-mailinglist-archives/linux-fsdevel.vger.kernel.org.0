Return-Path: <linux-fsdevel+bounces-13272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A686E1D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE91F2225A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59271B34;
	Fri,  1 Mar 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ItFl2A+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650171B2F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298982; cv=none; b=KaKnRo56e/PBAN45fjdqfFpyCdsKHRxvT93FRVrOxYDKl+nOO2Xio+++eXKSLYEdTqXO0CJa6g3ZIziX7ucmfZGy62cFsycP8jxRnQYUra8N/1MVbHZTnTgFVIoj9q5gTNs0SdnchLgxuGbqkhrE9weB8aRQhZiEf6XLWCto/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298982; c=relaxed/simple;
	bh=Jg9rMcezSQeBTXrKWZFhEhTNaM73wm+dkP3WSluxBxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnGka5dUiivZ4kCCqK6YWFQMcTurdlNAvEpcMIeUFojsJTqrouRct4KqGQygpqnJH2z9BEjBundYqDkMrq6fywjvamyaWLgJgIYSCI6Fl7Iq2jkPJkzDIwnZUr5B0O6/8Q4qiQNjPXUMZXZcDhrbLpBpUg6rvPGufUEp9v/Z1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ItFl2A+w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421CvJYT017358;
	Fri, 1 Mar 2024 13:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e5/DfUymUoVPfJ8nUl7SxG146YMt14b4B3SPFWBZTvk=;
 b=ItFl2A+wdEcm5vpHEERT+XDdPfh0treYU2+HeUSXcsohv1mYK7RknjlmNdYe+QykOSZ+
 YQF7EJOObkj6XFwS6mYhE/wLokc4QglpsgCZdbU300o3TQqSx3m8FzOx9LphrJRKyQIS
 Evmb55ZBHb4lXz/eKgvgJQ0oLLKg8pphTP/gz6/1dQa9BQjltzbdieUcQ7ZIYRLd5/Ix
 XomaY4BFDcc2TGPpYTtG7g9qlhMI1B0HVFwIFHNqw6fgosc+o0IQiBu4iP+q3q4jU76O
 m2RwCzW2N3jWVkOKsqAYn7UCa1a3Vty0UOzsz3in5+7u/OLEP7c39PpdZlb/XPMIIw3d IA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkffsgddp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 13:16:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421CwLAK020277;
	Fri, 1 Mar 2024 13:16:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkffsgddb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 13:16:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421CIa9F024122;
	Fri, 1 Mar 2024 13:16:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0kv7qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 13:16:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421DGAOQ27656620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 13:16:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A7E72004E;
	Fri,  1 Mar 2024 13:16:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DEBB2004D;
	Fri,  1 Mar 2024 13:16:10 +0000 (GMT)
Received: from [9.179.23.232] (unknown [9.179.23.232])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 13:16:10 +0000 (GMT)
Message-ID: <fc1ac345-6ec5-49dc-81db-c46aa62c8ae1@linux.ibm.com>
Date: Fri, 1 Mar 2024 14:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fanotify: move path permission and security check
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: jack@suse.cz, repnop@google.com, linux-fsdevel@vger.kernel.org
References: <20240229174145.3405638-1-meted@linux.ibm.com>
 <CAOQ4uxh+Od_+ZuLDorbFw6nOnsuabOreH4OE=uP_JE53f0rotA@mail.gmail.com>
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <CAOQ4uxh+Od_+ZuLDorbFw6nOnsuabOreH4OE=uP_JE53f0rotA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JpAnikGXghmJvLN1u5hlNF05hGWU6m_C
X-Proofpoint-GUID: z206Dfjs7luTQeKNZyaU9p2slmh4szM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_13,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010110

On 3/1/24 10:52, Amir Goldstein wrote:
> On Thu, Feb 29, 2024 at 7:53 PM Mete Durlu <meted@linux.ibm.com> wrote:
>>
>> In current state do_fanotify_mark() does path permission and security
>> checking before doing the event configuration checks. In the case
>> where user configures mount and sb marks with kernel internal pseudo
>> fs, security_path_notify() yields an EACESS and causes an earlier
>> exit. Instead, this particular case should have been handled by
>> fanotify_events_supported() and exited with an EINVAL.
> 
> What makes you say that this is the expected outcome?
> I'd say that the expected outcome is undefined and we have no reason
> to commit to either  EACCESS or EINVAL outcome.

TLDR; I saw the failing ltp test(fanotify14) started investigating, read
the comments on the related commits and noticed that the fanotify
documentation does not mention any EACESS as an errno. For these reasons
I made an attempt to provide a fix. The placement of the checks aim
minimal change, I just tried not to alter the logic more than needed.
Thanks for the feedback, will apply suggestions.


The main reason is the following commit;
* linux: 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel
internal pseudo fs")

fanotify_user: fanotify_events_supported()
     /*
      * mount and sb marks are not allowed on kernel internal pseudo
          * fs, like pipe_mnt, because that would subscribe to events on
          * all the anonynous pipes in the system.
      */
     if (mark_type != FAN_MARK_INODE &&
         path->mnt->mnt_sb->s_flags & SB_NOUSER)
         return -EINVAL;

It looks to me as, when configuring fanotify_mark with pipes and
FAN_MARK_MOUNT or FAN_MARK_FILESYSTEM, the path above should be taken
instead of an early return with EACCES.

Also the following commit on linux test project(ltp) expects EINVAL as
expected errno.

* ltp: 8e897008c ("fanotify14: Test disallow sb/mount mark on anonymous 
pipe")

To be honest, the test added on above commit is the main reason why I
started investigating this.

> I don't really mind the change of outcome, but to me it seems
> nicer that those tests are inside fanotify_find_path(), so I will
> want to get a good reason for moving them out.

I agree, when those tests are inside fanotify_find_path() it looks much
cleaner but then the check for psuedo fs in fanotify_events_supported()
is not made. And I believe when configuring fanotify an EINVAL makes
more sense than EACCES, it just seems more informative(at least to me).
Would it maybe make sense to put them in a separate helper function,
sth like:

static int fanotify_path_security(struct path *path,
				  __u64 mask,
				  unsigned int obj_type) {
	int ret;

	ret = path_permission(path, MAY_READ);
	if (ret)
		return ret;
	ret = security_path_notify(path, mask, obj_type);
	return ret;
}

...

ret = fanotify_path_security(...)
if (ret)
	goto path_put_and_out;

>>
>> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
>> index fbdc63cc10d9..14121ad0e10d 100644
>> --- a/fs/notify/fanotify/fanotify_user.c
>> +++ b/fs/notify/fanotify/fanotify_user.c
>> @@ -1015,7 +1015,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>>                          fdput(f);
>>                          goto out;
>>                  }
>> -
>> +               ret = 0;
> 
> Better convert all gotos in this helper to return.
> There is nothing in the out label.
> 
Good point, will do!

>>                  *path = f.file->f_path;
>>                  path_get(path);
>>                  fdput(f);
>> @@ -1028,21 +1028,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
>>                          lookup_flags |= LOOKUP_DIRECTORY;
>>
>>                  ret = user_path_at(dfd, filename, lookup_flags, path);
>> -               if (ret)
>> -                       goto out;
>>          }
>> -
>> -       /* you can only watch an inode if you have read permissions on it */
>> -       ret = path_permission(path, MAY_READ);
>> -       if (ret) {
>> -               path_put(path);
>> -               goto out;
>> -       }
>> -
>> -       ret = security_path_notify(path, mask, obj_type);
>> -       if (ret)
>> -               path_put(path);
>> -
>>   out:
>>          return ret;
>>   }
>> @@ -1894,6 +1880,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>>                  if (ret)
>>                          goto path_put_and_out;
>>          }
>> +       /* you can only watch an inode if you have read permissions on it */
>> +       ret = path_permission(&path, MAY_READ);
>> +       if (ret)
>> +               goto path_put_and_out;
>> +
>> +       ret = security_path_notify(&path, mask, obj_type);
>> +       if (ret)
>> +               goto path_put_and_out;
>>
>>          if (fid_mode) {
>>                  ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
> 
> If we do accept your argument that security_path_notify() should be
> after fanotify_events_supported(). Why not also after fanotify_test_fsid()
> and fanotify_test_fid()?

I tried to place the checks as close as possible to their original
position, that is why I placed them right after
fanotify_events_supported(). I wanted to keep the ordering as close as
possible to original to not break any other check. I am open to
suggestions regarding this.

Thank you
-Mete Durlu


