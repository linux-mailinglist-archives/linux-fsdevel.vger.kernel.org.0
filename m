Return-Path: <linux-fsdevel+bounces-22529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4578918793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94EC1C20B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9018FDAF;
	Wed, 26 Jun 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6l8TT9s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130818F2FB;
	Wed, 26 Jun 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419887; cv=none; b=uO4dkncKV/Y3UGaenTP7iFBb+kwd53/u3zAN5nmxdPbZLFtunRmjlFsbEkaNYY+YH/C1tuLRm1+Tw4eCaIFA7Ln5yLih/x+PkIXag+0DmJvm/jdq4s4EvYb2Cy0OsWb0H6W40nNnCRWevhtup1rbk4wkTaNm8NqaBIufIxJiSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419887; c=relaxed/simple;
	bh=D5bsgMqcxyy9HsQelD1iHSDm63I58pj/lwTBUEZFWmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rOiTuuK5gKH8W4GVW7sG3jlmVzjttIJ/tywK29AeQWSzq1tIPmnmuj54p8px6013c693AlSt6ztCsYVaIWQb1yyMQ065ov659tlgwV69CigIHBk0OBZKdN0zrw9BHbhKz7qGVovP6m5KAndEaReqBwq6RVU0Gbhkn5ajF5MeiOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6l8TT9s; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c21baf815dso915621eaf.1;
        Wed, 26 Jun 2024 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719419884; x=1720024684; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cVIcPPhEBUXqRMcxG1yeOT4hiCfThHRsp+pkbaR8/k=;
        b=m6l8TT9skNexueXSn1csotCE083bYYCN3ez4e43ZSI7s69YYrxD4i+Vi6PgXcKtsWZ
         5wuv31zBQivfdBEMjURHv+XJSZh9fwYLpPJbsL/hi5Q/iHpfePa0G4zIlGRuXbEujOuV
         0Lr/Ut/Ck6waCEiJSgnmKfr4pY/OOByVqMmJ6tF23Kot8xUInv2OPXCveNy4urTML5Jy
         llhZsPZ/PJNnYAE0qWZgT4F332o/v2JxHC/QH5Kx/MRat5ls2ICLGipw6KmONfUULIv9
         MPd/qWMi0BO7PJw18c7yQqiWEjTWKwi63CHVWtf4awJ40EJVPwVb9zD7jC82yNUOG8p9
         hJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419884; x=1720024684;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cVIcPPhEBUXqRMcxG1yeOT4hiCfThHRsp+pkbaR8/k=;
        b=AJRRusgiAYySP5BZ/AQCp9HUrp//ldWS0JCIOKZlj2XRcZjH2SkLXUNXCKkcFuBL7r
         Ow1K/B8Q6d+0xlPip3JkUuEdcE/gZzO1Dbchq4LRnt97i31yGsA8/teq5D7dErUPS5iV
         oNmey+VTDNjmPY6ab/6o03UPFZu6p3ZU0cB2FOCk0gsZCs0FOWsKhYQXU9sn6Pksap/9
         hUi5X1oPYd2FYUd/O+BAafrn31+cyd/8RetW1sQb8rDPqNZPXb09JoTw9Tnt9ms6zx7K
         9JVwq+k5kxQhFUws5rcmu67nFk5xaibq+MPF/bdZwsqWswLHNjg/4ePE9i2uYvsfXfkd
         OPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+GgZxVfUH8YOdg04iaE20DWg6FuCrcwk0VyM6rRFPe3wD5ACWVhzlLJWA0cq+pr/EBUaAJf2WJTGPptlkD5+Gs+jU4GSQjToNBOvI1c95dV7j78pt2CuTgUir6HBsg101HwMWKFTumZH999Lf9tVl7JsOUJs7l3iAu2G6v9mRqw==
X-Gm-Message-State: AOJu0YxIjpYPs2kdZ7OFTiTqfW0/Q3imyTVivH8pTDQwLOEpdge5iKnP
	uZi6S1VfobiF0vCOB5o6kZGKNYXcAeHN3wZMGicb1ljYY8lfnSWkQwXerfdW2skYUwwwaFDd6x3
	t6drT4/9dUegWmwLZD2uky7TQD8k=
X-Google-Smtp-Source: AGHT+IHuBq5hOd4/sH4F3EqjcgWE0azLRGW9R1NFwiXC36XTHUOyVWiNVokhWGI3FOhlNhfWMoV0QGG2Ek9o51kOgRM=
X-Received: by 2002:a05:6358:885:b0:1a2:11a9:cba with SMTP id
 e5c5f4694b2df-1a23fb90e10mr1357551355d.12.1719419884411; Wed, 26 Jun 2024
 09:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618224527.3685213-1-andrii@kernel.org> <20240618224527.3685213-3-andrii@kernel.org>
 <dqa4q42iy3yyzagm2fdvxqdlwbn5pc7uf5gizbdsvrsbcjglpo@s67nv7kam5a7>
