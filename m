Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5021E792F28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbjIETml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjIETmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:42:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE329C;
        Tue,  5 Sep 2023 12:42:37 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385JbE4N005359;
        Tue, 5 Sep 2023 19:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=C2S+okgiC3q3xjhMLQLURdpKIlXqqgqAfrFIsMS+dHk=;
 b=oBciih5S+vvO8syo1xz0vrSQrthE63QyAuhnTu/dB2pFTBM4Z7G7oYvfFpCc1DSp5B4d
 GIT7y4Fm7fcNY79s+vZZmbU9URvaoLRpRmjsJK5aagrD9lmJYAG7Nc8SXzMgpCfabQdN
 2qJ1Lm8WrcIEUcMHqszR+aZl9tBURaO0XREMfL+TOf2b6na0W/EH8Edk2hbRihvrJpPw
 kx5QahRKg8oz28BSRVpzb7TdVQf7QHfOXurx8ZtUj+RMuiGTRlghNtPYV2qjnMjJ4Vnn
 pDc0V723isfjP9JDehWuAiXAFKb7+YBIFNQpfvikGUOeM0J6XTpyShLSRwBg9ZUeR22m cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxafqgsqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:42:00 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385JbgVA009382;
        Tue, 5 Sep 2023 19:41:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxafqgs70-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 19:41:58 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385HaL2W012246;
        Tue, 5 Sep 2023 18:52:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjvq0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:52:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385IqLSc131726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 18:52:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C263458061;
        Tue,  5 Sep 2023 18:52:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C3DC58064;
        Tue,  5 Sep 2023 18:52:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 18:52:20 +0000 (GMT)
Message-ID: <f4afdc6a-bc60-1032-21d8-2f1450ba993f@linux.ibm.com>
Date:   Tue, 5 Sep 2023 14:52:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 17/25] security: Introduce inode_post_create_tmpfile
 hook
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
 <20230904133415.1799503-18-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-18-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I9Nai-GmrMO9y-P5hnb5rfRMfhEg5e1g
X-Proofpoint-GUID: rMEsMEA_ht0gMfXchHlezw9cK4C9WmaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050171
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
> the inode_post_create_tmpfile hook.
>
> It is useful for IMA to mark new temp files as successfully appraised and
> let them be subsequently opened for further modification.
>
> LSMs can benefit from this hook to update the inode state after a temp file
> has been successfully created. The new hook cannot return an error and
> cannot cause the operation to be canceled.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/namei.c                    |  1 +
>   include/linux/lsm_hook_defs.h |  2 ++
>   include/linux/security.h      |  8 ++++++++
>   security/security.c           | 18 ++++++++++++++++++
>   4 files changed, 29 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index c8c4ab26b52a..efed0e1e93f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3700,6 +3700,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>   		inode->i_state |= I_LINKABLE;
>   		spin_unlock(&inode->i_lock);
>   	}
> +	security_inode_post_create_tmpfile(idmap, dir, file, mode);
>   	ima_post_create_tmpfile(idmap, dir, file, mode);
>   	return 0;
>   }
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index b1634b5de98c..9ae573b83737 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
>   	 const struct qstr *name, const struct inode *context_inode)
>   LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
>   	 umode_t mode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
> +	 struct inode *dir, struct file *file, umode_t mode)
>   LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
>   	 struct dentry *new_dentry)
>   LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index f210bd66e939..5f296761883f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -338,6 +338,9 @@ int security_inode_init_security_anon(struct inode *inode,
>   				      const struct qstr *name,
>   				      const struct inode *context_inode);
>   int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *dir, struct file *file,
> +					umode_t mode);
>   int security_inode_link(struct dentry *old_dentry, struct inode *dir,
>   			 struct dentry *new_dentry);
>   int security_inode_unlink(struct inode *dir, struct dentry *dentry);
> @@ -788,6 +791,11 @@ static inline int security_inode_create(struct inode *dir,
>   	return 0;
>   }
>   
> +static inline void
> +security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> +				   struct file *file, umode_t mode)
> +{ }
> +
>   static inline int security_inode_link(struct dentry *old_dentry,
>   				       struct inode *dir,
>   				       struct dentry *new_dentry)
> diff --git a/security/security.c b/security/security.c
> index 78aeb24efedb..aa6274c90147 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1920,6 +1920,24 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
>   }
>   EXPORT_SYMBOL_GPL(security_inode_create);
>   
> +/**
> + * security_inode_post_create_tmpfile() - Update inode security field after creation of tmpfile
> + * @idmap: idmap of the mount
> + * @dir: the inode of the base directory
> + * @file: file descriptor of the new tmpfile
> + * @mode: the mode of the new tmpfile
> + *
> + * Update inode security field after a tmpfile has been created.
> + */
> +void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
> +					struct inode *dir,
> +					struct file *file, umode_t mode)
> +{
> +	if (unlikely(IS_PRIVATE(dir)))
> +		return;
> +	call_void_hook(inode_post_create_tmpfile, idmap, dir, file, mode);
> +}
> +
>   /**
>    * security_inode_link() - Check if creating a hard link is allowed
>    * @old_dentry: existing file


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


