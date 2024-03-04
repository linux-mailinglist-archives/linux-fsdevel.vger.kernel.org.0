Return-Path: <linux-fsdevel+bounces-13492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CF8706DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D6BB29D60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33704CB23;
	Mon,  4 Mar 2024 16:18:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA28482DA;
	Mon,  4 Mar 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569114; cv=none; b=eV+/QlY/IpNUKfjtGk7O4EDSlvQ5MSzuvG5ly9HIhEh3+M0JuiUB1C9nxbTA244ZZxBpESVTXMtbQU+GJPH9GPKHvurzRB27l4LIbktf9EiNFtd5nVZAn4Z9Ju0UqY4s8u77gV/3mK6UD/gttN61nL98dl8UtCGopN0bZ81/Xks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569114; c=relaxed/simple;
	bh=vfCt86t5faZJDVibBfvf2Juvf6JHTd3OEradfAtDy3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A8FZysNVWuXKRY/Ptbw+fgJDy6eDjDAMqxc9ES7rkf4lR400cwkOotEtJjFtOdrOKRPc4Og3S29w+bCQw8jceJO7C2d9R/ql34nlQCceTi8fOrddPHZlsIiGHgQH11bmVuJbWdaZbi3qBtlVmgQ0NU7O6V5BfhOgwKCuW/HfXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TpNky4sfvz9y5ZR;
	Tue,  5 Mar 2024 00:02:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A67B814066A;
	Tue,  5 Mar 2024 00:18:17 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD37xg49OVl09+0Aw--.24845S2;
	Mon, 04 Mar 2024 17:18:16 +0100 (CET)
Message-ID: <a7124afa6bed2fcadcb66efa08e256828cd6f8ab.camel@huaweicloud.com>
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
Date: Mon, 04 Mar 2024 17:17:57 +0100
In-Reply-To: <ZeXpbOsdRTbLsYe9@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-24-3039364623bd@kernel.org>
	 <dcbd9e7869d2fcce69546b53851d694b8ebad54e.camel@huaweicloud.com>
	 <ZeXpbOsdRTbLsYe9@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD37xg49OVl09+0Aw--.24845S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyfZrWkCrWxGw4UJw1fZwb_yoW5CrW5pF
	W3GFnxKr4kXr17Crn7tr4DZa4F9w4fJF47GF97G3y0ywnFkr1ftr4S9347uFy5Cry8Kr45
	ZF1qya45CrZ8ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj5r12AAAsP

On Mon, 2024-03-04 at 09:31 -0600, Seth Forshee (DigitalOcean) wrote:
> On Mon, Mar 04, 2024 at 11:19:54AM +0100, Roberto Sassu wrote:
> > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > > Use the vfs interfaces for fetching file capabilities for killpriv
> > > checks and from get_vfs_caps_from_disk(). While there, update the
> > > kerneldoc for get_vfs_caps_from_disk() to explain how it is different
> > > from vfs_get_fscaps_nosec().
> > >=20
> > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > ---
> > >  security/commoncap.c | 30 +++++++++++++-----------------
> > >  1 file changed, 13 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/security/commoncap.c b/security/commoncap.c
> > > index a0ff7e6092e0..751bb26a06a6 100644
> > > --- a/security/commoncap.c
> > > +++ b/security/commoncap.c
> > > @@ -296,11 +296,12 @@ int cap_capset(struct cred *new,
> > >   */
> > >  int cap_inode_need_killpriv(struct dentry *dentry)
> > >  {
> > > -	struct inode *inode =3D d_backing_inode(dentry);
> > > +	struct vfs_caps caps;
> > >  	int error;
> > > =20
> > > -	error =3D __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
> > > -	return error > 0;
> > > +	/* Use nop_mnt_idmap for no mapping here as mapping is unimportant =
*/
> > > +	error =3D vfs_get_fscaps_nosec(&nop_mnt_idmap, dentry, &caps);
> > > +	return error =3D=3D 0;
> > >  }
> > > =20
> > >  /**
> > > @@ -323,7 +324,7 @@ int cap_inode_killpriv(struct mnt_idmap *idmap, s=
truct dentry *dentry)
> > >  {
> > >  	int error;
> > > =20
> > > -	error =3D __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> > > +	error =3D vfs_remove_fscaps_nosec(idmap, dentry);
> >=20
> > Uhm, I see that the change is logically correct... but the original
> > code was not correct, since the EVM post hook is not called (thus the
> > HMAC is broken, or an xattr change is allowed on a portable signature
> > which should be not).
> >=20
> > For completeness, the xattr change on a portable signature should not
> > happen in the first place, so cap_inode_killpriv() would not be called.
> > However, since EVM allows same value change, we are here.
>=20
> I really don't understand EVM that well and am pretty hesitant to try an
> change any of the logic around it. But I'll hazard a thought: should EVM
> have a inode_need_killpriv hook which returns an error in this
> situation?

Uhm, I think it would not work without modifying
security_inode_need_killpriv() and the hook definition.

Since cap_inode_need_killpriv() returns 1, the loop stops and EVM would
not be invoked. We would need to continue the loop and let EVM know
what is the current return value. Then EVM can reject the change.

An alternative way would be to detect that actually we are setting the
same value for inode metadata, and maybe not returning 1 from
cap_inode_need_killpriv().

I would prefer the second, since EVM allows same value change and we
would have an exception if there are fscaps.

This solves only the case of portable signatures. We would need to
change cap_inode_need_killpriv() anyway to update the HMAC for mutable
files.

Roberto


