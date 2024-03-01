Return-Path: <linux-fsdevel+bounces-13295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D386E401
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FB81F221F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 15:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE86D1D8;
	Fri,  1 Mar 2024 15:04:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EC3A8E3;
	Fri,  1 Mar 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305484; cv=none; b=BLoij6TMLFgbmqEKDy9aK0Dz47jqORXmLxmTpoFab/73Jh3Ei6FJmsEqRkQtPQlGbYtxpHxtLyPjyXfU0TEJXGRHCnwTgUSIzzBaSIl05+AeMNbKCdYON/p03XC3VJ2OOHD7kt1vP82zdlun9ouAu1+yU2RPiNwtF3PP28F7daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305484; c=relaxed/simple;
	bh=CLfHGgV8g9ikDXr41EpApqiaZGI0K8iTSgXJt1K3S6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PIaPpuxN0nniTwyZEFoAaLJeGZXT5GUdAzRcE5cxQdMb9LUVtExx3OdN1wxuTQtD5yj6imY9/fazALaszKzmGRGnJJk9z3GTi8u+EuV+Whl90u3nSOULXPm/1FpdSUrFTLI+HJMJwg4dtCykAMWomrLCtgKQ5Hle6FjTYgTjYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmWF93hfZz9y4Sq;
	Fri,  1 Mar 2024 22:49:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id B87D4140D09;
	Fri,  1 Mar 2024 23:04:31 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAH9Cdu7uFlW217Aw--.47273S2;
	Fri, 01 Mar 2024 16:04:31 +0100 (CET)
Message-ID: <f1b1b5a46fb07cd64e095bb4a224adbf2e6baab6.camel@huaweicloud.com>
Subject: Re: [PATCH v2 14/25] evm: add support for fscaps security hooks
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
Date: Fri, 01 Mar 2024 16:04:11 +0100
In-Reply-To: <ZeHotBrI0aYd2HeA@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
	 <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
	 <15a69385b49c4f8626f082bc9b957132388414fb.camel@huaweicloud.com>
	 <ZeHotBrI0aYd2HeA@do-x1extreme>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAH9Cdu7uFlW217Aw--.47273S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF18ZFykGFyDJw4rXr17Awb_yoW5uF1xpF
	WfC3ZYkrn5Jry3Jr97A3yDX3WF93yrJrW7Kr95X34kua4DCF1fCrWxKFW5uFs3ZwnxGr1q
	qw47tr1DGFsIv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj5bh2gABsS

On Fri, 2024-03-01 at 08:39 -0600, Seth Forshee (DigitalOcean) wrote:
> On Fri, Mar 01, 2024 at 10:19:13AM +0100, Roberto Sassu wrote:
> > On Wed, 2024-02-21 at 15:24 -0600, Seth Forshee (DigitalOcean) wrote:
> > > Support the new fscaps security hooks by converting the vfs_caps to r=
aw
> > > xattr data and then handling them the same as other xattrs.
> >=20
> > Hi Seth
> >=20
> > I started looking at this patch set.
> >=20
> > The first question I have is if you are also going to update libcap
> > (and also tar, I guess), since both deal with the raw xattr.
>=20
> There are no changes needed for userspace; it will still deal with raw
> xattrs. As I mentioned in the cover letter, capabilities tests from
> libcap2, libcap-ng, ltp, and xfstests all pass against this sereies.
> That's with no modifications to userspace.

Yes, figured it out after applying the patch set. Then yes, IMA/EVM
tests should work too.

> > From IMA/EVM perspective (Mimi will add on that), I guess it is
> > important that files with a signature/HMAC continue to be accessible
> > after applying this patch set.
> >=20
> > Looking at the code, it seems the case (if I understood correctly,
> > vfs_getxattr_alloc() is still allowed).
>=20
> So this is something that would change based on Christian's request to
> stop using the xattr handlers entirely for fscaps as was done for acls.
> I see how this would impact EVM, but we should be able to deal with it.
>=20
> I am a little curious now about this code in evm_calc_hmac_or_hash():
>=20
> 		size =3D vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
> 					  &xattr_value, xattr_size, GFP_NOFS);
> 		if (size =3D=3D -ENOMEM) {
> 			error =3D -ENOMEM;
> 			goto out;
> 		}
> 		if (size < 0)
> 			continue;
>=20
> 		user_space_size =3D vfs_getxattr(&nop_mnt_idmap, dentry,
> 					       xattr->name, NULL, 0);
> 		if (user_space_size !=3D size)
> 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
> 				 dentry->d_name.name, xattr->name, size,
> 				 user_space_size);
>=20
> Because with the current fscaps code you actually could end up getting
> different sizes from these two interfaces, as vfs_getxattr_alloc() reads
> the xattr directly from disk but vfs_getxattr() goes through
> cap_inode_getsecurity(), which may do conversion between v2 and v3
> formats which are different sizes.

Yes, that was another source of confusion. It happened that
security.selinux in the disk was without '\0', and the one from
vfs_getxattr() had it (of course the HMAC wouldn't match).

So, basically, you set something in user space and you get something
different.

Example:

# setfattr -n security.selinux -v "unconfined_u:object_r:admin_home_t:s0" t=
est-file

SELinux active:
# getfattr -m - -d -e hex test-file
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a61646d696e=
5f686f6d655f743a733000

Smack active:
# getfattr -m - -d -e hex test-file
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a61646d696e=
5f686f6d655f743a7330


evmctl (will) allow to provide a hex xattr value for fscaps. That
should be the one to be used (and vfs_getxattr_alloc() does that).
However, I guess if the conversion happens, evmctl cannot correctly
verify anymore the file, unless the same string is specified for
verification (otherwise it reads the xattr through vfs_getxattr(),
which would be different).

Roberto


