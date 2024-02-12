Return-Path: <linux-fsdevel+bounces-11177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD7851CB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882912847E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5241775;
	Mon, 12 Feb 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K8JRXJ4P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A45405C6;
	Mon, 12 Feb 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762413; cv=none; b=Zg0a4MWqaJhQ62NAPRLXa4Rw3AnA4UNZm1g+nIPx/x0fG9L1micB/UlC3Dp5jKGCUGyWj48wJH69ZnYg5ofvRzzXY550mPoYZk0gZQOvy0nNRMldt/vtT4XbEHXk9Et58Y8quOS82thxEPv2o7436Jqbj1zNwFwq5NEh5LsqNhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762413; c=relaxed/simple;
	bh=zPCAl5W84MBNOsC7L5RhtuIjML3Qo3/ZiF/pSR55Tw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZzvsjyAZdnPVs/eTLajqh8zEjneN/Ilu9rZzcMfZn6TYTQoz//iXTrEV+bqGSWYVOoFzN/6WkRLTLp5CnDh4V/SNmS0B1F9/rt/QkgPaGg2l54qQGgE5XwMgWU7W3eEYPeCcQylqAcUIaBs3cmC1Mc/RtOvNB1xxbnvpNU47kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K8JRXJ4P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CI7Cpo010517;
	Mon, 12 Feb 2024 18:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Orzq42MMO1ZEvKZjaWq3C1tqDEzzTaEwvYhlVNC563w=;
 b=K8JRXJ4PqLVKZ0WMD9nrgP1IEz3u4RKWc619cNgQ9yK16WPJyqQChwh0pZWP+YrBu/Ng
 Hd+Tiibuch3pwMxs62A2ybloGjiMw+Tv0fkKflFiNohOcesTjpewb5+8WYKeaJXhc1YK
 SHei8YaI/TClrRSYWEJMBg9aiP6rdy5Ekw7qZd8oWpkA7jQ6GcgiS3IBecNeqQPmk69W
 MALZnxHex4n8dnMOkyMzZTpV4RosSize1Rp6RUWtlCNIHam/bW8EP5FQvMpDTxWQsREb
 DIlGj7Z0bttGNMGgx7CKU2Sk0XfvcTBE5AXgWgQGEfFr6mVeICDExbT1zrCDEyEhPFTd /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7raq0f34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:26:21 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CI7mtC012593;
	Mon, 12 Feb 2024 18:26:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7raq0f22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:26:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGx4f0024877;
	Mon, 12 Feb 2024 18:26:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp27hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 18:26:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CIQH4n17629696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 18:26:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AAB858059;
	Mon, 12 Feb 2024 18:26:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8480B58067;
	Mon, 12 Feb 2024 18:26:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 18:26:10 +0000 (GMT)
Message-ID: <5d10e7d8-9d3e-43f9-95d8-67247ffa091c@linux.ibm.com>
Date: Mon, 12 Feb 2024 13:26:09 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 22/25] evm: Move to LSM infrastructure
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
 <20240115181809.885385-23-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-23-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sHIteHYy_ZuTq_ohDZCWtRB_3ocR2sgr
X-Proofpoint-ORIG-GUID: 90lN_cbqjmQZCAMAtg7OuVMDbdTvBlWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_15,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120139



On 1/15/24 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> As for IMA, move hardcoded EVM function calls from various places in the
> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> (last and always enabled like 'ima'). The order in the Makefile ensures
> that 'evm' hooks are executed after 'ima' ones.
> 
> Make EVM functions as static (except for evm_inode_init_security(), which
> is exported), and register them as hook implementations in init_evm_lsm().
> Also move the inline functions evm_inode_remove_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_set_acl() from the public
> evm.h header to evm_main.c.
> 
> Unlike before (see commit to move IMA to the LSM infrastructure),
> evm_inode_post_setattr(), evm_inode_post_set_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
> executed for private inodes.
> 
> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

>   }
>   
> +static struct security_hook_list evm_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_setattr, evm_inode_setattr),
> +	LSM_HOOK_INIT(inode_post_setattr, evm_inode_post_setattr),
> +	LSM_HOOK_INIT(inode_copy_up_xattr, evm_inode_copy_up_xattr),
> +	LSM_HOOK_INIT(inode_setxattr, evm_inode_setxattr),
> +	LSM_HOOK_INIT(inode_set_acl, evm_inode_set_acl),
> +	LSM_HOOK_INIT(inode_post_set_acl, evm_inode_post_set_acl),
> +	LSM_HOOK_INIT(inode_remove_acl, evm_inode_remove_acl),
> +	LSM_HOOK_INIT(inode_post_remove_acl, evm_inode_post_remove_acl),
> +	LSM_HOOK_INIT(inode_post_setxattr, evm_inode_post_setxattr),

nit: move this one up after inode_setxattr.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

