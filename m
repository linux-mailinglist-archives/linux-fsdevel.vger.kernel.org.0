Return-Path: <linux-fsdevel+bounces-253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14F7C846C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67ABE1C210BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6013AE2;
	Fri, 13 Oct 2023 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55311720
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 11:32:43 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF82A9;
	Fri, 13 Oct 2023 04:32:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4S6PDL5vqYz9yxfd;
	Fri, 13 Oct 2023 19:19:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXsJGuKillo+ciAg--.35350S2;
	Fri, 13 Oct 2023 12:32:12 +0100 (CET)
Message-ID: <d0afbd03940e45219852787a1001d8debe48bf09.camel@huaweicloud.com>
Subject: Re: [PATCH v3 25/25] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Stefan Berger <stefanb@linux.ibm.com>, viro@zeniv.linux.org.uk, 
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de,  kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, paul@paul-moore.com,
 jmorris@namei.org,  serge@hallyn.com, dhowells@redhat.com,
 jarkko@kernel.org,  stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 13 Oct 2023 13:31:55 +0200
In-Reply-To: <a0913021426ead2fc5e2a3db013335a67cdd4322.camel@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904134049.1802006-6-roberto.sassu@huaweicloud.com>
	 <82486de4-2917-afb6-2ae3-6ea7f1346dc0@linux.ibm.com>
	 <a0913021426ead2fc5e2a3db013335a67cdd4322.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBXsJGuKillo+ciAg--.35350S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4kWFyDXryUKr1kWw43Awb_yoW5Gr4xpF
	4IgayUJw4DZry0kr4vvFW5urWSg3yjgayUWrn0k3WkZryvvr1YgF45Aryj9FyUGrWxtw10
	qr1jkrW3ZF1DArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj5D80gAAsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-09-15 at 11:39 +0200, Roberto Sassu wrote:
> On Tue, 2023-09-12 at 12:19 -0400, Stefan Berger wrote:
> > On 9/4/23 09:40, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >=20
> > > Before the security field of kernel objects could be shared among LSM=
s with
> > > the LSM stacking feature, IMA and EVM had to rely on an alternative s=
torage
> > > of inode metadata. The association between inode metadata and inode i=
s
> > > maintained through an rbtree.
> > >=20
> > > With the reservation mechanism offered by the LSM infrastructure, the
> > > rbtree is no longer necessary, as each LSM could reserve a space in t=
he
> > > security blob for each inode. Thus, request from the 'integrity' LSM =
a
> > > space in the security blob for the pointer of inode metadata
> > > (integrity_iint_cache structure).
> > >=20
> > > Prefer this to allocating the integrity_iint_cache structure directly=
, as
> > > IMA would require it only for a subset of inodes. Always allocating i=
t
> > > would cause a waste of memory.
> > >=20
> > > Introduce two primitives for getting and setting the pointer of
> > > integrity_iint_cache in the security blob, respectively
> > > integrity_inode_get_iint() and integrity_inode_set_iint(). This would=
 make
> > > the code more understandable, as they directly replace rbtree operati=
ons.
> > >=20
> > > Locking is not needed, as access to inode metadata is not shared, it =
is per
> > > inode.
> > >=20
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > >=20
> > > @@ -145,10 +91,8 @@ static void integrity_inode_free(struct inode *in=
ode)
> > >   	if (!IS_IMA(inode))
> > >   		return;
> >=20
> > I think you can remove this check !IS_IMA()=C2=A0 as well since the nex=
t=20
> > function called here integrity_iint_find() already has this check:
> >=20
> > struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
> > {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_IMA(inode))
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return NULL;
> >=20
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return integrity_inode_get_=
iint(inode);
> > }
>=20
> I agree, thanks!

Actually, I had to keep it otherwise, without a check on iint,
iint_free() can get NULL as argument.

Roberto

> Roberto
>=20
> > >  =20
> > > -	write_lock(&integrity_iint_lock);
> > > -	iint =3D __integrity_iint_find(inode);
> > > -	rb_erase(&iint->rb_node, &integrity_iint_tree);
> > > -	write_unlock(&integrity_iint_lock);
> > > +	iint =3D integrity_iint_find(inode);         <--------------
> > > +	integrity_inode_set_iint(inode, NULL);
> > >  =20
> > >   	iint_free(iint);
> > >   }
>=20


