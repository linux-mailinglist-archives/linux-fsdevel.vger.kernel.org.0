Return-Path: <linux-fsdevel+bounces-11186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE06E851EAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393831F20EEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23534C60B;
	Mon, 12 Feb 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tAv1716J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17046551;
	Mon, 12 Feb 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769753; cv=none; b=CeIxJJcLrojDctgP7PHIAfmX95nNIrtwgsqxsjL3IBg3swecZdAtUQPXqFlLrrczWHH9TRw4Fto7QM+lG12mmSunFRR6OVW2LS5hjoBIFmBAUvHTXiJstrYunMihdYyvLgbBM5ASifSv7K9HkLSwFtTwNwld7xnklLoqqXAm2ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769753; c=relaxed/simple;
	bh=eSMPcnqleewvsCZOjcxX6j+WVDKLH3kGFH0udq8XuOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wttk7MdccOB4IXmfEC5SAImVoD+rarb0N+X/IWR6ADizPsaOiM8Wu//sa9BBtMuKPtDvXaZFkJRNld5jxrl/1ph1n+lqrr+YHeqVOaSUD0hrK/VwPS+5GzD2u7gSMq7emi0YsWEJ76K3loYsSjgBHvbuECM+373Mj+HfOJO3Zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tAv1716J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CKN0SZ003408;
	Mon, 12 Feb 2024 20:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JhR4CnsbNNlV55xXkJZROwtBvgr65QVEvejYyFSklRU=;
 b=tAv1716JGfXUJ56oTLAfdJEAD2xUh5bWfDi9/epslC9qI0QdHGhMP/isop8LFXZYitAa
 X5/DINpovaNb3ALNwWh0aQicSxSlX3WzOwvXd3m9k02/VXzF/4GKcMhiTOmgiyW+dOXr
 lwoTKH3TjlQWp9nDIbr6sM9Q9zGbt2g9THl4Zxm4b32c9xkVgn0QCLEPjsCf/n9T9XhT
 tgfV7J7oxNDKtRSUSArXMorP4r5rMg0LzL0C7ErqQlUsn9GZiHTasnhq2ToHLX53pHpd
 O31Ey5sgcha96GI93Q+qCuG+6760LshZH1SRDukLhKwsbjemnWFUeLvqXosjvZNfu8iA 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7taf8470-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:28:45 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CKQ2sa011682;
	Mon, 12 Feb 2024 20:28:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7taf845d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:28:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJ3q0B004297;
	Mon, 12 Feb 2024 20:28:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv036ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:28:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CKSeM546268780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 20:28:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FD7C5805D;
	Mon, 12 Feb 2024 20:28:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE8E58055;
	Mon, 12 Feb 2024 20:28:34 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 20:28:34 +0000 (GMT)
Message-ID: <7940b9d0-3133-4b08-b397-ad9ee34e3b34@linux.ibm.com>
Date: Mon, 12 Feb 2024 15:28:33 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/25] integrity: Move
 integrity_kernel_module_request() to IMA
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org,
        mic@digikod.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
 <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
 <CAHC9VhTY=X7z5SRQZzFe25FGB2E3FBBkuZ_YYA1+ETyr7pv=tA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAHC9VhTY=X7z5SRQZzFe25FGB2E3FBBkuZ_YYA1+ETyr7pv=tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IG8gA7VCiIuoNiLherBpxii_bnuMc-F5
X-Proofpoint-ORIG-GUID: n2O60wZIGE2TuBwcELMLALmk7ji0iQ_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120158



On 2/12/24 12:56, Paul Moore wrote:
> On Mon, Feb 12, 2024 at 12:48 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 1/15/24 13:18, Roberto Sassu wrote:
> 
> ...
> 
>>> +/**
>>> + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
>>> + * @kmod_name: kernel module name
>>> + *
>>> + * We have situation, when public_key_verify_signature() in case of RSA > + * algorithm use alg_name to store internal information in order to
>>> + * construct an algorithm on the fly, but crypto_larval_lookup() will try
>>> + * to use alg_name in order to load kernel module with same name.
>>> + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
>>> + * we are safe to fail such module request from crypto_larval_lookup().
>>> + *
>>> + * In this way we prevent modprobe execution during digsig verification
>>> + * and avoid possible deadlock if modprobe and/or it's dependencies
>>> + * also signed with digsig.
>>
>> This text needs to some reformulation at some point..
> 
> There is no time like the present.  If you have a suggestion I would
> love to hear it and I'm sure Roberto would too.
> 

My interpretation of the issue after possibly lossy decoding of the 
above sentences:

Avoid a deadlock by rejecting a virtual kernel module with the name 
"crypto-pkcs1pad(rsa,*)". This module may be requested by 
crypto_larval_lookup() while trying to verify an RSA signature in 
public_key_verify_signature(). Since the loading of the RSA module may 
itself cause the request for an RSA signature verification it will 
otherwise lead to a deadlock.


