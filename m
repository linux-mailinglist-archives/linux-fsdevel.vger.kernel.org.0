Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1376B0C70
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCHPUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjCHPTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:19:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7495AF6A3;
        Wed,  8 Mar 2023 07:19:36 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Eof4v028629;
        Wed, 8 Mar 2023 15:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4CtqSlTtRa2zDBj0noBeDCXB//5VJ5JU8QEKZuC7gks=;
 b=maCDxhsr97CfgXrXkOWCS5pYGdjfzE1yWoQuguY61Jt6S7ZQiYe0UYFP/TdPtn1422WW
 CND34myf7HeHSqY+LmVQ1MC2oTwfBzlBjITUujAVX6UM0osO19J7Xgp7hTOTmDc61OJb
 q2Ke0SxwTq7NWv1SQuJyln968M83E0wgnzKSV8K8ZP7XGicO3xZeiOTycfuwsaeD+e55
 hk63okT/kTznU83BoeCeUs4eMDltoPCytPOlbsehZXBwtvLfBhNQDO0qynAxshKjRR9m
 s3FUx04OCRm+EgPcvugAjZcBQ4fGgolE7N6VzJEHHSSv6jGDIO2jLfsiFAy7f4l9r+X+ OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6pmxa0s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:19:10 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328EvbHe012765;
        Wed, 8 Mar 2023 15:19:09 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6pmxa0r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:19:09 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328E0Jsu016684;
        Wed, 8 Mar 2023 15:19:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3p6fhk3va4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:19:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328FJ7gW53608940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:19:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09D458068;
        Wed,  8 Mar 2023 15:19:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 831A858052;
        Wed,  8 Mar 2023 15:19:05 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:19:05 +0000 (GMT)
Message-ID: <1221e9c0192d8a6c55dd10471d7259549d87f0b2.camel@linux.ibm.com>
Subject: Re: [PATCH 14/28] security: Introduce inode_post_setattr hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, dmitry.kasatkin@gmail.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 08 Mar 2023 10:19:05 -0500
In-Reply-To: <20230303181842.1087717-15-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-15-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: loRp11pt8bKz3W85sk6ovHzNEIL7iZqZ
X-Proofpoint-ORIG-GUID: rOvpUuENJFdUZHal6Vhi53pHGu5LFb3F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

On Fri, 2023-03-03 at 19:18 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_setattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Other than the one minor comment below,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/attr.c                     |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index da45cf01be6..343d6d62435 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -485,6 +485,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> +		security_inode_post_setattr(idmap, dentry, ia_valid);
>  		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 4372a6b2632..eedefbcdde3 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -135,6 +135,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
>  LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
>  LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
>  	 struct iattr *attr)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
> +	 struct dentry *dentry, int ia_valid)
>  LSM_HOOK(int, 0, inode_getattr, const struct path *path)
>  LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name, const void *value,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cd23221ce9e..64224216f6c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -354,6 +354,8 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
>  int security_inode_permission(struct inode *inode, int mask);
>  int security_inode_setattr(struct mnt_idmap *idmap,
>  			   struct dentry *dentry, struct iattr *attr);
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 int ia_valid);
>  int security_inode_getattr(const struct path *path);
>  int security_inode_setxattr(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, const char *name,
> @@ -855,6 +857,11 @@ static inline int security_inode_setattr(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> +static inline void
> +security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			    int ia_valid)
> +{ }
> +
>  static inline int security_inode_getattr(const struct path *path)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index f7fe252e9d3..2dbf225f5d8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2190,6 +2190,22 @@ int security_inode_getattr(const struct path *path)
>  	return call_int_hook(inode_getattr, 0, path);
>  }
>  

Like the definitions, move the security_inode_post_setattr() to after
security_inode_setattr().

> +/**
> + * security_inode_post_setattr() - Update the inode after a setattr operation
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @ia_valid: file attributes set
> + *
> + * Update inode security field after successful setting file attributes.
> + */
> +void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *entry,
> +				 int ia_valid)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;
> +	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
> +}
> +
>  /**
>   * security_inode_setxattr() - Check if setting file xattrs is allowed
>   * @idmap: idmap of the mounth

-- 
thanks,

Mimi

