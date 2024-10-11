Return-Path: <linux-fsdevel+bounces-31694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B037499A2C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DDDD1F24B27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FBA1E7C0E;
	Fri, 11 Oct 2024 11:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB41FC8;
	Fri, 11 Oct 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646506; cv=none; b=VEOy7AXz2oh8/3nNi9xyzQBTUmGoRmZZVLWD/aXF2ZCopzIiEU42K+nvosJFH8K7Gp4Pq8YIOnDCnTXqz5qFLnaDmZODfLdoceGY3NxUpJXZD38p809A3QcsHxFC7wqFmR73PAnVtOBHS5zNTKYwMhRZSNOvwLoxMDtpQxmJ0WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646506; c=relaxed/simple;
	bh=qF9Qqz6fKoWlxDLgBio3Rbg3a3Ff15kVjjXJd+WqbTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3yG3Y+qFZDzZ8tfG2cIzye6DsL/t4DlUQfKkuOG9E8Nht8NkPaHR7CjATXVosmFRwPh1IW22CBUMlZUKb6fleJs9uH/b7nPboZG2rKeEIHa4GON6KEBB817I6LAwqJ0SqDe3bog5CTThMbq1Nq0J7HluufjPJimNjEIplemcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XQ3tf6LTwz9v7J5;
	Fri, 11 Oct 2024 19:14:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 3D70A1401EA;
	Fri, 11 Oct 2024 19:34:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnNS1SDQln_Z2jAg--.16349S2;
	Fri, 11 Oct 2024 12:34:51 +0100 (CET)
Message-ID: <370204a3fbceef1bebfdcfc136beed98a3ca0229.camel@huaweicloud.com>
Subject: Re: [PATCH RFC v1 4/7] integrity: Fix inode numbers in audit records
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Paul Moore
	 <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>
Date: Fri, 11 Oct 2024 13:34:39 +0200
In-Reply-To: <20241011.Eigh6nohChai@digikod.net>
References: <20241010152649.849254-4-mic@digikod.net>
	 <bafd35c50bbcd62ee69e0d3c5f6b112d@paul-moore.com>
	 <20241011.Eigh6nohChai@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnNS1SDQln_Z2jAg--.16349S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kArW8Cw4xKr4ruFy8Xwb_yoW8CF1kpF
	W7tFWvyr1kAFW8CayIqF45uFyS9ayUGr4jgr43Cr10vF9xXrn2gryI9r18Cr98GryUJrWF
	qF1j93sxua1vyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBGcIiXgHcAABsg

On Fri, 2024-10-11 at 12:15 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Thu, Oct 10, 2024 at 09:20:52PM -0400, Paul Moore wrote:
> > On Oct 10, 2024 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:
> > >=20
> > > Use the new inode_get_ino() helper to log the user space's view of
> > > inode's numbers instead of the private kernel values.
> > >=20
> > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > > Cc: Eric Snowberg <eric.snowberg@oracle.com>
> > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > ---
> > >  security/integrity/integrity_audit.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Should we also need to update the inode value used in hmac_add_misc()?
>=20
> I'm not sure what the impact will be wrt backward compatibility. Mimi,
> Roberto?

Changing the inode number the HMAC was calculated with has the
potential effect of making the file inaccessible.

In order to use the new inode number, we need to define a new EVM xattr
type, and update the previous xattr version with the new one. We could
deprecate the old xattr version after a while (to be discussed with
Mimi).

Roberto

> >=20
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/e=
vm/evm_crypto.c
> > index 7c06ffd633d2..68ae454e187f 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -155,7 +155,7 @@ static void hmac_add_misc(struct shash_desc *desc, =
struct inode *inode,
> >          * signatures
> >          */
> >         if (type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
> > -               hmac_misc.ino =3D inode->i_ino;
> > +               hmac_misc.ino =3D inode_get_ino(inode->i_ino);
> >                 hmac_misc.generation =3D inode->i_generation;
> >         }
> >         /* The hmac uid and gid must be encoded in the initial user
> >=20
> > --
> > paul-moore.com


