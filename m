Return-Path: <linux-fsdevel+bounces-29312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD85A977FD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3401F22443
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022D1D932C;
	Fri, 13 Sep 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKUQuLQe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4C1C2BF;
	Fri, 13 Sep 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230424; cv=none; b=nqIY7wJIWY2mqzfk5dhe9EfWiBc5QGuoyBgIaEcckzWMNBNWf3DYuiDgeknHB2Zxj3xcFLwui9r1LGAydb+94ZqaKRd6PSBVBWmVyMNK/d4Dk1888Mv22/xBgtX8MHI3qtoTpsJJrR5gjZgMWI4iA4Z2wY11Qzd1MFEssMrhG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230424; c=relaxed/simple;
	bh=xs4HuJ2pJ9TnbonjCUcHSSnLUWOFSyeiPzKB0Miknw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU78WpdAsafE1dtcMUjaNSGdcSZ8dxVi41ME7YJj8OUNbnf80SqjsJgf04UpiP/WUGGWcUsgQr7gJ523p+9a7fAONKJkQFbS5HVOV4DC70YuSBgcm9WKFpCRKyWvtW5hFyHGW/0vYtW8gRV5YbTERaOOZOF1AnTneAmFyOVqBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKUQuLQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5601C4CEC0;
	Fri, 13 Sep 2024 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726230424;
	bh=xs4HuJ2pJ9TnbonjCUcHSSnLUWOFSyeiPzKB0Miknw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKUQuLQeXSbrJ1BAXy9tX7hdY0fykofmjRNQt5t+bNCN1XvoEy9wlLhjKiU6bWBLg
	 xt7Stk3qqEqCHV9bzHsUNLmkthkZCdLsXmpomFveM2xRyfEMdNnxOvCDwQO3jEdc8W
	 DCfGsmWItVg/pors06wNTrygbIOZ/tQDbsmfYwSMaV4XlsQNpEMOxL/Kv5goysfQyz
	 ytZMZ5zsptVp12argZaVqW1411du3Tdv7AdLwiNUxLuMJjTXZKmHM2TUh+ocPItiaV
	 ODBxklT8Z1Pzumi31gVwvHKqstojR4LYu0T79TgbtijkqCqtwVcZTQ42xG6pr4X7hW
	 EZ6uH/7lkSpeg==
Date: Fri, 13 Sep 2024 08:27:02 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Anna Schumaker <anna.schumaker@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuQvlsAWRW9CvglZ@kernel.org>
References: <A8A5876A-4C8A-4630-AED3-7AED4FF121AB@oracle.com>
 <172618388461.17050.3025025482727199332@noble.neil.brown.name>
 <2A6AA1A5-9498-4783-A23C-C25500AB6D88@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2A6AA1A5-9498-4783-A23C-C25500AB6D88@oracle.com>

On Thu, Sep 12, 2024 at 11:42:28PM +0000, Chuck Lever III wrote:
> 
> 
> > On Sep 12, 2024, at 7:31 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Thu, 12 Sep 2024, Chuck Lever III wrote:
> >> 
> >> 
> >>> On Sep 10, 2024, at 8:43 PM, NeilBrown <neilb@suse.de> wrote:
> >>> 
> >>> On Sat, 07 Sep 2024, Anna Schumaker wrote:
> >>>> Hi Mike,
> >>>> 
> >>>> On 8/31/24 6:37 PM, Mike Snitzer wrote:
> >>>>> Hi,
> >>>>> 
> >>>>> Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> >>>>> what I hope the final LOCALIO patchset this weekend: its my birthday
> >>>>> this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> >>>>> inclusion sometime next week: best b-day gift in a while! ;)
> >>>>> 
> >>>>> Anyway, I've been busy incorporating all the review feedback from v14
> >>>>> _and_ working closely with NeilBrown to address some lingering net-ns
> >>>>> refcounting and nfsd modules refcounting issues, and more (Chnagelog
> >>>>> below):
> >>>>> 
> >>>> 
> >>>> I've been running tests on localio this afternoon after finishing up going through v15 of the patches (I was most of the way through when you posted v16, so I haven't updated yet!). Cthon tests passed on all NFS versions, and xfstests passed on NFS v4.x. However, I saw this crash from xfstests with NFS v3:
> >>>> 
> >>>> [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
> >>>> [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv: empty string added
> >>>> [ 1502.699514] Oops: general protection fault, probably for non-canonical address 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
> >>>> [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-g0c79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
> >>>> [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> >>>> [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
> >>>> [ 1502.704474] Code: 8d bb 30 02 00 00 bb 01 00 00 00 eb 12 49 8d 46 10 48 8b 08 ff c3 48 85 c9 0f 84 9c 00 00 00 49 89 ce 4c 8d 61 c8 41 8b 45 00 <3b> 41 c8 75 1f 41 8b 45 04 41 3b 46 cc 74 15 8b 15 2c c6 b8 f2 be
> >>>> [ 1502.706931] RSP: 0018:ffffc27ac0a2fd18 EFLAGS: 00010206
> >>>> [ 1502.707547] RAX: 00000000b95691f7 RBX: 0000000000000002 RCX: 6c616e69665f6178
> >>> 
> >>> This doesn't look like code anywhere near the changes that LOCALIO
> >>> makes.
> >>> 
> >>> I dug around and the faulting instruction is 
> >>>  cmp    -0x38(%rcx),%eax 
> >>> 
> >>> The -0x38 points to nfsd_cache_insert().  -0x38 is the index back
> >>> from the rbnode pointer to c_key.k_xid.  So the rbtree is corrupt.
> >>> %rcx is 6c616e69665f6178 which is "xa_final".  So that rbtree node has
> >>> been over-written or freed and re-used.
> >>> 
> >>> It looks like
> >>> 
> >>> Commit add1511c3816 ("NFSD: Streamline the rare "found" case")
> >>> 
> >>> moved a call to nfsd_reply_cache_free_locked() that was inside a region
> >>> locked with ->cache_lock out of that region.
> >> 
> >> My reading of the current code is that cache_lock is held
> >> during the nfsd_reply_cache_free_locked() call.
> >> 
> >> add1511c3816 simply moved the call site from before a "goto"
> >> to after the label it branches to. What am I missing?
> > 
> > Yes, I let myself get confused by the gotos.  As you say that patch
> > didn't move the call out of the locked region.  Sorry.
> > 
> > I can't see anything wrong with the locking or tree management in
> > nfscache.c, yet this Oops looks a lot like a corrupted rbtree.
> > It *could* be something external stomping on the memory but I think
> > that is unlikely.  I'd rather have a more direct explanation....  Not
> > today though it seems.
> 
> My spidey sense (well, OK, my PTSD from when I've worked on
> the DRC code previously) is that these kind of memory overwrites
> can happen when the XDR receive buffer is unexpectedly short,
> and the DRC code ends up reading off the end of it. That code
> makes some stunning assumptions that might not hold true in the
> new LOCALIO paths.

I really don't think LOCALIO is the reason for whatever Anna saw.  I
haven't ever seen anything like it during all my time with the code.

> Anna/Mike, you might try enabling KASAN to see if it will catch
> which instructions are doing the damage.

ktest runs xfstests with KASAN enabled, not seen any issues yet.

My most pressing work related to LOCALIO is fixing xfstests
generic/525.  It is proving to be quite the mystery (for some reason
the final eof page isn't getting added the the pagcache and subsequent
pread is failing to find the page in either NFS or XFS
pagecache.. _only_ for this eof page).. inching closer but I'm going
on day 3 now.

Thanks,
Mike

