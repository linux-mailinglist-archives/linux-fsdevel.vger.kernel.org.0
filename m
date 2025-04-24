Return-Path: <linux-fsdevel+bounces-47276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73718A9B34F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059BF5A6C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F22820D9;
	Thu, 24 Apr 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da7C7H6R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F627A926;
	Thu, 24 Apr 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510613; cv=none; b=YKiIamAlYlFxwS3yc3Jz9QqHH0EDtZoMpTAVh9VuiJhhtVUkyDKhAoyGKz/DZDCkv/gXShpncyHtG1LlMVHBzh53vX3hRFRc86h3ZGIOAKeD4tpL0Rh3jhFGhZ65dNuZ5hqcOCJzAJd4HTTpIcd6uLZlZvHMseWkaY1WwbakjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510613; c=relaxed/simple;
	bh=tx216eYgSjKEPSxy+8wetWBxS+7Dpyt0FvU1BsZTz6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbgbCRHWRNYf3YI5zZpRsH9C7G5sM681KedP4N1j2LE8rTWHBiSJXoLD4L1+O2ra9KkQXjxEE3DbPB7bvMxBl5q44rcdvHm/RVIS6O0+vd0MzSSE5MJMIlIjxmwyQQL0DbLAO+il5dWaRRs4RBhwbI6Qzar9w5YGGo4CAJSijtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da7C7H6R; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73972a54919so1067035b3a.3;
        Thu, 24 Apr 2025 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745510611; x=1746115411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr73UvGmhNbjdi/Hymko96JYMAKbguXj6Ma/dOTZBDc=;
        b=Da7C7H6R6R5v3Cf+EOTi8+3lwwmfWjju9n7OZRDosYW6VaeHaGG3DcycMvBtn+cbrz
         pYiZ2NGP3rDY+ZLCZ/pfuqPvWz3ngQoYimmg0wZjet0ndoKh6NPnVrEQwhV8fLnviVe7
         +42T+I+K3sIvZVAZn3K7P0RGt901sDPBvcemhjmhloLLUdNHfXPlTLN4A2yc7SpgHi1a
         ZhD77taWtB5KWcNxC5t6MTyvVoWHhWrUoRiJLgfXGjwXz/rt8VX4FhyL4FlXN0RA8Ykq
         nfUJBns/bi1QVds5bniPPVxAZaFb/lMJvExPEchjFZ6Kc9924flTgJMlhFM3OhcLDLUk
         4vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510611; x=1746115411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr73UvGmhNbjdi/Hymko96JYMAKbguXj6Ma/dOTZBDc=;
        b=EsGreUR0Vke6yE3eTP1RzEVHVGIAXWqDsB+RCZ57rsNyiBEauqALb4xUZ+xQq/fgrT
         BcHvFrJwz5WzMsgVi0UKJ9/1tPFKrrwQb1Hpc2oQL35g0Of8abjrKTUJAuE2ROjQcQHf
         vnBdLMCz0T3cipAwQj6cy2Zy6mjIRC88Clswi069hskF04HDYJYKhpAhGosTym9hKNF/
         ZlYuCJKvVv+vO9Htj+2AXZ27dHpfVTTdx5++y9ToEmFrGB6PebkwcCI4XwV/0Ui7ORCJ
         R96LBw1yrUtk19ohAbPcCtIkx7NJI4AD0PTuJoz3vynhdo7gtmLnlIJI8lRKjgQhZCVf
         yQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDrMwZeRs1MPt3h34YyGQu8j0ViSndxJjY2BW+6MeIGsQNVNrCaaYHkBD5HnP6r3aCcg0gK6dvSEetNECr@vger.kernel.org, AJvYcCUYVaowi0pydnC6SnglUJizDeSvfoPJGtZdwwy6CKkEV0r2bdMz05FnPXJNSprLp5cid4SYe2EtWBBvIJkhS80q@vger.kernel.org, AJvYcCXl1bMrAYJYauqoibzUHP47J2NKi9NJf4q3hSao2cwQ/qhZFiEdDj11Qv+tw+efVuFG7lXepIr1HH/eplUC@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/ibHffqMywU6PTjBaI9tb1cZC/5zYMgFplR1WbVJWOB+2yk0
	3C7JHxJrjJLGNPi3QqXSQ77UXYEkFW87pJsSbEEGquSfOoMzKlFBJHOl2l4WPI890N0EHbY5Ppe
	gFUqidg3k7nu4K6TnZ+y0WsONgbQ=
X-Gm-Gg: ASbGncsuMDU7NErT4ageLFUomf9V2mTOLYTyBe1E1R8U9Y38SKaySa6VQuKm7TX2PZ1
	8AgcrpvjeIHJ5rrp41MNdcQMH0uFqk4H6SsRey9MT8hEyUIN+0IKd9okOBBchuJ55pTQd1wQMD5
	vIEdNA5HzX9D//RJsbBWfqJyN2VlSWOX8CDRm05w==
