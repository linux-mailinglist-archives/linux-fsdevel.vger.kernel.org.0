Return-Path: <linux-fsdevel+bounces-34829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 210369C9114
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21193B37001
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3C18595B;
	Thu, 14 Nov 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN1NXCIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F267DA6D;
	Thu, 14 Nov 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602374; cv=none; b=L6sF162VoNTRmmFAaYNvd+IQMgd5thRrIdvtpdC+R9xDm2cjw1II3Pv/NNfeskOF6zWKPa8ZUAV4JcS9adzUivJdbeFHQVrWVWaCdnGJSYsIDU7weRFQq/j9qJd9+WFcvLcNCl4On59GHhTAWXZ+cQnEJBnnXH8Uuy0ZFfLTi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602374; c=relaxed/simple;
	bh=SUgKw9P+o1HnS6FND7Lta07yLNLbdsT2InWIXPbLQT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjyjCgY+xFvxwzofj1UifN2foVv5PqoWQEQSAZscMVX5LHwnB9xhhmuh4DbGJoQbRafZ8IMjPl7ONtDToy8uuArNwDEX9dibhpXzREjAIOC2NAPQPL/MgUvhM+jsWQRZzpPAWwqT32lWGh9J+cn5C4QNUCSPfa8GjzKmhB2sr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN1NXCIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF3DC4CED0;
	Thu, 14 Nov 2024 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731602374;
	bh=SUgKw9P+o1HnS6FND7Lta07yLNLbdsT2InWIXPbLQT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nN1NXCIgrxJ4wk4bcHMhmOuYrCKibErARAw+zOQjDHHFuOK18Brb1h1CQ5hmnTp8V
	 KAyuHnkpDtG87QBRy9XwJlthDqNWBY202bxVt1qqw99Wzobz5thZ096hR0glKhIjII
	 /ZA3UnhDf+X4rBLnCVp0MRl2Leq42RY0Kcie0wqnm4FzsG4U61FM3ZRq+0+x7gknv3
	 FzZKNTgibcdo9cf0/5GAfT8k1ONMZ9XozEApa5Sh4ftMjfeOgROuZcus0jAnRg5D/A
	 kaXLd5qcq5VRrPOpsLSKYA5EOUNKK0ercajIivXck4U0VWWp1wDJfnDoM1SgBdANjJ
	 cZ6W8T227w59w==
Date: Thu, 14 Nov 2024 09:39:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>
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
Subject: Re: [PATCH v4 28/33] netfs: Change the read result collector to only
 use one work item
Message-ID: <20241114163931.GA1928968@thelio-3990X>
References: <20241108173236.1382366-1-dhowells@redhat.com>
 <20241108173236.1382366-29-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108173236.1382366-29-dhowells@redhat.com>

Hi David,

