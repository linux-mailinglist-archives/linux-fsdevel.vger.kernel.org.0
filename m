Return-Path: <linux-fsdevel+bounces-10500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FB84BAE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DCD1C222A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B25F1350C2;
	Tue,  6 Feb 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu5w7Hsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA94134742
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236812; cv=none; b=kekH9crsJaoIGmvKQBy7XUeGxhbK0Wp74XT21fKORAzPKi60p5F4i0FqKn7Vpk3VrK6ZomYqjSu6y/46qK+/0iRj7KhQn5gPQeTYOdhbYaENaHJFn+PK+umH1YvJaJGm1SfHqtiRWtELUrvGDz541dwMcy0AfYo6B7GvzuB9pZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236812; c=relaxed/simple;
	bh=udcJME1WFwtZ8qNKbeG7WotKfoR1aTEcRmjEug/Md1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iGDVuXrYNCz0cp31AJ5UvTkVPGetyxjCH5cPG5p2F5wWMLwhhzh8axjytlYbvIH61IUg0pAM1MbbSJHyB1zaInsrPXZk8N3Ih1TKlE4Wl5bx7IaYsMEyUGoIZkvureoYqKL8D25pRnlpLprT+LMGjhsHPgUOqqzxRiumhpnHj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu5w7Hsp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b436dbdcfso1036397f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707236809; x=1707841609; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKcGartFfaDNzaw0oNAzfboMjdH4dZ1SThMOYPfs59E=;
        b=Wu5w7HspkXm7lNfIXyWqH0zPiKvw+tBcS5wQ5r6dfBrJhduF6nwj76KATYq1dLX7Nn
         JBI20OSG8o7o7waAI51KIoa/VFf9N3U+j+NHdWcwANEuyaFH5wjgHHShE5BjnZHPojq5
         GzInZtY/utVLSDfxX9k6EwqHFGJlEcRkXDcSPro94oKrQVRn3hhPAzkEVYLPHA8UCEId
         WsqZV9oidmSql93LRNxJTwklNh5fP5QiNYXC+nmqEnOqZ96QgnhbnR4SamCj1/rILaru
         vzGK5+evYxYtipU9ZaARV2oHDTfcoyzD7g/PL/QS9l4PbTSrhncXplIn0/M/O6v2pgJq
         E1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236809; x=1707841609;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKcGartFfaDNzaw0oNAzfboMjdH4dZ1SThMOYPfs59E=;
        b=GQcz93QxhZjzz2cZ5wIqe/Z4TI7Fcco1FHvHOhwrz69zB68bHDQ9GiuDU1yA2Oi/dZ
         mBtTP+yaewmQbCtU6gBfdHDUcI1ITTAHINwL1y5s40RCTGqI3jjvzNYBAjJt5CdLrJ99
         zCwDZXwHR4InjFTn5RvtOizm36Ba6nH0l4ypkvftsnT9PcEsiXLAv1shdIMAXY2VcljA
         wUFKhaXB8Ipfuj+oEexNtUO8HZuluwmkGTmLjvotQ2W/3LBDk/7VKC0iBocjgKrD6uw1
         uGnDEf+VkpaO6MJU7XwnP+axn6Hyjgw98JXCxbwxGEEUZThKbrSgu3ZrSWI3Jcwgtbnc
         QCNA==
X-Gm-Message-State: AOJu0YzcQgyofRPmK7G/Pa0eInQZyP4nBmLpeCxm2mbeCUj5WzGSFzRp
	Phato0U+qPrvx6pmdHfmaBe+LYjA6Hn2dEHL1cyjb4/Ku3i6X3mSpV1EAmo8gA3rdt5EZkk20dJ
	uQ6VFQ+bH006JaQQjFi8tACvtTLXtC4QK6WstrSTmag3QToeu/YTf
