Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E0496488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 18:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351614AbiAURxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 12:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350142AbiAURxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:53:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE59CC06173B;
        Fri, 21 Jan 2022 09:53:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BA3261B0D;
        Fri, 21 Jan 2022 17:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F25C340E1;
        Fri, 21 Jan 2022 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642787590;
        bh=ThQXA6SoRQU7Z3j3cfZ8hZaWXTx2O3dQBqVmVVdKdRg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z+uy9Nno6dBEZtnV5CHOdZas1aZMJ4hu9LnjqQjvnKAlaNXGPRY5wjkuKNH84yUfR
         LA6c/o2PmF1zZtyArrLUx2sAPUKDiuqggo7P1s5B3gtrZ8HAFIrlqoKIhtjKvPT0zr
         WDJTqrg8144wD16x9bPXIbWNxPO2ajo9hxmQnvQVgpopFUzI63HqEnkruxwGG5Nd/6
         Ul3wLwr6jSBpxfaT5fgO3GP5I3x+UxV7PAsjAs5xOX1hRBEF7f3jMRSvWEu8VpNOgI
         xvLjpqyi9VR+Je3dQAxxU57a+G0JMlFCA+Ipa2DQ9DnrdYrg5cHS1lXu5dm6m7SFel
         3WV98pUOeYZOw==
Message-ID: <952f31150513af64ca5ccbb440d1e0ca88a37900.camel@kernel.org>
Subject: Re: [PATCH 05/11] cachefiles: Trace active-mark failure
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Jan 2022 12:53:08 -0500
In-Reply-To: <164251404666.3435901.17331742792401482190.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
         <164251404666.3435901.17331742792401482190.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-01-18 at 13:54 +0000, David Howells wrote:
> Add a tracepoint to log failure to apply an active mark to a file in
> addition to tracing successfully setting and unsetting the mark.
> 
> Also include the backing file inode number in the message logged to dmesg.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/cachefiles/namei.c             |    4 +++-
>  include/trace/events/cachefiles.h |   21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 52c9f0864a87..f256c8aff7bb 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -25,7 +25,9 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
>  		trace_cachefiles_mark_active(object, inode);
>  		can_use = true;
>  	} else {
> -		pr_notice("cachefiles: Inode already in use: %pd\n", dentry);
> +		trace_cachefiles_mark_failed(object, inode);
> +		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
> +			  dentry, inode->i_ino);
>  	}
>  
>  	return can_use;
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
> index 093c4acb7a3a..c6f5aa74db89 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -573,6 +573,27 @@ TRACE_EVENT(cachefiles_mark_active,
>  		      __entry->obj, __entry->inode)
>  	    );
>  
> +TRACE_EVENT(cachefiles_mark_failed,
> +	    TP_PROTO(struct cachefiles_object *obj,
> +		     struct inode *inode),
> +
> +	    TP_ARGS(obj, inode),
> +
> +	    /* Note that obj may be NULL */
> +	    TP_STRUCT__entry(
> +		    __field(unsigned int,		obj		)
> +		    __field(ino_t,			inode		)
> +			     ),
> +
> +	    TP_fast_assign(
> +		    __entry->obj	= obj ? obj->debug_id : 0;
> +		    __entry->inode	= inode->i_ino;
> +			   ),
> +
> +	    TP_printk("o=%08x B=%lx",
> +		      __entry->obj, __entry->inode)
> +	    );
> +
>  TRACE_EVENT(cachefiles_mark_inactive,
>  	    TP_PROTO(struct cachefiles_object *obj,
>  		     struct inode *inode),
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
