Return-Path: <linux-fsdevel+bounces-10365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A055384A8C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48BE1C28AF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25C45A4DC;
	Mon,  5 Feb 2024 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iD7CDZzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6D5A4C0
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169630; cv=none; b=WKJTDdkwvOc7FLEMW99WYm3jp2coLv7gBbw0MSGnNeNiuTPids8QJnJXJHt9TlIjJDmo1pAF1rhaS5urZh74NtKf4ydYfLzL4MvJ0ZEeKm58SBWgmQPFUmoa/ZK2cSWRhTpJGDZlPzDr1HWV+y+hId+r+q2D3ofrtVdOQGIdiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169630; c=relaxed/simple;
	bh=NjbfyCvn6P5A6gPnyetbURYMdwSEp2bmJNmXhO0SszI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AR+eZ4td+0OTpioBeAWyEeBO+WPqGTf757k/5+8SJ5j8h2RbLOtBK3PhuPMfmwJ8eJqZ6TsAB5Uq1C86cH8KDsG/6PWpaY7CTrrdarOWCRK1kEVWDD/i+9bALCbPWJeewshZVFgIYFTCNcvYdunffT80FtudRlGxoo/zAeqYqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iD7CDZzV; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60412f65124so45531887b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707169628; x=1707774428; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSizpbEWnE13YJNMJ42hfW3O1AVhhtGuGyUG9Qkenj8=;
        b=iD7CDZzVfTca4yP05OqK7tQ2Wv88Qu5pLH0SIbzuNyL1uZd3Z1MOitmpUiH8OSxZ0U
         XtNWDAnw95mQ8eLY13mOaDesctnI1yNt3NX+Wsa96rtr9Pw69E8Q+rapr2CAjDQLHhqo
         WFPQjFZ6JFI7f1SFZzWLoUcYQCsocyZFiyS2J184a5gz1bZa5ZFDok48iAcex3MiE7R+
         c4Qza3vRf0tObMZ44YNoUAN4cqT6jP1hWKjxcGObpzWjeKENTVZwkI7w2cZDWdj3Ci+o
         in+HATYfPtBZlrdaYTu4z6qHAa0cx01b+naCg/l/qeg2Z05x+gOzg7IOFAJeAsveiF+S
         HlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707169628; x=1707774428;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSizpbEWnE13YJNMJ42hfW3O1AVhhtGuGyUG9Qkenj8=;
        b=Y/H5ifX7AMet1WME/HWKAwGMrwAc4EgC7wcX+vdZMf+vB9DEy0jF4rYVYcJBAKHgmk
         VYd/nPefmtMZjYVV5hR982YMcS8femxa7j37naNzeuo5Safa/ZHOgsyOqSrq4+3Ydr8K
         zMSQWRp46g+51w7qQirSwazJw0hlc1mmsNMGZK6USeyQXww6DL19j44OyKHIIx5UICTg
         4xY9w1mLqNTKlYbfKHLdp45hrWgB25NMthSrvAqB2ualtVwCfjN6Vl+4xslCRVTfibvP
         D8doxsO65cdXNTkkPGK0LzxJn9z2tnpUBVH6TZsFHlnZ8gn0mixIZN4TSL/x4IM3nXTh
         z3WQ==
X-Gm-Message-State: AOJu0YwoiKNYQw905AYOBExvtCu7krM11Ifi1LOkWyF+mOY7XxWgcR4E
	Vm6jF8SLqv4+DtBiVkiNu1SlopjxPRFq9toemJ7u7glpBteFXJkCeWrWczCXvX7PSUnH9fs7aBY
	4kSlXmSkrChu3B4v0yEP5zpa/cL1dRuq+G9vW
X-Google-Smtp-Source: AGHT+IEphcfl8B473ExqoDpauaRG7hqodOc+VOgJG3cmKcSbGn/sTQn22Y3ofZYLc+wnDRSnVqOObRe/rssntFsrq00=
X-Received: by 2002:a81:4e44:0:b0:5ff:5fda:fdae with SMTP id
 c65-20020a814e44000000b005ff5fdafdaemr898990ywb.42.1707169627564; Mon, 05 Feb
 2024 13:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com> <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver> <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver>
