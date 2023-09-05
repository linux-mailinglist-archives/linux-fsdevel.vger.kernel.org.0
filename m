Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70BD792F20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjIETmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjIETmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:42:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CE83;
        Tue,  5 Sep 2023 12:42:09 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ig0MM012704;
        Tue, 5 Sep 2023 19:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bCMjfEDcp2Ez/aiu5W/6HZO4RxBNtSX1WOn2U+dWPCY=;
 b=Gji0eTjieYIopOMrSQXGQHj6dcyqbEtyjCGy/ECSfZzYxaG+foYg1Yd4TAJKmcpc94ps
 TlMs4amep74vY/9pS/iB2Tbbf4Fc91VEexTTAT1D1IXVGXMbNY88lhDMuylIISMRg0xP
 cB9IPL4RIihXEt8UJ9a8cfuvGvJB+219S31D02AaFHSyUFdrWn6aDrrykrOTH/yc9Wmb
 M4tAFw8y0kYiznwrsg+SC5rSnCaCXq1CIPhQUb+I76vk2EuM/w/MDmIJz2m5ZwNWGuGc
 bFogB9yNXxFL4T2jNXR4hZKxCtMAX3xj3vFuKfqS/ylHqUwfzlcZmz1coVilHYdc23ne mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9ubgqvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:00:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385IiFbd024081;
        Tue, 5 Sep 2023 19:00:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9ubgquc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:00:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385HEH1q006625;
        Tue, 5 Sep 2023 19:00:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkcy8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:00:05 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385J053m33292850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 19:00:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1023C5806F;
        Tue,  5 Sep 2023 19:00:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DE9958064;
        Tue,  5 Sep 2023 19:00:03 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 19:00:03 +0000 (GMT)
Message-ID: <50674258-0f4e-eb6f-c40a-d905249a46d5@linux.ibm.com>
Date:   Tue, 5 Sep 2023 15:00:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 18/25] security: Introduce inode_post_set_acl hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
 <20230904133415.1799503-19-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-19-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NhzYSOGVVmNo22LqiQ8zhpZijtUlgBA9
X-Proofpoint-ORIG-GUID: byrWmNkxEDSLDaLa4lbAbuEE84jvN08e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050161
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/4/23 09:34, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.
>
> It is useful for EVM to recalculate the HMAC on the modified POSIX ACL and
> other file metadata, after it verified the HMAC of current file metadata
> with the inode_set_acl hook.
>
> LSMs should use the new hook instead of inode_set_acl, when they need to
> know that the operation was done successfully (not known in inode_set_acl).
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/posix_acl.c                |  1 +
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  7 +++++++
>   security/security.c           | 17 +++++++++++++++++
>   4 files changed, 27 insertions(+)
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 7fa1b738bbab..3b7dbea5c3ff 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1137,6 +1137,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>   		error = -EIO;
>   	if (!error) {
>   		fsnotify_xattr(dentry);
> +		security_inode_post_set_acl(dentry, acl_name, kacl);
>   		evm_inode_post_set_acl(dentry, acl_name, kacl);
>   	}
>   
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 9ae573b83737..bba1fbd97207 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -157,6 +157,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>   	 const char *name)
>   LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> +	 const char *acl_name, struct posix_acl *kacl)
>   LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name)
>   LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5f296761883f..556d019ebe5c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -367,6 +367,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>   int security_inode_set_acl(struct mnt_idmap *idmap,
>   			   struct dentry *dentry, const char *acl_name,
>   			   struct posix_acl *kacl);
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl);
>   int security_inode_get_acl(struct mnt_idmap *idmap,
>   			   struct dentry *dentry, const char *acl_name);
>   int security_inode_remove_acl(struct mnt_idmap *idmap,
> @@ -894,6 +896,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
>   	return 0;
>   }
>   
> +static inline void security_inode_post_set_acl(struct dentry *dentry,
> +					       const char *acl_name,
> +					       struct posix_acl *kacl)
> +{ }
> +
>   static inline int security_inode_get_acl(struct mnt_idmap *idmap,
>   					 struct dentry *dentry,
>   					 const char *acl_name)
> diff --git a/security/security.c b/security/security.c
> index aa6274c90147..aabace9e24d9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2260,6 +2260,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>   	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>   }
>   
> +/**
> + * security_inode_post_set_acl() - Update inode security after set_acl()
> + * @dentry: file
> + * @acl_name: acl name
> + * @kacl: acl struct
> + *
> + * Update inode security field after successful set_acl operation on @dentry.
> + * The posix acls in @kacl are identified by @acl_name.
> + */
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
> +}
> +
>   /**
>    * security_inode_get_acl() - Check if reading posix acls is allowed
>    * @idmap: idmap of the mount

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


