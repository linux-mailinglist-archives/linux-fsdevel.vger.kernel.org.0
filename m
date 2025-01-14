Return-Path: <linux-fsdevel+bounces-39141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE84A10915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA67B3A7345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5B214883C;
	Tue, 14 Jan 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tjG7QCLV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F86126C0D;
	Tue, 14 Jan 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864479; cv=none; b=TMQlY+Lo7zeeSxvRdFt5kt4q6QyLtfkNlU/sZoaLgly+yyLJLbGT2iOgHhTjGVbbTfaULAW6etneevfgavAaXjvU/6P7Q0XkFQmzrKDWOlQipbV+YbpqO9arzhImZj7orUs/CpwR+wq5DbDEMPGUN9eQ+UcLcsB3lUbqeTso0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864479; c=relaxed/simple;
	bh=mOjrhcNJumrD7oGOzLiEB/Af5QF2YsulVU+Sef5zJjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3DUSVJiYcRpwLRdPbgkubs4e0bQsQlerys91t2LalkquOTGbXxcErY2dKrS18yFWZYd0O5UbbMeRQWESJ+MhRHK6W88OWRs8ZXmLUvZC5EY//sWb7zzUEkyU4QB+EdeQ1NgoGgqqu0b/3tedxrjRbFRHtTtIYZVBeqGCcnNb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tjG7QCLV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DNaHTW028858;
	Tue, 14 Jan 2025 14:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2YWz2P
	YWntESkOYs4GkD1axYx6lXfF6WpZaE+S77tZM=; b=tjG7QCLV99e2KuScyCqk5H
	4m2Ng4luUKJNbfdEaHxojLlObfpTp4cwYJ2GFUFHSslfLUmmD4wBwE5QxgG/PTOk
	nU9aWTlAg9+qvfQLoEVy1tqd8QMZG/ETq9zkTm8De/i4CF7z7EYoPv3YxlNFpCSu
	xhzMA/SEw8fAsG+xmPCHo8bdO022DsWhAFrfqSIY+ee+iUtWOO3BOkJO7KwD1vH3
	g93cDTlHpQ4WAt+6nUFDRYp1Hg0EfAkuP6+SrFUQO1SBb5RMdhT9v8R/WEgKucCm
	EAl7mH4g8UMGwSteF/Kv7sBH5Loyq0mdIC+fzaz9XFegAyjDGuO6WSmPX0lBXs8w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb2yyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:20:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EEKcrK019545;
	Tue, 14 Jan 2025 14:20:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb2yyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:20:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EDWPWY002663;
	Tue, 14 Jan 2025 14:20:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443by3mfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:20:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EEKe2119530328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 14:20:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8149558055;
	Tue, 14 Jan 2025 14:20:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92B9F58043;
	Tue, 14 Jan 2025 14:20:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.110.183])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 14:20:39 +0000 (GMT)
Message-ID: <3545a38326a5d3dff28b1089ab2149f1662a641b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/7] ima: Ensure lock is held when setting iint
 pointer in inode security blob
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 14 Jan 2025 09:20:39 -0500
In-Reply-To: <20241128100621.461743-4-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-4-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: VIjwZgTQ_o8CSnNqxEvZMhkfeSbv8D2N
X-Proofpoint-GUID: FKwaSuEbO9iefhSmboy5NN6m9CPGxmCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=598 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140112

On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
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
> Ensure that the iint check and assignment is guarded, by adding a lockdep
> assertion in ima_inode_get().

-> is guarded by the ima_iint_cache_lock mutex, ...

>=20
> Consequently, guard the remaining ima_inode_get() calls, in
> ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockdep
> warnings.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
> =C2=A0security/integrity/ima/ima_iint.c |=C2=A0 2 ++
> =C2=A0security/integrity/ima/ima_main.c | 14 ++++++++++++--
> =C2=A02 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/i=
ma_iint.c
> index dcc32483d29f..fca9db293c79 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -97,6 +97,8 @@ struct ima_iint_cache *ima_inode_get(struct inode *inod=
e)
> =C2=A0	if (!iint_lock)
> =C2=A0		return NULL;
> =C2=A0
> +	lockdep_assert_held(&iint_lock->mutex);
> +

lockdep_assert_held() doesn't actually "ensure" the lock is held, but emits=
 a warning
when the lock is not held (if debugging is enabled).  Semantically "ensure"=
 gives the
impression of enforcing.

Mimi

> =C2=A0	iint =3D iint_lock->iint;
> =C2=A0	if (iint)
> =C2=A0		return iint;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 05cfb04cd02b..1e474ff6a777 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -705,14 +705,19 @@ static void ima_post_create_tmpfile(struct mnt_idma=
p *idmap,
> =C2=A0	if (!must_appraise)
> =C2=A0		return;
> =C2=A0
> +	ima_iint_lock(inode);
> +
> =C2=A0	/* Nothing to do if we can't allocate memory */
> =C2=A0	iint =3D ima_inode_get(inode);
> -	if (!iint)
> +	if (!iint) {
> +		ima_iint_unlock(inode);
> =C2=A0		return;
> +	}
> =C2=A0
> =C2=A0	/* needed for writing the security xattrs */
> =C2=A0	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> =C2=A0	iint->ima_file_status =3D INTEGRITY_PASS;
> +	ima_iint_unlock(inode);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -737,13 +742,18 @@ static void ima_post_path_mknod(struct mnt_idmap *i=
dmap,
> struct dentry *dentry)
> =C2=A0	if (!must_appraise)
> =C2=A0		return;
> =C2=A0
> +	ima_iint_lock(inode);
> +
> =C2=A0	/* Nothing to do if we can't allocate memory */
> =C2=A0	iint =3D ima_inode_get(inode);
> -	if (!iint)
> +	if (!iint) {
> +		ima_iint_unlock(inode);
> =C2=A0		return;
> +	}
> =C2=A0
> =C2=A0	/* needed for re-opening empty files */
> =C2=A0	iint->flags |=3D IMA_NEW_FILE;
> +	ima_iint_unlock(inode);
> =C2=A0}
> =C2=A0
> =C2=A0/**


