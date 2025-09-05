Return-Path: <linux-fsdevel+bounces-60324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7046AB44AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F365467E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9079CF;
	Fri,  5 Sep 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jATP4Hct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861720ED
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757031275; cv=none; b=SDE2xIDz9zqTRDeKeRq+QA6Rhd4tHMa1iVpJiCMd38HuTHMCHu5K7ga35nAxz3YQ2FoXSOTVMWV9DftJqmNo7jCLWnSbJZbF4azBbfU2Srngdi1hKZNQJOr0RFPq2kUKV7e3vVy8oabGQSfisySDxXzCLexMVH38jdVeFztnXlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757031275; c=relaxed/simple;
	bh=IH4TImD6iwU9xjfyerZBQVLvDtVFitDeZyQccqZmt+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE4sI2B0fAEP53lafygcV4iuV7Spz1A4vnqSTS+3hNxseOre58hrJ6FZru2pIr2rhvbKYglw1EIXa4yq3iXnWQrZDWoKI5iTKftOOqGa8rWCtAAyAfaoKdGLJA3fFcIZNQabUFDqY/qDdk7Iz4nGgr2mTJQMe8qL4BFK2HCF4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jATP4Hct; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b48eabaef3so19163921cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757031272; x=1757636072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsW/czUCbQ7OZLy+yNicQSZepTUp0JVIomaauiZ5/mc=;
        b=jATP4Hctx9aPN/mQB7Ab9q2DxjJJ1EHD7a+xTE4zeFgCyBC2KuJq2+UiCOiD+o0yYJ
         2bPjBm5kOcc+MudaelSKC+OjBHd0eZhmcYQojPIJwfDtmQ3t5uySbe2TuGncXsW6oTxT
         /CXrjPQeV/RmRZ362D2LLZ2ml8Eu9RqbcOrb0e0PvegSQ6Q38db/gjBj2SItrJEWMik+
         upuhHLTS22zDkIm4hSu1hFeKZuD5ZVIZBB1rnwTFfJGVW5NW/jp+azc+8YLtL9+/jNPl
         EiUPjrnDw2Vxmd5uPaqZOkZ35snc3JsB9ZIYuO1eAZIdge3ZfcrjvzLyGkF1d/dAa4ip
         pw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757031272; x=1757636072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsW/czUCbQ7OZLy+yNicQSZepTUp0JVIomaauiZ5/mc=;
        b=rJex67Y+7vi6wNPtYK/P2noWEbOTjeu3QCRiHctt3XeRBVv6LJgFVJ6N6rsQT2vgyc
         I5e8D0qhNKBNWnTMLahojSBBsUKAQ6n+iPaNjc7umw359p1Cf5fbkAnbOYs6/B9dThTy
         mn2++yQOfkUsSJCMrIlfDh2UWMN/Jq3DLZ5lJTt7Zp9LgzjUn7lKHkmT1uszzZh6BU/P
         7sEwXlDgiL1z/adO4LbpjypVETe311XuRDTbEwExCwaZaQhjHIaZMDhJvi3XuCNny5o7
         dtgwpoHFwbbJBfXf1vGCB3ch67XPI1jSRMGoW852QZnpFRJkqd7TP2mAS6Kuv0GZkQra
         ohGA==
X-Forwarded-Encrypted: i=1; AJvYcCWsHHtto38TN2e1X7/Vc5YVWOkoHMlTsRHCivXpADpIDTkjZ3xzuybaEI2UTE9xfn55U+dLG4laFy447xN1@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhBXv61O049x+LVHaNrmQYR7KmGkYTX33F01OjoGCzAl14lUN
	oK4c2BuoXP4muun8DHy+yauYmmJwxpoaj+7+Qnu5yES1lDhVW49uw+PMtAlGOZngtMzTfnsS3sC
	FVfTZUVXzmUfg1+3PYnl2RF0fdCgutXV0FOEQ
X-Gm-Gg: ASbGnctSWFQT3KA/frdlXrVV1RCDG+s/VfRFB/zy6ZHZ4CC6VKRw8SFgiwYJVAQ/lv2
	QYu86qSqFOkqni/6fy8ws+JkrEWtzsO+FTMlRXpBlwbeqhA9+b8N02UBoMZotWard2DTtdAj9r1
	mA74nL2y1TanSGHid7AuzNZc852kEuWB3JDsxrDfVWunpjrVq+V+gfrr3aJ9EyiFRwFLL8swznP
	FoEy7YloYpWGBKiLIU=
