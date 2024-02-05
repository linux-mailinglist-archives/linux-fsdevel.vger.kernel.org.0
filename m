Return-Path: <linux-fsdevel+bounces-10366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6EF84A8D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D0E1F30133
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F105C61D;
	Mon,  5 Feb 2024 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5VCjZyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528D5C614
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 21:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170098; cv=none; b=WTxt1MyRCOBnQjrlH9DSZpOnngHe6/G3uHZfzxbki+OBLV+egC7hSp4ScDaPHnx/uwFDOLcd5GDkETfkoRRrGd9HXbVLGnyoKmP3GYilIyHFZ3o6bvTSxX7k5733Q0l3azIe00aop46enhrxec+XAn7/vn2Ev6r6VLtKNtLpGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170098; c=relaxed/simple;
	bh=J/wLslb/AFm/pwmtZ8NeoG3aXGAE3L7KF+RaF6q3vJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dh8v0VfYshk5gWEgvnsgQYeNFkIzyxHHyhYG64dkPf7McIWHeoK84BYr+fXRSBUC5a0OMHDgy10rAxWRGK4GKKcatMLd4PpzTMbtp1chVTB2WN5YBxbqaiO0mK83XIwwx2kJDsCakcqYlEHYoQKpFMlTrGo8S1fAkKTkXugqVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5VCjZyq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b1a51743fso3663701f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707170095; x=1707774895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htTuvVyAX4wJ7U4/j+fiU4mrRuOGdWA0fijTiSjZLM4=;
        b=M5VCjZyq/Oue3A/y5lmkh0prvAduY91px7+EC9zmxrzvguT3I3yLVF8p65cu8frabJ
         gUVh2ZoTswI32vo6TeVqzPBFF/weZ3Fdyg80C9U/GHfl+t5MvgstkluVHdSX8i2RvpPp
         v6jt3NOnoNWPbY9m12MGgWC8/YJrYSir8raJ0kNH3f00yMQi+ncdboGJcnbSCaU3nMK5
         3IbHX6B/h96xrIcCcKb5dqKufvZaXzK9EnPOM6xbW/kqPP++7yqMkhu3HPp4JvDWWcFX
         Whf/1bcxMFKIuwL1U/q5aW0rzCTo+3e8COCVfCSJKc56wAqp2TFNpXdebpMkPCp/zpAu
         AktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170095; x=1707774895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htTuvVyAX4wJ7U4/j+fiU4mrRuOGdWA0fijTiSjZLM4=;
        b=AaEpAN7LFcoQ//yDLcJk6+ceI4Gxqf5i53Fs1gL1H6oHi1CNeNwgRaEdrRo4o62X64
         PLwFjrxP9RVXfq0nm7Jgcne4Zl/byS1CwFyXbSY3/+TXQuzXVQ2mrbuS01V2Jp3olZAR
         hSd8/4R+vS2Jmxr8eWkQR2GJEKO6XS1ah+SCN5b0aZGxWXklyU7FNV5KDe4jc/Rf1yUF
         MDPpum4eWv0YQw4RtVPd9eAgh0KfOYrS8CrNWmRBZUsD3RiGps5ImRH1SctUmpSwe3SU
         b4673ymGZikfeoxlg60Uj4iEA2wvBcPLb6mxfDvExob29heOqRn75gmoXi09yvxJ8iAh
         KoBw==
X-Gm-Message-State: AOJu0YxnZHVfjjVZESHGW2D5pB16BhKoaCTNtAoNPcJfGy49lq/XxFKs
	02CPtZCKUb0vOOMWhBfTiFIJFkl97GkzJ96KKAQw/YqH783IyEhXmfJ3cdiwHiRrEZbJe0Vo3GT
	/stmCdjjWuef7jFN1Zpl7PRQYF40p+T4wlYFF
X-Google-Smtp-Source: AGHT+IHXIaoM8v/s7uf1cZjr4pYirqJZMsxVSKJ5GaStD8mOFri7ZDNfcWpdu/4lTUQiJ7WEfOKXZEoHRA9d/Yu57xc=
X-Received: by 2002:a5d:56cc:0:b0:33b:178a:6715 with SMTP id
 m12-20020a5d56cc000000b0033b178a6715mr181170wrw.24.1707170095131; Mon, 05 Feb
 2024 13:54:55 -0800 (PST)
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
 <20240131214104.rgw3x5vuap43xubi@revolver> <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
