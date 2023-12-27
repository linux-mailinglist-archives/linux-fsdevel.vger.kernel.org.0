Return-Path: <linux-fsdevel+bounces-6955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07181EF2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 14:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9201F22132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 13:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18945022;
	Wed, 27 Dec 2023 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVPGP1ul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AF44C7D;
	Wed, 27 Dec 2023 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BR9uNoV025429;
	Wed, 27 Dec 2023 13:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WPz+hpVpxsQ+qqqsD6Duvt6Nw2k7J7caNmsZW+HYcIg=;
 b=EVPGP1ulObLIlqPIw73X9pqR/DvX0lhu9lNbkAncPe69to+37jCQzA/Nk6yHyqwzM0HP
 6WnKLvvBth7jwzUkfXYYg0fOsLfN3+tZ6BBG3Aa9zAjrh0by6wokPNA4u77TezMBQTJW
 RSHCj6xCqZEAgQqEygzCU0PiHkVr8O9B5zshlLNvmwjiH6OX++jQwMt4e0jgBUI5SUZB
 FhOBAac0nrq4mGc6pySrBBbd0TGmlDJpvyo59hqOKXLLRpVSldJLho+jkWkIufch3X/K
 vl1w59NbUptOqxpeYchz5/gD7orKHIS5hCDqnrKT9zFPTsjiojbuxak/Vj2q2lFPHAUv 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8e31yv9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 13:22:34 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BRCukRQ007239;
	Wed, 27 Dec 2023 13:22:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8e31yv92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 13:22:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRAXfuE004750;
	Wed, 27 Dec 2023 13:22:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v6bckt6gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 13:22:32 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BRDMWLK16777788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 13:22:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE2E5805A;
	Wed, 27 Dec 2023 13:22:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 982E958054;
	Wed, 27 Dec 2023 13:22:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.80.254])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Dec 2023 13:22:29 +0000 (GMT)
Message-ID: <5aa5986266c3a3f834114a835378455cbbff7b64.camel@linux.ibm.com>
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
Date: Wed, 27 Dec 2023 08:22:27 -0500
In-Reply-To: <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-24-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: _d8Ygrcb_7dsdneF4-9o020pZsjVFlBn
X-Proofpoint-ORIG-GUID: SMb4ru960eYehQR330NQ-KnC6jxqCq89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-27_08,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=713 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312270100

On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Make the 'ima' LSM independent from the 'integrity' LSM by introducing IMA
> own integrity metadata (ima_iint_cache structure, with IMA-specific fields
> from the integrity_iint_cache structure), and by managing it directly from
> the 'ima' LSM.
> 
> Move the remaining IMA-specific flags to security/integrity/ima/ima.h,
> since they are now unnecessary in the common integrity layer.
> 
> Replace integrity_iint_cache with ima_iint_cache in various places
> of the IMA code.
> 
> Then, reserve space in the security blob for the entire ima_iint_cache
> structure, so that it is available for all inodes having the security blob
> allocated (those for which security_inode_alloc() was called).  Adjust the
> IMA code accordingly, call ima_iint_inode() to retrieve the ima_iint_cache
> structure. Keep the non-NULL checks since there can be inodes without
> security blob.

Previously the 'iint' memory was only allocated for regular files in
policy and were tagged S_IMA.  This patch totally changes when and how
memory is being allocated.  Does it make sense to allocate memory at
security_inode_alloc()?  Is this change really necessary for making IMA
a full fledged LSM?

Mimi

> 
> Don't include the inode pointer as field in the ima_iint_cache structure,
> since the association with the inode is clear. Since the inode field is
> missing in ima_iint_cache, pass the extra inode parameter to
> ima_get_verity_digest().
> 
> Finally, register ima_inode_alloc_security/ima_inode_free_security() to
> initialize/deinitialize the new ima_iint_cache structure (before this task
> was done by iint_init_always() and iint_free()). Also, duplicate
> iint_lockdep_annotate() for the ima_iint_cache structure, and name it
> ima_iint_lockdep_annotate().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>


