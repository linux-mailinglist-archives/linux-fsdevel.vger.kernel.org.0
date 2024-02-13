Return-Path: <linux-fsdevel+bounces-11389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841B85361F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3DB275B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766E5FDAA;
	Tue, 13 Feb 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EGBC73Yt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480026AD7;
	Tue, 13 Feb 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842025; cv=none; b=r6+n211DcjzAlp7RyIyAojEbGYmsN2lN8M2OYTuzL3V2Ve2Nfgpq/gUQeoUlfJr+ZheGUfK7/R/Ndc3vL2joIAdR4YGKttDsMIkXQNruq4oC1wiX1WoD/TlE8HvDa9D4oYfCRUlWdZodwgvWAY2JghP3DRRu5cI2lD9bMglnqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842025; c=relaxed/simple;
	bh=A07J6sqhM54HR9uLgNXXEdd8RFnknbXR0ltWdOpPdw4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uWPOgHzQfXkAna8Zdk5bx2LooS4GLIgJ691h8Qu0CrUCQbO8oxOZ8Tjd5ae7LChWdhqvCYwvm3xC8fFllWWz/5D7tf1QHcZIz5d4j5/SC+pBhR/T+O61+WCiF5wqHJWp7lzJLD+oiOqW4TLvUCygfziMqSTnmhHgKoLyFErDCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EGBC73Yt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DFst9D028182;
	Tue, 13 Feb 2024 16:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UgvbajqcPtxWyMn3yRWVa6zmR/EN7tedRiy2deW+QGU=;
 b=EGBC73YtFO68WSb+N2FPNSH+qeujPBGBR2TVYmRVBxGljcdBnFcaC9xqlTIZpBA+KNNf
 rBnBg1K/xh9Eoss8iPX57M8aB3QseGU5Zu7iawItX2GNSjDx4J46Q6/5nl7KeT86uSIb
 LVaH7M5ZU5em3AzE7viL8TXZSFWK9GuRKPckgMDO4VlN0nP7W/7Sb4CGayN3PIWNh/Nd
 lptcoH7a8ag9I6or8tEF+Cu5MQVIoj511RN+rT1X/HhubGATe4F7rKhAPyge5gvxUGK3
 of//seJapC5kgspPve9qBSffQuapBdaZqthMQVnRWalI1S3bFT3i1ejzZuSRfQYSIEVo 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w87gkfyrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:33:03 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DG6e1F018013;
	Tue, 13 Feb 2024 16:32:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w87gkfya7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:32:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DF30vX016184;
	Tue, 13 Feb 2024 16:31:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymgbn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:31:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DGVS705702208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 16:31:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7079558059;
	Tue, 13 Feb 2024 16:31:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C2A458058;
	Tue, 13 Feb 2024 16:31:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 16:31:27 +0000 (GMT)
Message-ID: <1d8f8990-43e2-4afc-835e-629c7328d497@linux.ibm.com>
Date: Tue, 13 Feb 2024 11:31:26 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 19/25] integrity: Move
 integrity_kernel_module_request() to IMA
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
 <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
 <CAHC9VhTY=X7z5SRQZzFe25FGB2E3FBBkuZ_YYA1+ETyr7pv=tA@mail.gmail.com>
 <7940b9d0-3133-4b08-b397-ad9ee34e3b34@linux.ibm.com>
 <b95967cd1aa2a4e751a8be3d23f72b7e1db0e4b6.camel@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <b95967cd1aa2a4e751a8be3d23f72b7e1db0e4b6.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9tDAfUnsoLLQtRaYozl8hJE8AlJiBDzw
X-Proofpoint-ORIG-GUID: fA6Gn1wQxZmMUpZtwqYWP5VACQonDsxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_09,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402130130



On 2/13/24 03:57, Roberto Sassu wrote:
> On Mon, 2024-02-12 at 15:28 -0500, Stefan Berger wrote:
>>
>> On 2/12/24 12:56, Paul Moore wrote:
>>> On Mon, Feb 12, 2024 at 12:48 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>> On 1/15/24 13:18, Roberto Sassu wrote:
>>>
>>> ...
>>>
>>>>> +/**
>>>>> + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
>>>>> + * @kmod_name: kernel module name
>>>>> + *
>>>>> + * We have situation, when public_key_verify_signature() in case of RSA > + * algorithm use alg_name to store internal information in order to
>>>>> + * construct an algorithm on the fly, but crypto_larval_lookup() will try
>>>>> + * to use alg_name in order to load kernel module with same name.
>>>>> + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
>>>>> + * we are safe to fail such module request from crypto_larval_lookup().
>>>>> + *
>>>>> + * In this way we prevent modprobe execution during digsig verification
>>>>> + * and avoid possible deadlock if modprobe and/or it's dependencies
>>>>> + * also signed with digsig.
>>>>
>>>> This text needs to some reformulation at some point..
>>>
>>> There is no time like the present.  If you have a suggestion I would
>>> love to hear it and I'm sure Roberto would too.
>>>
>>
>> My interpretation of the issue after possibly lossy decoding of the
>> above sentences:
>>
>> Avoid a deadlock by rejecting a virtual kernel module with the name
>> "crypto-pkcs1pad(rsa,*)". This module may be requested by
>> crypto_larval_lookup() while trying to verify an RSA signature in
>> public_key_verify_signature(). Since the loading of the RSA module may
>> itself cause the request for an RSA signature verification it will
>> otherwise lead to a deadlock.
> 
> I can be even more precise I guess (I actually reproduced it). >
> Avoid a verification loop where verifying the signature of the modprobe
> binary requires executing modprobe itself. Since the modprobe iint-
>> mutex is already held when the signature verification is performed, a
> deadlock occurs as soon as modprobe is executed within the critical
> region, since the same lock cannot be taken again.

When ecdsa is used for signing files it could get stuck as well and 
would need this patch:

diff --git a/security/integrity/ima/ima_main.c 
b/security/integrity/ima/ima_main.c
index 45f1a102c599..2e71dc977d43 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1110,7 +1110,9 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
   */
  static int ima_kernel_module_request(char *kmod_name)
  {
-       if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
+       if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0 ||
+           strncmp(kmod_name, "crypto-ecdsa-nist-p", 19) == 0 ||
+           strcmp(kmod_name, "cryptomgr") == 0)
                 return -EINVAL;

         return 0;

Rejecting cryptomgr seems necessary in the ecdsa case though I am not 
sure what the side effects of rejecting it all the time could be.

    Stefan

> 
> This happens when public_key_verify_signature(), in case of RSA
> algorithm, use alg_name to store internal information in order to
> construct an algorithm on the fly, but crypto_larval_lookup() will try
> to use alg_name in order to load a kernel module with same name.
> 
> Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
> we are safe to fail such module request from crypto_larval_lookup(),
> and avoid the verification loop.
> 
> Roberto
> 
> 

