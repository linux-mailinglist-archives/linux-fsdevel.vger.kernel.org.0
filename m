Return-Path: <linux-fsdevel+bounces-47374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EABA9CD1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE1C5A232A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C828468B;
	Fri, 25 Apr 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXcYVjQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02126C3AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595182; cv=none; b=WeGoiNmsKxyoi3sMb1v4YC0D5VfFUpZSEkvygYxKrloQ0b7q5JYLNAHpcJlv1F/9vMZlLytaWH1OJOXN2WI9L++t9iS4s1rO0GxgGRtTo9JI8oTYnYg4RYdGV6QzmzPsT4hCM52cY4rqzUEXZQeRxmlroIUb3+brFeMrKZiXYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595182; c=relaxed/simple;
	bh=azphG0LvZMLBQfUOp84PmDRab8XVCOT21CuIpXdnZ78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Vwhi6m7bFdnnIv7YSAIhHyq1eb3IPdIfKK7QMm+3n8v2vVKr9PujvgaXWMUflXRj/3hY9L8mbqZDdS2PtjjFzwREMApcQUuRxkckCbCYXYGYID3LsQ2+mW+92idACqPAODwbGN48qsoc6XVHsNhYlJ45wbEVC5MuzXKLggdWvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXcYVjQt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774611d40bso339471cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745595180; x=1746199980; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP6z3CE+fLIrfWHZmKWlxUhDiYFfaprQFcGgrLTshIA=;
        b=cXcYVjQtEow59hw4yD0zdZKh+ZNeG3XDmG0f5GkSLfkG0FIvOPMt9l4GBPyg/SDHMr
         tDgSPHoYb0CTNfXFYp8qfPH+a/c+lIg5orRvT0tPydZZWdVs1HmAgksZlrn2IGH87A3a
         sJGxYisr95SC0c2U135zuZtwXNzR6/L7OIuUWT1MZKg8+wXHkXkuzX8aqASKwkQwzK6Z
         AWOWSsRD0Q/1vh0sRR5RiUbzUKUQpjcCevo2Ohb05a+4cN13t+glaKU06lKo7Cfv7t/z
         zL2ZdpKwhgDnc6xCu0pqBqghY2DHpBZMO7EIDgYdrFKEShB3SxljOeyoOZOPg3fIuvhX
         9ARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595180; x=1746199980;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP6z3CE+fLIrfWHZmKWlxUhDiYFfaprQFcGgrLTshIA=;
        b=T9UWtebgBJFmscVmh8RWCwGWAcUgJdN+QpusptzyUWtuK6RDpxmBqtMFWLnnxMXDS1
         J9TNThFvO48OtH+O6te/szRkdFSKq7jMXF9vbdXXrKA2lHfbiAmPcfIhJ506gSJO5SYa
         a4xXXWccNfx/aTtfF/T9BlkbbLxQs1trnbnJmLUQ3MpsrvPWq/M8+qDxPJ7Hi1buZwoB
         SZu0Ns2VGvSNTDAx0QPkk7qaQqArsTF/FxwUCvyzBXclNKMuMamLHERXVxxXb5TLyd8i
         7S6u83CSC291s0x09K6LrhUwhONmTGelYNh70G01cHQwsiYTZb4cRfTJINZBNj32+mkk
         9D0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDxuRHgd6j8nysBHcCa1Swb+mEncr9zLROdzEFpJd+AUMsPJ42otVlTolnSR+QyZj+aaii4g0wF96SJJH/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SjXCgy7YCSFj2SClrzb+A1x7F1Bb3JAnGPeWZlwRYu3Vg4iy
	KAsoyyccPWjQN6Dh7lcvRbLnlPyXxmBmzibX7kPyw7uj/2an4Rf4J3/OFOZhsCCU9L8yrDYF5Z9
	6kfFgzzNALQ8jV+XYAeS7eKIgOgdrsAzleCXpFCFsHzWOPjhu8bdlF8s=
X-Gm-Gg: ASbGncu8D8jD0qQ/nFSYzvgBMaN1Lo/1fDYayH2OWp2zYZzSF8668/YTlLvMFftmObW
	zjNL4czKfn1F2e7rcVmE9QIMPIrQf8+wGcQbLFOzvWoX2/pdhZeWDyIDcx95D2ZORu8+2oIciFK
	lXhppEgYygjwmktpeoJlTd
X-Google-Smtp-Source: AGHT+IGI+8KofZYr/rnLzwwlH5lcjuihGFz+/pVqSeDJMF8TV6u79oDolvsETvevEUoiykM1utbOMi84hjY6taQXhiM=
X-Received: by 2002:a05:622a:2517:b0:477:c4f:ee58 with SMTP id
 d75a77b69052e-47fe1ed5f87mr4183671cf.24.1745595179801; Fri, 25 Apr 2025
 08:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org> <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
 <n6lrbjs4o6luzl3fydpo4frj35q6kvoz74mhlyae5gp7t5loyy@ubmfmzwfhnwq>
