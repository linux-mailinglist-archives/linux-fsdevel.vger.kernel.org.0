Return-Path: <linux-fsdevel+bounces-48909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38740AB58D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA7863629
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34B32BE0FD;
	Tue, 13 May 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvsJuyhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383B242D77
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150724; cv=none; b=XxHtWjJpF29U8txerDnTx0nkXFUOqDWnleXP4gLva/Bwddt34v3eO3gn593TRHTG5q2g38XiKknwAlvDPdABXEUItOWu3d7gMwyyr91ndLoKhbSEcXNetuIcrhXpWfRCGTQ8y7ATz5SzTBn1p79QgzsG+ImigFmVNkHf1S/1N7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150724; c=relaxed/simple;
	bh=+iXXgL4gr8KPYDv9/e7RFbUo5M19orzShFShoavpw88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PmvqXaPxJAkFUpUaCAbc24nbWjeDLQZwRvmeQibBcYcKRplIMUain54rkvKmNjLD99lnXVQtWeI8e0Zkdbyh5UoQK7lRDDUr38jx1lb8ev5GYwJfVW54e7d5zk6Qj9iTsojAz+wxCXEbQEvKhRlCDCG3ub2yAYIUj60o5xUb1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pvsJuyhn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-48b7747f881so358731cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747150721; x=1747755521; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89y90/kYEAF6o+kMHPOusZlookMeFzeAB2+XdecwNJU=;
        b=pvsJuyhnthP36mpKtFRwOuGdagEFkSpcv5CG9cVRWKoO6+E+AjXyWrAodHH4ZxBUGQ
         VaROaGwfeuDTVcDwXZrwm/kGSlboFRbky06MAHhNerZaNYYosvcfFjxrw5lQ0gsN8hve
         NlRdSKM1qmnkrBnG9R61in2tfCgGkIJQdQ+UNE6/tjgcuilNN0hSnIDbUrzjuZDUrtK/
         jmCK+Nj2daEBFWql6RNWaM9K9hnhHRLFcHSb5yyMzjNvmhO+Ubg2krUh8MP5zmVeiQJ+
         PEt8zzdJ79zrOXUT49wsy2CNY6qIbw3Yf0tJjKUEKmgtLYUNUr8CBr63AAz3QkzrhzMv
         BBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150721; x=1747755521;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89y90/kYEAF6o+kMHPOusZlookMeFzeAB2+XdecwNJU=;
        b=Z1lFWVgFBzLzI7u6J6Pn19YC7sApag7eKEZ36SbUcICXsl4532QwAsIq8wq3xTXaWZ
         PENEr2oPMoaTpUJEXC2dusr/Qzoy14kqviUorE02slV6d7ONbpYWOPXCsNmmkR0MPFDK
         7+hlHtREm1yytwY6S0XPcf37GDQf1bPOEJp4sHyUszftBrqVVMArcB6MYCnGnba+qYpB
         tJIMz0ZTBnxTJvR02k7ApEn4MbCuIh/mD6lkZuRhJIGxAUxKBpHFK9ARO1IVkU2buGZJ
         GkaZWQqYhjQNBZB8lPM3pShfhm+/axjNhCZNB8emo4/KCTh+tKgbJ7lAAecDjj4n8uQl
         ZrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrg76c3j72Ba/jTo9Ub/AvICAG129Pm3Z4xuDHVm6vsxAU6pSd8hrnaFh3Q3CKfU/1IlUvytVOYW3Ompyz@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPupIIg1JIVNj/pdRhJiBwzsVuCgO+SK+dkUbDOTEWWikB4bE
	O4pNgh9xBv2/mjsekkQ+ESAHAAPxK6vBk4yTgZPZidxU0Na/7GP7NfL4G7qxUk44KYve55mkz2n
	oYDxyMlncUBjpmDxN8vOBhMqJ3utUgCL1u44DaMLm
X-Gm-Gg: ASbGncsA/U+DUKBmUE+JEPLomNpuqMMYYYwyAxWTA47FPPq9SMOkotnH4G5/+HhjFy1
	NDlH6ZipxrG2oTEwxzYBLKk2HKFTKG5TywS9OGUNUZGkYZXxiqndKlCKM0TepFEpLWATqgi3ejv
	7Y8Re5p0J1ZBXmsSWBARUuKSCL8MoGiZx2Dyy3s/BqZb2GmOeF81d1ACxYlJhs
