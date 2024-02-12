Return-Path: <linux-fsdevel+bounces-11170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92B851B82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6602869C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96A3F9EC;
	Mon, 12 Feb 2024 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TDlzwwoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879AB3EA78;
	Mon, 12 Feb 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759109; cv=none; b=HIq5lt/SLl0f2LN2H1kcAtAncwVgEG2MyNAVD2QI2hJMUfYbs/kzUhjx6paTBadYwptLcznXc/QhSSF5DQf1RoaqeCkm0QKEa51zKel6OohO8o2duFssidX+SSvlP7YmfZPc9jn6/Dpzhlwt+ARdMCXvpTvCmj+eyvIgFKeTK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759109; c=relaxed/simple;
	bh=KTQRUIWsSy6fCUzMRSakU3C2/jNpAR6/r162Nsdd9e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tjm6abfcqbHcfFpjPcdwxKqgzyIDP8Afp3deMOcqlfQ4IGiQj0/2hpCq2l/0MRoeTD1giM16XuJCjBTgOD50YwWQrB8BAZZVKYTgJqYT/weDJeYAgZQ9lf4p2951xlVrCPF5FKypF7QzRNaQ6ojkyOvxtyEgFxl8wGwzp0Kq+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TDlzwwoa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CHQm8x003949;
	Mon, 12 Feb 2024 17:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Uqjq24L/txe6fjmnLR2c3Ml+syRGFsRrMlcBpbusI0E=;
 b=TDlzwwoaskHJUG7X4SHjHJ7pJt0Js82m6KaMqtH5STaIa2Uvxxw5lJVLeC8M81CSjBjG
 SVGFrtJsJXb7lYY2/+hLSLpEiDgEbok6dH6oubsKQkIW58D0GqGhD1bdA9tyNLFqeKex
 xYwJ9guQ7JYgFVgRT3tXvACUULmNMTLY6QNf+0AFTNec5VE2NdeRTO1+htdfR36cSHu4
 A7CLLbHK6y5nrCNBOAibVyfGE/KExopurx5uvCxEY64fWaOv4aFDetbz4cQlzeFBdyLy
 ZHVu7RaUIqtft+UIF4oDulMUgCMlRYnLapkUBMNPA4pzboSXr6GamV/ZAYs9C25c8wIo bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qr3r69p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:31:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHR6aP005757;
	Mon, 12 Feb 2024 17:31:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qr3r685-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:31:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGSULR024878;
	Mon, 12 Feb 2024 17:26:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp1x6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:26:14 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CHQB2118285230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:26:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CECB658055;
	Mon, 12 Feb 2024 17:26:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E6058043;
	Mon, 12 Feb 2024 17:26:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 17:26:08 +0000 (GMT)
Message-ID: <1175a4ee-94fd-4331-9412-d77987ca1827@linux.ibm.com>
Date: Mon, 12 Feb 2024 12:26:07 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/25] security: Introduce inode_post_create_tmpfile
 hook
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
 <20240115181809.885385-16-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-16-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b3FvR0c02HCTFg3Zt0r2fkFLkTxKdW1z
X-Proofpoint-ORIG-GUID: RO1BQ0VD0_K1Qa5cBSbG9DuK2P1ScW3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120133



On 1/15/24 13:17, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_create_tmpfile hook.
> 
> As temp files can be made persistent, treat new temp files like other new
> files, so that the file hash is calculated and stored in the security
> xattr.
> 
> LSMs could also take some action after temp files have been created.
> 
> The new hook cannot return an error and cannot cause the operation to be
> canceled.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   fs/namei.c                    |  1 +
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  6 ++++++
>   security/security.c           | 15 +++++++++++++++
>   4 files changed, 24 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index b7f433720b1e..adb3ab27951a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3686,6 +3686,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>   		inode->i_state |= I_LINKABLE;
>   		spin_unlock(&inode->i_lock);
>   	}
> +	security_inode_post_create_tmpfile(idmap, inode);
>   	ima_post_create_tmpfile(idmap, inode);
>   	return 0;
>   }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index e08b9091350d..5f90914d23e0 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>   	 const struct qstr *name, const struct inode *context_inode)
>   LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>   	 umode_t mode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
> +	 struct inode *inode)
>   LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
>   	 struct dentry *new_dentry)
>   LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 977dd9f7f51a..1cb604282617 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -344,6 +344,8 @@ int security_inode_init_security_anon(struct inode *inode,
>   				      const struct qstr *name,
>   				      const struct inode *context_inode);
>   int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *inode);
>   int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>   			 struct dentry *new_dentry);
>   int security_inode_unlink(struct inode *dir, struct dentry *dentry);
> @@ -811,6 +813,10 @@ static inline int security_inode_create(struct inode *dir,
>   	return 0;
>   }
>   
> +static inline void
> +security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *inode)
> +{ }
> +
>   static inline int security_inode_link(struct dentry *old_dentry,
>   				       struct inode *dir,
>   				       struct dentry *new_dentry)
> diff --git a/security/security.c b/security/security.c
> index 750bfe2768d5..5bc7edc22923 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2013,6 +2013,21 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
>   }
>   EXPORT_SYMBOL_GPL(security_inode_create);
>   
> +/**
> + * security_inode_post_create_tmpfile() - Update inode security of new tmpfile
> + * @idmap: idmap of the mount
> + * @inode: inode of the new tmpfile
> + *
> + * Update inode security data after a tmpfile has been created.
> + */
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *inode)
> +{
> +	if (unlikely(IS_PRIVATE(inode)))
> +		return;
> +	call_void_hook(inode_post_create_tmpfile, idmap, inode);
> +}
> +
>   /**
>    * security_inode_link() - Check if creating a hard link is allowed
>    * @old_dentry: existing file

