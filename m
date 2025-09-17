Return-Path: <linux-fsdevel+bounces-61877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC33B7D737
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7432D7AC50C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 05:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54436261B97;
	Wed, 17 Sep 2025 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9IP6lHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60830199E94
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086583; cv=none; b=GLk57nHcmsI1YD52c5BoAw3wbAW+P9VohASTHw5KmGL9xDpYg28Zp520iaxUQ7KGh9ydWrxmYFme6MUL3+zNH9advKSqofzFaiO09UVt+JGln6CTnqWm/3wnjYt/F948iun4L3ihSZblODPRc7EDnzWafna5sm3JehgKwfKcCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086583; c=relaxed/simple;
	bh=6gmx7nAOz7x8ECrrtogL+h4cr0iBnycW9rUPcfw8OzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZDvcYWJ5g7zQDPRsUg3JCv24qWhcOnOivd6HKjW2lRr47/5QCcYkzMGvsnbEDMl3bgpm8hT0LDRUtpNPtsiA1otgc6D5ok+c/oUIZX/bpzCNOuExQbs/5VnjkyUfMKV/REnl8yhl6Rsx67QW+X4Bc/tZhkm02OharG/DCxLvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9IP6lHS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so7402239a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758086580; x=1758691380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB85/PaNUJMrdnB5pj74aZCvU4kUegAWUrlhOp8yV3A=;
        b=P9IP6lHSsGmqtkRUNdyQFCORhbzxymRxrXZf7s4d/GRpykXDwmBAH0DFyKXc50QCu9
         y99MOCSjMCHf6/TAZiQ5D8EBSsX+v9bSdHFmQ/LVwgC4gBVFIoy4Xmyev3DaciX8NCpT
         6PikzX2ByL9KKgIEUB6EFsf37BoKf6DwAIiDhzTCFZE6CA0aTFMHfh7C2LSsRZNui1MU
         t0aGsr+OH80TtMtpV86ajeS+3gj16aaVeR1K9h9tKQV1iszQWRDhMDC5/h6/o1Ob1TId
         SsIKM4fnxg44xe/IchAPIF1vEVi0245vHgn5FFPzwAwIoEImucKjSwqU7qxpydC1awVX
         879w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758086580; x=1758691380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB85/PaNUJMrdnB5pj74aZCvU4kUegAWUrlhOp8yV3A=;
        b=F6NVNcPp2Sw4tj3zW9aTZp/943IL5wNYY2GH8lUGOmgRF7q5cP/qKUDDVz5d893WMK
         vjYQzM/aqFSbQGofITLla/xvkd8+CCleZsnODte9bf0bRGkZxFberdHk+T0Kqv5vLVCr
         uXKYGVZ6AV+7oJ/MA9oAhS7kuaUbyHrsKmZZyp06ciTbtcopO7ly+2oj6dwBr7TRYjHS
         HCwA1ngezss3KX7TTp8U67oaEXJ3taLloDvd35X0rk9Cly72Xd7NcQeaRWtQ+UgilEMl
         Z+CbWeJndcVWnp/SVEe9tWj3QXqqlM43J7jjpp1s+Tc09HzldF7ar+eKcQKhtNpcTdZV
         r/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX1S1vCpnnuE78tWs0KqIebvnw/VHolzheKoPGMxRH10volCUWuLw0e7ImKowMm/tQWWZHY0/jbAIkcmml0@vger.kernel.org
X-Gm-Message-State: AOJu0YxUBco0HjNp7sXRstKZVCRvqb5Sn6Zmz0BLQ9iP6UOlBPfHHAcH
	2Q5jjSbShp2gSaHvMJveEjdaTN3z7Pa3JL6KV94y7f6o4uqgEq51lxKbLbx9tVB403bGUnD7KNd
	ho4+yu9wrTtaNum603YmBp6TMT6ayWwU=
X-Gm-Gg: ASbGnct4GzAGptvlDfN7Mrkl5TTxUNWbHdRM3JsvFV8aEPaXJeap40DJtuRS141V6j2
	Smqud45mWrmEmkKt07QksRB6omw5s6dVgmZvbXytyTGvuMhc+fDKNBDq9eDlQ2BQtgehxS6nDHR
	K2thGxzUfwYOwndIK2+8J1QFpSZ3S4yVWF+KAiT7LUvfsztv+CCwUSkYSlhBmVyqn0AEg6rlBHH
	CH9cVLaZ40vC/Kujj5oF8+nj4R2z+HvUFDvDE8=
