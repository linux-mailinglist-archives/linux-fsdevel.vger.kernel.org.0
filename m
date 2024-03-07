Return-Path: <linux-fsdevel+bounces-13893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BD8752A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CBB1C233C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B571E865;
	Thu,  7 Mar 2024 15:02:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5E12D754;
	Thu,  7 Mar 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823761; cv=none; b=QQfjogkxYlUzatjvNpI69uPo9lLTBh9wRzbVmsXjnWF5AjQNF7/XJum/5WE6aBdLpi3OWgo+V21HNcfkkYN+ht1kpgurRDCvp9kGhFUuUqvqjjnlHujECgM3d93cnpgIMYHxK7KXoveYTFe2B0e9wzUBGENTOQIBpwWKe8IefRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823761; c=relaxed/simple;
	bh=z3D5M3QBXmwHZtu6oMiapW9tSBhuH61YAr5Zlqn9s4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PStrwxVB4rm58WmrG7RWSOnauZIaalmG5ljOOqkxzK5gL/wLzJRZTtX0Fk+yKrMTGGNX8u8ly62BIB4q5kV4hI2v59aEhBY2oorgZMOcIvaTl+jXB1BphdsAt6Rz55U0X+l6G2Y/P5a8VmyJjhgOFFWNmpiJYkDQ9VpXmKVaZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TrBqG42nzz9xxcx;
	Thu,  7 Mar 2024 22:42:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E38521400D7;
	Thu,  7 Mar 2024 23:02:35 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXCxQA1+llg+XkAw--.4752S2;
	Thu, 07 Mar 2024 16:02:35 +0100 (CET)
Message-ID: <2dbcd57e3905555b5d966c5403c8f94a307f4990.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: Change vfs_getxattr() with __vfs_getxattr() in
 evm_calc_hmac_or_hash()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Seth Forshee <sforshee@kernel.org>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,  stable@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Date: Thu, 07 Mar 2024 16:02:20 +0100
In-Reply-To: <5a08af42118541c87ce0b173d03217c3623adce2.camel@huaweicloud.com>
References: <20240307122240.3560688-1-roberto.sassu@huaweicloud.com>
	 <ZenPtCfh6CyD2xz5@do-x1extreme>
	 <5a08af42118541c87ce0b173d03217c3623adce2.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXCxQA1+llg+XkAw--.4752S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy5Aw1fGw4UAr4DZFy7KFg_yoW8KF45pF
	WYyanFkrn5Xry5C3s5KF4DAayF93yjqrWjkrnFv340v3ZFvrnrZr93Wr13uryF9r1xtwn5
	tw4qqFyavwnxA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5sZvQAAsE

On Thu, 2024-03-07 at 15:36 +0100, Roberto Sassu wrote:
> On Thu, 2024-03-07 at 08:31 -0600, Seth Forshee wrote:
> > On Thu, Mar 07, 2024 at 01:22:39PM +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Use __vfs_getxattr() instead of vfs_getxattr(), in preparation for
> > > deprecating using the vfs_ interfaces for retrieving fscaps.
> > >=20
> > > __vfs_getxattr() is only used for debugging purposes, to check if ker=
nel
> > > space and user space see the same xattr value.
> >=20
> > __vfs_getxattr() won't give you the value as seen by userspace though.
> > Userspace goes through vfs_getxattr() -> xattr_getsecurity() ->
> > cap_inode_getsecurity(), which does the conversion to the value
> > userspace sees. __vfs_getxattr() just gives the raw disk data.
> >=20
> > I'm also currently working on changes to my fscaps series that will mak=
e
> > it so that __vfs_getxattr() also cannot be used to read fscaps xattrs.
> > I'll fix this and other code in EVM which will be broken by that change
> > as part of the next version too.
>=20
> You are right, thank you!

(Apologies, I should have been more careful).

Roberto

> Roberto
>=20
> > >=20
> > > Cc: stable@vger.kernel.org # 5.14.x
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > Fixes: 907a399de7b0 ("evm: Check xattr size discrepancy between kerne=
l and user")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/integrity/evm/evm_crypto.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity=
/evm/evm_crypto.c
> > > index b1ffd4cc0b44..168d98c63513 100644
> > > --- a/security/integrity/evm/evm_crypto.c
> > > +++ b/security/integrity/evm/evm_crypto.c
> > > @@ -278,8 +278,8 @@ static int evm_calc_hmac_or_hash(struct dentry *d=
entry,
> > >  		if (size < 0)
> > >  			continue;
> > > =20
> > > -		user_space_size =3D vfs_getxattr(&nop_mnt_idmap, dentry,
> > > -					       xattr->name, NULL, 0);
> > > +		user_space_size =3D __vfs_getxattr(dentry, inode, xattr->name,
> > > +						 NULL, 0);
> > >  		if (user_space_size !=3D size)
> > >  			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\=
n",
> > >  				 dentry->d_name.name, xattr->name, size,
> > > --=20
> > > 2.34.1
> > >=20


