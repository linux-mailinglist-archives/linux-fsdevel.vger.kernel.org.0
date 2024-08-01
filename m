Return-Path: <linux-fsdevel+bounces-24832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DF945305
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 20:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F12856A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B5149C5E;
	Thu,  1 Aug 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaOYwW9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557C143883;
	Thu,  1 Aug 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538406; cv=none; b=CVp67a1uXZDxy8l2rLXvCv5m6m/Lj4NbMjo0x44NKf3/PC7GPzgps8N1F4kzH8TbivK6gN8CvCQ78qPSRXTp8x4ewFdKyuWObuTBoqMJOKMgVFnp5wMlZjEMecrbg+hn4k7JQj7wJGu9MAjrf1FtAcHeiei/h/XZgjzX4V5SlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538406; c=relaxed/simple;
	bh=8fSyU2sb8kmX3R6gndd/1GgRwRBUKnHGxw9g8uAGMbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIDcBiqPdu+eiwvsjLl7w1I1wgvy7J/N5pzaxvTnZNdZHXzSi6SzLJ3hZT7N4f/Rxxs7hxG4MZTy0J95XWcYASrgUHbEe167KGsDOrk+26zdgQMDmY2jEC+pq8hi/moIS7XU/s+GeySWWa6Nl0VBdBfalam86X+xDNW5tfZYUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaOYwW9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE6AC32786;
	Thu,  1 Aug 2024 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722538404;
	bh=8fSyU2sb8kmX3R6gndd/1GgRwRBUKnHGxw9g8uAGMbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaOYwW9BfCu9i44CDKEZGhyyXPNNch8oGDnGletL0Un/ouU/aRaMFsLFkmv3lEuCA
	 +7ja6mmwZph8X7iGE+xEYRD3mNq6ZdnIoJFT4jomwOyfbEBDmUzTmFTH0mXMMNip/R
	 +cC7yytW8K1ClqfzSE1o2mXpikLIp+I4oTE0sAjOwIlFrdSp79VYgVL/f2ZMw/6xmz
	 ILYvtEswuHcHI/Jn94fctSTX7WysarchHqvcFLklSEBcoGtNXCh6wBvvk6VL/1kd1y
	 km1sHZPziIGOyZai3aJNrYlTlJmtXlDnhKVDU3TwqIXepvzZYzfLSAIko0Ar2py1d8
	 sdzQc78+tt0PQ==
Date: Thu, 1 Aug 2024 11:53:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>
Cc: Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/24] netfs: Speed up buffered reading
Message-ID: <20240801185321.GA2534812@thelio-3990X>
References: <20240729162002.3436763-1-dhowells@redhat.com>
 <20240729162002.3436763-19-dhowells@redhat.com>
 <20240731190742.GS1967603@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731190742.GS1967603@kernel.org>

