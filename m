Return-Path: <linux-fsdevel+bounces-64510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B955BEB35E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE8EE4F70FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3833291D;
	Fri, 17 Oct 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLqoHszD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1D2FFFA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725384; cv=none; b=p1lrYmcqDQ7QnPtpnYNUFnRYD61cMUrVerJwToIv2bYhd66Ts44Kgkae0wGxATCuY8/UAyBUWt7nrTxM/wMCLgnU0tIeB4Yo8czB4iu2pCFmqUbDrcxpoOgf1OYR3hKCVUjAoEkgaWOfIQaKEZvazRUR6gTZwrS+FFWrsW+21ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725384; c=relaxed/simple;
	bh=Vf4vVaT+sV+PpWlDRyAK2gGv2onaepF96k6hC4mEm2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCJUTo71dqwjgy5wAm8wsAKaI3/tgyqVkydYcwU8o+Ax2W4BpzwEAiWCF1pfBCka0RSrufH8ok+rDAKo/+MfJx2bBCbD/5DDKEoxQXzjxfXgi2bV+35SILAr7/RlKroPRnMxGT8lz0e187A85CrNzJMKGho9aLbYy/RL09V4KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLqoHszD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760725380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DApuC5LYiNEMzGOPV0lFHiz2II5x9jSsKedD1XftBEM=;
	b=QLqoHszDGNB7ny64tjE21i0uZuMOBguGaj5YA9rU9cPiF9t7nraNfEq9pZxb1NGs48+7BW
	WJKuITH/e1tRAe/t+7XIoA5DEZj799FZkOUnhdGmv30cmKJVmEp8yE+x1mN1FKPnRTaBpD
	wsZCvMnNYa6qqMEscOeYhhIY82gtBts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-4R7oyhwjPT68u4d6MTjAHw-1; Fri,
 17 Oct 2025 14:22:57 -0400
X-MC-Unique: 4R7oyhwjPT68u4d6MTjAHw-1
X-Mimecast-MFC-AGG-ID: 4R7oyhwjPT68u4d6MTjAHw_1760725376
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAF0618002EC;
	Fri, 17 Oct 2025 18:22:55 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63DA319560AD;
	Fri, 17 Oct 2025 18:22:54 +0000 (UTC)
Date: Fri, 17 Oct 2025 14:27:13 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
Message-ID: <aPKKgctbV4TQ9vid@bfoster>
References: <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
 <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
 <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
 <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <aPDXIWeTKceHuqkj@bfoster>
 <CAJnrk1YeT8uBLf0e2-+wd6vKMH4Rp9dhHbC0d9eCu1hEwhiANA@mail.gmail.com>
 <aPJhy4kEw0M7vtz-@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPJhy4kEw0M7vtz-@bfoster>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Oct 17, 2025 at 11:33:31AM -0400, Brian Foster wrote:
