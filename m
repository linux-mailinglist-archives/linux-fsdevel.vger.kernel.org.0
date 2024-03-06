Return-Path: <linux-fsdevel+bounces-13695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B48730A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A8BB27542
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF435D754;
	Wed,  6 Mar 2024 08:26:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8585C057;
	Wed,  6 Mar 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713576; cv=none; b=XpVtk8IEmKm6HHMnlh9y8O1SyM5MgQlBVJWF/gI1Yd9fgQqYvJSEHVwOG9GBWCp7fPtH+LrdnoTaraSyf+wxlby0FAPBnHsilTthwh2BvxLohx/wuFEthlrWGlAB5v0Xs7CF4OZffjafSaZ6b+47bZPX2So+WgznxQjbPv5PEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713576; c=relaxed/simple;
	bh=IVbVUMXrP0pWnl6Gqzn7NDcqyyzsIK+2/AJi/qKsKYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3tk3uGjUu7Q8MwKc2un65xVgN9VPDb3VJGXsk42NLIXlnvwptnvt7wAvfX7xFG84hL3sXaoLwc6oQRiUrCqad+JNfutBZPMlTIGGmerOz8rUJSiNz/F1e2VFZ2D0oUeskwglbA6qySc0CYzcUV59Px2xB09xGl9SqI+baQLI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TqQ8z72pQz9xrt5;
	Wed,  6 Mar 2024 16:10:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 17A50140416;
	Wed,  6 Mar 2024 16:26:04 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnoCSIKOhlyTjHAw--.13514S2;
	Wed, 06 Mar 2024 09:26:03 +0100 (CET)
Message-ID: <1217017cc1928842abfdb40a7fa50bad8ae5e99f.camel@huaweicloud.com>
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Christian Brauner
 <brauner@kernel.org>,  "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Eric
 Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Date: Wed, 06 Mar 2024 09:25:40 +0100
In-Reply-To: <10773e5b90ec9378cbc69fa9cfeb61a84273edc2.camel@linux.ibm.com>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
	 <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
	 <10773e5b90ec9378cbc69fa9cfeb61a84273edc2.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnoCSIKOhlyTjHAw--.13514S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4kAr4UGFyxXr45GFWfKrg_yoW7ZF1xpr
	y5GF4UKr4DJr1UJrn7tr1UX3W0y3yfJF4UXrn8G34UAr1qyr13Gr1xCr17uFyDur18Gr1U
	Zr1jyFy3Wr1UAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYY7kG6xAYrwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUguHqUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5sG0gAAs1

