Return-Path: <linux-fsdevel+bounces-21461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB329043B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4C21F2298B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91125770FB;
	Tue, 11 Jun 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4wHn2wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E198474BE2;
	Tue, 11 Jun 2024 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130601; cv=none; b=PyITepaDUWUYDPo2qAs+S9ShJMMlec2HfoVrVGfDvucsxT4wU5irnhkHADKsV6EiNPQhmjtLxT7TDzIzBO7AJ9AVlD/TWbw2Qozwg6AzYeOe8vEiCS7qpdXPUEGCafT9pAD7W5Gq4jrjgHaaGzJ+sjZmQ7V7bXiO1Pk5imivlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130601; c=relaxed/simple;
	bh=5EOvWQp68RIcBOSg4YFAnSWecjOyMMJj7nDme+d1s/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auuj4b2Z5UwEYT2LZ59dX3VKiPg6YcM5PhsbcViPKv+V/e7mDkxF5p0uMSpvMSgQrSV8Sr0erf8oFAe7RBjmkStEXU6XUODTFy0Roij9s0DtmekOTf7mAbnw20+V7KOtIQv5+/v2GflV5Pzzxi9KhIpyH5GFpp3vaww3qTci2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4wHn2wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C7C4AF67;
	Tue, 11 Jun 2024 18:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718130600;
	bh=5EOvWQp68RIcBOSg4YFAnSWecjOyMMJj7nDme+d1s/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4wHn2wbBtiahaV8uAu5b30r04/E1lT2osRrSUQBMYaGr0T87eN7bAdoA3h2cA8yH
	 EpzxeJ+aRGrEzrH9vvXzpTsTEdaOFQk7lwUG9n/jmjSm+WHXy0mV1LaPNhnjslIcsi
	 dJOftjE0a3kmEAanBAk53b3DVsMnc4axdHAFl6CkAzoJ60coBQ75YkAXQEESseXAIU
	 E61FXNtkztNh/m97ZI43UX9iIiAMpngeZe7gXFXrZiWdEbkq6P+wqCRcEDVwRaAUvw
	 vRlLJQMqG9e4HWPtNF4/7SidJm7zmZGC79zFpMniPHMKO5R/9Epgx/SvIo0lqmSgbS
	 6Om99EnfMpTRg==
Date: Tue, 11 Jun 2024 11:29:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 5/5] fstests: add stress truncation + writeback test
Message-ID: <20240611182959.GZ52987@frogsfrogsfrogs>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-6-mcgrof@kernel.org>
 <20240611144503.GI52977@frogsfrogsfrogs>
 <ZmiUWCPcmtFSdrBG@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiUWCPcmtFSdrBG@bombadil.infradead.org>

On Tue, Jun 11, 2024 at 11:15:52AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 11, 2024 at 07:45:03AM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 10, 2024 at 08:02:02PM -0700, Luis Chamberlain wrote:
> > > +# Requires CONFIG_DEBUGFS and truncation knobs
> > > +_require_split_debugfs()
> > 
> > Er... I thought "split" referred to debugfs itself.
> > 
> > _require_split_huge_pages_knob?
> 
> Much better, thanks.
> 
> > > +# This aims at trying to reproduce a difficult to reproduce bug found with
> > > +# min order. The issue was root caused to an xarray bug when we split folios
> > > +# to another order other than 0. This functionality is used to support min
> > > +# order. The crash:
> > > +#
> > > +# https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> > 
> > You might want to paste the stacktrace in here directly, in case the
> > gist ever goes away.
> 
> Its not a simple crash trace, it is pretty enourmous considering I
> decoded it, and it has all locking candidates. Even including it after
> the "---" lines of the patch might make someone go: TLDR. Thoughts?

I'd paste it in, even if it's quite lengthy.  I don't even think it's all that
much if you remove some of the less useful bits of the unwind:

"Crash excerpt is as follows:

"BUG: kernel NULL pointer dereference, address: 0000000000000036
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 PID: 2190 Comm: kworker/u38:5 Not tainted 6.9.0-rc5+ #14
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:5)
RIP: 0010:filemap_get_folios_tag+0xa9/0x200
Call Trace:
 <TASK>
 writeback_iter+0x17d/0x310
 write_cache_pages+0x42/0xa0
 iomap_writepages+0x33/0x50
 xfs_vm_writepages+0x63/0x90 [xfs]
 do_writepages+0xcc/0x260
 __writeback_single_inode+0x3d/0x340
 writeback_sb_inodes+0x1ed/0x4b0
 __writeback_inodes_wb+0x4c/0xe0
 wb_writeback+0x267/0x2d0
 wb_workfn+0x2a4/0x440
 process_one_work+0x189/0x3b0
 worker_thread+0x273/0x390
 kthread+0xda/0x110
 ret_from_fork+0x2d/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>"

--D

> > > +if grep -q thp_split_page /proc/vmstat; then
> > > +	split_count_after=$(grep ^thp_split_page /proc/vmstat | head -1 | awk '{print $2}')
> > > +	split_count_failed_after=$(grep ^thp_split_page_failed /proc/vmstat | head -1 | awk '{print $2}')
> > 
> > I think this ought to be a separate function for cleanliness?
> > 
> > _proc_vmstat()
> > {
> > 	awk -v name="$1" '{if ($1 ~ name) {print($2)}}' /proc/vmstat
> > }
> 
> > Otherwise this test looks fine to me.
> 
> Thanks!
> 
>   Luis
> 

