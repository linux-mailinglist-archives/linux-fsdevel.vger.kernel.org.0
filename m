Return-Path: <linux-fsdevel+bounces-57612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6CBB23DA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 03:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803146E3433
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE82C12FF69;
	Wed, 13 Aug 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqj09Sfk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1572C0F6F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755048018; cv=none; b=VtOdlbPxjtld+mmcy6z6v8qDqKmHb5Wp4kIMNoUIQKo34Ep6ffExJ3Riwfdo2fPko7MwgwXAlitWF5g/ONDxIj+1CWkbdipwS8yb1i8thFq27BUpd57dW1/kRMcO5vPHWt1LfBCIVJrfhjMoxv3qiLZID3Ij1vSYyTFMOE1mhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755048018; c=relaxed/simple;
	bh=bLMuEFmUcy9I9FuSedwINddVZT6jxzYFmp9Zfo2JOI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2PactS+bT9FRzns36q3AXuT4eCLgkXLcAKIfIVfwwZszuqzrd40tRm6NU7uqYcGBolbCZg7cWf3hTx2YCCO2idaZ6lPDqhY4iQdIyzPJncbQ3/JL77fsYd8LwLEgB9nUPz+Yrnr/y/PQPNZH1HXug758nGo34OynBJFaHGehoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqj09Sfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF189C4CEF0;
	Wed, 13 Aug 2025 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755048018;
	bh=bLMuEFmUcy9I9FuSedwINddVZT6jxzYFmp9Zfo2JOI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqj09SfkkOKPpI0XZ+11XK13nrZNHH44Xdg2C0dieOz3RM2+azFIKIZOvbVneMjzq
	 /swmAp7YzuNcFrdVKMJo3Ypag1YVeDkpp8YSF1AyR0GJHAhhys9UmYBz8RHK6d8aYJ
	 +T8COCiwWbvtMSALHGjv6VOXNibN4kdcCtuD3tcVHvkLxiJdtnlkZG1XkpkR2/W1ad
	 /WTmSEFq2Ggt4dOUcIhZO4/W8kbBxkbUGJzY3LLFu4vACaA77NB2fUyHFSQMuNSGtS
	 1HfNwdZyc6XsFDbI0dI/MYxS8NWGaS5brmlTehlgfWywHm3/u8NpSmZN7xZXw7eL2Y
	 RQOcLkXyePsGw==
Date: Tue, 12 Aug 2025 18:20:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com, bernd.schubert@fastmail.fm,
	willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
Message-ID: <20250813012017.GM7942@frogsfrogsfrogs>
References: <20250811204008.3269665-1-joannelkoong@gmail.com>
 <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
 <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
 <20250812193842.GJ7942@frogsfrogsfrogs>
 <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Y27jYLxORfTaVWvMxH1h2-TrpxrexxxqawSK1rOzdrYg@mail.gmail.com>

On Tue, Aug 12, 2025 at 04:02:12PM -0700, Joanne Koong wrote:
> On Tue, Aug 12, 2025 at 12:38 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, Aug 12, 2025 at 01:13:57PM +0200, Miklos Szeredi wrote:
> > > On Mon, 11 Aug 2025 at 23:13, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 11, 2025 at 1:43 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > Large folios are only enabled if the writeback cache isn't on.
> > > > > (Strictlimiting needs to be turned off if the writeback cache is used in
> > > > > conjunction with large folios, else this tanks performance.)
> > >
> > > Is there an explanation somewhere about the writeback cache vs.
> > > strictlimit issue?
> >
> > and, for n00bs such as myself: what is "strictlimit"? :)
> >
> 
> My understanding of strictlimit is that it's a way of preventing
> non-trusted filesystems from dirtying too many pages too quickly and
> thus taking up too much bandwidth. It imposes stricter / more

Oh, BDI_CAP_STRICTLIMIT.

/me digs

"Then wb_thresh is 1% of 20% of 16GB. This amounts to ~8K pages."

Oh wow.

> conservative limits on how many pages a filesystem can dirty before it
> gets forcibly throttled (the bulk of the logic happens in
> balance_dirty_pages()). This is needed for fuse because fuse servers
> may be unprivileged and malicious or buggy. The feature was introduced
> in commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit
> feature). The reason we now run into this is because with large
> folios, the dirtying happens so much faster now (eg a 1MB folio is
> dirtied and copied at once instead of page by page), and as a result
> the fuse server gets throttled more while doing large writes, which
> ends up making the write overall slower.

<nod> and hence your patchset gives the number of dirty blocks (pages?)
within the large folio to the writeback throttling code so that you
don't get charged for 2M of dirty data if you've really only touched a
single byte of a 2M folio, right?

Will go have a look at that tomorrow.

--D

> 
> Thanks,
> Joanne
> 
> > --D
> >
> > > Thanks,
> > > Miklos
> > >
> 

