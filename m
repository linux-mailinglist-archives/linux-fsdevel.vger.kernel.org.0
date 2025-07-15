Return-Path: <linux-fsdevel+bounces-55009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E437BB06527
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 19:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2466218910F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC82857E4;
	Tue, 15 Jul 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtkSRLh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFCB27BF89;
	Tue, 15 Jul 2025 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600584; cv=none; b=gZ7ejKsz/TZiC5v1s+LkQsGx4rDI6IgqhPenJ9YPwnn7qqSq/A4v9hBIPNVXjHY9UZJP+DOYTNHJgpxCrXNc6ZRyLMdvYPA71vGQ8LN7YCuozIwYAZAleSAoYwRHWszA8xlQhXaqiGTIA3mHc/vcj9nJZlMDMTSnX35O/vpCEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600584; c=relaxed/simple;
	bh=RVuuMlQbOGlMH0Af9eVwx0kRq1T72m7vcRSvh8pU0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYib0BAqsNEsjkthohv/hLp4Wt0srhfyFlj2NdAwgvVC8ADgIFEid05ksowR6LMcp0dPVJl8vH5T1WxzfZv02tIaxbtVygdxRknB8rWHqgPSuTZAq6dbfFQ+svxJPEQP9TSC2pmcyyFQIyW1d0cdu8npSojmOep+PXNzQNsTJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtkSRLh0; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so4942682a91.3;
        Tue, 15 Jul 2025 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752600581; x=1753205381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc903ng5sV3+K5886ssk/NI8G/f9wB2jD4krWuXRVgg=;
        b=GtkSRLh0/e1nDEL84I+Aa7HYQgcFJHYqkjbGOixsqOHRvaYC3/OVWzA4BALSZ+Hg7P
         sFXVPGV3tOlR2guXK4aXwpHF9KC5FScmSzjBRrgcCAxkVosz81nta47+rLA362HILsAz
         K/FZltNi6YZhP/v0y/08I91sr+E/Twy4kEN4za24jjhbtaiRe5seRe5OcF5IbKPfMNRL
         mjl7veH4TP1ZQ9AXbU9ehSMZ5jdnyincko8Xe1chbODiS7eXXQx5LIfYU21Min0742w/
         CzE/FAPnwBV0PHM9kdHvoBRkNUfz6YHf0GTDGOJ2heySXNaFW+Wq6m6Fw1BCCWunJuoC
         GFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600581; x=1753205381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc903ng5sV3+K5886ssk/NI8G/f9wB2jD4krWuXRVgg=;
        b=N01YhIDAWybXtuz4ATvLY3GySHzhEiQjW3PiTUdxA4DKM9XycUuCjQ82usqOZ3f2i8
         Fe4k9BQJwqYsG362RGR4npl3pE8XmVnS5GhcBNRthF7J32sYHJ/cQdeyAl+bfX3pbK/p
         ydC+l7ezZumrwPZEkLfHTsoCnGe8QdX8E7NqLWDK5EmKW7zrLZeAFmXIQptdYA9uoSlV
         aZn4lVhosSakq6mRmN7Hdj0ibcPWOfQq++4U0H1DqgcRwk9byzq0yJJQJnFvxZGD6R5O
         593n7bdtI0vLxS3wLnJlBhpajNOCf/icuVTilqhU6Lvm2qt8l0U9Z/rkpnPQP68o6KTs
         /nlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6km+lrzLDeILCD1zRUrqv5ETEZaUrlaRQ/5iS9Ayd2pCdUkPdij/HFxHl5vrrEv1LBbc8TdUcm+rk48lO8fNd@vger.kernel.org, AJvYcCWODMzYf9AFDiGSXm5pnQgupkABkASXfqEEwZh5FjyW3BKX6WuEwUH1w8GLd7BzpJEzdetzT4Mrjb48K2F3@vger.kernel.org, AJvYcCX/SaAY1IoSGjg9COxWkxRcdVbR7jbunPdcm09+6kfUZDXMZa7wcd3Avsyf74qIIv9WVQDVP+XNn0LzYmF6@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDX4FaQSGjZ6xxUUSijDu4+Ul9Sj/ZTY9f4H7/pWL3y5kbKuf
	U76W07WnT2kAmM1Eh53KXNJ45Zb2vZxtjuD+94RV7zuaYUlVcxBb7EHPt9LztXUUubLUf/iibCU
	O5gudc35lKTaw7aVKNyBLxjafe+Bxgtg=
