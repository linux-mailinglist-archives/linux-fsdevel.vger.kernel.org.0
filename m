Return-Path: <linux-fsdevel+bounces-45686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60844A7AD1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1304188E810
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B09298CCC;
	Thu,  3 Apr 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzpAJeYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0962980D1
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707364; cv=none; b=eAosf3+VAxwp4ajt5zXdTUMCTOIAfHhiCL9FN42wzOTxICDb1tIhz/vGbEErgMEvTtkqM/MAAbj/gWMD9qBjOXt7FOVcBTk68eOndhrhOT1XFr7DsNFcACPuLk4IjZELLeEokGp43bLoBiI+wO+WmdGAuRlb+bICpJ8zgSKb3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707364; c=relaxed/simple;
	bh=cF+aefJSt33JDNbl7QptnVrNGivN/3qNQmkVn9O8UVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6KFbhcj2sBvseQmxuYsnPEzu7vd3eTchbUwtyalKvKRDVdYp3/ZcANVOOkQ2lhRDF49krcJpHJBYn7/ACUnb1/OphEVMTbSt+rbGhLs9iFoQkQmRLpRkDLXVnY5qcdmkNpPyxJLFgni/grJpFa3Wp1kGEzQGsTgnFQU2llMR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzpAJeYb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476964b2c1dso20321741cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743707361; x=1744312161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJSjlXCIVWKGtU45wyBNud75NhUKU7q3l/U4dBOcs9c=;
        b=KzpAJeYbgqNghypBwwBaL3IMgQJ2w4coqXdjLGEz50y5TPmwmDbN7uhG5B3IraWlER
         AIf4Cvh50ttaoPR5F8kHmBQOv+wLYVF2cPrss/YUgRYB/NGTvo8iy72ZnlnsfgXw6Uk7
         7OK2ss7aRgFdKgP4CYZUIZFkIUPYAFiL/pObuM/JmhLF8fngYD2x+UZjK+g5DebNtyb5
         DklB8H//i1sVpHETHsDR6RBCu4aSbFFK9JpptFXlkoaDEg/p4EztX83F3iAGZpv1RqE3
         OYlxxmJD+6nIjGbM5nkU8PhftVEV1+hFL/UjrgWqz76DXxLYntUvtvAxlUfosJx7f4Pt
         1A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707361; x=1744312161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJSjlXCIVWKGtU45wyBNud75NhUKU7q3l/U4dBOcs9c=;
        b=p1H7Deh8LBXgLySEW7SAvpainAmazTlZsj6cX7XrlCHulZAc6JsmhmG52IUibe/6LI
         JgbCxtBlZbK8UzwiCwPzygi59vkpnO8tSs2dmUj+Mq8OMa39E/O8fkcFxBD4pmxreMyD
         1KjGOwrjKLqUNIl2HiTPxk4WeFi/t0C8h8eds0lGbrxOmrfKOpWTACGWjeMMxETUOlNJ
         CeUhkrEeMij8ciKlBMZXZX0JurOJrhfiKYZ6ws39IvgjmShULgg/ACNOGZpAgD7dXbpX
         RxdkOBRcG+khRFmhTGXa60xSmonZuvUlpYzlgh5Mr4DXfdwDm80CHtMBppvW6EfYedh1
         S2dw==
X-Forwarded-Encrypted: i=1; AJvYcCVXyvlUI4cKAxwGsiUodo9rqBQRWQg6K7j/8Augdq0tPlYL6ceMFxua+JXHdWuGTRXBUwyeYe3iCk01mFrt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8XY95044zh7mso/D801Vah+nmV2qC7uONLpsUWt3FbKcbGZK
	kTJejoJAHOVWOhvgn6leOdjnZZ60XeI0aJvcBhNwRHlIU6QSrNr2aQkL2vuXTSu7QdLCOCsTpAv
	5XP9whMDjvtAt/Wb7q9GvPCe06Eg=
