Return-Path: <linux-fsdevel+bounces-26109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48B9547A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17C41C20D85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 11:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C5B1A76BC;
	Fri, 16 Aug 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYeXurtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E619A281;
	Fri, 16 Aug 2024 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806750; cv=none; b=GvlPNun1faoITaiVgAV3GXu+qSOcLzwK46P9vOBoHxM3cVw036i6nSrHqYC6n0nYCCjH0c3eJg7zclAoPzOAr69WjFzerylPkXexvabb+GRMJPzSHK6VhMD4lGFq0tQDS5shh5BARbzAROt9mvX/MURW73/QO+flat4yKXZxiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806750; c=relaxed/simple;
	bh=Xvhko6m4gXDcrQOr/bnImNG8IdOv4SrzCD327herT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1/8SRPev3HaBf+E4b/XdlUxTcBL6QS7oS/ZCMzeKiG+r0G6wGCWMCLJHL+/9cyTLckmGuhx51HwfL1HyAfQfDYZ9eDiq2SArge6dDMe6ixzQInXE2vpj+fLCxtiCLh77y3hOuI87HTsm/LIsZuaxYYthZUBBgtVN0bPLCavjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYeXurtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCC8C32782;
	Fri, 16 Aug 2024 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806749;
	bh=Xvhko6m4gXDcrQOr/bnImNG8IdOv4SrzCD327herT1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYeXurtmdnv5fR0Lvxwg11Rmuc4ghH5uPedjp9RUF9ZTVRnFe2KEe0exw3cCImVFK
	 rCaAS7BmZxAY/8WKFqSPpuApwA/YreEZ9JZ14QNkvArFFGle3hRED2RvbCpLyCba2l
	 rIPVVL5acPzqM+YeW9LejtpG8c61dmocnDYvshJQKqGbPQJB2fbGcmY9H6N30CodvY
	 inuJJ0QRj7hpszFcgk6KmUmw7RkjTNRCuLb4pQX2F0ynh6meOkJZNOwdlryD6Dy8zV
	 g7Vy8wfyyWx8LeA3HgxdqtkuHQaZe/I9xJVOX78DNQ2ZR0Dft1NVeuF8t5cTsweIxv
	 AbnNlysFgTzuQ==
Date: Fri, 16 Aug 2024 12:12:22 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <20240816111222.GT632411@kernel.org>
References: <20240814203850.2240469-1-dhowells@redhat.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814203850.2240469-20-dhowells@redhat.com>

On Wed, Aug 14, 2024 at 09:38:39PM +0100, David Howells wrote:
> Improve the efficiency of buffered reads in a number of ways:
> 
>  (1) Overhaul the algorithm in general so that it's a lot more compact and
>      split the read submission code between buffered and unbuffered
>      versions.  The unbuffered version can be vastly simplified.
> 
>  (2) Read-result collection is handed off to a work queue rather than being
>      done in the I/O thread.  Multiple subrequests can be processes
>      simultaneously.
> 
>  (3) When a subrequest is collected, any folios it fully spans are
>      collected and "spare" data on either side is donated to either the
>      previous or the next subrequest in the sequence.
> 
> Notes:
> 
>  (*) Readahead expansion is massively slows down fio, presumably because it
>      causes a load of extra allocations, both folio and xarray, up front
>      before RPC requests can be transmitted.
> 
>  (*) RDMA with cifs does appear to work, both with SIW and RXE.
> 
>  (*) PG_private_2-based reading and copy-to-cache is split out into its own
>      file and altered to use folio_queue.  Note that the copy to the cache
>      now creates a new write transaction against the cache and adds the
>      folios to be copied into it.  This allows it to use part of the
>      writeback I/O code.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

...

> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c

...

> @@ -334,9 +344,8 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  	struct ceph_client *cl = fsc->client;
>  	struct ceph_osd_request *req = NULL;
>  	struct ceph_vino vino = ceph_vino(inode);
> -	struct iov_iter iter;
> -	int err = 0;
> -	u64 len = subreq->len;
> +	int err;

Hi David,

err is set conditionally in various places in this function, and then read
unconditionally near the end of this function. With this change isn't
entirely clear that err is always initialised by the end of the function.

Flagged by Smatch.

> +	u64 len;
>  	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
>  	u64 off = subreq->start;
>  	int extent_cnt;

...

> @@ -410,17 +423,19 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  	req->r_inode = inode;
>  	ihold(inode);
>  
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
>  	ceph_osdc_start_request(req->r_osdc, req);
>  out:
>  	ceph_osdc_put_request(req);
>  	if (err)
> -		netfs_subreq_terminated(subreq, err, false);
> +		netfs_read_subreq_terminated(subreq, err, false);
>  	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
>  }

