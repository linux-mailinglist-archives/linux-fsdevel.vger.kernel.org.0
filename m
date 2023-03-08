Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F36B0D34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCHPpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCHPop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:44:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE372BC;
        Wed,  8 Mar 2023 07:43:37 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328FDBc8022813;
        Wed, 8 Mar 2023 15:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1XKBGz6L+Gmy5WXWv/bJ3Jr0o/2Oj4GpILFhfE6SF5Q=;
 b=W0RX9YQPbFFzSZKz4S6lT0pK8pXGaBt0Zt3QBrRu8SzdLDepB++7EChTr+pfFIAN6YQs
 VeakPa5nDKcWifN24gb+yFjoHPHSYncpW90gH7w9KJ7/CixOQUiPbpfEwOUVxJYax7xw
 NVy+ZR/pSR6I7V4dyDjwgJ9+qeXvgdWSnxx4ePOG+jVovOnn5Wze3gmXGujVCJWw2Ln7
 g7JlvXMmb3pJLsRMuFZmCtK6c4euol13voxq9G/Rpnlh66I0veZ0wUgOfnWbI6L3Hgrr
 O7g8pZXQGg59rwezZZz9ztiQjY0CMKEYGSupxhWqJ68AVxfwYcz4qENrqu87zGAIVJfJ PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6pa73136-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:43:09 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 328FcEiS025409;
        Wed, 8 Mar 2023 15:43:08 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6pa7312n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:43:08 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 328EsNS4011838;
        Wed, 8 Mar 2023 15:43:07 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3p6gbv4pvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 15:43:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 328Fh53I51183992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 15:43:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52FB858059;
        Wed,  8 Mar 2023 15:43:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB86658057;
        Wed,  8 Mar 2023 15:43:03 +0000 (GMT)
Received: from sig-9-77-134-135.ibm.com (unknown [9.77.134.135])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 15:43:03 +0000 (GMT)
Message-ID: <f5a61c0f09c1b8d8aaeb99ad7ba4aab15818c5ed.camel@linux.ibm.com>
Subject: Re: [PATCH 15/28] security: Introduce inode_post_removexattr hook
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
Date:   Wed, 08 Mar 2023 10:43:03 -0500
In-Reply-To: <20230303181842.1087717-16-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
         <20230303181842.1087717-16-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rcDnmFkSeRtMQr31Sk-ko2LOYipxVCr9
X-Proofpoint-ORIG-GUID: lX655t0e_XgQfnp5nDGpuFc_8fvKNGV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
> the inode_post_removexattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/xattr.c                    |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 14a7eb3c8fa..10c959d9fc6 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -534,6 +534,7 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
>  
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		security_inode_post_removexattr(dentry, name);
>  		evm_inode_post_removexattr(dentry, name);
>  	}

Nothing wrong with this, but other places in this function test "if
(error) goto ...".   Perhaps it is time to clean this up.

>  
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eedefbcdde3..2ae5224d967 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -147,6 +147,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
>  LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
>  LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name)
> +LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
> +	 const char *name)

@Christian should the security_inode_removexattr() and
security_inode_post_removexattr() arguments be the same?

>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,

-- 
thanks,

Mimi

