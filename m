Return-Path: <linux-fsdevel+bounces-39298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C960A12555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CB716913A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5924334A;
	Wed, 15 Jan 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VkOUQ12I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85B29A5;
	Wed, 15 Jan 2025 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948800; cv=none; b=vGmNAimSZTkTC9SPg6XcgFnQxpYkoJHuTNCGZFHI3S5osFXnN1GilA00hFa1udoiRycaz83ZCEo4L1EbChrA2oKYK8GzUFp+56+f1UTCojSquK69HM5HrjqoH5IQKfj+Y0mdpL6vja78WxXcgQEeFNgPKfFpTRGyvPy/L6CS2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948800; c=relaxed/simple;
	bh=BJBiP01vAX3/hcSFK9Qtvwkh971Yj1osxx2tvLHtq2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ky1XsDjRVtRwj+8KVTUibnmWiUAfbyMnhlm0axbDj6/RPEPWA+0g+fGQtjZ2eeu7fwQb3V52MO2TNM2CD9IT7SZzUIfUp/arXzyJblaXibQTH9W5pOHYZwgTnH0TQLwt4wU0qD5ygUAS8fzw55cZIyf3S6p5qtMQN4GvLh8+x0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VkOUQ12I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F3rIvn019911;
	Wed, 15 Jan 2025 13:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zzEO5g
	okc39peyexb+JjoQ95EgGI6De7Tp73/tvf5Iw=; b=VkOUQ12IR3OmrTGFcMkDzY
	zFBmGOHCtbjLWORieL438CLKqz1nkZOS+w3STDgMStCP2tPRqfp/dHGwv+2r5oqv
	s0+TAtl1Ccg8t/+Rr4ce/DbadGYdjiiVnJOPEo2ZKZtE+l3PeZxXcQeMiYXr/QWb
	VFLHKLvlqRmGm37Ybn/k77gRJfd23FUy5He7d+Bp5HJEnLD6Txd6eZJOPc6EKqM7
	rtZX+UNV+kr34rOeEVMx1wqWaKtROaPdkr2/x+06Yb/l+wm1AX5saF7IoITtoQBs
	+NfS1S621keOHPdBNNNpzTNOLw+uqAtWsHNj+oOgzF13xOyggH5sF6/lDtg5V8Hg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjtdc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:46:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FDjgq9015833;
	Wed, 15 Jan 2025 13:46:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gjtdc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:46:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FBoLa7001108;
	Wed, 15 Jan 2025 13:46:06 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k0a30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 13:46:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FDk5qj29491880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 13:46:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A4325805B;
	Wed, 15 Jan 2025 13:46:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22A9E58055;
	Wed, 15 Jan 2025 13:46:04 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.175.76])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jan 2025 13:46:03 +0000 (GMT)
Message-ID: <72d71cc694f27dbafb64656d8db4a89df8532aed.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/7] ima: Set security.ima on file close when
 ima_appraise=fix
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 15 Jan 2025 08:46:03 -0500
In-Reply-To: <20241128100621.461743-6-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-6-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: hvxL16T867bUyhhyR3ZRT50OVa7egvOt
X-Proofpoint-GUID: gbfl1k6tWGMrM5Yv7bcPMYW43YAd13gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150102

Please use "__fput()" rather than "file close".  Perhaps update the subject=
 line to
something like "ima: Defer fixing security.ima to __fput()".=20

On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
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
> closing the file descriptor is the last writer. =20
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto, I really like the idea of removing the inode_lock in process_measu=
rement()
needed for writing xattrs, but I'm concerned about the delay being introduc=
ed.  For
example, does it interfere with labeling the filesystem with file signature=
s
(with/without EVM enabled)?

> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0security/integrity/ima/ima_appraise.c |=C2=A0 7 +++++--
> =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++=
+++++++-------
> =C2=A03 files changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index b4eeab48f08a..22c3b87cfcac 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -179,6 +179,7 @@ struct ima_kexec_hdr {
> =C2=A0#define IMA_CHANGE_ATTR		2
> =C2=A0#define IMA_DIGSIG		3
> =C2=A0#define IMA_MUST_MEASURE	4
> +#define IMA_UPDATE_XATTR_FIX	5
> =C2=A0
> =C2=A0/* IMA integrity metadata associated with an inode */
> =C2=A0struct ima_iint_cache {
> diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c
> index 656c709b974f..94401de8b805 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -576,8 +576,10 @@ int ima_appraise_measurement(enum ima_hooks func, st=
ruct
> ima_iint_cache *iint,
> =C2=A0		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (!xattr_value ||
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 xattr_value->type !=3D EVM_IMA_XATTR_DIG=
SIG)) {
> -			if (!ima_fix_xattr(dentry, iint))
> -				status =3D INTEGRITY_PASS;
> +			/* Fix by setting security.ima on file close. */
> +			set_bit(IMA_UPDATE_XATTR_FIX, &iint->atomic_flags);
> +			status =3D INTEGRITY_PASS;
> +			cause =3D "fix";
> =C2=A0		}
> =C2=A0
> =C2=A0		/*
> @@ -587,6 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, str=
uct
> ima_iint_cache *iint,
> =C2=A0		if (inode->i_size =3D=3D 0 && iint->flags & IMA_NEW_FILE &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
> =C2=A0			status =3D INTEGRITY_PASS;
> +			cause =3D "new-signed-file";
> =C2=A0		}
> =C2=A0
> =C2=A0		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 1e474ff6a777..50b37420ea2c 100644
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
> +	if (atomic_read(&inode->i_writecount) =3D=3D 1 && (mode & FMODE_WRITE))=
 {

Probably better to reverse the "mode & FMODE_WRITE" and atomic_read() test =
order.

Mimi

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


