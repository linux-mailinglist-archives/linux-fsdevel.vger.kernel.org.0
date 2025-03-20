Return-Path: <linux-fsdevel+bounces-44592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D05A6A84B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F68C981CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46439223304;
	Thu, 20 Mar 2025 14:18:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D51D47A6;
	Thu, 20 Mar 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480334; cv=none; b=oILbnkDnJEndLKaPB0gPtcZrL3ecqOa0J6yPf6mLcSb6VaUo13TT/be/rHMVzVtysI+QC+lZtgnyojT9t3q3fV8puPEUqna/ojDWTwmpppuTuWKDoXgl+JtRj22SqshoFD28tlMkd119qtAftoaCulWw0Klz3LF12t68wKIFgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480334; c=relaxed/simple;
	bh=z0SpEwCYglJQbG+ycO6OoWcHpaVIFARN/Aoyofd6pjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR9EmifHoPGvf+aIdDQtj4Fm0mArgkM84YOyjWEyynOQmLn112FEAvUIL1feFMaqSiP2sQjib98GiNrX5PDAbhB58HegoI9BDSOb4ruEuvbiPC+NftBlGPygN8qt3SxlNOmysssbVWmJpFEBnfJGUYczjuI79Ml+Rb2b084SGzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE86768AA6; Thu, 20 Mar 2025 15:18:47 +0100 (CET)
Date: Thu, 20 Mar 2025 15:18:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	david@fromorbit.com, leon@kernel.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
	brauner@kernel.org, hare@suse.de, willy@infradead.org,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250320141846.GA11512@lst.de>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
> We've been constrained to a max single 512 KiB IO for a while now on x86_64.

No, we absolutely haven't.  I'm regularly seeing multi-MB I/O on both
SCSI and NVMe setup.

> This is due to the number of DMA segments and the segment size.

In nvme the max_segment_size is UINT_MAX, and for most SCSI HBAs it is
fairly large as well.


