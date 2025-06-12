Return-Path: <linux-fsdevel+bounces-51394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C33AD664A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE0B7A54D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADFB1DE8AE;
	Thu, 12 Jun 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4r/q+y4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193F1A5B92;
	Thu, 12 Jun 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700418; cv=none; b=FI+dNF73Zx1KFlqFhQILS2DBV59bhMzEm5/5aQi7IRrRQsDNs1O+ixXwjpjMDVsQETFXYeV0sjUJ1pgdZ27E+RMV7bxeO+F9qVb7xyussVnsI9LeTcwtbiKTgv363eS2uWrer0HPg+FGDXFg/0Yc989ZhHvjqQAtaxgtpi7/Fxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700418; c=relaxed/simple;
	bh=LoGqnQT5Bn3seaxONVKi0W3Etp9RzaFlHJcm/jONMC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWLDWk42ocDS1EVC97kRwh4V9XlAbR+RNukjJPtXU5IMfwoUJMiOQI5ree4dvKeTHHY8nZrgjqGPPvRaGEJuhm7oS6zfpso0KYoBy+99M8+CDpikgkUJ44yan80D0jub+cjf4EB5MqA6BHFSXHOSVtUKDn1drM3esFnUMIH9pNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4r/q+y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CF0C4CEEA;
	Thu, 12 Jun 2025 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749700418;
	bh=LoGqnQT5Bn3seaxONVKi0W3Etp9RzaFlHJcm/jONMC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4r/q+y4YVHuRZQzrdqyb/Nv3gp/zcdVGssjHA5rO4+qmZG9Q6togV+q9FaNvmCVQ
	 d/fOme4s9fMV8s10vbqLeKbNC1P/kZcSePiK+NVJDwACE3OtjKwzNRHQwZQIidyWhf
	 N8N09+GNAYWhtHDLgVmZAr0opg7V1FKKOSAyDaIj6i5cm9Jy2m7wmJx42TWPryGljz
	 LG8dh2NLvulvRX0w0PYLspGGoDAhJ4C8L1QN/rsnRqnklV0j+JHnZMc8YJ6RHPu/UI
	 c18xlfH2K3tvTw6SH0mj9pxIIxS4lS8IKFxezVa70i7dbyYLNKb3yvMeYWOHii+Byc
	 zlJUMm1Q1mVDQ==
Date: Wed, 11 Jun 2025 20:53:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <20250612035337.GH6138@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
 <20250609162432.GI6156@frogsfrogsfrogs>
 <CAJnrk1aUJzN-c-jd0WzH8rb1R5rYdcnq=_RWMNobbQEk9_C7Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aUJzN-c-jd0WzH8rb1R5rYdcnq=_RWMNobbQEk9_C7Wg@mail.gmail.com>

On Mon, Jun 09, 2025 at 02:28:52PM -0700, Joanne Koong wrote:
> On Mon, Jun 9, 2025 at 9:24 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jun 06, 2025 at 04:37:57PM -0700, Joanne Koong wrote:
> > > Add a new iomap type, IOMAP_IN_MEM, that represents data that resides in
> > > memory and does not map to or depend on the block layer and is not
> > > embedded inline in an inode. This will be used for example by filesystems
> > > such as FUSE where the data is in memory or needs to be fetched from a
> > > server and is not coupled with the block layer. This lets these
> > > filesystems use some of the internal features in iomaps such as
> > > granular dirty tracking for large folios.
> >
> > How does this differ from using IOMAP_INLINE and setting
> > iomap::inline_data = kmap_local_folio(...)?  Is the situation here that
> > FUSE already /has/ a folio from the mapping, so all you really need
> > iomap to do is manage the folio's uptodate/dirty state?
> >
> 
> I had looked into whether IOMAP_INLINE could be used but there are a few issues:
> 
> a) no granular uptodate reading of the folio if the folio needs to be
> read into the page cache
> If fuse uses IOMAP_INLINE then it'll need to read in all the bytes of
> whatever needs to be written into the folio because the IOMAP_INLINE
> points to one contiguous memory region, not different chunks. For
> example if there's a 2 MB file and position 0 to 1 MB of the file is
> represented by a 1 MB folio, and a client issues a write from position
> 1 to 1048575, we'll need to read in the entire folio instead of just
> the first and last chunks.

Well we could modify the IOMAP_INLINE code to handle iomap::offset > 0
so you could keep feeding the pagecache inline mappings as packets of
data become available.  But that statement is missing the point, since I
think you already /have/ the folios populated and stuffed in i_mapping;
you just need iomap for the sub-folio state tracking when things get
dirty.

> b) an extra memcpy is incurred if the folio needs to be read in (extra
> read comes from reading inline data into folio) and an extra memcpy is
> incurred after the write (extra write comes from writing from folio ->
> inline data)
> IOMAP_INLINE copies the inline data into the folio
> (iomap_write_begin_inline() -> iomap_read_inline_data() ->
> folio_fill_tail()) but for fuse, the folio would already have had to
> been fetched from the server in fuse's ->iomap_begin callback (and
> similarly, the  folio tail zeroing and dcache flush will be
> unnecessary work here too). When the write is finished, there's an
> extra memcpy incurred from iomap_write_end_inline() copying data from
> the folio back to inline data (for fuse, inline data is already the
> folio).
> 
> I guess we could add some flag that the filesystem can set in
> ->iomap_begin() to indicate that it's an IOMAP_INLINE type where the
> mem is the folio being written, but that still doesn't help with the
> issue in a).

I think we already did something like that for fsdax.

> c) IOMAP_INLINE isn't supported for writepages. From what I see, this
> was added in commit 3e19e6f3e (" iomap: warn on inline maps in
> iomap_writepage_map"). Maybe it's as simple as now allowing inline
> maps to be used in writepages but it also seems to suggest that inline
> maps is meant for something different than what fuse is trying to do
> with it.

Yeah -- the sole user (gfs2) stores the inline data near the inode, so
->iomap_begin initiates a transaction and locks the inode and returns.
iomap copies data between the pagecache and iomap::addr, and calls
->iomap_end, which commits the transaction, unlocks the inode, and
cleans the page.  That's why writeback doesn't support IOMAP_INLINE;
there's no users for it.

If ext4 ever gets to handling inline data via iomap, I think they'd do a
similar dance.

> > --D
> >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/iomap.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 68416b135151..dbbf217eb03f 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -30,6 +30,7 @@ struct vm_fault;
> > >  #define IOMAP_MAPPED 2       /* blocks allocated at @addr */
> > >  #define IOMAP_UNWRITTEN      3       /* blocks allocated at @addr in unwritten state */
> > >  #define IOMAP_INLINE 4       /* data inline in the inode */
> > > +#define IOMAP_IN_MEM 5       /* data in memory, does not map to blocks */
> > >
> > >  /*
> > >   * Flags reported by the file system from iomap_begin:
> > > --
> > > 2.47.1
> > >
> > >
> 

