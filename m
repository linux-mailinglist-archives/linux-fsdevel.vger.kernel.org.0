Return-Path: <linux-fsdevel+bounces-47139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091EA99B36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3333B5DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237671EFFAB;
	Wed, 23 Apr 2025 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMBax0Fx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8E38382;
	Wed, 23 Apr 2025 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445983; cv=none; b=nxlbh7EOYUb/igDoZDmJUqE1bxhLlwVovaKHbiwFLwO2Mn/ZgS2ttZtIKhFXkfewAwK2CEt6nyfUpRxYSNjRJAyYi1iuGI3INaezYlBQ8YubK3iCIlTUR2p22+RlwNQuyiCf5Yw5RJof10+TzRzJRhvG4edbtXYxUOFGgoDffmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445983; c=relaxed/simple;
	bh=catdYc0guUL+1mvfHScpo9lna8XPaXOuQVHEw0vLKqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOHKaM9l8s+xAiJyjroJ9vh6EQDoUSaYKTp6fHgGricNysyJHEDB2FCSvauMZ7k/0aFgu+m22rX6d48JmVa4g+HxCwESlE7ilbBheNhroA27uw7T6oe6UU1q4DdJEAjNuwX3OLT3FAo63dE2TGZ+znB+3hqxUB+Vk5zbbTYDE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMBax0Fx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so313330a91.1;
        Wed, 23 Apr 2025 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745445981; x=1746050781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsiPVmQ9vMCRkpTsBzVfBMDI0AoYgjzP6nuAuKJ1bTo=;
        b=aMBax0Fxslb53pT804XbY7HBldxL0cH9gQoWASndXnwE4wG/xiE1RIaEA2mbxf/q11
         jKapIHih4p/ZsDsCAly/FGlwXeHi+/sZU7GolNhE/hdam6ikRn+3yAFqiKyJXH72D15E
         Fu4ZsKy/twFjkgRBk+RC8RmdHvbfiTTqMalnL/0IEPcqBR11LjAWWx6Cwi4oCsz8rBL6
         9/ZPUe4Q9+2w5kuI7H7m2MtgwIk6IZoaXCgM8Tgt/V6vbddsxkf3CBkyg5cggSx5s7rF
         OFouMYng0aUi7MVvos1PQ4+3sSqm7HuhEJm239nhNdMgTRelIxuYrNqCix48VVNENX6a
         mPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745445981; x=1746050781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsiPVmQ9vMCRkpTsBzVfBMDI0AoYgjzP6nuAuKJ1bTo=;
        b=EyLwLE0Z4iQb0AHNlNRkqpFj3xWiOwSNbcvMxy3S/Jffkq9NtMzCLxxdkILk3JQXkZ
         mFdBS91O3BOKr5Riv8wBtyJj9lYJtX2WtMlCsWN3cWPcMpQloGuv8bdjrW1kQBB88PSn
         kkjIbH0ykOxFV6EL/nRxePMCApa0Toad73iUurq6DVmyDqZ7ITXCkC14kSqCTudMm0Zv
         bFxcNlZ3I4724WfOQYY6ImCe33/cMC9TyVbEXaZVmmlSv+cDEjiRXDN+GJliGOkmYnBY
         ZoQlTgEoC/sWRcqm77vGzQvwcsSoOEIzmg1LSghRJHWLvnUJ2ulUlLgf4GpKK6jmBhEI
         61BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+PkzDLtcm67a6BntrBJdzfA9CaATl2unvCSBAlQRzDnWG1xiM5citqT0ZlFOVSDtboesA6/JijfqBv/Z7@vger.kernel.org, AJvYcCULOPEXzZN3J+GuJqhoTdThUQsI8J0RwgP4gwUzvQ95zPU6EYCfA2DptddenAa4w4Y2OAuvPG0Twjy/y2fy@vger.kernel.org, AJvYcCUzvddI96H7SHkZT692E2pgqbitV8a9NVSY1sJrcrOZQc5r20MF3A1Q9dIyia4Ya+Qs+BpSJn03pOK4X64JtNyJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/+EmwefFmjnERtGAhzzbWGc80JeIrIDmsS09UoTuvYWX7AeW
	cqIBQ2W7s4K4eRJM5QUSFGiSbtn00FIbn5+CsFhtL2vmtazRHZm0Y/eQtZzyIxitTQVr+Bwm/mn
	MRnjKWIRLsFuhvko+M1827cAuGAw=
