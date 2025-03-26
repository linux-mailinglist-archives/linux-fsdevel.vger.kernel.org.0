Return-Path: <linux-fsdevel+bounces-45095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E5DA71B36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853A5188936A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B041F462C;
	Wed, 26 Mar 2025 15:56:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251871F4622
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004561; cv=none; b=OhmcBHwB2WuyPUBoX9fSlONd20Fdhsbcjg5IQ9MyjWD0AhnUkdUZ5CsDlWQgHEefGOaU1BXeOtrplUNn4YGjxTv2DSJIUXrsCXyeUjXQvCcA91Urb1O6aaKrU+2Qk03kWkieKN/jKrNv8/c43pvZQao8S3cPmLRcp03+jmy4sNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004561; c=relaxed/simple;
	bh=6KtF1XPi4tI2b5Yz4LvA80lIP+XxsfbAoKKpNifPtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psV27R7dZwBERPbaS+c25P8LoTPxQcJbSEEJCrGTtT8/6ZApyVB4UDsgpFbItphMU7sD46K/YhcCAxHod5UN+n7+ThPqh0CMwavD+EA8HUfQyDRx9OeUTAZQ7yNFXfktQvO+kfBXZtp0azWJLPU9WUffLiYzymxD1LUjVd7LNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([99.209.85.25])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52QFtMTW005549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 11:55:23 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 77A51346060; Wed, 26 Mar 2025 11:55:22 -0400 (EDT)
Date: Wed, 26 Mar 2025 11:55:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [LSF/MM/BPF Topic] Filesystem reclaim & memory allocation BOF
Message-ID: <20250326155522.GB1459574@mit.edu>
References: <Z-QcUwDHHfAXl9mK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-QcUwDHHfAXl9mK@casper.infradead.org>

On Wed, Mar 26, 2025 at 03:25:07PM +0000, Matthew Wilcox wrote:
> 
> We've got three reports now (two are syzkaller kiddie stuff, but one's a
> real workload) of a warning in the page allocator from filesystems
> doing reclaim.  Essentially they're using GFP_NOFAIL from reclaim
> context.  This got me thinking about bs>PS and I realised that if we fix
> this, then we're going to end up trying to do high order GFP_NOFAIL allocations
> in the memory reclaim path, and that is really no bueno.
> 
> https://lore.kernel.org/linux-mm/20250326105914.3803197-1-matt@readmodwrite.com/
> 
> I'll prepare a better explainer of the problem in advance of this.

Thanks for proposing this as a last-minute LSF/MM topic!

I was looking at this myself, and was going to reply to the mail
thread above, but I'll do it here.

From my perspective, the problem is that as part of memory reclaim,
there is an attempt to shrink the inode cache, and there are cases
where an inode's refcount was elevated (for example, because it was
referenced by a dentry), and when the dentry gets flushed, now the
inode can get evicted.  But if the inode is one that has been deleted,
then at eviction time the file system will try to release the blocks
associated with the deleted-file.  This operation will require memory
allocation, potential I/O, and perhaps waiting for a journal
transaction to complete.

So basically, there are a class of inodes where if we are in reclaim,
we should probably skip trying to evict them because there are very
likely other inodes that will be more likely to result in memory
getting released expeditiously.  And if we take a look at
inode_lru_isolate(), there's logic there already about when inodes
should skipped getting evicted.  It's probably just a matter of adding
some additional coditions there.

This seems relatively straightforward; what am I missing?

> Required attendees: Ted, Luis, Chris, Josef, other people who've wrestled
> with this before.

Happy to be there!   :-)_

						- Ted

