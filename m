Return-Path: <linux-fsdevel+bounces-50681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26772ACE60D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C9E178707
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AF214813;
	Wed,  4 Jun 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J48ZOjUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B02040B6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071629; cv=none; b=LJ13MqztNb9mEEp9RiRBbmrXrXmK4MQk68RwN4RMqCMAciRn+hGucDEi8Vp/OpNwv0sY9p8tqlewRLuJ6RDCCrLCDZdV0/l+Ym1vUtd6/5XIO52Ao2DpEiZXlqVqyPGdEGpBC9dP//tnDzLTMoSjgDDix5/55AqMbQTttTKpCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071629; c=relaxed/simple;
	bh=sWOJA7v7Ov16Q2lLF9qoja13SWcCS3EU3H+3Y0lbZz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/EnzMbrU9PTrHMY+7D2m1V24z5oEISroJOqheTSAZ2ANdQOVc49oW/j5U9rPiMWIXKPOl4rPV1ZsSjEJyysRtLA7e6sUzuJJudNSZctpjTXaIxVGNMFij1ZPDjAsil9z4djlR/Xe7hEYmgYqtuf1gvmFeKlxBgSthDGEeY50AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J48ZOjUs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e818a57287eso67664276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749071627; x=1749676427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFILvALIoE88+amXnoIecD1FsclDUOa9FdnGICXctS8=;
        b=J48ZOjUs0gsj1gujKn+DBWQnSptDO5yRJ16jdvn4uPtU3S3UZPfZwMAVcfgXv+j/f/
         ALk6LRWyNA+CakxXcVJx2dlmjB41IXZmSRtRRrIdt3oXwPdBWmiebEfcywF6GyZLUdyp
         D2SmzhGHh/zSxeHGLDqdnLJCzGsLrPDfXfrF76pF5ZoyWFO2htuTzJqDCILONYKufjdS
         eXY28de8CiPJiT8ola9UaGLNnJqtpY5M9y/qWPutXkIVXpBjW7s3jNnyc5tAsOw5zY0b
         DN7NeSufe1nUM2cXLlW8koJwvxtNMGRKTJj8hash7GuvLSPcsAYEvd+3a0c8ApvrZegy
         E7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749071627; x=1749676427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFILvALIoE88+amXnoIecD1FsclDUOa9FdnGICXctS8=;
        b=VbC/xAn9EJuOaXfy0vX2ti2uHfO4lDe6AJ/2cJ4siechBGoXWz4+cCJVWDy7xUG5kf
         RjrGbEp4l8QaoPyrCptrDKoNRAiG2HQKG3J4WBzj5dzn2fKCljYbwCGQDUYFj+MtCdAv
         1scMO1GX2TUBM4eKiejoyGvAzq9On55W7wcdkCu3jOn545AN6ZVyZmJ3T6uDeQnRKn+W
         m5Cv9hfB0aqRug+qNEvqX8jAg9PM8HprD2ZX7VLNtBLjcGQ1Ys1B2xJhH/mVRr4UENdU
         TlrJg8PZy38iOXngv4kGYKVn67PmSkbamfYvL0dNKxva9ll2wIJ3QyCU/4JvvU90+zF0
         bP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7uHThpRsvl7QfqlxHgcERRDhz3NCZMbl4YrmjrFiDmvUIHBfoTcIoXRRBG+1Xrr7r/6ZYDMU5fsbxG8dt@vger.kernel.org
X-Gm-Message-State: AOJu0YyzL6qYfLhYZvhi8jY9iFwcJBQBQGJsANFkk++xUzrKlQZovETL
	00FyVWPARiAjwLnrOeFWewdRAe+g/PKkfP06QcfHiQQjP1dKaP9ThtH6XFhwVydW+DUv7BzDH5t
	QhVRQ0Qaqv+CjyhS0ARiUf3aHh8OAisycbfEyBBzp
X-Gm-Gg: ASbGncsxi1Cpv2G/7q2A3Rt7wVyrCaW+xCvDhpTzCTPfytLYyZdc4SMo7qbr9/iUdx/
	FzvkVPLKQJXwvUuDO3OY6yuDGGOcchgIh+4Q0ldBQ1A2nFMhllK8G4BlDwBfd5y0D2LtHwzCXQr
	L+WMVhy6e/IfMHSAlkslAgfQJf4yKlV/eu8ctFf88i9Ho=
X-Google-Smtp-Source: AGHT+IEzd3OT8v9HoRUzTyFAkQerHkAukxjDsy8RjmPaJTovfL79YwQkPcrXXduheAqGSFN+2XKJ11JKw/rxJLleniI=
X-Received: by 2002:a05:6902:100c:b0:e7f:7352:bb31 with SMTP id
 3f1490d57ef6-e8179d82fc0mr6218584276.39.1749071626412; Wed, 04 Jun 2025
 14:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748890962.git.ackerleytng@google.com> <c03fbe18c3ae90fb3fa7c71dc0ee164e6cc12103.1748890962.git.ackerleytng@google.com>
 <aD_8z4pd7JcFkAwX@kernel.org>
In-Reply-To: <aD_8z4pd7JcFkAwX@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Jun 2025 17:13:35 -0400
X-Gm-Features: AX0GCFtyTLCLuG24EDdI8wKdQSrU3K8jUJ6RM6t9O342c2DffUvgfnmfuwj20Jg
Message-ID: <CAHC9VhQczhrVx4YEGbXbAS8FLi0jaV1RB0kb8e4rPsUOXYLqtA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: Provide function that allocates a secure
 anonymous inode
