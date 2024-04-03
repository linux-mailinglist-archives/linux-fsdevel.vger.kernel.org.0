Return-Path: <linux-fsdevel+bounces-16026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E1D896FED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6E28C226
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9661482E2;
	Wed,  3 Apr 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Upl7xRlv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD6200D4;
	Wed,  3 Apr 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149916; cv=none; b=beMQbl1PE/prIpYLya6B7k1r09SbGf5BRXRrN373xXl4sBHeMSHFsNIxAunx0GTu5DZQaAuZ50P8IgKxVVBZyYg/3BWviY1CzCu1QJpp6I614SzEHqjcT+1+pczGd16bsbSssckTqLcjxJqW2pBgcs5Jdg93932KHQcIKIXp9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149916; c=relaxed/simple;
	bh=988I3Q8yT1g6WpTi1Ga40N32urlSH2QimLrM2LzfSQs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ht/SOUW5vc9UYTape6IUgbjMMoPbW35ftH9heAPrL+EGJxhx+CzmFyRZQXGe2zEq1wYhaTX0mOPOD06f8q1v1QtUeLRKOJVY2YoHabJryRkhRsMoBu2JD1izGzNxgIaqRu2Pvjw2tyOTUiyyGJr3umGgJRkc2TuDipJ844SCSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Upl7xRlv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433CqamI013959;
	Wed, 3 Apr 2024 13:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cX9BfS1KFfnbnppbxJxElitNCKueMFxijxJrZ6z2zUY=;
 b=Upl7xRlvRndQgXEOukfJD8YvwK8uodvSpontiwuTshTMpllHoYVQIpRAgIV2cHEpF8eL
 wMeO+3N4zGuRYam8thFiH4TYke6zB4CmxU6wxHfdBRUQz+J1b28xIOOtFdtpjLG3aRe2
 hiX1h1hLm4RGqCmnj1jxX8pAFyeVKHllAg5U7iFSCUXkPSB8qULByym6B5I1QICnI3xd
 V3ITFR5yCjMpVUdV77VktwzlX+e2IWuS6MlxIqMhH5rHWe3b/uc8XDCY4ox3D1RNH2qB
 vL/okmm37QDg67D8QXV82a1SyLLbT9qDpuTf0m+xhusxeAujZWsEpgg3++dTsaWWIu4P nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x97gd01fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:11:18 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 433DBH13013325;
	Wed, 3 Apr 2024 13:11:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x97gd01f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:11:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4339sdpA015214;
	Wed, 3 Apr 2024 13:11:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6y9m5299-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:11:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433DB7Sd393788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:11:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3EA5805B;
	Wed,  3 Apr 2024 13:11:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A23D58067;
	Wed,  3 Apr 2024 13:11:06 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.65.3])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:11:05 +0000 (GMT)
Message-ID: <6d3b9d8a5f5a2ca010a5a701d7826e47912fec89.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org, pc@manguebit.com,
        torvalds@linux-foundation.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Steve French <smfrench@gmail.com>
Date: Wed, 03 Apr 2024 09:11:05 -0400
In-Reply-To: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WKsOfMXpW4Ur0rTPFXN01RjMFZxDEYOv
X-Proofpoint-GUID: grSbjh9SmaV9twxkgVclig21urG8CFOV
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
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2404030091

Hi Roberto,

Subject: -> security: Limit security_path_post_mknod() to regular files

This patch description was written for the previous patch version with minor
changes.  The discussion was more about making LSM hooks more generic than
currently needed.  The patch description should somehow reflect that discussion.

On Wed, 2024-04-03 at 11:07 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 08abce60d63f ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call to
> ima_post_path_mknod().
> 
> For symmetry with security_path_mknod(), security_path_post_mknod() was
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.

-> rather than only for regular files.
> 
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
> 
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.

This is an example of why making the LSM hook more generic than needed didn't
work.  Based on the discussion there is no valid reason for making the hook more
generic.

> 
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.

-> Move the security_path_post_mknod() back to the original placement of the
ima_post_path_mknod(), so that it is only called for regular files.

> 
> Reported-by: Steve French <smfrench@gmail.com>
> Closes: 
> https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


