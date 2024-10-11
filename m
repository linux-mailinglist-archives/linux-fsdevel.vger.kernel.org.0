Return-Path: <linux-fsdevel+bounces-31705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8F99A428
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C271F22FC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A7218584;
	Fri, 11 Oct 2024 12:45:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FD16426;
	Fri, 11 Oct 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650738; cv=none; b=FsMLsyfAcrdlt/6Fy78j1EaBgFAHWUghT2D4txf9/EPYm0oI8ONf4AI/PB9RFobWcU4izgCpFpOiMSUKHt/i4QGIHmzNeDQP58U8i56X5tPgU266AHR5CLzvl4ASYimEAd8FM0Qt8ykOfEzy1YSceaxVAj5huLuwr5FVFiN+ZWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650738; c=relaxed/simple;
	bh=YmqieO68lUe1LJVJMd7J+HmJq8IUKElH45znFPQc098=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NjzpoUlC5Q6YPlrxeTu2ZOOkkgrPLFTNI61MIakY1Gv5USFxH7IWsZPjMkVTpZtXg3ZMQ0cRcRNmCW2x+iG5Rc4g8SUaqij8/Bxal6mRxGIPkGEbZeqsneRGJeMAHqu2JdoUkxGdUv8TbXpvqqYtmgLgVUecuNrvZxB8Ye+4m0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQ5Rz48sxz9v7Hv;
	Fri, 11 Oct 2024 20:25:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 9AA76140132;
	Fri, 11 Oct 2024 20:45:25 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwA3mMjcHQlnAnaqAg--.11911S2;
	Fri, 11 Oct 2024 13:45:24 +0100 (CET)
Message-ID: <bb67b4e9c58988f81fc37950f5227a0f33e216e7.camel@huaweicloud.com>
Subject: Re: [PATCH RFC v1 4/7] integrity: Fix inode numbers in audit records
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, Christian Brauner
 <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org,  linux-security-module@vger.kernel.org,
 audit@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>
Date: Fri, 11 Oct 2024 14:45:12 +0200
In-Reply-To: <20241011.upah1Ek3faiB@digikod.net>
References: <20241010152649.849254-4-mic@digikod.net>
	 <bafd35c50bbcd62ee69e0d3c5f6b112d@paul-moore.com>
	 <20241011.Eigh6nohChai@digikod.net>
	 <370204a3fbceef1bebfdcfc136beed98a3ca0229.camel@huaweicloud.com>
	 <20241011.upah1Ek3faiB@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwA3mMjcHQlnAnaqAg--.11911S2
X-Coremail-Antispam: 1UD129KBjvPXoW5Gry3Ar4xCw4rGr1rZr43p5X_Xry8GoWfAw
	1Ska1xKr1rGFsYka4xJFWfuan3Jr45JrWFvF4UGa42q3yjkayUCrW8GF4aqr15Jr18W34U
	Aa90vFykt3Z5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3AaLa
	J3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAv
	wI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67
	xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14
	v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBGcIiXgIYwAAs9

On Fri, 2024-10-11 at 14:38 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Oct 11, 2024 at 01:34:39PM +0200, Roberto Sassu wrote:
> > On Fri, 2024-10-11 at 12:15 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Thu, Oct 10, 2024 at 09:20:52PM -0400, Paul Moore wrote:
> > > > On Oct 10, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=
=3D <mic@digikod.net> wrote:
> > > > >=20
> > > > > Use the new inode_get_ino() helper to log the user space's view o=
f
> > > > > inode's numbers instead of the private kernel values.
> > > > >=20
> > > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > > > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > ---
> > > > >  security/integrity/integrity_audit.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > Should we also need to update the inode value used in hmac_add_misc=
()?
> > >=20
> > > I'm not sure what the impact will be wrt backward compatibility. Mimi=
,
> > > Roberto?
> >=20
> > Changing the inode number the HMAC was calculated with has the
> > potential effect of making the file inaccessible.
> >=20
> > In order to use the new inode number, we need to define a new EVM xattr
> > type, and update the previous xattr version with the new one. We could
> > deprecate the old xattr version after a while (to be discussed with
> > Mimi).
>=20
> That was my though.  I don't we should patch hmac_add_misc() because it
> is already in the IMA/EVM ABI and not directly reflected to user space.
> The issue might be that user space cannot recreate this hmac because
> this private inode number is not known to user space, but I don't know
> if there is such user space implementation of IMA/EVM.

EVM will recalculate the HMAC of the file metadata based on the new
inode number, and will conclude that metadata was corrupted (same as if
someone modified a protected xattr during an offline attack).

Roberto

> >=20
> > Roberto
> >=20
> > > >=20
> > > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integri=
ty/evm/evm_crypto.c
> > > > index 7c06ffd633d2..68ae454e187f 100644
> > > > --- a/security/integrity/evm/evm_crypto.c
> > > > +++ b/security/integrity/evm/evm_crypto.c
> > > > @@ -155,7 +155,7 @@ static void hmac_add_misc(struct shash_desc *de=
sc, struct inode *inode,
> > > >          * signatures
> > > >          */
> > > >         if (type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
> > > > -               hmac_misc.ino =3D inode->i_ino;
> > > > +               hmac_misc.ino =3D inode_get_ino(inode->i_ino);
> > > >                 hmac_misc.generation =3D inode->i_generation;
> > > >         }
> > > >         /* The hmac uid and gid must be encoded in the initial user
> > > >=20
> > > > --
> > > > paul-moore.com
> >=20
> >=20


