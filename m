Return-Path: <linux-fsdevel+bounces-50463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267BCACC7B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361A5174555
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D3231857;
	Tue,  3 Jun 2025 13:24:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018B1A08AF;
	Tue,  3 Jun 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957088; cv=none; b=k8hFJ0JGvUemIZK4PbeOi5aB7PGSDxSvTlShb5FJ2vIvKuYRpc09vm9Ecc9sMwxKGVCtRrFdnRFyTuHAJLLTq5aRf/r3zELTegynZLX0d7WwMyXiAajMpX9GkekdVbLdKcku9r1t/X6WJVDwBehBJO8jCpNWtIC+g8L3Shb5QOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957088; c=relaxed/simple;
	bh=YkplZoxchk+TFyPN/qguBcT2q6688KcYdcnl9pZWw3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI7CZkfn3RWv915Wv+FI8WlRGpuTEYGgVM1BMB73UojmkoajLMVeIVqCcWW5yBv0gi1P01yoNxJn7MNnwMgMDJ2ziGlPZ9L/ka1LL91VsN5xlqlGbA98G8+2eENCpqBsGDzCdrQquwGu64017RR0r9sCIjkv4dfsAiO5oR8SoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D45DF68D0F; Tue,  3 Jun 2025 15:24:34 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:24:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Kundan Kumar <kundan.kumar@samsung.com>,
	jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu,
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com,
	axboe@kernel.dk, ritesh.list@gmail.com, djwong@kernel.org,
	dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com,
	anuj1072538@gmail.com, kundanthebest@gmail.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <20250603132434.GA10865@lst.de>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com> <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de> <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 03, 2025 at 02:46:20PM +0530, Anuj Gupta/Anuj Gupta wrote:
> On 6/2/2025 7:49 PM, Christoph Hellwig wrote:
> > On Thu, May 29, 2025 at 04:44:51PM +0530, Kundan Kumar wrote:
> > Well, the proper thing would be to figure out a good default and not
> > just keep things as-is, no?
> 
> We observed that some filesystems, such as Btrfs, don't benefit from
> this infra due to their distinct writeback architecture. To preserve
> current behavior and avoid unintended changes for such filesystems,
> we have kept nr_wb_ctx=1 as the default. Filesystems that can take
> advantage of parallel writeback (xfs, ext4) can opt-in via a mount
> option. Also we wanted to reduce risk during initial integration and
> hence kept it as opt-in.

A mount option is about the worst possible interface for behavior
that depends on file system implementation and possibly hardware
chacteristics.  This needs to be set by the file systems, possibly
using generic helpers using hardware information.

> Used PMEM of 6G

battery/capacitor backed DRAM, or optane?

>
> and NVMe SSD of 3.84 TB

Consumer drive, enterprise drive?

> For xfs used this command:
> xfs_io -c "stat" /mnt/testfile
> And for ext4 used this:
> filefrag /mnt/testfile

filefrag merges contiguous extents, and only counts up for discontiguous
mappings, while fsxattr.nextents counts all extent even if they are
contiguous.  So you probably want to use filefrag for both cases.

