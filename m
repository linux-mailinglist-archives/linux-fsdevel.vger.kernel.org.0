Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF57486721
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiAFPzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 10:55:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55946 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiAFPzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:55:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 523EC61CCD;
        Thu,  6 Jan 2022 15:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA9EC36AED;
        Thu,  6 Jan 2022 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641484515;
        bh=Zs49UM4op7FhcCag8kpRl0gmJmPkQMG6LyUseoRbg+0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u/X2RYkCkXWlEbdzZylMfFjFSEVyRT5Ca3qVn7cp9C12kkSDpjgzNfNvUmOCIJizx
         DommcboOU+mfgMmoOi08pZRyP+WiWUHP2RIG7uehFtB1oWZtypyF8sWK4S/xTD38sh
         Y1XgFY7Ix5jLFUTR/9KYwRCm4cHtFN4stWf7TxUjUkUiy5DK4m/VEiFiF0MUQQtwM5
         CO6xPJVth9K2ogc2C0OdzBJPzd9r7HwWMa3eqeonRWKWg2fW5fpAghr2pKvhzexsb+
         afyqg3LXWlrEtyE5ww0K0lsmykZcj63W0+M+mg0S4X+1a8SAezzwD6LHmxXCGzt6RL
         uY4rs4xgdqKUA==
Message-ID: <043a206f03929c2667a465314144e518070a9b2d.camel@kernel.org>
Subject: Re: [PATCH v4 28/68] fscache: Provide a function to note the
 release of a page
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
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
Date:   Thu, 06 Jan 2022 10:55:12 -0500
In-Reply-To: <164021525963.640689.9264556596205140044.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
         <164021525963.640689.9264556596205140044.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-12-22 at 23:20 +0000, David Howells wrote:
> Provide a function to be called from a network filesystem's releasepage
> method to indicate that a page has been released that might have been a
> reflection of data upon the server - and now that data must be reloaded
> from the server or the cache.
> 
> This is used to end an optimisation for empty files, in particular files
> that have just been created locally, whereby we know there cannot yet be
> any data that we would need to read from the server or the cache.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/163819617128.215744.4725572296135656508.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/163906920354.143852.7511819614661372008.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/163967128061.1823006.611781655060034988.stgit@warthog.procyon.org.uk/ # v3
> ---
> 
>  include/linux/fscache.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index 18e725671594..28ce258c1f87 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -607,4 +607,20 @@ static inline void fscache_clear_inode_writeback(struct fscache_cookie *cookie,
>  	}
>  }
>  
> +/**
> + * fscache_note_page_release - Note that a netfs page got released
> + * @cookie: The cookie corresponding to the file
> + *
> + * Note that a page that has been copied to the cache has been released.  This
> + * means that future reads will need to look in the cache to see if it's there.
> + */
> +static inline
> +void fscache_note_page_release(struct fscache_cookie *cookie)
> +{
> +	if (cookie &&
> +	    test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> +	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> +		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
> +}
> +
>  #endif /* _LINUX_FSCACHE_H */
> 
> 

Is this logic correct?

FSCACHE_COOKIE_HAVE_DATA gets set in cachefiles_write_complete, but will
that ever be called on a cookie that has no data? Will we ever call
cachefiles_write at all when there is no data to be written?

--
Jeff Layton <jlayton@kernel.org>
