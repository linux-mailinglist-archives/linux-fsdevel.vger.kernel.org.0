Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01263469527
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbhLFLp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 06:45:56 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:54919 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237397AbhLFLpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:45:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UzcMKwq_1638790938;
Received: from 30.225.24.25(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UzcMKwq_1638790938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 19:42:19 +0800
Message-ID: <d4167c15-b3ce-73b2-1d66-97d651723305@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 19:42:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH 24/64] netfs: Pass more information on how to deal with a
 hole in the cache
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
 <163819612321.215744.9738308885948264476.stgit@warthog.procyon.org.uk>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <163819612321.215744.9738308885948264476.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/29/21 10:28 PM, David Howells wrote:
> Pass more information to the cache on how to deal with a hole if it
> encounters one when trying to read from the cache.  Three options are
> provided:
> 
>  (1) NETFS_READ_HOLE_IGNORE.  Read the hole along with the data, assuming
>      it to be a punched-out extent by the backing filesystem.
> 
>  (2) NETFS_READ_HOLE_CLEAR.  If there's a hole, erase the requested region
>      of the cache and clear the read buffer.
> 
>  (3) NETFS_READ_HOLE_FAIL.  Fail the read if a hole is detected.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/netfs/read_helper.c |    8 ++++----
>  include/linux/netfs.h  |   11 ++++++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 7dc79fa8a1f3..08df413efdf3 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -170,7 +170,7 @@ static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error
>   */
>  static void netfs_read_from_cache(struct netfs_read_request *rreq,
>  				  struct netfs_read_subrequest *subreq,
> -				  bool seek_data)
> +				  enum netfs_read_from_hole read_hole)
>  {
>  	struct netfs_cache_resources *cres = &rreq->cache_resources;
>  	struct iov_iter iter;
> @@ -180,7 +180,7 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
>  			subreq->start + subreq->transferred,
>  			subreq->len   - subreq->transferred);
>  
> -	cres->ops->read(cres, subreq->start, &iter, seek_data,
> +	cres->ops->read(cres, subreq->start, &iter, read_hole,
>  			netfs_cache_read_terminated, subreq);
>  }
>  
> @@ -466,7 +466,7 @@ static void netfs_rreq_short_read(struct netfs_read_request *rreq,
>  	netfs_get_read_subrequest(subreq);
>  	atomic_inc(&rreq->nr_rd_ops);
>  	if (subreq->source == NETFS_READ_FROM_CACHE)
> -		netfs_read_from_cache(rreq, subreq, true);
> +		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);

Hi I'm not sure why NETFS_READ_HOLE_CLEAR style should be used in 'short
read' case.

Besides,

```
static void netfs_read_from_cache(struct netfs_read_request *rreq,
				  struct netfs_read_subrequest *subreq,
				  enum netfs_read_from_hole read_hole)
{
	struct netfs_cache_resources *cres = &rreq->cache_resources;
	struct iov_iter iter;

	netfs_stat(&netfs_n_rh_read);
	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
			subreq->start + subreq->transferred,
			subreq->len   - subreq->transferred);

	cres->ops->read(cres, subreq->start, &iter, read_hole,
			netfs_cache_read_terminated, subreq);
}
```

I'm not sure why 'subreq->start' is not incremented with
'subreq->transferred' when calling cres->ops->read() in 'short read' case.


>  	else
>  		netfs_read_from_server(rreq, subreq);
>  }
> @@ -794,7 +794,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_request *rreq,
>  		netfs_read_from_server(rreq, subreq);
>  		break;
>  	case NETFS_READ_FROM_CACHE:
> -		netfs_read_from_cache(rreq, subreq, false);
> +		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
>  		break;
>  	default:
>  		BUG();




> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 5a46fde65759..b46c39d98bbd 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -196,6 +196,15 @@ struct netfs_read_request_ops {
>  	void (*cleanup)(struct address_space *mapping, void *netfs_priv);
>  };
>  
> +/*
> + * How to handle reading from a hole.
> + */
> +enum netfs_read_from_hole {
> +	NETFS_READ_HOLE_IGNORE,
> +	NETFS_READ_HOLE_CLEAR,
> +	NETFS_READ_HOLE_FAIL,
> +};
> +
>  /*
>   * Table of operations for access to a cache.  This is obtained by
>   * rreq->ops->begin_cache_operation().
> @@ -208,7 +217,7 @@ struct netfs_cache_ops {
>  	int (*read)(struct netfs_cache_resources *cres,
>  		    loff_t start_pos,
>  		    struct iov_iter *iter,
> -		    bool seek_data,
> +		    enum netfs_read_from_hole read_hole,
>  		    netfs_io_terminated_t term_func,
>  		    void *term_func_priv);
>  
> 

-- 
Thanks,
Jeffle
