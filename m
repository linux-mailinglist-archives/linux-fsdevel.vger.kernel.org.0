Return-Path: <linux-fsdevel+bounces-46013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4095A8140F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606073BE367
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E523E25B;
	Tue,  8 Apr 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r011JZJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D141A8407;
	Tue,  8 Apr 2025 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134535; cv=none; b=BTNBpjPgLJYjNDtsnVUOnKRyDYoJA56y18i3K8HoZuB0fng6KtOOjxGK8T0DYSUrUkYNlpoERbHuJN8O0hz7Mbcr4Ls4JlTddcjPHSd0meUMd+JKvy/t8VsLkljHIv5proVmAYKF4kX96Q3rZJp2hCAR1x0tZUqBLgbfwV3kUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134535; c=relaxed/simple;
	bh=TdcykO/mghNf7CApPAPiGbc4Ap+76aFjaQ1G0ZF/1Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAw8hynYVbvTZXKV9PJ5wuU2hzVTIHxiZMwBCJw/4MLPL8VL9I7+WLzUw6d49Vnkj7169IKJVI6B+mcaHdiWTzen2UO6iwmwMK6eHTqhqQ4hxqrFugRgHTCwtvGFau6diyEKc4GnJ6MEDS/ug1dtLJo4vD4MWpSPsyBmOFB3phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r011JZJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F30C4CEE5;
	Tue,  8 Apr 2025 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134535;
	bh=TdcykO/mghNf7CApPAPiGbc4Ap+76aFjaQ1G0ZF/1Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r011JZJ1Bwu5Q3CTglhODEsz9xvCkNNFznG4hJq0zj2FGM9UvvS6i18OLvLwe9EIW
	 wbciFnly4IhqfzgqcxVGhGbTXEPXWtX2tSZsbyJQCDrZj0lsAvc1ctVYf4zeFktpIZ
	 3vZm/cpmUHcjicVH0gPjtT+TAKnAPx/IS2GpFhx4eiyBRRwaYtosGcFp+8vzy3Bw+N
	 XTN8eS0glsG4Jmqi5/T5CorQajBJXZ0O9B3f/BZ4GGrHHd3u+4exvp31qgZ7FBuoU8
	 kzzNFYOm4wswHtUy1uL8Clg7ln3OgJeic63egQay8Be9BmABHamxhE98z7PlVQxf2P
	 JtSj3XxUtX+og==
Date: Tue, 8 Apr 2025 10:48:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: David Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Tso Ted <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Oliver Sang <oliver.sang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, John Garry <john.g.garry@oracle.com>,
	linux-block@vger.kernel.org, ltp@lists.linux.it,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>, gost.dev@samsung.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <20250408174855.GI6307@frogsfrogsfrogs>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>

On Tue, Apr 08, 2025 at 10:24:40AM -0700, Luis Chamberlain wrote:
> On Tue, Apr 8, 2025 at 10:06 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > Fun
> > puzzle for the community is figuring out *why* oh why did a large folio
> > end up being used on buffer-heads for your use case *without* an LBS
> > device (logical block size) being present, as I assume you didn't have
> > one, ie say a nvme or virtio block device with logical block size  >
> > PAGE_SIZE. The area in question would trigger on folio migration *only*
> > if you are migrating large buffer-head folios. We only create those
> 
> To be clear, large folios for buffer-heads.
> > if
> > you have an LBS device and are leveraging the block device cache or a
> > filesystem with buffer-heads with LBS (they don't exist yet other than
> > the block device cache).

My guess is that udev or something tries to read the disk label in
response to some uevent (mkfs, mount, unmount, etc), which creates a
large folio because min_order > 0, and attaches a buffer head.  There's
a separate crash report that I'll cc you on.

--D

