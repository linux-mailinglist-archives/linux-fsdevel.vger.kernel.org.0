Return-Path: <linux-fsdevel+bounces-39504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F0A1554B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BED161A81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1081A00FA;
	Fri, 17 Jan 2025 17:06:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512313B59B;
	Fri, 17 Jan 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133593; cv=none; b=ARWf+3VFb5h0ei3FlUs9xyd/DRP/KFWUG/VuhEXwLmQCMI2I1p4UZVyvb0e6bCLAjxNpKzCzYUrcnWqQ3OyYFz9g8rd9ThOcS5/pvGlAqzh0UuYAvRVPDerCN3a6SptQFV+RXZog1ygK6wXkWFH59GfY8BHeooctT4gHMa6thYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133593; c=relaxed/simple;
	bh=in4JlROnQDHcP8GUZq+j4sVW3Duj8qwmyK5DwZ07WK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrsMk6yqxqtjN2hMbKttJSdh6qojLoDNtB5afhBEoinOd1UICsx/MmbF0S0tuSrdRY48iacVVC8Ww0udzWq/yIj8rrcM/Xtn6VtoKyLk+2mBxYX27RZpQpes8TByQC4raqdvNBjdtPrVwxtxwGSWjp5BJ9tTAxg8tnoCMddCWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZQYb4JKtz9v7Vg;
	Sat, 18 Jan 2025 00:44:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DDCC81402C8;
	Sat, 18 Jan 2025 01:06:21 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnbEsCjopnGx7PAA--.40276S2;
	Fri, 17 Jan 2025 18:06:21 +0100 (CET)
Message-ID: <6f310cfc1a0f505cf5e07885728d8cbf783cd644.camel@huaweicloud.com>
Subject: Re: [PATCH v2 5/7] ima: Set security.ima on file close when
 ima_appraise=fix
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 17 Jan 2025 18:06:06 +0100
In-Reply-To: <72d71cc694f27dbafb64656d8db4a89df8532aed.camel@linux.ibm.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-6-roberto.sassu@huaweicloud.com>
	 <72d71cc694f27dbafb64656d8db4a89df8532aed.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnbEsCjopnGx7PAA--.40276S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw4DGw1rAF43uw4UWrWUtwb_yoWxuryfpa
	yvqa4UKryv9F97WFWvya13CayF93yjgF4DWws8J3WvvFnxZr10gr1rJr129Fy3Xrs5Jw1x
	tr1jg3yUZa1vyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBGeKAVIGRgAAsz

On Wed, 2025-01-15 at 08:46 -0500, Mimi Zohar wrote:
> Please use "__fput()" rather than "file close".  Perhaps update the subje=
ct line to
> something like "ima: Defer fixing security.ima to __fput()".=20
>=20
> On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > IMA-Appraisal implements a fix mode, selectable from the kernel command
> > line by specifying ima_appraise=3Dfix.
> >=20
> > The fix mode is meant to be used in a TOFU (trust on first use) model,
> > where systems are supposed to work under controlled conditions before t=
he
> > real enforcement starts.
> >=20
> > Since the systems are under controlled conditions, it is assumed that t=
he
> > files are not corrupted, and thus their current data digest can be trus=
ted,
> > and written to security.ima.
> >=20
> > When IMA-Appraisal is switched to enforcing mode, the security.ima valu=
e
> > collected during the fix mode is used as a reference value, and a misma=
tch
> > with the current value cause the access request to be denied.
> >=20
> > However, since fixing security.ima is placed in ima_appraise_measuremen=
t()
> > during the integrity check, it requires the inode lock to be taken in
> > process_measurement(), in addition to ima_update_xattr() invoked at fil=
e
> > close.
> >=20
> > Postpone the security.ima update to ima_check_last_writer(), by setting=
 the
> > new atomic flag IMA_UPDATE_XATTR_FIX in the inode integrity metadata, i=
n
> > ima_appraise_measurement(), if security.ima needs to be fixed. In this =
way,
> > the inode lock can be removed from process_measurement(). Also, set the
> > cause appropriately for the fix operation and for allowing access to ne=
w
> > and empty signed files.
> >=20
> > Finally, update security.ima when IMA_UPDATE_XATTR_FIX is set, and when
> > there wasn't a previous security.ima update, which occurs if the proces=
s
> > closing the file descriptor is the last writer. =20
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Roberto, I really like the idea of removing the inode_lock in process_mea=
surement()
> needed for writing xattrs, but I'm concerned about the delay being introd=
uced.  For
> example, does it interfere with labeling the filesystem with file signatu=
res
> (with/without EVM enabled)?

There will be a difference when EVM is enabled, and inode metadata are
corrupted.

In that case, currently IMA in fix mode is able to fix inode metadata
as well, by writing security.ima. That happens because IMA ignores the
result of evm_verifyxattr() and writes the xattr directly, causing EVM
to update the HMAC to a valid one.

