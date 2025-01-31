Return-Path: <linux-fsdevel+bounces-40501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F405A2410F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED40163A41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C91EE7AA;
	Fri, 31 Jan 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fEa2aLJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6181C5D63;
	Fri, 31 Jan 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342350; cv=none; b=avjiY5CylJ5KRjZENX4i/aBHT+9m3XpaGkwXXF4TgK55qBWPgVj2wINHEE8o+RzZKOE/aaBc2A+/FQKmxFpukGDLEuF2VW5xBy/txFw2rPrJNYorg/mMhiEUnsodc1kO6Vinvql188baK0o6Yk90bJc9taGKKidTzOsAPcIEYyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342350; c=relaxed/simple;
	bh=6Xp4ueQdFl8WmbQ0ueOgHxXi/KSsNywtWaKc8axdKss=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQwC6o0VXW8XZRP3hqtOk9LMhzjf1i5vrMf4SBHg4vcHJbVEBHIMQsuR2ll07oY8QJTWIV6WEEJnrj4Siz5BNFbtUPJCWwsmBMpu8+kXoF60NY7C6ILeSlxeKclMGOnSdL5DmtuAGeFdLCpQws7oNggOBWGfAQ7pyBt2sqlge+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fEa2aLJa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VF1PMV012998;
	Fri, 31 Jan 2025 16:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7uKq2R
	Xg8AsGUgQND13tWgTLMrt+YZuxi3vOWeNbpvQ=; b=fEa2aLJaEbdhGEUE1GN48E
	GjyFRIlqCrSoYJcxtjBjaly589uSPrygnYIdeMVCeRTpu7VonhoMSubAvg6k0Ao3
	9exIrKBbXIL2p/5XhXIFYf9VbHqoMWCZqR02vDUiSNVHZ9T53eMLADUuuuj6oR1k
	7qd6pm6Oorpjd9faT06cUJqLyhxyI8YNfU1e7sCBBW7/CxAk8x1SGXPwjnC4XGR8
	1FJLlQwmbHcFcTvJqSlqjRdoNqJhuxHoHVhDy8H/ps+fqhn2AMbdbIqh5pq877TK
	+rsboAgrN3+RcFzCOmkrC8ieg1ZZTaxDdB7hwqY/bdSktYKxyOD3onsQd17kb5Bg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44h0t00hss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:52:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VGnMRM019574;
	Fri, 31 Jan 2025 16:52:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44h0t00hsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:51:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGhLwA010192;
	Fri, 31 Jan 2025 16:51:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gfa0mfcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:51:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VGpvsj31392436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:51:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4274A5805D;
	Fri, 31 Jan 2025 16:51:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C093F5805C;
	Fri, 31 Jan 2025 16:51:56 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.176])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 16:51:56 +0000 (GMT)
Message-ID: <910cb84836f8366a566bae7dbe92f0e649d1715c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/6] ima: Detect if lock is held when iint pointer is
 set in inode security blob
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
Date: Fri, 31 Jan 2025 11:51:56 -0500
In-Reply-To: <20250122172432.3074180-4-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
	 <20250122172432.3074180-4-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: t-iBCn-6cVlDFpiJP4zIMTMVPEpbVSAB
X-Proofpoint-ORIG-GUID: 9DFpJgQh-UceYTkhgy6J5n4OhGVWXLc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=822
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310123

On Wed, 2025-01-22 at 18:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> IMA stores a pointer of the ima_iint_cache structure, containing integrit=
y
> metadata, in the inode security blob. However, check and assignment of th=
is
> pointer is not atomic, and it might happen that two tasks both see that t=
he
> iint pointer is NULL and try to set it, causing a memory leak.
>=20
> Detect if the iint check and assignment is guarded by the iint_lock mutex=
,
> by adding a lockdep assertion in ima_inode_get().
>=20
> Consequently, guard the remaining ima_inode_get() calls, in
> ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockdep
> warnings.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thank you for updating the patch description.  You might also want to menti=
on that
CONFIG_LOCKDEP_DEBUG is required to see the warnings.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


