Return-Path: <linux-fsdevel+bounces-51055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C723AD247D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10601882058
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B03D21B196;
	Mon,  9 Jun 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F16ZfaTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597E1624CE;
	Mon,  9 Jun 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488263; cv=none; b=fpx+xEh7US8yWBRMRL8Fy64dCgPZgAXf1WUkcqDjqvggnw72ZBR0dMzoxi03IAS3gQl578/t78YXMq09iQMdYxp3uZIlwr7wtu2jB5Veysef31AB5tae1CaZWmcfErM7+e8odt0nRtyiRdV7OnSN33S+GkeHZc9+o+ZIWBiucEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488263; c=relaxed/simple;
	bh=klUfMHQOWf4dOvsh98V+g3nj3kSkg/EV9cqMKDNvUQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOzqhmAlIuZz4mhkx9VQNYfTsFxY7c4LeqhjvxpeQJRMzJuy0Zt3pg2wmachd6Mfov/r09ZlB/rF0iyKnN57jiSLi8oAiUgQE7Gqn2fWE7VGHEohrkNztOD1V+czpB+wHHvDkX9H+I2BMaj3aE34bAOmAAsG4YOlD1Phaz0wnKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F16ZfaTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E902C4CEEB;
	Mon,  9 Jun 2025 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749488262;
	bh=klUfMHQOWf4dOvsh98V+g3nj3kSkg/EV9cqMKDNvUQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F16ZfaTbWYPQ/jWjAtQ93fFJ+umkPlfNcbN6euZZbCKfjT/BluSGUh2IJjLCADI6I
	 INaB2iYYVBZsKUsX8NAwahntNy/8MtAUyWVED3r1iqSMH5K7tvbh6bn5PmObIB5rke
	 cU2JGbZUrLd7iBqCO8pxc3bsc4C8PptALAgRuoalopn/Twi33O7MO44iBQtV5w6uwY
	 PcWl0qqcinfn/Nq8iXGrwMs8ok2pjzuSRWZlQLLDAe3994koxRiH7k5Mv1Zk9ck5dr
	 yfJGZa0zcOYGmoCljqKccbpqikxmHUIkw7YVNwyLHGe/bCl8dFicer9agO8SRQc9EA
	 2hGxfjIFGW0xw==
Date: Mon, 9 Jun 2025 09:57:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 4/8] iomap: add writepages support for IOMAP_IN_MEM
 iomaps
Message-ID: <20250609165741.GK6156@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-5-joannelkoong@gmail.com>
 <aEZx5FKK13v36wRv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEZx5FKK13v36wRv@infradead.org>

On Sun, Jun 08, 2025 at 10:32:20PM -0700, Christoph Hellwig wrote:
> On Fri, Jun 06, 2025 at 04:37:59PM -0700, Joanne Koong wrote:
> > This allows IOMAP_IN_MEM iomaps to use iomap_writepages() for handling
> > writeback. This lets IOMAP_IN_MEM iomaps use some of the internal
> > features in iomaps such as granular dirty tracking for large folios.
> > 
> > This introduces a new iomap_writeback_ops callback, writeback_folio(),
> > callers may pass in which hands off folio writeback logic to the caller
> > for writing back dirty pages instead of relying on mapping blocks.
> > 
> > This exposes two apis, iomap_start_folio_write() and
> > iomap_finish_folio_write(), which callers may find useful in their
> > writeback_folio() callback implementation.
> 
> It might also be worth stating what you don't use.  One big thing
> that springs to mind is ioends.  Which are really useful if you
> need more than one request to handle a folio, something that is
> pretty common in network file systems.  I guess you don't need
> that for fuse?

My initial thought was "I wonder if Joanne would be better off with a
totally separate iomap_writepage_map_blocks implementation" since I
*think* fuse just needs a callback from iomap to initiate FUSE_WRITE
calls on the dirty range(s) of a folio, and then fuse can call
mapping_set_error and iomap_finish_folio_write when those FUSE_WRITE
calls complete.  There are no bios, so I don't see much point in using
the ioend machinery.

--D

> > +	if (wpc->iomap.type == IOMAP_IN_MEM) {
> > +		if (wpc->ops->submit_ioend)
> > +			error = wpc->ops->submit_ioend(wpc, error);
> > +		return error;
> > +	}
> 
> Given that the patch that moved things around already wrapped the
> error propagation to the bio into a helpr, how does this differ
> from the main path in the function now?
> 
> > +	/*
> > +	 * If error is non-zero, it means that we have a situation where some part of
> > +	 * the submission process has failed after we've marked pages for writeback.
> > +	 * We cannot cancel ioend directly in that case, so call the bio end I/O handler
> > +	 * with the error status here to run the normal I/O completion handler to clear
> > +	 * the writeback bit and let the file system process the errors.
> > +	 */
> 
> Please add the comment in a separate preparation patch.
> 
> > +		if (wpc->ops->writeback_folio) {
> > +			WARN_ON_ONCE(wpc->ops->map_blocks);
> > +			error = wpc->ops->writeback_folio(wpc, folio, inode,
> > +							  offset_in_folio(folio, pos),
> > +							  rlen);
> > +		} else {
> > +			WARN_ON_ONCE(wpc->iomap.type == IOMAP_IN_MEM);
> > +			error = iomap_writepage_map_blocks(wpc, wbc, folio,
> > +							   inode, pos, end_pos,
> > +							   rlen, &count);
> > +		}
> 
> So instead of having two entirely different methods, can we
> refactor the block based code to also use
> ->writeback_folio?
> 
> Basically move all of the code inside the do { } while loop after
> the call into ->map_blocks into a helper, and then let the caller
> loop and also directly discard the folio if needed.  I can give that
> a spin if you want.
> 
> Note that writeback_folio is misnamed, as it doesn't write back an
> entire folio, but just a dirty range.
> 
> >  	} else {
> > -		if (!count)
> > +		/*
> > +		 * If wpc->ops->writeback_folio is set, then it is responsible
> > +		 * for ending the writeback itself.
> > +		 */
> > +		if (!count && !wpc->ops->writeback_folio)
> >  			folio_end_writeback(folio);
> 
> This fails to explain why writeback_folio does the unlocking itself.
> I also don't see how that would work in case of multiple dirty ranges.
> 
> >  	}
> >  	mapping_set_error(inode->i_mapping, error);
> > @@ -1693,3 +1713,25 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
> >  	return iomap_submit_ioend(wpc, error);
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_writepages);
> > +
> > +void iomap_start_folio_write(struct inode *inode, struct folio *folio, size_t len)
> > +{
> > +	struct iomap_folio_state *ifs = folio->private;
> > +
> > +	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> > +	if (ifs)
> > +		atomic_add(len, &ifs->write_bytes_pending);
> > +}
> > +EXPORT_SYMBOL_GPL(iomap_start_folio_write);
> > +
> > +void iomap_finish_folio_write(struct inode *inode, struct folio *folio, size_t len)
> > +{
> > +	struct iomap_folio_state *ifs = folio->private;
> > +
> > +	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !ifs);
> > +	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
> > +
> > +	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
> > +		folio_end_writeback(folio);
> 
> Please also use these helpers in the block based code.
> 
> 