X-Google-Smtp-Source: AGHT+IFh1XagyJEx0F1fl42M6ZR0Wj4NxvObQ3ivZ1f01Bo1t+CbWymKjZgAxkMXsD1rOBMKGUXsYb1g2tgQFE9H/qk=
X-Received: by 2002:a05:6a00:279f:b0:73d:fa54:afb9 with SMTP id
 d2e1a72fcca58-73e32fa7f00mr335020b3a.7.1745510611109; Thu, 24 Apr 2025
 09:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com>
 <CAJuCfpE_jJ0Xq5T0HcLpquRzO+NdvN3T3_JXEwSjt2NG9Ryy5g@mail.gmail.com>
 <CAEf4BzYctDuS4DRTzdRQyyhCYvFTggOz=wcbizXEYvC_z_SSng@mail.gmail.com>
 <6ay37xorr35nw4ljtptnfqchuaozu73ffvjpmwopat42n4t6vr@qnr6xvralx2o> <CAJuCfpGc-23xpEYZQQevkzx+iN3AAqXXzbyqJAQjd4TQP9j9Dg@mail.gmail.com>
In-Reply-To: <CAJuCfpGc-23xpEYZQQevkzx+iN3AAqXXzbyqJAQjd4TQP9j9Dg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Apr 2025 09:03:17 -0700
X-Gm-Features: ATxdqUFS9FF0qHPJa3gvJuLiwcl_K5IeYr0KszQdGsNHpX8aM_Xv51piGS8AMas
Message-ID: <CAEf4BzYBdG95Zhi0M0CDTHAU6V9sF+kGSLB+346dq0Aa4Timmg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 8:20=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Apr 23, 2025 at 5:24=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [250423 18:06]:
> > > On Wed, Apr 23, 2025 at 2:49=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Apr 22, 2025 at 3:49=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <sure=
nb@google.com> wrote:
> > > > > >
> > > > > > With maple_tree supporting vma tree traversal under RCU and vma=
 and
> > > > > > its important members being RCU-safe, /proc/pid/maps can be rea=
d under
> > > > > > RCU and without the need to read-lock mmap_lock. However vma co=
ntent
> > > > > > can change from under us, therefore we make a copy of the vma a=
nd we
> > > > > > pin pointer fields used when generating the output (currently o=
nly
> > > > > > vm_file and anon_name). Afterwards we check for concurrent addr=
ess
> > > > > > space modifications, wait for them to end and retry. While we t=
ake
> > > > > > the mmap_lock for reading during such contention, we do that mo=
mentarily
> > > > > > only to record new mm_wr_seq counter. This change is designed t=
o reduce
> > > > >
> > > > > This is probably a stupid question, but why do we need to take a =
lock
> > > > > just to record this counter? uprobes get away without taking mmap=
_lock
> > > > > even for reads, and still record this seq counter. And then detec=
t
> > > > > whether there were any modifications in between. Why does this ch=
ange
> > > > > need more heavy-weight mmap_read_lock to do speculative reads?
> > > >
> > > > Not a stupid question. mmap_read_lock() is used to wait for the wri=
ter
> > > > to finish what it's doing and then we continue by recording a new
> > > > sequence counter value and call mmap_read_unlock. This is what
> > > > get_vma_snapshot() does. But your question made me realize that we =
can
> > > > optimize m_start() further by not taking mmap_read_lock at all.
> > > > Instead of taking mmap_read_lock then doing drop_mmap_lock() we can
> > > > try mmap_lock_speculate_try_begin() and only if it fails do the sam=
e
> > > > dance we do in the get_vma_snapshot(). I think that should work.
> > >
> > > Ok, yeah, it would be great to avoid taking a lock in a common case!
> >
> > We can check this counter once per 4k block and maintain the same
> > 'tearing' that exists today instead of per-vma.  Not that anyone said
> > they had an issue with changing it, but since we're on this road anyway=
s
> > I'd thought I'd point out where we could end up.
>
> We would need to run that check on the last call to show_map() right
> before seq_file detects the overflow and flushes the page. On
> contention we will also be throwing away more prepared data (up to a
> page worth of records) vs only the last record. All in all I'm not
> convinced this is worth doing unless increased chances of data tearing
> is identified as a problem.
>

Yep, I agree, with filling out 4K of data we run into much higher
chances of conflict, IMO. Not worth it, I'd say.

> >
> > I am concerned about live locking in either scenario, but I haven't
> > looked too deep into this pattern.
> >
> > I also don't love (as usual) the lack of ensured forward progress.
>
> Hmm. Maybe we should add a retry limit on
> mmap_lock_speculate_try_begin() and once the limit is hit we just take
> the mmap_read_lock and proceed with it? That would prevent a
> hyperactive writer from blocking the reader's forward progress
> indefinitely.

Came here to say the same. I'd add a small number of retries (3-5?)
and then fallback to the read-locked approach. The main challenge is
to keep all this logic nicely isolated from the main VMA
search/printing logic.

For a similar pattern in uprobes, we don't even bother to rety, we
just fallback to mmap_read_lock and proceed, under the assumption that
this is going to be very rare and thus not important from the overall
performance perspective.

>
> >
> > It seems like we have four cases for the vm area state now:
> > 1. we want to read a stable vma or set of vmas (per-vma locking)
> > 2. we want to read a stable mm state for reading (the very short named
> > mmap_lock_speculate_try_begin)
>
> and we don't mind retrying on contention. This one should be done
> under RCU protection.
>
> > 3. we ensure a stable vma/mm state for reading (mmap read lock)
> > 4. we are writing - get out of my way (mmap write lock).
>
> I wouldn't call #2 a vma state. More of a usecase when we want to read
> vma under RCU (valid but can change from under us) and then retry if
> it might have been modified from under us.
>
> >
> > Cheers,
> > Liam
> >

