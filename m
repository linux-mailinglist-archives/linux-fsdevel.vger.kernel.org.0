Return-Path: <linux-fsdevel+bounces-11180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D242851DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC091C218B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3284147A66;
	Mon, 12 Feb 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JU3sj7wi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDF3EA78;
	Mon, 12 Feb 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765233; cv=none; b=bnoftLAzaY+2X1WgKv4dsXB+TfjjknTpdbJpIIhbNpX4dBme+GfAYbItsqd4jUjkUxetBNQ1u/kAeLI2bZbyxEne/utg6whQsG4hZIVYHgGLPlNs+NjFvG1noPfbPXDehUZMN+q5ufSfj4thsBURkZmGwrh3tvOJpI8bQEXstnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765233; c=relaxed/simple;
	bh=Zg4dI59X8fKukbLuWBgS80Z3J3/AqqKxoPMGlLwMCM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3IAYJ4hB+DAJACU22PSFaGvCFwwJptLbGJn8YvE3SJlYARDufK40+SW9oNnGv34cn0Y+QXzgSP8mSzdeIW7CVybj7PSidLrDlUJ3qAYl4QRH0KuTxGTjoDw2XNzoxeF3VcA1PNyBIpI3K0MB5OWMBtrbQ24JiNXjYk+/LrIKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JU3sj7wi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CIvYkZ028573;
	Mon, 12 Feb 2024 19:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xRAtTXA0GYOC3hlcnkylDGI7YmiZlOBntAK8dL6+NIQ=;
 b=JU3sj7wi5sa3W3/c6ROS4fOw0SdEdRB57/eO2Br+dxuGpdK5Ozbtr1U+pD3nilnER6OF
 ys+xLlq+l/9Xz8On6ORJXNZH5E+RubgEydbi4lrH5Q/GLOo3ZA425tyDA8uHp2paNXO2
 F7IV0cv2HiDLlvMLPJAxpQClXgWGmuh8luwA0gEWjzmrlHcZYbY0sGw+TGmIhWKK3yKw
 3VzKCztg50EGasmePeKpf+VPs9v42qEq5k6OwPRi99tDk3iuc/aorcvWjzozgxiegJ8d
 ufKmukVI4AoTmxmoOyTbLEUc1tIy3eWK7Zio37pm7nMO6qn3cowP8uhomS3zMzXaSvgZ Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7s2crg9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:13:24 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CJ09Js004446;
	Mon, 12 Feb 2024 19:13:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7s2crg9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:13:23 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CIPK9G009904;
	Mon, 12 Feb 2024 19:13:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62j08h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:13:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CJDJKI19530190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 19:13:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850F75805F;
	Mon, 12 Feb 2024 19:13:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F8758059;
	Mon, 12 Feb 2024 19:13:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 19:13:17 +0000 (GMT)
Message-ID: <5ee562ed-e461-4e63-9219-827619c55b3e@linux.ibm.com>
Date: Mon, 12 Feb 2024 14:13:17 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/25] evm: Make it independent from 'integrity' LSM
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-24-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-24-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ji7sCJbvayq_fEExhtw88aZrsgxS19-n
X-Proofpoint-ORIG-GUID: dWteap1k1f3oG6uA_Xu3h5dvHPWJsTNJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=942
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120147



On 1/15/24 13:18, Roberto Sassu wrote:
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
> wasn't in the IMA policy. Now, because IMA and EVM use disjoint metadata,
> the EVM status has to be stored for every inode regardless of the IMA
> policy.
> 
> Given that from now on EVM relies on its own metadata, remove the iint
> parameter from evm_verifyxattr(). Also, directly retrieve the iint in
> evm_verify_hmac(), called by both evm_verifyxattr() and
> evm_verify_current_integrity(), since now there is no performance penalty
> in retrieving EVM metadata (constant time).
> 
> Replicate the management of the IMA_NEW_FILE flag, by introducing
> evm_post_path_mknod() and evm_file_release() to respectively set and clear
> the newly introduced flag EVM_NEW_FILE, at the same time IMA does. Like for
> IMA, select CONFIG_SECURITY_PATH when EVM is enabled, to ensure that files
> are marked as new.
> 
> Unlike ima_post_path_mknod(), evm_post_path_mknod() cannot check if a file
> must be appraised. Thus, it marks all affected files. Also, it does not
> clear EVM_NEW_FILE depending on i_version, but that is not a problem
> because IMA_NEW_FILE is always cleared when set in ima_check_last_writer().
> 
> Move the EVM-specific flag EVM_IMMUTABLE_DIGSIG to
> security/integrity/evm/evm.h, since that definition is now unnecessary in
> the common integrity layer.
> 
> Finally, switch to the LSM reservation mechanism for the EVM xattr, and
> consequently decrement by one the number of xattrs to allocate in
> security_inode_init_security().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

