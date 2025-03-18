Return-Path: <linux-fsdevel+bounces-44252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B1A6698B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639C23BA6CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E422E1DE4E6;
	Tue, 18 Mar 2025 05:39:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376E1DDC2D;
	Tue, 18 Mar 2025 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276354; cv=none; b=FCxAJGvEZcr6TPIoA7kY5XtQiQSHaa20R2X0G9avjH1skz62vee3bc1mgOXKqK6uOIJeHHpvHuKr1XUcz/ZfbVa1hZCFsYcDgxzVK8yHd5zX+yjPcujtjsxPZ+HwSX9SdebziwB8+nEc+8lvQ/sb//31OVp3pVm+4t653pZsYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276354; c=relaxed/simple;
	bh=gnLy4gjsKw4mL53JpCqDMubzDfHVBKrp9v+boAMKJf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy2KDhrGdbBHtmRZVzC9Hvur3YyA++CinodFr/uW1C3fHaT/EVjbynx0FIArX0E8CtXTOQngnzO3MaWG8fGioBMr9EpvOz+xxOQ38RDw7bJnTF0ThBVhgck46XAJEm06C30WR2vF6LWTEHrwk2ZpDwphXcvd57NCsPddfH6/26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A725D68AA6; Tue, 18 Mar 2025 06:39:07 +0100 (CET)
Date: Tue, 18 Mar 2025 06:39:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
Message-ID: <20250318053906.GD14470@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-11-john.g.garry@oracle.com> <Z9fOoE3LxcLNcddh@infradead.org> <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 10:18:58AM +0000, John Garry wrote:
> On 17/03/2025 07:26, Christoph Hellwig wrote:
>>> +static bool
>>> +xfs_bmap_valid_for_atomic_write(
>>
>> This is misnamed.  It checks if the hardware offload an be used.
>
> ok, so maybe:
>
> xfs_bmap_atomic_write_hw_possible()?

That does sound better.

> Fine, so it will be something like "atomic writes are required to be 
> naturally aligned for disk blocks, which is a block layer rule to ensure 
> that we won't straddle any boundary or violate write alignment 
> requirement".

Much better!  Maybe spell out the actual block layer rule, though?

>>
>> Should the atomic and cow be together for coherent naming?
>> But even if the naming is coherent it isn't really
>> self-explanatory, so please add a little top of the function
>> comment introducing it.
>
> I can add a comment, but please let me know of any name suggestion

/*
 * Handler for atomic writes implemented by writing out of place through
 * the COW fork.  If possible we try to use hardware provided atomicy
 * instead, which is handled directly in xfs_direct_write_iomap_begin.
 */

>
>>
>>> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>>> +			&nimaps, 0);
>>> +	if (error)
>>> +		goto out_unlock;
>>
>> Why does this need to read the existing data for mapping?  You'll
>> overwrite everything through the COW fork anyway.
>>
>
> We next call xfs_reflink_allocate_cow(), which uses the imap as the basis 
> to carry the offset and count.

Is xfs_reflink_allocate_cow even the right helper to use?  We know we
absolutely want a a COW fork extent, we know there can't be delalloc
extent to convert as we flushed dirty data, so most of the logic in it
is pointless.


