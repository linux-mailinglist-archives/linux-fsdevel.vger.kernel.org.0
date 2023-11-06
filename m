Return-Path: <linux-fsdevel+bounces-2115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6D7E2A1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E2FB20FCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AC2940C;
	Mon,  6 Nov 2023 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L4q+mC09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B476179B8;
	Mon,  6 Nov 2023 16:40:44 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2AAF3;
	Mon,  6 Nov 2023 08:40:43 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6G9wJq012558;
	Mon, 6 Nov 2023 16:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ntZsLRi2hus613FqdTu44OeobP9ahDx7BzxS4O7ju4U=;
 b=L4q+mC098fBK/UtAXsxypV3spcgftlRSQJy+2CUdgGUDbllToOxeEm8Ic1aTxLNFn60H
 kpBu540y2frJ67xd0dCxSk8FMsKSzWpz1OmRKQbbpIY/1/ke3t7u1IQVRHcYdbwxVMvE
 26w5IES8+okz+YwgVtpyzR2PI2Lkeen0BykOmCm4v6yaUBFVW+pnKoC8gS8xTf5h8k7p
 +lCFW1muge7J1+J9RgrHgn4x0ImTND3khz6cXsT9LliFLTEUYHWC3IUv6V2pjFOk5CYS
 xCH5uZN5SrorLDmGelw7b8Msj0PHgsuuWrOOt/lGky9E/UBf2iF70MbAcTeS/6wLmdF0 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73dwh8y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:40:14 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6GA5af013143;
	Mon, 6 Nov 2023 16:40:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73dwh8xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:40:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Eqi53028251;
	Mon, 6 Nov 2023 16:40:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gjt9gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Nov 2023 16:40:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6GeBce18875026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Nov 2023 16:40:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86AE658045;
	Mon,  6 Nov 2023 16:40:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E8E58056;
	Mon,  6 Nov 2023 16:40:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.58.168])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Nov 2023 16:40:09 +0000 (GMT)
Message-ID: <980b8df5eccc03a67328e28b7cef2b777bc310f0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 12/23] security: Introduce file_post_open hook
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
Date: Mon, 06 Nov 2023 11:40:08 -0500
In-Reply-To: <20231027083558.484911-13-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
	 <20231027083558.484911-13-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: zw57y4MwJGx3BnjPgEXX4OPSmxPCeezQ
X-Proofpoint-GUID: _5sXQ_fpTpFu-_ZM3yCz4MGm249TyFjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060134

On Fri, 2023-10-27 at 10:35 +0200, Roberto Sassu wrote:
> diff --git a/security/security.c b/security/security.c
> index 2ee958afaf40..d24a8f92d641 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2947,6 +2947,23 @@ int security_file_open(struct file *file)
>         return fsnotify_perm(file, MAY_OPEN);
>  }
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

The hook isn't limited to "Recheck access".    It's used for measuring,
appraising, and auditing a file's integrity.   Sorry for suggesting an
incomplete patch description.  Please update the wording here and the
patch description accordingly.

> + * Return: Returns 0 if permission is granted.
> + */
> +int security_file_post_open(struct file *file, int mask)
> +{
> +       return call_int_hook(file_post_open, 0, file, mask);
> +}
> +EXPORT_SYMBOL_GPL(security_file_post_open);
> +
>  /**
>   * security_file_truncate() - Check if truncating a file is allowed
>   * @file: file

-- 
thanks,

Mimi


