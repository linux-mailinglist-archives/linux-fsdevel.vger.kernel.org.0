Return-Path: <linux-fsdevel+bounces-29063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837C097456C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480CE28A182
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B21ABEAD;
	Tue, 10 Sep 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqhNnRUl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D317A924;
	Tue, 10 Sep 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006312; cv=none; b=Q5an5SzM6PXDhoqElpSIR/9i93mgmNOG25UKhNqs4w8ogn7LPjJfhRG3MY556YIsP0f1ar7RK4QTpeWvBhS6ons1Hm6r5FOr5W/1nNba8ZC6L8I/4mrVaDxeirO5itnfFBCPAgNe1f4oFj+AdOMun1jkaVpGxt8F81zl5JMrC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006312; c=relaxed/simple;
	bh=vVpp7uHZT4xapYNNyP7BWdaAt7X4JVfow4RERTcPSLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRiNPD7BAx13oFiVhUuoQqbIZiwXcJHhX6cTkPLu84ma9ZrbBJi3rxHiMOzVzN+AjnAOAy/4TfvKp+8MMUg6slkBEzLzqrIRNIBjz4oJb2PIJSfweKwPEWjjLIhb7M/QBj4Nbv2E8yPclxu1spUDtWUQQIyTf3K9lqKm9VI3Ws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqhNnRUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A6CC4CEC3;
	Tue, 10 Sep 2024 22:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726006312;
	bh=vVpp7uHZT4xapYNNyP7BWdaAt7X4JVfow4RERTcPSLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqhNnRUl5HScrLvQ8lR0VtPDI1EFxIU1VThQ+7DDe4xRw1n9FR0b2JlmLa/Cz/x1I
	 6JcMTQgC/Dfwdx5voMaGOnJzI4WPL1nPmVyUbKTZ0Wj8DXgDUQaqFK65GUsQmmOa8p
	 AQVtqflZHPdy4AoZoUzxl6K1IqYWAP5MFUEtHO9iTfG4dNRVdHnwL7GHCKDVRb+BaM
	 +1fiGzTjXV9FJJ9AHGlfZYyseQXo4H5VCsUYzRh7ZjA4J7W9QAFHUmjMzX0baY41Ma
	 Zx9fgNy03MkfxK3hjom4xPQQ52Ul8hUorLh3X3ulNHSvo4ltoRc2sJaAECKG64U6p7
	 iPx5KaqabzAxQ==
Date: Tue, 10 Sep 2024 18:11:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuDEJukUYv3yVSQM@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
 <ZuB3l71L_Gu1Xsrn@kernel.org>
 <ZuCasKhlB4-eGyg0@kernel.org>
 <686b4118-0505-4ea5-a2bb-2b16acc33c51@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686b4118-0505-4ea5-a2bb-2b16acc33c51@oracle.com>

On Tue, Sep 10, 2024 at 04:31:23PM -0400, Anna Schumaker wrote:
> Hi Mike,
> 
> On 9/10/24 3:14 PM, Mike Snitzer wrote:
> > On Tue, Sep 10, 2024 at 12:45:11PM -0400, Mike Snitzer wrote:
> >> On Fri, Sep 06, 2024 at 04:34:18PM -0400, Mike Snitzer wrote:
> >>> On Fri, Sep 06, 2024 at 03:31:41PM -0400, Anna Schumaker wrote:
> >>>> Hi Mike,
> >>>>
> >>>> I've been running tests on localio this afternoon after finishing up going through v15 of the patches (I was most of the way through when you posted v16, so I haven't updated yet!). Cthon tests passed on all NFS versions, and xfstests passed on NFS v4.x. However, I saw this crash from xfstests with NFS v3:
> >>>>
> >>>> [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
> >>>> [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv: empty string added
> >>>> [ 1502.699514] Oops: general protection fault, probably for non-canonical address 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
> >>>> [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-g0c79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
> >>>> [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> >>>> [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
> > 
> > <snip>
> > 
> >>>>
> >>>> Please let me know if there are any other details you need about my setup to help debug this!
> >>>
> >>> Hmm, I haven't seen this issue, my runs of xfstests with LOCALIO
> >>> enabled look solid:
> >>> https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next&test=^fs.nfs.fstests.generic.633$
> >>>
> >>> And I know Chuck has been testing xfstests and more with the patches
> >>> applied but LOCALIO disabled in his kernel config.
> >>>
> >>> The stack seems to indicate nfsd is just handling a request (so it
> >>> isn't using LOCALIO, at least not for this op).
> >>>
> >>> Probably best if you do try v16.  v15 has issues v16 addressed.  If
> >>> you can reproduce with v16 please share your kernel .config and
> >>> xfstests config. 
> >>>
> >>> Note that I've only really tested my changes against v6.11-rc4.  But I
> >>> can rebase on v6.11-rc6 if you find v16 still fails for you.
> >>
> >> Hi Anna,
> >>
> >> Just checking back, how is LOCALIO for you at this point?  Anything
> >> you're continuing to see as an issue or need from me?
> > 
> > In case it helps, I did just rebase LOCALIO (v16 + 1 fix) ontop of
> > cel/nfsd-next (v6.11-rc6 based), and I've pushed the result here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> 
> I'm seeing the same hang on generic/525 with your latest branch.
> 
> Anna

Interesting, I just looked at ktest and it shows the regression point
to be this commit:
   nfs: implement client support for NFS_LOCALIO_PROGRAM

See:
https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next&test=^fs.nfs.fstests.generic.525$

I think 525 has been like this for a while, really not sure why I
ignored it... will dig deeper!

Thanks,
Mike