On Wed, Jul 31, 2024 at 08:07:42PM +0100, Simon Horman wrote:
> On Mon, Jul 29, 2024 at 05:19:47PM +0100, David Howells wrote:
> 
> ...
> 
> > diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> 
> ...
> 
> > +/*
> > + * Perform a read to the pagecache from a series of sources of different types,
> > + * slicing up the region to be read according to available cache blocks and
> > + * network rsize.
> > + */
> > +static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
> > +{
> > +	struct netfs_inode *ictx = netfs_inode(rreq->inode);
> > +	unsigned long long start = rreq->start;
> > +	ssize_t size = rreq->len;
> > +	int ret = 0;
> > +
> > +	atomic_inc(&rreq->nr_outstanding);
> > +
> > +	do {
> > +		struct netfs_io_subrequest *subreq;
> > +		enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
> > +		ssize_t slice;
> > +
> > +		subreq = netfs_alloc_subrequest(rreq);
> > +		if (!subreq) {
> > +			ret = -ENOMEM;
> > +			break;
> > +		}
> > +
> > +		subreq->start	= start;
> > +		subreq->len	= size;
> > +
> > +		atomic_inc(&rreq->nr_outstanding);
> > +		spin_lock_bh(&rreq->lock);
> > +		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> > +		subreq->prev_donated = rreq->prev_donated;
> > +		rreq->prev_donated = 0;
> > +		trace_netfs_sreq(subreq, netfs_sreq_trace_added);
> > +		spin_unlock_bh(&rreq->lock);
> > +
> > +		source = netfs_cache_prepare_read(rreq, subreq, rreq->i_size);
> > +		subreq->source = source;
> > +		if (source == NETFS_DOWNLOAD_FROM_SERVER) {
> > +			unsigned long long zp = umin(ictx->zero_point, rreq->i_size);
> > +			size_t len = subreq->len;
> > +
> > +			if (subreq->start >= zp) {
> > +				subreq->source = source = NETFS_FILL_WITH_ZEROES;
> > +				goto fill_with_zeroes;
> > +			}
> > +
> > +			if (len > zp - subreq->start)
> > +				len = zp - subreq->start;
> > +			if (len == 0) {
> > +				pr_err("ZERO-LEN READ: R=%08x[%x] l=%zx/%zx s=%llx z=%llx i=%llx",
> > +				       rreq->debug_id, subreq->debug_index,
> > +				       subreq->len, size,
> > +				       subreq->start, ictx->zero_point, rreq->i_size);
> > +				break;
> > +			}
> > +			subreq->len = len;
> > +
> > +			netfs_stat(&netfs_n_rh_download);
> > +			if (rreq->netfs_ops->prepare_read) {
> > +				ret = rreq->netfs_ops->prepare_read(subreq);
> > +				if (ret < 0) {
> > +					atomic_dec(&rreq->nr_outstanding);
> > +					netfs_put_subrequest(subreq, false,
> > +							     netfs_sreq_trace_put_cancel);
> > +					break;
> > +				}
> > +				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
> > +			}
> > +
> > +			slice = netfs_prepare_read_iterator(subreq);
> > +			if (slice < 0) {
> > +				atomic_dec(&rreq->nr_outstanding);
> > +				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
> > +				ret = slice;
> > +				break;
> > +			}
> > +
> > +			rreq->netfs_ops->issue_read(subreq);
> > +			goto done;
> > +		}
> > +
> > +	fill_with_zeroes:
> > +		if (source == NETFS_FILL_WITH_ZEROES) {
> > +			subreq->source = NETFS_FILL_WITH_ZEROES;
> > +			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> > +			netfs_stat(&netfs_n_rh_zero);
> > +			slice = netfs_prepare_read_iterator(subreq);
> > +			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> > +			netfs_read_subreq_terminated(subreq, 0, false);
> > +			goto done;
> > +		}
> > +
> > +		if (source == NETFS_READ_FROM_CACHE) {
> > +			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
> > +			slice = netfs_prepare_read_iterator(subreq);
> > +			netfs_read_cache_to_pagecache(rreq, subreq);
> > +			goto done;
> > +		}
> > +
> > +		if (source == NETFS_INVALID_READ)
> > +			break;
> 
> Hi David,
> 
> I feel a sense of deja vu here. So apologies if this was already
> discussed in the past.
> 
> If the code ever reaches this line, then slice will be used
> uninitialised below.
> 
> Flagged by W=1 allmodconfig builds on x86_64 with Clang 18.1.8.

which now breaks the build in next-20240801:

  fs/netfs/buffered_read.c:304:7: error: variable 'slice' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
    304 |                 if (source == NETFS_INVALID_READ)
        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/netfs/buffered_read.c:308:11: note: uninitialized use occurs here
    308 |                 size -= slice;
        |                         ^~~~~
  fs/netfs/buffered_read.c:304:3: note: remove the 'if' if its condition is always true
    304 |                 if (source == NETFS_INVALID_READ)
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    305 |                         break;
  fs/netfs/buffered_read.c:221:16: note: initialize the variable 'slice' to silence this warning
    221 |                 ssize_t slice;
        |                              ^
        |                               = 0
  1 error generated.

If source has to be one of these values, perhaps switching to a switch
statement and having a default with a WARN_ON() or something would
convey that to the compiler?

Cheers,
Nathan

