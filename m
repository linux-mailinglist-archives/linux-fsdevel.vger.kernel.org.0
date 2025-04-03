Return-Path: <linux-fsdevel+bounces-45707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFBDA7B1D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 00:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E389177B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 22:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882C18DB17;
	Thu,  3 Apr 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv+iaeam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9672E62A2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717874; cv=none; b=ty/yKIsoBDGPg4oXhHVvNQIaYhSSCYYwzhODqZUZFDStPxI6zqXNFEM/exPsMA8F27v+pqE+7wUq1/sX6ERWdVhO9ZD9f6QM19ZQgybr8X/9OlaaSZh7dichE6sb9rMp7BZgEBA1ySZBl5FSG22FSmACtmV5n/w64B1Mosl7pW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717874; c=relaxed/simple;
	bh=dbpt6n3c9MRWpkRUSh1Hs6W+Trs/nt4zQ+ZVijpUVlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9X2ZJ4dZ1uLhVOfX/fK1CuVLmza9o7kma5C9lj5WVWLZnsK4ADWvVZKdEupYW9wYViYgjhtYX0LunxNBrHVgeKsydqYv9c+GI1QhpcJLwMgnHATmuHRuO0iZ9c3ygTufjQ4QD9fTOK/1cwDkxr12o02tyOQTOn+XtYAmdvJh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv+iaeam; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476b4c9faa2so16165361cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743717870; x=1744322670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dm6XkGVy8YUMK9wlTKzjo7DbVXBEwYL67ZlTyjaN0U=;
        b=Hv+iaeamAp0mlwYz5cN+XPH1i+0gIVlxhZe0Px3ngk+8TUe8hVffZ3pv4qm+ZQ4raE
         NngnhWDSDczcWuSwiWfVNuQXoxyuPc3uRrCJPPEXOp1TE68yDMvkaf7pEn8ypDqKXq50
         HfNrw1eVCBZwC6IY3qtWUXt6hZa9WMQMMUnRF7arvh6ZIvQh7vVEfuGSgSHJMPUJBWdd
         dZylcXfprXEexwhOmMwW257Ip2SgnkgTu0ZsXPby3BGNK9N/0p2YlxAeeFSBd2Nu1GL+
         VtlirdWTXcNRgH9YuowzVjvVTuvIsp5fhn9z/AoJ0g2HFptoODHeoKgjO/99ZM9QbeTr
         kpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743717870; x=1744322670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dm6XkGVy8YUMK9wlTKzjo7DbVXBEwYL67ZlTyjaN0U=;
        b=XySyqFYKr9CZhr236JcLCjdlUAWhyCA6nIKg2dWHpQrN6aybGDzNKGyncWmnO5GWnm
         672MCCuJNS8e+y4p9j+xHxXesJnEpvYqOn+qVtvSddY+IuDBBy7gLmRxvUrNYcMJMGG5
         lmm58BFSnogKZbR4YOiaXmPjx45AUBo4SDtnEQfe6UBwoBwGefOeIKQ9syiVx/F6KUkj
         neJllHQzgVmgpYySzxQnnobli23cgoh2og4enfjh75/MXK1UZvCofM9IvtTgQtarwFlL
         eGVLoxFIpEfNn6rOKM7uc4zEDt7ayhUllaRAt3Pr4ntlKusKvx7MGxwXEOpI37VvTVxu
         lMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNGDxuDiByUbDYiZEgiIe6k6Gkt0wf4eA/rl7Sddlu4M6KoB/BkCMzeYCuVuxgnpb76l315b2p7wih/mHp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuj0t4H5wZqaFM3viMYJ9RompNMqEqS2GP1bBc9c+MHnqy1s4F
	68T9gezq/byQw2URp31ggCKoF5cNIQ9anf03SSsnJAO6wdh5zQyHWQRFOvIJoVhMrHZpnYhp4Xi
	9wF0kHlIyVwzLIFvRDQqCTr4wJKKG0nY7LeY=
X-Gm-Gg: ASbGncuVQ9mkU0Gqpaa7k+uj4c9GfsWptUNfM8c9PLggma1TRibXP/84oWtFUB1MeyF
	oG+BBVvywkg9c5M6GDCa4bS3H5Gt0GmOWP+HaLZtGVOXjTcSk/UKgzDIX/s43PJWmCvs6A/b1sB
	viXi3UUGXkvnta+AimG1qKigW9prQruVpp280UKx7cfF6MtPddvf+m