On Tue, 2024-03-05 at 21:17 -0500, Mimi Zohar wrote:
> On Tue, 2024-03-05 at 18:11 +0100, Roberto Sassu wrote:
> > On Tue, 2024-03-05 at 13:46 +0100, Roberto Sassu wrote:
> > > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcea=
n)
> > > > wrote:
> > > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) =
wrote:
> > > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote=
:
> > > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOce=
an)
> > > > > > > > wrote:
> > > > > > > > > Use the vfs interfaces for fetching file capabilities for
> > > > > > > > > killpriv
> > > > > > > > > checks and from get_vfs_caps_from_disk(). While there, up=
date
> > > > > > > > > the
> > > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it =
is
> > > > > > > > > different
> > > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kern=
el.org>
> > > > > > > > > ---
> > > > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > > --- a/security/commoncap.c
> > > > > > > > > +++ b/security/commoncap.c
> > > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > > >   */
> > > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > > >  {
> > > > > > > > > -	struct inode *inode =3D d_backing_inode(dentry);
> > > > > > > > > +	struct vfs_caps caps;
> > > > > > > > >  	int error;
> > > > > > > > > =20
> > > > > > > > > -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS=
,
> > > > > > > > > NULL, 0);
> > > > > > > > > -	return error > 0;
> > > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is
> > > > > > > > > unimportant */
> > > > > > > > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry,
> > > > > > > > > &caps);
> > > > > > > > > +	return error =3D=3D 0;
> > > > > > > > >  }
> > > > > > > > > =20
> > > > > > > > >  /**
> > > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idm=
ap
> > > > > > > > > *idmap, struct dentry *dentry)
> > > > > > > > >  {
> > > > > > > > >  	int error;
> > > > > > > > > =20
> > > > > > > > > -	error =3D __vfs_removexattr(idmap, dentry,
> > > > > > > > > XATTR_NAME_CAPS);
> > > > > > > > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > >=20
> > > > > > > > Uhm, I see that the change is logically correct... but the
> > > > > > > > original
> > > > > > > > code was not correct, since the EVM post hook is not called=
 (thus
> > > > > > > > the
> > > > > > > > HMAC is broken, or an xattr change is allowed on a portable
> > > > > > > > signature
> > > > > > > > which should be not).
> > > > > > > >=20
> > > > > > > > For completeness, the xattr change on a portable signature =
should
> > > > > > > > not
> > > > > > > > happen in the first place, so cap_inode_killpriv() would no=
t be
> > > > > > > > called.
> > > > > > > > However, since EVM allows same value change, we are here.
> > > > > > >=20
> > > > > > > I really don't understand EVM that well and am pretty hesitan=
t to
> > > > > > > try an
> > > > > > > change any of the logic around it. But I'll hazard a thought:=
 should
> > > > > > > EVM
> > > > > > > have a inode_need_killpriv hook which returns an error in thi=
s
> > > > > > > situation?
> > > > > >=20
> > > > > > Uhm, I think it would not work without modifying
> > > > > > security_inode_need_killpriv() and the hook definition.
> > > > > >=20
> > > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and E=
VM
> > > > > > would
> > > > > > not be invoked. We would need to continue the loop and let EVM =
know
> > > > > > what is the current return value. Then EVM can reject the chang=
e.
> > > > > >=20
> > > > > > An alternative way would be to detect that actually we are sett=
ing the
> > > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > > cap_inode_need_killpriv().
> > > > > >=20
> > > > > > I would prefer the second, since EVM allows same value change a=
nd we
> > > > > > would have an exception if there are fscaps.
> > > > > >=20
> > > > > > This solves only the case of portable signatures. We would need=
 to
> > > > > > change cap_inode_need_killpriv() anyway to update the HMAC for =
mutable
> > > > > > files.
> > > > >=20
> > > > > I see. In any case this sounds like a matter for a separate patch
> > > > > series.
> > > >=20
> > > > Agreed.
> > >=20
> > > Christian, how realistic is that we don't kill priv if we are setting
> > > the same owner?
> > >=20
> > > Serge, would we be able to replace __vfs_removexattr() (or now
> > > vfs_get_fscaps_nosec()) with a security-equivalent alternative?
> >=20
> > It seems it is not necessary.
> >=20
> > security.capability removal occurs between evm_inode_setattr() and
> > evm_inode_post_setattr(), after the HMAC has been verified and before
> > the new HMAC is recalculated (without security.capability).
> >=20
> > So, all good.
> >=20
> > Christian, Seth, I pushed the kernel and the updated tests (all patches
> > are WIP):
> >=20
> > https://github.com/robertosassu/linux/commits/evm-fscaps-v2/
>=20
> Resetting the IMA status flag is insufficient.  The EVM status needs to b=
e reset
> as well.  Stefan's "ima: re-evaluate file integrity on file metadata chan=
ge"
> patch does something similar for overlay.

Both the IMA and EVM status are reset. The IMA one is reset based on
the evm_revalidate_status() call, similarly to ACLs.

Roberto

> Mimi
>=20
> https://lore.kernel.org/linux-integrity/20240223172513.4049959-8-stefanb@=
linux.ibm.com/
>=20
> >=20
> > https://github.com/robertosassu/ima-evm-utils/commits/evm-fscaps-v2/
> >=20
> >=20
> > The tests are passing:
> >=20
> > https://github.com/robertosassu/ima-evm-utils/actions/runs/8159877004/j=
ob/22305521359
> >=20
> > Roberto
> >=20
> >=20
>=20