With the new patch, the EVM HMAC remains invalid until file close,
meaning that it will not be possible for example to set xattr on the
opened file descriptor. It works after closing the file though.

Setting other LSMs xattrs will fail as well, if the EVM HMAC is
invalid.

If the problem is EVM, I would recommend setting evm=3Dfix as well, so
that inode metadata can be properly fixed.

I will update the documentation to describe the limitation introduced
by this patch, and to suggest to use evm=3Dfix.

Thanks

Roberto

> > ---
> > =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0security/integrity/ima/ima_appraise.c |=C2=A0 7 +++++--
> > =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++=
+++++++++-------
> > =C2=A03 files changed, 17 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index b4eeab48f08a..22c3b87cfcac 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -179,6 +179,7 @@ struct ima_kexec_hdr {
> > =C2=A0#define IMA_CHANGE_ATTR		2
> > =C2=A0#define IMA_DIGSIG		3
> > =C2=A0#define IMA_MUST_MEASURE	4
> > +#define IMA_UPDATE_XATTR_FIX	5
> > =C2=A0
> > =C2=A0/* IMA integrity metadata associated with an inode */
> > =C2=A0struct ima_iint_cache {
> > diff --git a/security/integrity/ima/ima_appraise.c
> > b/security/integrity/ima/ima_appraise.c
> > index 656c709b974f..94401de8b805 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -576,8 +576,10 @@ int ima_appraise_measurement(enum ima_hooks func, =
struct
> > ima_iint_cache *iint,
> > =C2=A0		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
> > =C2=A0		=C2=A0=C2=A0=C2=A0 (!xattr_value ||
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 xattr_value->type !=3D EVM_IMA_XATTR_D=
IGSIG)) {
> > -			if (!ima_fix_xattr(dentry, iint))
> > -				status =3D INTEGRITY_PASS;
> > +			/* Fix by setting security.ima on file close. */
> > +			set_bit(IMA_UPDATE_XATTR_FIX, &iint->atomic_flags);
> > +			status =3D INTEGRITY_PASS;
> > +			cause =3D "fix";
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		/*
> > @@ -587,6 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct
> > ima_iint_cache *iint,
> > =C2=A0		if (inode->i_size =3D=3D 0 && iint->flags & IMA_NEW_FILE &&
> > =C2=A0		=C2=A0=C2=A0=C2=A0 test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
> > =C2=A0			status =3D INTEGRITY_PASS;
> > +			cause =3D "new-signed-file";
> > =C2=A0		}
> > =C2=A0
> > =C2=A0		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 1e474ff6a777..50b37420ea2c 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -158,13 +158,16 @@ static void ima_check_last_writer(struct ima_iint=
_cache
> > *iint,
> > =C2=A0				=C2=A0 struct inode *inode, struct file *file)
> > =C2=A0{
> > =C2=A0	fmode_t mode =3D file->f_mode;
> > -	bool update;
> > +	bool update =3D false, update_fix;
> > =C2=A0
> > -	if (!(mode & FMODE_WRITE))
> > +	update_fix =3D test_and_clear_bit(IMA_UPDATE_XATTR_FIX,
> > +					&iint->atomic_flags);
> > +
> > +	if (!(mode & FMODE_WRITE) && !update_fix)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	ima_iint_lock(inode);
> > -	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
> > +	if (atomic_read(&inode->i_writecount) =3D=3D 1 && (mode & FMODE_WRITE=
)) {
>=20
> Probably better to reverse the "mode & FMODE_WRITE" and atomic_read() tes=
t order.
>=20
> Mimi
>=20
> > =C2=A0		struct kstat stat;
> > =C2=A0
> > =C2=A0		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
> > @@ -181,6 +184,10 @@ static void ima_check_last_writer(struct ima_iint_=
cache *iint,
> > =C2=A0				ima_update_xattr(iint, file);
> > =C2=A0		}
> > =C2=A0	}
> > +
> > +	if (!update && update_fix)
> > +		ima_update_xattr(iint, file);
> > +
> > =C2=A0	ima_iint_unlock(inode);
> > =C2=A0}
> > =C2=A0
> > @@ -378,13 +385,10 @@ static int process_measurement(struct file *file,=
 const
> > struct cred *cred,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 template_desc);
> > =C2=A0	if (rc =3D=3D 0 && (action & IMA_APPRAISE_SUBMASK)) {
> > =C2=A0		rc =3D ima_check_blacklist(iint, modsig, pcr);
> > -		if (rc !=3D -EPERM) {
> > -			inode_lock(inode);
> > +		if (rc !=3D -EPERM)
> > =C2=A0			rc =3D ima_appraise_measurement(func, iint, file,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pathname, xattr_value,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xattr_len, modsig);
> > -			inode_unlock(inode);
> > -		}
> > =C2=A0		if (!rc)
> > =C2=A0			rc =3D mmap_violation_check(func, file, &pathbuf,
> > =C2=A0						=C2=A0 &pathname, filename);


