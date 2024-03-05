Return-Path: <linux-fsdevel+bounces-13643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B60872547
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239321F261CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2C9179AF;
	Tue,  5 Mar 2024 17:09:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDE15E86;
	Tue,  5 Mar 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658550; cv=none; b=EQ6iwVAL97x0Se2TE4r3MDoB5i2VpBX9j4ubPPzhVT/jKjPRktKLaaERss+gqQtAHSb1ZwNLIsSawUP5iE+FxozuNsyY2RaPVg4IlcF8xIxPn5LjHgtgEBVvCQPt/992CAryluN8MMAg7QOSoE5C/lL1Dpbgu9BJSjLKI5sVPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658550; c=relaxed/simple;
	bh=5f1IPY+FnnC1k2YnB4vovG/JbKhW1jfLaamJn7esrcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnV/0ldlyACKC5cyMabuHTsLokiKSy7tm3Zg46o2vA6EqeTrAvF8PVV2xDDK6NHqlrTNNQVoTwOJ437F1JylcGuLlCM7jeHa0x1J3MNALkjqCVlFC+Yh3jsvfoUviYZ61C/tEO6C5cZsLvBxrBRIjiBQDid0Ft3da5WLDxizfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tq1pq4YcBz9y0Nb;
	Wed,  6 Mar 2024 00:53:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1989D14059B;
	Wed,  6 Mar 2024 01:09:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXTSGdUedlTf68Aw--.61170S2;
	Tue, 05 Mar 2024 18:09:01 +0100 (CET)
Message-ID: <9c739aae1677b2b7169025750f83c1126e91ebde.camel@huaweicloud.com>
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
  Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, James
 Morris <jmorris@namei.org>,  Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,  Casey Schaufler
 <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Date: Tue, 05 Mar 2024 18:08:41 +0100
In-Reply-To: <ZedQRThbc60h+VoA@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
	 <20240305-zyklisch-halluzinationen-98b782666cf8@brauner>
	 <133a912d05fb0790ab3672103a21a4f8bfb70405.camel@huaweicloud.com>
	 <ZedQRThbc60h+VoA@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXTSGdUedlTf68Aw--.61170S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw1kurWUuw4DZF1DCFWrAFb_yoWxGw45pF
	y5JFnrKF4DJr17Ar1xtw1UXF10yryxJF4UXrn8J34jyr1DKr17Gr4jyr17uF98Cr18Jr1j
	vF1jyFy3Wrs8AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5cByQABsk

