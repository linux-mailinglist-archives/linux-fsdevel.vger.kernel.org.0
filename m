Return-Path: <linux-fsdevel+bounces-40502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE19A24114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF3188446E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DD1EE7D6;
	Fri, 31 Jan 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KBpSDWRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BA1C5D63;
	Fri, 31 Jan 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738342374; cv=none; b=BdaG4+2o/fIWy53ChJAUzsKS0r3pvfKizwpi4VDLAwUNJUY475Rfr3ge9X+sdZHEdCRIvIew3JNxcRjvrUkkVcy/5auLB48I7O7Y4P2WOcGb43HC5pf/9Ufx68E4KsKkbeIjQHShpu1pUBZobzm7oZHuz2Tl9oLLoFx0W6cQPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738342374; c=relaxed/simple;
	bh=0GT4/+LlBqIUtZ7pp3RVNcFmSCoL/LN3iyCtSxaQQRA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qj+xKI+PlfrZt4XOuJcVR5HhK2fkvcLsIbXF1dNhXWa8GWhcW8HuZZD37T3SvkJ+rQLr53o63FUs2586xx6Gj5emE5jk/fHK1pjtC2tQaVb+JzW7EGZXvX+TGMxKlf/eLtKH8G3oKjmD5wE3c4YPXKAD8LgjcEoQv3oVwXmgQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KBpSDWRb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGii85010526;
	Fri, 31 Jan 2025 16:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=laejTw
	/J93FIpv8zpyFVltvFqqr8hmZZuzZLCRPS94Y=; b=KBpSDWRb34HwLPFamsc/dm
	8qVij7dR2ANkYM0mmnmBmHquHxyVR8nSia+qbwesKcH5aQGJS0uEQwftUXV0YICe
	WYYFEU+ghy1JHyzk1TMqjDP8Jb2bRoXltpel32CqdLhd5StQGtwT6qcS/Maizj/f
	EaKKMnn/QSVjdB858NMjPKvdc4RF272+7zAUm3RKIsH6SLk/udVLfh+vuijn3fEg
	SOq5v/idgt2QAweAL7yuVI/Z5AOHcDE6V8qV/QHPde+TD4TtTjGL2PGhjMUUusYL
	I6l+hSYLXmfX97CCjTYuNxrQb5PJBEHOKe/wIyNxQnBLw54PHSfe02g6w5Dd6szg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gt7nachj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:52:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50VGmbT1002833;
	Fri, 31 Jan 2025 16:52:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gt7nachf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:52:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VGSqNi024524;
	Fri, 31 Jan 2025 16:52:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gf914fyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:52:20 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VGqKqG19136812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:52:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02B1258062;
	Fri, 31 Jan 2025 16:52:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E49F58059;
	Fri, 31 Jan 2025 16:52:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.176])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 16:52:19 +0000 (GMT)
Message-ID: <574ab3058a019c0536c29f54516c48fdae82af12.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/6] ima: Defer fixing security.ima to __fput()
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
Date: Fri, 31 Jan 2025 11:52:18 -0500
In-Reply-To: <20250122172432.3074180-6-roberto.sassu@huaweicloud.com>
References: <20250122172432.3074180-1-roberto.sassu@huaweicloud.com>
	 <20250122172432.3074180-6-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: yGtW4jrvmsBMwDt-hPQYRRevwsyhlf-B
X-Proofpoint-ORIG-GUID: mn4jY_xc0QbmeTeMxX8t1_qZEjLIKbti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310127

