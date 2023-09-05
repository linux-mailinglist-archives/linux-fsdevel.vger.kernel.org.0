Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717FB792EBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIETTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242305AbjIETTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:19:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2A10F6;
        Tue,  5 Sep 2023 12:19:00 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385H9I9t030125;
        Tue, 5 Sep 2023 17:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sA4yc35urFGEFm2JaQk9a3ciRg5yjoFGQTn/es6FlF4=;
 b=ZIzNLD4/69WRdBLhsUSxfkRQQnXlvmQimUjSQ+R3VnK++qEU5xKM8Hlvtk4v1DhYhYGy
 QmKZ/V5K2Rs1fOkgu7sVjri1z+Ni15xgQyiT0N0AL94q1PkTqF7FTxqLN8BZD3wqbOhU
 bkhfAe709lGRHmAV+XL7520eeEJY43edsDgGsykEOMQ4CDCZVJU6aaRJ2m0wbigmSvvA
 B3wJfz4XULh263NBtBbz4muvRvuiyxK5cJEobRDBjqJuiVfrJGv67fK0LQ2qqgzY6Wfk
 NkRGzgCh40xbznbVoCiVHynp0NJoSbn+Xx6vtfhZuGf+bmc1BBWsOKdNaeljutB6JHdc 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx77p2vdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:23:21 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385HA3ec001113;
        Tue, 5 Sep 2023 17:23:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx77p2vd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:23:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385G96ak001624;
        Tue, 5 Sep 2023 17:23:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsmvc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 17:23:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385HNI6D2818606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 17:23:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8828258056;
        Tue,  5 Sep 2023 17:23:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D475803F;
        Tue,  5 Sep 2023 17:23:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 17:23:17 +0000 (GMT)
Message-ID: <bd5ac59e-c3ef-8b64-2c4b-757eca5a9f5e@linux.ibm.com>
Date:   Tue, 5 Sep 2023 13:23:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/25] ima: Align ima_post_path_mknod() definition with
 LSM infrastructure
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
 <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PrliHsut_Q6NRmhtv4xHOj3gsmF5V1JJ
X-Proofpoint-GUID: waA3HYOQCLA8nbe-LZP80wuNysfGBLRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> Change ima_post_path_mknod() definition, so that it can be registered as
> implementation of the path_post_mknod hook. Since LSMs see a umask-stripped
> mode from security_path_mknod(), pass the same to ima_post_path_mknod() as
> well.
>
> Also, make sure that ima_post_path_mknod() is executed only if
> (mode & S_IFMT) is equal to zero or S_IFREG.
>
> Add this check to take into account the different placement of the
> path_post_mknod hook (to be introduced) in do_mknodat(). Since the new hook
> will be placed after the switch(), the check ensures that
> ima_post_path_mknod() is invoked as originally intended when it is
> registered as implementation of path_post_mknod.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/namei.c                        |  9 ++++++---
>   include/linux/ima.h               |  7 +++++--
>   security/integrity/ima/ima_main.c | 10 +++++++++-
>   3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index e56ff39a79bc..c5e96f716f98 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4024,6 +4024,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>   	struct path path;
>   	int error;
>   	unsigned int lookup_flags = 0;
> +	umode_t mode_stripped;
>   
>   	error = may_mknod(mode);
>   	if (error)
> @@ -4034,8 +4035,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>   	if (IS_ERR(dentry))
>   		goto out1;
>   
> -	error = security_path_mknod(&path, dentry,
> -			mode_strip_umask(path.dentry->d_inode, mode), dev);
> +	mode_stripped = mode_strip_umask(path.dentry->d_inode, mode);
> +
> +	error = security_path_mknod(&path, dentry, mode_stripped, dev);
>   	if (error)
>   		goto out2;
>   
> @@ -4045,7 +4047,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>   			error = vfs_create(idmap, path.dentry->d_inode,
>   					   dentry, mode, true);
>   			if (!error)
> -				ima_post_path_mknod(idmap, dentry);
> +				ima_post_path_mknod(idmap, &path, dentry,
> +						    mode_stripped, dev);
>   			break;
>   		case S_IFCHR: case S_IFBLK:
>   			error = vfs_mknod(idmap, path.dentry->d_inode,
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 910a2f11a906..179ce52013b2 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -32,7 +32,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
>   extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   			      enum kernel_read_file_id id);
>   extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				struct dentry *dentry);
> +				const struct path *dir, struct dentry *dentry,
> +				umode_t mode, unsigned int dev);
>   extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>   extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
>   extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> @@ -114,7 +115,9 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   }
>   
>   static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				       struct dentry *dentry)
> +				       const struct path *dir,
> +				       struct dentry *dentry,
> +				       umode_t mode, unsigned int dev)
>   {
>   	return;
>   }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 365db0e43d7c..76eba92d7f10 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -696,18 +696,26 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>   /**
>    * ima_post_path_mknod - mark as a new inode
>    * @idmap: idmap of the mount the inode was found from
> + * @dir: path structure of parent of the new file
>    * @dentry: newly created dentry
> + * @mode: mode of the new file
> + * @dev: undecoded device number
>    *
>    * Mark files created via the mknodat syscall as new, so that the
>    * file data can be written later.
>    */
>   void ima_post_path_mknod(struct mnt_idmap *idmap,
> -			 struct dentry *dentry)
> +			 const struct path *dir, struct dentry *dentry,
> +			 umode_t mode, unsigned int dev)
>   {
>   	struct integrity_iint_cache *iint;
>   	struct inode *inode = dentry->d_inode;
>   	int must_appraise;
>   
> +	/* See do_mknodat(), IMA is executed for case 0: and case S_IFREG: */
> +	if ((mode & S_IFMT) != 0 && (mode & S_IFMT) != S_IFREG)
> +		return;
> +

These checks are only needed later (16/25) but IMO ok to introduce now.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


