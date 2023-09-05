Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C0792CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 20:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjIESA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 14:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjIESAE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:00:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA10769C;
        Tue,  5 Sep 2023 10:57:08 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Hrnxm015843;
        Tue, 5 Sep 2023 17:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kT06frDQt3xylLC8EbArkQbk0wDCQ4MMKDzf+HhXt80=;
 b=loQfl1WabIEqQqg+xWr/7/LLgrRN1xh0xMOWQk9dggAsqvDv6itAciwOuybdehyxzwrH
 8bb0BvPgsVAeEjuk1s1yI21UXhxp3M01ZjgMWZv+jbgPY02QJjFi9O57c363eWvWyXIP
 QWTXLJYX54boQ74EiHUSSC9tftwHTpqe0MRarigCxK+s7x4/b7V5VyKabMzz7ANK6K85
 uwVvRWdRqAwk5m4fw9Bgc+asHJozidmRhvaL3bWFrUMypXWbC3LeCvu3DkV8x+PtACc/
 3AwaeS4QrqfrLB1Yzsqy/jNfRZ13XKvCK01Ro6e2HZJ8uCxpCnTLxOCJHOSJG25RH81A Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx8pg109s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:55:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385HrxJE016927;
        Tue, 5 Sep 2023 17:55:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx8pg1099-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:55:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385GJCvu021478;
        Tue, 5 Sep 2023 17:55:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfrycwqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:55:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385HtcSD1180304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 17:55:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C143B58061;
        Tue,  5 Sep 2023 17:55:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D901D5806A;
        Tue,  5 Sep 2023 17:55:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 17:55:36 +0000 (GMT)
Message-ID: <bfed43cd-029b-be93-8b0b-9e901eb57a5e@linux.ibm.com>
Date:   Tue, 5 Sep 2023 13:55:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 13/25] security: Introduce inode_post_removexattr hook
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
 <20230904133415.1799503-14-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-14-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uP63RghdXrVrrOQzg33fDaoggNWa6l_9
X-Proofpoint-GUID: sxq69O-4b-DSCGXrVqQCGnCssxGsJcny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050152
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
> the inode_post_removexattr hook.
>
> It is useful for EVM to recalculate the HMAC on the remaining file xattrs,
> and other file metadata, after it verified the HMAC of current file
> metadata with the inode_removexattr hook.
>
> LSMs should use the new hook instead of inode_removexattr, when they need
> to know that the operation was done successfully (not known in
> inode_removexattr). The new hook cannot return an error and cannot cause
> the operation to be reverted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/xattr.c                    |  9 +++++----
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  5 +++++
>   security/security.c           | 14 ++++++++++++++
>   4 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e7bbb7f57557..4a0280295686 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>   		goto out;
>   
>   	error = __vfs_removexattr(idmap, dentry, name);
> +	if (error)
> +		goto out;
>   
> -	if (!error) {
> -		fsnotify_xattr(dentry);
> -		evm_inode_post_removexattr(dentry, name);
> -	}
> +	fsnotify_xattr(dentry);
> +	security_inode_post_removexattr(dentry, name);
> +	evm_inode_post_removexattr(dentry, name);
>   
>   out:
>   	return error;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 995d30336cfa..1153e7163b8b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -148,6 +148,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
>   LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
>   LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> +	 const char *name)
>   LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>   LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 820899db5276..665bba3e0081 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -374,6 +374,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
>   int security_inode_listxattr(struct dentry *dentry);
>   int security_inode_removexattr(struct mnt_idmap *idmap,
>   			       struct dentry *dentry, const char *name);
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name);
>   int security_inode_need_killpriv(struct dentry *dentry);
>   int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>   int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -919,6 +920,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
>   	return cap_inode_removexattr(idmap, dentry, name);
>   }
>   
> +static inline void security_inode_post_removexattr(struct dentry *dentry,
> +						   const char *name)
> +{ }
> +
>   static inline int security_inode_need_killpriv(struct dentry *dentry)
>   {
>   	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 764a6f28b3b9..3947159ba5e9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2354,6 +2354,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>   	return evm_inode_removexattr(idmap, dentry, name);
>   }
>   
> +/**
> + * security_inode_post_removexattr() - Update the inode after a removexattr op
> + * @dentry: file
> + * @name: xattr name
> + *
> + * Update the inode after a successful removexattr operation.
> + */
> +void security_inode_post_removexattr(struct dentry *dentry, const char *name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_removexattr, dentry, name);
> +}
> +
>   /**
>    * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>    * @dentry: associated dentry


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


