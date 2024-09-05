Return-Path: <linux-fsdevel+bounces-28743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D696DBA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA19E28D095
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FCBC8C7;
	Thu,  5 Sep 2024 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJERgEi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234ACA64;
	Thu,  5 Sep 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546063; cv=none; b=qDt1TSVV0z7p61SzgcmjSfMwNs8Vx4SSuw5htvZcKTXq8bI5ae++BfXHzU6w5RjST5/F59nvMXEcWSlG1EVOkAWiHTped+F3ttVqEl0vQe+dh9L34qoA2QMm2on5eEs7C3EZJ4rWO1uy6w6Q0NoC51O/NUQdhNGkaCFyvazMkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546063; c=relaxed/simple;
	bh=Na1GNfhq1VkT2SlIbInYpjSqIASnAc/oc5DJoxzyCxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMt9zU9UxJ5wfbfnm5tWMFvUveG22Gylnxt3KPEaksl3hrimkCwoHHIoJ7GV2v3+ocUkE4Oix2xtNWs/zitWh7gbKhYG7sKCMi934m1iWfrcXXpslbF6sesMkamX+lnZeiwu8uB0z1UySPAxI8JynP8DV2/U1B5taUpg2P7j9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJERgEi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70EBC4CEC3;
	Thu,  5 Sep 2024 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546063;
	bh=Na1GNfhq1VkT2SlIbInYpjSqIASnAc/oc5DJoxzyCxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJERgEi9LeJR70JAP4N+aLs0yNMw/wfC6NoGwiDcly4gL8iCksfi+Y6cNbP+oNCDI
	 K1tdZ5pbaO8OsGefi1ymSM9O6Adt3rVOR5fB29vCSfAJsUmI5EbhakwJY7NrUhzAA8
	 lC+7jxwaJ6FUt5MIKBKdm3r8FI/5l9e3fln0qOaN2nd7qZ4kM73QDOureW+mBewtsD
	 JpmHLGobrKfpcI64FdoNcXYLQ1PIYVzQK4jivkXOIWBhBI4HobySUkYenN9X4tCAbg
	 A6fTMYIetsa5pN4GBQCoZGDFw/hwhTJHx3k5Z6ZMyi82pMdUpvAakeQ7t1ix/h6vzr
	 pNNElT/goYTQw==
Date: Thu, 5 Sep 2024 10:21:01 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Message-ID: <Ztm-TbSdXOkx3IHn@kernel.org>
References: <>
 <67405117-1C08-4CA9-B0CE-743DFC7BCE3F@oracle.com>
 <172540270112.4433.6741926579586461095@noble.neil.brown.name>
 <172542610641.4433.9213915589635956986@noble.neil.brown.name>
 <Zthk29iSYQs6J8NX@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zthk29iSYQs6J8NX@tissot.1015granger.net>

