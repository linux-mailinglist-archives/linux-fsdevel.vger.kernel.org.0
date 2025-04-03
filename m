Return-Path: <linux-fsdevel+bounces-45621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F0A7A023
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3FD7A6986
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB52CA6;
	Thu,  3 Apr 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6MQjqC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93821224B14
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672930; cv=none; b=mVKaZTcfrZo+ZKG/VTfi/MSW3kw+gh0ccS1OrxibcH9S01qRL+9pti3qJuV+6ieYOw2yHWH/velPhtWxXd2Z3W1V7IrLh0uQJBlj0ZOXY7e+oIUYepxwmweuJ0OmydTFNEmFdyl+7gqEGibCJJCup+xjljruZ7QiwC+YYtjGr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672930; c=relaxed/simple;
	bh=YRlZ/NiPqcpQjk4lOYinYlI/Xb3uAZaKYuWB144x+lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNrHY9ehEOG1Zf5/qxbyzCBgkqje+mf70Nh3MeChFAJ7mAXfUpZHQT6T1Ukz7kTEzo7o2fUCYxCYXOOYT9nxpeQreCe5GWDq8TffGOZ8QerSskoJ2KWRl6ht9BYhKk3RV5H7/HIoTEGcOzAf89Qi8mwDWkjnvB7B4fk40b7JTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6MQjqC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915E7C4CEE3;
	Thu,  3 Apr 2025 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743672930;
	bh=YRlZ/NiPqcpQjk4lOYinYlI/Xb3uAZaKYuWB144x+lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6MQjqC9OdDz+McSWUx8DvTcR+uW4VY3zyuNFut/w45QXKgRWf7OgKXsURfsUEtaq
	 mp8iYogfRmneelF0cDPbW05E+BDPjpDwFZUXl1zxVhmyd0aSOakkwiVtDuAokS09CB
	 8OXEivZshjlD05rIFLZcWMXvhCfZaUQT62fRDqSxoIax3UEuvSlVOKEzUvaJJqr3cC
	 ifB0V2ILU83mM+m5hsO3i31TnQpzgAH9J6DLfgBlw6QlrBF53+eK++z3PY4uZw113X
	 oK6oyeR0B/jij6sm+Oo0OAdY2SPCTcUFR4K6b3gvtjM5jQawcTfw34IZRneg9y2+Vb
	 RhBpbsxiyYBCQ==
Date: Thu, 3 Apr 2025 11:35:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: David Hildenbrand <david@redhat.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <20250403-option-holztisch-de5d88079f59@brauner>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <CAJnrk1aXOJ-dAUdSmP07ZP6NPBJrdjPPJeaGbBULZfY=tBdn=Q@mail.gmail.com>
 <1036199a-3145-464b-8bbb-13726be86f46@linux.alibaba.com>
 <1577c4be-c6ee-4bc6-bb9c-d0a6d553b156@redhat.com>
 <cb6a5eb4-582b-42ba-a4b8-7ecaccbf5ba2@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb6a5eb4-582b-42ba-a4b8-7ecaccbf5ba2@fastmail.fm>