In-Reply-To: <dqa4q42iy3yyzagm2fdvxqdlwbn5pc7uf5gizbdsvrsbcjglpo@s67nv7kam5a7>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 09:37:52 -0700
Message-ID: <CAEf4BzZ9G9aek7u7Tr=307h8eK4v98LGZVsm5Eqz_4jpsEaiag@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] fs/procfs: implement efficient VMA querying API
 for /proc/<pid>/maps
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 7:42=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii@kernel.org> [240618 18:45]:
> ...
>
> > +
> > +static int do_procmap_query(struct proc_maps_private *priv, void __use=
r *uarg)
> > +{
> > +     struct procmap_query karg;
> > +     struct vm_area_struct *vma;
> > +     struct mm_struct *mm;
> > +     const char *name =3D NULL;
> > +     char *name_buf =3D NULL;
> > +     __u64 usize;
> > +     int err;
> > +
> > +     if (copy_from_user(&usize, (void __user *)uarg, sizeof(usize)))
> > +             return -EFAULT;
> > +     /* argument struct can never be that large, reject abuse */
> > +     if (usize > PAGE_SIZE)
> > +             return -E2BIG;
> > +     /* argument struct should have at least query_flags and query_add=
r fields */
> > +     if (usize < offsetofend(struct procmap_query, query_addr))
> > +             return -EINVAL;
> > +     err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, usize);
> > +     if (err)
> > +             return err;
> > +
> > +     /* reject unknown flags */
> > +     if (karg.query_flags & ~PROCMAP_QUERY_VALID_FLAGS_MASK)
> > +             return -EINVAL;
> > +     /* either both buffer address and size are set, or both should be=
 zero */
> > +     if (!!karg.vma_name_size !=3D !!karg.vma_name_addr)
> > +             return -EINVAL;
> > +
> > +     mm =3D priv->mm;
> > +     if (!mm || !mmget_not_zero(mm))
> > +             return -ESRCH;
> > +
> > +     err =3D query_vma_setup(mm);
> > +     if (err) {
> > +             mmput(mm);
> > +             return err;
> > +     }
> > +
> > +     vma =3D query_matching_vma(mm, karg.query_addr, karg.query_flags)=
;
> > +     if (IS_ERR(vma)) {
> > +             err =3D PTR_ERR(vma);
> > +             vma =3D NULL;
> > +             goto out;
> > +     }
> > +
> > +     karg.vma_start =3D vma->vm_start;
> > +     karg.vma_end =3D vma->vm_end;
> > +
> > +     karg.vma_flags =3D 0;
> > +     if (vma->vm_flags & VM_READ)
> > +             karg.vma_flags |=3D PROCMAP_QUERY_VMA_READABLE;
> > +     if (vma->vm_flags & VM_WRITE)
> > +             karg.vma_flags |=3D PROCMAP_QUERY_VMA_WRITABLE;
> > +     if (vma->vm_flags & VM_EXEC)
> > +             karg.vma_flags |=3D PROCMAP_QUERY_VMA_EXECUTABLE;
> > +     if (vma->vm_flags & VM_MAYSHARE)
> > +             karg.vma_flags |=3D PROCMAP_QUERY_VMA_SHARED;
> > +
> > +     karg.vma_page_size =3D vma_kernel_pagesize(vma);
> > +
> ...
>
> > +/*
> > + * Input/output argument structured passed into ioctl() call. It can b=
e used
> > + * to query a set of VMAs (Virtual Memory Areas) of a process.
> > + *
> > + * Each field can be one of three kinds, marked in a short comment to =
the
> > + * right of the field:
> > + *   - "in", input argument, user has to provide this value, kernel do=
esn't modify it;
> > + *   - "out", output argument, kernel sets this field with VMA data;
> > + *   - "in/out", input and output argument; user provides initial valu=
e (used
> > + *     to specify maximum allowable buffer size), and kernel sets it t=
o actual
> > + *     amount of data written (or zero, if there is no data).
> > + *
> > + * If matching VMA is found (according to criterias specified by
> > + * query_addr/query_flags, all the out fields are filled out, and ioct=
l()
> > + * returns 0. If there is no matching VMA, -ENOENT will be returned.
> > + * In case of any other error, negative error code other than -ENOENT =
is
> > + * returned.
> > + *
> > + * Most of the data is similar to the one returned as text in /proc/<p=
id>/maps
> > + * file, but procmap_query provides more querying flexibility. There a=
re no
> > + * consistency guarantees between subsequent ioctl() calls, but data r=
eturned
> > + * for matched VMA is self-consistent.
> > + */
> > +struct procmap_query {
> > +     /* Query struct size, for backwards/forward compatibility */
> > +     __u64 size;
> > +     /*
> > +      * Query flags, a combination of enum procmap_query_flags values.
> > +      * Defines query filtering and behavior, see enum procmap_query_f=
lags.
> > +      *
> > +      * Input argument, provided by user. Kernel doesn't modify it.
> > +      */
> > +     __u64 query_flags;              /* in */
> > +     /*
> > +      * Query address. By default, VMA that covers this address will
> > +      * be looked up. PROCMAP_QUERY_* flags above modify this default
> > +      * behavior further.
> > +      *
> > +      * Input argument, provided by user. Kernel doesn't modify it.
> > +      */
> > +     __u64 query_addr;               /* in */
> > +     /* VMA starting (inclusive) and ending (exclusive) address, if VM=
A is found. */
> > +     __u64 vma_start;                /* out */
> > +     __u64 vma_end;                  /* out */
> > +     /* VMA permissions flags. A combination of PROCMAP_QUERY_VMA_* fl=
ags. */
> > +     __u64 vma_flags;                /* out */
> > +     /* VMA backing page size granularity. */
> > +     __u32 vma_page_size;            /* out */
>
> The vma_kernel_pagesize() returns an unsigned long.  We could
> potentially be truncating the returned value (although probably not
> today?).  This is from the vm_operations_struct pagesize, which also
> returns an unsigned long.  Could we switch this to __u64?
>

Yep, fair point. It seemed excessive to use u64, but I guess nothing
prevents us (in the future) from having humongous pages with >4GB
sizes. I'll update to __u64.

I'll wait for a few more hours just in case I get some other feedback,
and will rebase and post a new revision later today, thanks.


> ...
>
> Thanks,
> Liam

