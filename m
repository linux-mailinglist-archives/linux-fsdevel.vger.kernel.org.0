Return-Path: <linux-fsdevel+bounces-2113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4C7E29E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126641C203DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAF29428;
	Mon,  6 Nov 2023 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ti5KhQ4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5582941E;
	Mon,  6 Nov 2023 16:34:55 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22077D45;
	Mon,  6 Nov 2023 08:34:53 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GBDot016609;
	Mon, 6 Nov 2023 16:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NeVOO3ag7WZ3PYhehXzcfy7HBo0MGidQ4RFYCFImuHo=;
 b=Ti5KhQ4cYjY6Lhp90ZbA9+NBrI2uy2L1eMEjA1rgCSRKlVSSzC7OMyah/wKBDMVTDZ6d
 HJeK9Zh7c9lN/bxud+2t5R++JWhvtkrSoT1qQx86wXVtH1cP6JAeBi5+siEtajgzsVz7
 nu3cvirrlN+9jRsCBWMy+37aJo2Q2JdT/SnusPK7zSuITU7Nzd9XNMbHU3fuSORVHsDU
 6ws19BbAK137zcyxURKAKCoGPWb6CVX+kQa3X7PKUt/Mzn/Yz+kChCikKrAAV1FMxNbm
 iB9TYcgVZ/laKohbIlcuc7CgzanWKETFKOvv9tjC8WhpDtvgFg/w/SVteBdxGhU26DFi bA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u71sgmfy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:34:09 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6GBO2I017071;
	Mon, 6 Nov 2023 16:34:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u71sgmfwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:34:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6EQYKC007930;
	Mon, 6 Nov 2023 16:34:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skaf3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:34:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6GY67t11928278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 16:34:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7618458059;
	Mon,  6 Nov 2023 16:34:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4E55805D;
	Mon,  6 Nov 2023 16:34:04 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Nov 2023 16:34:04 +0000 (GMT)
Message-ID: <3fe38f02c23bca8c516d6cdbbd85a1f748f64547.camel@linux.ibm.com>
Subject: Re: [PATCH v4 17/23] security: Introduce inode_post_remove_acl hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>
Date: Mon, 06 Nov 2023 11:34:03 -0500
In-Reply-To: <20231027083558.484911-18-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
	 <20231027083558.484911-18-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: x7u-W5Kl1lCEs0TlOvocnSxfIWeQ3iCj
X-Proofpoint-GUID: KAmYFfYLsGGXq8Y3wRs7SPWQOTkhpKZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060134

On Fri, 2023-10-27 at 10:35 +0200, Roberto Sassu wrote:
> diff --git a/security/security.c b/security/security.c
> index 622c24cbfbb6..6ca8fdd1f037 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2406,6 +2406,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>         return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
>  
> +/**
> + * security_inode_post_remove_acl() - Update inode sec after remove_acl op

"remove_acl op" doesn't add any additional information.   Both here and
in "security: Introduce inode_post_set_acl hook" the comment should be
the same. 

> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security field after successful remove_acl operation on @dentry
> + * in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +                                   struct dentry *dentry, const char *acl_name)
> +{
> +       if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +               return;
> +       call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr operation
>   * @dentry: file

-- 
thanks,

Mimi



