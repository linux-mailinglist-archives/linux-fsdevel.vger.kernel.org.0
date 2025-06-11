Return-Path: <linux-fsdevel+bounces-51341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1937AD5B13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8771316C987
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FB1DED53;
	Wed, 11 Jun 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwkK3sVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A71C84CE;
	Wed, 11 Jun 2025 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657105; cv=none; b=Awzj2HzShkh/6eQOrhmOnm/jHiVHr2r7A17C/bMAAIS06R/TmHHh1NY6ELHVrFdf0ug3KpK/kOMvpOTGTglT6A/CmPy34LbV58UTIBDWCKGNtU0ubjERG2nJwlpsk0U0B3vGvStA+YRV0s7bifAKV+uy5woC3ipZwvYoVqH9ZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657105; c=relaxed/simple;
	bh=Skl9KDuzJqFaqd+d7kcHfX6PNCmoq83oIlnZ4Q2zi04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjCHLnxgp9SNo3z26ZFanZVWKyDhUSNse3yBaa0eXKAkab+FbHRK9LciCrA1Py8DXnFOTczzHW+PTV0AoJI4liGAR5Zo9TSdn5MJOAJvC2he1/kE/0odXLlYdUxSwX6symPh2C8TxzxiWTwFB1+Xs+2V8QiAvrePIyjvBdGG88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwkK3sVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC8CC4CEE3;
	Wed, 11 Jun 2025 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749657105;
	bh=Skl9KDuzJqFaqd+d7kcHfX6PNCmoq83oIlnZ4Q2zi04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwkK3sVut+NThYh8qunzKpQ31Iwkrb1zjgxChbVqqV+oYpwR7fQbZPVg5A4Edk1ro
	 DCx3vF9ZtNT6ZDuYi3UopU5ifN5EotQF9zpy+5l37R7AVrIL3EIjhVePvIh9dIB4ZS
	 G/6R65R4Dn9ayyjY0KN/zRtZ28f2pepHw4nRUylMoAEErlDyz33KfDqQ4RyC751rg1
	 +FDXedv6UJgjDRzfI7isBuziAum8IKVKFsQzx3ZXq/U/fnwpekElwBhfmXNCNgWWCD
	 fqUIl1THgMSG4gfel9y+JyZmo6pLuQ80/jT72VVbjkgut1TcwbA6dDPc6rIL2IitzD
	 9a5tjk1UXZF3w==
Date: Wed, 11 Jun 2025 08:51:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundanthebest@gmail.com>
Cc: Anuj gupta <anuj1072538@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250611155144.GD6138@frogsfrogsfrogs>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com>
 <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
 <20250603132434.GA10865@lst.de>
 <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
 <CALYkqXqVRYqq+5_5W4Sdeh07M8DyEYLvrsm3yqhhCQTY0pvU1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALYkqXqVRYqq+5_5W4Sdeh07M8DyEYLvrsm3yqhhCQTY0pvU1g@mail.gmail.com>

On Wed, Jun 04, 2025 at 02:52:34PM +0530, Kundan Kumar wrote:
> > > > For xfs used this command:
> > > > xfs_io -c "stat" /mnt/testfile
> > > > And for ext4 used this:
> > > > filefrag /mnt/testfile
> > >
> > > filefrag merges contiguous extents, and only counts up for discontiguous
> > > mappings, while fsxattr.nextents counts all extent even if they are
> > > contiguous.  So you probably want to use filefrag for both cases.
> >
> > Got it — thanks for the clarification. We'll switch to using filefrag
> > and will share updated extent count numbers accordingly.
> 
> Using filefrag, we recorded extent counts on xfs and ext4 at three
> stages:
> a. Just after a 1G random write,
> b. After a 30-second wait,
> c. After unmounting and remounting the filesystem,
> 
> xfs
> Base
> a. 6251   b. 2526  c. 2526
> Parallel writeback
> a. 6183   b. 2326  c. 2326

Interesting that the mapping record count goes down...

I wonder, you said the xfs filesystem has 4 AGs and 12 cores, so I guess
wb_ctx_arr[] is 12?  I wonder, do you see a knee point in writeback
throughput when the # of wb contexts exceeds the AG count?

Though I guess for the (hopefully common) case of pure overwrites, we
don't have to do any metadata updates so we wouldn't really hit a
scaling limit due to ag count or log contention or whatever.  Does that
square with what you see?

> ext4
> Base
> a. 7080   b. 7080    c. 11
> Parallel writeback
> a. 5961   b. 5961    c. 11

Hum, that's particularly ... interesting.  I wonder what the mapping
count behaviors are when you turn off delayed allocation?

--D

> Used the same fio commandline as earlier:
> fio --filename=/mnt/testfile --name=test --bs=4k --iodepth=1024
> --rw=randwrite --ioengine=io_uring  --fallocate=none --numjobs=1
> --size=1G --direct=0 --eta-interval=1 --eta-newline=1
> --group_reporting
> 
> filefrag command:
> filefrag  /mnt/testfile
> 

