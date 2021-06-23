Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4003B13E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWGYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 02:24:02 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17251 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhFWGYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 02:24:01 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 02:24:01 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1624428374; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=FvwY4Amtbar2mVeWBKKfsiNg34jD7iLLLk+xu8nU9h+gSb1FlePD+poygQxs+zkOquxWfa3PF020TJn9uIdR2Eg1nGnEdd4J6qrh8C+d2RtJ17o3MkfM/dXqvDfAMOZUzulSN80ZJ/BfqG5z/p/8pv8mripcxfwLxueTlwQI1Eg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1624428374; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=LmqJlpoAuCfKzT2jfsIzXSh49imf5u7A6jt8fvymJag=; 
        b=an6OibPcmLXkoVHvoZ6M/y6b15xxwlmUBrkzNoTAJy4+xdnrKBEhGET8tmD2LRrFeb6D7MDVgi8iaq10yv8NdiLkncJys/tSjLKtms6cpAqBM8iHbKLPBjVw2sDttP+c1gE8u6vSXST+RnWAVws7zLU0e5QZfhWJ7VeridE3mug=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1624428374;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=LmqJlpoAuCfKzT2jfsIzXSh49imf5u7A6jt8fvymJag=;
        b=ZpNtt9lSKyrpbV47zI4soCxHIP7ioF4V1vPuuIAhSyU/IB3hX6QWNV1zCa/bYTiS
        p5/lfOSDp2zodxMRSyE4W493/x4pew+CAvXnZcSIQy8hUS9EHh4qP4LYsgR3t9UqULA
        n0UBUsr9+GJ6+UfRZNmJXAw4DenwXEhZsN6j35us=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1624428373723219.8140028881793; Wed, 23 Jun 2021 14:06:13 +0800 (CST)
Date:   Wed, 23 Jun 2021 14:06:13 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-mm" <linux-mm@kvack.org>,
        =?UTF-8?Q?=22Christian_K=C3=B6nig=22?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>
Message-ID: <17a3779e6d8.10898dfd28835.4753809433352490949@mykernel.net>
In-Reply-To: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com>
References: <YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:[PATCH]_ovl:_fix_mmap_denywrite?=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-06-22 20:30:04 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > Overlayfs did not honor positive i_writecount on realfile for VM_DENYWRI=
TE
 > mappings.  Similarly negative i_mmap_writable counts were ignored for
 > VM_SHARED mappings.
 >=20
 > Fix by making vma_set_file() switch the temporary counts obtained and
 > released by mmap_region().
 >=20
 > Reported-by: Chengguang Xu <cgxu519@mykernel.net>
 > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
 > ---
 >  fs/overlayfs/file.c |    4 +++-
 >  include/linux/mm.h  |    1 +
 >  mm/mmap.c           |    2 +-
 >  mm/util.c           |   38 +++++++++++++++++++++++++++++++++++++-
 >  4 files changed, 42 insertions(+), 3 deletions(-)
 >=20
 > --- a/fs/overlayfs/file.c
 > +++ b/fs/overlayfs/file.c
 > @@ -430,7 +430,9 @@ static int ovl_mmap(struct file *file, s
 >      if (WARN_ON(file !=3D vma->vm_file))
 >          return -EIO;
 > =20
 > -    vma_set_file(vma, realfile);
 > +    ret =3D vma_set_file_checkwrite(vma, realfile);
 > +    if (ret)
 > +        return ret;

I'm afraid that it may affect other overlayfs instances which share lower l=
ayers(no upper),
so could we just check those permissions for upper layer?



 > =20
 >      old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
 >      ret =3D call_mmap(vma->vm_file, vma);
 > --- a/include/linux/mm.h
 > +++ b/include/linux/mm.h
 > @@ -2751,6 +2751,7 @@ static inline void vma_set_page_prot(str
 >  #endif
 > =20
 >  void vma_set_file(struct vm_area_struct *vma, struct file *file);
 > +int vma_set_file_checkwrite(struct vm_area_struct *vma, struct file *fi=
le);
 > =20
 >  #ifdef CONFIG_NUMA_BALANCING
 >  unsigned long change_prot_numa(struct vm_area_struct *vma,
 > --- a/mm/mmap.c
 > +++ b/mm/mmap.c
 > @@ -1809,6 +1809,7 @@ unsigned long mmap_region(struct file *f
 >           */
 >          vma->vm_file =3D get_file(file);
 >          error =3D call_mmap(file, vma);
 > +        file =3D vma->vm_file;


I'm not sure the behavior of changing vma_file is always safe for vma mergi=
ng case.
In vma merging case, before go to tag 'unmap_writable' the reference of vma=
->vm_file will be released by fput().
For overlayfs, it probably safe because overlayfs file will get another ref=
erence for lower/upper file.



Thanks,
Chengguang Xu




 >          if (error)
 >              goto unmap_and_free_vma;
 > =20
 > @@ -1870,7 +1871,6 @@ unsigned long mmap_region(struct file *f
 >          if (vm_flags & VM_DENYWRITE)
 >              allow_write_access(file);
 >      }
 > -    file =3D vma->vm_file;
 >  out:
 >      perf_event_mmap(vma);
 > =20
 > --- a/mm/util.c
 > +++ b/mm/util.c
 > @@ -314,12 +314,48 @@ int vma_is_stack_for_current(struct vm_a
 >  /*
 >   * Change backing file, only valid to use during initial VMA setup.
 >   */
 > -void vma_set_file(struct vm_area_struct *vma, struct file *file)
 > +int vma_set_file_checkwrite(struct vm_area_struct *vma, struct file *fi=
le)
 >  {
 > +    vm_flags_t vm_flags =3D vma->vm_flags;
 > +    int err =3D 0;
 > +
 >      /* Changing an anonymous vma with this is illegal */
 >      get_file(file);
 > +
 > +    /* Get temporary denial counts on replacement */
 > +    if (vm_flags & VM_DENYWRITE) {
 > +        err =3D deny_write_access(file);
 > +        if (err)
 > +            goto out_put;
 > +    }
 > +    if (vm_flags & VM_SHARED) {
 > +        err =3D mapping_map_writable(file->f_mapping);
 > +        if (err)
 > +            goto out_allow;
 > +    }
 > +
 >      swap(vma->vm_file, file);
 > +
 > +    /* Undo temporary denial counts on replaced */
 > +    if (vm_flags & VM_SHARED)
 > +        mapping_unmap_writable(file->f_mapping);
 > +out_allow:
 > +    if (vm_flags & VM_DENYWRITE)
 > +        allow_write_access(file);
 > +out_put:
 >      fput(file);
 > +    return err;
 > +}
 > +EXPORT_SYMBOL(vma_set_file_checkwrite);
 > +
 > +/*
 > + * Change backing file, only valid to use during initial VMA setup.
 > + */
 > +void vma_set_file(struct vm_area_struct *vma, struct file *file)
 > +{
 > +    int err =3D vma_set_file_checkwrite(vma, file);
 > +
 > +    WARN_ON_ONCE(err);
 >  }
 >  EXPORT_SYMBOL(vma_set_file);
 > =20
 >=20
 >=20
 >=20