> On Thu, Oct 16, 2025 at 03:39:27PM -0700, Joanne Koong wrote:
> > On Thu, Oct 16, 2025 at 4:25 AM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 06:27:10PM -0700, Joanne Koong wrote:
> > > > On Wed, Oct 15, 2025 at 5:36 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 11:39 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > > >
> > > > > > Hi Joanne,
> > > > > >
> > > > > > On 2025/10/16 02:21, Joanne Koong wrote:
> > > > > > > On Wed, Oct 15, 2025 at 11:06 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > >>>
> > > > > > >>> This is where I encountered it in erofs: [1] for the "WARNING in
> > > > > > >>> iomap_iter_advance" syz repro. (this syzbot report was generated in
> > > > > > >>> response to this patchset version [2]).
> > > > > > >>>
> > > > > > >>> When I ran that syz program locally, I remember seeing pos=116 and length=3980.
> > > > > > >>
> > > > > > >> I just ran the C repro locally with the upstream codebase (but I
> > > > > > >> didn't use the related Kconfig), and it doesn't show anything.
> > > > > > >
> > > > > > > Which upstream commit are you running it on? It needs to be run on top
> > > > > > > of this patchset [1] but without this fix [2]. These changes are in
> > > > > > > Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> > > > > > > that branch has been published publicly yet so maybe just patching it
> > > > > > > in locally will work best.
> > > > > > >
> > > > > > > When I reproed it last month, I used the syz executor (not the C
> > > > > > > repro, though that should probably work too?) directly with the
> > > > > > > kconfig they had.
> > > > > >
> > > > > > I believe it's a regression somewhere since it's a valid
> > > > > > IOMAP_INLINE extent (since it's inlined, the length is not
> > > > > > block-aligned of course), you could add a print just before
> > > > > > erofs_iomap_begin() returns.
> > > > >
> > > > > Ok, so if erofs is strictly block-aligned except for tail inline data
> > > > > (eg the IOMAP_INLINE extent), then I agree, there is a regression
> > > > > somewhere as we shouldn't be running into the situation where erofs is
> > > > > calling iomap_adjust_read_range() with a non-block-aligned position
> > > > > and length. I'll track the offending commit down tomorrow.
> > > > >
> > > >
> > > > Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
> > > > iomap_iter advances") that changed this behavior for erofs such that
> > > > the read iteration continues even after encountering an IOMAP_INLINE
> > > > extent, whereas before, the iteration stopped after reading in the
> > > > iomap inline extent. This leads erofs to end up in the situation where
> > > > it calls into iomap_adjust_read_range() with a non-block-aligned
> > > > position/length (on that subsequent iteration).
> > > >
> > > > In particular, this change in commit bc264fea0f6f to iomap_iter():
> > > >
> > > > -       if (ret > 0 && !iter->processed && !stale)
> > > > +       if (ret > 0 && !advanced && !stale)
> > > >
> > > > For iomap inline extents, iter->processed is 0, which stopped the
> > > > iteration before. But now, advanced (which is iter->pos -
> > > > iter->iter_start_pos) is used which will continue the iteration (since
> > > > the iter is advanced after reading in the iomap inline extents).
> > > >
> > > > Erofs is able to handle subsequent iterations after iomap_inline
> > > > extents because erofs_iomap_begin() checks the block map and returns
> > > > IOMAP_HOLE if it's not mapped
> > > >         if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> > > >                 iomap->type = IOMAP_HOLE;
> > > >                 return 0;
> > > >         }
> > > >
> > > > but I think what probably would be better is a separate patch that
> > > > reverts this back to the original behavior of stopping the iteration
> > > > after IOMAP_INLINE extents are read in.
> > > >
> > >
> > > Hmm.. so as of commit bc264fea0f6f, it looks like the read_inline() path
> > > still didn't advance the iter at all by that point. It just returned 0
> > > and this caused iomap_iter() to break out of the iteration loop.
> > >
> > > The logic noted above in iomap_iter() is basically saying to break out
> > > if the iteration did nothing, which is a bit of a hacky way to terminate
> > > an IOMAP_INLINE read. The proper thing to do in that path IMO is to
> > > report the bytes processed and then terminate some other way more
> > > naturally. I see Gao actually fixed this sometime later in commit
> > > b26816b4e320 ("iomap: fix inline data on buffered read"), which is when
> > > the inline read path started to advance the iter.
> > 
> > That's a good point, the fix in commit b26816b4e320 is what led to the
> > new erofs behavior, not commit bc264fea0f6f.
> > 
> > >
> > > TBH, the behavior described above where we advance over the inline
> > > mapping and then report any remaining iter length as a hole also sounds
> > > like reasonably appropriate behavior to me. I suppose you could argue
> > > that the inline case should just terminate the iter, which perhaps means
> > > it should call iomap_iter_advance_full() instead. That technically
> > > hardcodes that we will never process mappings beyond an inline mapping
> > > into iomap. That bugs me a little bit, but is also probably always going
> > > to be true so doesn't seem like that big of a deal.
> > 
> > Reporting any remaining iter length as a hole also sounds reasonable
> > to me but it seems that this may add additional work that may not be
> > trivial. For example, I'm looking at erofs's erofs_map_blocks() call
> > which they would need to do to figure out it should be an iomap hole.
> > It seems a bit nonideal to me that any filesystem using iomap inline
> > data would also have to make sure they cover this case, which maybe
> > they already need to do that, I'm not sure, but it seems like an extra
> > thing they would now need to account for.
> > 
> 
> To make sure I follow, you're talking about any potential non-erofs
> cases, right? I thought it was mentioned that erofs already handled this
> correctly by returning a hole. So I take this to mean other users would
> need to handle this similarly.
> 
> Poking around, I see that ext4 uses iomap and IOMAP_INLINE in a couple
> isolated cases. One looks like swapfile activation and the other appears
> to be related to fiemap. Any idea if those are working correctly? At
> first look it kind of looks like they check and return error for offset
> beyond the specified length..
> 

