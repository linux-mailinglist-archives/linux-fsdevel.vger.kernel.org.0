Return-Path: <linux-fsdevel+bounces-51058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8EAD24E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537783B05A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3984D21C9F6;
	Mon,  9 Jun 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgWlWSYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981968633F;
	Mon,  9 Jun 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489285; cv=none; b=SjrmcQdutTNkwYT2Z7pJ4Ou3j3ExVEDcFHF9hKaIEjOLx1ywuts++fjKXonSYjVCCrCRtx1BwCvk9mMI4o32PVlx8qCNpVrnm6C467c7IWz8/TdDkpK+8TnZOVwYWfygk75Bjg3ZROuNW7ooL3Id0po3UlS9zdFTnsgrLaziJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489285; c=relaxed/simple;
	bh=ncxhRXYy2cXLfo0Pcrv9QpJlmCAgF3C8xXX8iU0kCz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNnBQZ3Nox1Luoke0dZcGEXRjb0g2XiVqvnfBd9/6LFhsZLT7nkJMTeSskdLF0cz6DnXamvrU1AvWMd07i58Kf5hgcy6loRxfTIN7VbsSWS3scHkksYce+HwfQKfZXSnZIvmkvTrFPN6ntaWSu8MII8KGYG9a6GPfShjhZNC9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgWlWSYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179F7C4CEEB;
	Mon,  9 Jun 2025 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749489285;
	bh=ncxhRXYy2cXLfo0Pcrv9QpJlmCAgF3C8xXX8iU0kCz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BgWlWSYcc9RL3502YwU/6gNmtqSOtOiQpevsLOvnKVlqauliAoMT99hcE6Lz56WZx
	 SBF1DBj1UHjd4nKlHJhYPGNgFmGttGqplcchj/3rjQX2ywFu8gLJIuUp1FbkWdpsJx
	 /kNy43SgPv3Qt4rvyhzy2GrQ4gKtIm4ewK9hEPepizIYbku/oR8C0/XL1aQH6AHGXy
	 +Hmu4VV3Xat+Ko42ap0i/A23Hu8s7UbutKXUuu9DqLBC9YipJhHV+AEnut/trS9caO
	 2P3SylKAXc2rCO9MFPezGh72An/oT598h74q75fdVt1jJL4N03WEPUCflhkUD1vXf7
	 alAH3KWl1e0wg==
Date: Mon, 9 Jun 2025 10:14:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <20250609171444.GL6156@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEZoau3AuwoeqQgu@infradead.org>

On Sun, Jun 08, 2025 at 09:51:54PM -0700, Christoph Hellwig wrote:
> On Fri, Jun 06, 2025 at 04:38:00PM -0700, Joanne Koong wrote:
> > Add iomap_writeback_dirty_folio() for writing back a dirty folio.
> > One use case of this is for folio laundering.
> 
> Where "folio laundering" means calling ->launder_folio, right?

What does fuse use folio laundering for, anyway?  It looks to me like
the primary users are invalidate_inode_pages*.  Either the caller cares
about flushing dirty data and has called filemap_write_and_wait_range;
or it doesn't and wants to tear down the pagecache ahead of some other
operation that's going to change the file contents and doesn't care.

I suppose it could be useful as a last-chance operation on a dirty folio
that was dirtied after a filemap_write_and_wait_range but before
invalidate_inode_pages*?  Though for xfs we just return EBUSY and let
the caller try again (or not).  Is there a subtlety to fuse here that I
don't know about?

(Both of those questions are directed at hch or joanne or anyone else
who knows ;))

--D

> > @@ -1675,7 +1677,8 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	 * already at this point.  In that case we need to clear the writeback
> >  	 * bit ourselves right after unlocking the page.
> >  	 */
> > -	folio_unlock(folio);
> > +	if (unlock_folio)
> > +		folio_unlock(folio);
> >  	if (ifs) {
> >  		if (atomic_dec_and_test(&ifs->write_bytes_pending))
> >  			folio_end_writeback(folio);
> 
> When writing this code I was under the impression that
> folio_end_writeback needs to be called after unlocking the page.
> 
> If that is not actually the case we can just move the unlocking into the
> caller and make things a lot cleaner than the conditional locking
> argument.
> 
> > +int iomap_writeback_dirty_folio(struct folio *folio, struct writeback_control *wbc,
> > +				struct iomap_writepage_ctx *wpc,
> > +				const struct iomap_writeback_ops *ops)
> 
> Please stick to the usual iomap coding style:  80 character lines,
> two-tab indent for multiline function declarations.  (Also in a few
> other places).
> 
> 

