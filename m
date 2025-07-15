Return-Path: <linux-fsdevel+bounces-55026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD6EB067A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCA41AA2014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B52BE657;
	Tue, 15 Jul 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJ43VV1Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD3244675
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610698; cv=none; b=gt8+KLs5KrIfCYCi5QX4P0Sp+b01WkuQcE1P5iUA0EPl339XXAi4+WigNLtNEqZggRQN3IaEAhAIZwwAV0+BZ5eFhyUylozRYLnBYOKknym8ijZ1Dd6lcBVmiwTMg/7JTBZkMXPu/YiAGfA62w7pkG+qAqMrhc6DNY3N5/Bvkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610698; c=relaxed/simple;
	bh=s2ktJkEJEUaWsaEALaqTUWvGoIB35UIRafKufaYtazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqobChL7l0oxHoTxrOiAffNPuZgCGofqDHNTNP1N31YfkrSrh7F3bE8ngIXl2Kkf0pCbxDyLu7EZLagdlM2iIXksg5kzO6P2NKHTYIlfByP3KBxDoCaucSmwvkz/UwcfxAm4Ilpn3fZGYCUr7lqxHATk7kdqwCNUOjadI1mQR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJ43VV1Z; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso120261cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752610695; x=1753215495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h3Ep2VWmJ725V4zeell0WprNHA0l7LEqrQxhnNjHu8=;
        b=LJ43VV1ZbLSsj9qfS+Z55jlpJVka01rmFc5XV6UDJf3dSt2ssVeJAEHfQdbL9P8mea
         dGEvfDQpnIXBcXYGjPWFHxp6a2RHn+wMMKz3VnYhYNlT/pZPEj17ANmbfbSowCKlqR6w
         ihxD5EhiW3xnQj3gLtjiqsSu+Ca++hiMjyGZCKPF6XvKJiklpGEvUaObAuaJVrrCl1zS
         gBMaGmZtbdXxH6MI5BoGEKBvzM4gCOMf8JL55P0jYMt/RXpI8JPLdhnGXO7JZ693B3oG
         2reQinwZ4FTqZiY9aaImo6nW+/cN2lDnuCAUysxSmRRVnNBezIJsyiWL1r7se2sMcXWA
         CNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752610695; x=1753215495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h3Ep2VWmJ725V4zeell0WprNHA0l7LEqrQxhnNjHu8=;
        b=WfHy7Lq71f5LUqQn86kI8BMTXwheKlLirX28ME40W2xnGyPFrkA7gSRHe6v+9E3tr+
         oE7uZKpRG+2VjTEQ9ULRTW1TTLpfkTXXuxRGMqxLyTzTGYEAm3ujQLTKgfNPvWNKvtbi
         htm8PgXmnlgnfUFj6yAZOmz7Y+J9OcEdxI4sZHkf88JFLoPo59keiSFwGgg+Ajyp0lha
         ZSMz5mbINiv4/VAiQ2WviNLkMRrIBYoi8mLz8NX+/vQEM1SJd5lm1gLXQNfDtLiqaJAX
         IE4OePJbguDD3hP4josjbxdWvoWHYKlf7zWanE752i5Wbgif0g6i8YJdEVA9CUhJzhu4
         WSPA==
X-Forwarded-Encrypted: i=1; AJvYcCX8pedr6Oj1VGzY74iTUglaS6s4D+VlkvvN1abu5s4hM5xXwQZcaOR/Jd206Py2xinBptxvWDYo8yWgcP4J@vger.kernel.org
X-Gm-Message-State: AOJu0YzqN5P06D9d91NRJftuk6rsWtd2q7x5OtADli3HzjqdgWv/QEKB
	TuujA+rlUbvMwUEI+gEuEAc+okeTjUC8CGVT2O4WdL41yDTY2Kx3TxZYuyFa9jvswlx+PNO2UgN
	fTJ5tqqGRCDI2e/U8f0eGVfiO3bI41D4jPA7d5N0u
X-Gm-Gg: ASbGnctZ2NwnB/u2mtxv3n6YOBHNDIA4EsS9PkxB5tCxGyL7WXkl8Mzx4bmV/++IkN2
	P0EwCKHdDEHiecEly6gTEmh1d40gltK7/B/PENs2hz/QWzHOad61VrE99yqHhMIOGH9WAeNk6tM
	gAF2Ojf/BFVnnRWZiCVGtWGebMvjHp4KDbehGVXrHjPg3y7V4bxb5EjbyYvU6J/3p/XKNjDmEs9
	Xg4I5SCqpFg0wCRAl7TncwvsHnOirdmae6Lp3Y4RlFrjp8=
