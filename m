Return-Path: <linux-fsdevel+bounces-8394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CC835B8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 08:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C87C1C2164A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F11F517;
	Mon, 22 Jan 2024 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+cP2u51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D35DF54
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705908244; cv=none; b=R6jrEEMCnFLVNJw4aw93bOqFLYJMm5Kf+iAiSukERsHgAFMJlWuuqXNtFbMIheGB+nHyFs5dW9zKNJgyAQDtPkOLhNSuHD6mOIyrfGFBaExgARFWqfmdBg32qsENnukEEd8+GQ+Q4p7Y4vwkF4bmQb9eyTWXuqgrJDdxSBDnRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705908244; c=relaxed/simple;
	bh=rWbUSyZEdxipvf2E7+M0Iv4K+d7cHRQC1vlYFO3g8Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrqNCkT5myNGhSYdHgMMclbufcvo7SM5H3VACNDEVg3LDZGLKaaq7KBS+oUc7nteP+ZtTtPzlpySTGZQ1YsfXTrXUbMkv+VYDQGrDG79ch0Lm5m8V+1WVT8NQFksn9uO4CGLgqBjcOrB9OdKow17nIvzwz+/nL1ga0o8wa9Y7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+cP2u51; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ec7a5a4b34so25391317b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 23:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705908241; x=1706513041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nULwB4h5pXORlWHrU8L4yn/qG7KobE3skZQ7okWTvc=;
        b=U+cP2u51f3YwhAgQNTpHPuyfH1glroHQnsjqtgJHhgPnKpNvowu1RZtdDeXsFmqMUj
         hFPIgmgfFpauxMXLHqqp1mHtQ8g7fL3eT/gXTtC4oO9OvABpTdUOabdDj9atj6vvaGIv
         CWGGoulHITWyXo4mnzJ8bsf8qMQ7lNbOZKbOK7Dla4fAh2xt16o3hPp/209w7IscRL9j
         qWQwWUJvwZ/nOZ6/gGkEP9YNrqDKiwt22obN5GgvRQpYCIRNFPolSO4rGoQZ+H6DKD4C
         sMpAfkwFnGOkJcciAeACSQBsBD4OBBvttmLGvs+MRWdhekFuhC2pF7M3L6wX+tnEHYoe
         hqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705908241; x=1706513041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nULwB4h5pXORlWHrU8L4yn/qG7KobE3skZQ7okWTvc=;
        b=io4xurG+7yYCF8B7riljdlOKBBYcwbW6uzWIRa88PJ93Z0fIRBk5WW6FQi5r1/9ThH
         +eWFV3hLdJgunCZNYDQ3EBAr4IpAcPPzUx86VYogZCLsdUT7gEO+LmSP1S8z6WDfFOU8
         Qxy2UcXkuMKUha0l3fajs5+HSNcE3bAhw4gyAt8yoC/ckZenTSWuNB2teR6KR9SXjy70
         IpzNRVrB49y8VEMQHyGhMxUIRZggBBD5cmlB6fj4bQSuWDPDOIK5tQ2w2Emp+aiMWWJd
         BE1tJkmHi4xOQ4tPTkmd2ncLPmNqw9NVy/i8kazIFFKbv5m+IbQqjymEgF0tXqwsPTXc
         8vdA==
X-Gm-Message-State: AOJu0YzDeqHEWuYNt0CaNwIuNEOuuk/3q32hgV+696lbZMJDiQgpLRiI
	Ltvi0kWVB9EgBw5AXwaaMlo46RyNkOgrwRs4z6XfFIs8ek1oJnuQzt7uwYk2PPYPfcjRDNbST4L
	8IkndfKzgF4KjWNMeV8aDHt6pKGNj6s/81lBo
X-Google-Smtp-Source: AGHT+IE6F//wT29st6eFFtAeRUskoVww8wNftQF3w1WeZzm+OMGiSq08/v3R/eN+cXzIAeOSU7Yv/rOii9evC7i0dCs=
X-Received: by 2002:a81:5383:0:b0:5ff:6587:19fd with SMTP id
 h125-20020a815383000000b005ff658719fdmr3099226ywb.86.1705908240727; Sun, 21
 Jan 2024 23:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com> <1bc8a5df-b413-4869-8931-98f5b9e82fe5@suse.cz>
 <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz> <CAJuCfpGTVEy=ZURbL3c7k+CduDR8wSfqsujN+OecPwuns7LiGQ@mail.gmail.com>
 <CAJuCfpHsNP7C2aDrgG=ANS+O2jh1ptEcAn2Gp0JhpM33=sf9UA@mail.gmail.com>
In-Reply-To: <CAJuCfpHsNP7C2aDrgG=ANS+O2jh1ptEcAn2Gp0JhpM33=sf9UA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 21 Jan 2024 23:23:47 -0800
Message-ID: <CAJuCfpFAmTfmTpd_8gJ1KYAT2ujiJKCjrJjEfp2pjrfqZzr+gg@mail.gmail.com>
Subject: Re: [RFC 0/3] reading proc/pid/maps under RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, dchinner@redhat.com, casey@schaufler-ca.com, 
	ben.wolsieffer@hefring.com, paulmck@kernel.org, david@redhat.com, 
	avagin@google.com, usama.anjum@collabora.com, peterx@redhat.com, 
	hughd@google.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	Liam.Howlett@oracle.com, yuzhao@google.com, axelrasmussen@google.com, 
	lstoakes@gmail.com, talumbau@google.com, willy@infradead.org, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:58=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jan 16, 2024 at 9:57=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Jan 16, 2024 at 6:46=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > On 1/16/24 15:42, Vlastimil Babka wrote:
