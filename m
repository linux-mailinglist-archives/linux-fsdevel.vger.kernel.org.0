Return-Path: <linux-fsdevel+bounces-45172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39448A74054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44FC1890A27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 21:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B51DE3B3;
	Thu, 27 Mar 2025 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXCzw67Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF91CDA2D;
	Thu, 27 Mar 2025 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111354; cv=none; b=hykfsMVrBZvnpa3EMsFNjEj1KROZ8mfOkeStrf1Mw8z5lZNp8vBxXMAYkxQmycx9W4VY35Lth5x9f1/SpOwmLN/FkZyY30vqtKVzkyaE4A9YrAYOinVUjL3SoYsfJUQV8oUH/7TX4QTWegu4f8b2fuMFEcVETBdoUfP57+XcCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111354; c=relaxed/simple;
	bh=LTF6cEblwWCHk6Ff4Ck1T08RDaFdQ1h4B3Knna6bGGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHFUxlxHJcQGyyLSyZtLglo2Q86McsRsH2IdRaXzxh5RwX4rqaB6Rs8WwSUSeLQD3scu8dduN/eveBvOOF+7YGSa3gnJtFl0mVsPG0pRlI6ENuYf5RmWshOoMo7kPuEyABwpzWbrTgJsdmCDwDLgTLzc0sYKYPMOtjV9kts4XHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXCzw67Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A47C4CEDD;
	Thu, 27 Mar 2025 21:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743111352;
	bh=LTF6cEblwWCHk6Ff4Ck1T08RDaFdQ1h4B3Knna6bGGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXCzw67YHPTYIT5MbmZFL4Rm6dK5qHQ4Zcl3HbJ4XmLeMAr44O5KkWKCMTePwnvgN
	 HbKyfwxydV34Fv9NSdRreZhetLuG/psuYz/p2HrVVGmp+5M4sfORVC2+qv7hfa3vyE
	 AJWyROHrpOBnEtwEsaPrGQ0ouwsRL5TpeXjky1CJz71QeDpQrzBjCLc1D4zXpBl9zC
	 RcOtuD4MSQjFkGYfm/F5izaEWBUNgEkipZ1PJqVamFIAlpEf8oNB6hyDX1dcDwlS+n
	 ZWOsic93gSKazwsepLOCdsLE/zYbLNDBM6i7SVBRCtwXnV+V2x1b6qsO/p7L1/o06P
	 +4VKCeoMjuKwA==
Date: Thu, 27 Mar 2025 14:35:50 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: Re: [PATCH] generic/764: fsstress + migrate_pages() test
Message-ID: <Z-XEtgT4quWcnG_T@bombadil.infradead.org>
References: <20250326185101.2237319-1-mcgrof@kernel.org>
 <pociwdgfqbzw4mjass6u6wcnvmqlh3ddqzoeoiwiyqs64pl6yu@5ad7ne7rgwe2>
 <Z-WzlUN6fSciApiC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-WzlUN6fSciApiC@dread.disaster.area>

On Fri, Mar 28, 2025 at 07:22:45AM +1100, Dave Chinner wrote:
> On Thu, Mar 27, 2025 at 12:53:30PM +0100, Jan Kara wrote:
> > On Wed 26-03-25 11:50:55, Luis Chamberlain wrote:
> > > 0-day reported a page migration kernel warning with folios which happen
> > > to be buffer-heads [0]. I'm having a terribly hard time reproducing the bug
> > > and so I wrote this test to force page migration filesystems.
> > > 
> > > It turns out we have have no tests for page migration on fstests or ltp,
> > > and its no surprise, other than compaction covered by generic/750 there
> > > is no easy way to trigger page migration right now unless you have a
> > > numa system.
> > > 
> > > We should evaluate if we want to help stress test page migration
> > > artificially by later implementing a way to do page migration on simple
> > > systems to an artificial target.
> > > 
> > > So far, this doesn't trigger any kernel splats, not even warnings for me.
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Link: https://lore.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > So when I was testing page migration in the past MM guys advised me to use
> > THP compaction as a way to trigger page migration. You can manually
> > trigger compaction by:
> > 
> > echo 1 >/proc/sys/vm/compact_memory
> 
> Right, that's what generic/750 does. IT runs fsstress and every 5
> seconds runs memory compaction in the background.
> 
> > So you first mess with the page cache a bit to fragment memory and then
> > call the above to try to compact it back...
> 
> Which is effectively what g/750 tries to exercise.

Indeed. And I've tried g/750 for over 24 hours trying to reproduce
the issue reported by Oliver and I was not able to, so this augments the
coverage.

The original report by Oliver was about ltp syscalls-04/close_range01
triggering the spin lock on the buffer_migrate_folio_norefs() path which
triggers a lock followed by a sleep context. But the report indicates
the test ran with btrfs and btrfs does not use buffer_migrate_folio_norefs().
Although clearly the splat and diagnosis by Matthew that the spinlock seems
to need fixing, reproducing this issue would be good. But this has been hard.

In fact there are only a few users of buffer_migrate_folio_norefs() left
and ext4 is one of them, as well as the block layer.

I wrote this test to see if this might help with another path, the other
aspect of migration on numa nodes with ext4. But sadly I can't reproduce
the issue yet.

I'm next trying fio against a block device directory and then looping
with migratepages on the pid, essentially bouncing the memory from fio
from one node to another in a loop. And.. nothing yet.. even if I then
try to loop enabling compaction.

Syszbot recently provided another reproducer in C  [0] but that hasn't let me
reproduce the issue yet either.

> When it's run by check-parallel, compaction ends up doing a lot
> more work over a much wider range of tests...

Yeah I would hope the issue is reproducible with check-parallel, I
haven't been able to run it yet but as soon as I do I am going to
be supper happy due the huge benefits this will bring to testing.

[0] https://lkml.kernel.org/r/67e57c41.050a0220.2f068f.0033.GAE@google.com

  Luis

