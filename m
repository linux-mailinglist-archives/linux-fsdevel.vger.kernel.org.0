Return-Path: <linux-fsdevel+bounces-7135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2E822091
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EA01F21061
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A19156F4;
	Tue,  2 Jan 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dgoP3kcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654D156EC;
	Tue,  2 Jan 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 402HI09n019616;
	Tue, 2 Jan 2024 17:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y42mo2JnJSDN9WOIeW8Q048HnRpueulusig05FfdHSc=;
 b=dgoP3kcJoBgDCM9LrG2PGDCQO/22Bz5HCVjjcGaCW2HD1d78czChL9JN0t8UI/BTCRA6
 nQc7vUnm2EFfMkazXQ/6je+MhIFtH5XXoT6cIt5REwXEUrAsI1T/u6LhWPo1R9o2+1fq
 WR43NDCuqemyLlU9YWC8+9/pR/U1v5HQQFTMqRF1Lvxk7cHS/mCTPr56WOay9HDj3fCn
 V19+gZPAukXreGvyxZ07WKgq4LrTp45CCS6Cy9qpAIydAyuZJuy3PmxMIjeXl0hWdR92
 wnUUH4PSpI0t1p1yDjicQYtPocb4IT+hNdbDuEJfW33Bozg7zhfKHO1l0s4zuIaWpFsb 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcprx8hgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:44:21 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 402HJEQj023759;
	Tue, 2 Jan 2024 17:44:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vcprx8hgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:44:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 402Gn5st007335;
	Tue, 2 Jan 2024 17:44:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vaxhnxatc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 17:44:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 402HiILQ3736236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jan 2024 17:44:18 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C62F58056;
	Tue,  2 Jan 2024 17:44:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C239858052;
	Tue,  2 Jan 2024 17:44:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.135.171])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jan 2024 17:44:16 +0000 (GMT)
Message-ID: <08e90ff7754aad45785ab05576f308a7aaae3438.camel@linux.ibm.com>
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
Date: Tue, 02 Jan 2024 12:44:16 -0500
In-Reply-To: <42911719-547d-443a-b2f2-07b0cfb11f7a@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-22-roberto.sassu@huaweicloud.com>
	 <b03e68e9fa1803d6b2cc7a2c0260f78a05a4d88e.camel@linux.ibm.com>
	 <42911719-547d-443a-b2f2-07b0cfb11f7a@huaweicloud.com>
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
X-Proofpoint-GUID: VtIxUobX29if44MZAZlKTPViebn08Xdu
X-Proofpoint-ORIG-GUID: 4wNfWCza0Tzp9fc5Zi2QfysG-XW8l4q-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-02_06,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=926 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401020133

On Tue, 2024-01-02 at 12:56 +0100, Roberto Sassu wrote:
> On 12/26/2023 11:13 PM, Mimi Zohar wrote:
> > On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> As for IMA, move hardcoded EVM function calls from various places in the
> >> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> >> (last and always enabled like 'ima'). The order in the Makefile ensures
> >> that 'evm' hooks are executed after 'ima' ones.
> >>
> >> Make EVM functions as static (except for evm_inode_init_security(), which
> >> is exported), and register them as hook implementations in init_evm_lsm().
> >>
> >> Unlike before (see commit to move IMA to the LSM infrastructure),
> >> evm_inode_post_setattr(), evm_inode_post_set_acl(),
> >> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
> >> executed for private inodes.
> >>
> > 
> > Missing is a comment on moving the inline function definitions -
> > evm_inode_remove_acl(), evm_inode_post_remove_acl(), and
> > evm_inode_post_set_acl() - to evm_main.c.
> 
> Ok.
> 
> >> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
> >>
> >> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> >> ---
> > 
> > [...]
> >> @@ -2307,9 +2299,7 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
> >>   
> >>   	if (ret == 1)
> >>   		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> >> -	if (ret)
> >> -		return ret;
> >> -	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> >> +	return ret;
> >>   }
> > 
> > Even though capability will be called after EVM, it doesn't make a
> > difference in this instance.
> > 
> > [...]
> > 
> >>   /**
> >> @@ -2493,9 +2472,7 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
> >>   	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
> >>   	if (ret == 1)
> >>   		ret = cap_inode_removexattr(idmap, dentry, name);
> >> -	if (ret)
> >> -		return ret;
> >> -	return evm_inode_removexattr(idmap, dentry, name);
> >> +	return ret;
> >>   }
> > 
> > 'security.capability' is one of the EVM protected xattrs.  As
> > capability isn't an LSM, it will now be called after EVM, which is a
> > problem.
> 
> Uhm, according to this comment in security_inode_removexattr() and 
> security_inode_setxattr():
> 
> 	/*
> 	 * SELinux and Smack integrate the cap call,
> 	 * so assume that all LSMs supplying this call do so.
> 	 */
> 
> We can add the call to IMA and EVM as well, to be compliant.

SELinux and Smack are the only current LSMs that register the
security_inode_removexattr hook.  Both enforce mandatory access
control,
so their calling capabilities to enforce DAC kind of makes sense.  I'm
not sure it makes sense for IMA and EVM to call capability directly,
just because of the comment.

> However, I'm missing why the two cases are different. It seems 
> cap_inode_set/removexattr() are doing just checks.

Both IMA and EVM require CAP_SYS_ADMIN to write/remove security.ima and
security.evm respectively.  In addition, EVM must recalculate
security.evm if any protected security xattrs are set or
removed.   However, security.evm is updated on
security_inode_post_setxattr, not security_inode_setxattr.

Mimi


