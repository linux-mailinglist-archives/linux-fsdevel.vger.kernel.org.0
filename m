Return-Path: <linux-fsdevel+bounces-66757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9653C2BABC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 437234E7273
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1530E0EF;
	Mon,  3 Nov 2025 12:21:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073230B53F;
	Mon,  3 Nov 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172479; cv=none; b=cHKvq5p7/8mb4DtjEQw8MiU+pXLkCRb/hxH4kpGVLlGB9kElJk5kCg/Ou3WamZzE3J1iacn+Da8ODU39PvafK+m28/ketvNc+PgKttQfdiqx20U325gaN8E8icUc+8igU/HR1lAkOj7Ivfhylb7s5BMBlpyhf6PTiJ7/okBnaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172479; c=relaxed/simple;
	bh=lrCX/7DPoLpPmdw07gFf4KbwMf9WN8il1bgP2jjVFso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EccoP2CoUvgeRdN8W3j4rBCUKSbeyFUeeVRHhoT5O+5Yj6ROyzA5ZiwAQHGPJbiP1v7aT+nSpXnYNdpXrVHzZIRtZ6+bGGpzBuk4HGWiqVZzkUau8ANEKx8wGsHIBSNDZLGijCgi4sjCW2bnod3UUiNtwFuZfJzQ93gEQ4VAp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1D04227AAA; Mon,  3 Nov 2025 13:21:11 +0100 (CET)
Date: Mon, 3 Nov 2025 13:21:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251103122111.GA17600@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <aQNJ4iQ8vOiBQEW2@dread.disaster.area> <20251030143324.GA31550@lst.de> <aQPyVtkvTg4W1nyz@dread.disaster.area> <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 12:14:06PM +0100, Jan Kara wrote:
> > Yes, it's pretty clear that the result in non-deterministic in what you
> > get.  But that result still does not result in corruption, because
> > there is a clear boundary ( either the sector size, or for NVMe
> > optionally even a larger bodunary) that designates the atomicy boundary.
> 
> Well, is that boundary really guaranteed? I mean if you modify the buffer
> under IO couldn't it happen that the DMA sees part of the sector new and
> part of the sector old? I agree the window is small but I think the real
> guarantee is architecture dependent and likely cacheline granularity or
> something like that.

If you actually modify it: yes.  But I think Keith' argument was just
about regular racing reads vs writes.

> > pretty clearly not an application bug.  It's also pretty clear that
> > at least some applications (qemu and other VMs) have been doings this
> > for 20+ years.
> 
> Well, I'm mostly of the opinion that modifying IO buffers in flight is an
> application bug (as much as most current storage stacks tolerate it) but on
> the other hand returning IO errors later or even corrupting RAID5 on resync
> is, in my opinion, not a sane error handling on the kernel side either so I
> think we need to do better.

Yes.  Also if you look at the man page which is about official as it gets
for the semantics you can't find anything requiring the buffers to be
stable (but all kinds of other odd rants).

> I also think the performance cost of the unconditional bounce buffering is
> so heavy that it's just a polite way of pushing the app to do proper IO
> buffer synchronization itself (assuming it cares about IO performance but
> given it bothered with direct IO it presumably does). 
>
> So the question is how to get out of this mess with the least disruption
> possible which IMO also means providing easy way for well-behaved apps to
> avoid the overhead.

Remember the cases where this matters is checksumming and parity, where
we touch all the cache lines anyway and consume the DRAM bandwidth,
although bounce buffering upgrades this from pure reads to also writes.
So the overhead is heavy, but if we handle it the right way, that is
doing the checksum/parity calculation while the cache line is still hot
it should not be prohibitive.  And getting this right in the direct
I/O code means that the low-level code could stop bounce buffering
for buffered I/O, providing a major speedup there.

I've been thinking a bit more on how to better get the copy close to the
checksumming at least for PI, and to avoid the extra copies for RAID5
buffered I/O. M maybe a better way is to mark a bio as trusted/untrusted
so that the checksumming/raid code can bounce buffer it, and I start to
like that idea.  A complication is that PI could relax that requirement
if we support PI passthrough from userspace (currently only for block
device, but I plan to add file system support), where the device checks
it, but we can't do that for parity RAID.


