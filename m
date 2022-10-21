Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F36078EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 15:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiJUN4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJUN4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:56:06 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EEB25E8A3;
        Fri, 21 Oct 2022 06:55:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSjhlh-_1666360554;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSjhlh-_1666360554)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 21:55:56 +0800
Date:   Fri, 21 Oct 2022 21:55:54 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] erofs: use netfs helpers manipulating request and
 subrequest
Message-ID: <Y1Kk6jMJ3KMshzsV@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
 <20221021084912.61468-3-jefflexu@linux.alibaba.com>
 <ce12b5050be31cc15bb84b620b4c21911d99530c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce12b5050be31cc15bb84b620b4c21911d99530c.camel@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeff,

On Fri, Oct 21, 2022 at 08:38:38AM -0400, Jeff Layton wrote:
> On Fri, 2022-10-21 at 16:49 +0800, Jingbo Xu wrote:
> > Use netfs_put_subrequest() and netfs_rreq_completed() completing request
> > and subrequest.
> > 
> > It is worth noting that a noop netfs_request_ops is introduced for erofs
> > since some netfs routine, e.g. netfs_free_request(), will call into
> > this ops.
> > 
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > ---
> >  fs/erofs/fscache.c | 47 ++++++++++------------------------------------
> >  1 file changed, 10 insertions(+), 37 deletions(-)
> > 
> > diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> > index fe05bc51f9f2..fa3f4ab5e3b6 100644
> > --- a/fs/erofs/fscache.c
> > +++ b/fs/erofs/fscache.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2022, Bytedance Inc. All rights reserved.
> >   */
> >  #include <linux/fscache.h>
> > +#include <trace/events/netfs.h>
> >  #include "internal.h"
> >  
> >  static DEFINE_MUTEX(erofs_domain_list_lock);
> > @@ -11,6 +12,8 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
> >  static LIST_HEAD(erofs_domain_list);
> >  static struct vfsmount *erofs_pseudo_mnt;
> >  
> > +static const struct netfs_request_ops erofs_noop_req_ops;
> > +
> >  static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
> >  					     loff_t start, size_t len)
> >  {
> > @@ -24,40 +27,12 @@ static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space
> >  	rreq->len	= len;
> >  	rreq->mapping	= mapping;
> >  	rreq->inode	= mapping->host;
> > +	rreq->netfs_ops	= &erofs_noop_req_ops;
> >  	INIT_LIST_HEAD(&rreq->subrequests);
> >  	refcount_set(&rreq->ref, 1);
> >  	return rreq;
> >  }
> >  
> 
> Why is erofs allocating its own netfs structures? This seems quite
> fragile, and a layering violation too.

Thanks for the reply.

I've talked this to David on IRC about this as well.  Actually what we
really want to use is to do raw I/O requests directly to
fscache/cachefiles.

Because as I said for many times, new netfs per-inode cookie model
doesn't suit for erofs use cases.  Since we treat each cookie as a
data blob, and each erofs inode can refer to one or more blobs in
the chunk-deduplicated way.

So we need a raw I/O data request to fscache/cachefiles.  I'm not sure
if it will also be a future feature request (raw I/O request on cookies)
for network fses in order to get some special file data/metadata.

> 
> > -static void erofs_fscache_put_request(struct netfs_io_request *rreq)
> > -{
> > -	if (!refcount_dec_and_test(&rreq->ref))
> > -		return;
> > -	if (rreq->cache_resources.ops)
> > -		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> > -	kfree(rreq);
> > -}
> > -
> > -static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *subreq)
> > -{
> > -	if (!refcount_dec_and_test(&subreq->ref))
> > -		return;
> > -	erofs_fscache_put_request(subreq->rreq);
> > -	kfree(subreq);
> > -}
> > -
> > -static void erofs_fscache_clear_subrequests(struct netfs_io_request *rreq)
> > -{
> > -	struct netfs_io_subrequest *subreq;
> > -
> > -	while (!list_empty(&rreq->subrequests)) {
> > -		subreq = list_first_entry(&rreq->subrequests,
> > -				struct netfs_io_subrequest, rreq_link);
> > -		list_del(&subreq->rreq_link);
> > -		erofs_fscache_put_subrequest(subreq);
> > -	}
> > -}
> > -
> >  static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
> >  {
> >  	struct netfs_io_subrequest *subreq;
> > @@ -114,11 +89,10 @@ static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rreq)
> >  static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
> >  {
> >  	erofs_fscache_rreq_unlock_folios(rreq);
> > -	erofs_fscache_clear_subrequests(rreq);
> > -	erofs_fscache_put_request(rreq);
> > +	netfs_rreq_completed(rreq, false);
> >  }
> >  
> > -static void erofc_fscache_subreq_complete(void *priv,
> > +static void erofs_fscache_subreq_complete(void *priv,
> >  		ssize_t transferred_or_error, bool was_async)
> >  {
> >  	struct netfs_io_subrequest *subreq = priv;
> > @@ -130,7 +104,7 @@ static void erofc_fscache_subreq_complete(void *priv,
> >  	if (atomic_dec_and_test(&rreq->nr_outstanding))
> >  		erofs_fscache_rreq_complete(rreq);
> >  
> > -	erofs_fscache_put_subrequest(subreq);
> > +	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_terminated);
> >  }
> >  
> >  /*
> > @@ -171,9 +145,8 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
> >  		}
> >  
> >  		subreq->start = pstart + done;
> > -		subreq->len	=  len - done;
> > +		subreq->len   =  len - done;
> >  		subreq->flags = 1 << NETFS_SREQ_ONDEMAND;
> > -
> >  		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> >  
> >  		source = cres->ops->prepare_read(subreq, LLONG_MAX);
> > @@ -184,7 +157,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
> >  				  source);
> >  			ret = -EIO;
> >  			subreq->error = ret;
> > -			erofs_fscache_put_subrequest(subreq);
> > +			netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
> >  			goto out;
> >  		}
> >  
> > @@ -195,7 +168,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
> >  
> >  		ret = fscache_read(cres, subreq->start, &iter,
> >  				   NETFS_READ_HOLE_FAIL,
> > -				   erofc_fscache_subreq_complete, subreq);
> > +				   erofs_fscache_subreq_complete, subreq);
> >  		if (ret == -EIOCBQUEUED)
> >  			ret = 0;
> >  		if (ret) {
> 
> I'd rather see this done differently. Either change erofs to use the
> netfs infrastructure in a more standard fashion, or maybe consider
> teaching erofs to talk to cachefiles directly?

I've requested David on IRC to shift netfs_io_request and
netfs_io_subrequest into a more natural new prefix other than
(netfs or fscache) but we didn't get into a proper conclusion (David
don't want to use fscache_ since fscache can be disabled but netfs
can still work.)

Like what we said for many times before, the reason why EROFS uses
fscache/cachefiles infrastructure is that we don't want to
duplicate/reinvent another same caching subsystem in order to manage
local caching in order to do lazy pulling / on-demand read, and the
majority code can be shared other than exist the same two codebases
to do the same thing, also:

content map: https://listman.redhat.com/archives/linux-cachefs/2022-August/007050.html

Also if we have the only one caching subsystem, the main codebase can
be tested better compared with two duplicated ones.

And I think overlayfs can also use it for partial copy up as anyone
interested.

> 
> IDK, but this sort of mucking around in the low level netfs objects
> seems wrong to me.

My suggestion is to abstract natural raw data interfaces for all fses
to use, rather than expose a per-inode cookie netfs interface only.

Thanks,
Gao Xiang

> -- 
> Jeff Layton <jlayton@kernel.org>
