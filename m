Return-Path: <linux-fsdevel+bounces-6936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D481EA46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 23:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872FE1C22051
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29025684;
	Tue, 26 Dec 2023 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hbhQNFEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E8F4E1;
	Tue, 26 Dec 2023 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQISBUn013302;
	Tue, 26 Dec 2023 22:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=QX/8r/eTbSQz/ANcD9xTm2MVORmshTWyQxvjDWlicFM=;
 b=hbhQNFEkfk+55HKnmoGkcLFb7Oof+wS0+gouORZJQ3G3396k+lPC96gfqG+n3CVJqG3w
 DN6a9JGrbr+zWJt3myfzsqkajuobMYQZShUAP/tViflGn0GLIWnqjD1vrTVE2P9wXCXw
 LhhWQrsL6JuDKPk8ZEsEVfc89/UenyCpvlZxYrVZNy+hR6iZeoBZs8WUKR5yfgY/KNnm
 mS0H4wwwNsLNp+XZdWrDnsa8jly4q29J2BJbceha3kg7/r1EWUM5U6MvDOOi7HgKHgVI
 ZcYQGBYnH6y+tRfmYu1zQcHlMnqEWAOHp3B1Qq2oh0ny1T109fe/ZWzlarKN528kslsQ Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v6xpswehq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 22:14:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BQLpSWW007268;
	Tue, 26 Dec 2023 22:14:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v6xpsweh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 22:14:03 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQKORSH017369;
	Tue, 26 Dec 2023 22:14:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6c3jxhk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 22:14:02 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BQME1eC40829640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Dec 2023 22:14:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DB5858056;
	Tue, 26 Dec 2023 22:14:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 324CB5803F;
	Tue, 26 Dec 2023 22:14:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.184.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Dec 2023 22:14:00 +0000 (GMT)
Message-ID: <b03e68e9fa1803d6b2cc7a2c0260f78a05a4d88e.camel@linux.ibm.com>
Subject: Re: [PATCH v8 21/24] evm: Move to LSM infrastructure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Tue, 26 Dec 2023 17:13:59 -0500
In-Reply-To: <20231214170834.3324559-22-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-22-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: is44P4jhmEorQ4L0DyOBUfQrrA9kamfJ
X-Proofpoint-GUID: cKHafkCFON1COfur3YkblPEwakOYjEWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-26_12,2023-12-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312260170

On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> As for IMA, move hardcoded EVM function calls from various places in the
> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> (last and always enabled like 'ima'). The order in the Makefile ensures
> that 'evm' hooks are executed after 'ima' ones.
> 
> Make EVM functions as static (except for evm_inode_init_security(), which
> is exported), and register them as hook implementations in init_evm_lsm().
> 
> Unlike before (see commit to move IMA to the LSM infrastructure),
> evm_inode_post_setattr(), evm_inode_post_set_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
> executed for private inodes.
> 

Missing is a comment on moving the inline function definitions -
evm_inode_remove_acl(), evm_inode_post_remove_acl(), and
evm_inode_post_set_acl() - to evm_main.c.

> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

[...] 
> @@ -2307,9 +2299,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  
>  	if (ret == 1)
>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> -	if (ret)
> -		return ret;
> -	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> +	return ret;
>  }

Even though capability will be called after EVM, it doesn't make a
difference in this instance.

[...]

>  /**
> @@ -2493,9 +2472,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>  	if (ret == 1)
>  		ret = cap_inode_removexattr(idmap, dentry, name);
> -	if (ret)
> -		return ret;
> -	return evm_inode_removexattr(idmap, dentry, name);
> +	return ret;
>  }

'security.capability' is one of the EVM protected xattrs.  As
capability isn't an LSM, it will now be called after EVM, which is a
problem.

-- 
thanks,

Mimi


