Return-Path: <linux-fsdevel+bounces-40504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97DA24125
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F94A1640DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02F1EE7D6;
	Fri, 31 Jan 2025 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s59ak5D1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983513213E;
	Fri, 31 Jan 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342517; cv=none; b=V6L1xPZnU/7bX7/z35LVpVvPflK5jBlW3DDxUELfDEhx1mOKPigp6XYXxPh+6UdhvGAuAuzYphlv5FhiSq1odG4HDipd7UWwiZ1oTwaltoyd1R2CIYizxzwNF2cuEtYF03042oQjRsVVAsyd89HtSeEhJ4thPcGFGkZKw4ov48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342517; c=relaxed/simple;
	bh=JePdSY0WVUnypZ6vG3BKI1d3ETqsiwo0doLbUymGKHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdG7orG9VTbxy5W4pYMkOyKkKPPbBCSxkYp/TV4Js83kFQWaWIDJMETbp6OJ+Lpr9S0G0UJMQCDBaML54TBOFYARvH8Pt+E1Xq2Y5nlsZtBDLqXL5yUQAyevyVOfx6Cz3FbDYuGAUsUISP3Lz4/FbG7xuPNLJdiZmdbltxaYe5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s59ak5D1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VG9aeq013095;
	Fri, 31 Jan 2025 16:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JePdSY
	0WVUnypZ6vG3BKI1d3ETqsiwo0doLbUymGKHU=; b=s59ak5D1fyI9MZSmEY5r3T
	i0v8GkwptZ9PsimCQBgfFjgODyYcD7A46uSVTgTh2z/ZkzHEP2pmyv9X42zKLYpE
	NioiDqnQKrHydk2ESXNy2OWuRbMYyix788NCmzgAOIK8I/aqDqQKeMv6asIorXZ+
	lpl32BOCsJ5UE4109IUjXT7MWPb+WF6nWp+g7Y3sEnNSGjf24gsrTuVZ7sKB2GZh
	Ps6wERwC+Oxk3tyRUG8Rtd938VPWe7t1EUxf2jrg5bXWDhEvDX7bHcvjIx2NYd3Q
	mOxQTQYeWlocPhGeBgM2L6viWCZcxZ9/tHAIHOALtfmXHR74Bc+U3reGZgF96Ebw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44grb7avrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:54:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VGsqPG017324;
	Fri, 31 Jan 2025 16:54:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44grb7avrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:54:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGZxEB017346;
	Fri, 31 Jan 2025 16:54:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gfaxcfcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:54:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VGsob728312262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:54:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC2A05803F;
	Fri, 31 Jan 2025 16:54:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6266A58054;
	Fri, 31 Jan 2025 16:54:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.176])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 16:54:49 +0000 (GMT)
Message-ID: <82b6fb1320c96b5839cda02f8df52e0a43401dbf.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/6] fs: ima: Remove S_IMA and IS_IMA()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Shu Han <ebpqwerty472123@gmail.com>
Date: Fri, 31 Jan 2025 11:54:48 -0500
In-Reply-To: <20250122172432.3074180-2-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
	 <20250122172432.3074180-2-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: _AjFAxHxB-PvCv5Ko5QQiLp7adcE-Gap
X-Proofpoint-ORIG-GUID: 5Skp69Yqf56rnMf__Qeib2BB_1fvUBK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=809 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2501310127

On Wed, 2025-01-22 at 18:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Commit 196f518128d2e ("IMA: explicit IMA i_flag to remove global lock on
> inode_delete") introduced the new S_IMA inode flag to determine whether o=
r
> not an inode was processed by IMA. In that way, it was not necessary to
> take the global lock on inode delete.
>=20
> Since commit 4de2f084fbff ("ima: Make it independent from 'integrity'
> LSM"), the pointer of the inode integrity metadata managed by IMA has bee=
n
> moved to the inode security blob, from the rb-tree. The pointer is not NU=
LL
> only if the inode has been processed by IMA, i.e. ima_inode_get() has bee=
n
> called for that inode.
>=20
> Thus, since the IS_IMA() check can be now implemented by trivially testin=
g
> whether or not the pointer of inode integrity metadata is NULL, remove th=
e
> S_IMA definition in include/linux/fs.h and also the IS_IMA() macro.
>=20
> Remove also the IS_IMA() invocation in ima_rdwr_violation_check(), since
> whether the inode was processed by IMA will be anyway detected by a
> subsequent call to ima_iint_find(). It does not have an additional overhe=
ad
> since the decision can be made in constant time, as opposed to logarithm
> when the inode integrity metadata was stored in the rb-tree.
>=20
> Suggested-by: Shu Han <ebpqwerty472123@gmail.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Acked-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewd-by: Mimi Zohar <zohar@linux.ibm.com>

