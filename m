Return-Path: <linux-fsdevel+bounces-66182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1CC18628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AF4402C2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311812FDC20;
	Wed, 29 Oct 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv8axgsk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656202FD7D6;
	Wed, 29 Oct 2025 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718173; cv=none; b=fxZuWwQ4LTFtESR+RLvu59Ur2kWq2K9qoEUXpm9woEsmlwg8VhnGdDhmQSlmYSS/ZAf+6OpayxnHs7h1WCIJ6zcGsl8MDlo0WdlOy7VVQKRUanDUY4F0hAFqQ0JicG8ljfOwXwLGw7VDS40WTHGDvJPM42lmwHSwLL2tAGGpdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718173; c=relaxed/simple;
	bh=KhUCwoEAjcKURljQn6Z5eULKXiBUNQeiGlQ0+eSZ1+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5OpGz61FrmSNYfDViWFGRy+CsW+JStAGoxd0s7sYjP5uaf1QUpM6C3QfILWC+MoMUtMnIs6F8ehEkiESqeyP+iglffu2OZld/jd73Q6we5N/utA4IzudLdJhj0MUd4Nd3ABwFNNLXIe7d8KDhgVr66/FS+TxtBwBYyFqSW4B9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv8axgsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AD4C4CEF7;
	Wed, 29 Oct 2025 06:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718173;
	bh=KhUCwoEAjcKURljQn6Z5eULKXiBUNQeiGlQ0+eSZ1+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jv8axgsk0a3r/K6s7anKOkdMHyoV9M9ohNLW6Pl1/bQB2ujsqML/NoQhhejBmqaK3
	 86Xp9WXDrWll1/0uizzBMXVWnxjT6M1yQXWhR/dtFAgXer1cs0/+gCJokbdV+U+R7j
	 rh+bSqMZejs5VHCLhtFXE+64+ISmcgtS1QgL9x108T5fFxUd17eLyFDWoTYmrq7fm/
	 VeqiahI9+MlKVwQ85vBqNlyTiOFo7DuhfqFp7iQWb7Tzt1SRshl6CLVMWIgK5bNXru
	 C3dGfWC2R7UhQIz7c+PDEO0phQxrW7dVvcP9VhkDolbrbTYJpovNOzg2NZKZDgxt/m
	 /E7EbpFdhc1wg==
Date: Tue, 28 Oct 2025 23:09:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <20251029060932.GS4015566@frogsfrogsfrogs>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com>
 <20251014120845.2361-1-kundan.kumar@samsung.com>
 <aPa7xozr7YbZX0W4@dread.disaster.area>
 <20251022043930.GC2371@lst.de>
 <e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com>

On Wed, Oct 29, 2025 at 11:35:21AM +0530, Kundan Kumar wrote:
> On 10/22/2025 10:09 AM, Christoph Hellwig wrote:
> > On Tue, Oct 21, 2025 at 09:46:30AM +1100, Dave Chinner wrote:
> >> Not necessarily. The allocator can (and will) select different AGs
> >> for an inode as the file grows and the AGs run low on space. Once
> >> they select a different AG for an inode, they don't tend to return
> >> to the original AG because allocation targets are based on
> >> contiguous allocation w.r.t. existing adjacent extents, not the AG
> >> the inode is located in.
> > 
> > Also, as pointed out in the last discussion of this for the RT
> > subvolume there is zero relation between the AG the inode is in
> > and the data placement.
> > 
> > 
> I evaluated the effect of parallel writeback on realtime inodes and
> observed no improvement in IOPS. We can limit writes for realtime
> inodes to utilize a single default (0) writeback context. Do you
> see it differently?

Was that with or without rtgroups?  metadir/rtgroups aren't enabled by
default yet so you'd have to select that manually with mkfs.xfs -m
metadir=1.

(and you might still not see much change because of what hch said)

--D

