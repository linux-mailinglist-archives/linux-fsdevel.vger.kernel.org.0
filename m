Return-Path: <linux-fsdevel+bounces-11183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D07851E1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF9F1C21DAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DE47F4D;
	Mon, 12 Feb 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nxvjID8z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB947F45;
	Mon, 12 Feb 2024 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767278; cv=none; b=skfmIl3jOljPoV105VLmbu/KTLIXxEwY+Pp7bsSmf+1v6lcf5XLkUld8Nged3E4B5dg/Wz36Z3Wn8WSLi1yBuz2MfpeRqbJ9X+gmD6a4HUM6Ka4UKNCoeK9lKGmqrnikMFDtrQKGLddPKWbu6cf5xLFLPSONkVyPAnzkF444mX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767278; c=relaxed/simple;
	bh=zJTgtxIKXgoU9MG2O9BnZcboJP5eJ6Oewa5Hsjb/uRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX9mVrH9aWJq+vbGLmi8lutP9pdkEdzBjusnudixg2mTaavIQK5Jh2ekdfwRto5tH7DLM0Ok3mUguZFTDOE23LpKO0215b3oqszG6HRgAopvF79hd4JOqRVO9Sns7zUgqOPwjf7BUDvkoZ9SGIAsIPegVMaGHvV7HCg/yrA5mx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nxvjID8z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJffmB020322;
	Mon, 12 Feb 2024 19:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6L3jpxBwkyfcvRtH8S/uSaadMDWnvfPBo1NAJUDPJUk=;
 b=nxvjID8zwQcQynlc6Me8SNDzFKVHc8Tsn/lvnutsNlnI/d9gjMH2sXwjaZThXhPYUNGu
 FGGWWIe175KQBGtX0kooKCVaCbFmTHtmXnUNlb/9e4qyobKRbTUD8bPF34uOkfx90SGS
 haBvaTiTuwR06O9QW6XgBg40EsRhuJTOAEGvGf8k0CfQhKdsQ+fNbSnlbiBQRidKBkA5
 OoDK+m1xHRjDOO2ozZ2a8xZS1RjFWLxugwT06+e8cDacoXpoeAsv/uTYRQY+0ClBAEEO
 HqCPROFBFc6ueNnO/inoxKuTX/7qF/otZsXk7ICyawfypqZPGrSlD5+vnd0bsTwb7aFF LA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7sgw0b2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:47:27 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CJgDOR021802;
	Mon, 12 Feb 2024 19:47:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7sgw0b2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:47:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CIQVXR032605;
	Mon, 12 Feb 2024 19:47:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftb2em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:47:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CJlMxd21889752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 19:47:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD80758055;
	Mon, 12 Feb 2024 19:47:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2019F58043;
	Mon, 12 Feb 2024 19:47:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 19:47:21 +0000 (GMT)
Message-ID: <155295d9-6cf3-4e66-9bfa-27c1a8e62694@linux.ibm.com>
Date: Mon, 12 Feb 2024 14:47:20 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 24/25] ima: Make it independent from 'integrity' LSM
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-25-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-25-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dx0riDMbYA92UQJVBQpjCX7PeCl41sXr
X-Proofpoint-ORIG-GUID: lBW5bSawebGnMLF6HBsmtLn_O5yit_IQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=561
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120152



On 1/15/24 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Make the 'ima' LSM independent from the 'integrity' LSM by introducing IMA
> own integrity metadata (ima_iint_cache structure, with IMA-specific fields
> from the integrity_iint_cache structure), and by managing it directly from
> the 'ima' LSM.
> 
> Create ima_iint.c and introduce the same integrity metadata management
> functions found in iint.c (renamed with ima_). However, instead of putting
> metadata in an rbtree, reserve space from IMA in the inode security blob
> for a pointer, and introduce the ima_inode_set_iint()/ima_inode_get_iint()
> primitives to store/retrieve that pointer. This improves search time from
> logarithm to constant.

logarithmic

> 
> Consequently, don't include the inode pointer as field in the
> ima_iint_cache structure, since the association with the inode is clear.
> Since the inode field is missing in ima_iint_cache, pass the extra inode
> parameter to ima_get_verity_digest().
> 
> Prefer storing the pointer instead of the entire ima_iint_cache structure,
> to avoid too much memory pressure. Use the same mechanism as before, a
> cache named ima_iint_cache (renamed from iint_cache), to quickly allocate
> a new ima_iint_cache structure when requested by the IMA policy.
> 
> Create the new ima_iint_cache in ima_iintcache_init(),
> called by init_ima_lsm(), during the initialization of the 'ima' LSM. And,
> register ima_inode_free_security() to free the ima_iint_cache structure, if
> exists.
> 
> Replace integrity_iint_cache with ima_iint_cache in various places of the
> IMA code. Also, replace integrity_inode_get() and integrity_iint_find(),
> respectively with ima_inode_get() and ima_iint_find().
> 
> Finally, move the remaining IMA-specific flags
> to security/integrity/ima/ima.h, since they are now unnecessary in the
> common integrity layer.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