JFYI from digging further.. ext4 returns -ENOENT for this "offset beyond
inline size" case. I didn't see any error returns from fiemap/filefrag
on a quick test against an inline data file. It looks like
iomap_fiemap() actually ignores errors either if the previous mapping is
non-hole, or catches -ENOENT explicitly to handle an attribute mapping
case. So afaict this all seems to work Ok..

I'm not sure this is all that relevant for the swap case. mkswap
apparently requires a file at least 40k in size, which iiuc is beyond
the scope of files with inline data..

Brian

> > One scenario I'm imagining maybe being useful in the future is
> > supporting chained inline mappings, in which case we would still want
> > to continue processing after the first inline mapping, but we could
> > also address that if it does come up.
> > 
> 
> Yeah..
> 
> > >
> > > If we wanted to consider it an optimization so we didn't always do this
> > > extra iter on inline files, perhaps another variant of that could be an
> > > EOF flag or some such that the fs could set to trigger a full advance
> > > after the current mapping. OTOH you could argue that's what inline
> > > already is so maybe that's overthinking it. Just a thought. Hm?
> > >
> > 
> > Would non-inline iomap types also find that flag helpful or is the
> > intention for it to be inline specific? I guess the flag could also be
> > used by non-inline types to stop the iteration short, if there's a use
> > case for that?
> > 
> 
> ... I hadn't really considered that. This was just me thinking out loud
> about trying to handle things more generically.
> 
> Having thought more about it, I think either way it might just make
> sense to fix the inline read case to do the full advance (assuming it is
> verified this fixes the problem) to restore historical iomap behavior.
> Then if there is ever value to support multiple inline mappings somehow
> or another, we could revisit the flag idea.
> 
> Brian
> 
> > Thanks,
> > Joanne
> > 
> > > Brian
> > >
> > > > So I don't think this patch should have a fixes: tag for that commit.
> > > > It seems to me like no one was hitting this path before with a
> > > > non-block-aligned position and offset. Though now there will be a use
> > > > case for it, which is fuse.
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > >
> > > > > > Also see my reply:
> > > > > > https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.alibaba.com
> > > > > >
> > > > > > I'm not sure if it caused user-visible regressions since
> > > > > > erofs images work properly with upstream code (unlike a
> > > > > > previous regression fixed by commit b26816b4e320 ("iomap:
> > > > > > fix inline data on buffered read")).
> > > > > >
> > > > > > But a fixes tag is needed since it causes an unexpected
> > > > > > WARNING at least.
> > > > > >
> > > > > > Thanks,
> > > > > > Gao Xiang
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Joanne
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t
> > > > > > > [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/
> > > > > > > [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> > > > > > >
> > > > > > >>
> > > > > > >> I feel strange why pos is unaligned, does this warning show
> > > > > > >> without your patchset on your side?
> > > > > > >>
> > > > > > >> Thanks,
> > > > > > >> Gao Xiang
> > > > > > >>
> > > > > > >>>
> > > > > > >>> Thanks,
> > > > > > >>> Joanne
> > > > > > >>>
> > > > > > >>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> > > > > > >>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/
> > > > > > >>>
> > > > > > >>>>
> > > > > > >>>> Thanks,
> > > > > > >>>> Gao Xiang
> > > > > > >>>>
> > > > > > >>>>>
> > > > > > >>>>>
> > > > > > >>>>> Thanks,
> > > > > > >>>>> Joanne
> > > > > > >>>>>
> > > > > > >>>>>>
> > > > > > >>>>>> Otherwise looks good:
> > > > > > >>>>>>
> > > > > > >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > > > >>>>
> > > > > > >>
> > > > > >
> > > >
> > >
> > 
> 
> 


