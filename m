Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8999E792EAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbjIETTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbjIETS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:18:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E914C1712;
        Tue,  5 Sep 2023 12:18:30 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385I8xgF006487;
        Tue, 5 Sep 2023 18:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oMCSbySD6qO+hkVV2TOuyb10G6/TIsmRykN9ZPcb8uo=;
 b=qbLsYYFw8RIxd2Z+iaaw8PE5o8PDj3XJT1GJHVbL9/t5ie8/CzB1E+kwO4/RVKbl/+m2
 efGJBEntMd2xdMQM0XSWGTcHcWQ27/B8UVU1m1muWpPdsYvA1EJl4myebCUi8aqkwVuz
 sTZ5qEZktMHjEa++uzSfqE/uB6FvVAC7zBrLcJZub1bph8HTDZiebqsc4OTd/OTqVKUe
 A6yXhJ7aBCDMebepCr3BgyDoSuVxpJge8xrYSJZ0fmg0UQ8AzFTR8OwYdmzMea7UbEKF
 j+LDDUPD/Tsc9iSg2jwCezZqJIJ3jQONLq9pNyrVOTUGe6WWjW6jxG7Nfb+QJGQaZ8eK QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx8h49hrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:11:02 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385I95WB007967;
        Tue, 5 Sep 2023 18:10:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx8h49h7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:10:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385GfDTu026826;
        Tue, 5 Sep 2023 18:10:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcnctbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 18:10:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385IAkl528770574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 18:10:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CBFB58061;
        Tue,  5 Sep 2023 18:10:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D81858063;
        Tue,  5 Sep 2023 18:10:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 18:10:44 +0000 (GMT)
Message-ID: <20a588ca-baee-e94b-11d6-d1f56c695c5b@linux.ibm.com>
Date:   Tue, 5 Sep 2023 14:10:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 14/25] security: Introduce file_post_open hook
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
 <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N2nLnmKdOlRduIAmDgmOzWx21xdhznR2
X-Proofpoint-ORIG-GUID: jtZkXbFKod4PEqOeGQ915dTFzUpQYLco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050157
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
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.
>
> It is useful for IMA to calculate the digest of the file content, and to
> decide based on that digest whether the file should be made accessible to
> the requesting process.
>
> LSMs should use this hook instead of file_open, if they need to make their
> decision based on an opened file (for example by inspecting the file
> content). The file is not open yet in the file_open hook. The new hook can
> return an error and can cause the open to be aborted.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   fs/namei.c                    |  2 ++
>   fs/nfsd/vfs.c                 |  6 ++++++
>   include/linux/lsm_hook_defs.h |  1 +
>   include/linux/security.h      |  6 ++++++
>   security/security.c           | 17 +++++++++++++++++
>   5 files changed, 32 insertions(+)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f5ec71360de..7dc4626859f0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3634,6 +3634,8 @@ static int do_open(struct nameidata *nd,
>   	error = may_open(idmap, &nd->path, acc_mode, open_flag);
>   	if (!error && !(file->f_mode & FMODE_OPENED))
>   		error = vfs_open(&nd->path, file);
> +	if (!error)
> +		error = security_file_post_open(file, op->acc_mode);
>   	if (!error)
>   		error = ima_file_check(file, op->acc_mode);
>   	if (!error && do_truncate)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8a2321d19194..3450bb1c8a18 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -862,6 +862,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>   		goto out_nfserr;
>   	}
>   
> +	host_err = security_file_post_open(file, may_flags);
> +	if (host_err) {
> +		fput(file);
> +		goto out_nfserr;
> +	}
> +
>   	host_err = ima_file_check(file, may_flags);
>   	if (host_err) {
>   		fput(file);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 1153e7163b8b..60ed33f0c80d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -188,6 +188,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>   	 struct fown_struct *fown, int sig)
>   LSM_HOOK(int, 0, file_receive, struct file *file)
>   LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
>   LSM_HOOK(int, 0, file_truncate, struct file *file)
>   LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>   	 unsigned long clone_flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 665bba3e0081..a0f16511c059 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -403,6 +403,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>   				 struct fown_struct *fown, int sig);
>   int security_file_receive(struct file *file);
>   int security_file_open(struct file *file);
> +int security_file_post_open(struct file *file, int mask);
>   int security_file_truncate(struct file *file);
>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>   void security_task_free(struct task_struct *task);
> @@ -1044,6 +1045,11 @@ static inline int security_file_open(struct file *file)
>   	return 0;
>   }
>   
> +static inline int security_file_post_open(struct file *file, int mask)
> +{
> +	return 0;
> +}
> +
>   static inline int security_file_truncate(struct file *file)
>   {
>   	return 0;
> diff --git a/security/security.c b/security/security.c
> index 3947159ba5e9..3e0078b51e46 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2856,6 +2856,23 @@ int security_file_open(struct file *file)
>   	return fsnotify_perm(file, MAY_OPEN);
>   }
>   
> +/**
> + * security_file_post_open() - Recheck access to a file after it has been opened
> + * @file: the file
> + * @mask: access mask
> + *
> + * Recheck access with mask after the file has been opened. The hook is useful
> + * for LSMs that require the file content to be available in order to make
> + * decisions.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_post_open(struct file *file, int mask)
> +{
> +	return call_int_hook(file_post_open, 0, file, mask);
> +}
> +EXPORT_SYMBOL_GPL(security_file_post_open);
> +
>   /**
>    * security_file_truncate() - Check if truncating a file is allowed
>    * @file: file