X-Google-Smtp-Source: AGHT+IH89GUBiASlkHU1t/vbfYCWBR4/w2Ue/VOkFZNVrEQU2R/i0VQYZk26ng6YoRY9yOTsCfq4LDgm9PGa95ZnLvE=
X-Received: by 2002:a5d:6d87:0:b0:33b:48ef:22ed with SMTP id
 l7-20020a5d6d87000000b0033b48ef22edmr1605036wrs.35.1707236809234; Tue, 06 Feb
 2024 08:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129203626.uq5tdic4z5qua5qy@revolver> <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver> <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver> <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
 <20240205220022.a4qy7xlv6jpcsnh7@revolver> <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
 <20240206143506.6zsj2gktu754gvl6@revolver>
In-Reply-To: <20240206143506.6zsj2gktu754gvl6@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 6 Feb 2024 08:26:36 -0800
Message-ID: <CA+EESO5H_f-APVpg1wgJEHjcMd4ogRUX33j8n=_nz4uTQW78uA@mail.gmail.com>
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

On Tue, Feb 6, 2024 at 6:35=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240205 17:24]:
> > On Mon, Feb 5, 2024 at 2:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
> > > ...
> > >
> > > > > > > We can take care of anon_vma as well here right? I can take a=
 bool
> > > > > > > parameter ('prepare_anon' or something) and then:
> > > > > > >
> > > > > > >            if (vma) {
> > > > > > >                     if (prepare_anon && vma_is_anonymous(vma)=
) &&
> > > > > > > !anon_vma_prepare(vma)) {
> > > > > > >                                       vma =3D ERR_PTR(-ENOMEM=
);
> > > > > > >                                       goto out_unlock;
> > > > > > >                    }
> > > > > > > >                 vma_aquire_read_lock(vma);
> > > > > > >            }
> > > > > > > out_unlock:
> > > > > > > >         mmap_read_unlock(mm);
> > > > > > > >         return vma;
> > > > > > > > }
> > > > > >
> > > > > > Do you need this?  I didn't think this was happening in the cod=
e as
> > > > > > written?  If you need it I would suggest making it happen alway=
s and
> > > > > > ditch the flag until a user needs this variant, but document wh=
at's
> > > > > > going on in here or even have a better name.
> > > > >
> > > > > I think yes, you do need this. I can see calls to anon_vma_prepar=
e()
> > > > > under mmap_read_lock() protection in both mfill_atomic_hugetlb() =
and
> > > > > in mfill_atomic(). This means, just like in the pagefault path, w=
e
> > > > > modify vma->anon_vma under mmap_read_lock protection which guaran=
tees
> > > > > that adjacent VMAs won't change. This is important because
> > > > > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs th=
e
> > > > > neighboring VMAs to be stable. Per-VMA lock guarantees stability =
of
> > > > > the VMA we locked but not of its neighbors, therefore holding per=
-VMA
> > > > > lock while calling anon_vma_prepare() is not enough. The solution
> > > > > Lokesh suggests would call anon_vma_prepare() under mmap_read_loc=
k and
> > > > > therefore would avoid the issue.
> > > > >
> > >
> > > ...
> > >
> > > > anon_vma_prepare() is also called in validate_move_areas() via move=
_pages().
> > >
> > > Probably worth doing it unconditionally and have a comment as to why =
it
> > > is necessary.
> > >
> > The src_vma (in case of move_pages()) doesn't need to have it.
> >
> > The only reason I'm not inclined to make it unconditional is what if
> > some future user of lock_vma() doesn't need it for their purpose? Why
> > allocate anon_vma in that case.
>
> Because there isn't a user and it'll add a flag that's a constant.  If
> there is a need for the flag later then it can be added at that time.
> Maybe there will never be a user and we've just complicated the code for
> no reason.  Don't implement features that aren't necessary, especially
> if there is no intent to use them.
>

I'm not too attached to the idea of keeping it conditional. But I have
already sent v3 which currently does it conditionally. Please take a
look at it. Along with any other comments/changes that I get, I'll
also make it unconditional in v4, if you say so.
> >
> > > Does this avoid your locking workaround?
> >
> > Not sure which workaround you are referring to. I am almost done
> > implementing your suggestion. Very soon will share the next version of
> > the patch-set.
>
> The locking dance with the flags indicating if it's per-vma lock or
> mmap_lock.
>
That dance was not because of anon_vma. It's just that I hadn't
realized that we can do it the way you suggested :) I really liked
your suggestion and is implemented in v3. PTAL.

