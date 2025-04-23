Return-Path: <linux-fsdevel+bounces-47080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED62A985AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418A43B69AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376425CC7F;
	Wed, 23 Apr 2025 09:36:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19017A2ED;
	Wed, 23 Apr 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400989; cv=none; b=Rq/ofZYEhz38K8XTLOZWsVDGVmiQPnad3nZbrejaUzYGW1xwiBk5VPKSXKY3YCd3BberjCqDtAzIjuUQFCavuFAXiNeb3zhPjjohRdzBjNpa8Tf+BI9zp/1pY9pU3P/oT16SPM6/Zk5gMtEW4yJkPUp0QgBDXE/lea79USzfvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400989; c=relaxed/simple;
	bh=1iiKmz+vv/wFY/hdPOM2YY4ykwGG+mD3peLf4rvYkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdQnh9F2ocn+YURbddkesDdpoCo58NF8/A2tbKcGcyciI0pWk2aO4uDuf7VjjJDqxCyFfl3WyhRZpVaElUzeSqJWnTWvIpk9r/nOHBH163uGhjjb935oLynKHSPipJWNsbiTFUSA+xJaipT/F5ZJMsnL6EJWLO9oCNlILvMeouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F27268AFE; Wed, 23 Apr 2025 11:36:21 +0200 (CEST)
Date: Wed, 23 Apr 2025 11:36:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: add more bio helper
Message-ID: <20250423093621.GA2578@lst.de>
References: <20250422142628.1553523-1-hch@lst.de> <jetduw7zshrmp4gl7zfpwqjweycwesxiod7xvtnxqwqekgtvdf@idwnvfzvhgik>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jetduw7zshrmp4gl7zfpwqjweycwesxiod7xvtnxqwqekgtvdf@idwnvfzvhgik>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 10:47:03AM -0400, Kent Overstreet wrote:
> On Tue, Apr 22, 2025 at 04:26:01PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds more block layer helpers to remove boilerplate code when
> > adding memory to a bio or to even do the entire synchronous I/O.
> > 
> > The main aim is to avoid having to convert to a struct page in the caller
> > when adding kernel direct mapping or vmalloc memory.
> 
> have you seen (bch,bch2)_bio_map?

Now I have.

> 
> it's a nicer interface than your bio_add_vmalloc(), and also handles the
> if (is_vmalloc_addr())

Can you explain how it's nicer?

For use with non-vmalloc memory it does a lot of extra work
and generates less optimal bios using more vecs than required, but
maybe that wasn't the point?

For vmalloc it might also build suboptimal bios when using large vmalloc
mappings due to the lack of merging, but I don't think anyone does I/O to
those yet.

It lacks a API description and it or the callers miss handling for VIVT
caches, maybe because of that.

Besides optimizing the direct map case that always needs just one vec
that is also one of the reasons why I want the callers to know about
vmalloc vs non-vmalloc memory.

It also don't support bio chaining or error handling and requires a
single bio that is guaranteed to fit the required number of vectors.

OTOH for callers where that applies it would be nice to have a
helper that loops over bio_add_vmalloc.  I actually had one initially,
but given that I only found two obvious users I dropped it for now.
If we get more we can add one.


