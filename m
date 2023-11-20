Return-Path: <linux-fsdevel+bounces-3192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B557F0D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 09:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10931F21BCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61E5F4FB;
	Mon, 20 Nov 2023 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E9EE3;
	Mon, 20 Nov 2023 00:16:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SYg0Z1Pc1z9v7GV;
	Mon, 20 Nov 2023 16:00:14 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDHxV_LFVtlN1ABAQ--.398S2;
	Mon, 20 Nov 2023 09:16:26 +0100 (CET)
Message-ID: <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob  for integrity_iint_cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com,  dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com,  eparis@parisplace.org,
 casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 20 Nov 2023 09:16:09 +0100
In-Reply-To: <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
	 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDHxV_LFVtlN1ABAQ--.398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17Kw1kuFWrWr45ur1kGrg_yoWrJr43pF
	W3Ka47Jr1kXFyI9rn2vF45uFWSgFWSgFWUGwn0kr1kAF98ur1Ygr15CryUuFyUGr98tw10
	qr1a9ryUZ3Wqy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5ahSwACsN
X-CFilter-Loop: Reflected

On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > Before the security field of kernel objects could be shared among LSMs =
with
> > the LSM stacking feature, IMA and EVM had to rely on an alternative sto=
rage
> > of inode metadata. The association between inode metadata and inode is
> > maintained through an rbtree.
> >=20
> > Because of this alternative storage mechanism, there was no need to use
> > disjoint inode metadata, so IMA and EVM today still share them.
> >=20
> > With the reservation mechanism offered by the LSM infrastructure, the
> > rbtree is no longer necessary, as each LSM could reserve a space in the
> > security blob for each inode. However, since IMA and EVM share the
> > inode metadata, they cannot directly reserve the space for them.
> >=20
> > Instead, request from the 'integrity' LSM a space in the security blob =
for
> > the pointer of inode metadata (integrity_iint_cache structure). The oth=
er
> > reason for keeping the 'integrity' LSM is to preserve the original orde=
ring
> > of IMA and EVM functions as when they were hardcoded.
> >=20
> > Prefer reserving space for a pointer to allocating the integrity_iint_c=
ache
> > structure directly, as IMA would require it only for a subset of inodes=
.
> > Always allocating it would cause a waste of memory.
> >=20
> > Introduce two primitives for getting and setting the pointer of
> > integrity_iint_cache in the security blob, respectively
> > integrity_inode_get_iint() and integrity_inode_set_iint(). This would m=
ake
> > the code more understandable, as they directly replace rbtree operation=
s.
> >=20
> > Locking is not needed, as access to inode metadata is not shared, it is=
 per
> > inode.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/iint.c      | 71 +++++-----------------------------
> >  security/integrity/integrity.h | 20 +++++++++-
> >  2 files changed, 29 insertions(+), 62 deletions(-)
> >=20
> > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > index 882fde2a2607..a5edd3c70784 100644
> > --- a/security/integrity/iint.c
> > +++ b/security/integrity/iint.c
> > @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
> >  	return 0;
> >  }
> > =20
> > +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init =3D {
> > +	.lbs_inode =3D sizeof(struct integrity_iint_cache *),
> > +};
>=20
> I'll admit that I'm likely missing an important detail, but is there
> a reason why you couldn't stash the integrity_iint_cache struct
> directly in the inode's security blob instead of the pointer?  For
> example:
>=20
>   struct lsm_blob_sizes ... =3D {
>     .lbs_inode =3D sizeof(struct integrity_iint_cache),
>   };
>=20
>   struct integrity_iint_cache *integrity_inode_get(inode)
>   {
>     if (unlikely(!inode->isecurity))
>       return NULL;
>     return inode->i_security + integrity_blob_sizes.lbs_inode;
>   }

It would increase memory occupation. Sometimes the IMA policy
encompasses a small subset of the inodes. Allocating the full
integrity_iint_cache would be a waste of memory, I guess?

On the other hand... (did not think fully about that) if we embed the
full structure in the security blob, we already have a mutex available
to use, and we don't need to take the inode lock (?).

I'm fully convinced that we can improve the implementation
significantly. I just was really hoping to go step by step and not
accumulating improvements as dependency for moving IMA and EVM to the
LSM infrastructure.

Thanks

Roberto


