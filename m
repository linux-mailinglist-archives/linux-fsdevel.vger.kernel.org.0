Return-Path: <linux-fsdevel+bounces-39143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E270A10974
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40A83A1A4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDC1494DF;
	Tue, 14 Jan 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zp7DSMlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C041C94;
	Tue, 14 Jan 2025 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865173; cv=none; b=OupUCPWZfKRUmFKr/ps1BwPHCCtwn3kciTadWssyV/+NOybteJYsTj1Jc2iX9zsy8BVf6YUXh8atYzcRpGIs2nFO15FBfc84ApzBiO0lIs37Hq41O4QE9vowZ7Z0Ut3yZdWXPExH+NOuAwY7CWrDEumqqeYKd32FdCHbUDbsWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865173; c=relaxed/simple;
	bh=CXT+2n998GraIpo3xFCkNZ/cMesx2buqdH/8pQlpHxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEt1QotYnr8+iscNmKJ2HK77jOhgRQD0zQxV6CQuPNP/uAJFxChsG9oH3UUw9H5so6kk+PPxJDC695AaPUzQDG4cIIjZoPsCYgrHctKLSQlOZaza5l7rGw3xVJ8CQNA9kLvC09DsMMySNP24jdt04D7h42CAj9k/5uS7e4+vz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zp7DSMlJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EE6KqQ013489;
	Tue, 14 Jan 2025 14:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jtLAFz
	jeOwhpY5+se6uHC7jF6IT5yZMY4ox8zRlKOEA=; b=Zp7DSMlJ2IeVzVTFykABEy
	XCgyRjSBIPfF4ErzK0VGFlGMRpEoGPuirp7HltGmg1We3idLp7aADy3/4dSr8M+X
	EGuM8VB0o2bdkCiNiRYzm0T6W2HrnsiGQToxHQ3+Hy2rqyRAk/O7N0vts4vTeUMp
	hw6MYMJDXeTX+HOI3JcpZ9y4wvdXBvQ2TvHhi6F06RhDIISFoH39XEwbd152Z6yl
	7tOY/VBW8YgHMP0yuFCLMhK9LJ3FUjTUvDVjzAjFnyzaXYT5Pt+p9NFP+iBkNsbS
	pfiP/szvZlwJxW0Gt/AhZTBsuI4/K+qvMtb5MjCtYv9nPZonnSWN9i3aUeqx1YHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445sd6040a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:32:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EEPhIl021648;
	Tue, 14 Jan 2025 14:32:29 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445sd60405-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:32:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EAk4tl001108;
	Tue, 14 Jan 2025 14:32:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456juags-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:32:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EEWS0J27722340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 14:32:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09FEF5803F;
	Tue, 14 Jan 2025 14:32:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 463EA58056;
	Tue, 14 Jan 2025 14:32:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.110.183])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 14:32:26 +0000 (GMT)
Message-ID: <6de587ad97ca3f053cd6dae3df9a4af945d8c17d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] ima: Mark concurrent accesses to the iint
 pointer in the inode security blob
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 14 Jan 2025 09:32:25 -0500
In-Reply-To: <20241128100621.461743-5-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-5-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: cxSxMEpZvOG_kngIrSHYkYKyiQYhaX7a
X-Proofpoint-ORIG-GUID: mZJLh6tVltSQkoXID79lxcxrH3I7_XCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140115

On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Use the READ_ONCE() and WRITE_ONCE() macros to mark concurrent read and
> write accesses to the portion of the inode security blob containing the
> iint pointer.
>=20
> Writers are serialized by the iint lock.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks, Roberto.

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0security/integrity/ima/ima_iint.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/i=
ma_iint.c
> index fca9db293c79..c763f431fbc1 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -32,7 +32,7 @@ struct ima_iint_cache *ima_iint_find(struct inode *inod=
e)
> =C2=A0	if (!iint_lock)
> =C2=A0		return NULL;
> =C2=A0
> -	return iint_lock->iint;
> +	return READ_ONCE(iint_lock->iint);
> =C2=A0}
> =C2=A0
> =C2=A0#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
> @@ -99,7 +99,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *inod=
e)
> =C2=A0
> =C2=A0	lockdep_assert_held(&iint_lock->mutex);
> =C2=A0
> -	iint =3D iint_lock->iint;
> +	iint =3D READ_ONCE(iint_lock->iint);
> =C2=A0	if (iint)
> =C2=A0		return iint;
> =C2=A0
> @@ -109,7 +109,7 @@ struct ima_iint_cache *ima_inode_get(struct inode *in=
ode)
> =C2=A0
> =C2=A0	ima_iint_init_always(iint, inode);
> =C2=A0
> -	iint_lock->iint =3D iint;
> +	WRITE_ONCE(iint_lock->iint, iint);
> =C2=A0
> =C2=A0	return iint;
> =C2=A0}