X-Google-Smtp-Source: AGHT+IGyfKAKCqQ+zjf0Kqp0F2yAQ+7HG81Q6goKCnG6wQLEtMtVSU9iztnx1YTrdf7+HN+sjSEKNXvdrbeg1QQd5SU=
X-Received: by 2002:a05:622a:16:b0:477:e78:5a14 with SMTP id
 d75a77b69052e-47925930d19mr10327441cf.3.1743717869929; Thu, 03 Apr 2025
 15:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com> <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
 <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com> <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
 <CAJnrk1a7DAijj09VQxJ1rjppgh=FMCm30cN_=wQijrz4B4nUtQ@mail.gmail.com> <075209ac-c659-485e-a220-83d4afed8a94@redhat.com>
In-Reply-To: <075209ac-c659-485e-a220-83d4afed8a94@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 3 Apr 2025 15:04:19 -0700
X-Gm-Features: AQ5f1Jq_CyzARy-pMtX6EIMqdzCB9JrpiQvlztngZ0rTMQICHyVz0WDMSZbnKGU
Message-ID: <CAJnrk1bCybWR1mzfB-ts1xHhPGvtBMFO+yATsAA5r98Ndes=0w@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 1:44=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.04.25 21:09, Joanne Koong wrote:
> > On Thu, Apr 3, 2025 at 2:18=E2=80=AFAM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 03.04.25 05:31, Jingbo Xu wrote:
> >>>
> >>>
> >>> On 4/3/25 5:34 AM, Joanne Koong wrote:
> >>>> On Thu, Dec 19, 2024 at 5:05=E2=80=AFAM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 23.11.24 00:23, Joanne Koong wrote:
> >>>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the fol=
io if
> >>>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag =
set on its
> >>>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapp=
ing, the
> >>>>>> writeback may take an indeterminate amount of time to complete, an=
d
> >>>>>> waits may get stuck.
> >>>>>>
> >>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>>> ---
> >>>>>>     mm/migrate.c | 5 ++++-
> >>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>>

> >>>>> Ehm, doesn't this mean that any fuse user can essentially completel=
y
> >>>>> block CMA allocations, memory compaction, memory hotunplug, memory
> >>>>> poisoning... ?!
> >>>>>
> >>>>> That sounds very bad.
> >>>>
> >>>> I took a closer look at the migration code and the FUSE code. In the
> >>>> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
> >>>> mode folio lock holds will block migration until that folio is
> >>>> unlocked. This is the snippet in migrate_folio_unmap() I'm looking a=
t:
> >>>>
> >>>>           if (!folio_trylock(src)) {
> >>>>                   if (mode =3D=3D MIGRATE_ASYNC)
> >>>>                           goto out;
> >>>>
> >>>>                   if (current->flags & PF_MEMALLOC)
> >>>>                           goto out;
> >>>>
> >>>>                   if (mode =3D=3D MIGRATE_SYNC_LIGHT && !folio_test_=
uptodate(src))
> >>>>                           goto out;
> >>>>
> >>>>                   folio_lock(src);
> >>>>           }
> >>>>
> >>
> >> Right, I raised that also in my LSF/MM talk: waiting for readahead
> >> currently implies waiting for the folio lock (there is no separate
> >> readahead flag like there would be for writeback).
> >>
> >> The more I look into this and fuse, the more I realize that what fuse
> >> does is just completely broken right now.
> >>
> >>>> If this is all that is needed for a malicious FUSE server to block
> >>>> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
> >>>> mappings are skipped in migration. A malicious server has easier and
> >>>> more powerful ways of blocking migration in FUSE than trying to do i=
t
> >>>> through writeback. For a malicious fuse server, we in fact wouldn't
> >>>> even get far enough to hit writeback - a write triggers
> >>>> aops->write_begin() and a malicious server would deliberately hang
> >>>> forever while the folio is locked in write_begin().
> >>>
> >>> Indeed it seems possible.  A malicious FUSE server may already be
> >>> capable of blocking the synchronous migration in this way.
> >>
> >> Yes, I think the conclusion is that we should advise people from not
> >> using unprivileged FUSE if they care about any features that rely on
> >> page migration or page reclaim.
> >>
> >>>
> >>>
> >>>>
> >>>> I looked into whether we could eradicate all the places in FUSE wher=
e
> >>>> we may hold the folio lock for an indeterminate amount of time,
> >>>> because if that is possible, then we should not add this writeback w=
ay
> >>>> for a malicious fuse server to affect migration. But I don't think w=
e
> >>>> can, for example taking one case, the folio lock needs to be held as
> >>>> we read in the folio from the server when servicing page faults, els=
e
> >>>> the page cache would contain stale data if there was a concurrent
> >>>> write that happened just before, which would lead to data corruption
> >>>> in the filesystem. Imo, we need a more encompassing solution for all
> >>>> these cases if we're serious about preventing FUSE from blocking
> >>>> migration, which probably looks like a globally enforced default
> >>>> timeout of some sort or an mm solution for mitigating the blast radi=
us
> >>>> of how much memory can be blocked from migration, but that is outsid=
e
> >>>> the scope of this patchset and is its own standalone topic.
> >>
> >> I'm still skeptical about timeouts: we can only get it wrong.
> >>
> >> I think a proper solution is making these pages movable, which does se=
em
> >> feasible if (a) splice is not involved and (b) we can find a way to no=
t
> >> hold the folio lock forever e.g., in the readahead case.
> >>
> >> Maybe readahead would have to be handled more similar to writeback
> >> (e.g., having a separate flag, or using a combination of e.g.,
> >> writeback+uptodate flag, not sure)
> >>
> >> In both cases (readahead+writeback), we'd want to call into the FS to
> >> migrate a folio that is under readahread/writeback. In case of fuse
> >> without splice, a migration might be doable, and as discussed, splice
> >> might just be avoided.
> >>
> >>>>
> >>>> I don't see how this patch has any additional negative impact on
> >>>> memory migration for the case of malicious servers that the server
> >>>> can't already (and more easily) do. In fact, this patchset if anythi=
ng
> >>>> helps memory given that malicious servers now can't also trigger pag=
e
> >>>> allocations for temp pages that would never get freed.
> >>>>
> >>>
> >>> If that's true, maybe we could drop this patch out of this patchset? =
So
> >>> that both before and after this patchset, synchronous migration could=
 be
