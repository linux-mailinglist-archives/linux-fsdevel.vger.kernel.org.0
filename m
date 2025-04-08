Return-Path: <linux-fsdevel+bounces-46015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD6A8140D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3511B819E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E6923E333;
	Tue,  8 Apr 2025 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRpD+7Vp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A722D4C0;
	Tue,  8 Apr 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134688; cv=none; b=L1AZKUt3kF7ZK7K/W/Ilk+IUFkYM4iMBfvSC5bO3O+dW80O1R0DAdRie7k+7nojo3g43/X2WqJqXpTeDSciW2qljPqtwRHKp3bhsYm/FNlxm7BnTfRMXGT7vGN+roVowMDcwh18RcdNxfC17i9d3QAvQSu8PW0Mpnk8tlZsLSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134688; c=relaxed/simple;
	bh=nyTUNsuPjPGzyNEqBbLpwSD1kFm8MNqPPii+JsWSl4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXxJBZDiL+dirrNRVP9jcHCI9lJ9gbcfpg8sm3GEDkfXvLwsq+uN6PVvB0qn5K9yAxKgvZ9KRDkBIdynUcOFL4hf5/xrOXQ4g3oDzjSaDBgtg22K9ecWAFIq/zO2VhSjYYGokOaarWj0o9na4+ZkqUjFzxFtsB7Eenp6UybUx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oRpD+7Vp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LRoGsm36GWYvDS1XW5mGL/7sKrvWfbhdm+vbaWZ07xI=; b=oRpD+7Vp0e6qyj9DRDn2GCOlm3
	QtllRxj5NJ/kOR/p0aXCC/crlROlM3tpCnE2R9jbNekSugaTVJeIPnSACelAiyHiY6eWW7OiJ/ur/
	QMAM8mcWeNn88uJmLjz/63ZWtc1Gztmxkg2io6kDrtossNunvtlsw6kHzOqudKBBVzSqO5+iKhMK8
	euIj2dPnhebY2hqhmBXiIJ3VGAAKoDZCOPcJAulPYz0V1dtSqNxa/XYk0QPIopMuVprax9sVnU/6Z
	7G4L9yb9UvvMamiEpwksfST5cchHFB5oUJ5OaZ/o16Y241oWm/8SVoiAFs/nqeDzZHMJIJ1cY+9hI
	U2ezk9IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2D6Q-00000000JDI-1K6g;
	Tue, 08 Apr 2025 17:51:14 +0000
Date: Tue, 8 Apr 2025 18:51:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, David Bueso <dave@stgolabs.net>,
	Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Tso Ted <tytso@mit.edu>, Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <Z_ViElxiCcDNpUW8@casper.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408174855.GI6307@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 10:48:55AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 08, 2025 at 10:24:40AM -0700, Luis Chamberlain wrote:
> > On Tue, Apr 8, 2025 at 10:06 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > Fun
> > > puzzle for the community is figuring out *why* oh why did a large folio
> > > end up being used on buffer-heads for your use case *without* an LBS
> > > device (logical block size) being present, as I assume you didn't have
> > > one, ie say a nvme or virtio block device with logical block size  >
> > > PAGE_SIZE. The area in question would trigger on folio migration *only*
> > > if you are migrating large buffer-head folios. We only create those
> > 
> > To be clear, large folios for buffer-heads.
> > > if
> > > you have an LBS device and are leveraging the block device cache or a
> > > filesystem with buffer-heads with LBS (they don't exist yet other than
> > > the block device cache).
> 
> My guess is that udev or something tries to read the disk label in
> response to some uevent (mkfs, mount, unmount, etc), which creates a
> large folio because min_order > 0, and attaches a buffer head.  There's
> a separate crash report that I'll cc you on.

But you said:

> the machine is arm64 with 64k basepages and 4k fsblock size:

so that shouldn't be using large folios because you should have set the
order to 0.  Right?  Or did you mis-speak and use a 4K PAGE_SIZE kernel
with a 64k fsblocksize?

