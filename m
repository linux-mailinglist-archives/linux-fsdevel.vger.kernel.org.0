Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FF792DB3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbjIEStx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 14:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbjIEStv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:49:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D863E42;
        Tue,  5 Sep 2023 11:49:25 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ifxnr012644;
        Tue, 5 Sep 2023 18:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BysWmv5+b5xLkW/mI6AvDI46yvyU4fYqmh+B5FEaFno=;
 b=P1mv3rWN6lGpM0G5gyZ/RVeZr1lZxYlDVbnlzPvBJF1orU3hFMnxYM0jaNwVYEsqSnuA
 shHSZwgsaZ3YNEyk8BE9RkrT4Nh7kuWtp9auFCCkuYcYTXQGx2mkiBu4fPMfqIZO++ib
 MQPWuaKHmpVeStXYFXigiGjLuJO8i4zJvH9kgxvBMnxW842zGbhSqSC3MqJWodRASqZs
 zm7SFd38U8y1T5uSYG4V+5uXWAHOVHT1m+29W2Kr8j2MiWiKM+Y4jQD1v6AF+McdL5HJ
 zJLiSGu4ykZQIYuWonjFZLjz5MDsu9KNmGbS8RktMYnz0G1+cIZxWo8+hj86DntYWnhc AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9ubg6w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:48:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385Ih8H5019146;
        Tue, 5 Sep 2023 18:48:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx9ubg6ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:48:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385Hk4Ik012212;
        Tue, 5 Sep 2023 18:48:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjvp6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:48:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385Im5Mm66388310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 18:48:05 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8981758056;
        Tue,  5 Sep 2023 18:48:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 069875803F;
        Tue,  5 Sep 2023 18:48:04 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 18:48:03 +0000 (GMT)
Message-ID: <b77aa6ef-52a7-60ff-02c3-e5d5c7b47daf@linux.ibm.com>
Date:   Tue, 5 Sep 2023 14:48:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/25] security: Introduce path_post_mknod hook
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
 <20230904133415.1799503-17-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-17-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oDjiXqgrQIyzJXgqTJVtf7KXp2QFjs7b
X-Proofpoint-ORIG-GUID: lfJ8vPCOs-R3MEUgvsCljD5LUQ_zf5uM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=863
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
> the path_post_mknod hook.
>
> It is useful for IMA to let new empty files be subsequently opened for
> further modification.
>
> LSMs can benefit from this hook to update the inode state after a file has
> been successfully created. The new hook cannot return an error and cannot
> cause the operation to be canceled.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/namei.c                    |  5 +++++
>   include/linux/lsm_hook_defs.h |  3 +++
>   include/linux/security.h      |  9 +++++++++
>   security/security.c           | 19 +++++++++++++++++++
>   4 files changed, 36 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 7dc4626859f0..c8c4ab26b52a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4061,6 +4061,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>   					  dentry, mode, 0);
>   			break;
>   	}
> +

Nit: remove empty line.


> +	if (error)
> +		goto out2;
> +
> +	security_path_post_mknod(idmap, &path, dentry, mode_stripped, dev);
>   out2:
>   	done_path_create(&path, dentry);
>   	if (retry_estale(error, lookup_flags)) {
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 797f51da3f7d..b1634b5de98c 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -93,6 +93,9 @@ LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
>   LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
>   LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
>   	 umode_t mode, unsigned int dev)
> +LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
> +	 const struct path *dir, struct dentry *dentry, umode_t mode,
> +	 unsigned int dev)
>   LSM_HOOK(int, 0, path_truncate, const struct path *path)
>   LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
>   	 const char *old_name)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7871009d59ae..f210bd66e939 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1842,6 +1842,9 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
>   int security_path_rmdir(const struct path *dir, struct dentry *dentry);
>   int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
>   			unsigned int dev);
> +void security_path_post_mknod(struct mnt_idmap *idmap, const struct path *dir,
> +			      struct dentry *dentry, umode_t mode,
> +			      unsigned int dev);
>   int security_path_truncate(const struct path *path);
>   int security_path_symlink(const struct path *dir, struct dentry *dentry,
>   			  const char *old_name);
> @@ -1876,6 +1879,12 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
>   	return 0;
>   }
>   
> +static inline void security_path_post_mknod(struct mnt_idmap *idmap,
> +					    const struct path *dir,
> +					    struct dentry *dentry, umode_t mode,
> +					    unsigned int dev)
> +{ }
> +
>   static inline int security_path_truncate(const struct path *path)
>   {
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index fbb58eeeea02..78aeb24efedb 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1702,6 +1702,25 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
>   }
>   EXPORT_SYMBOL(security_path_mknod);
>   
> +/**
> + * security_path_post_mknod() - Update inode security field after file creation
> + * @idmap: idmap of the mount
> + * @dir: parent directory
> + * @dentry: new file
> + * @mode: new file mode
> + * @dev: device number
> + *
> + * Update inode security field after a file has been created.
> + */
> +void security_path_post_mknod(struct mnt_idmap *idmap, const struct path *dir,
> +			      struct dentry *dentry, umode_t mode,
> +			      unsigned int dev)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
> +		return;
> +	call_void_hook(path_post_mknod, idmap, dir, dentry, mode, dev);
> +}
> +
>   /**
>    * security_path_mkdir() - Check if creating a new directory is allowed
>    * @dir: parent directory


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


