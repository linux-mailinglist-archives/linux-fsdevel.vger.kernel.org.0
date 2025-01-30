Return-Path: <linux-fsdevel+bounces-40449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E1A236F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1611649DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BE1F12F6;
	Thu, 30 Jan 2025 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jp/++nzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07E1DA5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273732; cv=none; b=jnqql9eGJvun6F3EbYzReesYX1TSl3H7HUHUQ+JHYUfwFFcuEfOr4ACLrQY3Br6sOd65iqqhAepTP9A7iUZl2DvRsyIMZ/ia0kCkT2VsR1QjajG/pIBX9hADwH3n19derlKp8faeFgS0E7Rm/zTitOooh3zXC7en1PXqGcVO3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273732; c=relaxed/simple;
	bh=tg8D7K7cc4mPfWwTlISLQXzX8PsaeKcuofFWoQASRPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeJigZfofB56rQdOsCqniOtDwq2PcYsZ1OREXBOkCteLuHVWTV7rLabFxsttq28OOCeH4pPSSthFiDV4GFQY+LhRrGpSQhOQcl5RoiEMI2vfTXOYBcH8X+mUiSDjiEQHesZei7AWxp6eqGCQFisIwKCM/KhlZ3KQbBAcF99J0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jp/++nzV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CQEc+/G2RJpf6STGUAzJPzi2XVauipWKftAPOBfoZ+o=; b=Jp/++nzVTGKhFinbZ3B7Aybaha
	trmHE86Fzk1278Qq3G/Pmuz/BtLmWBa8Kd1TEahkz6ijUFvX0USmpYW0uQfmqnIOP47fpJUOoQGXd
	OTg49d6GNTC8T/ZJhLfxef/mXef9ETTSw3Tb9mppcRIqN1SUBU0YRjAhx21qMsBtcq5bGBpEaXy8h
	DR1ePg+YZieryn/PQYGas3UUbDSpf2J84Cy7GRcRqTsO1tICBSfmZ1s3sG1jhx/b39oDcEYr+9ZoG
	0WjS2mBir/i5IZNlhsqSXYdqjdoPEQrm+TtZbFusgqzDg1gNe1V3kJsmW6zOZWfFGFphNaSsUYkKP
	iNdwlqZg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdcOw-0000000DnVA-3nb0;
	Thu, 30 Jan 2025 21:48:42 +0000
Date: Thu, 30 Jan 2025 21:48:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BPF TOPIC] Migrating the un-migratable
Message-ID: <Z5vzuii9-zS-WsCH@casper.infradead.org>
References: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>

On Wed, Jan 29, 2025 at 05:10:03PM +0100, David Hildenbrand wrote:
> As one example, in context of FUSE we recently discovered that folios that
> are under writeback cannot be migrated, and user space in control of when
> writeback will end. Something similar can happen ->readahead() where user
> space is in charge of supplying page content. Networking filesystems in
> general seem to be prone to this as well.

You're not wrong.  The question is whether we're willing to put the
asterisk on "In the presence of a misbehaving server (network or fuse),
our usual guarantees do not apply".  I'm not sure it's a soluble
problem, though.  Normally writeback (or, as you observed, readahead)
completes just fine and we don't need to use non-movable pages for them.

But if someone trips over the network cable, anything in flight becomes
unmovable until someone plugs it back in.  We've given the DMA address
of the memory to a network adapter, and that's generally a non-revokable
step (maybe the iommu could save us, but at what cost?)

> As another example, failing to split large folios can prevent migration if
> memory is fragmented. XFS (IOMAP in general) refuses to split folios that
> are dirty [3]. Splitting of folios and page migration have a lot in common.

Welll ... yes and no.  iomap refuses to split a dirty folio because it
has a per-folio data structure which tells us which blocks in the folio
are dirty.  If we split the folio, we have to allocate an extra data
structure for each new folio that we create.  It's not impossible, but
it's a big ask for slab.  It'll be a lot better once Zi Yan's patch is
in to only split folios as needed rather than all the way.

That problem doesn't arise for migration.  filemap_release_folio() is
only called by fallback_migrate_folio(), which is only called if the
filesystem doesn't provide a ->migrate_folio callback.  All iomap
users should use filemap_migrate_folio() which just has to move the
data structure from the old folio to the new.