X-Gm-Gg: ASbGncsyn3BypipJa1tMQ0HAP1YBrJpb1Clx+OS4sQbiAUf2E9JYGP/SrZwuRoOhdUO
	GvANyoALegYik2IBI8xJNYH+kuTIv0zi14Slqur2cMjr8K53893NeCAyO3eZk35siWxx3930E0A
	xNq6IVU1C6qJb90bBqe3F8CmmxAXtoZXZtPy19dQ==
X-Google-Smtp-Source: AGHT+IHPtTemguCK+hx6hcId37B8xL62Uyc2LDddSUMllW5thzGIQ0M8WwtIdLrFj5yuefDf8uif4NNLqSOOAgS6Zxc=
X-Received: by 2002:a17:90b:6c3:b0:2ee:6d08:7936 with SMTP id
 98e67ed59e1d1-309ed2a3f21mr580521a91.20.1745445980960; Wed, 23 Apr 2025
 15:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com> <CAJuCfpE_jJ0Xq5T0HcLpquRzO+NdvN3T3_JXEwSjt2NG9Ryy5g@mail.gmail.com>
In-Reply-To: <CAJuCfpE_jJ0Xq5T0HcLpquRzO+NdvN3T3_JXEwSjt2NG9Ryy5g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 15:06:08 -0700
X-Gm-Features: ATxdqUEhpIukcADUQT8bpUPiETvpQWy_LLT6W5s_rIldofkQMQI-nBweMCKUcrM
Message-ID: <CAEf4BzYctDuS4DRTzdRQyyhCYvFTggOz=wcbizXEYvC_z_SSng@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
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

On Wed, Apr 23, 2025 at 2:49=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Apr 22, 2025 at 3:49=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > With maple_tree supporting vma tree traversal under RCU and vma and
> > > its important members being RCU-safe, /proc/pid/maps can be read unde=
r
> > > RCU and without the need to read-lock mmap_lock. However vma content
> > > can change from under us, therefore we make a copy of the vma and we
> > > pin pointer fields used when generating the output (currently only
> > > vm_file and anon_name). Afterwards we check for concurrent address
> > > space modifications, wait for them to end and retry. While we take
> > > the mmap_lock for reading during such contention, we do that momentar=
ily
> > > only to record new mm_wr_seq counter. This change is designed to redu=
ce
> >
> > This is probably a stupid question, but why do we need to take a lock
> > just to record this counter? uprobes get away without taking mmap_lock
> > even for reads, and still record this seq counter. And then detect
> > whether there were any modifications in between. Why does this change
> > need more heavy-weight mmap_read_lock to do speculative reads?
>
> Not a stupid question. mmap_read_lock() is used to wait for the writer
> to finish what it's doing and then we continue by recording a new
> sequence counter value and call mmap_read_unlock. This is what
> get_vma_snapshot() does. But your question made me realize that we can
> optimize m_start() further by not taking mmap_read_lock at all.
> Instead of taking mmap_read_lock then doing drop_mmap_lock() we can
> try mmap_lock_speculate_try_begin() and only if it fails do the same
> dance we do in the get_vma_snapshot(). I think that should work.

Ok, yeah, it would be great to avoid taking a lock in a common case!

