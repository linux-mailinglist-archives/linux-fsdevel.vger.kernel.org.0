Return-Path: <linux-fsdevel+bounces-28900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A097030B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454CA1F224F2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301915FA72;
	Sat,  7 Sep 2024 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekRciZr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63521A93D;
	Sat,  7 Sep 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724324; cv=none; b=e5BZjaABtq+J1DuC69p50z5kktuFMex6mmkuyrxOC/CMPANHDG8w8NpjDAgf9zt/qX2dLfrUllcejTDRxEQd9JFJbAIRLXgwOKAeQTbW+BxtOT+e7lR20SlucbMrdqaHoRQ4p7wGm3iybJqrouHKzyiXqpBI1Hy1tXvlIk1MCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724324; c=relaxed/simple;
	bh=smkRxt5hdjY4bCFqIyeboIgwO0HKMJqQXLXBaHMaMs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnSNOnh9hInydF0dHDJ3LgoWfeq/K6Om3RoJ1TDk6gHtxUYM3JDV0OqCltNQf03dcLOtBZ2wIvewcMBBfVMhB3KP5vGUTF7pXQR/bkHWmnI/YrL/UTcyZ95Dx0obv3vEggCAupgNXuVtyxOOZkYZjcZSEiKdvwea4UuXUnCGkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekRciZr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDCCC4CEC4;
	Sat,  7 Sep 2024 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725724324;
	bh=smkRxt5hdjY4bCFqIyeboIgwO0HKMJqQXLXBaHMaMs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekRciZr5Gh9sD5WCTrTd4Dis6k4/mskj0JrHHCEbAqhcOGgqEhY7QBtNiaKM1AnGc
	 erjwDXw9vK2ZMLI7Ow0JNidmjdfbQlW3aqwVrq9anmRDk8l6R8DX8c/8z6ixm35cJX
	 1OIJKrOeq4UfumaFYY856RyS4iW/9+eofPIHGQDmlCvyIVUtZBLJE0ZjcbPHjh5ktH
	 8Bw8Vv/W0FmB7TGbgBFq/5Vym85cr/F58V9anWhgaRMcPvrZXoAip5AhDWy5gg92bt
	 r5izTumtbkXuRwGvQwTM/FZwIuRkz9gAhpZwK4pLHKhOEIWkLaiG8m0TDKmQFHFlGU
	 Ho7Y51DedpC+A==
Date: Sat, 7 Sep 2024 11:52:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <Ztx2o7jCnbeVm5f7@kernel.org>
References: <>
 <ZttE4DKrqqVa0ACn@kernel.org>
 <172565980778.4433.7347554942573335142@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172565980778.4433.7347554942573335142@noble.neil.brown.name>

On Sat, Sep 07, 2024 at 07:56:47AM +1000, NeilBrown wrote:
> On Sat, 07 Sep 2024, Mike Snitzer wrote:
> 
> > > But I'd just like to point out that something like the below patch
> > > wouldn't be needed if we kept my "heavy" approach (nfs reference on
> > > nfsd modules via nfs_common using symbol_request):
> > > https://marc.info/?l=linux-nfs&m=172499445027800&w=2
> > > (that patch has stuff I since cleaned up, e.g. removed typedefs and
> > > EXPORT_SYMBOL_GPLs..)
> > > 
> > > I knew we were going to pay for being too cute with how nfs took its
> > > reference on nfsd.
> > > 
> > > So here we are, needing fiddly incremental fixes like this to close a
> > > really-small-yet-will-be-deadly race:
> > 
> > <snip required delicate rcu re-locking requirements patch>
> > 
> > I prefer this incremental re-implementation of my symbol_request patch
> > that eliminates all concerns about the validity of 'nfs_to' calls:
> 
> We could achieve the same effect without using symbol_request() (which
> hardly anyone uses) if we did a __module_get (or try_module_get) at the
> same place you are calling symbol_request(), and module_put() where you
> do symbol_put().
> 
> This would mean that once NFS LOCALIO had detected a path to the local
> server, it would hold the nfsd module until the nfs server were shutdown
> and the nfs client noticed.  So you wouldn't be able to unmount the nfsd
> module immediately after stopping all nfsd servers.

s/unmount the nfsd module/remove the nfsd module/

Right, the nfsd module wouldn't be able to be unloaded if LOCALIO
client is still active (on host or within some container) with a mount
from an export the now shutdown server hosted.

With LOCALIO the client has extended the footprint of its kernel code
to include portions of the nfsd module (indirectly via nfs_common).

That said, we can preserve the fine-grained rcu-based locking dances
that I reinforced with the first patch (call it "option 1") I shared
in this sub-thread ;)

> Maybe that doesn't matter.  I think it is important to be able to
> completely shut down the NFS server at any time.  I think it is
> important to be able to completely shutdown a network namespace at any
> time.  I am less concerned about being able to rmmod the nfsd module
> after all obvious users have been disabled.

Yes, and even the last case: if all obvious users have been disabled
and unmounted then LOCALIO nfs client would have no cause to be
holding a reference for nfsd.

> So if others think that the improvements in code maintainability are
> worth the loss of being able to rmmod nfsd without (potentially) having
> to unmount all NFS filesystems, then I won't argue against it.  But I
> really would want it to be get/put of the module, not of some symbol.

I can do that.
 
> .... BTW you probably wanted to use symbol_get(), not symbol_request(). 
> The latter tries to load the module if it isn't already loaded.  Using
> symbol_get() does have the benefit that you don't need any locking dance
> to prevent the module unloading while we get the ref.  So if we really
> want to go for less tricky locking that might be a justification - but
> you don't need much locking for try_module_get()...

Yes that was the entire reason I did it this way (call it "option 2",
nicely avoids the bouncing of the rcu locking while putting nfsd_serv
ref in nfs_open_local_fh's error path).

Will look at switching to try_module_get().

Whichever way we go with fixing nfs_open_local_fh's narrow race with
putting the nfsd_serv ref, thankfully this is a pretty minor point
that we can quickly fix once Anna and Trond are comfortable with
LOCALIO being merged.

option 2's coarser nfs reference for nfsd via try_module_get would
reduce think-time if/when we make LOCALIO changes in future.  But I'd
be fine with either fix.

Thanks,
Mike