X-Google-Smtp-Source: AGHT+IGW18xtRuU2GK+tpKtajYwOhrW4O1BhSvambII8KyAv0L3MmzAdTmi7DunDdrqaD8FTROygg/qVkaFANLc30gY=
X-Received: by 2002:a05:6402:40c8:b0:62f:6706:7772 with SMTP id
 4fb4d7f45d1cf-62f8468ec40mr917576a12.34.1758086579371; Tue, 16 Sep 2025
 22:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250916194915.1395712-1-clm@meta.com> <CAGudoHE1GfgM-fX9pE-McqXH3dowPRoSPU9yHiGi+a3mk1hwnw@mail.gmail.com>
 <36fc538c-4e25-409d-b718-437fe97201ac@lucifer.local>
In-Reply-To: <36fc538c-4e25-409d-b718-437fe97201ac@lucifer.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 07:22:46 +0200
X-Gm-Features: AS18NWDTNu0uFCPWXMNYZriE-TkKq3-qYDDJDkS6S-UwtaAG2QuEVfyEtB1SXAM
Message-ID: <CAGudoHGBedD35u9FnYyPuJV=vT9mUrbtRVREO1P0RdzHhV=1FQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:20=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Sep 17, 2025 at 02:16:54AM +0200, Mateusz Guzik wrote:
> > On Wed, Sep 17, 2025 at 1:57=E2=80=AFAM Chris Mason <clm@meta.com> wrot=
e:
> > >
> > > On Tue, 12 Aug 2025 16:44:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@o=
racle.com> wrote:
> > >
> > > > As part of the effort to move to mm->flags becoming a bitmap field,=
 convert
> > > > existing users to making use of the mm_flags_*() accessors which wi=
ll, when
> > > > the conversion is complete, be the only means of accessing mm_struc=
t flags.
> > > >
> > > > This will result in the debug output being that of a bitmap output,=
 which
> > > > will result in a minor change here, but since this is for debug onl=
y, this
> > > > should have no bearing.
> > > >
> > > > Otherwise, no functional changes intended.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > >
> > > [ ... ]
> > >
> > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > index 25923cfec9c6..17650f0b516e 100644
> > > > --- a/mm/oom_kill.c
> > > > +++ b/mm/oom_kill.c
> > >
> > > [ ... ]
> > >
> > > > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd,=
 unsigned int, flags)
> > > >        * Check MMF_OOM_SKIP again under mmap_read_lock protection t=
o ensure
> > > >        * possible change in exit_mmap is seen
> > > >        */
> > > > -     if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_m=
m(mm))
> > > > +     if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm=
))
> > > >               ret =3D -EAGAIN;
> > > >       mmap_read_unlock(mm);
> > > >
> > >
> > > Hi Lorzeno, I think we lost a ! here.
> > >
> > > claude found enough inverted logic in moved code that I did a new run=
 with
> > > a more explicit prompt for it, but this was the only new hit.
> > >
> >
> > I presume conversion was done mostly manually?
>
> Actually largely via sed/emacs find-replace. I'm not sure why this case
> happened. But maybe it's one of the not 'largely' changes...
>
> Human-in-the-middle is obviously subject to errors :)
>

tru.dat

> >
> > The way(tm) is to use coccinelle.
> >
> > I whipped out the following real quick and results look good:
> >
> > @@
> > expression mm, bit;
> > @@
> >
> > - test_bit(bit, &mm->flags)
> > + mm_flags_test(bit, mm)
>
> Thanks. Not sure it'd hit every case. But that's useful to know, could
> presumably expand to hit others.
>
> I will be changing VMA flags when my review load finally allows me to so =
knowing
> this is useful...
>

I ran into bugs in spatch in the past where it just neglected to patch
something, but that's rare and can be trivially caught.

Defo easier to check than making sure none of the manual fixups are off.

> Cheers, Lorenzo
>
> >
> > $ spatch --sp-file mmbit.cocci mm/oom_kill.c
> > [snip]
> > @@ -892,7 +892,7 @@ static bool task_will_free_mem(struct ta
> >          * This task has already been drained by the oom reaper so ther=
e are
> >          * only small chances it will free some more
> >          */
> > -       if (test_bit(MMF_OOM_SKIP, &mm->flags))
> > +       if (mm_flags_test(MMF_OOM_SKIP, mm))
> >                 return false;
> >
> >         if (atomic_read(&mm->mm_users) <=3D 1)
> > @@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
> >                 reap =3D true;
> >         else {
> >                 /* Error only if the work has not been done already */
> > -               if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> > +               if (!mm_flags_test(MMF_OOM_SKIP, mm))
> >                         ret =3D -EINVAL;
> >         }
> >         task_unlock(p);
> > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
> >          * Check MMF_OOM_SKIP again under mmap_read_lock protection to =
ensure
> >          * possible change in exit_mmap is seen
> >          */
> > -       if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(=
mm))
> > +       if (!mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm)=
)
> >                 ret =3D -EAGAIN;
> >         mmap_read_unlock(mm);

