Return-Path: <linux-fsdevel+bounces-6969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826BC81F19A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 20:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46EAB217BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7347F46;
	Wed, 27 Dec 2023 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bVtsB3an"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1E46B85;
	Wed, 27 Dec 2023 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRFrDWu015987;
	Wed, 27 Dec 2023 19:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=18f/gr/PZcXdeMM5kpAIhPR02z3c/KDZi/eOcuzIIpQ=;
 b=bVtsB3annBIu4X6srNn88R2Vl4YR8tkm/MkIDQOt+CJnjUudlHDyvvtuYUnkqLxa6Y4K
 VrtdgWWkDpNwGFkQ/DdUqkL/EbmNwifBK+8TkMaPTUvSGhAG2bkMa7iUk74lWbLfeNo1
 Rbu9Rf1wPuB8Ves/aRY+oPoa2u54fwch5e5cOpn1MFlXn1mZg90QPfsvH2pzC6MR/IIv
 9Ob8WYFq2s8cORaUzVWSo9Np2P8zq2IVmRPXmt2HfvLVXfFg5CF/G0O9V00Y5FAF7omV
 +rV4EUw/YFbCa7pFwWLpD1aR0GueZPwEIAyb30YHEX0qAXiYSaOhW0dxN+tSsQL+1Q8U tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8pxvkj0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 19:21:24 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BRJDXvQ032429;
	Wed, 27 Dec 2023 19:21:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8pxvkj07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 19:21:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRGAZE4008402;
	Wed, 27 Dec 2023 19:21:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v69vsv4r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 19:21:22 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BRJLLSj61866258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 19:21:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC475805D;
	Wed, 27 Dec 2023 19:21:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90C758052;
	Wed, 27 Dec 2023 19:21:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.140.144])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Dec 2023 19:21:19 +0000 (GMT)
Message-ID: <96f82924cd2fda95f0c89341215e128419bf77fd.camel@linux.ibm.com>
Subject: Re: [PATCH v8 23/24] ima: Make it independent from 'integrity' LSM
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
Date: Wed, 27 Dec 2023 14:21:18 -0500
In-Reply-To: <ff8e6341-1ff0-4163-b5c7-236a0e8bdc7c@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
	 <5aa5986266c3a3f834114a835378455cbbff7b64.camel@linux.ibm.com>
	 <ff8e6341-1ff0-4163-b5c7-236a0e8bdc7c@huaweicloud.com>
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
X-Proofpoint-GUID: ZuI2XL95XsmBzpGslmSc2WJbPjAOR3zJ
X-Proofpoint-ORIG-GUID: 96PxLxuOz0BBu8l6Y97vO_NKje96XAZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-27_12,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=932 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312270142

On Wed, 2023-12-27 at 17:39 +0100, Roberto Sassu wrote:
> On 12/27/2023 2:22 PM, Mimi Zohar wrote:
> > On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Make the 'ima' LSM independent from the 'integrity' LSM by introducing IMA
> >> own integrity metadata (ima_iint_cache structure, with IMA-specific fields
> >> from the integrity_iint_cache structure), and by managing it directly from
> >> the 'ima' LSM.
> >>
> >> Move the remaining IMA-specific flags to security/integrity/ima/ima.h,
> >> since they are now unnecessary in the common integrity layer.
> >>
> >> Replace integrity_iint_cache with ima_iint_cache in various places
> >> of the IMA code.
> >>
> >> Then, reserve space in the security blob for the entire ima_iint_cache
> >> structure, so that it is available for all inodes having the security blob
> >> allocated (those for which security_inode_alloc() was called).  Adjust the
> >> IMA code accordingly, call ima_iint_inode() to retrieve the ima_iint_cache
> >> structure. Keep the non-NULL checks since there can be inodes without
> >> security blob.
> > 
> > Previously the 'iint' memory was only allocated for regular files in
> > policy and were tagged S_IMA.  This patch totally changes when and how
> > memory is being allocated.  Does it make sense to allocate memory at
> > security_inode_alloc()?  Is this change really necessary for making IMA
> > a full fledged LSM?
> 
> Good question. I think it wouldn't be necessary, we can reuse the same 
> approach as in the patch 'integrity: Switch from rbtree to LSM-managed 
> blob for integrity_iint_cache'.

Going forward with the v8 proposed solution would require some real
memory usage analysis for different types of policies.

To me the "integrity: Switch from rbtree to LSM-managed blob for
integrity_iint_cache" makes a lot more sense.   Looking back at the
original thread, your reasons back then for not directly allocating the
integrity_iint_cache are still valid for the ima_iint_cache structure.

Mimi

> > 
> >>
> >> Don't include the inode pointer as field in the ima_iint_cache structure,
> >> since the association with the inode is clear. Since the inode field is
> >> missing in ima_iint_cache, pass the extra inode parameter to
> >> ima_get_verity_digest().
> >>
> >> Finally, register ima_inode_alloc_security/ima_inode_free_security() to
> >> initialize/deinitialize the new ima_iint_cache structure (before this task
> >> was done by iint_init_always() and iint_free()). Also, duplicate
> >> iint_lockdep_annotate() for the ima_iint_cache structure, and name it
> >> ima_iint_lockdep_annotate().
> >>
> >> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 