...

> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c

...

> +/*
> + * Go through the list of failed/short reads, retrying all retryable ones.  We
> + * need to switch failed cache reads to network downloads.
> + */
> +static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_io_stream *stream0 = &rreq->io_streams[0];
> +	LIST_HEAD(sublist);
> +	LIST_HEAD(queue);
> +
> +	_enter("R=%x", rreq->debug_id);
> +
> +	if (list_empty(&rreq->subrequests))
> +		return;
> +
> +	if (rreq->netfs_ops->retry_request)
> +		rreq->netfs_ops->retry_request(rreq, NULL);
> +
> +	/* If there's no renegotiation to do, just resend each retryable subreq
> +	 * up to the first permanently failed one.
> +	 */
> +	if (!rreq->netfs_ops->prepare_read &&
> +	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
> +		struct netfs_io_subrequest *subreq;
> +
> +		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
> +			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
> +				break;
> +			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> +				netfs_reset_iter(subreq);
> +				netfs_reissue_read(rreq, subreq);
> +			}
> +		}
> +		return;
> +	}
> +
> +	/* Okay, we need to renegotiate all the download requests and flip any
> +	 * failed cache reads over to being download requests and negotiate
> +	 * those also.  All fully successful subreqs have been removed from the
> +	 * list and any spare data from those has been donated.
> +	 *
> +	 * What we do is decant the list and rebuild it one subreq at a time so
> +	 * that we don't end up with donations jumping over a gap we're busy
> +	 * populating with smaller subrequests.  In the event that the subreq
> +	 * we just launched finishes before we insert the next subreq, it'll
> +	 * fill in rreq->prev_donated instead.
> +
> +	 * Note: Alternatively, we could split the tail subrequest right before
> +	 * we reissue it and fix up the donations under lock.
> +	 */
> +	list_splice_init(&rreq->subrequests, &queue);
> +
> +	do {
> +		struct netfs_io_subrequest *from;
> +		struct iov_iter source;
> +		unsigned long long start, len;
> +		size_t part, deferred_next_donated = 0;
> +		bool boundary = false;
> +
> +		/* Go through the subreqs and find the next span of contiguous
> +		 * buffer that we then rejig (cifs, for example, needs the
> +		 * rsize renegotiating) and reissue.
> +		 */
> +		from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
> +		list_move_tail(&from->rreq_link, &sublist);
> +		start = from->start + from->transferred;
> +		len   = from->len   - from->transferred;
> +
> +		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
> +		       rreq->debug_id, from->debug_index,
> +		       from->start, from->consumed, from->transferred, from->len);
> +
> +		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
> +		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
> +			goto abandon;
> +
> +		deferred_next_donated = from->next_donated;
> +		while ((subreq = list_first_entry_or_null(
> +				&queue, struct netfs_io_subrequest, rreq_link))) {
> +			if (subreq->start != start + len ||
> +			    subreq->transferred > 0 ||
> +			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
> +				break;
> +			list_move_tail(&subreq->rreq_link, &sublist);
> +			len += subreq->len;
> +			deferred_next_donated = subreq->next_donated;
> +			if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
> +				break;
> +		}
> +
> +		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
> +
> +		/* Determine the set of buffers we're going to use.  Each
> +		 * subreq gets a subset of a single overall contiguous buffer.
> +		 */
> +		netfs_reset_iter(from);
> +		source = from->io_iter;
> +		source.count = len;
> +
> +		/* Work through the sublist. */
> +		while ((subreq = list_first_entry_or_null(
> +				&sublist, struct netfs_io_subrequest, rreq_link))) {
> +			list_del(&subreq->rreq_link);
> +
> +			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
> +			subreq->start	= start - subreq->transferred;
> +			subreq->len	= len   + subreq->transferred;
> +			stream0->sreq_max_len = subreq->len;
> +
> +			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +
> +			spin_lock_bh(&rreq->lock);
> +			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> +			subreq->prev_donated += rreq->prev_donated;
> +			rreq->prev_donated = 0;
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> +			spin_unlock_bh(&rreq->lock);
> +
> +			BUG_ON(!len);
> +
> +			/* Renegotiate max_len (rsize) */
> +			if (rreq->netfs_ops->prepare_read(subreq) < 0) {

Earlier in this function it is assumed that prepare_read may be NULL.
Can that also be the case here?

Also flagged by Smatch.

> +				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
> +				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +			}

...

