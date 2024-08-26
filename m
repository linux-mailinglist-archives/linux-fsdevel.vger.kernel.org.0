Return-Path: <linux-fsdevel+bounces-27228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915695FA48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E9D1F21A89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531031990DB;
	Mon, 26 Aug 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRL2t5PV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB64199E9E;
	Mon, 26 Aug 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702585; cv=none; b=uaqfyVJbEiUY2QdAwqxu+tVrv8AVlM8KwhDuAVQ94S1QS2RhSjCPr/oM4MYvW98BnARB7cgj4CuxZrcaA8W0T5ym03AMV5PBbHU9YYyezDl4Co21EUq2FphvOeem1ps9IeIddgZsNma3sb9gYPf3nZMadccfMo6DHlWfkYvL870=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702585; c=relaxed/simple;
	bh=NoPy+nbGyqCPtTKiGxyENba+IyOrf06MnqP6QYxHy1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiG4fo/ZXOJGGMb1b8V2fIL4xvZ99gmXsBjkRVbjPGFpIrecqLLrJj6iCuNRjV2meStPDcvoMw2TyLJ3kzf1y1n/Vc6ZOWdeLaQFz1sWzsypdQJsZmaBi3Ary77oNXLkAAesFufZjMv72xfoB7iOPbEH1IbFq7cnfoyHlYY/cJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRL2t5PV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB03C4DDF3;
	Mon, 26 Aug 2024 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702585;
	bh=NoPy+nbGyqCPtTKiGxyENba+IyOrf06MnqP6QYxHy1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRL2t5PVvNQXYSB4naqq5QoK95m6VIgVYpuopW7xnUNVQdfNjDzwo0ISRHqhepF6O
	 RBq2hR/ERq7j6tebTp8mPZmU/so4hJbq5XpQXWq8kRaSUKnxwz0mhPLK8tXASr0nyq
	 RoKhFyfwoyCl1nCBVk0L0mtzDFDv+qfTYujqpgzTIcXqoE3/avjqw6RGJvLNwwxiK0
	 Ey2/LqKa78HzvtM8G5QyVCCNe6L/ToEdmN6QuP8mqUCx0Pv5sW5hzLmgC5vbxngaDv
	 BcD4728lvAsxn7tCZrL5Kg3lGXwadfzZWgT+phl4iwM0be76LLAlCU10dQE4VEAwSq
	 R70PR0aLyvzVQ==
Date: Mon, 26 Aug 2024 16:03:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 10/19] nfsd: add localio support
Message-ID: <Zszfd9FSg3NWohN0@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-11-snitzer@kernel.org>
 <172463360544.6062.2165398603066803638@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172463360544.6062.2165398603066803638@noble.neil.brown.name>

On Mon, Aug 26, 2024 at 10:53:25AM +1000, NeilBrown wrote:
> On Sat, 24 Aug 2024, Mike Snitzer wrote:
> > +
> > +	/* Save client creds before calling nfsd_file_acquire_local which calls nfsd_setuser */
> > +	save_cred = get_current_cred();
> 
> I don't think this belongs here.  I would rather than
> nfsd_file_acquire_local() saved and restored the cred so it could be
> called without concern for internal implementation details.

OK, will fix.

> > +
> > +	/* nfs_fh -> svc_fh */
> > +	fh_init(&fh, NFS4_FHSIZE);
> > +	fh.fh_handle.fh_size = nfs_fh->size;
> > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > +
> > +	if (fmode & FMODE_READ)
> > +		mayflags |= NFSD_MAY_READ;
> > +	if (fmode & FMODE_WRITE)
> > +		mayflags |= NFSD_MAY_WRITE;
> > +
> > +	rpcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> > +
> > +	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, rpc_clnt->cl_vers,
> > +					cl_nfssvc_dom, &fh, mayflags, pnf);
> > +	if (beres) {
> > +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> > +		goto out_fh_put;
> > +	}
> > +out_fh_put:
> > +	fh_put(&fh);
> > +	if (rq_cred.cr_group_info)
> > +		put_group_info(rq_cred.cr_group_info);
> > +	revert_creds(save_cred);
> > +	nfsd_serv_put(nn);
> 
> I think this is too early to be calling nfsd_serv_put().
> I think it should be called when the IO completes - when 
> nfs_to.nfsd_file_put() is called.
> 
> nfs_to.nfsd_open_local_fh() and nfs_to.nfsd_file_get() should each get a ref to the
> server.
> nfsd_to.nfsd_file_put() should drop the ref.
> 
> Note that nfs_do.nfsd_file_get() would not exactly be nfsd_file_get.  So
> maybe a different name would suit.

Yes, you're right.  I'll get it fixed.

Thanks!

