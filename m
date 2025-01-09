Return-Path: <linux-fsdevel+bounces-38701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F5A06D47
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 05:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7413A130E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 04:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F48214235;
	Thu,  9 Jan 2025 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAbnnR+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172361AAC9;
	Thu,  9 Jan 2025 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736398076; cv=none; b=YsE33sh6Sr8NQaYt2ltsikMfnEleOqfqDP6i0GmtBMwhB8FI6g62xCeFkjvmeeuEGkDt9cwhju49F4Ny54fiBVLepVs2Jh/5p/SUJc5heWRvfAg6p2YKRTx9AVegTP3w9Umg+x3VfI3FI6lfTDIOB9bhmXBw7PnfSSduqqZgJOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736398076; c=relaxed/simple;
	bh=wTO7f9EAg+QIbT3diNa6I4GFhEemdmlA9AGi0QBKcmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzwYY3qqBPxa5WnFv3lpsL0az98VvP57FB9ZVCmYL/MKwK+wChgFnqgE01WBgfLMWFwQa/U50imIhWobNPY4y28DkyakutNrqosiz9Cd2JkE+CkRYE3ro8Nxcgy8NECRxD7OxgGfIYbkeW1GoIlD8+RLM6Max44UQn+x/htL9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAbnnR+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99432C4CED2;
	Thu,  9 Jan 2025 04:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736398075;
	bh=wTO7f9EAg+QIbT3diNa6I4GFhEemdmlA9AGi0QBKcmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAbnnR+SVUNgabPrhYi3BB4mvB7ZefnhKVWQ1abQtdPoZwtyYGvIxm5l+nWRfPztn
	 1MwioZGLLSRrkGsA38J91vddIRUTfnrncib7QokIrvoMpAK7SYn1wG3JVergAWBBjM
	 f6G0PWVFl2uxme6GpCHk0jd//St09r5bsXuzMnj8jrQMXWt7KJ636J4dLDt7w48gHH
	 Ju3FlqJAJ5kS08/X1F6x8zF7nPD7koMD3PdWSaVDSULE1Qaivs7S9Ufpd6IgF4o3Sr
	 0stipo+lvMBfzkXQFZJpxBGZQ3GTR2xjmTTN/KllwBegDDlXMwjoqaHVDzKUTzOV1b
	 cU0Y0d5fS7szQ==
Date: Wed, 8 Jan 2025 20:47:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Marco Nelissen <marco.nelissen@gmail.com>
Cc: brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid avoid truncating 64-bit offset to 32 bits
Message-ID: <20250109044754.GK1387004@frogsfrogsfrogs>
References: <20250109041253.2494374-1-marco.nelissen@gmail.com>
 <20250109043846.GJ1387004@frogsfrogsfrogs>
 <CAH2+hP6Rb6zXWcZ01epXOhD49os8F43=snE3pzCHX8+=Dzt1xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2+hP6Rb6zXWcZ01epXOhD49os8F43=snE3pzCHX8+=Dzt1xg@mail.gmail.com>

On Wed, Jan 08, 2025 at 08:45:07PM -0800, Marco Nelissen wrote:
> On Wed, Jan 8, 2025 at 8:38 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Jan 08, 2025 at 08:11:50PM -0800, Marco Nelissen wrote:
> > > on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
> > > 32-bit position due to folio_next_index() returning an unsigned long.
> > > This could lead to an infinite loop when writing to an xfs filesystem.
> > >
> > > Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 54dc27d92781..d303e6c8900c 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
> > >                               start_byte, end_byte, iomap, punch);
> > >
> > >               /* move offset to start of next folio in range */
> > > -             start_byte = folio_next_index(folio) << PAGE_SHIFT;
> > > +             start_byte = folio_pos(folio) + folio_size(folio);
> >
> > eeek.  Yeah, I guess that would happen towards the upper end of the 16T
> > range on 32-bit.
> 
> By "16T" do you mean 16 TeraByte? I'm able to reproduce the infinite loop
> with files around 4 GB.

Yes.  On 32-bit, everything between 2^32 and 16T is the upper end. :)

--D

> > I wonder if perhaps pagemap.h should have:
> >
> > static inline loff_t folio_next_pos(struct folio *folio)
> > {
> >         return folio_pos(folio) + folio_size(folio);
> > }
> >
> > But I think this is the only place in the kernel that uses this
> > construction?  So maybe not worth the fuss.
> >
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > --D
> >
> > >               folio_unlock(folio);
> > >               folio_put(folio);
> > >       }
> > > --
> > > 2.39.5
> > >

