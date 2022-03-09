Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D4E4D320F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 16:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiCIPqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 10:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiCIPqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:46:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B895711597B;
        Wed,  9 Mar 2022 07:45:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530FE60A64;
        Wed,  9 Mar 2022 15:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42702C340E8;
        Wed,  9 Mar 2022 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646840753;
        bh=JcjbwficnT5HSFxU++0rxH+SOkMYh+Q/0GQjWeHYYts=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PisR0LQ5zQVYJyJ484puq/l3orA8rvxQrD4771IojLnRjsqCTRTHweABN+VGnMjAN
         CiPoqBnQM62mUDCNH/trKobaxotcS+yb3tlZ3tq66fhukeWbN0s4X7makoWuk+6b25
         7egYjezt0hXbp7LcNo9cCJvmA7y49ynJPIYO+x4h5VcxE9q9sxP34KgQ6+pVQQj250
         H2KMKjC3byDuR8DSo2TKNYLZqkfSlQeTwxJloHGPabWMwTGUtDl26I0HkqMFmBxTW5
         sU1HI+g2uQmSugdfn0eK1EvP9G+bNm7Xcj8jfhskRGZAFGZjSQmXc+TPKVbUkmCIoM
         cbuoLdQfEeeVg==
Message-ID: <9763458f708e3021f7606cfdb4c578f2591b9bd7.camel@kernel.org>
Subject: Re: [PATCH v2 06/19] netfs: Adjust the netfs_rreq tracepoint
 slightly
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
Date:   Wed, 09 Mar 2022 10:45:51 -0500
In-Reply-To: <164678199468.1200972.17275585970238114726.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678199468.1200972.17275585970238114726.stgit@warthog.procyon.org.uk>
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
> Adjust the netfs_rreq tracepoint to include the origin of the request and
> to increase the size of the "what trace" output strings by a character so
> that "ENCRYPT" and "DECRYPT" will fit without abbreviation.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> 
> Link: https://lore.kernel.org/r/164622996715.3564931.4252319907990358129.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  fs/netfs/read_helper.c       |    2 +-
>  include/trace/events/netfs.h |   18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index ef23ef9889d5..181aeda32649 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -181,7 +181,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
>  	struct iov_iter iter;
>  	int ret;
>  
> -	trace_netfs_rreq(rreq, netfs_rreq_trace_write);
> +	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
>  
>  	/* We don't want terminating writes trying to wake us up whilst we're
>  	 * still going through the list.
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 2d0665b416bf..daf171de2142 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -22,13 +22,13 @@
>  	E_(netfs_read_trace_write_begin,	"WRITEBEGN")
>  
>  #define netfs_rreq_traces					\
> -	EM(netfs_rreq_trace_assess,		"ASSESS")	\
> -	EM(netfs_rreq_trace_done,		"DONE  ")	\
> -	EM(netfs_rreq_trace_free,		"FREE  ")	\
> -	EM(netfs_rreq_trace_resubmit,		"RESUBM")	\
> -	EM(netfs_rreq_trace_unlock,		"UNLOCK")	\
> -	EM(netfs_rreq_trace_unmark,		"UNMARK")	\
> -	E_(netfs_rreq_trace_write,		"WRITE ")
> +	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
> +	EM(netfs_rreq_trace_copy,		"COPY   ")	\
> +	EM(netfs_rreq_trace_done,		"DONE   ")	\
> +	EM(netfs_rreq_trace_free,		"FREE   ")	\
> +	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
> +	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
> +	E_(netfs_rreq_trace_unmark,		"UNMARK ")
>  
>  #define netfs_sreq_sources					\
>  	EM(NETFS_FILL_WITH_ZEROES,		"ZERO")		\
> @@ -134,7 +134,7 @@ TRACE_EVENT(netfs_rreq,
>  
>  	    TP_STRUCT__entry(
>  		    __field(unsigned int,		rreq		)
> -		    __field(unsigned short,		flags		)
> +		    __field(unsigned int,		flags		)
>  		    __field(enum netfs_rreq_trace,	what		)
>  			     ),
>  
> @@ -182,8 +182,8 @@ TRACE_EVENT(netfs_sreq,
>  
>  	    TP_printk("R=%08x[%u] %s %s f=%02x s=%llx %zx/%zx e=%d",
>  		      __entry->rreq, __entry->index,
> -		      __print_symbolic(__entry->what, netfs_sreq_traces),
>  		      __print_symbolic(__entry->source, netfs_sreq_sources),
> +		      __print_symbolic(__entry->what, netfs_sreq_traces),
>  		      __entry->flags,
>  		      __entry->start, __entry->transferred, __entry->len,
>  		      __entry->error)
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
