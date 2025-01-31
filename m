Return-Path: <linux-fsdevel+bounces-40505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAF0A24131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB52D1884544
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87ED1EEA44;
	Fri, 31 Jan 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="newWPRrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295C1E32D4;
	Fri, 31 Jan 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342605; cv=none; b=F9bucpTKO9TEjinVcOaoalX4S64crH1VcQJa5aLiH6SoGc/VGkST5NDAYneBsNa0PEDQpf53nlHPYtcsa8POOe993Ie+kszd3EhSv0Wvfudu669KL8BvEQDOJazXzEI8NEh5+9FwkOVbIUD9+VoMwEa+t+/TxSos1rZnoa69yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342605; c=relaxed/simple;
	bh=5380sfTgLTFBqH3ZCR/iQbhEmAaM0fHWS9wvdftGOb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1hS+FmJmctMLovmzIxQBx4QjsuCe+tPe7QgU1AxKu/D9qYZG6yxShgwp7uwZ7mZqMLX1GatlSRqkmV8IGjH7Uvp307d2eRT4apQoNUNsiUxH9+AM0kjypezLYZB3xLl8D1MGdH5fmw6+OnxUpxo0LGdftg5U8UyOlXf/w4Yi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=newWPRrm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VCmu7h021709;
	Fri, 31 Jan 2025 16:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5380sf
	TgLTFBqH3ZCR/iQbhEmAaM0fHWS9wvdftGOb4=; b=newWPRrmieUVTk95UuLOqU
	K1s4Oe6k8mEdGFNGRLkrgGGHJYYvbDuaDz5yEQOwFiMZ93RBBOqDblxVmZnKGCYA
	opWNR4ycbEMbCF8IB4tIeocTn8hmCGCl8T274ZsYiRUuElykke2doe5J+gj01fVE
	2fgETfZzqTAY3yjarhJTah30k/zqjD4BD4i9lUYilPQ/9wZfCy3yukw/AkdVus4x
	5UV+WDthBVivvUMZTzVjEBOCTeZ22S0NaqVPcSBWuCuWlsjiwHATIAJ/IL+icmGg
	5acK0xEtbOVa0RF8me+haAuzw3VnZnajgTpzo5bh9Lf52w4ZtYPf4GKBGeuLSNIQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gnbybejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:56:24 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VGp3Yi024723;
	Fri, 31 Jan 2025 16:56:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gnbybeje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:56:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGSqOU024524;
	Fri, 31 Jan 2025 16:56:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gf914gdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:56:23 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VGuMO931588954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:56:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 226F558059;
	Fri, 31 Jan 2025 16:56:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A919258058;
	Fri, 31 Jan 2025 16:56:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.176])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 16:56:20 +0000 (GMT)
Message-ID: <7a9c97fa759a07fc9b23a3f05a8702744b1e6e8e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/6] ima: Remove inode lock
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Fri, 31 Jan 2025 11:56:20 -0500
In-Reply-To: <20250122172432.3074180-3-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
	 <20250122172432.3074180-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zzq683GU-P0sDttlokTlYjtY0nE1j7bx
X-Proofpoint-GUID: kUIBVIG_6kVsMEvlDHcIlnJ2l88z0SMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=816 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310127

On Wed, 2025-01-22 at 18:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Move out the mutex in the ima_iint_cache structure to a new structure
> called ima_iint_cache_lock, so that a lock can be taken regardless of
> whether or not inode integrity metadata are stored in the inode.
>=20
> Introduce ima_inode_security() to retrieve the ima_iint_cache_lock
> structure, if inode i_security is not NULL, and consequently remove
> ima_inode_get_iint() and ima_inode_set_iint(), since the ima_iint_cache
> structure can be read and modified from the new structure.
>=20
> Move the mutex initialization and annotation in the new function
> ima_inode_alloc_security() and introduce ima_iint_lock() and
> ima_iint_unlock() to respectively lock and unlock the mutex.
>=20
> Finally, expand the critical region in process_measurement() guarded by
> iint->mutex up to where the inode was locked, use only one iint lock in
> __ima_inode_hash(), since the mutex is now in the inode security blob, an=
d
> replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

