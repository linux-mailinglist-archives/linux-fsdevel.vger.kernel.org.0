Return-Path: <linux-fsdevel+bounces-44250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A81A66971
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 06:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFF017BA8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93371DD0D5;
	Tue, 18 Mar 2025 05:33:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD01C173D;
	Tue, 18 Mar 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276017; cv=none; b=QilLrKyE+t0WNjpfgQtuH8UT0VnJueD40qW/6AG65L/VQu46X1349bqFc+ZMghylTw/VqKKRqzeseM9XvmvyiV1ud/0MP4PVsbYtbyeTg9YW4zCZs5LtSR3rMOcNQF1Pw1P2r4cnyo7ZCoSt/OzMwP6oj9K9sV8/4nO2G0rKefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276017; c=relaxed/simple;
	bh=OxtWREZnetr8xI1wT+yLxBvviutkth7E7SKabR0SFJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLig0AnDv2J9oUlCVxxvE/4uiM4GYZdpnEI4WLCLSmHy7FqWScIqqh+xvp7O8LAEpGE+GgGlxwj4K9liYymTz7wIeWCIFZ5wKp6bJsqu/OIoI2sUQhyWkIhEB3MinK6NYcZ7rR1L0Tyj8XO+/N/9dzbodNMSkl8IcOVgbF3xLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DDDC68B05; Tue, 18 Mar 2025 06:33:31 +0100 (CET)
Date: Tue, 18 Mar 2025 06:33:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 04/13] xfs: pass flags to xfs_reflink_allocate_cow()
Message-ID: <20250318053330.GB14470@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-5-john.g.garry@oracle.com> <20250317061523.GD27019@lst.de> <7c9b72fa-652a-44d5-9d51-85b609676901@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9b72fa-652a-44d5-9d51-85b609676901@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 09:17:10AM +0000, John Garry wrote:
>>
>> Given that this is where the policy is implemented now, this comment:
>>
>> 	/*
>> 	 * COW fork extents are supposed to remain unwritten until we're ready
>>           * to initiate a disk write.  For direct I/O we are going to write the
>> 	 * data and need the conversion, but for buffered writes we're done.
>>           */
>>
>> from xfs_reflink_convert_unwritten should probably move here now.
>
> ok, fine, I can relocate this comment to xfs_direct_write_iomap_begin(), 
> but please let me know if you prefer an rewording.

I have to admit I found the wording a bit odd, but I failed to come up
with something significantly better.