On Tue, 2024-03-05 at 11:03 -0600, Seth Forshee (DigitalOcean) wrote:
> On Tue, Mar 05, 2024 at 05:35:11PM +0100, Roberto Sassu wrote:
> > On Tue, 2024-03-05 at 17:26 +0100, Christian Brauner wrote:
> > > On Tue, Mar 05, 2024 at 01:46:56PM +0100, Roberto Sassu wrote:
> > > > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOc=
ean) wrote:
> > > > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean=
) wrote:
> > > > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wro=
te:
> > > > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalO=
cean) wrote:
> > > > > > > > > > Use the vfs interfaces for fetching file capabilities f=
or killpriv
> > > > > > > > > > checks and from get_vfs_caps_from_disk(). While there, =
update the
> > > > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how i=
t is different
> > > > > > > > > > from vfs_get_fscaps_nosec().
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@ke=
rnel.org>
> > > > > > > > > > ---
> > > > > > > > > >  security/commoncap.c | 30 +++++++++++++---------------=
--
> > > > > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/security/commoncap.c b/security/commoncap.=
c
> > > > > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > > > > --- a/security/commoncap.c
> > > > > > > > > > +++ b/security/commoncap.c
> > > > > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > > > > >   */
> > > > > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > > > > >  {
> > > > > > > > > > -	struct inode *inode =3D d_backing_inode(dentry);
> > > > > > > > > > +	struct vfs_caps caps;
> > > > > > > > > >  	int error;
> > > > > > > > > > =20
> > > > > > > > > > -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CA=
PS, NULL, 0);
> > > > > > > > > > -	return error > 0;
> > > > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping i=
s unimportant */
> > > > > > > > > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry=
, &caps);
> > > > > > > > > > +	return error =3D=3D 0;
> > > > > > > > > >  }
> > > > > > > > > > =20
> > > > > > > > > >  /**
> > > > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_i=
dmap *idmap, struct dentry *dentry)
> > > > > > > > > >  {
> > > > > > > > > >  	int error;
> > > > > > > > > > =20
> > > > > > > > > > -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME=
_CAPS);
> > > > > > > > > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > > >=20
> > > > > > > > > Uhm, I see that the change is logically correct... but th=
e original
> > > > > > > > > code was not correct, since the EVM post hook is not call=
ed (thus the
> > > > > > > > > HMAC is broken, or an xattr change is allowed on a portab=
le signature
> > > > > > > > > which should be not).
> > > > > > > > >=20
> > > > > > > > > For completeness, the xattr change on a portable signatur=
e should not
> > > > > > > > > happen in the first place, so cap_inode_killpriv() would =
not be called.
> > > > > > > > > However, since EVM allows same value change, we are here.
> > > > > > > >=20
> > > > > > > > I really don't understand EVM that well and am pretty hesit=
ant to try an
> > > > > > > > change any of the logic around it. But I'll hazard a though=
t: should EVM
> > > > > > > > have a inode_need_killpriv hook which returns an error in t=
his
> > > > > > > > situation?
> > > > > > >=20
> > > > > > > Uhm, I think it would not work without modifying
> > > > > > > security_inode_need_killpriv() and the hook definition.
> > > > > > >=20
> > > > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and=
 EVM would
> > > > > > > not be invoked. We would need to continue the loop and let EV=
M know
> > > > > > > what is the current return value. Then EVM can reject the cha=
nge.
> > > > > > >=20
> > > > > > > An alternative way would be to detect that actually we are se=
tting the
> > > > > > > same value for inode metadata, and maybe not returning 1 from
> > > > > > > cap_inode_need_killpriv().
> > > > > > >=20
> > > > > > > I would prefer the second, since EVM allows same value change=
 and we
> > > > > > > would have an exception if there are fscaps.
> > > > > > >=20
> > > > > > > This solves only the case of portable signatures. We would ne=
ed to
> > > > > > > change cap_inode_need_killpriv() anyway to update the HMAC fo=
r mutable
> > > > > > > files.
> > > > > >=20
> > > > > > I see. In any case this sounds like a matter for a separate pat=
ch
> > > > > > series.
> > > > >=20
> > > > > Agreed.
> > > >=20
> > > > Christian, how realistic is that we don't kill priv if we are setti=
ng
> > > > the same owner?
> > >=20
> > > Uhm, I would need to see the wider context of the proposed change. Bu=
t
> > > iiuc then you would be comparing current and new fscaps and if they a=
re
> > > identical you don't kill privs? I think that would work. But again, I
> > > would need to see the actual context/change to say something meaningf=
ul.
> >=20
> > Ok, basically a software vendor can ship binaries with a signature over
> > file metadata, including UID/GID, etc.
> >=20
> > A system can verify the signature through the public key of the
> > software vendor.
> >=20
> > The problem is if someone (or even tar), executes chown on that binary,
> > fscaps are lost. Thus, signature verification will fail from now on.
> >=20
> > EVM locks file metadata as soon as signature verification succeeds
> > (i.e. metadata are the same of those signed by the software vendor).
> >=20
> > EVM locking works if someone is trying to set different metadata. But,
> > if I try to chown to the same owner as the one stored in the inode, EVM
> > allows it but the capability LSM removes security.capability, thus
> > invalidating the signature.
> >=20
> > At least, it would be desirable that security.capability is not removed
> > when setting the same owner. If the owner is different, EVM will handle
> > that.
>=20
> When you say EVM "locks" file metadata, does that mean it prevents
> modification to file metadata?

Yes, but only when metadata are in the final state (what the software
vendor signed). Otherwise, modifications are still allowed.

That was needed to let tar set everything (xattrs and attrs).

> What about changes to file data? This will also result in removing
> fscaps xattrs. Does EVM also block changes to file data when signature
> verification succeeds?

That would be the job of IMA. EVM would not be able to detect that. If
the file has an EVM immutable and portable signature, IMA denies
changes to it (assuming that an IMA appraisal policy was loaded, and
that file matches a policy rule).

Roberto


