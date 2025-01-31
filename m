Return-Path: <linux-fsdevel+bounces-40506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF574A24175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BABB188653F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184CF1F03C4;
	Fri, 31 Jan 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MNdtuBNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC031C5D73;
	Fri, 31 Jan 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342815; cv=none; b=n9taPda7s82FQh8rgXTTjijoxNT0uaZX+ZGC2pfWqbF8r8VyJdpergjRYU9QXCALepGrfebrhzycac1ikIerJX6tCN9Ntm4fL1Ar+gi9rTttvT43Tt68pusgg4UzqaZsYiIQtpwhihRuF5pBvuNKMXA14iGQussWJpFKVYnSIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342815; c=relaxed/simple;
	bh=OAf7ZA8VEl6RMYbsBFoYEqh2oE08y3k9VPFD9/eT+D8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0H/9aBQi/6IDiKoDfqqKrfc8Qi4V9xwBu7YmmySE2ItV1emwXx19tMjviAOIIk6UuOF7FaCq1slCxWPZJoFke6EDiTnXKmtY/UBtuFnbqfUSRyw1aNJKk5dyDXPf7nmsTx2VWYsP6BY2d9Jyrqe8XASJmuxl/dQVjW/YdG6+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MNdtuBNX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VEJgRp014600;
	Fri, 31 Jan 2025 16:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OAf7ZA
	8VEl6RMYbsBFoYEqh2oE08y3k9VPFD9/eT+D8=; b=MNdtuBNXRYk/9qDSAxRP2h
	ZFX8tOFMI2lXBDJmUEuR009r0QVUuE5/n1lBhgRmdjtkZYS4TlXueq5V0OgPYXfF
	TPf+HOj+vj98+A8xCzBYkzNXYG8z/fWXDZGwQwjW8PS5XrJ1E0HvP1z9aIdb6sVw
	g0PqM86zdONS1hJrRDdGDZKHcxfUGx2a2E6WRFrSzNpCsDhzfJGX+hI+pmYiDnnu
	s0UAnGonIVhDGwd0Jmm+FBa4h/HekTx8qh+mEwAsFZ91b3VRO3uc7YjnkMQyt2Cv
	O2kRcA91/bJ1gDvsI0VGz8sORoQcXfmMS2JcJfgfFA+X+4FfjMpSijuRUX5IEptA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44grb7awf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:59:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VGc7ah008820;
	Fri, 31 Jan 2025 16:59:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44grb7awea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:59:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGNFor013878;
	Fri, 31 Jan 2025 16:59:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gf93cgjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:59:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VGxVT730343712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:59:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C5E458056;
	Fri, 31 Jan 2025 16:59:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E05258061;
	Fri, 31 Jan 2025 16:59:30 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.176])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 16:59:30 +0000 (GMT)
Message-ID: <3432701f63ea1a2904a1e84aa5db4b1bc0d4331c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/6] ima: Mark concurrent accesses to the iint
 pointer in the inode security blob
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
Date: Fri, 31 Jan 2025 11:59:29 -0500
In-Reply-To: <20250122172432.3074180-5-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
	 <20250122172432.3074180-5-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: f52rQtxzKAMg65zWGxmx6Ys3D4TjoL__
X-Proofpoint-ORIG-GUID: Dn1hRKMXgfrQ6FICyra519HicpOqwKhK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=748 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2501310129

On Wed, 2025-01-22 at 18:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Use the READ_ONCE() and WRITE_ONCE() macros to mark concurrent read and
> write accesses to the portion of the inode security blob containing the
> iint pointer.
>=20
> Writers are serialized by the iint lock.
>=20
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