X-Google-Smtp-Source: AGHT+IEGe3y7C/3dEYNxkfLLRp1t4I353MK1YI+azNL4dTTRCLF/nBxhIhBEqvLjXbiBNaH44EYUd3wPgMy+iFeei/0=
X-Received: by 2002:ac8:598d:0:b0:466:8c23:823a with SMTP id
 d75a77b69052e-494898efdb9mr3460091cf.17.1747150720836; Tue, 13 May 2025
 08:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <d5d8fc74f02b89d6bec5ae8bc0e36d7853b65cda.1746792520.git.lorenzo.stoakes@oracle.com>
 <bfd5b4co3ha32m7z7fo7rm2uhaqcunn7zqgywonm54wi2iakpb@zogdqwo4722c>
In-Reply-To: <bfd5b4co3ha32m7z7fo7rm2uhaqcunn7zqgywonm54wi2iakpb@zogdqwo4722c>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 May 2025 08:38:28 -0700
X-Gm-Features: AX0GCFu_sNznUsLr1ugO_DiPLuhx2Qpcv2QmJwH3d9RiFtZ1VEMUc2w3eNQQQs0
Message-ID: <CAJuCfpHCZS-goD88VhKU1ovuZbOnQk6aWBHnEPu2HsBxfT+xzQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/vma: remove mmap() retry merge
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 6:25=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250509 08:14]:
> > We have now introduced a mechanism that obviates the need for a reattem=
pted
> > merge via the mmap_prepare() file hook, so eliminate this functionality
> > altogether.
> >
> > The retry merge logic has been the cause of a great deal of complexity =
in
> > the past and required a great deal of careful manoeuvring of code to en=
sure
> > its continued and correct functionality.
> >
> > It has also recently been involved in an issue surrounding maple tree
> > state, which again points to its problematic nature.
> >
> > We make it much easier to reason about mmap() logic by eliminating this=
 and
> > simply writing a VMA once. This also opens the doors to future optimisa=
tion
> > and improvement in the mmap() logic.
> >
> > For any device or file system which encounters unwanted VMA fragmentati=
on
> > as a result of this change (that is, having not implemented .mmap_prepa=
re
> > hooks), the issue is easily resolvable by doing so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
>
> I have a few tests for the vma test suite that would test this path.
> I'll just let them go.
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> > ---
> >  mm/vma.c | 14 --------------
> >  1 file changed, 14 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 3f32e04bb6cc..3ff6cfbe3338 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -24,7 +24,6 @@ struct mmap_state {
> >       void *vm_private_data;
> >
> >       unsigned long charged;
> > -     bool retry_merge;
> >
> >       struct vm_area_struct *prev;
> >       struct vm_area_struct *next;
> > @@ -2417,8 +2416,6 @@ static int __mmap_new_file_vma(struct mmap_state =
*map,
> >                       !(map->flags & VM_MAYWRITE) &&
> >                       (vma->vm_flags & VM_MAYWRITE));
> >
> > -     /* If the flags change (and are mergeable), let's retry later. */
> > -     map->retry_merge =3D vma->vm_flags !=3D map->flags && !(vma->vm_f=
lags & VM_SPECIAL);

Could we have a WARN_ON() here please? I know you took care of in-tree
drivers but if an out-of-tree driver does this there will be no
indication that it has to change its ways. I know we don't care about
out-of-tree ones but they still exist, so maybe we can be nice here
and issue a warning?

> >       map->flags =3D vma->vm_flags;
> >
> >       return 0;
> > @@ -2622,17 +2619,6 @@ static unsigned long __mmap_region(struct file *=
file, unsigned long addr,
> >       if (have_mmap_prepare)
> >               set_vma_user_defined_fields(vma, &map);
> >
> > -     /* If flags changed, we might be able to merge, so try again. */
> > -     if (map.retry_merge) {
> > -             struct vm_area_struct *merged;
> > -             VMG_MMAP_STATE(vmg, &map, vma);
> > -
> > -             vma_iter_config(map.vmi, map.addr, map.end);
> > -             merged =3D vma_merge_existing_range(&vmg);
> > -             if (merged)
> > -                     vma =3D merged;
> > -     }
> > -
> >       __mmap_complete(&map, vma);
> >
> >       return addr;
> > --
> > 2.49.0
> >

