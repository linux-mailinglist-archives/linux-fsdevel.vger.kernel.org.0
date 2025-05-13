Return-Path: <linux-fsdevel+bounces-48907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA21AB58A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990EB17F652
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1E255F26;
	Tue, 13 May 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0p1asKpy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7B1DD0C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150347; cv=none; b=QJhwQI640JR8GvK7HLyKn+bio9/Jo2K//rZ1AaSSGD27O8yAAwYbXRiEmPYxdrFM0cIg0Wgrt97BktynwabEQU2YFvr7YdzqERYQIdyL1QlruZO9an5+9wgaB4Qs9VrwVUcpeY/Yag5U9unF7N/EVLr7c9VTIVnnRxpHXZUMASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150347; c=relaxed/simple;
	bh=MVkr3QWAI/X4Ew1h+MJOSNkV7y4pQmb/XzRFIHYUEwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Fg1AubWxOvEqjuFTU3hiIO4RhHgsiCEFkZydTsOmjrxOSesXg73W52yNoAJBO6Qdi2+j+PG82qpBEzTW0hpv/AbVCZMrSUwdKTuCm4hnyhCp4JbcJgX58VZoOAAnbCpMC9dYbkpiFjxzt8lhZXQgKFj7GgSZLzdM6o7/OQX0gus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0p1asKpy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4774611d40bso348181cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747150345; x=1747755145; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7GIEqlT6VpngqlG/9UDc8Z0jwZJiLiyfG5vtoML09U=;
        b=0p1asKpy0gdYPt8rKvMPBvIYt+hH6T75HDvurqPBy3/dtF7yZbZwHJoHyZ+BqEHhsU
         a8Ud1rJVmsngDQGu0Ng+hnNed2VxboEmjrQqP1LYReloyx2On3/tfWICIbvFdjo1Udxc
         us5claWoM2H/1P3055lzUcDx8qPhcj3tijur8bdAB62FJcEiaGacS5YhjPHHE5rtRr+J
         +sJUSF7wBpWm+4I9iQYnnCufsZrArMcv+BFMxKjUZEEICvrZPTtzmBy8ZUQIZIQxbtXS
         givyRksKCm/nLLSIEPNCqxS/gbzNWtxqk4i90UljK1RRtUSVZevUuO9RDf0AIj8k2HEp
         +/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150345; x=1747755145;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7GIEqlT6VpngqlG/9UDc8Z0jwZJiLiyfG5vtoML09U=;
        b=q/hIFWZfQDEu78RFtqy5svhMqTemTC1VKiNyl785x09CQGy1pzjAcmUuxV/8PvfsyA
         kr7/v7sX+2vZy7LRQu2wmV0gvZPe/JwwCcYAfqNgrv4DRXqacKGgDfHvVY0FIAz6nh5f
         sZUPLA97GeFfk72+GgoCq6IlHH2IROR732K2VFjNh1BZnTmC+J+xgl1MqaSQcKICKA6c
         7IPjh3c5HNkOB4QwTZ5pXudwTBmRv6rhIfOiA/s08hc073RWnOhz8u60s8U2fobEe4Xn
         cjuVbyfUTgoKv1WJ67yrL2kGvtpurpHrIhu+JQb/1FXKGE4EmqUi/NZqvh1lFSSPpwge
         kz7g==
X-Forwarded-Encrypted: i=1; AJvYcCVJfiGTbO+TMgkfzngTbxs5LtPz5EHY0yGO+WwT0DQt2zHs3tyQRCSV+nKZbs3uZYJ9HLj/8kbId2O46lU1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0j8Ojo+mqsfw/1Mo2vKHF2AVfzky3RSNZHYAvUqNaxYRttpqy
	MXrr4tVEV0wPBBzgm0irASNlpdzfDwzZ0tJe3mNrVztFvrnSg4VBOrjzbmsD4Cog+XAEcaa4j9t
	abrkPVu0PAFkGy1kOT99Dsn75OVomh/adB9TJRYbS
