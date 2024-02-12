Return-Path: <linux-fsdevel+bounces-11171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A6851BA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B087E2827EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04453FB28;
	Mon, 12 Feb 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ffndsBHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B83F9D6;
	Mon, 12 Feb 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759261; cv=none; b=UdyGR7MtAaq6BcZUZviHPrJymEvGuTT51IBzX7zRgSEKH7dnyp+SSkGu0qGyB6ucGTHkzKm/DkGkNa7vfRFp9VaDCy/l9ZIyx3ElCu8Q6f6Wx0rZQHElZVTBswWQwTq49rcLXe3ZfyJviFIDZ80machDpkJXJP3FX9Gl9FEQRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759261; c=relaxed/simple;
	bh=MR2vvDdKuPLHZeKtHXdt3kZU+KSz+BqV4ccn+OWY6tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1iEV5RKH8pUo0shr3ZHQ9Bwu2zvK3o2SiqTD9Lhaigkfa5Z37z/jfXXlcTipMO0Dd3ACX5C2T5vdSEzFb8bPd4ZlBlrvgrfVQc0p+FIqUo/vpEkFnozETYJc+U4FD3c2w0oq+NijSv4JNKJm47pm4g1YJomXaQkxHpuIQPanZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ffndsBHv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CHVwr4023553;
	Mon, 12 Feb 2024 17:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DLXtadvmS+MQDFNX0Ou+z9MDPCtBkk/v8TTumqraoFU=;
 b=ffndsBHvEBggVrzfPWOmT47iJQ8MPRJxfnrm/M5NRpJHng9gZh9QDpbP14FtdRCYxNyg
 0bhXFQ75LzsWBjnBup66mdELK6VAbUMVRcRyxSNFo72BwwIBjz3cM2r2HyE2U/PUfO9w
 FonH0nTk17YIyYJO76ZuMEucWGu10tor7/mF9E8YMRNrNFPGu1/n+Ge4XsDu5DT2Lr/J
 Bj01d609SVPtxHHe5J0hrqk7TOEB1LNCVS8jAAGOlcYPJo/ZIHsElALHBuSqUfSYslb0
 peweyxL0oCAAYZxc0uabtIQeeUPhn9r+NpmKowaPCHVeKAVmRTMyYt30qKtlu6lCfFB/ zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qtjr0fk-80
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:33:47 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHGWGQ001555;
	Mon, 12 Feb 2024 17:24:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qcggv06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:24:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGjLG7024908;
	Mon, 12 Feb 2024 17:24:00 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp1wpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:24:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CHNwef38470244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:24:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 239B258055;
	Mon, 12 Feb 2024 17:23:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80A635805F;
	Mon, 12 Feb 2024 17:23:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 17:23:55 +0000 (GMT)
Message-ID: <0c707e4f-88d8-4cad-a2ed-8db0e9d0b4ac@linux.ibm.com>
Date: Mon, 12 Feb 2024 12:23:54 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/25] security: Introduce path_post_mknod hook
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
 <20240115181809.885385-15-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-15-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2rgWjWbv1u0IGwjd5MfBUTeXVggIG93w
X-Proofpoint-ORIG-GUID: YjZ9j3wE5gn5UpYDttxI-qnVyWYUFImn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120133



On 1/15/24 13:17, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.
> 
> IMA-appraisal requires all existing files in policy to have a file
> hash/signature stored in security.ima. An exception is made for empty files
> created by mknod, by tagging them as new files.
> 
> LSMs could also take some action after files are created.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   fs/namei.c                    |  5 +++++
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  5 +++++
>   security/security.c           | 14 ++++++++++++++
>   4 files changed, 26 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index fb93d3e13df6..b7f433720b1e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4047,6 +4047,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>   					  dentry, mode, 0);
>   			break;
>   	}
> +
> +	if (error)
> +		goto out2;
> +
> +	security_path_post_mknod(idmap, dentry);
>   out2:
>   	done_path_create(&path, dentry);
>   	if (retry_estale(error, lookup_flags)) {
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 229f84ce12ae..e08b9091350d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -94,6 +94,8 @@ LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
>   LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
>   LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
>   	 umode_t mode, unsigned int dev)
> +LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
> +	 struct dentry *dentry)
>   LSM_HOOK(int, 0, path_truncate, const struct path *path)
>   LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
>   	 const char *old_name)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2997348afcb7..977dd9f7f51a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1893,6 +1893,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
>   int security_path_rmdir(const struct path *dir, struct dentry *dentry);
>   int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
>   			unsigned int dev);
> +void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
>   int security_path_truncate(const struct path *path);
>   int security_path_symlink(const struct path *dir, struct dentry *dentry,
>   			  const char *old_name);
> @@ -1927,6 +1928,10 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
>   	return 0;
>   }
>   
> +static inline void security_path_post_mknod(struct mnt_idmap *idmap,
> +					    struct dentry *dentry)
> +{ }
> +
>   static inline int security_path_truncate(const struct path *path)
>   {
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index 7d10724872f8..750bfe2768d5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1800,6 +1800,20 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
>   }
>   EXPORT_SYMBOL(security_path_mknod);
>   
> +/**
> + * security_path_post_mknod() - Update inode security field after file creation
> + * @idmap: idmap of the mount
> + * @dentry: new file
> + *
> + * Update inode security field after a file has been created.
> + */
> +void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(path_post_mknod, idmap, dentry);
> +}
> +
>   /**
>    * security_path_mkdir() - Check if creating a new directory is allowed
>    * @dir: parent directory