On Fri, Nov 08, 2024 at 05:32:29PM +0000, David Howells wrote:
...
> diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
> index 264f3cb6a7dc..8ca0558570c1 100644
> --- a/fs/netfs/read_retry.c
> +++ b/fs/netfs/read_retry.c
> @@ -12,15 +12,8 @@
>  static void netfs_reissue_read(struct netfs_io_request *rreq,
>  			       struct netfs_io_subrequest *subreq)
>  {
> -	struct iov_iter *io_iter = &subreq->io_iter;
> -
> -	if (iov_iter_is_folioq(io_iter)) {
> -		subreq->curr_folioq = (struct folio_queue *)io_iter->folioq;
> -		subreq->curr_folioq_slot = io_iter->folioq_slot;
> -		subreq->curr_folio_order = subreq->curr_folioq->orders[subreq->curr_folioq_slot];
> -	}
> -
> -	atomic_inc(&rreq->nr_outstanding);
> +	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
> +	__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
>  	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
>  	netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>  	subreq->rreq->netfs_ops->issue_read(subreq);
> @@ -33,13 +26,12 @@ static void netfs_reissue_read(struct netfs_io_request *rreq,
>  static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  {
>  	struct netfs_io_subrequest *subreq;
> -	struct netfs_io_stream *stream0 = &rreq->io_streams[0];
> -	LIST_HEAD(sublist);
> -	LIST_HEAD(queue);
> +	struct netfs_io_stream *stream = &rreq->io_streams[0];
> +	struct list_head *next;
>  
>  	_enter("R=%x", rreq->debug_id);
>  
> -	if (list_empty(&rreq->subrequests))
> +	if (list_empty(&stream->subrequests))
>  		return;
>  
>  	if (rreq->netfs_ops->retry_request)
> @@ -52,7 +44,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
>  		struct netfs_io_subrequest *subreq;
>  
> -		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
> +		list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
>  			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
>  				break;
>  			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> @@ -73,48 +65,44 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  	 * populating with smaller subrequests.  In the event that the subreq
>  	 * we just launched finishes before we insert the next subreq, it'll
>  	 * fill in rreq->prev_donated instead.
> -
> +	 *
>  	 * Note: Alternatively, we could split the tail subrequest right before
>  	 * we reissue it and fix up the donations under lock.
>  	 */
> -	list_splice_init(&rreq->subrequests, &queue);
> +	next = stream->subrequests.next;
>  
>  	do {
> -		struct netfs_io_subrequest *from;
> +		struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
>  		struct iov_iter source;
>  		unsigned long long start, len;
> -		size_t part, deferred_next_donated = 0;
> +		size_t part;
>  		bool boundary = false;
>  
>  		/* Go through the subreqs and find the next span of contiguous
>  		 * buffer that we then rejig (cifs, for example, needs the
>  		 * rsize renegotiating) and reissue.
>  		 */
> -		from = list_first_entry(&queue, struct netfs_io_subrequest, rreq_link);
> -		list_move_tail(&from->rreq_link, &sublist);
> +		from = list_entry(next, struct netfs_io_subrequest, rreq_link);
> +		to = from;
>  		start = from->start + from->transferred;
>  		len   = from->len   - from->transferred;
>  
> -		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx/%zx",
> +		_debug("from R=%08x[%x] s=%llx ctl=%zx/%zx",
>  		       rreq->debug_id, from->debug_index,
> -		       from->start, from->consumed, from->transferred, from->len);
> +		       from->start, from->transferred, from->len);
>  
>  		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
>  		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
>  			goto abandon;
>  
> -		deferred_next_donated = from->next_donated;
> -		while ((subreq = list_first_entry_or_null(
> -				&queue, struct netfs_io_subrequest, rreq_link))) {
> -			if (subreq->start != start + len ||
> -			    subreq->transferred > 0 ||
> +		list_for_each_continue(next, &stream->subrequests) {
> +			subreq = list_entry(next, struct netfs_io_subrequest, rreq_link);
> +			if (subreq->start + subreq->transferred != start + len ||
> +			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
>  			    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
>  				break;
> -			list_move_tail(&subreq->rreq_link, &sublist);
> -			len += subreq->len;
> -			deferred_next_donated = subreq->next_donated;
> -			if (test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags))
> -				break;
> +			to = subreq;
> +			len += to->len;
>  		}
>  
>  		_debug(" - range: %llx-%llx %llx", start, start + len - 1, len);
> @@ -127,36 +115,28 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  		source.count = len;
>  
>  		/* Work through the sublist. */
> -		while ((subreq = list_first_entry_or_null(
> -				&sublist, struct netfs_io_subrequest, rreq_link))) {
> -			list_del(&subreq->rreq_link);
> -
> +		subreq = from;
> +		list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
> +			if (!len)
> +				break;
>  			subreq->source	= NETFS_DOWNLOAD_FROM_SERVER;
>  			subreq->start	= start - subreq->transferred;
>  			subreq->len	= len   + subreq->transferred;
> -			stream0->sreq_max_len = subreq->len;
> -
>  			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> -
> -			spin_lock(&rreq->lock);
> -			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> -			subreq->prev_donated += rreq->prev_donated;
> -			rreq->prev_donated = 0;
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> -			spin_unlock(&rreq->lock);
> -
> -			BUG_ON(!len);
>  
>  			/* Renegotiate max_len (rsize) */
> +			stream->sreq_max_len = subreq->len;
>  			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
>  				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
>  				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +				goto abandon;
>  			}
>  
> -			part = umin(len, stream0->sreq_max_len);
> -			if (unlikely(rreq->io_streams[0].sreq_max_segs))
> -				part = netfs_limit_iter(&source, 0, part, stream0->sreq_max_segs);
> +			part = umin(len, stream->sreq_max_len);
> +			if (unlikely(stream->sreq_max_segs))
> +				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
>  			subreq->len = subreq->transferred + part;
>  			subreq->io_iter = source;
>  			iov_iter_truncate(&subreq->io_iter, part);
> @@ -166,58 +146,106 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>  			if (!len) {
>  				if (boundary)
>  					__set_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
> -				subreq->next_donated = deferred_next_donated;
>  			} else {
>  				__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
> -				subreq->next_donated = 0;
>  			}
>  
> +			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>  			netfs_reissue_read(rreq, subreq);
> -			if (!len)
> +			if (subreq == to)
>  				break;
> -
> -			/* If we ran out of subrequests, allocate another. */
> -			if (list_empty(&sublist)) {
> -				subreq = netfs_alloc_subrequest(rreq);
> -				if (!subreq)
> -					goto abandon;
> -				subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
> -				subreq->start = start;
> -
> -				/* We get two refs, but need just one. */
> -				netfs_put_subrequest(subreq, false, netfs_sreq_trace_new);
> -				trace_netfs_sreq(subreq, netfs_sreq_trace_split);
> -				list_add_tail(&subreq->rreq_link, &sublist);
> -			}
>  		}
>  
>  		/* If we managed to use fewer subreqs, we can discard the
> -		 * excess.
> +		 * excess; if we used the same number, then we're done.
>  		 */
> -		while ((subreq = list_first_entry_or_null(
> -				&sublist, struct netfs_io_subrequest, rreq_link))) {
> -			trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
> -			list_del(&subreq->rreq_link);
> -			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
> +		if (!len) {
> +			if (subreq == to)
> +				continue;
> +			list_for_each_entry_safe_from(subreq, tmp,
> +						      &stream->subrequests, rreq_link) {
> +				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
> +				list_del(&subreq->rreq_link);
> +				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_done);
> +				if (subreq == to)
> +					break;
> +			}
> +			continue;
>  		}
>  
> -	} while (!list_empty(&queue));
> +		/* We ran out of subrequests, so we need to allocate some more
> +		 * and insert them after.
> +		 */
> +		do {
> +			subreq = netfs_alloc_subrequest(rreq);
> +			if (!subreq) {
> +				subreq = to;
> +				goto abandon_after;
> +			}
> +			subreq->source		= NETFS_DOWNLOAD_FROM_SERVER;
> +			subreq->start		= start;
> +			subreq->len		= len;
> +			subreq->debug_index	= atomic_inc_return(&rreq->subreq_counter);
> +			subreq->stream_nr	= stream->stream_nr;
> +			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
> +
> +			trace_netfs_sreq_ref(rreq->debug_id, subreq->debug_index,
> +					     refcount_read(&subreq->ref),
> +					     netfs_sreq_trace_new);
> +			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
> +
> +			list_add(&subreq->rreq_link, &to->rreq_link);
> +			to = list_next_entry(to, rreq_link);
> +			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
> +
> +			stream->sreq_max_len	= umin(len, rreq->rsize);
> +			stream->sreq_max_segs	= 0;
> +			if (unlikely(stream->sreq_max_segs))
> +				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
> +
> +			netfs_stat(&netfs_n_rh_download);
> +			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
> +				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
> +				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +				goto abandon;
> +			}
> +
> +			part = umin(len, stream->sreq_max_len);
> +			subreq->len = subreq->transferred + part;
> +			subreq->io_iter = source;
> +			iov_iter_truncate(&subreq->io_iter, part);
> +			iov_iter_advance(&source, part);
> +
> +			len -= part;
> +			start += part;
> +			if (!len && boundary) {
> +				__set_bit(NETFS_SREQ_BOUNDARY, &to->flags);
> +				boundary = false;
> +			}
> +
> +			netfs_reissue_read(rreq, subreq);
> +		} while (len);
> +
> +	} while (!list_is_head(next, &stream->subrequests));
>  
>  	return;
>  
> -	/* If we hit ENOMEM, fail all remaining subrequests */
> +	/* If we hit an error, fail all remaining incomplete subrequests */
> +abandon_after:
> +	if (list_is_last(&subreq->rreq_link, &stream->subrequests))
> +		return;

This change as commit 1bd9011ee163 ("netfs: Change the read result
collector to only use one work item") in next-20241114 causes a clang
warning:

  fs/netfs/read_retry.c:235:20: error: variable 'subreq' is uninitialized when used here [-Werror,-Wuninitialized]
    235 |         if (list_is_last(&subreq->rreq_link, &stream->subrequests))
        |                           ^~~~~~
  fs/netfs/read_retry.c:28:36: note: initialize the variable 'subreq' to silence this warning
     28 |         struct netfs_io_subrequest *subreq;
        |                                           ^
        |                                            = NULL

May be a shadowing issue, as adding KCFLAGS=-Wshadow shows:

  fs/netfs/read_retry.c:75:31: error: declaration shadows a local variable [-Werror,-Wshadow]
     75 |                 struct netfs_io_subrequest *subreq = NULL, *from, *to, *tmp;
        |                                             ^
  fs/netfs/read_retry.c:28:30: note: previous declaration is here
     28 |         struct netfs_io_subrequest *subreq;
        |                                     ^

Cheers,
Nathan

> +	subreq = list_next_entry(subreq, rreq_link);
>  abandon:
> -	list_splice_init(&sublist, &queue);
> -	list_for_each_entry(subreq, &queue, rreq_link) {
> -		if (!subreq->error)
> -			subreq->error = -ENOMEM;
> -		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +	list_for_each_entry_from(subreq, &stream->subrequests, rreq_link) {
> +		if (!subreq->error &&
> +		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
> +		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
> +			continue;
> +		subreq->error = -ENOMEM;
> +		__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
>  		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  		__clear_bit(NETFS_SREQ_RETRYING, &subreq->flags);
>  	}
> -	spin_lock(&rreq->lock);
> -	list_splice_tail_init(&queue, &rreq->subrequests);
> -	spin_unlock(&rreq->lock);
>  }
>  
>  /*
> @@ -225,14 +253,19 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
>   */
>  void netfs_retry_reads(struct netfs_io_request *rreq)
>  {
> -	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
> +	struct netfs_io_subrequest *subreq;
> +	struct netfs_io_stream *stream = &rreq->io_streams[0];
>  
> -	atomic_inc(&rreq->nr_outstanding);
> +	/* Wait for all outstanding I/O to quiesce before performing retries as
> +	 * we may need to renegotiate the I/O sizes.
> +	 */
> +	list_for_each_entry(subreq, &stream->subrequests, rreq_link) {
> +		wait_on_bit(&subreq->flags, NETFS_SREQ_IN_PROGRESS,
> +			    TASK_UNINTERRUPTIBLE);
> +	}
>  
> +	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
>  	netfs_retry_read_subrequests(rreq);
> -
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		netfs_rreq_terminated(rreq);
>  }
>  
>  /*

