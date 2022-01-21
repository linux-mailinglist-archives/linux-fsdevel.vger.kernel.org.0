Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C18496477
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbiAURve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 12:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbiAURvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:51:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9381AC06173D;
        Fri, 21 Jan 2022 09:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1CD6CE2421;
        Fri, 21 Jan 2022 17:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DBCC340E1;
        Fri, 21 Jan 2022 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642787490;
        bh=tYe2qeyG3K8Ybask+5r18i3T0TXGMZtvCPQR9mEQiGg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e0/S6Uu1IgSh1ZWOBTOoulHrURo3/79rcEeGLtCgQ2sUCKPfa7edjdBmPYBhJf5Y/
         hK4Hb4VP2POLuuDOe1GG8yg9UP8wRTeiL96e+Tv6l2EI21tkswFqMm0sSEBwhGxjsu
         tchWZJleK06F8U/2mVC9rEG0sfWnWROnuhne0/vmZ4qzljjQBXhQtDY/l/oG9WKQ2R
         9DJ7QyUBxBmU9m1N8E41t4+RJE3GkZ9wSNO9JHYizhjSceHUX3cu3X6LM5CtQTgxs2
         13IJ5FlEvIgHPsCL/ZfLtGPQWgWTl8KBis89xvXqOO1Kse6bjnmEJO+4b6Zwvr2Ne2
         Hv3b24ePSPGcQ==
Message-ID: <d99c4042fa900187b179b9087981b25c22edd645.camel@kernel.org>
Subject: Re: [PATCH 03/11] cachefiles: set default tag name if it's
 unspecified
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Jan 2022 12:51:27 -0500
In-Reply-To: <164251399914.3435901.4761991152407411408.stgit@warthog.procyon.org.uk>
References: <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk>
         <164251399914.3435901.4761991152407411408.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-01-18 at 13:53 +0000, David Howells wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> fscache_acquire_cache() requires a non-empty name, while 'tag <name>'
> command is optional for cachefilesd.
> 
> Thus set default tag name if it's unspecified to avoid the regression of
> cachefilesd. The logic is the same with that before rewritten.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/cachefiles/daemon.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 40a792421fc1..7ac04ee2c0a0 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -703,6 +703,17 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
>  		return -EBUSY;
>  	}
>  
> +	/* Make sure we have copies of the tag string */
> +	if (!cache->tag) {
> +		/*
> +		 * The tag string is released by the fops->release()
> +		 * function, so we don't release it on error here
> +		 */
> +		cache->tag = kstrdup("CacheFiles", GFP_KERNEL);
> +		if (!cache->tag)
> +			return -ENOMEM;
> +	}
> +
>  	return cachefiles_add_cache(cache);
>  }
>  
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
