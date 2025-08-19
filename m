Return-Path: <linux-fsdevel+bounces-58273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A1CB2BC4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C177AA4F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06F6315779;
	Tue, 19 Aug 2025 08:57:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E67315764;
	Tue, 19 Aug 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593879; cv=none; b=eCurMgBvLrHRFxh+urbPcL8vuD18+sRk8Q2IQAWeB6C+3p6cy6I1f2kMNXL7aaFAKVBbbhVET2ORCDazE9S7WxcJYmQGks6RyoXM++XPOancqh7N+CdtOtHWBmX4WUbET+oUBduRuwbW0jkIYobBhwnnFk8V3o1FaLSzURgkenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593879; c=relaxed/simple;
	bh=rtBbqK17Bhj1BgB0FxPp9IjnxXNQh4jrV0zRyjJLAkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOc+MdWhrEnp2EDYJ/xK3WIAr1kuqH5wwMPKz/Vb0mNCiLiut45+NSZDI/By21b+yxLX9etllU0EavgKILD6RCamtDkqYRdxuClV+XldhusVWHgXhAQlsurOE+EZxGmOhZT/lqqR4ZNYdN/fnRYEqC2lXKthLiVWqA12hPEJ7QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12A5467373; Tue, 19 Aug 2025 10:57:52 +0200 (CEST)
Date: Tue, 19 Aug 2025 10:57:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-bcachefs@vger.kernel.org, ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] bcachefs: stop using write_cache_pages
Message-ID: <20250819085751.GA4283@lst.de>
References: <20250818061017.1526853-1-hch@lst.de> <20250818061017.1526853-3-hch@lst.de> <3zji6rc56egwqvy2gy63aj2wjfo5pyeuq2iikhgudcttdcif2m@dphqqiozruka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3zji6rc56egwqvy2gy63aj2wjfo5pyeuq2iikhgudcttdcif2m@dphqqiozruka>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 18, 2025 at 07:17:15AM -0400, Kent Overstreet wrote:
> On Mon, Aug 18, 2025 at 08:10:09AM +0200, Christoph Hellwig wrote:
> > Stop using the obsolete write_cache_pages and use writeback_iter
> > directly.  This basically just open codes write_cache_pages
> > without the indirect call, but there's probably ways to structure
> > the code even nicer as a follow on.
> 
> Wouldn't inlining write_cache_pages() achieve the same thing?

It might eliminate the indirect calls with the right compiler or
options, but not archieve any of the other goals, and leave us
with a helper implementing a pointless callback pattern for 1 user.

> > +
> > +	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> > +		error = __bch2_writepage(folio, wbc, data);
> > +	return error;
> > +}
> > +
> >  int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc)
> >  {
> >  	struct bch_fs *c = mapping->host->i_sb->s_fs_info;
> > @@ -663,7 +674,7 @@ int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc
> >  	bch2_inode_opts_get(&w->opts, c, &to_bch_ei(mapping->host)->ei_inode);
> >  
> >  	blk_start_plug(&w->plug);
> > -	int ret = write_cache_pages(mapping, wbc, __bch2_writepage, w);
> > +	int ret = bch2_write_cache_pages(mapping, wbc, w);
> >  	if (w->io)
> >  		bch2_writepage_do_io(w);
> >  	blk_finish_plug(&w->plug);
> > -- 
> > 2.47.2
> > 
---end quoted text---