> > > > On 1/15/24 19:38, Suren Baghdasaryan wrote:
> > > >
> > > > Hi,
> > > >
> > > >> The issue this patchset is trying to address is mmap_lock contenti=
on when
> > > >> a low priority task (monitoring, data collecting, etc.) blocks a h=
igher
> > > >> priority task from making updated to the address space. The conten=
tion is
> > > >> due to the mmap_lock being held for read when reading proc/pid/map=
s.
> > > >> With maple_tree introduction, VMA tree traversals are RCU-safe and=
 per-vma
> > > >> locks make VMA access RCU-safe. this provides an opportunity for l=
ock-less
> > > >> reading of proc/pid/maps. We still need to overcome a couple obsta=
cles:
> > > >> 1. Make all VMA pointer fields used for proc/pid/maps content gene=
ration
> > > >> RCU-safe;
> > > >> 2. Ensure that proc/pid/maps data tearing, which is currently poss=
ible at
> > > >> page boundaries only, does not get worse.
> > > >
> > > > Hm I thought we were to only choose this more complicated in case a=
dditional
> > > > tearing becomes a problem, and at first assume that if software can=
 deal
> > > > with page boundary tearing, it can deal with sub-page tearing too?
> >
> > Hi Vlastimil,
> > Thanks for the feedback!
> > Yes, originally I thought we wouldn't be able to avoid additional
> > tearing without a big change but then realized it's not that hard, so
> > I tried to keep the change in behavior transparent to the userspace.
>
> In the absence of other feedback I'm going to implement and post the
> originally envisioned approach: remove validation step and avoid any
> possibility of blocking but allowing for sub-page tearing. Will use
> Matthew's rwsem_wait() to deal with possible inconsistent maple_tree
> state.

I posted v1 at
https://lore.kernel.org/all/20240122071324.2099712-1-surenb@google.com/
In the RFC I used mm_struct.mm_lock_seq to detect if mm is being
changed but then I realized that won't work. mm_struct.mm_lock_seq is
incremented after mm is changed and right before mmap_lock is
write-unlocked. Instead I need a counter that changes once we
write-lock mmap_lock and before any mm changes. So the new patchset
introduces a separate counter to detect possible mm changes. In
addition, I could not use rwsem_wait() and instead had to take
mmap_lock for read to wait for the writer to finish and then record
the new counter while holding mmap_lock for read. That prevents
concurrent mm changes while we are recording the new counter value.

> Thanks,
> Suren.
>
> >
> > > >
> > > >> The patchset deals with these issues but there is a downside which=
 I would
> > > >> like to get input on:
> > > >> This change introduces unfairness towards the reader of proc/pid/m=
aps,
> > > >> which can be blocked by an overly active/malicious address space m=
odifyer.
> > > >
> > > > So this is a consequence of the validate() operation, right? We cou=
ld avoid
> > > > this if we allowed sub-page tearing.
> >
> > Yes, if we don't care about sub-page tearing then we could get rid of
> > validate step and this issue with updaters blocking the reader would
> > go away. If we choose that direction there will be one more issue to
> > fix, namely the maple_tree temporary inconsistent state when a VMA is
> > replaced with another one and we might observe NULL there. We might be
> > able to use Matthew's rwsem_wait() to deal with that issue.
> >
> > > >
> > > >> A couple of ways I though we can address this issue are:
> > > >> 1. After several lock-less retries (or some time limit) to fall ba=
ck to
> > > >> taking mmap_lock.
> > > >> 2. Employ lock-less reading only if the reader has low priority,
> > > >> indicating that blocking it is not critical.
> > > >> 3. Introducing a separate procfs file which publishes the same dat=
a in
> > > >> lock-less manner.
> > >
> > > Oh and if this option 3 becomes necessary, then such new file shouldn=
't
> > > validate() either, and whoever wants to avoid the reader contention a=
nd
> > > converts their monitoring to the new file will have to account for th=
is
> > > possible extra tearing from the start. So I would suggest trying to c=
hange
> > > the existing file with no validate() first, and if existing userspace=
 gets
> > > broken, employ option 3. This would mean no validate() in either case=
?
> >
> > Yes but I was trying to avoid introducing additional file which
> > publishes the same content in a slightly different way. We will have
> > to explain when userspace should use one vs the other and that would
> > require going into low level implementation details, I think. Don't
> > know if that's acceptable/preferable.
> > Thanks,
> > Suren.
> >
> > >
> > > >> I imagine a combination of these approaches can also be employed.
> > > >> I would like to get feedback on this from the Linux community.
> > > >>
> > > >> Note: mmap_read_lock/mmap_read_unlock sequence inside validate_map=
()
> > > >> can be replaced with more efficiend rwsem_wait() proposed by Matth=
ew
> > > >> in [1].
> > > >>
> > > >> [1] https://lore.kernel.org/all/ZZ1+ZicgN8dZ3zj3@casper.infradead.=
org/
> > > >>
> > > >> Suren Baghdasaryan (3):
> > > >>   mm: make vm_area_struct anon_name field RCU-safe
> > > >>   seq_file: add validate() operation to seq_operations
> > > >>   mm/maps: read proc/pid/maps under RCU
> > > >>
> > > >>  fs/proc/internal.h        |   3 +
> > > >>  fs/proc/task_mmu.c        | 130 +++++++++++++++++++++++++++++++++=
+----
> > > >>  fs/seq_file.c             |  24 ++++++-
> > > >>  include/linux/mm_inline.h |  10 ++-
> > > >>  include/linux/mm_types.h  |   3 +-
> > > >>  include/linux/seq_file.h  |   1 +
> > > >>  mm/madvise.c              |  30 +++++++--
> > > >>  7 files changed, 181 insertions(+), 20 deletions(-)
> > > >>
> > > >
> > >

