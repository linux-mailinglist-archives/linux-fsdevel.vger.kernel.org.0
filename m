Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B26B0C55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjCHPQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjCHPQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:16:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61AD00AE;
        Wed,  8 Mar 2023 07:15:51 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328Dp3fQ030280;
        Wed, 8 Mar 2023 15:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=t/E/fSGrKzKvxHpmo7aESTIBZ8GiqCBUESMmRQywa9U=;
 b=f0cdyiByL8PYGkxbeqrx98JpH2NkhpbMyL5bIqWfW0TCbmtnA20BjgKoedox5GQOidCS
 ySWToEqZ8pEqqB93PtSW3+RqEnhvUDVdxFkx+rBg4dl/Myt3savD8cV0LnZrUKNvKftJ
 KGqjjSuoy2OPDpbd4fGInaLiT5F0bTQkJyohoU4i5zbam3budksrapiF+EBtOAMQvBcg
 YwO8otrw95n6aGtjjERuKy1bADRf0UID57P2nW5V32DAo8i/srVI5bERf+8Em2j+qrMH
 tdIHNDAMApU29QxCnSkKN3x9hWIVMZ6F0RXt+cwX2WqO2EmJnPt37azrffXaknBqSKz3 vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6sdf5n52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:15:31 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328Eipdw020618;
        Wed, 8 Mar 2023 15:15:30 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6sdf5n4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:15:30 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328Ek96O011844;
        Wed, 8 Mar 2023 15:15:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3p6gbv4hkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:15:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328FFRJv3277546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:15:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B25F658056;
        Wed,  8 Mar 2023 15:15:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A5758061;
        Wed,  8 Mar 2023 15:15:26 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:15:26 +0000 (GMT)
Message-ID: <502bd55cdbe47df40542f957f29f201502d7218f.camel@linux.ibm.com>
Subject: Re: [PATCH 03/28] ima: Align ima_post_create_tmpfile() definition
 with LSM infrastructure
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
Date:   Wed, 08 Mar 2023 10:15:25 -0500
In-Reply-To: <20230303181842.1087717-4-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pmLRYdIREL2fkuhzyb5F6JRAg6zVhzo4
X-Proofpoint-ORIG-GUID: QxW19gDVx-IM8EvWCLydpPz6eTx0GU3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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
> Change ima_post_create_tmpfile() definition, so that it can be registered
> as implementation of the post_create_tmpfile hook.

Since neither security_create_tmpfile() nor
security_post_create_tmpfile() already exist, why not pass a pointer to
the file to conform to the other file related security hooks?

Mimi

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/namei.c                        | 2 +-
>  include/linux/ima.h               | 7 +++++--
>  security/integrity/ima/ima_main.c | 8 ++++++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index b5a1ec29193..57727a1ae38 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3622,7 +3622,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		inode->i_state |= I_LINKABLE;
>  		spin_unlock(&inode->i_lock);
>  	}
> -	ima_post_create_tmpfile(idmap, inode);
> +	ima_post_create_tmpfile(idmap, dir, file_dentry(file), mode);
>  	return 0;
>  }
>  
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 179ce52013b..7535686a403 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -19,7 +19,8 @@ extern enum hash_algo ima_get_current_hash_algo(void);
>  extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask);
>  extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -				    struct inode *inode);
> +				    struct inode *dir, struct dentry *dentry,
> +				    umode_t mode);
>  extern void ima_file_free(struct file *file);
>  extern int ima_file_mmap(struct file *file, unsigned long reqprot,
>  			 unsigned long prot, unsigned long flags);
> @@ -69,7 +70,9 @@ static inline int ima_file_check(struct file *file, int mask)
>  }
>  
>  static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -					   struct inode *inode)
> +					   struct inode *dir,
> +					   struct dentry *dentry,
> +					   umode_t mode)
>  {
>  }
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 8941305376b..4a3d0c8bcba 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -659,16 +659,20 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
>  /**
>   * ima_post_create_tmpfile - mark newly created tmpfile as new
>   * @idmap: idmap of the mount the inode was found from
> - * @inode: inode of the newly created tmpfile
> + * @dir: inode structure of the parent of the new file
> + * @dentry: dentry structure of the new file
> + * @mode: mode of the new file
>   *
>   * No measuring, appraising or auditing of newly created tmpfiles is needed.
>   * Skip calling process_measurement(), but indicate which newly, created
>   * tmpfiles are in policy.
>   */
>  void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -			     struct inode *inode)
> +			     struct inode *dir, struct dentry *dentry,
> +			     umode_t mode)
>  {
>  	struct integrity_iint_cache *iint;
> +	struct inode *inode = dentry->d_inode;
>  	int must_appraise;
>  
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))