X-Gm-Gg: ASbGncscmQBwBKwiTEq+ydXiTzYSHdWM0MxNCrRJDWZpK4rLOJ0+StlGDQJSw8SQYqO
	dzFnzgHEqHhOuEl4CrPmIBuxNyvJEXNMSV4fx/v/+3n5rzQ5hhdbdllMg1BRupr9uFxYkcxKp7d
	DR26oMOETqIeGSi/wtMaM+bvgUmUVetMMKtZQIRg/uag==
X-Google-Smtp-Source: AGHT+IG75X1XvdK85dlsxGMvV8dnK0AvzHzV36OOvRcEgxeRGYBCxWfBxYN8dPj5CA7ONCNAz1dA1lpDzF4kA31waHs=
X-Received: by 2002:ac8:5f8f:0:b0:477:64b0:6a21 with SMTP id
 d75a77b69052e-4792493888amr9633761cf.23.1743707361189; Thu, 03 Apr 2025
 12:09:21 -0700 (PDT)
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
In-Reply-To: <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 3 Apr 2025 12:09:09 -0700
X-Gm-Features: AQ5f1JrZofkcbXtoX4LepJz2X9D-MSMdrXSPGN3_U7PLkEKiB7qwZJOz1E2SP08
Message-ID: <CAJnrk1a7DAijj09VQxJ1rjppgh=FMCm30cN_=wQijrz4B4nUtQ@mail.gmail.com>
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

On Thu, Apr 3, 2025 at 2:18=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 03.04.25 05:31, Jingbo Xu wrote:
> >
> >
> > On 4/3/25 5:34 AM, Joanne Koong wrote:
> >> On Thu, Dec 19, 2024 at 5:05=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 23.11.24 00:23, Joanne Koong wrote:
> >>>> For migrations called in MIGRATE_SYNC mode, skip migrating the folio=
 if
