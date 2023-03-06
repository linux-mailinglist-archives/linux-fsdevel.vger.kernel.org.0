Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3906ACE65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 20:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCFTqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 14:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCFTqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:46:19 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA74C29;
        Mon,  6 Mar 2023 11:46:15 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326JHNBG024357;
        Mon, 6 Mar 2023 19:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FX+IFbE0ww/sohan/gFdmJVjorKhB/Ioyds8Q7icbJI=;
 b=lAjfiH44YCyG6sKxvfeKrcin8u5oDtnnJQS54ES1j9On3tJHTy+aydiW0l8+LoxuQsC/
 Am6ZeHtKQsA2Qg/IvkJ0pExHj536NI5dm2jD0uxRqKbPRNUA1SMpz0t0ZLQUlbeBNkPI
 JKnA2HCPBKSeZ0nO7Z6eLNO3xiWZSFMg5wktMlU4deCLPecGYgt4ongUTgW9f8yQMspg
 rLMW9juB7bDQJ5vf0HdDE72PNStEs9BVBqZiUwpJXQjF21i9XlzgV67XurQsDpdJeL7j
 A/r+jPpSdobHxOHGmiMZaA94ly350tTWkQUqg8y2tJIOiE5EjJzlBbfn1eQWOqdSrLnK /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p5p6xgm66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 19:45:54 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326JK4vT008519;
        Mon, 6 Mar 2023 19:45:52 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p5p6xgm5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 19:45:52 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326J276S017282;
        Mon, 6 Mar 2023 19:45:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3p41akanws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 19:45:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326JjoHS36634910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 19:45:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD7ED5805D;
        Mon,  6 Mar 2023 19:45:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B9B958043;
        Mon,  6 Mar 2023 19:45:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 19:45:49 +0000 (GMT)
Message-ID: <cb76da88-c5c3-d7ca-59e9-a427faf73ddd@linux.ibm.com>
Date:   Mon, 6 Mar 2023 14:45:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 20/28] security: Introduce inode_post_set_acl hook
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
 <20230303181842.1087717-21-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230303181842.1087717-21-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pMS76I5j8_o5O3TGueGd4ennj0VFBiB_
X-Proofpoint-ORIG-GUID: Z4Ko6SqqL5giXG3ySAw6QhuLXH1MW3W4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_12,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/3/23 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.
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
> index 5a76fb35923..acddf2dff4c 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -1102,6 +1102,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>   		error = -EOPNOTSUPP;
>   	if (!error) {
>   		fsnotify_xattr(dentry);
> +		security_inode_post_set_acl(dentry, acl_name, kacl);
>   		evm_inode_post_set_acl(dentry, acl_name, kacl);
>   	}
>   
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 5dc2a7c3d9a..9a3e14db0af 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -156,6 +156,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>   	 const char *name)
>   LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> +	 const char *acl_name, struct posix_acl *kacl)
>   LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
>   	 struct dentry *dentry, const char *acl_name)
>   LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b3e201404dc..b0691bf7237 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -366,6 +366,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>   int security_inode_set_acl(struct mnt_idmap *idmap,
>   			   struct dentry *dentry, const char *acl_name,
>   			   struct posix_acl *kacl);
> +void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
> +				 struct posix_acl *kacl);
>   int security_inode_get_acl(struct mnt_idmap *idmap,
>   			   struct dentry *dentry, const char *acl_name);
>   int security_inode_remove_acl(struct mnt_idmap *idmap,
> @@ -893,6 +895,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
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
> index 8883082b686..fc11d70bb02 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2310,6 +2310,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>   	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
>   }
>   
> +/**
> + * security_inode_post_set_acl() - Update inode sec after set_acl operation

'sec' because 'security' doesn't let this fit into 80 characters for the line?

Update inode security after set_acl op     :-/
Update inode security after set_acl()      :-)

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
