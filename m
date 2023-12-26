Return-Path: <linux-fsdevel+bounces-6918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D35581E88D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 17:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C50B21B3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9C74F8AE;
	Tue, 26 Dec 2023 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyoEySQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600444F883;
	Tue, 26 Dec 2023 16:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B5FC433C8;
	Tue, 26 Dec 2023 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703609685;
	bh=3qM2GHh77DRCqEQvJaFuJ3OPumR+rWFKPmfNaFK09E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyoEySQdPRqvopBhVvKfA83jPoJIz0P6THQ1jeUtceYWcDZeRZW1jcFBAvdLWkqMe
	 frKLy7VUSRSjJQfc+reCBX7hp9ANBukZNVXEwM4p/dU8O2geuf8PC57yDjHEPNsvlI
	 E4vKIvBhMpQdA3341bpZkfJ7JHjoRmNhXyyO7fdFjPxHkb8rcFGSlGXjrsYbVxi0dZ
	 SBFfT1xUJKTeDW+oKt+mmjGGSV3PNdjQDn2oRYEUWiwe+EsfhMQYlo4r+cxZ/bmj66
	 TZFcKGOwzCsSvPV0AwndM3MugXdYA2GSDrjrm+Zki38tWEUoO8HbiBJjk8RiqrDPOg
	 1uHSFsFaNMGEA==
Date: Tue, 26 Dec 2023 09:54:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 15/40] netfs: Add support for DIO buffering
Message-ID: <20231226165442.GA1202197@dev-arch.thelio-3990X>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-16-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221132400.1601991-16-dhowells@redhat.com>

On Thu, Dec 21, 2023 at 01:23:10PM +0000, David Howells wrote:
> Add a bvec array pointer and an iterator to netfs_io_request for either
> holding a copy of a DIO iterator or a list of all the bits of buffer
> pointed to by a DIO iterator.
> 
> There are two problems:  Firstly, if an iovec-class iov_iter is passed to
> ->read_iter() or ->write_iter(), this cannot be passed directly to
> kernel_sendmsg() or kernel_recvmsg() as that may cause locking recursion if
> a fault is generated, so we need to keep track of the pages involved
> separately.
> 
> Secondly, if the I/O is asynchronous, we must copy the iov_iter describing
> the buffer before returning to the caller as it may be immediately
> deallocated.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/objects.c    | 10 ++++++++++
>  include/linux/netfs.h |  4 ++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 1bd20bdad983..4df5e5eeada6 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -76,6 +76,7 @@ static void netfs_free_request(struct work_struct *work)
>  {
>  	struct netfs_io_request *rreq =
>  		container_of(work, struct netfs_io_request, work);
> +	unsigned int i;
>  
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
>  	netfs_proc_del_rreq(rreq);
> @@ -84,6 +85,15 @@ static void netfs_free_request(struct work_struct *work)
>  		rreq->netfs_ops->free_request(rreq);
>  	if (rreq->cache_resources.ops)
>  		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> +	if (rreq->direct_bv) {
> +		for (i = 0; i < rreq->direct_bv_count; i++) {
> +			if (rreq->direct_bv[i].bv_page) {
> +				if (rreq->direct_bv_unpin)
> +					unpin_user_page(rreq->direct_bv[i].bv_page);
> +			}
> +		}
> +		kvfree(rreq->direct_bv);
> +	}
>  	kfree_rcu(rreq, rcu);
>  	netfs_stat_d(&netfs_n_rh_rreq);
>  }
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 3da962e977f5..bbb33ccbf719 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -190,6 +190,9 @@ struct netfs_io_request {
>  	struct iov_iter		iter;		/* Unencrypted-side iterator */
>  	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
>  	void			*netfs_priv;	/* Private data for the netfs */
> +	struct bio_vec		*direct_bv	/* DIO buffer list (when handling iovec-iter) */
> +	__counted_by(direct_bv_count);

This will break the build with versions of clang that have support for
counted_by (as it has been reverted in main but reapplication to main is
being actively worked on) because while annotating pointers with this
attribute is a goal of the counted_by attribute, it is not ready yet.
Please consider removing this and adding a TODO to annotate it when
support is available.

  In file included from /builds/linux/fs/ceph/crypto.c:14:
  In file included from /builds/linux/fs/ceph/super.h:20:
  /builds/linux/include/linux/netfs.h:259:19: error: 'counted_by' only applies to C99 flexible array members
    259 |         struct bio_vec          *direct_bv      /* DIO buffer list (when handling iovec-iter) */
        |                                  ^~~~~~~~~
  1 error generated.

Some additional context from another recent error like this:

https://lore.kernel.org/CAKwvOdkvGTGiWzqEFq=kzqvxSYP5vUj3g9Z-=MZSQROzzSa_dg@mail.gmail.com/

Cheers,
Nathan

> +	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
>  	unsigned int		debug_id;
>  	atomic_t		nr_outstanding;	/* Number of ops in progress */
>  	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
> @@ -197,6 +200,7 @@ struct netfs_io_request {
>  	size_t			len;		/* Length of the request */
>  	short			error;		/* 0 or error that occurred */
>  	enum netfs_io_origin	origin;		/* Origin of the request */
> +	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
>  	loff_t			i_size;		/* Size of the file */
>  	loff_t			start;		/* Start position */
>  	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
> 

