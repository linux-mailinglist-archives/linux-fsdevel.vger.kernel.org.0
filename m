Return-Path: <linux-fsdevel+bounces-50492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13567ACC8B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB63818890FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78819238C36;
	Tue,  3 Jun 2025 14:05:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944FE555;
	Tue,  3 Jun 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959520; cv=none; b=hIOjuqDS3Fa6c3l6GQMK2bufE5uvqsVfAq3FkDVYRkqgPSLcvS9KLYbKd74xyD87XJ6UJyeNE1CeypewaXzXWO8W9xK74aHhCYAP8IVzFuWB/2il3kP4FMI9fEXDTSqEaoH4ME/g1mDf8rW/1P4SJIaj02ni6qKv9/qGTHAVqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959520; c=relaxed/simple;
	bh=/7gmfWPUUUH+3HZaLMCVF6p3MlsFHQNLtxEyr+1gqUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqdOx9817vZudmkFVkf/B+BDKcJJKMDuTFkgqIe5memeze3Wo/8UWcO2HyhZzFpC3MFff+ukfdAL9Ve9L5cmOcxnb85lEmL9OYZXbxAqJlThL0iGvdF23Xv88t4brLSYE5hVQVSGbRiA34itewNF/zFaHQhu5vRIAzr5PiC3AJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9FB0A68D12; Tue,  3 Jun 2025 16:05:13 +0200 (CEST)
Date: Tue, 3 Jun 2025 16:05:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org,
	chao@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net,
	p.raghav@samsung.com, da.gomez@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	kundanthebest@gmail.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250603140513.GB14351@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de> <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de> <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com> <20250603140445.GA14351@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603140445.GA14351@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 03, 2025 at 04:04:45PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 03, 2025 at 07:22:18PM +0530, Anuj gupta wrote:
> > > A mount option is about the worst possible interface for behavior
> > > that depends on file system implementation and possibly hardware
> > > chacteristics.  This needs to be set by the file systems, possibly
> > > using generic helpers using hardware information.
> > 
> > Right, that makes sense. Instead of using a mount option, we can
> > introduce generic helpers to initialize multiple writeback contexts
> > based on underlying hardware characteristics — e.g., number of CPUs or
> > NUMA topology. Filesystems like XFS and EXT4 can then call these helpers
> > during mount to opt into parallel writeback in a controlled way.
> 
> Yes.  A mount option might still be useful to override this default,
> but it should not be needed for the normal use case.

.. actually a sysfs file on the bdi is probably the better interface
for the override than a mount option.