In-Reply-To: <20240131214104.rgw3x5vuap43xubi@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 5 Feb 2024 13:46:54 -0800
Message-ID: <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:41=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240130 21:49]:
> > On Mon, Jan 29, 2024 at 6:58=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240129 19:28]:
> > > > On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > > >
> > >
>
> ...
>
> > >
> > > > Your suggestion is definitely simpler and easier to follow, but due=
 to
> > > > the overflow situation that Suren pointed out, I would still need t=
o
> > > > keep the locking/boolean dance, no? IIUC, even if I were to return
> > > > EAGAIN to the userspace, there is no guarantee that subsequent ioct=
ls
> > > > on the same vma will succeed due to the same overflow, until someon=
e
> > > > acquires and releases mmap_lock in write-mode.
> > > > Also, sometimes it seems insufficient whether we managed to lock vm=
a
> > > > or not. For instance, lock_vma_under_rcu() checks if anon_vma (for
> > > > anonymous vma) exists. If not then it bails out.
> > > > So it seems to me that we have to provide some fall back in
> > > > userfaultfd operations which executes with mmap_lock in read-mode.
> > >
> > > Fair enough, what if we didn't use the sequence number and just locke=
d
> > > the vma directly?
> >
> > Looks good to me, unless someone else has any objections.
> > >
> > > /* This will wait on the vma lock, so once we return it's locked */
> > > void vma_aquire_read_lock(struct vm_area_struct *vma)
> > > {
> > >         mmap_assert_locked(vma->vm_mm);
> > >         down_read(&vma->vm_lock->lock);
> > > }
> > >
> > > struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > >         unsigned long addr))    /* or some better name.. */
> > > {
> > >         struct vm_area_struct *vma;
> > >
> > >         vma =3D lock_vma_under_rcu(mm, addr);
> > >         if (vma)
> > >                 return vma;
> > >
> > >         mmap_read_lock(mm);
> > >         /* mm sequence cannot change, no mm writers anyways.
> > >          * find_mergeable_anon_vma is only a concern in the page faul=
t
> > >          * path
> > >          * start/end won't change under the mmap_lock
> > >          * vma won't become detached as we have the mmap_lock in read
> > >          * We are now sure no writes will change the VMA
> > >          * So let's make sure no other context is isolating the vma
> > >          */
> > >         vma =3D lookup_vma(mm, addr);
> > >         if (vma)
> > We can take care of anon_vma as well here right? I can take a bool
> > parameter ('prepare_anon' or something) and then:
> >
> >            if (vma) {
> >                     if (prepare_anon && vma_is_anonymous(vma)) &&
> > !anon_vma_prepare(vma)) {
> >                                       vma =3D ERR_PTR(-ENOMEM);
> >                                       goto out_unlock;
> >                    }
> > >                 vma_aquire_read_lock(vma);
> >            }
> > out_unlock:
> > >         mmap_read_unlock(mm);
> > >         return vma;
> > > }
>
> Do you need this?  I didn't think this was happening in the code as
> written?  If you need it I would suggest making it happen always and
> ditch the flag until a user needs this variant, but document what's
> going on in here or even have a better name.

I think yes, you do need this. I can see calls to anon_vma_prepare()
under mmap_read_lock() protection in both mfill_atomic_hugetlb() and
in mfill_atomic(). This means, just like in the pagefault path, we
modify vma->anon_vma under mmap_read_lock protection which guarantees
that adjacent VMAs won't change. This is important because
__anon_vma_prepare() uses find_mergeable_anon_vma() that needs the
neighboring VMAs to be stable. Per-VMA lock guarantees stability of
the VMA we locked but not of its neighbors, therefore holding per-VMA
lock while calling anon_vma_prepare() is not enough. The solution
Lokesh suggests would call anon_vma_prepare() under mmap_read_lock and
therefore would avoid the issue.


>
> Thanks,
> Liam