On Wed, Sep 04, 2024 at 09:47:07AM -0400, Chuck Lever wrote:
> On Wed, Sep 04, 2024 at 03:01:46PM +1000, NeilBrown wrote:
> > On Wed, 04 Sep 2024, NeilBrown wrote:
> > > 
> > > I agree that dropping and reclaiming a lock is an anti-pattern and in
> > > best avoided in general.  I cannot see a better alternative in this
> > > case.
> > 
> > It occurred to me what I should spell out the alternate that I DO see so
> > you have the option of disagreeing with my assessment that it isn't
> > "better".
> > 
> > We need RCU to call into nfsd, we need a per-cpu ref on the net (which
> > we can only get inside nfsd) and NOT RCU to call
> > nfsd_file_acquire_local().
> > 
> > The current code combines these (because they are only used together)
> > and so the need to drop rcu. 
> > 
> > I thought briefly that it could simply drop rcu and leave it dropped
> > (__releases(rcu)) but not only do I generally like that LESS than
> > dropping and reclaiming, I think it would be buggy.  While in the nfsd
> > module code we need to be holding either rcu or a ref on the server else
> > the code could disappear out from under the CPU.  So if we exit without
> > a ref on the server - which we do if nfsd_file_acquire_local() fails -
> > then we need to reclaim RCU *before* dropping the ref.  So the current
> > code is slightly buggy.
> > 
> > We could instead split the combined call into multiple nfs_to
> > interfaces.
> > 
> > So nfs_open_local_fh() in nfs_common/nfslocalio.c would be something
> > like:
> > 
> >  rcu_read_lock();
> >  net = READ_ONCE(uuid->net);
> >  if (!net || !nfs_to.get_net(net)) {
> >        rcu_read_unlock();
> >        return ERR_PTR(-ENXIO);
> >  }
> >  rcu_read_unlock();
> >  localio = nfs_to.nfsd_open_local_fh(....);
> >  if (IS_ERR(localio))
> >        nfs_to.put_net(net);
> >  return localio;
> > 
> > So we have 3 interfaces instead of 1, but no hidden unlock/lock.
> 
> Splitting up the function call occurred to me as well, but I didn't
> come up with a specific bit of surgery. Thanks for the suggestion.
> 
> At this point, my concern is that we will lose your cogent
> explanation of why the release/lock is done. Having it in email is
> great, but email is more ephemeral than actually putting it in the
> code.
> 
> 
> > As I said, I don't think this is a net win, but reasonable people might
> > disagree with me.
> 
> The "win" here is that it makes this code self-documenting and
> somewhat less likely to be broken down the road by changes in and
> around this area. Since I'm more forgetful these days I lean towards
> the more obvious kinds of coding solutions. ;-)
> 
> Mike, how do you feel about the 3-interface suggestion?

I dislike expanding from 1 indirect function call to 2 in rapid
succession (3 for the error path, not a problem, just being precise.
But I otherwise like it.. maybe.. heh.

FYI, I did run with the suggestion to make nfs_to a pointer that just
needs a simple assignment rather than memcpy to initialize.  So Neil's
above code becames:

        rcu_read_lock();
        net = rcu_dereference(uuid->net);
        if (!net || !nfs_to->nfsd_serv_try_get(net)) {
                rcu_read_unlock();
                return ERR_PTR(-ENXIO);
        }
        rcu_read_unlock();
        /* We have an implied reference to net thanks to nfsd_serv_try_get */
        localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
                                             cred, nfs_fh, fmode);
        if (IS_ERR(localio))
                nfs_to->nfsd_serv_put(net);
        return localio;

I do think it cleans the code up... full patch is here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=nfs-localio-for-next.v15-with-fixups&id=e85306941878a87070176702de687f2779436061

But I'm still on the fence.. someone help push me over!

Tangent, but in the related business of "what are next steps?":

I updated headers with various provided Reviewed-by:s and Acked-by:s,
fixed at least 1 commit header, fixed some sparse issues, various
fixes to nfs_to patch (removed EXPORT_SYMBOL_GPL, switched to using
pointer, updated nfs_to callers). Etc...

But if I fold those changes in I compromise the provided Reviewed-by
and Acked-by.. so I'm leaning toward posting a v16 that has
these incremental fixes/improvements, see the 3 topmost commits here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next.v15-with-fixups

Or if you can review the incremental patches I can fold them in and
preserve the various Reviewed-by and Acked-by...

You can also see incremental diff from .v15 to .v15-with-fixups with:
git remote update snitzer
git diff snitzer/nfs-localio-for-next.v15 snitzer/nfs-localio-for-next.v15-with-fixups

Either way, I should post a v16 right?  SO question is: should I fold
these incremental changes in to the original or keep them split out?

I'm good with whatever you guys think.  But whatever is decided: this
needs to be the handoff point to focused NFS client review and hopeful
staging for 6.12 inclusion, I've pivoted to working with Trond to
make certain he is good with everything.

Thanks,
Mike

