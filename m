Return-Path: <linux-fsdevel+bounces-13614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C17871F77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096421F23B77
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30058222;
	Tue,  5 Mar 2024 12:47:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84385645;
	Tue,  5 Mar 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709642856; cv=none; b=bzf8OapVC3z2cyY7VAuywh8t6N9y/XrLydBiWrmS2+e1QPpYGJy5Dbq/SlOVSPkrqMGcDe6q+ZfnR14LULsihepn8kz+uwX6Md2tdkJonHgyspu1v/wQDxZzzC+dIb57VgIaQ1Vx+hq8zeav4Cq50u7ef8vwdbZtCdninYv3TxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709642856; c=relaxed/simple;
	bh=6hryqrJ72wzfly2rJ+FzgO0eAdOTeU5s0vIFIR7Onrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TeIFCmUhOf92cHAkNRuyGsLMkB2LracKqlhPSkjNVd9OxfVcvAmMEOLzQAmPulVpXVndZ5AV/9zYHQVYuDZzSpxyIQSgZa5k6mCltrlPNQUpy+dfLufYMKdI4pe3DQTJ8wjMxTl8RvqsY7gZ8x/I5aC0RMYMOkcifA3u/fZE7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tpw0v3nc2z9ybvS;
	Tue,  5 Mar 2024 20:31:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C0E871405A1;
	Tue,  5 Mar 2024 20:47:16 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3YBlEFOdlb7rCAw--.65453S2;
	Tue, 05 Mar 2024 13:47:16 +0100 (CET)
Message-ID: <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
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
Date: Tue, 05 Mar 2024 13:46:56 +0100
In-Reply-To: <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3YBlEFOdlb7rCAw--.65453S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWDWF4UJw13Kw1UXr4Dtwb_yoWrGFWDpF
	W3GFnrKrs5Xr13Ar1xtr1UX3WFk3yfJF4UXFyDG3y0yr1qkr1fGr4fAry7uFy5ur18Kw1j
	vF1jyFy3urs8A3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5b+nwAAsN

On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcean) wro=
te:
> > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrote:
> > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wr=
ote:
> > > > > > Use the vfs interfaces for fetching file capabilities for killp=
riv
> > > > > > checks and from get_vfs_caps_from_disk(). While there, update t=
he
> > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it is dif=
ferent
> > > > > > from vfs_get_fscaps_nosec().
> > > > > >=20
> > > > > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org=
>
> > > > > > ---
> > > > > >  security/commoncap.c | 30 +++++++++++++-----------------
> > > > > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > > > > >=20
> > > > > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > > > > index a0ff7e6092e0..751bb26a06a6 100644
> > > > > > --- a/security/commoncap.c
> > > > > > +++ b/security/commoncap.c
> > > > > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > > > > >   */
> > > > > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > > > > >  {
> > > > > > -	struct inode *inode =3D d_backing_inode(dentry);
> > > > > > +	struct vfs_caps caps;
> > > > > >  	int error;
> > > > > > =20
> > > > > > -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL=
, 0);
> > > > > > -	return error > 0;
> > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is unimpo=
rtant */
> > > > > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps)=
;
> > > > > > +	return error =3D=3D 0;
> > > > > >  }
> > > > > > =20
> > > > > >  /**
> > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *id=
map, struct dentry *dentry)
> > > > > >  {
> > > > > >  	int error;
> > > > > > =20
> > > > > > -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> > > > > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> > > > >=20
> > > > > Uhm, I see that the change is logically correct... but the origin=
al
> > > > > code was not correct, since the EVM post hook is not called (thus=
 the
> > > > > HMAC is broken, or an xattr change is allowed on a portable signa=
ture
> > > > > which should be not).
> > > > >=20
> > > > > For completeness, the xattr change on a portable signature should=
 not
> > > > > happen in the first place, so cap_inode_killpriv() would not be c=
alled.
> > > > > However, since EVM allows same value change, we are here.
> > > >=20
> > > > I really don't understand EVM that well and am pretty hesitant to t=
ry an
> > > > change any of the logic around it. But I'll hazard a thought: shoul=
d EVM
> > > > have a inode_need_killpriv hook which returns an error in this
> > > > situation?
> > >=20
> > > Uhm, I think it would not work without modifying
> > > security_inode_need_killpriv() and the hook definition.
> > >=20
> > > Since cap_inode_need_killpriv() returns 1, the loop stops and EVM wou=
ld
> > > not be invoked. We would need to continue the loop and let EVM know
> > > what is the current return value. Then EVM can reject the change.
> > >=20
> > > An alternative way would be to detect that actually we are setting th=
e
> > > same value for inode metadata, and maybe not returning 1 from
> > > cap_inode_need_killpriv().
> > >=20
> > > I would prefer the second, since EVM allows same value change and we
> > > would have an exception if there are fscaps.
> > >=20
> > > This solves only the case of portable signatures. We would need to
> > > change cap_inode_need_killpriv() anyway to update the HMAC for mutabl=
e
> > > files.
> >=20
> > I see. In any case this sounds like a matter for a separate patch
> > series.
>=20
> Agreed.

Christian, how realistic is that we don't kill priv if we are setting
the same owner?

Serge, would we be able to replace __vfs_removexattr() (or now
vfs_get_fscaps_nosec()) with a security-equivalent alternative?

Thanks

Roberto


