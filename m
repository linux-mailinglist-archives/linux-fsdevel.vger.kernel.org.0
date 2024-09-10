Return-Path: <linux-fsdevel+bounces-29051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B776974344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 21:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A861F26A30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD201A727D;
	Tue, 10 Sep 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr7aCOy0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896B1A38F4;
	Tue, 10 Sep 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995698; cv=none; b=RLVQ+AR5FHTwiSuoxVxExUidikVEV34Xobb4VAQO8IWy06Cbf7DQo/nAzmHJSR1+raPqU+V0uNEYc6Z40ulwi4qrQJFZ0H4ZHzpe+CbsRsjijlIgY621okWikt7ZMoSIXKCZeT1QQrDeFJqQZW60NS2UbKkUJ+SsvwV7tvgv0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995698; c=relaxed/simple;
	bh=Idc2Ar5vVZRGRq/j2AlTG7KVMzvB1NjvNgOUDnyw80Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL/E7x3k5hw5lJKCGOVUPpKyT9Uyn9IV14JjUgx2K+iOHn2oA7qLjFaITcWw3kfR+oD2UW9YqS4XdwjEUnG+M2KAdcM5RJqIOCDgRCvcq4HQvXdLD6g7c6zF1v1vVqf113AfNgSL4lc5A2D2cEi6yp+SVZsB98XSCnRwqStAC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr7aCOy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724C0C4CEC3;
	Tue, 10 Sep 2024 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995697;
	bh=Idc2Ar5vVZRGRq/j2AlTG7KVMzvB1NjvNgOUDnyw80Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kr7aCOy0JAC9pMEEuuBAg/HY8l8P3cbMFM6RxSmIcLsZvbt5GBS3eHfr3PFRfIcMq
	 F/ZGNbPDfe0/mHAq+n1TN+4HKWWl06d86I002FgWdb1ZVstZlFnTEYHjYSCes67oB4
	 DA0WVz7njhQ1ktrx1rygC/45F8Y9M7rTav4zfy+l79P9jOQePTw6L0kNmapEOCbP/E
	 B3q52auHKQbBU+cqAGtQOWjPM2jRGRDWVmRX4Ta8ACY487z0Ay3hZnSnZCqCtY04xB
	 rMsN8/chuoRBqwLQTAh6qzOKt9b2VBYN4PYJ40vds6JgZR4Qu1oUENWmB8NCNZTmBH
	 3qSK6qDU+UM6A==
Date: Tue, 10 Sep 2024 15:14:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuCasKhlB4-eGyg0@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
 <ZuB3l71L_Gu1Xsrn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuB3l71L_Gu1Xsrn@kernel.org>

On Tue, Sep 10, 2024 at 12:45:11PM -0400, Mike Snitzer wrote:
> On Fri, Sep 06, 2024 at 04:34:18PM -0400, Mike Snitzer wrote:
> > On Fri, Sep 06, 2024 at 03:31:41PM -0400, Anna Schumaker wrote:
> > > Hi Mike,
> > > 
> > > I've been running tests on localio this afternoon after finishing up going through v15 of the patches (I was most of the way through when you posted v16, so I haven't updated yet!). Cthon tests passed on all NFS versions, and xfstests passed on NFS v4.x. However, I saw this crash from xfstests with NFS v3:
> > > 
> > > [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
> > > [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv: empty string added
> > > [ 1502.699514] Oops: general protection fault, probably for non-canonical address 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
> > > [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-g0c79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
> > > [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> > > [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]

<snip>

> > > 
> > > Please let me know if there are any other details you need about my setup to help debug this!
> > 
> > Hmm, I haven't seen this issue, my runs of xfstests with LOCALIO
> > enabled look solid:
> > https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next&test=^fs.nfs.fstests.generic.633$
> > 
> > And I know Chuck has been testing xfstests and more with the patches
> > applied but LOCALIO disabled in his kernel config.
> > 
> > The stack seems to indicate nfsd is just handling a request (so it
> > isn't using LOCALIO, at least not for this op).
> > 
> > Probably best if you do try v16.  v15 has issues v16 addressed.  If
> > you can reproduce with v16 please share your kernel .config and
> > xfstests config. 
> > 
> > Note that I've only really tested my changes against v6.11-rc4.  But I
> > can rebase on v6.11-rc6 if you find v16 still fails for you.
> 
> Hi Anna,
> 
> Just checking back, how is LOCALIO for you at this point?  Anything
> you're continuing to see as an issue or need from me?

In case it helps, I did just rebase LOCALIO (v16 + 1 fix) ontop of
cel/nfsd-next (v6.11-rc6 based), and I've pushed the result here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

ktest is running xfstests against it (LOCALIO enabled and in use):
https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next

And Chuck's kdevops testing should test it tomorrow morning.

