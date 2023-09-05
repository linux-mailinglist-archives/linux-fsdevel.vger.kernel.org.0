Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5E792E30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbjIETB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbjIETBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:01:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040EE53;
        Tue,  5 Sep 2023 12:00:54 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385H7fKk026800;
        Tue, 5 Sep 2023 17:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ia1C3iKF3m+Dgw5fxSrpVwcFV9fIiMHXNzvPBAEcalE=;
 b=H7+iFy/7LT+1CmV1/kXfZq+1e554gphzAM3ojGb8quyi52L4MxWJgPZJmwVycmZ5svn5
 2aY4CxUqkgGfjgaV0/GliYmHjtBg2gv5Q9VQpgbONqQxIhWgm4xPcQteacfJjPwDgdtj
 pWdljAbzkq5l/H9WuSeju+R+5kL/gl1GEc6knKMlReqxXhZI3s5ZvFGl05SQXJg4s7O7
 XpafsS2t15U5kp5NedwVgBgZ1C3g6YaVgQ+bLjJkX6L2kUv5Fl61aKViHMHDasT7aoJ8
 ifZTmOFCf5s7YHvhPoaKv1z3H9fRyoN92d4WL9gSlGfWL/Qv9sYI/ECJ8ZXRKukP64bH RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx7tbj07g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:26:41 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385HNMNM007369;
        Tue, 5 Sep 2023 17:26:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx7tbj076-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:26:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385GvSlv006710;
        Tue, 5 Sep 2023 17:26:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkcbnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:26:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385HQcg759375874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 17:26:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABFAC58056;
        Tue,  5 Sep 2023 17:26:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC5785803F;
        Tue,  5 Sep 2023 17:26:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 17:26:36 +0000 (GMT)
Message-ID: <d1a03980-11ea-c2a2-69c3-6137e69e5db9@linux.ibm.com>
Date:   Tue, 5 Sep 2023 13:26:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/25] ima: Align ima_post_create_tmpfile() definition
 with LSM infrastructure
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
 <20230904133415.1799503-4-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mH9497JBU-JGokhYJM_EQ7FVLKqdlTde
X-Proofpoint-ORIG-GUID: PEnAzxXSl_CKe-6xjoSQi5wVko_julzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050148
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/4/23 09:33, Roberto Sassu wrote:

> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change ima_post_create_tmpfile() definition, so that it can be registered
> as implementation of the post_create_tmpfile hook.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/namei.c                        | 2 +-
>   include/linux/ima.h               | 7 +++++--
>   security/integrity/ima/ima_main.c | 8 ++++++--
>   3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index c5e96f716f98..1f5ec71360de 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3698,7 +3698,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>   		inode->i_state |= I_LINKABLE;
>   		spin_unlock(&inode->i_lock);
>   	}
> -	ima_post_create_tmpfile(idmap, inode);
> +	ima_post_create_tmpfile(idmap, dir, file, mode);
>   	return 0;
>   }
>   
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 179ce52013b2..893c3b98b4d0 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -19,7 +19,8 @@ extern enum hash_algo ima_get_current_hash_algo(void);
>   extern int ima_bprm_check(struct linux_binprm *bprm);
>   extern int ima_file_check(struct file *file, int mask);
>   extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -				    struct inode *inode);
> +				    struct inode *dir, struct file *file,
> +				    umode_t mode);
>   extern void ima_file_free(struct file *file);
>   extern int ima_file_mmap(struct file *file, unsigned long reqprot,
>   			 unsigned long prot, unsigned long flags);
> @@ -69,7 +70,9 @@ static inline int ima_file_check(struct file *file, int mask)
>   }
>   
>   static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -					   struct inode *inode)
> +					   struct inode *dir,
> +					   struct file *file,
> +					   umode_t mode)
>   {
>   }
>   
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 76eba92d7f10..52e742d32f4b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -663,16 +663,20 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
>   /**
>    * ima_post_create_tmpfile - mark newly created tmpfile as new
>    * @idmap: idmap of the mount the inode was found from
> - * @inode: inode of the newly created tmpfile
> + * @dir: inode structure of the parent of the new file
> + * @file: file descriptor of the new file
> + * @mode: mode of the new file
>    *
>    * No measuring, appraising or auditing of newly created tmpfiles is needed.
>    * Skip calling process_measurement(), but indicate which newly, created
>    * tmpfiles are in policy.
>    */
>   void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -			     struct inode *inode)
> +			     struct inode *dir, struct file *file,
> +			     umode_t mode)
>   {
>   	struct integrity_iint_cache *iint;
> +	struct inode *inode = file_inode(file);
>   	int must_appraise;
>   
>   	if (!ima_policy_flag || !S_ISREG(inode->i_mode))


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


