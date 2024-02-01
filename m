Return-Path: <linux-fsdevel+bounces-9874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747A845961
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4B81F27C5B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201895D493;
	Thu,  1 Feb 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJ4Nplj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC05D48D;
	Thu,  1 Feb 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795644; cv=none; b=lDhVJsXCmgfSm2N7lpT09jvWQloUpsggSToXE9qxwLrJ+gmIKZTc0Es2HzncSBQVV0ic+ZDftaH+GNTAOlyVNlBbw+W/wJRyZ+LIyBhCTL1SDJqfuZA5O/pPoETJhppjq+nlWPBS08GGFtst2uBXUmQYhqwNWcjn1KPSeG9k9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795644; c=relaxed/simple;
	bh=UaYoO8odMjsOoJa0rA+5orOrqeLC2r0iVUdb6uKnm/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEcxktAdw4I8axWONj8R150I1vuMCtRyc/3PZ9z9hRUCkawhYnOzoBuF1oeS03teHrWMqZhxljRiKrSTZRMn21OVGl26UQoc8R6ar53MyUJB94bR9Vwyr0oAE2MzTyBjczX1PDIvnnRnm0HbUn3h8HGINpJ00+hpDfzp15f7C+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mJ4Nplj6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HvWvFe8kmg8uC1rXi4MnVrUITUPbCSnUcddzzqebB+A=; b=mJ4Nplj678opG4pI0nIIioQ2ao
	ehU6FxBSUrTMKj9Xqt7omU5DeAVSCxi6SfC9aiT/nRK1tHvEF6MgJPKpU37FpkPuXEtIMuJda+IPv
	duBz42Tn0qfXvytuDT7kpBOEkwkwK0AKZeu3n/ehzXwqiXd9EhcWX4ZuW65nmqlB92aIypjN5/Buc
	EFDoverS85GS/IBfiTk5Ymyc7mlHZC2yckd2UIvBv6mIEHiPUiW/foidIwTdqrUMG/IKWsTGfxPLO
	gF/NtWJGtKO01th3kWeJ+qRy36hljFmUHCpo4NusHGXIrqEfHpv5Kf+TiJySl0MVI59VwoDCq52nQ
	RuWExw8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVXVq-0000000Fxpf-31Gt;
	Thu, 01 Feb 2024 13:53:54 +0000
Date: Thu, 1 Feb 2024 13:53:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Liu Shixin <liushixin2@huawei.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/readahead: stop readahead loop if memcg charge
 fails
Message-ID: <ZbuickwNyxExIVzC@casper.infradead.org>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-2-liushixin2@huawei.com>
 <Zbug14NoOHFmfLst@casper.infradead.org>
 <20240201135231.tgnn7cnlmtqh5n4f@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201135231.tgnn7cnlmtqh5n4f@quack3>

On Thu, Feb 01, 2024 at 02:52:31PM +0100, Jan Kara wrote:
> On Thu 01-02-24 13:47:03, Matthew Wilcox wrote:
> > On Thu, Feb 01, 2024 at 06:08:34PM +0800, Liu Shixin wrote:
> > > @@ -247,9 +248,12 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> > >  		folio = filemap_alloc_folio(gfp_mask, 0);
> > >  		if (!folio)
> > >  			break;
> > > -		if (filemap_add_folio(mapping, folio, index + i,
> > > -					gfp_mask) < 0) {
> > > +
> > > +		ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
> > > +		if (ret < 0) {
> > >  			folio_put(folio);
> > > +			if (ret == -ENOMEM)
> > > +				break;
> > 
> > No, that's too early.  You've still got a batch of pages which were
> > successfully added; you have to read them.  You were only off by one
> > line though ;-)
> 
> There's a read_pages() call just outside of the loop so this break is
> actually fine AFAICT.

Oh, good point!  I withdraw my criticism.

