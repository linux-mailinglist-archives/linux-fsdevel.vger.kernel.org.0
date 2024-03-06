Return-Path: <linux-fsdevel+bounces-13696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E328730B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB0C281FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D15C8F9;
	Wed,  6 Mar 2024 08:31:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1EB22F1D;
	Wed,  6 Mar 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713879; cv=none; b=Bs7Ubh3zjMDVr/NBtMK9J/gqNSg7dduEdoLvOf9FMPF50+o9lwyiRLqrNyYa4tJhOfMdmJRZjrObbf3KNs3BEZZnrDRl2+hiOODiqT4wbePTHkjIHCYMkwJKI8E91HTRZe/+MhOx7z85Oc5oSU6msjlayn2TQF1ukkvZVsm9WBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713879; c=relaxed/simple;
	bh=S2k4dHHEQpRhP6c+TZy4wKSpHEmoOGsY42HtUH5CMZk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDT/kThFW05W1dlMgICWoFKyl1wjD9cAzSXxm/4Nhc5P19WqxBQ/4T/W8H4rlkdFPucU4EdOP1wnDRUEQJpW3RdRT1V7o2xgf3hHHsGA/bona/WV2RrohntTDY5gtfEfrE2HXSMMovFxc8aJ1Cjr2GXpwa1pvXeU4swwLn/CJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TqQGr2sGmz9y4gm;
	Wed,  6 Mar 2024 16:15:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 836DC140412;
	Wed,  6 Mar 2024 16:31:13 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBHPhfBKehlVBnQAw--.462S2;
	Wed, 06 Mar 2024 09:31:12 +0100 (CET)
Message-ID: <720e7d0d55c2a22742ede0104fc884609b2f840d.camel@huaweicloud.com>
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
Date: Wed, 06 Mar 2024 09:30:54 +0100
In-Reply-To: <Zed91y4MYugjI1/K@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
	 <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
	 <ZeX9MRhU/EGhHkCY@do-x1extreme>
	 <20240305-fachjargon-abmontieren-75b1d6c67a83@brauner>
	 <3098aef3e5f924e5717b4ba4a34817d9f22ec479.camel@huaweicloud.com>
	 <7058e2f93d16f910336a5380877b14a2e069ee9d.camel@huaweicloud.com>
	 <Zed91y4MYugjI1/K@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBHPhfBKehlVBnQAw--.462S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar48Cr1DZFyfCry5ZF17Awb_yoW7CFy5pF
	W5GFn8Kr4kJr1UAr18tr1UX3WFy3yfJF4UXr1DK34jyr1qkr1ftr4Skr17uF98Cr18Gr1j
	vr1jy3W3Wr15AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj5sG1gABsw

On Tue, 2024-03-05 at 14:17 -0600, Seth Forshee (DigitalOcean) wrote:
> On Tue, Mar 05, 2024 at 06:11:45PM +0100, Roberto Sassu wrote:
> > On Tue, 2024-03-05 at 13:46 +0100, Roberto Sassu wrote:
> > > On Tue, 2024-03-05 at 10:12 +0100, Christian Brauner wrote:
> > > > On Mon, Mar 04, 2024 at 10:56:17AM -0600, Seth Forshee (DigitalOcea=
n) wrote:
> > > > > On Mon, Mar 04, 2024 at 05:17:57PM +0100, Roberto Sassu wrote:
> > > > > > On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) =
wrote:
> > > > > > > On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote=
:
> > > > > > > > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOce=
an) wrote:
> > > > > > > > > Use the vfs interfaces for fetching file capabilities for=
 killpriv
> > > > > > > > > checks and from get_vfs_caps_from_disk(). While there, up=
date the
> > > > > > > > > kerneldoc for get_vfs_caps_from_disk() to explain how it =
is different
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
, NULL, 0);
> > > > > > > > > -	return error > 0;
> > > > > > > > > +	/* Use nop_mnt_idmap for no mapping here as mapping is =
unimportant */
> > > > > > > > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, =
&caps);
> > > > > > > > > +	return error =3D=3D 0;
> > > > > > > > >  }
> > > > > > > > > =20
> > > > > > > > >  /**
> > > > > > > > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idm=
ap *idmap, struct dentry *dentry)
> > > > > > > > >  {
> > > > > > > > >  	int error;
> > > > > > > > > =20
> > > > > > > > > -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME_C=
APS);
> > > > > > > > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> > > > > > > >=20
> > > > > > > > Uhm, I see that the change is logically correct... but the =
original
> > > > > > > > code was not correct, since the EVM post hook is not called=
 (thus the
> > > > > > > > HMAC is broken, or an xattr change is allowed on a portable=
 signature
> > > > > > > > which should be not).
> > > > > > > >=20
> > > > > > > > For completeness, the xattr change on a portable signature =
should not
> > > > > > > > happen in the first place, so cap_inode_killpriv() would no=
t be called.
> > > > > > > > However, since EVM allows same value change, we are here.
> > > > > > >=20
> > > > > > > I really don't understand EVM that well and am pretty hesitan=
t to try an
> > > > > > > change any of the logic around it. But I'll hazard a thought:=
 should EVM
> > > > > > > have a inode_need_killpriv hook which returns an error in thi=
s
> > > > > > > situation?
> > > > > >=20
> > > > > > Uhm, I think it would not work without modifying
> > > > > > security_inode_need_killpriv() and the hook definition.
> > > > > >=20
> > > > > > Since cap_inode_need_killpriv() returns 1, the loop stops and E=
VM would
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
> >=20
> > https://github.com/robertosassu/ima-evm-utils/commits/evm-fscaps-v2/
> >=20
> >=20
> > The tests are passing:
> >=20
> > https://github.com/robertosassu/ima-evm-utils/actions/runs/8159877004/j=
ob/22305521359
>=20
> Thanks! I probably won't be able to take them exactly as-is due to other
> changes for the next version (rebasing onto the changes to make IMA and
> EVM LSMs, forbidding xattr handlers entirely for fscaps), but they will
> serve as a good road map for what needs to happen.

Welcome. Yes, both ima_inode_set_fscaps() and ima_inode_remove_fscaps()
will be registered as LSM hooks in ima_appraise.c. It will be probably
straightforward for you to make those changes, but if you have any
question, let me know.

Roberto


