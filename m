Return-Path: <linux-fsdevel+bounces-11169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC5F851B30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C681C21889
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4453E47E;
	Mon, 12 Feb 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEkS2fjk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9D3D56D;
	Mon, 12 Feb 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758536; cv=none; b=Qdg1k4vxgY5775S5wpv+wEaumYV0+p2a7IOkb+TpbNHFTz7ihuEA+nG2h5lbsXRHOeqXU+X5b5vU/6wp1twsBa/r2TnJBIg9WC3Gx9IUowCdmgMvvs29VHFtcdSw0UiPjP8MYDMFO6CxeuPyvcA4yxwr1bdP+B2PzRxpEKaf0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758536; c=relaxed/simple;
	bh=k7LXORf4EzSDIl/lyRla5O6ZlfVqO/jSxTnInSO0e4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1KdXEWgfFkzybIufuppHMA/nG0kiaifsSFRtN6/zLyIaGl9eWLLep/4usxh/bY/F/lvhdx0l2urku8T6VKgOHHg1coNtqWIm01yI2MAAbAzOaon67X7QMidtbgyPTZAnlzT666nN3rZgLNzwPmX0uy4+bLK/Xyhi8KG9dPi0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEkS2fjk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CHG4Ql028987;
	Mon, 12 Feb 2024 17:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eSdxrm/EgFSXFEX8alLuk+gV1hUzMo+xxS4g34enfxY=;
 b=mEkS2fjkqCOA6jxngNacB0yRwYRFZw19r0UErGQ4dopxmxCcn/5Ki42z00v8FWhpTp4u
 DqR0yyaFG5S/C/4YmUKDL3cyCaZ58LgAZn2RUWqQHeq/zK62s8/0o+x0MClB9xL3EBjZ
 cYX9xBnulkGQ1gOCbWl+VEq5gkHUPSuP/LvzkqfPphKRYweXkWpzem8v673ujELdJZL9
 wHpsw/YHl7O1KNvcaYihQjBc3/v4PNgu+eFhqrgAsmSvuzdq+Yel5lIN3BOLpWsr2ebv
 fF83v4LZtJb7S/5feV9Nu9sgZSv5mHeO+AAJcKSTrHWDqXLeuty/DbOcEJ2qo3DC6I2H bA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qcggh27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:21:33 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHIXJw008039;
	Mon, 12 Feb 2024 17:21:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qcggh0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:21:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CH2LbW016517;
	Mon, 12 Feb 2024 17:21:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mym9t4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:21:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CHLSFF16515820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:21:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2779258060;
	Mon, 12 Feb 2024 17:21:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8FF58043;
	Mon, 12 Feb 2024 17:21:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 17:21:24 +0000 (GMT)
Message-ID: <8d89f67b-fa66-492d-8339-baa586d0ca93@linux.ibm.com>
Date: Mon, 12 Feb 2024 12:21:23 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
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
 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uOXCzbmK3_nwpGIe6hrW3GVsbsUdt_V_
X-Proofpoint-ORIG-GUID: o5EoBELV83dp3OQdJea5KQ3RJesNYIc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120132



On 1/15/24 13:17, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_release hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> An LSM could implement an exclusive access scheme for files, only allowing
> access to files that have no references.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   fs/file_table.c               |  1 +
>   include/linux/lsm_hook_defs.h |  1 +
>   include/linux/security.h      |  4 ++++
>   security/security.c           | 11 +++++++++++
>   4 files changed, 17 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..c72dc75f2bd3 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -385,6 +385,7 @@ static void __fput(struct file *file)
>   	eventpoll_release(file);
>   	locks_remove_file(file);
>   
> +	security_file_release(file);
>   	ima_file_free(file);
>   	if (unlikely(file->f_flags & FASYNC)) {
>   		if (file->f_op->fasync)
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index c3fecc7dcb0b..229f84ce12ae 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -173,6 +173,7 @@ LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>   	 struct kernfs_node *kn)
>   LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
>   LSM_HOOK(int, 0, file_alloc_security, struct file *file)
> +LSM_HOOK(void, LSM_RET_VOID, file_release, struct file *file)
>   LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>   LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>   	 unsigned long arg)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 97f2212c13b6..2997348afcb7 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -395,6 +395,7 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
>   				  struct kernfs_node *kn);
>   int security_file_permission(struct file *file, int mask);
>   int security_file_alloc(struct file *file);
> +void security_file_release(struct file *file);
>   void security_file_free(struct file *file);
>   int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>   int security_file_ioctl_compat(struct file *file, unsigned int cmd,
> @@ -1008,6 +1009,9 @@ static inline int security_file_alloc(struct file *file)
>   	return 0;
>   }
>   
> +static inline void security_file_release(struct file *file)
> +{ }
> +
>   static inline void security_file_free(struct file *file)
>   { }
>   
> diff --git a/security/security.c b/security/security.c
> index f3d92bffd02f..7d10724872f8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2724,6 +2724,17 @@ int security_file_alloc(struct file *file)
>   	return rc;
>   }
>   
> +/**
> + * security_file_release() - Perform actions before releasing the file ref
> + * @file: the file
> + *
> + * Perform actions before releasing the last reference to a file.
> + */
> +void security_file_release(struct file *file)
> +{
> +	call_void_hook(file_release, file);
> +}
> +
>   /**
>    * security_file_free() - Free a file's LSM blob
>    * @file: the file

