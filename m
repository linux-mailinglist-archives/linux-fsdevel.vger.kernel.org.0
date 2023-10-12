Return-Path: <linux-fsdevel+bounces-171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5F7C6E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FF0282A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110612511B;
	Thu, 12 Oct 2023 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lc/aI3bW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A0208B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 12:37:28 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63807DD;
	Thu, 12 Oct 2023 05:37:26 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBvELD020872;
	Thu, 12 Oct 2023 12:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=APF4ufeMOc4k/r9OsmCJnUHSmK96weybH+bNQw4RGrQ=;
 b=Lc/aI3bW3vLI32BS7MSViAmq98lluB1EavVbzzdPRjDuyPNsZdVZZUWT3ZNYY7xgRqM0
 JQI1H/YiHuDwlLoeWukHeO9EzNyx2uHBQjfK4t1/wku59ow9ucHiJs6VoyK7VtJ1bgXV
 uvyvfBZlmkKQ1+olnW9wGGgdDPshVesI3j7aXv85TyYJUjKpeyyOQNFs/+ZYPF3qU5do
 sgWQYs4N7ds7+1+I8vlozhwAh7Rjqv0czQ0qWw/bl1b9vLWaxBwq/+kiKd80kO0Xdfpp
 cMDPjGZqMZ/IoIL21BmeaZ4f9UVWEItKRHsYZXzs9W2A6Z2XmeaGyfKQ1O0zy/IrEScP 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpgcksaf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 12:36:51 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CCTN5d013746;
	Thu, 12 Oct 2023 12:36:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpgcksac3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 12:36:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9YUPh025907;
	Thu, 12 Oct 2023 12:36:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnqegw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 12:36:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CCakFx18023096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 12:36:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C9415806B;
	Thu, 12 Oct 2023 12:36:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFFA5804B;
	Thu, 12 Oct 2023 12:36:43 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.11.225])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 12:36:43 +0000 (GMT)
Message-ID: <2026a46459563d8f5d132a099f402ddad8f06fae.camel@linux.ibm.com>
Subject: Re: [PATCH v3 14/25] security: Introduce file_post_open hook
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 12 Oct 2023 08:36:43 -0400
In-Reply-To: <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: W4LRJQti9fHiQFFt0_wLJVRt3XCiNlF0
X-Proofpoint-ORIG-GUID: WVWDu9i6QufDrkrbNCw79s7W3Gf62yHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> file_post_open hook. Also, export security_file_post_open() for NFS.
> 
> It is useful for IMA to calculate the dhigest of the file content, and to
> decide based on that digest whether the file should be made accessible to
> the requesting process.

Please remove "It is usefile for".   Perhaps something along the lines:


Based on policy, IMA calculates the digest of the file content and
decides ...

> 
> LSMs should use this hook instead of file_open, if they need to make their
> decision based on an opened file (for example by inspecting the file
> content). The file is not open yet in the file_open hook.

The security hooks were originally defined for enforcing access
control.  As a result the hooks were placed before the action.  The
usage of the LSM hooks is not limited to just enforcing access control
these days.  For IMA/EVM to become full LSMs additional hooks are
needed post action.  Other LSMs, probably non-access control ones,
could similarly take some action post action, in this case successful
file open.

Having to justify the new LSM post hooks in terms of the existing LSMs,
which enforce access control, is really annoying and makes no sense. 
Please don't.

> The new hook can
> return an error and can cause the open to be aborted.

Please make this a separate pagraph.

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/namei.c                    |  2 ++
>  fs/nfsd/vfs.c                 |  6 ++++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 17 +++++++++++++++++
>  5 files changed, 32 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f5ec71360de..7dc4626859f0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3634,6 +3634,8 @@ static int do_open(struct nameidata *nd,
>  	error = may_open(idmap, &nd->path, acc_mode, open_flag);
>  	if (!error && !(file->f_mode & FMODE_OPENED))
>  		error = vfs_open(&nd->path, file);
> +	if (!error)
> +		error = security_file_post_open(file, op->acc_mode);
>  	if (!error)
>  		error = ima_file_check(file, op->acc_mode);
>  	if (!error && do_truncate)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8a2321d19194..3450bb1c8a18 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -862,6 +862,12 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out_nfserr;
>  	}
>  
> +	host_err = security_file_post_open(file, may_flags);
> +	if (host_err) {
> +		fput(file);
> +		goto out_nfserr;
> +	}
> +
>  	host_err = ima_file_check(file, may_flags);
>  	if (host_err) {
>  		fput(file);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 1153e7163b8b..60ed33f0c80d 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -188,6 +188,7 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>  	 struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)
>  LSM_HOOK(int, 0, file_open, struct file *file)
> +LSM_HOOK(int, 0, file_post_open, struct file *file, int mask)
>  LSM_HOOK(int, 0, file_truncate, struct file *file)
>  LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
>  	 unsigned long clone_flags)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 665bba3e0081..a0f16511c059 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -403,6 +403,7 @@ int security_file_send_sigiotask(struct task_struct *tsk,
>  				 struct fown_struct *fown, int sig);
>  int security_file_receive(struct file *file);
>  int security_file_open(struct file *file);
> +int security_file_post_open(struct file *file, int mask);
>  int security_file_truncate(struct file *file);
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
>  void security_task_free(struct task_struct *task);
> @@ -1044,6 +1045,11 @@ static inline int security_file_open(struct file *file)
>  	return 0;
>  }
>  
> +static inline int security_file_post_open(struct file *file, int mask)
> +{
> +	return 0;
> +}
> +
>  static inline int security_file_truncate(struct file *file)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 3947159ba5e9..3e0078b51e46 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2856,6 +2856,23 @@ int security_file_open(struct file *file)
>  	return fsnotify_perm(file, MAY_OPEN);
>  }
>  
> +/**
> + * security_file_post_open() - Recheck access to a file after it has been opened

The LSM post hooks aren't needed to enforce access control.   Probably
better to say something along the lines of "take some action after
successful file open".

> + * @file: the file
> + * @mask: access mask
> + *
> + * Recheck access with mask after the file has been opened. The hook is useful
> + * for LSMs that require the file content to be available in order to make
> + * decisions.

And reword the above accordingly.

> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_post_open(struct file *file, int mask)
> +{
> +	return call_int_hook(file_post_open, 0, file, mask);
> +}
> +EXPORT_SYMBOL_GPL(security_file_post_open);
> +
>  /**
>   * security_file_truncate() - Check if truncating a file is allowed
>   * @file: file

-- 
thanks,

Mimi


