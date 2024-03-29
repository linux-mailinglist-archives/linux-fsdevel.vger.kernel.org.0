Return-Path: <linux-fsdevel+bounces-15690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79A892111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A380AB2E66B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D51327EF;
	Fri, 29 Mar 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qjcJgRX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFD48787;
	Fri, 29 Mar 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724755; cv=none; b=mFniPnx/5rWavZxtcm+fqhUkJj/wZDQ5TIiV3Q4Llvqeams+Mcljjeobk+P4fF6zMUjk3qgpxuDzT2WhkaEn/0C2+HOGctnNLFV7wDjhcTUCw5fp50MyWofTZqxQR4piIvtdXmmbVO5USbK8LcAeDNnkmS1yN4672/QHvKcEnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724755; c=relaxed/simple;
	bh=hWTBr1HsRFSiIR+jVAkUIvH4iFAvcopyR5HkgRFO4VA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pX5V65g73Z7UsBMHOBGT5REbokHHeoqIiyGt7wczyrZ6HAN5CediOgEcq01GLCIsV1AR0AIeZ7UwHq1KmghsEs8fFQyoCmO91lXUeS1bwb/SbwAY+l/jW3yRRBbZnKY6ileRkzNkUel7rQIleYq5eJhpfzdo7uy9LetnXS9EogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qjcJgRX+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42TF2v2P004967;
	Fri, 29 Mar 2024 15:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=j3kxR/csuodeDHffXwgWbeoQ0UBFIz87t1zEbv/ko6M=;
 b=qjcJgRX+neaKnzPRRWb7qoH2qZ6KoaXKFtoUW1L6Iht796BfDFNG0hfFi9sP/s2aKBBS
 Fbzf1ageLnyOkHC/C2ophHxj1iU1EFxDY+kWkRHqjRwlJb3DS9fN2m2vWYzUI7vpW5sC
 +ii3lBsg+ggzoUslOYfUQqT2Py4yDCBXaNHMhksqLNxAzRHQFbNMT8akwMnPkU3A/9Xi
 Cl+PHpCrRDhUb8T/HTb+LCiZ1shnQiQGtb+Lt13UsJkV/pm2JryJKKJ+7us32hQjnXg/
 WWnTQwP4oWlM+3lFc4bPPChaUWRAzD/GImVuBqeaj9JcYO+BIK+fm3c2y0BpKXBsan9q uA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5yxf809h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:05:19 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42TF5Ju5008421;
	Fri, 29 Mar 2024 15:05:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5yxf809g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:05:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42TEbeMX016411;
	Fri, 29 Mar 2024 15:05:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dun0ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:05:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42TF5FPs25166550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 15:05:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8468E5805F;
	Fri, 29 Mar 2024 15:05:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A9758060;
	Fri, 29 Mar 2024 15:05:13 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.126.92])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Mar 2024 15:05:13 +0000 (GMT)
Message-ID: <7b8162281b355b16e8dbdb93297a9a1cfb5bb6da.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] security: Handle dentries without inode in
 security_path_post_mknod()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com,
        christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org, Steve French <smfrench@gmail.com>
Date: Fri, 29 Mar 2024 11:05:13 -0400
In-Reply-To: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gEKmMXZ0y70WPjaV8vljt_hLgh1srMtD
X-Proofpoint-ORIG-GUID: XvQ5czlv999DsIyO-nwzKjYYOrUUmD7Q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=831 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290133

On Fri, 2024-03-29 at 11:56 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 08abce60d63fi ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call to
> ima_post_path_mknod().
> 
> For symmetry with security_path_mknod(), security_path_post_mknod() is
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.
> 
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
> 
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.
> 
> Add an extra check to first verify if there is an inode attached to the
> dentry, before checking if the inode is private. Also add the same check to
> the current users of the path_post_mknod hook, ima_post_path_mknod() and
> evm_post_path_mknod().
> 
> Finally, use the proper helper, d_backing_inode(), to retrieve the inode
> from the dentry in ima_post_path_mknod().
> 
> Cc: stable@vger.kernel.org # 6.8.x

Huh?  It doesn't need to be backported.

> Reported-by: Steve French <smfrench@gmail.com>
> Closes: 
> https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Fixes: 08abce60d63fi ("security: Introduce path_post_mknod hook")

-> 08abce60d63f

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


