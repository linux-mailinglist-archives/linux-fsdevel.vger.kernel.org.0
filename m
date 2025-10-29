Return-Path: <linux-fsdevel+bounces-66201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A4C19465
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA459560BBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224031E115;
	Wed, 29 Oct 2025 08:55:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AC1DF271;
	Wed, 29 Oct 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728134; cv=none; b=XuinV7NTH9YgH00vxGCp7ApsE5qMKpYMHsUymSLJr2LQ5/u9rrj/FRT6KpstZvWdeT+ZkwlDeI5CJvSHAPgfUsMe3sbTM0vNp3qOTSA0JPMNkVy1DxNoxi/CNTv1IPekepggeBeVCwZGT9B9IsgyPxzQ2cIQQN8iPBgeappjO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728134; c=relaxed/simple;
	bh=zepYc3++ebcZ2KMN9+QV/h2Vjz82C9++wv7Z2LBWOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv/q9/bDyVcDSfcfoSbaUceWk4S67PcP9+YIi9o5BMvm9/28SBxoyTxrag2uW45N66U33XSGVDtrHJYJLwQqXoMMobsXuCqGtUfWAtQjHZgCqXVhP7M/rS7bEMAgbmHhnkXirD/u6PGA+pGXJcrET4n4/OV6HlPG91U16d5QRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEDD8227A88; Wed, 29 Oct 2025 09:55:26 +0100 (CET)
Date: Wed, 29 Oct 2025 09:55:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Dave Chinner <david@fromorbit.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	amir73il@gmail.com, axboe@kernel.dk, ritesh.list@gmail.com,
	dave@stgolabs.net, wangyufei@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v2 00/16] Parallelizing filesystem writeback
Message-ID: <20251029085526.GA32407@lst.de>
References: <CGME20251014120958epcas5p267c3c9f9dbe6ffc53c25755327de89f9@epcas5p2.samsung.com> <20251014120845.2361-1-kundan.kumar@samsung.com> <aPa7xozr7YbZX0W4@dread.disaster.area> <20251022043930.GC2371@lst.de> <e51e4fb9-01f7-4273-a363-fc1c2c61954b@samsung.com> <20251029060932.GS4015566@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029060932.GS4015566@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 28, 2025 at 11:09:32PM -0700, Darrick J. Wong wrote:
> Was that with or without rtgroups?  metadir/rtgroups aren't enabled by
> default yet so you'd have to select that manually with mkfs.xfs -m
> metadir=1.
> 
> (and you might still not see much change because of what hch said)

The real problem here is that even the inode number to AG association
is just a hint, and will often go wrong on an aged file system.

Now for the zoned RT device we could probably do a thread per open
zone, as that is a very logical association.  The problem with that
right now is that we only pick the zone to write to once doing
writeback, but there might be ways to lift it up.  Then again
zoned writeback is so little code that I can't see how it would
saturate a single thread.

> 
> --D
---end quoted text---

