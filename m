Return-Path: <linux-fsdevel+bounces-52763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ABEAE6519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20C31889104
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729E2882A1;
	Tue, 24 Jun 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3u8Vh1Hu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111E222571;
	Tue, 24 Jun 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768400; cv=none; b=E/LX3jhsErQVJLTVyFLNT4U+r8HisRFLQ9yIM71jBVD8Sced+X0aBiWKT6G4jHMh8YfN66S01rnDxB7mTjcO6UNAN3vym0oYQlYQbV6wse9TTXgE1dJaQKoIaSLCfIVUKX+4m474r8r4J6DM0TM3GrwluaNtXBfyh69QgKIQZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768400; c=relaxed/simple;
	bh=t+05GO1nofi2rBM0PdQlROBCwN8XeweEuaj4WdZHohM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njM/fE2g0VrvkIasSRZRQmHVvpKt4vHlcDrmYKhv+mJ+WCTkZMM9JR790xvM073fhwQVVOU464YcxTt4Vur6JWOa7OQrPaMpthUNqFNyLKjN8O9vJeeOVBwIXGqDonNanLZxB/YqRwSqa+RCAJ2FeQj3ses6GJAQBEdwjvw+S50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3u8Vh1Hu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iPTpAgcRbujRNs+Bzdm5JCDsevWvOgWZgjysr9px/tk=; b=3u8Vh1Hukuro41nJNrdqnIezZY
	qlcxYh4a/2CNMgY5dWmqUJHKqMqiR1HaGA5m/+wI1TIWYLksAGEeyp9U89pOR+Ju7LA1Wnbi+rOxm
	UclX8PMxoQrPvaZsHoVckSTHxARnx7G1sKxNpcTfr2NJN6kLLjnDugOUcqpRL81Vf5ZBWCnvuK1bI
	SXh7ZSrFFQ+t6aHhoFxurucnzR0Z4If9n+TXgRqPZyhgKRYph1kJfpxJQslOlqylzHTaeWpnBdAet
	oNTFzFCXFX2uSx2lLD2hpk57JmWBHiCfyEzQtAZLrupHO6D1nhSf/YalaAYz7z4VT27yK3jbvv4zi
	M8TNMf2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU2py-00000005ays-3QpC;
	Tue, 24 Jun 2025 12:33:18 +0000
Date: Tue, 24 Jun 2025 05:33:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <aFqbDg03Y2nAech5@infradead.org>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-geerntet-haare-2ce4cc42b026@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 24, 2025 at 10:51:51AM +0200, Christian Brauner wrote:
> 
> void (*yank_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> void (*pull_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> void (*unplug_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);
> void (*remove_bdev)(struct super_block *sb, struct block_device *bdev /* , unsigned int flags/reason maybe too ? */);

Out of these remove_bdev is the most sane.

> (That brings me to another thought. Is there a use-case for knowing in
> advance whether removing a device would shut down the superblock?
> Because then the ability to probe whether a device can be safely
> removed or an option to only remove the device if it can be removed
> without killing the superblock would be a natural extension.)

I don't think there is a use for it at this (holder_ops) level.  If
the device driver notifies about a device going to away we're already
committed.  It makes some sense at the file system administration level,
but you want to tie that much deepter into the file system, i.e. you'd
actually usually want to migrate all data off the device first.


