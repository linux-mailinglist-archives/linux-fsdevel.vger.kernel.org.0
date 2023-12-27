Return-Path: <linux-fsdevel+bounces-6941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4170181EBD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 04:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2060B21378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 03:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1942E3C15;
	Wed, 27 Dec 2023 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e5hXre4F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55A4405;
	Wed, 27 Dec 2023 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BR2gYuA019407;
	Wed, 27 Dec 2023 03:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=c9fQ+vhSJGXd98MvYdn4qO5cywrGCtI0rrUForI+urQ=;
 b=e5hXre4FR/bmvbP1EdTAZndf7m6VWSY10rIEx1GrE30k59YPO7QgrHMLEZw6ETd+9AtT
 rBi4aQGakAKzc279B18qlt7my1l3zKIjV3sd1s3eK4qbQ4bvFNC9dwSA2eF/Sxm8rtYh
 8ToAvnVeqns5nwbSRxLsMyFG46vXjDFSyisvin1D6mt61ez2LooZWmCdppoTYFYnXAzl
 qy5V5CIbgSFupGjOlvZIPpqwXhSQJo18Q7Yu3+UvUiyl1mlQjxZX6iWdjKcyv4mcEWjr
 5kefXO4DDcGVGtbTsPDoLxKLoSUelsk4p6X3RJjKwfUsoQX0VvkoRKhQY+t4ZzpXZ4PB 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8bcjrdrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 03:12:19 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BR2tLx8018208;
	Wed, 27 Dec 2023 03:12:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8bcjrdrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 03:12:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BR2Canx029924;
	Wed, 27 Dec 2023 03:12:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v6avng0sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 03:12:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BR3CHNq57278768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 03:12:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161CD58060;
	Wed, 27 Dec 2023 03:12:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB975803F;
	Wed, 27 Dec 2023 03:12:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.184.58])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Dec 2023 03:12:15 +0000 (GMT)
Message-ID: <3cfd131856909f8a36f502498987dece7a294a3e.camel@linux.ibm.com>
Subject: Re: [PATCH v8 22/24] evm: Make it independent from 'integrity' LSM
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
Date: Tue, 26 Dec 2023 22:12:15 -0500
In-Reply-To: <20231214170834.3324559-23-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-23-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: SLw6GlFKe5t0xvSpBXoE3IkAIYHg9flH
X-Proofpoint-ORIG-GUID: 50U8yRTnMXTyIllrq2rguBKkUj3Y8ROV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-26_14,2023-12-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312270024

On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Define a new structure for EVM-specific metadata, called evm_iint_cache,
> and embed it in the inode security blob. Introduce evm_iint_inode() to
> retrieve metadata, and register evm_inode_alloc_security() for the
> inode_alloc_security LSM hook, to initialize the structure (before
> splitting metadata, this task was done by iint_init_always()).
> 
> Keep the non-NULL checks after calling evm_iint_inode() except in
> evm_inode_alloc_security(), to take into account inodes for which
> security_inode_alloc() was not called. When using shared metadata,
> obtaining a NULL pointer from integrity_iint_find() meant that the file
> wasn't processed by IMA.

^wasn't in policy.

Ok.  So now regardless of the IMA policy, EVM always allocates and
stores the EVM status.  Depending on the IMA policy, the EVM status
could be saved for a lot more inodes.

> 
> Given that from now on EVM relies on its own metadata, remove the iint
> parameter from evm_verifyxattr(). Also, directly retrieve the iint in
> evm_verify_hmac(), called by both evm_verifyxattr() and
> evm_verify_current_integrity(), since now there is no performance penalty
> in retrieving EVM metadata (constant time).

Ok.  So the change only negatively impacts memory usage, not
performance.

> 
> Replicate the management of the IMA_NEW_FILE flag (now EVM_NEW_FILE), by
> introducing evm_post_path_mknod() and evm_file_free() to respectively set
> and clear the new flag at the same time IMA does.

nit:  Instead of "(now EVM_NEW_FILE)", add an additional sentence,
saying "Define EVM_NEW_FILE".

> A noteworthy difference
> is that evm_post_path_mknod() cannot check if a file must be appraised.

This is the result of making EVM independent of IMA's policy.  
Somewhere, here or above, this needs to be stated.

> Also, since IMA_NEW_FILE is always cleared in ima_check_last_writer() if it
> is set, it is not necessary to maintain an inode version in EVM to
> replicate the IMA logic (the inode version check is in OR).

IMA checking the i_version is to prevent unnecessarily having to re-
calculate the file data hash, which depending on the file size could
take a while.   This is unnecessary for EVM, as re-calculating the EVM
hmac is triggered anytime a trusted xattr is updated.  So only the EVM
new file flag needs to cleared on file free.

> Also, move the EVM-specific flag EVM_IMMUTABLE_DIGSIG to
> security/integrity/evm/evm.h, since that definition is now unnecessary in
> the common integrity layer.
> 
> Finally, switch to the LSM reservation mechanism for the EVM xattr, and
> consequently decrement by one the number of xattrs to allocate in
> security_inode_init_security().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

-- 
thanks,

Mimi