X-Google-Smtp-Source: AGHT+IGEID8qAurpsErvZKNzDIpmP9VV/rHLEbw2pWPHg3bzNSQDoXQs1n+nPyAcatHBOhMGKo32MfCxhIma055fDIs=
X-Received: by 2002:a05:622a:4106:b0:4b4:7b4d:281f with SMTP id
 d75a77b69052e-4b47b4d29e5mr130092351cf.52.1757031272144; Thu, 04 Sep 2025
 17:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
 <20250829233942.3607248-13-joannelkoong@gmail.com> <20250902234604.GC1587915@frogsfrogsfrogs>
 <aLiNYdLaMIslxySo@bfoster> <CAJnrk1Z6qKqkOwHJwaBfE9FEGABGD4JKoEwNbRJTpOWL-VtPrg@mail.gmail.com>
 <aLl8P8Qzn1IDw_7j@bfoster> <20250904200749.GZ1587915@frogsfrogsfrogs>
In-Reply-To: <20250904200749.GZ1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 17:14:21 -0700
X-Gm-Features: Ac12FXwoE8ZTOsJHqeSMAAV3bMzh9nzvAn_uf7_dz4rvHllVYtbQbbm-98UHeiE
Message-ID: <CAJnrk1aD=n1NzyxgftoQfvC83OO73w2E7ChvGHAh5xfxKrM86Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] iomap: add granular dirty and writeback accounting
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-mm@kvack.org, brauner@kernel.org, 
	willy@infradead.org, jack@suse.cz, hch@infradead.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 1:07=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Thu, Sep 04, 2025 at 07:47:11AM -0400, Brian Foster wrote:
> > On Wed, Sep 03, 2025 at 05:35:51PM -0700, Joanne Koong wrote:
> > > On Wed, Sep 3, 2025 at 11:44=E2=80=AFAM Brian Foster <bfoster@redhat.=
com> wrote:
> > > >
> > > > On Tue, Sep 02, 2025 at 04:46:04PM -0700, Darrick J. Wong wrote:
> > > > > On Fri, Aug 29, 2025 at 04:39:42PM -0700, Joanne Koong wrote:
> > > > > > Add granular dirty and writeback accounting for large folios. T=
hese
> > > > > > stats are used by the mm layer for dirty balancing and throttli=
ng.
> > > > > > Having granular dirty and writeback accounting helps prevent
> > > > > > over-aggressive balancing and throttling.
> > > > > >
> > > > > > There are 4 places in iomap this commit affects:
> > > > > > a) filemap dirtying, which now calls filemap_dirty_folio_pages(=
)
> > > > > > b) writeback_iter with setting the wbc->no_stats_accounting bit=
 and
> > > > > > calling clear_dirty_for_io_stats()
> > > > > > c) starting writeback, which now calls __folio_start_writeback(=
)
> > > > > > d) ending writeback, which now calls folio_end_writeback_pages(=
)
> > > > > >
> > > > > > This relies on using the ifs->state dirty bitmap to track dirty=
 pages in
