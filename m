Return-Path: <linux-fsdevel+bounces-64566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5FBECD7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A9E621F44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23742EB873;
	Sat, 18 Oct 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzkCl7e2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAF2F361E
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760783156; cv=none; b=LVrkpd22N9MQsQvmas/SzO7wWuZIo3Pbljk8Xg8/0yjuVYeBG8LeSe17FjLDyWC5traygVqYmIEjoy15j+wQdf8qx/s0PCP0XvJx/c+S/Xbd8SjJtn1bcjrmEckBNJNcgPu1/Q0rkhSNwbDvhU/Cacq22M/ugn9hwuOYphzB2ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760783156; c=relaxed/simple;
	bh=QQbG6kV15rymPj05CkGxtyMj6tadP93rjMUP7A7ZXT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrT0Ftu75fszh6G1EtAl3YoXZumizctQ+D1J+HaB6pNibIYNK7TkAH5ul0g2q5u3AakizBgeWWkVI/FBL6MzT0xgCQfXhA9MFyyxv/xO0veCqYJgF/pU+2MTPEnC7QE/fDBuInqZVDwNoHV7cbakdJ8Tf3+Q4yy6nRkQKZOtSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzkCl7e2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760783151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFQYBfi+U3DUIEhKYR9y8oylrruZNrmdqwfmTPsUI64=;
	b=LzkCl7e2NvJELfZxENzDlU67nirV2YILamCaMp4hQQjXdVKqr6DS+J+2gGniX99nodaAe3
	YSu0ocXAXxBH40SSq0ebf7W1iZy70VBEP8xEgCF6HC3+Rmf5DShvZyBwPx7LbyLaj+Kf/o
	SM74o944sngC8abi1bfQE5CDtHZiwnM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-BTDEzx3JOYSQNFv0ygr7YQ-1; Sat,
 18 Oct 2025 06:25:48 -0400
X-MC-Unique: BTDEzx3JOYSQNFv0ygr7YQ-1
X-Mimecast-MFC-AGG-ID: BTDEzx3JOYSQNFv0ygr7YQ_1760783147
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B82F71800637;
	Sat, 18 Oct 2025 10:25:46 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53EC81800586;
	Sat, 18 Oct 2025 10:25:44 +0000 (UTC)
Date: Sat, 18 Oct 2025 06:30:03 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
Message-ID: <aPNsK9D3RtAjccOA@bfoster>
References: <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
 <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
 <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <aPDXIWeTKceHuqkj@bfoster>
 <CAJnrk1YeT8uBLf0e2-+wd6vKMH4Rp9dhHbC0d9eCu1hEwhiANA@mail.gmail.com>
 <aPJhy4kEw0M7vtz-@bfoster>
 <aPKKgctbV4TQ9vid@bfoster>
 <CAJnrk1YLuiRyVwEW6nR1fUnvWf1Ozu1hK4LKn3mRWKeECVyMAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YLuiRyVwEW6nR1fUnvWf1Ozu1hK4LKn3mRWKeECVyMAA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Oct 17, 2025 at 01:19:39PM -0700, Joanne Koong wrote:
> On Fri, Oct 17, 2025 at 11:23 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Fri, Oct 17, 2025 at 11:33:31AM -0400, Brian Foster wrote:
> > > On Thu, Oct 16, 2025 at 03:39:27PM -0700, Joanne Koong wrote:
> > > > On Thu, Oct 16, 2025 at 4:25 AM Brian Foster <bfoster@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 06:27:10PM -0700, Joanne Koong wrote:
> > > > > > On Wed, Oct 15, 2025 at 5:36 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 15, 2025 at 11:39 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > Hi Joanne,
> > > > > > > >
> > > > > > > > On 2025/10/16 02:21, Joanne Koong wrote:
> > > > > > > > > On Wed, Oct 15, 2025 at 11:06 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > >>>
> > > > > > > > >>> This is where I encountered it in erofs: [1] for the "WARNING in
> > > > > > > > >>> iomap_iter_advance" syz repro. (this syzbot report was generated in
> > > > > > > > >>> response to this patchset version [2]).
> > > > > > > > >>>
> > > > > > > > >>> When I ran that syz program locally, I remember seeing pos=116 and length=3980.
> > > > > > > > >>
> > > > > > > > >> I just ran the C repro locally with the upstream codebase (but I
> > > > > > > > >> didn't use the related Kconfig), and it doesn't show anything.
> > > > > > > > >
> > > > > > > > > Which upstream commit are you running it on? It needs to be run on top
> > > > > > > > > of this patchset [1] but without this fix [2]. These changes are in
> > > > > > > > > Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> > > > > > > > > that branch has been published publicly yet so maybe just patching it
> > > > > > > > > in locally will work best.
> > > > > > > > >
> > > > > > > > > When I reproed it last month, I used the syz executor (not the C
> > > > > > > > > repro, though that should probably work too?) directly with the
> > > > > > > > > kconfig they had.
> > > > > > > >
> > > > > > > > I believe it's a regression somewhere since it's a valid
> > > > > > > > IOMAP_INLINE extent (since it's inlined, the length is not
> > > > > > > > block-aligned of course), you could add a print just before
> > > > > > > > erofs_iomap_begin() returns.
> > > > > > >
> > > > > > > Ok, so if erofs is strictly block-aligned except for tail inline data
> > > > > > > (eg the IOMAP_INLINE extent), then I agree, there is a regression
> > > > > > > somewhere as we shouldn't be running into the situation where erofs is
> > > > > > > calling iomap_adjust_read_range() with a non-block-aligned position
> > > > > > > and length. I'll track the offending commit down tomorrow.
> > > > > > >
> > > > > >
> > > > > > Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
> > > > > > iomap_iter advances") that changed this behavior for erofs such that
> > > > > > the read iteration continues even after encountering an IOMAP_INLINE
> > > > > > extent, whereas before, the iteration stopped after reading in the
> > > > > > iomap inline extent. This leads erofs to end up in the situation where
> > > > > > it calls into iomap_adjust_read_range() with a non-block-aligned
> > > > > > position/length (on that subsequent iteration).
> > > > > >
> > > > > > In particular, this change in commit bc264fea0f6f to iomap_iter():
> > > > > >
> > > > > > -       if (ret > 0 && !iter->processed && !stale)
> > > > > > +       if (ret > 0 && !advanced && !stale)
> > > > > >
> > > > > > For iomap inline extents, iter->processed is 0, which stopped the
> > > > > > iteration before. But now, advanced (which is iter->pos -
> > > > > > iter->iter_start_pos) is used which will continue the iteration (since
> > > > > > the iter is advanced after reading in the iomap inline extents).
> > > > > >
> > > > > > Erofs is able to handle subsequent iterations after iomap_inline
> > > > > > extents because erofs_iomap_begin() checks the block map and returns
> > > > > > IOMAP_HOLE if it's not mapped
> > > > > >         if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> > > > > >                 iomap->type = IOMAP_HOLE;
> > > > > >                 return 0;
> > > > > >         }
> > > > > >
> > > > > > but I think what probably would be better is a separate patch that
> > > > > > reverts this back to the original behavior of stopping the iteration
> > > > > > after IOMAP_INLINE extents are read in.
> > > > > >
> > > > >
> > > > > Hmm.. so as of commit bc264fea0f6f, it looks like the read_inline() path
> > > > > still didn't advance the iter at all by that point. It just returned 0
> > > > > and this caused iomap_iter() to break out of the iteration loop.
> > > > >
> > > > > The logic noted above in iomap_iter() is basically saying to break out
> > > > > if the iteration did nothing, which is a bit of a hacky way to terminate
> > > > > an IOMAP_INLINE read. The proper thing to do in that path IMO is to
> > > > > report the bytes processed and then terminate some other way more
> > > > > naturally. I see Gao actually fixed this sometime later in commit
> > > > > b26816b4e320 ("iomap: fix inline data on buffered read"), which is when
> > > > > the inline read path started to advance the iter.
> > > >
> > > > That's a good point, the fix in commit b26816b4e320 is what led to the
> > > > new erofs behavior, not commit bc264fea0f6f.
> > > >
> > > > >
> > > > > TBH, the behavior described above where we advance over the inline
> > > > > mapping and then report any remaining iter length as a hole also sounds
> > > > > like reasonably appropriate behavior to me. I suppose you could argue
> > > > > that the inline case should just terminate the iter, which perhaps means
> > > > > it should call iomap_iter_advance_full() instead. That technically
> > > > > hardcodes that we will never process mappings beyond an inline mapping
> > > > > into iomap. That bugs me a little bit, but is also probably always going
> > > > > to be true so doesn't seem like that big of a deal.
> > > >
> > > > Reporting any remaining iter length as a hole also sounds reasonable
> > > > to me but it seems that this may add additional work that may not be
> > > > trivial. For example, I'm looking at erofs's erofs_map_blocks() call
> > > > which they would need to do to figure out it should be an iomap hole.
> > > > It seems a bit nonideal to me that any filesystem using iomap inline
> > > > data would also have to make sure they cover this case, which maybe
> > > > they already need to do that, I'm not sure, but it seems like an extra
> > > > thing they would now need to account for.
> > > >
> > >
> > > To make sure I follow, you're talking about any potential non-erofs
> > > cases, right? I thought it was mentioned that erofs already handled this
> > > correctly by returning a hole. So I take this to mean other users would
> > > need to handle this similarly.
> 
> Yes, sorry if my previous wording was confusing. Erofs already handles
> this correctly but there's some overhead with having to determine it's
> a hole.
> 
> > >
> > > Poking around, I see that ext4 uses iomap and IOMAP_INLINE in a couple
> > > isolated cases. One looks like swapfile activation and the other appears
> > > to be related to fiemap. Any idea if those are working correctly? At
> > > first look it kind of looks like they check and return error for offset
> > > beyond the specified length..
> > >
> >
> > JFYI from digging further.. ext4 returns -ENOENT for this "offset beyond
> > inline size" case. I didn't see any error returns from fiemap/filefrag
> > on a quick test against an inline data file. It looks like
> > iomap_fiemap() actually ignores errors either if the previous mapping is
> > non-hole, or catches -ENOENT explicitly to handle an attribute mapping
> > case. So afaict this all seems to work Ok..
> >
> > I'm not sure this is all that relevant for the swap case. mkswap
> > apparently requires a file at least 40k in size, which iiuc is beyond
> > the scope of files with inline data..
> 
> I think gfs2 also uses IOMAP_INLINE. In __gfs2_iomap_get(), it looks
> like they report a hole if the offset is beyond the inode size, so
> that looks okay.
> 
> >
> > Brian
> >
> > > > One scenario I'm imagining maybe being useful in the future is
> > > > supporting chained inline mappings, in which case we would still want
> > > > to continue processing after the first inline mapping, but we could
> > > > also address that if it does come up.
> > > >
> > >
> > > Yeah..
> > >
> > > > >
> > > > > If we wanted to consider it an optimization so we didn't always do this
> > > > > extra iter on inline files, perhaps another variant of that could be an
> > > > > EOF flag or some such that the fs could set to trigger a full advance
> > > > > after the current mapping. OTOH you could argue that's what inline
> > > > > already is so maybe that's overthinking it. Just a thought. Hm?
> > > > >
> > > >
> > > > Would non-inline iomap types also find that flag helpful or is the
> > > > intention for it to be inline specific? I guess the flag could also be
> > > > used by non-inline types to stop the iteration short, if there's a use
> > > > case for that?
> > > >
> > >
> > > ... I hadn't really considered that. This was just me thinking out loud
> > > about trying to handle things more generically.
> > >
> > > Having thought more about it, I think either way it might just make
> > > sense to fix the inline read case to do the full advance (assuming it is
> > > verified this fixes the problem) to restore historical iomap behavior.
> 
> Hmm, the iter is already fully advanced after the inline data is read.
> I think the issue is that when the iomap mapping length is less than
> the iter len (the iter len will always be the size of the folio but
> the length for the inline data could be less), then advancing it fully
> through iomap_iter_advance_full() will only advance it up to the iomap
> length. iter->len will then still have a positive value which makes
> iomap_iter() continue iterating.
> 

Derp.. yeah, I had my wires crossed thinking the full advance completed
the full request, when really it's just the current iteration. Thanks
for pointing that out.

> I don't see a cleaner way of restoring historical iomap behavior than
> adding that eof/stop flag.
> 

Hmm.. so then aside from the oddly aligned iter case warning that you've
already fixed, ISTM that everything otherwise works correctly, right? If
so, I wouldn't be in a huge rush to do the flag thing.

In theory, there may still be similar options to do what I was thinking,
like perhaps just zero out remaining iter->len in that particular inline
path (maybe via an iomap_iter_advance_inline() helper for example). It's
not totally clear to me it's worth it though if everything is pretty
much working as is.

Brian

> Thanks,
> Joanne
> 
> 
> > > Then if there is ever value to support multiple inline mappings somehow
> > > or another, we could revisit the flag idea.
> 
> > >
> > > Brian
> > >
> > > > Thanks,
> > > > Joanne
> 