To: Mike Rapoport <rppt@kernel.org>, Ackerley Tng <ackerleytng@google.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:59=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> (added Paul Moore for selinux bits)

Thanks Mike.

I'm adding the LSM and SELinux lists too since there are others that
will be interested as well.

> On Mon, Jun 02, 2025 at 12:17:54PM -0700, Ackerley Tng wrote:
> > The new function, alloc_anon_secure_inode(), returns an inode after
> > running checks in security_inode_init_security_anon().
> >
> > Also refactor secretmem's file creation process to use the new
> > function.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > ---
> >  fs/anon_inodes.c   | 22 ++++++++++++++++------
> >  include/linux/fs.h |  1 +
> >  mm/secretmem.c     |  9 +--------
> >  3 files changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index 583ac81669c2..4c3110378647 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -55,17 +55,20 @@ static struct file_system_type anon_inode_fs_type =
=3D {
> >       .kill_sb        =3D kill_anon_super,
> >  };
> >
> > -static struct inode *anon_inode_make_secure_inode(
> > -     const char *name,
> > -     const struct inode *context_inode)
> > +static struct inode *anon_inode_make_secure_inode(struct super_block *=
s,
> > +             const char *name, const struct inode *context_inode,
> > +             bool fs_internal)
> >  {
> >       struct inode *inode;
> >       int error;
> >
> > -     inode =3D alloc_anon_inode(anon_inode_mnt->mnt_sb);
> > +     inode =3D alloc_anon_inode(s);
> >       if (IS_ERR(inode))
> >               return inode;
> > -     inode->i_flags &=3D ~S_PRIVATE;
> > +
> > +     if (!fs_internal)
> > +             inode->i_flags &=3D ~S_PRIVATE;
> > +
> >       error =3D security_inode_init_security_anon(inode, &QSTR(name),
> >                                                 context_inode);
> >       if (error) {
> > @@ -75,6 +78,12 @@ static struct inode *anon_inode_make_secure_inode(
> >       return inode;
> >  }
> >
> > +struct inode *alloc_anon_secure_inode(struct super_block *s, const cha=
r *name)
> > +{
> > +     return anon_inode_make_secure_inode(s, name, NULL, true);
> > +}
> > +EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
> > +
> >  static struct file *__anon_inode_getfile(const char *name,
> >                                        const struct file_operations *fo=
ps,
> >                                        void *priv, int flags,
> > @@ -88,7 +97,8 @@ static struct file *__anon_inode_getfile(const char *=
name,
> >               return ERR_PTR(-ENOENT);
> >
> >       if (make_inode) {
> > -             inode =3D anon_inode_make_secure_inode(name, context_inod=
e);
> > +             inode =3D anon_inode_make_secure_inode(anon_inode_mnt->mn=
t_sb,
> > +                                                  name, context_inode,=
 false);
> >               if (IS_ERR(inode)) {
> >                       file =3D ERR_CAST(inode);
> >                       goto err;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 016b0fe1536e..0fded2e3c661 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, =
struct address_space *mapping,
> >  extern const struct address_space_operations ram_aops;
> >  extern int always_delete_dentry(const struct dentry *);
> >  extern struct inode *alloc_anon_inode(struct super_block *);
> > +extern struct inode *alloc_anon_secure_inode(struct super_block *, con=
st char *);
> >  extern int simple_nosetlease(struct file *, int, struct file_lease **,=
 void **);
> >  extern const struct dentry_operations simple_dentry_operations;
> >
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 1b0a214ee558..c0e459e58cb6 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigne=
d long flags)
> >       struct file *file;
> >       struct inode *inode;
> >       const char *anon_name =3D "[secretmem]";
> > -     int err;
> >
> > -     inode =3D alloc_anon_inode(secretmem_mnt->mnt_sb);
> > +     inode =3D alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_nam=
e);
> >       if (IS_ERR(inode))
> >               return ERR_CAST(inode);
>
> I don't think we should not hide secretmem and guest_memfd inodes from
> selinux, so clearing S_PRIVATE for them is not needed and you can just dr=
op
> fs_internal parameter in anon_inode_make_secure_inode()

It's especially odd since I don't see any comments or descriptions
about why this is being done.  The secretmem change is concerning as
this is user accessible and marking the inode with S_PRIVATE will
bypass a number of LSM/SELinux access controls, possibly resulting in
a security regression (one would need to dig a bit deeper to see what
is possible with secretmem and which LSM/SELinux code paths would be
affected).

I'm less familiar with guest_memfd, but generally speaking if
userspace can act on the inode/fd then we likely don't want the
S_PRIVATE flag stripped from the anon_inode.

Ackerley can you provide an explanation about why the change in
S_PRIVATE was necessary?

> > -     err =3D security_inode_init_security_anon(inode, &QSTR(anon_name)=
, NULL);
> > -     if (err) {
> > -             file =3D ERR_PTR(err);
> > -             goto err_free_inode;
> > -     }
> > -
> >       file =3D alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
> >                                O_RDWR, &secretmem_fops);
> >       if (IS_ERR(file))
> > --
> > 2.49.0.1204.g71687c7c1d-goog

--=20
paul-moore.com