> > > > > > the folio. As such, this can only be utilized on filesystems wh=
ere the
> > > > > > block size >=3D PAGE_SIZE.
> > > > >
> > > > > Er... is this statement correct?  I thought that you wanted the g=
ranular
> > > > > dirty page accounting when it's possible that individual sub-page=
s of a
> > > > > folio could be dirty.
> > > > >
> > > > > If i_blocksize >=3D PAGE_SIZE, then we'll have set the min folio =
order and
> > > > > there will be exactly one (large) folio for a single fsblock.  Wr=
iteback
> > >
> > > Oh interesting, this is the part I'm confused about. With i_blocksize
> > > >=3D PAGE_SIZE, isn't there still the situation where the folio itsel=
f
> > > could be a lot larger, like 1MB? That's what I've been seeing on fuse
> > > where "blocksize" =3D=3D PAGE_SIZE =3D=3D 4096. I see that xfs sets t=
he min
> > > folio order through mapping_set_folio_min_order() but I'm not seeing
> > > how that ensures "there will be exactly one large folio for a single
> > > fsblock"? My understanding is that that only ensures the folio is at
> > > least the size of the fsblock but that the folio size can be larger
> > > than that too. Am I understanding this incorrectly?
> > >
> > > > > must happen in units of fsblocks, so there's no point in doing th=
e extra
> > > > > accounting calculations if there's only one fsblock.
> > > > >
> > > > > Waitaminute, I think the logic to decide if you're going to use t=
he
> > > > > granular accounting is:
> > > > >
> > > > >       (folio_size > PAGE_SIZE && folio_size > i_blocksize)
> > > > >
> > >
> > > Yeah, you're right about this - I had used "ifs && i_blocksize >=3D
> > > PAGE_SIZE" as the check, which translates to "i_blocks_per_folio > 1
> > > && i_block_size >=3D PAGE_SIZE", which in effect does the same thing =
as
> > > what you wrote but has the additional (and now I'm realizing,
> > > unnecessary) stipulation that block_size can't be less than PAGE_SIZE=
.
> > >
> > > > > Hrm?
> > > > >
> > > >
> > > > I'm also a little confused why this needs to be restricted to block=
size
> > > > gte PAGE_SIZE. The lower level helpers all seem to be managing bloc=
k
> > > > ranges, and then apparently just want to be able to use that direct=
ly as
> > > > a page count (for accounting purposes).
> > > >
> > > > Is there any reason the lower level functions couldn't return block
> > > > units, then the higher level code can use a blocks_per_page or some=
 such
> > > > to translate that to a base page count..? As Darrick points out I a=
ssume
> > > > you'd want to shortcut the folio_nr_pages() =3D=3D 1 case to use a =
min page
> > > > count of 1, but otherwise ISTM that would allow this to work with
> > > > configs like 64k pagesize and 4k blocks as well. Am I missing somet=
hing?
> > > >
> > >
> > > No, I don't think you're missing anything, it should have been done
> > > like this in the first place.
> > >
> >
> > Ok. Something that came to mind after thinking about this some more is
> > whether there is risk for the accounting to get wonky.. For example,
> > consider 4k blocks, 64k pages, and then a large folio on top of that. I=
f
> > a couple or so blocks are dirtied at one time, you'd presumably want to
> > account that as the minimum of 1 dirty page. Then if a couple more
> > blocks are dirtied in the same large folio, how do you determine whethe=
r
> > those blocks are a newly dirtied page or part of the already accounted
> > dirty page? I wonder if perhaps this is the value of the no sub-page
> > sized blocks restriction, because you can imply that newly dirtied
> > blocks means newly dirtied pages..?
> >
> > I suppose if that is an issue it might still be manageable. Perhaps we'=
d
> > have to scan the bitmap in blks per page windows and use that to
> > determine how many base pages are accounted for at any time. So for
> > example, 3 dirty 4k blocks all within the same 64k page size window
> > still accounts as 1 dirty page, vs. dirty blocks in multiple page size
> > windows might mean multiple dirty pages, etc. That way writeback
> > accounting remains consistent with dirty accounting. Hm?
>
> Yes, I think that's correct -- one has to track which basepages /were/
> dirty, and then which ones become dirty after updating the ifs dirty
> bitmap.
>
> For example, if you have a 1k fsblock filesystem, 4k base pages, and a
> 64k folio, you could write a single byte at offset 0, then come back and
> write to a byte at offset 1024.  The first write will result in a charge
> of one basepage, but so will the second, I think.  That results
> incharges for two dirty pages, when you've really only dirtied a single
> basepage.

Does it matter though which blocks map to which pages? AFAIU, the
"block size" is the granularity for disk io and is not really related
to pages (eg for writing out to disk, only the block gets written, not
the whole page). The stats (as i understand it) are used to throttle
how much data gets written back to disk, and the primary thing it
cares about is how many bytes that is, not how many pages, it's just
that it's in PAGE_SIZE granularity because prior to iomap there was no
dirty tracking of individual blocks within a page/folio; it seems like
it suffices then to just keep track of  total # of dirty blocks,
multiply that by blocksize, and roundup divide that by PAGE_SIZE and
pass that to the stats.

But, as Jan pointed out to me in his comment, the stats are also used
for monitoring the health of reclaim, so maybe it does matter then how
the blocks translate to pages.

I'll put this patchset on hold until there's more feedback from the mm
side as to whether we should proceed or drop this.


Thanks,
Joanne


>
> Also, does (block_size >> PAGE_SHIFT) evaluate to ... zero?
>
> --D
>
> > Brian