In-Reply-To: <n6lrbjs4o6luzl3fydpo4frj35q6kvoz74mhlyae5gp7t5loyy@ubmfmzwfhnwq>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Apr 2025 08:32:48 -0700
X-Gm-Features: ATxdqUH-7fcjY1Nm52E2GQYuVXFxGwTyQxbInQgwFOhzX15Q8W5Vpu5wImOKUvg
Message-ID: <CAJuCfpErtLvktCsbFSGmrT_zir9z0g+uuVvhr=QEitA7ARkdkw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in mm
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 6:55=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:40]:
> > On Thu, Apr 24, 2025 at 08:15:26PM -0700, Kees Cook wrote:
> > >
> > >
> > > On April 24, 2025 2:15:27 PM PDT, Lorenzo Stoakes <lorenzo.stoakes@or=
acle.com> wrote:
> > > >+static void vm_area_init_from(const struct vm_area_struct *src,
> > > >+                        struct vm_area_struct *dest)
> > > >+{
> > > >+  dest->vm_mm =3D src->vm_mm;
> > > >+  dest->vm_ops =3D src->vm_ops;
> > > >+  dest->vm_start =3D src->vm_start;
> > > >+  dest->vm_end =3D src->vm_end;
> > > >+  dest->anon_vma =3D src->anon_vma;
> > > >+  dest->vm_pgoff =3D src->vm_pgoff;
> > > >+  dest->vm_file =3D src->vm_file;
> > > >+  dest->vm_private_data =3D src->vm_private_data;
> > > >+  vm_flags_init(dest, src->vm_flags);
> > > >+  memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > > >+         sizeof(dest->vm_page_prot));
> > > >+  /*
> > > >+   * src->shared.rb may be modified concurrently when called from
> > > >+   * dup_mmap(), but the clone will reinitialize it.
> > > >+   */
> > > >+  data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared=
)));
> > > >+  memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > > >+         sizeof(dest->vm_userfaultfd_ctx));
> > > >+#ifdef CONFIG_ANON_VMA_NAME
> > > >+  dest->anon_name =3D src->anon_name;
> > > >+#endif
> > > >+#ifdef CONFIG_SWAP
> > > >+  memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > > >+         sizeof(dest->swap_readahead_info));
> > > >+#endif
> > > >+#ifdef CONFIG_NUMA
> > > >+  dest->vm_policy =3D src->vm_policy;
> > > >+#endif
> > > >+}
> > >
> > > I know you're doing a big cut/paste here, but why in the world is thi=
s function written this way? Why not just:
> > >
> > > *dest =3D *src;
> > >
> > > And then do any one-off cleanups?
> >
> > Yup I find it odd, and error prone to be honest. We'll end up with unin=
itialised
> > state for some fields if we miss them here, seems unwise...
> >
> > Presumably for performance?
> >
> > This is, as you say, me simply propagating what exists, but I do wonder=
.
>
> Two things come to mind:
>
> 1. How ctors are done.  (v3 of Suren's RCU safe patch series, willy made
> a comment.. I think)
>
> 2. Some race that Vlastimil came up with the copy and the RCU safeness.
> IIRC it had to do with the ordering of the setting of things?
>
> Also, looking at it again...
>
> How is it safe to do dest->anon_name =3D src->anon_name?  Isn't that ref
> counted?

dest->anon_name =3D src->anon_name is fine here because right after
vm_area_init_from() we call dup_anon_vma_name() which will bump up the
refcount. I don't recall why this is done this way but now looking at
it I wonder if I could call dup_anon_vma_name() directly instead of
this assignment. Might be just an overlooked legacy from the time we
memcpy'd the entire structure. I'll need to double-check.

>
> Pretty sure it's okay, but Suren would know for sure on all of this.
>
> Suren, maybe you could send a patch with comments on this stuff?

Yeah, I think I need to add some comments in this code for
clarification. We do not copy the entire vm_area_struct because we
have to preserve vma->vm_refcnt field of the dest vma. Since these
structures are allocated from a cache with SLAB_TYPESAFE_BY_RCU,
another thread might be concurrently checking the state of the dest
object by reading dest->vm_refcnt. Therefore it's important here not
to override the vm_refcnt. Changelog in
https://lore.kernel.org/all/20250213224655.1680278-18-surenb@google.com/
touches on it but a comment in the code would be indeed helpful. Will
add it but will wait for Lorenzo's refactoring to land into linux-mm
first to avoid adding merge conflicts.

>
> Thanks,
> Liam