On Thu, Apr 03, 2025 at 11:25:17AM +0200, Bernd Schubert wrote:
> 
> 
> On 4/3/25 11:18, David Hildenbrand wrote:
> > On 03.04.25 05:31, Jingbo Xu wrote:
> >>
> >>
> >> On 4/3/25 5:34 AM, Joanne Koong wrote:
> >>> On Thu, Dec 19, 2024 at 5:05 AM David Hildenbrand <david@redhat.com>
> >>> wrote:
> >>>>
> >>>> On 23.11.24 00:23, Joanne Koong wrote:
> >>>>> For migrations called in MIGRATE_SYNC mode, skip migrating the
> >>>>> folio if
> >>>>> it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag
> >>>>> set on its
> >>>>> mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the
> >>>>> mapping, the
> >>>>> writeback may take an indeterminate amount of time to complete, and
> >>>>> waits may get stuck.
> >>>>>
> >>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>> ---
> >>>>>    mm/migrate.c | 5 ++++-
> >>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>>> index df91248755e4..fe73284e5246 100644
> >>>>> --- a/mm/migrate.c
> >>>>> +++ b/mm/migrate.c
> >>>>> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t
> >>>>> get_new_folio,
> >>>>>                 */
> >>>>>                switch (mode) {
> >>>>>                case MIGRATE_SYNC:
> >>>>> -                     break;
> >>>>> +                     if (!src->mapping ||
> >>>>> +                         !mapping_writeback_indeterminate(src-
> >>>>> >mapping))
> >>>>> +                             break;
> >>>>> +                     fallthrough;
> >>>>>                default:
> >>>>>                        rc = -EBUSY;
> >>>>>                        goto out;
> >>>>
> >>>> Ehm, doesn't this mean that any fuse user can essentially completely
> >>>> block CMA allocations, memory compaction, memory hotunplug, memory
> >>>> poisoning... ?!
> >>>>
> >>>> That sounds very bad.
> >>>
> >>> I took a closer look at the migration code and the FUSE code. In the
> >>> migration code in migrate_folio_unmap(), I see that any MIGATE_SYNC
> >>> mode folio lock holds will block migration until that folio is
> >>> unlocked. This is the snippet in migrate_folio_unmap() I'm looking at:
> >>>
> >>>          if (!folio_trylock(src)) {
> >>>                  if (mode == MIGRATE_ASYNC)
> >>>                          goto out;
> >>>
> >>>                  if (current->flags & PF_MEMALLOC)
> >>>                          goto out;
> >>>
> >>>                  if (mode == MIGRATE_SYNC_LIGHT && !
> >>> folio_test_uptodate(src))
> >>>                          goto out;
> >>>
> >>>                  folio_lock(src);
> >>>          }
> >>>
> > 
> > Right, I raised that also in my LSF/MM talk: waiting for readahead
> > currently implies waiting for the folio lock (there is no separate
> > readahead flag like there would be for writeback).
> > 
> > The more I look into this and fuse, the more I realize that what fuse
> > does is just completely broken right now.
> > 
> >>> If this is all that is needed for a malicious FUSE server to block
> >>> migration, then it makes no difference if AS_WRITEBACK_INDETERMINATE
> >>> mappings are skipped in migration. A malicious server has easier and
> >>> more powerful ways of blocking migration in FUSE than trying to do it
> >>> through writeback. For a malicious fuse server, we in fact wouldn't
> >>> even get far enough to hit writeback - a write triggers
> >>> aops->write_begin() and a malicious server would deliberately hang
> >>> forever while the folio is locked in write_begin().
> >>
> >> Indeed it seems possible.  A malicious FUSE server may already be
> >> capable of blocking the synchronous migration in this way.
> > 
> > Yes, I think the conclusion is that we should advise people from not
> > using unprivileged FUSE if they care about any features that rely on
> > page migration or page reclaim.
> > 
> >>
> >>
> >>>
> >>> I looked into whether we could eradicate all the places in FUSE where
> >>> we may hold the folio lock for an indeterminate amount of time,
> >>> because if that is possible, then we should not add this writeback way
> >>> for a malicious fuse server to affect migration. But I don't think we
> >>> can, for example taking one case, the folio lock needs to be held as
> >>> we read in the folio from the server when servicing page faults, else
> >>> the page cache would contain stale data if there was a concurrent
> >>> write that happened just before, which would lead to data corruption
> >>> in the filesystem. Imo, we need a more encompassing solution for all
> >>> these cases if we're serious about preventing FUSE from blocking
> >>> migration, which probably looks like a globally enforced default
> >>> timeout of some sort or an mm solution for mitigating the blast radius
> >>> of how much memory can be blocked from migration, but that is outside
> >>> the scope of this patchset and is its own standalone topic.
> > 
> > I'm still skeptical about timeouts: we can only get it wrong.
> > 
> > I think a proper solution is making these pages movable, which does seem
> > feasible if (a) splice is not involved and (b) we can find a way to not
> > hold the folio lock forever e.g., in the readahead case.
> > 
> > Maybe readahead would have to be handled more similar to writeback
> > (e.g., having a separate flag, or using a combination of e.g.,
> > writeback+uptodate flag, not sure)
> > 
> > In both cases (readahead+writeback), we'd want to call into the FS to
> > migrate a folio that is under readahread/writeback. In case of fuse
> > without splice, a migration might be doable, and as discussed, splice
> > might just be avoided.
> 
> My personal take is here that we should move away from splice.
> Keith (or colleague) is working on ZC with io-uring anyway, so
> maybe a good timing. We should just ensure that the new approach
> doesn't have the same issue.

splice is problematic in a lot of other ways too. It's easy to abuse it
for weird userspace hangs since it clings onto the pipe_lock() and no
one wants to do the invasive surgery to wean it off of that. So +1 on
avoiding splice.

