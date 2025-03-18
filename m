Return-Path: <linux-fsdevel+bounces-44292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EEA66E4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7132216C3A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453CF1FA261;
	Tue, 18 Mar 2025 08:32:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D391A3029;
	Tue, 18 Mar 2025 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286731; cv=none; b=B9cPxnHxK7rvBKmNbTOK/S5BQgDAXYFnZwDEmrJ/c/q/yT+d9824cNkOGyMyZty0ixiDrChmGKVF9PIMYZ80nMAiqN3FOXfxbng9y8y4zJ9v9Lcyc3iDYm82f+jXbwgbKcmhjEBb7Wtv5Re7FjoZzYKsiQC2jMYKzmzuHmMLeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286731; c=relaxed/simple;
	bh=VUBUtsEoRtebnSCvo7AuNWKcmyLRVO2HXmd33PWz/Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzbCy81Sy27840we8STIU6HFVCbjlOoiiO58wohPFfd84rVEnQNpfwv/klB4eZOQqjMFjgTmpttHkw8rLwaSwrVCL19AdJS9DRgQcmkarww1JGRPteAp/Rhc7FVkZrPsmF0jFFf+PcMetUeZSeFlZK8rFoML/+LHGTFexCZ050o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5910A68AFE; Tue, 18 Mar 2025 09:32:04 +0100 (CET)
Date: Tue, 18 Mar 2025 09:32:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <20250318083203.GA18902@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com> <Z9fOoE3LxcLNcddh@infradead.org> <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com> <20250318053906.GD14470@lst.de> <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 08:22:53AM +0000, John Garry wrote:
>> Is xfs_reflink_allocate_cow even the right helper to use?  We know we
>> absolutely want a a COW fork extent, we know there can't be delalloc
>> extent to convert as we flushed dirty data, so most of the logic in it
>> is pointless.
>
> Well xfs_reflink_allocate_cow gives us what we want when we set some flag 
> (XFS_REFLINK_FORCE_COW).
>
> Are you hinting at a dedicated helper? Note that 
> xfs_reflink_fill_cow_hole() also handles the XFS_REFLINK_FORCE_COW flag.

We might not even need much of a helper.  This all comes from my
experience with the zoned code that always writes out of place as well.
I initially tried to reuse the existing iomap_begin methods and all
these helpers, but in the end it turned out to much, much simpler to
just open code the logic.  Now the atomic cow code will be a little
more complex in some aspect (unwritten extents, speculative
preallocations), but also simpler in others (no need to support buffered
I/O including zeroing and sub-block writes that require the ugly
srcmap based read-modify-write), but I suspect the overall trade-off
will be similar.

After all the high-level logic for the atomic COW iomap_begin really
should just be:

 - take the ilock
 - check the COW fork if there is an extent for the start of the range.
 - If yes:
     - if the extent is unwritten, convert the part overlapping with
       the range to written
     - return the extent
 - If no:
     - allocate a new extent covering the range in the COW fork

Doing this without going down multiple levels of helpers designed for
an entirely different use case will probably simplify things
significantly.

