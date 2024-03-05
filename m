Return-Path: <linux-fsdevel+bounces-13640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F0E872471
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE3D1C24FCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB88C8F3;
	Tue,  5 Mar 2024 16:35:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2198BF6;
	Tue,  5 Mar 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656550; cv=none; b=fUxArBNx+sFLDhasVNBSA9wR/bwdpG8ZAGYvAUGj8W6KaTvw495u0XzDYc0RTHM/6cpWnk01XbgxqrxlYZPEIhhgSrqUOt4TiKvQUhlb33JQydRXtDOmk13NwKyrbaXvKtPBewqQOJBRheYP0l0neEjTmQbP2VkijKls6kkuO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656550; c=relaxed/simple;
	bh=1pdeNcwiI6EsTl0SRaoPJVpuE3CKPxS67A9A0uH3rcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/UMJg7S/ufDsWQykburViVdO5hnLTOn6viGfGoEgTAtV7I6/vgZTuMZWFTgQbMY/fD6PKOyFsRH6WR630PugCwhRpxeV0U6n2/2hedT2EOYqOmZKBq/qptqYENwdd18Ah65V89604HRDtclLx/nJDXU0Lzr4p0qoV/rWtJQcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tq14K38T3z9y8HV;
	Wed,  6 Mar 2024 00:20:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 05A921406AE;
	Wed,  6 Mar 2024 00:35:32 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnmhPDSedlWlTFAw--.63520S2;
	Tue, 05 Mar 2024 17:35:31 +0100 (CET)
Message-ID: <133a912d05fb0790ab3672103a21a4f8bfb70405.camel@huaweicloud.com>
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Serge Hallyn
 <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Eric Paris
 <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,  Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jonathan Corbet
 <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein
 <amir73il@gmail.com>,  linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-security-module@vger.kernel.org,
 audit@vger.kernel.org,  selinux@vger.kernel.org,
 linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-unionfs@vger.kernel.org
Date: Tue, 05 Mar 2024 17:35:11 +0100
In-Reply-To: <20240305-zyklisch-halluzinationen-98b782666cf8@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
	 <20240305-zyklisch-halluzinationen-98b782666cf8@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnmhPDSedlWlTFAw--.63520S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFy3uw1xCw1xCrWrur1rZwb_yoW7Xw18pF
	W5GFnrKF4DJr13Cr1xtw1UX3WFy34fJF4UXrn8J3yjyr1qkr1fGr4Syr17uFy5Cr1xtw4Y
	vF1jyFyfWrn8A3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ebytUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5cBhQAAsp

On Tue, 2024-03-05 at 17:26 +0100, Christian Brauner wrote:
> On Tue, Mar 05, 2024 at 01:46:56PM +0100, Roberto Sassu wrote:
> > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean)=
 wrote:
> > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wr=
ote:
> > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean=
) wrote:
> > > > > > > > Use the vfs interfaces for fetching file capabilities for k=
illpriv
> > > > > > > > checks and from get_vfs_caps_from_disk(). While there, upda=
te the
> > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is=
 different
> > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > >=20
> > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel=
.org>
> > > > > > > > ---
> > > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > --- a/security/commoncap.c
> > > > > > > > +++ b/security/commoncap.c
> > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > >   */
> > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > >  {
> > > > > > > > -	struct inode *inode =3D d_backing_inode(dentry);
> > > > > > > > +	struct vfs_caps caps;
> > > > > > > >  	int error;
> > > > > > > > =20
> > > > > > > > -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, =
NULL, 0);
> > > > > > > > -	return error > 0;
> > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is un=
important */
> > > > > > > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &c=
aps);
> > > > > > > > +	return error =3D=3D 0;
> > > > > > > >  }
> > > > > > > > =20
> > > > > > > >  /**
> > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap=
 *idmap, struct dentry *dentry)
> > > > > > > >  {
> > > > > > > >  	int error;
> > > > > > > > =20
> > > > > > > > -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME_CAP=
S);
> > > > > > > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > >=20
> > > > > > > Uhm, I see that the change is logically correct... but the or=
iginal
> > > > > > > code was not correct, since the EVM post hook is not called (=
thus the
> > > > > > > HMAC is broken, or an xattr change is allowed on a portable s=
ignature
> > > > > > > which should be not).
> > > > > > >=20
> > > > > > > For completeness, the xattr change on a portable signature sh=
ould not
> > > > > > > happen in the first place, so cap_inode_killpriv() would not =
be called.
> > > > > > > However, since EVM allows same value change, we are here.
> > > > > >=20
> > > > > > I really don't understand EVM that well and am pretty hesitant =
to try an
> > > > > > change any of the logic around it. But I'll hazard a thought: s=
hould EVM
> > > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > > situation?
> > > > >=20
> > > > > Uhm, I think it would not work without modifying
> > > > > security_inode_need_killpriv() and the hook definition.
> > > > >=20
> > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM=
 would
> > > > > not be invoked. We would need to continue the loop and let EVM kn=
ow
> > > > > what is the current return value. Then EVM can reject the change.
> > > > >=20
> > > > > An alternative way would be to detect that actually we are settin=
g the
> > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > cap_inode_need_killpriv().
> > > > >=20
> > > > > I would prefer the second, since EVM allows same value change and=
 we
> > > > > would have an exception if there are fscaps.
> > > > >=20
> > > > > This solves only the case of portable signatures. We would need t=
o
> > > > > change cap_inode_need_killpriv() anyway to update the HMAC for mu=
table
> > > > > files.
> > > >=20
> > > > I see. In any case this sounds like a matter for a separate patch
> > > > series.
> > >=20
> > > Agreed.
> >=20
> > Christian, how realistic is that we don't kill priv if we are setting
> > the same owner?
>=20
> Uhm, I would need to see the wider context of the proposed change. But
> iiuc then you would be comparing current and new fscaps and if they are
> identical you don't kill privs? I think that would work. But again, I
> would need to see the actual context/change to say something meaningful.

Ok, basically a software vendor can ship binaries with a signature over
file metadata, including UID/GID, etc.

A system can verify the signature through the public key of the
software vendor.

The problem is if someone (or even tar), executes chown on that binary,
fscaps are lost. Thus, signature verification will fail from now on.

EVM locks file metadata as soon as signature verification succeeds
(i.e. metadata are the same of those signed by the software vendor).

EVM locking works if someone is trying to set different metadata. But,
if I try to chown to the same owner as the one stored in the inode, EVM
allows it but the capability LSM removes security.capability, thus
invalidating the signature.

At least, it would be desirable that security.capability is not removed
when setting the same owner. If the owner is different, EVM will handle
that.

Roberto


