Return-Path: <linux-fsdevel+bounces-64361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1750BE30BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48492424629
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7263164B6;
	Thu, 16 Oct 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fq577kAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F77263B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613928; cv=none; b=JLy1iAvlu2+h3bnxiRAwkyS1jdnbLEwpAkzfD1aAXDny8AlVdTM54awSkkgUG0bL4wWF4Fz0ymvmSZ/IqNSj2fktGWdIM6EjceiQjvTJuiYnqN0s4ObYJ0CRs1B+l+bzxQl8P69q5v3BvlWf6KaDPP2XKjn48GlRkuY4d36CL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613928; c=relaxed/simple;
	bh=CzOvjXb94uUmXv0n1NQKoUJCyNCYWr+KrcU/l+NbOCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7hhOmg8jZcoVLEI4ZjMYB1REEp2T8AOR7ZuB+20y8wR5P5tBdvW4TU6SrL2j3EV4iXXiuKxlghESKMbHj8iv7/LaQ1m5RleOuY+kpZtIZT0MhiIFadz3IKJfj/eQ7SwfDzCMaM8wXjcWarJ4lCzvB4pvZDcjqhf0RMm4FKTIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fq577kAh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760613925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG5WzkCZ+DOLbqii8Ha+LD9sIOAQulM3CbCiVp+K3pU=;
	b=Fq577kAhdAFyMTXYo1iQ5YzYMf31eYKR2ze0jaJePxRZXNgbntUskFNsCr8zKAUEaM97uV
	m7s7l2Koa875QKiFnqzzkhZJ7h0Y6bj2wJxFZCxRNJy43TMfkYatSaFtUnNVOi+nPQnPdQ
	Ayax6XvEp9LFlaYM29GtLMbGKWMuAkk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-jL8vxzLRMymL6zJv4YQsRw-1; Thu,
 16 Oct 2025 07:25:21 -0400
X-MC-Unique: jL8vxzLRMymL6zJv4YQsRw-1
X-Mimecast-MFC-AGG-ID: jL8vxzLRMymL6zJv4YQsRw_1760613920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09D2C19560B5;
	Thu, 16 Oct 2025 11:25:20 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76A32300019F;
	Thu, 16 Oct 2025 11:25:18 +0000 (UTC)
Date: Thu, 16 Oct 2025 07:29:37 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
Message-ID: <aPDXIWeTKceHuqkj@bfoster>
References: <20251009225611.3744728-2-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
 <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
 <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
 <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 15, 2025 at 06:27:10PM -0700, Joanne Koong wrote:
> On Wed, Oct 15, 2025 at 5:36 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 11:39 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >
> > > Hi Joanne,
> > >
> > > On 2025/10/16 02:21, Joanne Koong wrote:
> > > > On Wed, Oct 15, 2025 at 11:06 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > >
> > > ...
> > >
> > > >>>
> > > >>> This is where I encountered it in erofs: [1] for the "WARNING in
> > > >>> iomap_iter_advance" syz repro. (this syzbot report was generated in
> > > >>> response to this patchset version [2]).
> > > >>>
> > > >>> When I ran that syz program locally, I remember seeing pos=116 and length=3980.
> > > >>
> > > >> I just ran the C repro locally with the upstream codebase (but I
> > > >> didn't use the related Kconfig), and it doesn't show anything.
> > > >
> > > > Which upstream commit are you running it on? It needs to be run on top
> > > > of this patchset [1] but without this fix [2]. These changes are in
> > > > Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> > > > that branch has been published publicly yet so maybe just patching it
> > > > in locally will work best.
> > > >
> > > > When I reproed it last month, I used the syz executor (not the C
> > > > repro, though that should probably work too?) directly with the
> > > > kconfig they had.
> > >
> > > I believe it's a regression somewhere since it's a valid
> > > IOMAP_INLINE extent (since it's inlined, the length is not
> > > block-aligned of course), you could add a print just before
> > > erofs_iomap_begin() returns.
> >
> > Ok, so if erofs is strictly block-aligned except for tail inline data
> > (eg the IOMAP_INLINE extent), then I agree, there is a regression
> > somewhere as we shouldn't be running into the situation where erofs is
> > calling iomap_adjust_read_range() with a non-block-aligned position
> > and length. I'll track the offending commit down tomorrow.
> >
> 
> Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
> iomap_iter advances") that changed this behavior for erofs such that
> the read iteration continues even after encountering an IOMAP_INLINE
> extent, whereas before, the iteration stopped after reading in the
> iomap inline extent. This leads erofs to end up in the situation where
> it calls into iomap_adjust_read_range() with a non-block-aligned
> position/length (on that subsequent iteration).
> 
> In particular, this change in commit bc264fea0f6f to iomap_iter():
> 
> -       if (ret > 0 && !iter->processed && !stale)
> +       if (ret > 0 && !advanced && !stale)
> 
> For iomap inline extents, iter->processed is 0, which stopped the
> iteration before. But now, advanced (which is iter->pos -
> iter->iter_start_pos) is used which will continue the iteration (since
> the iter is advanced after reading in the iomap inline extents).
> 
> Erofs is able to handle subsequent iterations after iomap_inline
> extents because erofs_iomap_begin() checks the block map and returns
> IOMAP_HOLE if it's not mapped
>         if (!(map.m_flags & EROFS_MAP_MAPPED)) {
>                 iomap->type = IOMAP_HOLE;
>                 return 0;
>         }
> 
> but I think what probably would be better is a separate patch that
> reverts this back to the original behavior of stopping the iteration
> after IOMAP_INLINE extents are read in.
> 

Hmm.. so as of commit bc264fea0f6f, it looks like the read_inline() path
still didn't advance the iter at all by that point. It just returned 0
and this caused iomap_iter() to break out of the iteration loop.

The logic noted above in iomap_iter() is basically saying to break out
if the iteration did nothing, which is a bit of a hacky way to terminate
an IOMAP_INLINE read. The proper thing to do in that path IMO is to
report the bytes processed and then terminate some other way more
naturally. I see Gao actually fixed this sometime later in commit
b26816b4e320 ("iomap: fix inline data on buffered read"), which is when
the inline read path started to advance the iter.

TBH, the behavior described above where we advance over the inline
mapping and then report any remaining iter length as a hole also sounds
like reasonably appropriate behavior to me. I suppose you could argue
that the inline case should just terminate the iter, which perhaps means
it should call iomap_iter_advance_full() instead. That technically
hardcodes that we will never process mappings beyond an inline mapping
into iomap. That bugs me a little bit, but is also probably always going
to be true so doesn't seem like that big of a deal.

If we wanted to consider it an optimization so we didn't always do this
extra iter on inline files, perhaps another variant of that could be an
EOF flag or some such that the fs could set to trigger a full advance
after the current mapping. OTOH you could argue that's what inline
already is so maybe that's overthinking it. Just a thought. Hm?

Brian

> So I don't think this patch should have a fixes: tag for that commit.
> It seems to me like no one was hitting this path before with a
> non-block-aligned position and offset. Though now there will be a use
> case for it, which is fuse.
> 
> Thanks,
> Joanne
> 
> >
> > Thanks,
> > Joanne
> >
> > >
> > > Also see my reply:
> > > https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.alibaba.com
> > >
> > > I'm not sure if it caused user-visible regressions since
> > > erofs images work properly with upstream code (unlike a
> > > previous regression fixed by commit b26816b4e320 ("iomap:
> > > fix inline data on buffered read")).
> > >
> > > But a fixes tag is needed since it causes an unexpected
> > > WARNING at least.
> > >
> > > Thanks,
> > > Gao Xiang
> > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#t
> > > > [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/
> > > > [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> > > >
> > > >>
> > > >> I feel strange why pos is unaligned, does this warning show
> > > >> without your patchset on your side?
> > > >>
> > > >> Thanks,
> > > >> Gao Xiang
> > > >>
> > > >>>
> > > >>> Thanks,
> > > >>> Joanne
> > > >>>
> > > >>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606bef
> > > >>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE@google.com/
> > > >>>
> > > >>>>
> > > >>>> Thanks,
> > > >>>> Gao Xiang
> > > >>>>
> > > >>>>>
> > > >>>>>
> > > >>>>> Thanks,
> > > >>>>> Joanne
> > > >>>>>
> > > >>>>>>
> > > >>>>>> Otherwise looks good:
> > > >>>>>>
> > > >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > >>>>
> > > >>
> > >
> 


