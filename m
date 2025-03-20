Return-Path: <linux-fsdevel+bounces-44620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B03A6AB50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D3980619
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36FC2222CF;
	Thu, 20 Mar 2025 16:45:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5E1E7C3B;
	Thu, 20 Mar 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489101; cv=none; b=sv3v01HPaln7PRzc9op6X2+HdVXqbRqb4kwKSHhIyZnuhLr9WXRgzyu/5LJ4hn52J6Zu3ArYR0CfYgA+roP7yFGvzvoQb4gLKkdp++zuSACqcTCb9171Z7xqbFK+PHPwzBtbBNnAyThfnNU2C0OigNt5qhnbmcnmTLH4dphrwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489101; c=relaxed/simple;
	bh=/u61Jwp+ai5pZlaKMnn+SZJFHL2VxcANp7aVTHQUCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlzHC+YGefjJntQTG/PPr3qV6JI3PGt1h2GK+CXM7itK7sXk1LDWAIyJsbAZtUd1dNqeZpu8ZjFXwHybbD6QkNoyG8r4wncphfFC27TmiYDK61fwH31pNgd0yDT3I7idsztoziDkV6qfEo+jUqKSNvAgNTw16kAJj13s/rk3u2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 271EE68AA6; Thu, 20 Mar 2025 17:44:52 +0100 (CET)
Date: Thu, 20 Mar 2025 17:44:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
	kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	joro@8bytes.org, brauner@kernel.org, hare@suse.de,
	david@fromorbit.com, djwong@kernel.org, john.g.garry@oracle.com,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
Message-ID: <20250320164451.GA21364@lst.de>
References: <20250320111328.2841690-1-mcgrof@kernel.org> <20250320111328.2841690-3-mcgrof@kernel.org> <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org> <Z9w9FWG2hKCe7mhR@casper.infradead.org> <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org> <Z9xB4kZiZfSdFJfV@casper.infradead.org> <7cc6f537-aac4-4bfc-80f0-1829a850d56a@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc6f537-aac4-4bfc-80f0-1829a850d56a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 09:34:50AM -0700, Bart Van Assche wrote:
> The fact that this change is proposed because there are device
> manufacturers that want to produce devices with block sizes larger than
> 64 KiB would be useful information for the commit message.

I think it's just the proposal that is very confused.  Keith pointed
out that number of segments mostly matters when you have 4k
non-contiguous pages and that's where the quoted limit comes from.

The LBA size is a lower bound to the folio size in the page cache,
so the limit automatically increases with that, although in practice
the file system will usually allocate larger folios even with a smaller
block size, and I assume most systems (or at least the ones that care
about performance) actually use transparent huge pages/folios for
anonymous memory as well.