X-Gm-Gg: ASbGnctudXouK7trBGPp0U17w2W2m2rZfN2qdN2AX2Q6wv5hE4XTFqC1llrwEnIwnh9
	Ft0ZgusofnfuSa8gaVvn2RMbgnzZFDFwj0Z4qRG4RoH7Z84edcFZjZi+mimYDTkVxuTQyuMDqKX
	LcZxp+0J4UvGwC3474N/0yHJx30pkUiWlqCUBRHZvbNWguvC+vqj9ZqOAvxv/5eaZvZgYDuWANZ
	+4jCDhALP/EnW1wnAvmRE8=
X-Google-Smtp-Source: AGHT+IFV88ZsnMSrkKMCH3CvZnEcbNhiDbfsajxpa2V0A5Yj6GokzkBemYmOXveEA3RZ+tMFxpnloTbZg9BkrWKCBIc=
X-Received: by 2002:a17:90b:134e:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-31c9e6e4061mr52933a91.7.1752600581083; Tue, 15 Jul 2025
 10:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz> <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com> <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local> <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
 <7568edfa-6992-452d-9eb2-2497221cb22a@lucifer.local> <7d878566-f445-4fc2-9d04-eb8b38024c9b@lucifer.local>
In-Reply-To: <7d878566-f445-4fc2-9d04-eb8b38024c9b@lucifer.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 10:29:26 -0700
X-Gm-Features: Ac12FXyKCi8yfm9zpEz0p2N_Fds77kWBfr-mDczWqrvQScCzLL70RGcrvxh5Qp8
Message-ID: <CAEf4BzYDktFt9R78tQifMrJ7okzA+1LhhiqCi+SpSdq3h4zKyw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:21=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Jul 15, 2025 at 06:10:16PM +0100, Lorenzo Stoakes wrote:
> > > For PROCMAP_QUERY, we need priv->mm, but the newly added locked_vma
> > > and locked_vma don't need to be persisted between ioctl calls. So we
> > > can just add those two fields into a small struct, and for seq_file
> > > case have it in priv, but for PROCMAP_QUERY just have it on the stack=
.
> > > The code can be written to accept this struct to maintain the state,
> > > which for PROCMAP_QUERY ioctl will be very short-lived on the stack
> > > one.
> > >
> > > Would that work?
> >
> > Yeah that's a great idea actually, the stack would obviously give us th=
e
> > per-query invocation thing. Nice!
> >
> > I am kicking myself because I jokingly suggested (off-list) that a help=
er
> > struct would be the answer to everything (I do love them) and of
> > course... here we are :P
>
> Hm but actually we'd have to invert things I think, what I mean is - sinc=
e
> these fields can be updated at any time by racing threads, we can't have
> _anything_ in the priv struct that is mutable.
>

Exactly, and I guess I was just being incomplete with just listing two
of the fields that Suren make use of in PROCMAP_QUERY. See below.

> So instead we should do something like:
>
> struct proc_maps_state {
>         const struct proc_maps_private *priv;
>         bool mmap_locked;
>         struct vm_area_struct *locked_vma;
>         struct vma_iterator iter;
>         loff_t last_pos;
> };
>
> static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, uns=
igned long arg)
> {
>         struct seq_file *seq =3D file->private_data;
>         struct proc_maps_private *priv =3D seq->private;
>         struct proc_maps_state state =3D {
>                 .priv =3D priv,
>         };
>
>         switch (cmd) {
>         case PROCMAP_QUERY:
>                 return do_procmap_query(state, (void __user *)arg);

I guess it's a matter of preference, but I'd actually just pass
seq->priv->mm and arg into do_procmap_query(), which will make it
super obvious that priv is not used or mutated, and all the new stuff
that Suren needs for lockless VMA iteration, including iter (not sure
PROCMAP_QUERY needs last_pos, tbh), I'd just put into this new struct,
which do_procmap_query() can keep private to itself.

Ultimately, I think we are on the same page, it's just a matter of
structuring code and types.

>         default:
>                 return -ENOIOCTLCMD;
>         }
> }
>
> And then we have a stack-based thing with the bits that change and a
> read-only pointer to the bits that must remain static. And we can enforce
> that with const...
>
> We'd have to move the VMI and last_pos out too to make it const.
>
> Anyway the general idea should work!