> >>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag se=
t on its
> >>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mappin=
g, the
> >>>> writeback may take an indeterminate amount of time to complete, and
> >>>> waits may get stuck.
> >>>>
> >>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>> ---
> >>>>    mm/migrate.c | 5 ++++-
> >>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> index df91248755e4..fe73284e5246 100644
> >>>> --- a/mm/migrate.c
> >>>> +++ b/mm/migrate.c
> >>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t ge=
t_new_folio,
> >>>>                 */
> >>>>                switch (mode) {
> >>>>                case MIGRATE_SYNC:
> >>>> -                     break;
> >>>> +                     if (!src->mapping ||
> >>>> +                         !mapping_writeback_indeterminate(src->mapp=
ing))
> >>>> +                             break;
> >>>> +                     fallthrough;
> >>>>                default:
> >>>>                        rc =3D -EBUSY;
> >>>>                        goto out;
> >>>
> >>> Ehm, doesn't this mean that any fuse user can essentially completely
> >>> block CMA allocations, memory compaction, memory hotunplug, memory
> >>> poisoning... ?!
> >>>
> >>> That sounds very bad.
> >>
> >> I took a closer look at the migration code and the FUSE code. In the
> >> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
> >> mode folio lock holds will block migration until that folio is
> >> unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:
> >>
> >>          if (!folio_trylock(src)) {
> >>                  if (mode =3D=3D MIGRATE_ASYNC)
> >>                          goto out;
> >>
> >>                  if (current->flags & PF_MEMALLOC)
> >>                          goto out;
> >>
> >>                  if (mode =3D=3D MIGRATE_SYNC_LIGHT && !folio_test_upt=
odate(src))
> >>                          goto out;
> >>
> >>                  folio_lock(src);
> >>          }
> >>
>
> Right, I raised that also in my LSF/MM talk: waiting for readahead
> currently implies waiting for the folio lock (there is no separate
> readahead flag like there would be for writeback).
>
> The more I look into this and fuse, the more I realize that what fuse
> does is just completely broken right now.
>
> >> If this is all that is needed for a malicious FUSE server to block
> >> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
> >> mappings are skipped in migration. A malicious server has easier and
> >> more powerful ways of blocking migration in FUSE than trying to do it
> >> through writeback. For a malicious fuse server, we in fact wouldn't
> >> even get far enough to hit writeback - a write triggers
> >> aops->write_begin() and a malicious server would deliberately hang
> >> forever while the folio is locked in write_begin().
> >
> > Indeed it seems possible.  A malicious FUSE server may already be
> > capable of blocking the synchronous migration in this way.
>
> Yes, I think the conclusion is that we should advise people from not
> using unprivileged FUSE if they care about any features that rely on
> page migration or page reclaim.
>
> >
> >
> >>
> >> I looked into whether we could eradicate all the places in FUSE where
> >> we may hold the folio lock for an indeterminate amount of time,
> >> because if that is possible, then we should not add this writeback way
> >> for a malicious fuse server to affect migration. But I don't think we
> >> can, for example taking one case, the folio lock needs to be held as
> >> we read in the folio from the server when servicing page faults, else
> >> the page cache would contain stale data if there was a concurrent
> >> write that happened just before, which would lead to data corruption
> >> in the filesystem. Imo, we need a more encompassing solution for all
> >> these cases if we're serious about preventing FUSE from blocking
> >> migration, which probably looks like a globally enforced default
> >> timeout of some sort or an mm solution for mitigating the blast radius
> >> of how much memory can be blocked from migration, but that is outside
> >> the scope of this patchset and is its own standalone topic.
>
> I'm still skeptical about timeouts: we can only get it wrong.
>
> I think a proper solution is making these pages movable, which does seem
> feasible if (a) splice is not involved and (b) we can find a way to not
> hold the folio lock forever e.g., in the readahead case.
>
> Maybe readahead would have to be handled more similar to writeback
> (e.g., having a separate flag, or using a combination of e.g.,
> writeback+uptodate flag, not sure)
>
> In both cases (readahead+writeback), we'd want to call into the FS to
> migrate a folio that is under readahread/writeback. In case of fuse
> without splice, a migration might be doable, and as discussed, splice
> might just be avoided.
>
> >>
> >> I don't see how this patch has any additional negative impact on
> >> memory migration for the case of malicious servers that the server
> >> can't already (and more easily) do. In fact, this patchset if anything
> >> helps memory given that malicious servers now can't also trigger page
> >> allocations for temp pages that would never get freed.
> >>
> >
> > If that's true, maybe we could drop this patch out of this patchset? So
> > that both before and after this patchset, synchronous migration could b=
e
> > blocked by a malicious FUSE server, while the usability of continuous
> > memory (CMA) won't be affected.
>
> I had exactly the same thought: if we can block forever on the folio
> lock, there is no need for AS_WRITEBACK_INDETERMINATE. It's already all
> completely broken.

I will resubmit this patchset and drop this patch.

I think we still need AS_WRITEBACK_INDETERMINATE for sync and legacy
cgroupv1 reclaim scenarios:
a) sync: sync waits on writeback so if we don't skip waiting on
writeback for AS_WRITEBACK_INDETERMINATE mappings, then malicious fuse
servers could make syncs hang. (There's no actual effect on sync
behavior though with temp pages because even without temp pages, we
return even though the data hasn't actually been synced to disk by the
server yet)

b) cgroupv1 reclaim: a correctly written fuse server can fall into
this deadlock in one very specific scenario (eg  if it's using legacy
cgroupv1 and reclaim encounters a folio that already has the reclaim
flag set and the caller didn't have __GFP_FS (or __GFP_IO if swap)
set), where the deadlock is triggered by:
* single-threaded FUSE server is in the middle of handling a request
that needs a memory allocation
* memory allocation triggers direct reclaim
* direct reclaim waits on a folio under writeback
* the FUSE server can't write back the folio since it's stuck in direct rec=
laim

Thanks for the feedback and discussion, everyone.
>
> --
> Cheers,
>
> David / dhildenb
>

