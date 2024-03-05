Return-Path: <linux-fsdevel+bounces-13644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC5872567
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066C8283974
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB4516415;
	Tue,  5 Mar 2024 17:12:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D866DF5B;
	Tue,  5 Mar 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658735; cv=none; b=bWt8wFKjyzzbGaoyXoEBlPyDp4fNacDpOb+NFQTd5az0J/H3iyusKyQ9sjmdKgNUgdXmIApCXWvC+LBQxZzFF15qKh6GOHBGKbH9VJeK1kafVyrul3UOBiEskEEQc5h9zR4fwS3HK4iZTsy6WviGDVuJmXDZjZ6d0ftpD7haOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658735; c=relaxed/simple;
	bh=Q8PaurBFrppbrqEEOgrIENl2HwLshHsmzS0Oq1dK20k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DZ5fZMNnabvamCgpSVjl73kvv8+Bpu8w0+0qiiMOjEcN4QZ6ckwITMiKqQWBSyrEWqIwrS26HvvjRl/bM1pZiDhpLHGnXtewhiwiQldVLt+xj1SQxyHnv7+gYIH4kQB2KGwisbdhyVKm1WHgqvHrCd4ehADYXuhBw8K2Dg/Dq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Tq1tR1BFrz9yMLR;
	Wed,  6 Mar 2024 00:56:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id CE1D914066A;
	Wed,  6 Mar 2024 01:12:03 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHehNTUudld77FAw--.63538S2;
	Tue, 05 Mar 2024 18:12:03 +0100 (CET)
Message-ID: <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
Subject: Re: [PATCH v2 24/25] commoncap: use vfs fscaps interfaces
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Christian Brauner <brauner@kernel.org>, "Seth Forshee (DigitalOcean)"
	 <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, Eric
 Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro
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
Date: Tue, 05 Mar 2024 18:11:45 +0100
In-Reply-To: <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCHehNTUudld77FAw--.63538S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWrGF4xWw15JFyxWr1UAwb_yoWrtr47pF
	W5GFn8Krs5Xr17Jrn7tr1DX3WFy3yfJF4UXrykG3y0vr1qyr1fKr4Skr17uF98ur1xJr1Y
	vF1jya43Wrn8AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkvb40E47kJMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUg7GYDU
	UUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5sCpAAAsE

On Tue, 2024-03-05 at 13:46 +0100, Roberto Sassu wrote:
> On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean) w=
rote:
> > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrot=
e:
> > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) =
wrote:
> > > > > > > Use the vfs interfaces for fetching file capabilities for kil=
lpriv
> > > > > > > checks and from get_vfs_caps_from_disk(). While there, update=
 the
> > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is d=
ifferent
> > > > > > > from vfs_get_fscaps_nosec().
> > > > > > >=20
> > > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.o=
rg>
> > > > > > > ---
> > > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > > --- a/security/commoncap.c
> > > > > > > +++ b/security/commoncap.c
> > > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > > >   */
> > > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > > >  {
> > > > > > > -	struct inode *inode =3D d_backing_inode(dentry);
> > > > > > > +	struct vfs_caps caps;
> > > > > > >  	int error;
> > > > > > > =20
> > > > > > > -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NU=
LL, 0);
> > > > > > > -	return error > 0;
> > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is unim=
portant */
> > > > > > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &cap=
s);
> > > > > > > +	return error =3D=3D 0;
> > > > > > >  }
> > > > > > > =20
> > > > > > >  /**
> > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *=
idmap, struct dentry *dentry)
> > > > > > >  {
> > > > > > >  	int error;
> > > > > > > =20
> > > > > > > -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS)=
;
> > > > > > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > >=20
> > > > > > Uhm, I see that the change is logically correct... but the orig=
inal
> > > > > > code was not correct, since the EVM post hook is not called (th=
us the
> > > > > > HMAC is broken, or an xattr change is allowed on a portable sig=
nature
> > > > > > which should be not).
> > > > > >=20
> > > > > > For completeness, the xattr change on a portable signature shou=
ld not
> > > > > > happen in the first place, so cap_inode_killpriv() would not be=
 called.
> > > > > > However, since EVM allows same value change, we are here.
> > > > >=20
> > > > > I really don't understand EVM that well and am pretty hesitant to=
 try an
> > > > > change any of the logic around it. But I'll hazard a thought: sho=
uld EVM
> > > > > have a inode_need_killpriv hook which returns an error in this
> > > > > situation?
> > > >=20
> > > > Uhm, I think it would not work without modifying
> > > > security_inode_need_killpriv() and the hook definition.
> > > >=20
> > > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM w=
ould
> > > > not be invoked. We would need to continue the loop and let EVM know
> > > > what is the current return value. Then EVM can reject the change.
> > > >=20
> > > > An alternative way would be to detect that actually we are setting =
the
> > > > same value for inode metadata, and maybe not returning 1 from
> > > > cap_inode_need_killpriv().
> > > >=20
> > > > I would prefer the second, since EVM allows same value change and w=
e
> > > > would have an exception if there are fscaps.
> > > >=20
> > > > This solves only the case of portable signatures. We would need to
> > > > change cap_inode_need_killpriv() anyway to update the HMAC for muta=
ble
> > > > files.
> > >=20
> > > I see. In any case this sounds like a matter for a separate patch
> > > series.
> >=20
> > Agreed.
>=20
> Christian, how realistic is that we don't kill priv if we are setting
> the same owner?
>=20
> Serge, would we be able to replace __vfs_removexattr() (or now
> vfs_get_fscaps_nosec()) with a security-equivalent alternative?

It seems it is not necessary.

security.capability removal occurs between evm_inode_setattr() and
evm_inode_post_setattr(), after the HMAC has been verified and before
the new HMAC is recalculated (without security.capability).

So, all good.

Christian, Seth, I pushed the kernel and the updated tests (all patches
are WIP):

https://github.com/robertosassu/linux/commits/evm-fscaps-v2/

https://github.com/robertosassu/ima-evm-utils/commits/evm-fscaps-v2/


The tests are passing:

https://github.com/robertosassu/ima-evm-utils/actions/runs/8159877004/job/2=
2305521359

Roberto


