Return-Path: <linux-fsdevel+bounces-65031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADDFBF9F5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0919D4E63B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8362D73B1;
	Wed, 22 Oct 2025 04:39:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43F27FD49;
	Wed, 22 Oct 2025 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107979; cv=none; b=EJ88yTO4A6RzVNH0bz+uAINCZ0rPvsR1z30gFDUq/GWtOpiMfBBV2yvlaYLERh7H567pASOMD3vCEXa32tJVP1vYdkiyX2J3vfsrXIBfhVXi9qvusWGXZU+Kd56lZ68CFf9pspjeRxAAy0ToZIzW1hrHih91b3b5UhhhTaye/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107979; c=relaxed/simple;
	bh=qatNIJci3WKhQ+0+JT0//JgJlcNnKbGMZhbGMbS1LLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLB3h9zHQQ9VJJETIo60iwrOEEsEw3rRu5hYenu8j9s7U/f8Q1cnQ1tcwnQnvxsAjuFIi/JL3in1EJIZqGtCgsxINctZ7MeZu/3CxY0tt/36m8aaCA0JPYKIxpoXgXQZM09yWl+ZetpDHSLKG2ZseAKfGaak2J4TO0585P5ssLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79DC1227A88; Wed, 22 Oct 2025 06:39:30 +0200 (CEST)
Date: Wed, 22 Oct 2025 06:39:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	wangyufei@vivo.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <20251022043930.GC2371@lst.de>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com> <20251014120845.2361-1-kundan.kumar@samsung.com> <aPa7xozr7YbZX0W4@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPa7xozr7YbZX0W4@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 21, 2025 at 09:46:30AM +1100, Dave Chinner wrote:
> Not necessarily. The allocator can (and will) select different AGs
> for an inode as the file grows and the AGs run low on space. Once
> they select a different AG for an inode, they don't tend to return
> to the original AG because allocation targets are based on
> contiguous allocation w.r.t. existing adjacent extents, not the AG
> the inode is located in.

Also, as pointed out in the last discussion of this for the RT
subvolume there is zero relation between the AG the inode is in
and the data placement.