>
> >
> > > mmap_lock contention and prevent a process reading /proc/pid/maps fil=
es
> > > (often a low priority task, such as monitoring/data collection servic=
es)
> > > from blocking address space updates.
> > > Note that this change has a userspace visible disadvantage: it allows
> > > for sub-page data tearing as opposed to the previous mechanism where
> > > data tearing could happen only between pages of generated output data=
.
> > > Since current userspace considers data tearing between pages to be
> > > acceptable, we assume is will be able to handle sub-page data tearing
> > > as well.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/proc/internal.h        |   6 ++
> > >  fs/proc/task_mmu.c        | 170 ++++++++++++++++++++++++++++++++++--=
--
> > >  include/linux/mm_inline.h |  18 ++++
> > >  3 files changed, 177 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> > > index 96122e91c645..6e1169c1f4df 100644
> > > --- a/fs/proc/internal.h
> > > +++ b/fs/proc/internal.h
> > > @@ -379,6 +379,12 @@ struct proc_maps_private {
> > >         struct task_struct *task;
> > >         struct mm_struct *mm;
> > >         struct vma_iterator iter;
> > > +       bool mmap_locked;
> > > +       loff_t last_pos;
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +       unsigned int mm_wr_seq;
> > > +       struct vm_area_struct vma_copy;
> > > +#endif
> > >  #ifdef CONFIG_NUMA
> > >         struct mempolicy *task_mempolicy;
> > >  #endif
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -127,13 +127,130 @@ static void release_task_mempolicy(struct proc=
_maps_private *priv)
> > >  }
> > >  #endif
> > >
> > > -static struct vm_area_struct *proc_get_vma(struct proc_maps_private =
*priv,
> > > -                                               loff_t *ppos)
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +
> > > +static const struct seq_operations proc_pid_maps_op;
> > > +
> > > +/*
> > > + * Take VMA snapshot and pin vm_file and anon_name as they are used =
by
> > > + * show_map_vma.
> > > + */
> > > +static int get_vma_snapshot(struct proc_maps_private *priv, struct v=
m_area_struct *vma)
> > > +{
> > > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > > +       int ret =3D -EAGAIN;
> > > +
> > > +       memcpy(copy, vma, sizeof(*vma));
> > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > +               goto out;
> > > +
> > > +       if (!anon_vma_name_get_if_valid(copy))
> > > +               goto put_file;
> >
> > Given vm_file and anon_vma_name are both RCU-protected, if we take
> > rcu_read_lock() at m_start/m_next before fetching VMA, we shouldn't
> > even need getting/putting them, no?
>
> Yeah, anon_vma_name indeed looks safe without pinning but vm_file is
> using SLAB_TYPESAFE_BY_RCU cache, so it might still be a valid pointer
> but pointing to a wrong object even if the rcu grace period did not
> pass. With my assumption that seq_file can't rollback once show_map()
> is done, I would need a completely stable vma at the time show_map()
> is executed so that it does not change from under us while we are
> generating the output.
> OTOH, if we indeed can rollback while generating seq_file output then
> show_map() could output potentially invalid vma, then check for vma
> changes and when detected, rollback seq_file and retry again.
>
> >
> > I feel like I'm missing some important limitations, but I don't think
> > they are spelled out explicitly...
> >
> > > +
> > > +       if (!mmap_lock_speculate_retry(priv->mm, priv->mm_wr_seq))
> > > +               return 0;
> > > +
> > > +       /* Address space got modified, vma might be stale. Re-lock an=
d retry. */
> > > +       rcu_read_unlock();
> >
> > Another question I have is whether we really need to copy vma into
> > priv->vma_copy to have a stable snapshot? Can't we just speculate like
> > with uprobes under assumption that data doesn't change. And once we
> > are done producing text output, confirm that speculation was
> > successful, and if not - retry?
> >
> > We'd need an API for seq_file to rollback to previous good known
> > location for that, but that seems straightforward enough to do, no?
> > Just remember buffer position before speculation, write data, check
> > for no mm modifications, and if something changed, rollback seq file
> > to last position.
>
> From looking at seq_read_iter() I think for a rollback we would have
> to reset seq_file.count and seq_file.index to their previous states.
> At this location:
> https://elixir.bootlin.com/linux/v6.14.3/source/fs/seq_file.c#L272 if
> show_map() returns negative value m->count will indeed be rolled back
> but not seq_file.index. Also returning negative value at
> https://elixir.bootlin.com/linux/v6.14.3/source/fs/seq_file.c#L230
> would be interpreted as a hard error... So, I'll need to spend some
> time in this code to get the answer about rollback.
> Thanks for the review!

Yeah, seq_file is a glorified wrapper around a memory buffer,
essentially. And at the lowest level, this transaction-like API would
basically just return seq->count before we start writing anything, and
rollback will just accept a new count to set to seq->count, if we need
to rollback.

Logistically this all needs to be factored into the whole seq_file
callbacks thing, of course, especially if "transaction" will be
started in m_start/m_next, while it can be "aborted" in m_show... So
that's what would need careful consideration.

But you can end up with faster and cleaner implementation, as we
discussed above, so worth giving it a try, IMO.

>
> >
> >
> > > +       ret =3D mmap_read_lock_killable(priv->mm);
> > > +       if (!ret) {
> > > +               /* mmap_lock_speculate_try_begin() succeeds when hold=
ing mmap_read_lock */
> > > +               mmap_lock_speculate_try_begin(priv->mm, &priv->mm_wr_=
seq);
> > > +               mmap_read_unlock(priv->mm);
> > > +               ret =3D -EAGAIN;
> > > +       }
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       anon_vma_name_put_if_valid(copy);
> > > +put_file:
> > > +       if (copy->vm_file)
> > > +               fput(copy->vm_file);
> > > +out:
> > > +       return ret;
> > > +}
> > > +
> > > +static void put_vma_snapshot(struct proc_maps_private *priv)
> > > +{
> > > +       struct vm_area_struct *vma =3D &priv->vma_copy;
> > > +
> > > +       anon_vma_name_put_if_valid(vma);
> > > +       if (vma->vm_file)
> > > +               fput(vma->vm_file);
> > > +}
> > > +
> >
> > [...]

