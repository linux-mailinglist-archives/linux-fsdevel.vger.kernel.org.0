Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BAE4D31D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiCIPfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 10:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiCIPfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:35:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57C0107D0E;
        Wed,  9 Mar 2022 07:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C401B8216D;
        Wed,  9 Mar 2022 15:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEA5C340E8;
        Wed,  9 Mar 2022 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646840056;
        bh=TV95MBhKSCKP9nVEtQW0Jyit4w7bEmsJUAPYrD+2OeI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uxPK2Y52hxeVPMpJmf72oYD1O59FwXg5Zwx1BnfsKLaHITiwjPErmpSRhJDSjuAzD
         vOD0E5JMt9gSHX9TACHxel/gpdo36XLqAemy2Q0OmdomPRzRtFBlqhWQdJAfk7q6v3
         iaSGWxJ+LA9r4accQnb+ARoCcbhzyRHvX8lCXzDeImRd0OlrywOKucHZVh6XIY/azb
         L1T4kWYZWUSKPkilu1gFbTuOnkcMawQ/ddU0UaIvLLS1MWu1mArSlbwLRbvweYbn0d
         B/Cc9OJ9gnQQ88rmPBQcCl7m5I8S3Ns28IOCDYtvT9ES5vkhLngTv6s7QnVb9Dg0V4
         X79YAi5drO+pQ==
