Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2813D1551
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 19:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhGURDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 13:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229948AbhGURDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626889430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dOn7+nrEQrDF2IcT4kr/9MG9FoA4OKzs2zFSvE50Nw=;
        b=TzH38iu4sbKjMeSzIj4A9hkBCxoOWBslcRg9QjkKIzPbXnlYxN131oqdv1/qQTw66TXhtR
        lkccyP9TpFdWluBEwEpqWirqyCohCNUlYVm5kpKh4woyj/ZKYEjofNVkIAS8HBWN7+kjZS
        DqKMAeF/ptjBkBU1qD4DrvfcCWRqMNg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-4g7dj1IOP-eEHSP2jR34vw-1; Wed, 21 Jul 2021 13:43:49 -0400
X-MC-Unique: 4g7dj1IOP-eEHSP2jR34vw-1
Received: by mail-qk1-f199.google.com with SMTP id y16-20020a05620a0e10b02903b8f9d28c19so2172169qkm.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 10:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3dOn7+nrEQrDF2IcT4kr/9MG9FoA4OKzs2zFSvE50Nw=;
        b=SQVLDdR5kUn1/ttID1GRzy1fwr+IPWtLaRYJQ4IPUfZcVg5FIh11o4cz3E9VO5tEi3
         MekATG7ZcJRJfdtQtjDw27L9XYfFtdg7RmqkbDgOhYB55DYloUl5R8iH63yUyiZ7MmfO
         9YAXMvf/6OfcmfqxBmJUWQtIABehb9NQNmUxbIxKUHydsKhMi2/vyPz2d1+GcXaVu3qd
         t3PeW/7q7GbdwlxYP4j+5T1Gqs0QnK5dAhXlbQMJTPAYORjEUEqJ1E3SK0e46h6qFFU9
         EiQKonnpPZfXmM6H/4L2ReQ93Iz/TYeNpuG2E/E9i32l/LT67eRZXPv60VBgDUwWZhuH
         iG0w==
X-Gm-Message-State: AOAM531H5UQv9Zk8cM8zPeqJF15I5SUrVlWiyjsPK5IvWRTOFwoOz+6d
        Dl3/SjjQ3/thzTHawrInUS70DFBjmEmouuwejwGaP5/rAfkDgqykKJexQuCagY9wH03NUUbUZWJ
        4e9XRn801/Jqj4gwHHGDe897WlQ==
X-Received: by 2002:a05:622a:1653:: with SMTP id y19mr18163566qtj.305.1626889428564;
        Wed, 21 Jul 2021 10:43:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy73QoeXgeoF1lBpX1Vc7kQ/yjCgrGxg1ygCZQ38G6t9sqd8L74fPzeKuZd3aAUpkrFW+V2/g==
X-Received: by 2002:a05:622a:1653:: with SMTP id y19mr18163539qtj.305.1626889428351;
        Wed, 21 Jul 2021 10:43:48 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id r16sm11484664qke.73.2021.07.21.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:43:47 -0700 (PDT)
Message-ID: <e7a3b850e8a42845f4e020c7642743b3dce2b9f1.camel@redhat.com>
Subject: Re: [RFC PATCH 03/12] netfs: Remove
 netfs_read_subrequest::transferred
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 13:43:47 -0400
In-Reply-To: <162687511125.276387.15493860267582539643.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
         <162687511125.276387.15493860267582539643.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-21 at 14:45 +0100, David Howells wrote:
> Remove netfs_read_subrequest::transferred as it's redundant as the count on
> the iterator added to the subrequest can be used instead.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/afs/file.c                |    4 ++--
>  fs/netfs/read_helper.c       |   26 ++++----------------------
>  include/linux/netfs.h        |    1 -
>  include/trace/events/netfs.h |   12 ++++++------
>  4 files changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index ca529f23515a..82e945dbe379 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -315,8 +315,8 @@ static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
>  		return netfs_subreq_terminated(subreq, -ENOMEM, false);
>  
>  	fsreq->subreq	= subreq;
> -	fsreq->pos	= subreq->start + subreq->transferred;
> -	fsreq->len	= subreq->len   - subreq->transferred;
> +	fsreq->pos	= subreq->start + subreq->len - iov_iter_count(&subreq->iter);
> +	fsreq->len	= iov_iter_count(&subreq->iter);
>  	fsreq->key	= subreq->rreq->netfs_priv;
>  	fsreq->vnode	= vnode;
>  	fsreq->iter	= &subreq->iter;
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 715f3e9c380d..5e1a9be48130 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -148,12 +148,7 @@ static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
>   */
>  static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
>  {
> -	struct iov_iter iter;
> -
> -	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
> -			subreq->start + subreq->transferred,
> -			subreq->len   - subreq->transferred);
> -	iov_iter_zero(iov_iter_count(&iter), &iter);
> +	iov_iter_zero(iov_iter_count(&subreq->iter), &subreq->iter);
>  }
>  
>  static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
> @@ -173,14 +168,9 @@ static void netfs_read_from_cache(struct netfs_read_request *rreq,
>  				  bool seek_data)
>  {
>  	struct netfs_cache_resources *cres = &rreq->cache_resources;
> -	struct iov_iter iter;
>  
>  	netfs_stat(&netfs_n_rh_read);
> -	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
> -			subreq->start + subreq->transferred,
> -			subreq->len   - subreq->transferred);
> -
> -	cres->ops->read(cres, subreq->start, &iter, seek_data,
> +	cres->ops->read(cres, subreq->start, &subreq->iter, seek_data,
>  			netfs_cache_read_terminated, subreq);
>  }
>  

