Return-Path: <linux-fsdevel+bounces-21464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF8904419
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F931C246AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C047711C;
	Tue, 11 Jun 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r3fAqW6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD16D1D7;
	Tue, 11 Jun 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132352; cv=none; b=PIA/akYppPVUEgKbu+w7IDvr3ITl8icnvnr9wuT6RGjs5YBfc+4S2fSMNGtXjBqsutmgC8LkS5NUDQ/bfiYJdwHmQDLQsGoxjka4AQxUANryl9rH3yhIxy/Z99Ie2y+SfdyZJWZhkUJkORvTU+bacCQDDnsbrGfeVECivZZLXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132352; c=relaxed/simple;
	bh=2ko4AZAQjHKkQKP0cOLbkW/lgcK+uu590PSvOaZZPYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLgwDxAVMhtACJH9IrtRXOG6y+eajC13RZnxGnVYE5MHkbFhs9i1PVjPIWYR6ILoOmeiB80gDQtJHTML3Y8Q4+kiCkx/O6DAotIp2mjLGA7+0tMsVM3hNZCXWQH79NVdnyKSeQkClnw3e4mvuFEmwsX497VSbgaml/I6iZSRiQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r3fAqW6w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5/Z2xlBkH/IkjDKgK+u4Kdw+HNECNgtpfjVhYfN2IyE=; b=r3fAqW6wR3TOHT5LMXNw6yql1i
	p8FMBVIc+dLcNEkS64fwz/4q6hNFANw15RdbDXVRsu16KMrI8mxbh2z2hbyWIAN5FkeS7rNXnvzvE
	4VCdj9k3kH0dmVdw9FQo1Krb7JjbMmFbYHnSjkwYzF/6+uvGzy+uVmWeHEktgi/AMpLnj68v9syd0
	P69xwyXZrrtQQN4xaBdEezV29h0CBsVfk9CzgwHeGk+TR5rqwte/+ipDj+G1Nlxq8qRi084CxvRG1
	FDhxRJ7z/tM0qIhgF5a7FZqFcdjPmD9s2iP43LtyLnk/tXFzpyaQek9psB3/OQVbDV4fh3PmFQMPz
	qEiAoPfg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH6i5-00000009vLn-1bJw;
	Tue, 11 Jun 2024 18:59:09 +0000
Date: Tue, 11 Jun 2024 11:59:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 5/5] fstests: add stress truncation + writeback test
Message-ID: <ZmiefecsEYNJhdDP@bombadil.infradead.org>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-6-mcgrof@kernel.org>
 <20240611144503.GI52977@frogsfrogsfrogs>
 <ZmiUWCPcmtFSdrBG@bombadil.infradead.org>
 <20240611182959.GZ52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611182959.GZ52987@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jun 11, 2024 at 11:29:59AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 11, 2024 at 11:15:52AM -0700, Luis Chamberlain wrote:
> > On Tue, Jun 11, 2024 at 07:45:03AM -0700, Darrick J. Wong wrote:
> > > On Mon, Jun 10, 2024 at 08:02:02PM -0700, Luis Chamberlain wrote:
> > > > +# Requires CONFIG_DEBUGFS and truncation knobs
> > > > +_require_split_debugfs()
> > > 
> > > Er... I thought "split" referred to debugfs itself.
> > > 
> > > _require_split_huge_pages_knob?
> > 
> > Much better, thanks.
> > 
> > > > +# This aims at trying to reproduce a difficult to reproduce bug found with
> > > > +# min order. The issue was root caused to an xarray bug when we split folios
> > > > +# to another order other than 0. This functionality is used to support min
> > > > +# order. The crash:
> > > > +#
> > > > +# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> > > 
> > > You might want to paste the stacktrace in here directly, in case the
> > > gist ever goes away.
> > 
> > Its not a simple crash trace, it is pretty enourmous considering I
> > decoded it, and it has all locking candidates. Even including it after
> > the "---" lines of the patch might make someone go: TLDR. Thoughts?
> 
> I'd paste it in, even if it's quite lengthy.  I don't even think it's all that
> much if you remove some of the less useful bits of the unwind:
> 
> "Crash excerpt is as follows:
> 
> "BUG: kernel NULL pointer dereference, address: 0000000000000036
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 2190 Comm: kworker/u38:5 Not tainted 6.9.0-rc5+ #14
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Workqueue: writeback wb_workfn (flush-7:5)
> RIP: 0010:filemap_get_folios_tag+0xa9/0x200
> Call Trace:
>  <TASK>
>  writeback_iter+0x17d/0x310
>  write_cache_pages+0x42/0xa0
>  iomap_writepages+0x33/0x50
>  xfs_vm_writepages+0x63/0x90 [xfs]
>  do_writepages+0xcc/0x260
>  __writeback_single_inode+0x3d/0x340
>  writeback_sb_inodes+0x1ed/0x4b0
>  __writeback_inodes_wb+0x4c/0xe0
>  wb_writeback+0x267/0x2d0
>  wb_workfn+0x2a4/0x440
>  process_one_work+0x189/0x3b0
>  worker_thread+0x273/0x390
>  kthread+0xda/0x110
>  ret_from_fork+0x2d/0x50
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>"

Ah, sorry yes, this crash dump is small, the other one is the one that
was I thinking, which we still deadlock on and have only a lockdep hint
about likely what is going on. I'll include this dump on v2.

  Luis