Message-ID: <c18a1ccd52f8c88205cc1345d6fa73d3e9da5456.camel@kernel.org>
Subject: Re: [PATCH v2 04/19] netfs: Finish off rename of netfs_read_request
 to netfs_io_request
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 10:34:13 -0500
In-Reply-To: <164678196111.1200972.5001114956865989528.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678196111.1200972.5001114956865989528.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-08 at 23:26 +0000, David Howells wrote:
> Adjust helper function names and comments after mass rename of
> struct netfs_read_*request to struct netfs_io_*request.
> 
> Changes
> =======
> ver #2)
>  - Make the changes in the docs also.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> 
> Link: https://lore.kernel.org/r/164622992433.3564931.6684311087845150271.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  Documentation/filesystems/netfs_library.rst |    4 +
>  fs/9p/vfs_addr.c                            |    6 +-
>  fs/afs/file.c                               |    4 +
>  fs/cachefiles/io.c                          |    4 +
>  fs/ceph/addr.c                              |    6 +-
>  fs/netfs/read_helper.c                      |   83 ++++++++++++++-------------
>  include/linux/netfs.h                       |   22 ++++---
>  7 files changed, 65 insertions(+), 64 deletions(-)
> 
> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
> index a997e2d4321d..4eb7e7b7b0fc 100644
> --- a/Documentation/filesystems/netfs_library.rst
> +++ b/Documentation/filesystems/netfs_library.rst
> @@ -250,7 +250,7 @@ through which it can issue requests and negotiate::
>  		int (*begin_cache_operation)(struct netfs_io_request *rreq);
>  		void (*expand_readahead)(struct netfs_io_request *rreq);
>  		bool (*clamp_length)(struct netfs_io_subrequest *subreq);
> -		void (*issue_op)(struct netfs_io_subrequest *subreq);
> +		void (*issue_read)(struct netfs_io_subrequest *subreq);
>  		bool (*is_still_valid)(struct netfs_io_request *rreq);
>  		int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
>  					 struct folio *folio, void **_fsdata);
> @@ -305,7 +305,7 @@ The operations are as follows:
>  
>     This should return 0 on success and an error code on error.
>  
> - * ``issue_op()``
> + * ``issue_read()``
>  
>     [Required] The helpers use this to dispatch a subrequest to the server for
>     reading.  In the subrequest, ->start, ->len and ->transferred indicate what
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index 7b79fabe7593..fdc1033a1546 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -28,10 +28,10 @@
>  #include "fid.h"
>  
>  /**
> - * v9fs_req_issue_op - Issue a read from 9P
> + * v9fs_issue_read - Issue a read from 9P
>   * @subreq: The read to make
>   */
> -static void v9fs_req_issue_op(struct netfs_io_subrequest *subreq)
> +static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>  {
>  	struct netfs_io_request *rreq = subreq->rreq;
>  	struct p9_fid *fid = rreq->netfs_priv;
> @@ -106,7 +106,7 @@ static const struct netfs_request_ops v9fs_req_ops = {
>  	.init_request		= v9fs_init_request,
>  	.is_cache_enabled	= v9fs_is_cache_enabled,
>  	.begin_cache_operation	= v9fs_begin_cache_operation,
> -	.issue_op		= v9fs_req_issue_op,
> +	.issue_read		= v9fs_issue_read,
>  	.cleanup		= v9fs_req_cleanup,
>  };
>  
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index e55761f8858c..b19d635eed12 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -310,7 +310,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
>  	return afs_do_sync_operation(op);
>  }
>  
> -static void afs_req_issue_op(struct netfs_io_subrequest *subreq)
> +static void afs_issue_read(struct netfs_io_subrequest *subreq)
>  {
>  	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
>  	struct afs_read *fsreq;
> @@ -401,7 +401,7 @@ const struct netfs_request_ops afs_req_ops = {
>  	.is_cache_enabled	= afs_is_cache_enabled,
>  	.begin_cache_operation	= afs_begin_cache_operation,
>  	.check_write_begin	= afs_check_write_begin,
> -	.issue_op		= afs_req_issue_op,
> +	.issue_read		= afs_issue_read,
>  	.cleanup		= afs_priv_cleanup,
>  };
>  
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 6ac6fdbc70d3..b19f496db9ad 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -406,7 +406,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  	}
>  
>  	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
> -		__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
> +		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
>  		why = cachefiles_trace_read_no_data;
>  		goto out_no_object;
>  	}
> @@ -475,7 +475,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
>  	goto out;
>  
>  download_and_store:
> -	__set_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
> +	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
>  out:
>  	cachefiles_end_secure(cache, saved_cred);
>  out_no_object:
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 9d995f351079..9189257476f8 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -259,7 +259,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
>  	size_t len;
>  
>  	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> -	__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
> +	__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
>  
>  	if (subreq->start >= inode->i_size)
>  		goto out;
> @@ -298,7 +298,7 @@ static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest *subreq)
>  	return true;
>  }
>  
> -static void ceph_netfs_issue_op(struct netfs_io_subrequest *subreq)
> +static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  {
>  	struct netfs_io_request *rreq = subreq->rreq;
>  	struct inode *inode = rreq->inode;
> @@ -367,7 +367,7 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
>  static const struct netfs_request_ops ceph_netfs_read_ops = {
>  	.is_cache_enabled	= ceph_is_cache_enabled,
>  	.begin_cache_operation	= ceph_begin_cache_operation,
> -	.issue_op		= ceph_netfs_issue_op,
> +	.issue_read		= ceph_netfs_issue_read,
>  	.expand_readahead	= ceph_netfs_expand_readahead,
>  	.clamp_length		= ceph_netfs_clamp_length,
>  	.check_write_begin	= ceph_netfs_check_write_begin,
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 50035d93f1dc..26d54055b17e 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -37,7 +37,7 @@ static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
>  		__netfs_put_subrequest(subreq, was_async);
>  }
>  
> -static struct netfs_io_request *netfs_alloc_read_request(
> +static struct netfs_io_request *netfs_alloc_request(
>  	const struct netfs_request_ops *ops, void *netfs_priv,
>  	struct file *file)
>  {
> @@ -63,13 +63,12 @@ static struct netfs_io_request *netfs_alloc_read_request(
>  	return rreq;
>  }
>  
> -static void netfs_get_read_request(struct netfs_io_request *rreq)
> +static void netfs_get_request(struct netfs_io_request *rreq)
>  {
>  	refcount_inc(&rreq->usage);
>  }
>  
> -static void netfs_rreq_clear_subreqs(struct netfs_io_request *rreq,
> -				     bool was_async)
> +static void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
>  {
>  	struct netfs_io_subrequest *subreq;
>  
> @@ -81,11 +80,11 @@ static void netfs_rreq_clear_subreqs(struct netfs_io_request *rreq,
>  	}
>  }
>  
> -static void netfs_free_read_request(struct work_struct *work)
> +static void netfs_free_request(struct work_struct *work)
>  {
>  	struct netfs_io_request *rreq =
>  		container_of(work, struct netfs_io_request, work);
> -	netfs_rreq_clear_subreqs(rreq, false);
> +	netfs_clear_subrequests(rreq, false);
>  	if (rreq->netfs_priv)
>  		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
> @@ -95,15 +94,15 @@ static void netfs_free_read_request(struct work_struct *work)
>  	netfs_stat_d(&netfs_n_rh_rreq);
>  }
>  
> -static void netfs_put_read_request(struct netfs_io_request *rreq, bool was_async)
> +static void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
>  {
>  	if (refcount_dec_and_test(&rreq->usage)) {
>  		if (was_async) {
> -			rreq->work.func = netfs_free_read_request;
> +			rreq->work.func = netfs_free_request;
>  			if (!queue_work(system_unbound_wq, &rreq->work))
>  				BUG();
>  		} else {
> -			netfs_free_read_request(&rreq->work);
> +			netfs_free_request(&rreq->work);
>  		}
>  	}
>  }
> @@ -121,14 +120,14 @@ static struct netfs_io_subrequest *netfs_alloc_subrequest(
>  		INIT_LIST_HEAD(&subreq->rreq_link);
>  		refcount_set(&subreq->usage, 2);
>  		subreq->rreq = rreq;
> -		netfs_get_read_request(rreq);
> +		netfs_get_request(rreq);
>  		netfs_stat(&netfs_n_rh_sreq);
>  	}
>  
>  	return subreq;
>  }
>  
> -static void netfs_get_read_subrequest(struct netfs_io_subrequest *subreq)
> +static void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
>  {
>  	refcount_inc(&subreq->usage);
>  }
> @@ -141,7 +140,7 @@ static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
>  	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
>  	kfree(subreq);
>  	netfs_stat_d(&netfs_n_rh_sreq);
> -	netfs_put_read_request(rreq, was_async);
> +	netfs_put_request(rreq, was_async);
>  }
>  
>  /*
> @@ -216,7 +215,7 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
>  				   struct netfs_io_subrequest *subreq)
>  {
>  	netfs_stat(&netfs_n_rh_download);
> -	rreq->netfs_ops->issue_op(subreq);
> +	rreq->netfs_ops->issue_read(subreq);
>  }
>  
>  /*
> @@ -225,8 +224,8 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
>  static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
>  {
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
> -	netfs_rreq_clear_subreqs(rreq, was_async);
> -	netfs_put_read_request(rreq, was_async);
> +	netfs_clear_subrequests(rreq, was_async);
> +	netfs_put_request(rreq, was_async);
>  }
>  
>  /*
> @@ -306,7 +305,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
>  	atomic_inc(&rreq->nr_copy_ops);
>  
>  	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
> -		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
> +		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
>  			list_del_init(&subreq->rreq_link);
>  			netfs_put_subrequest(subreq, false);
>  		}
> @@ -336,7 +335,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
>  
>  		atomic_inc(&rreq->nr_copy_ops);
>  		netfs_stat(&netfs_n_rh_write);
> -		netfs_get_read_subrequest(subreq);
> +		netfs_get_subrequest(subreq);
>  		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
>  		cres->ops->write(cres, subreq->start, &iter,
>  				 netfs_rreq_copy_terminated, subreq);
> @@ -378,9 +377,9 @@ static void netfs_rreq_unlock(struct netfs_io_request *rreq)
>  	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
>  
>  	if (test_bit(NETFS_RREQ_FAILED, &rreq->flags)) {
> -		__clear_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
> +		__clear_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
>  		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
> -			__clear_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags);
> +			__clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
>  		}
>  	}
>  
> @@ -408,7 +407,7 @@ static void netfs_rreq_unlock(struct netfs_io_request *rreq)
>  				pg_failed = true;
>  				break;
>  			}
> -			if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
> +			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
>  				folio_start_fscache(folio);
>  			pg_failed |= subreq_failed;
>  			if (pgend < iopos + subreq->len)
> @@ -453,13 +452,13 @@ static void netfs_rreq_unlock(struct netfs_io_request *rreq)
>  static void netfs_rreq_short_read(struct netfs_io_request *rreq,
>  				  struct netfs_io_subrequest *subreq)
>  {
> -	__clear_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
> +	__clear_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
>  	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
>  
>  	netfs_stat(&netfs_n_rh_short_read);
>  	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
>  
> -	netfs_get_read_subrequest(subreq);
> +	netfs_get_subrequest(subreq);
>  	atomic_inc(&rreq->nr_outstanding);
>  	if (subreq->source == NETFS_READ_FROM_CACHE)
>  		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
> @@ -493,10 +492,10 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
>  			subreq->error = 0;
>  			netfs_stat(&netfs_n_rh_download_instead);
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
> -			netfs_get_read_subrequest(subreq);
> +			netfs_get_subrequest(subreq);
>  			atomic_inc(&rreq->nr_outstanding);
>  			netfs_read_from_server(rreq, subreq);
> -		} else if (test_bit(NETFS_SREQ_SHORT_READ, &subreq->flags)) {
> +		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
>  			netfs_rreq_short_read(rreq, subreq);
>  		}
>  	}
> @@ -553,7 +552,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
>  	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
>  	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
>  
> -	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags))
> +	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags))
>  		return netfs_rreq_write_to_cache(rreq);
>  
>  	netfs_rreq_completed(rreq, was_async);
> @@ -642,8 +641,8 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
>  
>  complete:
>  	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
> -	if (test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags))
> -		set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
> +	if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
> +		set_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
>  
>  out:
>  	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
> @@ -674,7 +673,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
>  		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
>  	}
>  
> -	__set_bit(NETFS_SREQ_SHORT_READ, &subreq->flags);
> +	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
>  	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
>  	goto out;
>  
> @@ -878,7 +877,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  	if (readahead_count(ractl) == 0)
>  		goto cleanup;
>  
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, ractl->file);
> +	rreq = netfs_alloc_request(ops, netfs_priv, ractl->file);
>  	if (!rreq)
>  		goto cleanup;
>  	rreq->mapping	= ractl->mapping;
> @@ -916,7 +915,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  	return;
>  
>  cleanup_free:
> -	netfs_put_read_request(rreq, false);
> +	netfs_put_request(rreq, false);
>  	return;
>  cleanup:
>  	if (netfs_priv)
> @@ -953,7 +952,7 @@ int netfs_readpage(struct file *file,
>  
>  	_enter("%lx", folio_index(folio));
>  
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	rreq = netfs_alloc_request(ops, netfs_priv, file);
>  	if (!rreq) {
>  		if (netfs_priv)
>  			ops->cleanup(folio_file_mapping(folio), netfs_priv);
> @@ -975,7 +974,7 @@ int netfs_readpage(struct file *file,
>  	netfs_stat(&netfs_n_rh_readpage);
>  	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpage);
>  
> -	netfs_get_read_request(rreq);
> +	netfs_get_request(rreq);
>  
>  	atomic_set(&rreq->nr_outstanding, 1);
>  	do {
> @@ -989,7 +988,8 @@ int netfs_readpage(struct file *file,
>  	 * process.
>  	 */
>  	do {
> -		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
> +		wait_var_event(&rreq->nr_outstanding,
> +			       atomic_read(&rreq->nr_outstanding) == 1);
>  		netfs_rreq_assess(rreq, false);
>  	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
>  
> @@ -999,7 +999,7 @@ int netfs_readpage(struct file *file,
>  		ret = -EIO;
>  	}
>  out:
> -	netfs_put_read_request(rreq, false);
> +	netfs_put_request(rreq, false);
>  	return ret;
>  }
>  EXPORT_SYMBOL(netfs_readpage);
> @@ -1122,7 +1122,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	}
>  
>  	ret = -ENOMEM;
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	rreq = netfs_alloc_request(ops, netfs_priv, file);
>  	if (!rreq)
>  		goto error;
>  	rreq->mapping		= folio_file_mapping(folio);
> @@ -1146,7 +1146,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	 */
>  	ractl._nr_pages = folio_nr_pages(folio);
>  	netfs_rreq_expand(rreq, &ractl);
> -	netfs_get_read_request(rreq);
> +	netfs_get_request(rreq);
>  
>  	/* We hold the folio locks, so we can drop the references */
>  	folio_get(folio);
> @@ -1160,12 +1160,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  
>  	} while (rreq->submitted < rreq->len);
>  
> -	/* Keep nr_outstanding incremented so that the ref always belongs to us, and
> -	 * the service code isn't punted off to a random thread pool to
> +	/* Keep nr_outstanding incremented so that the ref always belongs to
> +	 * us, and the service code isn't punted off to a random thread pool to
>  	 * process.
>  	 */
>  	for (;;) {
> -		wait_var_event(&rreq->nr_outstanding, atomic_read(&rreq->nr_outstanding) == 1);
> +		wait_var_event(&rreq->nr_outstanding,
> +			       atomic_read(&rreq->nr_outstanding) == 1);
>  		netfs_rreq_assess(rreq, false);
>  		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
>  			break;
> @@ -1177,7 +1178,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  		trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_write_begin);
>  		ret = -EIO;
>  	}
> -	netfs_put_read_request(rreq, false);
> +	netfs_put_request(rreq, false);
>  	if (ret < 0)
>  		goto error;
>  
> @@ -1193,7 +1194,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	return 0;
>  
>  error_put:
> -	netfs_put_read_request(rreq, false);
> +	netfs_put_request(rreq, false);
>  error:
>  	folio_unlock(folio);
>  	folio_put(folio);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index a2ca91cb7a68..f63de27d6f29 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -131,7 +131,7 @@ struct netfs_cache_resources {
>   * Descriptor for a single component subrequest.
>   */
>  struct netfs_io_subrequest {
> -	struct netfs_io_request *rreq;	/* Supervising read request */
> +	struct netfs_io_request *rreq;		/* Supervising I/O request */
>  	struct list_head	rreq_link;	/* Link in rreq->subrequests */
>  	loff_t			start;		/* Where to start the I/O */
>  	size_t			len;		/* Size of the I/O */
> @@ -139,29 +139,29 @@ struct netfs_io_subrequest {
>  	refcount_t		usage;
>  	short			error;		/* 0 or error that occurred */
>  	unsigned short		debug_index;	/* Index in list (for debugging output) */
> -	enum netfs_io_source	source;		/* Where to read from */
> +	enum netfs_io_source	source;		/* Where to read from/write to */
>  	unsigned long		flags;
> -#define NETFS_SREQ_WRITE_TO_CACHE	0	/* Set if should write to cache */
> +#define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
>  #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
> -#define NETFS_SREQ_SHORT_READ		2	/* Set if there was a short read from the cache */
> +#define NETFS_SREQ_SHORT_IO		2	/* Set if the I/O was short */
>  #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
>  #define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
>  };
>  
>  /*
> - * Descriptor for a read helper request.  This is used to make multiple I/O
> - * requests on a variety of sources and then stitch the result together.
> + * Descriptor for an I/O helper request.  This is used to make multiple I/O
> + * operations to a variety of data stores and then stitch the result together.
>   */
>  struct netfs_io_request {
>  	struct work_struct	work;
>  	struct inode		*inode;		/* The file being accessed */
>  	struct address_space	*mapping;	/* The mapping being accessed */
>  	struct netfs_cache_resources cache_resources;
> -	struct list_head	subrequests;	/* Requests to fetch I/O from disk or net */
> +	struct list_head	subrequests;	/* Contributory I/O operations */
>  	void			*netfs_priv;	/* Private data for the netfs */
>  	unsigned int		debug_id;
> -	atomic_t		nr_outstanding;	/* Number of read ops in progress */
> -	atomic_t		nr_copy_ops;	/* Number of write ops in progress */
> +	atomic_t		nr_outstanding;	/* Number of ops in progress */
> +	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
>  	size_t			submitted;	/* Amount submitted for I/O so far */
>  	size_t			len;		/* Length of the request */
>  	short			error;		/* 0 or error that occurred */
> @@ -171,7 +171,7 @@ struct netfs_io_request {
>  	refcount_t		usage;
>  	unsigned long		flags;
>  #define NETFS_RREQ_INCOMPLETE_IO	0	/* Some ioreqs terminated short or with error */
> -#define NETFS_RREQ_WRITE_TO_CACHE	1	/* Need to write to the cache */
> +#define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
>  #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on completion */
>  #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on completion */
>  #define NETFS_RREQ_FAILED		4	/* The request failed */
> @@ -188,7 +188,7 @@ struct netfs_request_ops {
>  	int (*begin_cache_operation)(struct netfs_io_request *rreq);
>  	void (*expand_readahead)(struct netfs_io_request *rreq);
>  	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
> -	void (*issue_op)(struct netfs_io_subrequest *subreq);
> +	void (*issue_read)(struct netfs_io_subrequest *subreq);
>  	bool (*is_still_valid)(struct netfs_io_request *rreq);
>  	int (*check_write_begin)(struct file *file, loff_t pos, unsigned len,
>  				 struct folio *folio, void **_fsdata);
> 
> 

Another (mostly) mechanical change...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