The above two deltas seem like they should have been in patch #2.

> @@ -419,7 +409,7 @@ static void netfs_rreq_unlock(struct netfs_read_request *rreq)
>  			if (pgend < iopos + subreq->len)
>  				break;
>  
> -			account += subreq->transferred;
> +			account += subreq->len - iov_iter_count(&subreq->iter);
>  			iopos += subreq->len;
>  			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
>  				subreq = list_next_entry(subreq, rreq_link);
> @@ -635,15 +625,8 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
>  		goto failed;
>  	}
>  
> -	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
> -		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
> -		 rreq->debug_id, subreq->debug_index,
> -		 transferred_or_error, subreq->len, subreq->transferred))
> -		transferred_or_error = subreq->len - subreq->transferred;
> -
>  	subreq->error = 0;
> -	subreq->transferred += transferred_or_error;
> -	if (subreq->transferred < subreq->len)
> +	if (iov_iter_count(&subreq->iter))
>  		goto incomplete;
>  

I must be missing it, but where does subreq->iter get advanced to the
end of the current read? If you're getting rid of subreq->transferred
then I think that has to happen above, no?

>  complete:
> @@ -667,7 +650,6 @@ void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
>  incomplete:
>  	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
>  		netfs_clear_unread(subreq);
> -		subreq->transferred = subreq->len;
>  		goto complete;
>  	}
>  
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 5e4fafcc9480..45d40c622205 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -116,7 +116,6 @@ struct netfs_read_subrequest {
>  	struct iov_iter		iter;		/* Iterator for this subrequest */
>  	loff_t			start;		/* Where to start the I/O */
>  	size_t			len;		/* Size of the I/O */
> -	size_t			transferred;	/* Amount of data transferred */
>  	refcount_t		usage;
>  	short			error;		/* 0 or error that occurred */
>  	unsigned short		debug_index;	/* Index in list (for debugging output) */
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 4d470bffd9f1..04ac29fc700f 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -190,7 +190,7 @@ TRACE_EVENT(netfs_sreq,
>  		    __field(enum netfs_read_source,	source		)
>  		    __field(enum netfs_sreq_trace,	what		)
>  		    __field(size_t,			len		)
> -		    __field(size_t,			transferred	)
> +		    __field(size_t,			remain		)
>  		    __field(loff_t,			start		)
>  			     ),
>  
> @@ -202,7 +202,7 @@ TRACE_EVENT(netfs_sreq,
>  		    __entry->source	= sreq->source;
>  		    __entry->what	= what;
>  		    __entry->len	= sreq->len;
> -		    __entry->transferred = sreq->transferred;
> +		    __entry->remain	= iov_iter_count(&sreq->iter);
>  		    __entry->start	= sreq->start;
>  			   ),
>  
> @@ -211,7 +211,7 @@ TRACE_EVENT(netfs_sreq,
>  		      __print_symbolic(__entry->what, netfs_sreq_traces),
>  		      __print_symbolic(__entry->source, netfs_sreq_sources),
>  		      __entry->flags,
> -		      __entry->start, __entry->transferred, __entry->len,
> +		      __entry->start, __entry->len - __entry->remain, __entry->len,
>  		      __entry->error)
>  	    );
>  
> @@ -230,7 +230,7 @@ TRACE_EVENT(netfs_failure,
>  		    __field(enum netfs_read_source,	source		)
>  		    __field(enum netfs_failure,		what		)
>  		    __field(size_t,			len		)
> -		    __field(size_t,			transferred	)
> +		    __field(size_t,			remain		)
>  		    __field(loff_t,			start		)
>  			     ),
>  
> @@ -242,7 +242,7 @@ TRACE_EVENT(netfs_failure,
>  		    __entry->source	= sreq ? sreq->source : NETFS_INVALID_READ;
>  		    __entry->what	= what;
>  		    __entry->len	= sreq ? sreq->len : 0;
> -		    __entry->transferred = sreq ? sreq->transferred : 0;
> +		    __entry->remain	= sreq ? iov_iter_count(&sreq->iter) : 0;
>  		    __entry->start	= sreq ? sreq->start : 0;
>  			   ),
>  
> @@ -250,7 +250,7 @@ TRACE_EVENT(netfs_failure,
>  		      __entry->rreq, __entry->index,
>  		      __print_symbolic(__entry->source, netfs_sreq_sources),
>  		      __entry->flags,
> -		      __entry->start, __entry->transferred, __entry->len,
> +		      __entry->start, __entry->len - __entry->remain, __entry->len,
>  		      __print_symbolic(__entry->what, netfs_failures),
>  		      __entry->error)
>  	    );
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>

