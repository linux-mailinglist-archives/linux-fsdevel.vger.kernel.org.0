Return-Path: <linux-fsdevel+bounces-68-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554267C56CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DA42826BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03B120335;
	Wed, 11 Oct 2023 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kNh1IE6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FB1EA8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 14:27:20 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0C0B6;
	Wed, 11 Oct 2023 07:27:18 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BEKJgZ026056;
	Wed, 11 Oct 2023 14:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hwv9Ln5vwUJ6RTl5oYfvcx3p5aoxxW+VLSzODqPcTGI=;
 b=kNh1IE6/AIonVhJ3NCWkxse1DrFFdg9H2SIIDT0wD5L34gedEFjLcq5xQuuyRN3HvbIe
 tf/n/SVSv0/yCMxa1SfbrYd0Rxd7KoXtilfS5knyDmocKIVnYAQO++PUIMmMMTVNeMrz
 6iLn6K+iDQYkNuqsEs6tdYZ7pTKGijxGrfB0Ijrd9efrHf3yAdRWnwXrScKgEFLAaA27
 48x6JtzwPZd/cnaUR7o8QX5l/8s+Ton/qklkSwip7VmHnAe0nFrdNdGq5qPTf0csW1jV
 cRPO4ZyPhP7EhDlkKOIyWn6GYE9xIBy3Me+t4Z2mL3iYm6jpJ06cpbj6NEmr8W1r20F7 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwcng7ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 14:26:30 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BELEdB029444;
	Wed, 11 Oct 2023 14:26:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwcng7e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 14:26:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BE3NVc025863;
	Wed, 11 Oct 2023 14:26:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnngkm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 14:26:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BEQSHP27001392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 14:26:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0038B5803F;
	Wed, 11 Oct 2023 14:26:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC4558056;
	Wed, 11 Oct 2023 14:26:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.67.198])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Oct 2023 14:26:26 +0000 (GMT)
Message-ID: <e9c402eac882ada620b9bf9aadd507ae51bd4a7f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/25] ima: Align ima_inode_post_setattr() definition
 with LSM infrastructure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>
Date: Wed, 11 Oct 2023 10:26:26 -0400
In-Reply-To: <20230904133415.1799503-2-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t0qch1x91VHPl_IFUTpYzTcwiC6OKrX2
X-Proofpoint-GUID: Pm1mNEanTYeYNl1mS2QD2BQ4BS1Re_WB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change ima_inode_post_setattr() definition, so that it can be registered as
> implementation of the inode_post_setattr hook.

Please indicate inode_post_settattr() is a new hook.  In general it
should be stated on first usage.  In 02/25 the wording "(to be
introduced)" is used, but not on first usage.  Please add "(to be
introduced)" after inode_post_setattr.

Adding a new security hook argument would be to support both IMA and
EVM, which have different options.

Mimi

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/attr.c                             | 2 +-
>  include/linux/ima.h                   | 4 ++--
>  security/integrity/ima/ima_appraise.c | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index d60dc1edb526..7d4553c1208d 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -486,7 +486,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
> -		ima_inode_post_setattr(idmap, dentry);
> +		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(dentry, ia_valid);
>  	}
>  
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 86b57757c7b1..910a2f11a906 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -186,7 +186,7 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -				   struct dentry *dentry);
> +				   struct dentry *dentry, int ia_valid);
>  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len);
>  extern int ima_inode_set_acl(struct mnt_idmap *idmap,
> @@ -206,7 +206,7 @@ static inline bool is_ima_appraise_enabled(void)
>  }
>  h
>  static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -					  struct dentry *dentry)
> +					  struct dentry *dentry, int ia_valid)
>  {
>  	return;
>  }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 491c1aca0b1c..6b032bce4fe7 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -627,6 +627,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>   * ima_inode_post_setattr - reflect file metadata changes
>   * @idmap:  idmap of the mount the inode was found from
>   * @dentry: pointer to the affected dentry
> + * @ia_valid: for the UID and GID status
>   *
>   * Changes to a dentry's metadata might result in needing to appraise.
>   *
> @@ -634,7 +635,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>   * to lock the inode's i_mutex.
>   */
>  void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -			    struct dentry *dentry)
> +			    struct dentry *dentry, int ia_valid)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct integrity_iint_cache *iint;