X-Google-Smtp-Source: AGHT+IGH4M4H5yhWaOUW04EMOoMVNaNdnS8aTx/in7/xD6LRAKlI7amTM7yUE22F+ar6ZwOBueaAeL5WAceT+XowSog=
X-Received: by 2002:a05:622a:a492:b0:4a7:26d2:5a38 with SMTP id
 d75a77b69052e-4ab92bdf67fmr419201cf.19.1752610695062; Tue, 15 Jul 2025
 13:18:15 -0700 (PDT)
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
 <CAEf4BzYDktFt9R78tQifMrJ7okzA+1LhhiqCi+SpSdq3h4zKyw@mail.gmail.com>
In-Reply-To: <CAEf4BzYDktFt9R78tQifMrJ7okzA+1LhhiqCi+SpSdq3h4zKyw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Jul 2025 13:18:03 -0700
X-Gm-Features: Ac12FXxyNmeLY-h4XS0JaeMQU9el1n8wMSHADzsB6KmgQZuTOsVzCS4Lh8cGUys
Message-ID: <CAJuCfpFx1vcv-a5Eez3AhoCUM2+jM6Sh0s9ms8FCWqZ8tFkTQg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
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

On Tue, Jul 15, 2025 at 10:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jul 15, 2025 at 10:21=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 06:10:16PM +0100, Lorenzo Stoakes wrote:
> > > > For PROCMAP_QUERY, we need priv->mm, but the newly added locked_vma
> > > > and locked_vma don't need to be persisted between ioctl calls. So w=
e
> > > > can just add those two fields into a small struct, and for seq_file
> > > > case have it in priv, but for PROCMAP_QUERY just have it on the sta=
ck.
> > > > The code can be written to accept this struct to maintain the state=
,
> > > > which for PROCMAP_QUERY ioctl will be very short-lived on the stack
> > > > one.
> > > >
> > > > Would that work?
> > >
> > > Yeah that's a great idea actually, the stack would obviously give us =
the
> > > per-query invocation thing. Nice!
> > >
> > > I am kicking myself because I jokingly suggested (off-list) that a he=
lper
> > > struct would be the answer to everything (I do love them) and of
> > > course... here we are :P
> >
> > Hm but actually we'd have to invert things I think, what I mean is - si=
nce
> > these fields can be updated at any time by racing threads, we can't hav=
e
> > _anything_ in the priv struct that is mutable.
> >
>
> Exactly, and I guess I was just being incomplete with just listing two
> of the fields that Suren make use of in PROCMAP_QUERY. See below.
>
> > So instead we should do something like:
> >
> > struct proc_maps_state {
> >         const struct proc_maps_private *priv;
> >         bool mmap_locked;
> >         struct vm_area_struct *locked_vma;
> >         struct vma_iterator iter;
> >         loff_t last_pos;
> > };
> >
> > static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, u=
nsigned long arg)
> > {
> >         struct seq_file *seq =3D file->private_data;
> >         struct proc_maps_private *priv =3D seq->private;
> >         struct proc_maps_state state =3D {
> >                 .priv =3D priv,
> >         };
> >
> >         switch (cmd) {
> >         case PROCMAP_QUERY:
> >                 return do_procmap_query(state, (void __user *)arg);
>
> I guess it's a matter of preference, but I'd actually just pass
> seq->priv->mm and arg into do_procmap_query(), which will make it
> super obvious that priv is not used or mutated, and all the new stuff
> that Suren needs for lockless VMA iteration, including iter (not sure
> PROCMAP_QUERY needs last_pos, tbh), I'd just put into this new struct,
> which do_procmap_query() can keep private to itself.
>
> Ultimately, I think we are on the same page, it's just a matter of
> structuring code and types.

That sounds cleaner to me too.
I'll post a new version of my patchset today without the last patch to
keep PROCMAP_QUERY changes separate, and then a follow-up patch that
does this refactoring and changes PROCMAP_QUERY to use per-vma locks.

Thanks folks! It's good to be back from vacation with the problem
already figured out for you :)

>
> >         default:
> >                 return -ENOIOCTLCMD;
> >         }
> > }
> >
> > And then we have a stack-based thing with the bits that change and a
> > read-only pointer to the bits that must remain static. And we can enfor=
ce
> > that with const...
> >
> > We'd have to move the VMI and last_pos out too to make it const.
> >
> > Anyway the general idea should work!