> >>> blocked by a malicious FUSE server, while the usability of continuous
> >>> memory (CMA) won't be affected.
> >>
> >> I had exactly the same thought: if we can block forever on the folio
> >> lock, there is no need for AS_WRITEBACK_INDETERMINATE. It's already al=
l
> >> completely broken.
> >
> > I will resubmit this patchset and drop this patch.
> >
> > I think we still need AS_WRITEBACK_INDETERMINATE for sync and legacy
> > cgroupv1 reclaim scenarios:
> > a) sync: sync waits on writeback so if we don't skip waiting on
> > writeback for AS_WRITEBACK_INDETERMINATE mappings, then malicious fuse
> > servers could make syncs hang. (There's no actual effect on sync
> > behavior though with temp pages because even without temp pages, we
> > return even though the data hasn't actually been synced to disk by the
> > server yet)
>
> Just curious: Are we sure there are no other cases where a malicious
> userspace could make some other folio_lock() hang forever either way?
>

Unfortunately, there's an awful case where kswapd may get blocked
waiting for the folio lock. We encountered this in prod last week from
a well-intentioned but incorrectly written FUSE server that got stuck.
The stack trace was:

  366 kswapd0 D
  folio_wait_bit_common.llvm.15141953522965195141
  truncate_inode_pages_range
  fuse_evict_inode
  evict
  _dentry_kill
  shrink_dentry_list
  prune_dcache_sb
  super_cache_scan
  do_shrink_slab
  shrink_slab
  kswapd
  kthread
  ret_from_fork
  ret_from_fork_asm

which was narrowed down to the  __filemap_get_folio(..., FGP_LOCK,
...)  call in truncate_inode_pages_range().

I'm working on a fix for this for kswapd and planning to also do a
broader audit for other places where we might get tripped up from fuse
forever holding a folio lock. I'm going to look more into the
long-term fuse fix too - the first step will be documenting all the
places currently where a lock may be forever held.

> IOW, just like for migration, isn't this just solving one part of the
> whole problem we are facing?

For sync, I didn't see any folio lock acquires anywhere but I just
noticed that fuse's .sync_fs() implementation will block until a
server replies, so yes a malicious server could still hold up sync
regardless of temp pages or not. I'll drop the sync patch too in v7.

Thanks,
Joanne

>
> >
> > b) cgroupv1 reclaim: a correctly written fuse server can fall into
> > this deadlock in one very specific scenario (eg  if it's using legacy
> > cgroupv1 and reclaim encounters a folio that already has the reclaim
> > flag set and the caller didn't have __GFP_FS (or __GFP_IO if swap)
> > set), where the deadlock is triggered by:
> > * single-threaded FUSE server is in the middle of handling a request
> > that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in direct=
 reclaim
>
> Yes, that sounds reasonable.
>
> --
> Cheers,
>
> David / dhildenb
>