On Wed, 2025-01-22 at 18:24 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> IMA-Appraisal implements a fix mode, selectable from the kernel command
> line by specifying ima_appraise=3Dfix.
>=20
> The fix mode is meant to be used in a TOFU (trust on first use) model,
> where systems are supposed to work under controlled conditions before the
> real enforcement starts.
>=20
> Since the systems are under controlled conditions, it is assumed that the
> files are not corrupted, and thus their current data digest can be truste=
d,
> and written to security.ima.
>=20
> When IMA-Appraisal is switched to enforcing mode, the security.ima value
> collected during the fix mode is used as a reference value, and a mismatc=
h
> with the current value cause the access request to be denied.
>=20
> However, since fixing security.ima is placed in ima_appraise_measurement(=
)
> during the integrity check, it requires the inode lock to be taken in
> process_measurement(), in addition to ima_update_xattr() invoked at file
> close.
>=20
> Postpone the security.ima update to ima_check_last_writer(), by setting t=
he
> new atomic flag IMA_UPDATE_XATTR_FIX in the inode integrity metadata, in
> ima_appraise_measurement(), if security.ima needs to be fixed. In this wa=
y,
> the inode lock can be removed from process_measurement(). Also, set the
> cause appropriately for the fix operation and for allowing access to new
> and empty signed files.
>=20
> Finally, update security.ima when IMA_UPDATE_XATTR_FIX is set, and when
> there wasn't a previous security.ima update, which occurs if the process
> closing the file descriptor is the last writer.
>=20
> Deferring fixing security.ima has a side effect: metadata of files with a=
n
> invalid EVM HMAC cannot be updated until the file is close. In alternativ=
e
> to waiting, it is also recommended to add 'evm=3Dfix' in the kernel comma=
nd
> line to handle this case (recommendation added to kernel-parameters.txt a=
s
> well).
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

[ ... ]

> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -158,13 +158,16 @@ static void ima_check_last_writer(struct ima_iint_c=
ache
> *iint,
> =C2=A0				=C2=A0 struct inode *inode, struct file *file)
> =C2=A0{
> =C2=A0	fmode_t mode =3D file->f_mode;
> -	bool update;
> +	bool update =3D false, update_fix;
> =C2=A0
> -	if (!(mode & FMODE_WRITE))
> +	update_fix =3D test_and_clear_bit(IMA_UPDATE_XATTR_FIX,
> +					&iint->atomic_flags);
> +
> +	if (!(mode & FMODE_WRITE) && !update_fix)
> =C2=A0		return;
> =C2=A0
> =C2=A0	ima_iint_lock(inode);
> -	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
> +	if ((mode & FMODE_WRITE) && atomic_read(&inode->i_writecount) =3D=3D 1)=
 {
> =C2=A0		struct kstat stat;
> =C2=A0
> =C2=A0		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
> @@ -181,6 +184,10 @@ static void ima_check_last_writer(struct ima_iint_ca=
che *iint,
> =C2=A0				ima_update_xattr(iint, file);
> =C2=A0		}
> =C2=A0	}
> +
> +	if (!update && update_fix)
> +		ima_update_xattr(iint, file);
> +
> =C2=A0	ima_iint_unlock(inode);
> =C2=A0}
> =C2=A0
> @@ -378,13 +385,10 @@ static int process_measurement(struct file *file, c=
onst
> struct cred *cred,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 template_desc);
> =C2=A0	if (rc =3D=3D 0 && (action & IMA_APPRAISE_SUBMASK)) {
> =C2=A0		rc =3D ima_check_blacklist(iint, modsig, pcr);
> -		if (rc !=3D -EPERM) {
> -			inode_lock(inode);
> +		if (rc !=3D -EPERM)
> =C2=A0			rc =3D ima_appraise_measurement(func, iint, file,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pathname, xattr_value,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xattr_len, modsig);
> -			inode_unlock(inode);
> -		}
> =C2=A0		if (!rc)
> =C2=A0			rc =3D mmap_violation_check(func, file, &pathbuf,
> =C2=A0						=C2=A0 &pathname, filename);

In ima_appraise_measurement() IMA calls EVM to verify the file metadata
(evm_verifyxattr). One would think that since IMA is not "fixing" security.=
ima, EVM
would not require the inode lock to be taken by IMA.  However, in addition =
to
verifying the file metdata, EVM converts the original file metadata signatu=
re to an
HMAC.  This does require the inode lock. Perhaps the EVM conversion from a =
signature
to an HMAC needs to be deferred as well.

Mimi