X-Gm-Gg: ASbGncuy/IsH1pCgfq5kZXpjCqPvRMgvW54lEOucUZMHmY/mmPoE6fpAzgLS4yGTV4A
	Jd6eO1iWuAaUZ+SAUE2jk1dgU05VpsgUcZOFX3ioU30gd/V0MB2hn+EuKDWM4/ipLRI8R1FquPD
	ATPo8M+90McYed6Z98fAEJ4TFGgAW2CgaRcZYCPvIH/4odH3ehmiSzD5MaKnAX
X-Google-Smtp-Source: AGHT+IGaQOJh2WGLgdgVaUkWCSRwxWI0zOQtCZRpqIPwC1f/xENNQg6z8FkZS2+QDmtcgov4WAX0uJ0FkCBKDw2bCo0=
X-Received: by 2002:ac8:5d93:0:b0:494:58a3:d3e6 with SMTP id
 d75a77b69052e-494880c8030mr4064571cf.26.1747150344392; Tue, 13 May 2025
 08:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <0f758474fa6a30197bdf25ba62f898a69d84eef3.1746792520.git.lorenzo.stoakes@oracle.com>
 <lbykhkt4sjfb2l4mexgnzq7zumauvi5ycxua666ixvxns4w3qp@pgbo2krrtu2d>
In-Reply-To: <lbykhkt4sjfb2l4mexgnzq7zumauvi5ycxua666ixvxns4w3qp@pgbo2krrtu2d>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 May 2025 08:32:11 -0700
X-Gm-Features: AX0GCFuKZoSDkdrM5SwPBVnmxK9uYRCIyU-gKUoqlLzfyT7RC4ZlWav-ftNZMDo
Message-ID: <CAJuCfpFfoPHgUcu_-S4wXVxGpEGgTH_mLpgVO5UhtDG5+L3b2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: secretmem: convert to .mmap_prepare() hook
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 6:23=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250509 08:14]:
> > Secretmem has a simple .mmap() hook which is easily converted to the ne=
w
> > .mmap_prepare() callback.
> >
> > Importantly, it's a rare instance of an driver that manipulates a VMA w=
hich
> > is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting V=
MA
> > flags which may adjust mergeability, meaning the retry merge logic migh=
t
> > impact whether or not the VMA is merged.
> >
> > By using .mmap_prepare() there's no longer any need to retry the merge
> > later as we can simply set the correct flags from the start.
> >
> > This change therefore allows us to remove the retry merge logic in a
> > subsequent commit.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  mm/secretmem.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 1b0a214ee558..589b26c2d553 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode,=
 struct file *file)
> >       return 0;
> >  }
> >
> > -static int secretmem_mmap(struct file *file, struct vm_area_struct *vm=
a)
> > +static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > -     unsigned long len =3D vma->vm_end - vma->vm_start;
> > +     const unsigned long len =3D desc->end - desc->start;
> >
> > -     if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) =3D=3D 0)
> > +     if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) =3D=3D 0)
> >               return -EINVAL;
> >
> > -     if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> > +     if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
> >               return -EAGAIN;
> >
> > -     vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
> > -     vma->vm_ops =3D &secretmem_vm_ops;
> > +     desc->vm_flags |=3D VM_LOCKED | VM_DONTDUMP;
> > +     desc->vm_ops =3D &secretmem_vm_ops;
> >
> >       return 0;
> >  }
> > @@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
> >
> >  static const struct file_operations secretmem_fops =3D {
> >       .release        =3D secretmem_release,
> > -     .mmap           =3D secretmem_mmap,
> > +     .mmap_prepare   =3D secretmem_mmap_prepare,
> >  };
> >
> >  static int secretmem_migrate_folio(struct address_space *mapping,
> > --
> > 2.49.0
> >