In-Reply-To: <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 5 Feb 2024 13:54:43 -0800
Message-ID: <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:47=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jan 31, 2024 at 1:41=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240130 21:49]:
> > > On Mon, Jan 29, 2024 at 6:58=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240129 19:28]:
> > > > > On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Suren Baghdasaryan <sure=
nb@google.com> wrote:
> > > > > >
> > > >
> >
> > ...
> >
> > > >
> > > > > Your suggestion is definitely simpler and easier to follow, but d=
ue to
> > > > > the overflow situation that Suren pointed out, I would still need=
 to
> > > > > keep the locking/boolean dance, no? IIUC, even if I were to retur=
n
> > > > > EAGAIN to the userspace, there is no guarantee that subsequent io=
ctls
> > > > > on the same vma will succeed due to the same overflow, until some=
one
> > > > > acquires and releases mmap_lock in write-mode.
> > > > > Also, sometimes it seems insufficient whether we managed to lock =
vma
> > > > > or not. For instance, lock_vma_under_rcu() checks if anon_vma (fo=
r
> > > > > anonymous vma) exists. If not then it bails out.
> > > > > So it seems to me that we have to provide some fall back in
> > > > > userfaultfd operations which executes with mmap_lock in read-mode=
.
> > > >
> > > > Fair enough, what if we didn't use the sequence number and just loc=
ked
> > > > the vma directly?
> > >
> > > Looks good to me, unless someone else has any objections.
> > > >
> > > > /* This will wait on the vma lock, so once we return it's locked */
> > > > void vma_aquire_read_lock(struct vm_area_struct *vma)
> > > > {
> > > >         mmap_assert_locked(vma->vm_mm);
> > > >         down_read(&vma->vm_lock->lock);
> > > > }
> > > >
> > > > struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > >         unsigned long addr))    /* or some better name.. */
> > > > {
> > > >         struct vm_area_struct *vma;
> > > >
> > > >         vma =3D lock_vma_under_rcu(mm, addr);
> > > >         if (vma)
> > > >                 return vma;
> > > >
> > > >         mmap_read_lock(mm);
> > > >         /* mm sequence cannot change, no mm writers anyways.
> > > >          * find_mergeable_anon_vma is only a concern in the page fa=
ult
> > > >          * path
> > > >          * start/end won't change under the mmap_lock
> > > >          * vma won't become detached as we have the mmap_lock in re=
ad
> > > >          * We are now sure no writes will change the VMA
> > > >          * So let's make sure no other context is isolating the vma
> > > >          */
> > > >         vma =3D lookup_vma(mm, addr);
> > > >         if (vma)
> > > We can take care of anon_vma as well here right? I can take a bool
> > > parameter ('prepare_anon' or something) and then:
> > >
> > >            if (vma) {
> > >                     if (prepare_anon && vma_is_anonymous(vma)) &&
> > > !anon_vma_prepare(vma)) {
> > >                                       vma =3D ERR_PTR(-ENOMEM);
> > >                                       goto out_unlock;
> > >                    }
> > > >                 vma_aquire_read_lock(vma);
> > >            }
> > > out_unlock:
> > > >         mmap_read_unlock(mm);
> > > >         return vma;
> > > > }
> >
> > Do you need this?  I didn't think this was happening in the code as
> > written?  If you need it I would suggest making it happen always and
> > ditch the flag until a user needs this variant, but document what's
> > going on in here or even have a better name.
>
> I think yes, you do need this. I can see calls to anon_vma_prepare()
> under mmap_read_lock() protection in both mfill_atomic_hugetlb() and
> in mfill_atomic(). This means, just like in the pagefault path, we
> modify vma->anon_vma under mmap_read_lock protection which guarantees
> that adjacent VMAs won't change. This is important because
> __anon_vma_prepare() uses find_mergeable_anon_vma() that needs the
> neighboring VMAs to be stable. Per-VMA lock guarantees stability of
> the VMA we locked but not of its neighbors, therefore holding per-VMA
> lock while calling anon_vma_prepare() is not enough. The solution
> Lokesh suggests would call anon_vma_prepare() under mmap_read_lock and
> therefore would avoid the issue.
>
Thanks, Suren.
anon_vma_prepare() is also called in validate_move_areas() via move_pages()=
.
>
> >
> > Thanks,
> > Liam

