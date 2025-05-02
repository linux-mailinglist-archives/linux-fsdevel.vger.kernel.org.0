Return-Path: <linux-fsdevel+bounces-47898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5800AA6B50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 09:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FC9A3B24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 07:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EEA26772A;
	Fri,  2 May 2025 07:07:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B12221FB8;
	Fri,  2 May 2025 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169668; cv=none; b=Wot6qy8xXOzJISp52oEVDuM76UezMsjOzRunbEvyMdPnYkVYVHuwmC2UfekWGO2zNAGPJeuagGdY8i18pDYmX1ICZb9oof1GBsWaWVbcBJcn6FwSSN+qggL6U5Cp8aXBT36RkAaiOm7MDds36mdGvYkTtZ8CrFMbI9BUVt5V4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169668; c=relaxed/simple;
	bh=AyX6xkPFouLWSp+QKSd+EP0BhoGf3gaWHhcGS7jjc5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqTHT1Yx4SlhXCmLr5PiQBKrbvDqFWpaJOVVp6SCooq7aGKxaPBp3jpRnUbTFCc56hLXaZQpOh/yqE8y3Y9O2Mc34FQhitpYMtReWhQQEHwO2A1KJBBMCI+opkvkZv1gtZ6n1KMFHjiC7W8OSy3sDl8LuAvnS/+ShWXf919QOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A043667373; Fri,  2 May 2025 09:07:41 +0200 (CEST)
Date: Fri, 2 May 2025 09:07:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/19] xfs: simplify xfs_buf_submit_bio
Message-ID: <20250502070741.GB8402@lst.de>
References: <20250430212159.2865803-1-hch@lst.de> <20250430212159.2865803-16-hch@lst.de> <20250501195103.GD25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501195103.GD25675@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 01, 2025 at 12:51:03PM -0700, Darrick J. Wong wrote:
> > +	bio = bio_alloc(bp->b_target->bt_bdev, nr_vecs, xfs_buf_bio_op(bp),
> > +			GFP_NOIO);
> > +	if (is_vmalloc_addr(bp->b_addr))
> > +		bio_add_vmalloc(bio, bp->b_addr, len);
> 
> I wonder, do we need a debug assertion on the return value?  AFAICT,
> bio_add_max_vecs should result in a bio that's big enough to handle the
> vmalloc area, but those could be famous last words. :P

Buffers are way smaller than the maximum size, but yes error checking
would be nice here.  That'll need an error return value or shutdown,
which means changes to the code structure.  As the existing code didn't
have that (which happens to be my fault..) I don't want to add it in a
block layer series.  I'll add it in the next merge window for future
proofing.


