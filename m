Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01B413253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhIULRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIULRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:17:13 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA4C061574;
        Tue, 21 Sep 2021 04:15:44 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B3B01C020; Tue, 21 Sep 2021 13:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1632222942; bh=YyXbeloQrhrw5B3tSpqOK4BxPhPDbk/o6nxun6d3Bl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txM5knXUmgdiPvtTmpw4zO4tPHpwpgHZMKnHUXxi7T6YBuyrhRUjwj+BsqeNX0y9t
         bxnz5dh6OTQF3uGj6dWcZ9O6MspbfiT3+Nia+wMxoOBcskqTbuPo+mlm09cePXZaIO
         Qm9ozDUoPjS/c/dUiDULM1Bc9aOAVscCmqmfafjF4plG7GHmZymFb4JijP1GteZpn4
         +u9r/jl5rbMBXzenZ2HboIqAwH1fqVo2iiDCh6EXyuDFN32VMVnYDoBe2FZpgfG7oM
         6wk2/FatqZ+nDLNcf16iH0IDa2O2KzSSq1bJ7omYkqP6yDOU2/zXsSCPwWhGy//vdc
         d46+jdfXPcBUA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 337E1C009;
        Tue, 21 Sep 2021 13:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1632222941; bh=YyXbeloQrhrw5B3tSpqOK4BxPhPDbk/o6nxun6d3Bl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T77mTADz4tV4QYfANvTTm3k3xcptdXeQ9WoFltTUHTVtiveOQgR0TNOjfApkMQOiW
         PzoR3lc2uu9+nijFJTBlxpFfm+MtGhjw+QFajAu4oqJMuh597ho5MuYpXmXtF6jqWS
         +0MvIdqojrxKULuD9y0ZVVh9m8kSYK/AwfZrTd99qheKVPrjKx9h8igsv7bwNPN2aD
         0i+uPHyeyDkAEQGA2mRN1l1HHpviFwZtYe7f50vDtWmHOcSkhq0pETPizQvXorMrUl
         1iM+0ONtA2cZ4k9F/UU/PLNEZQzr5zt1FAeiHgADd9w9v4wd/0OED+QAa811ItQyv2
         uIu/GYrwN5z0g==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a7c0d52c;
        Tue, 21 Sep 2021 11:15:33 +0000 (UTC)
Date:   Tue, 21 Sep 2021 20:15:18 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] 9p: (untested) Convert to using the netfs helper lib
 to do reads and caching
Message-ID: <YUm+xucHxED+1MJp@codewreck.org>
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
 <163162772646.438332.16323773205855053535.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163162772646.438332.16323773205855053535.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Tue, Sep 14, 2021 at 02:55:26PM +0100:
> 9p: (untested) Convert to using the netfs helper lib to do reads and caching

Finally tested to some extent: let's remove that (untested) tag.


> Convert the 9p filesystem to use the netfs helper lib to handle readpage,
> readahead and write_begin, converting those into a common issue_op for the
> filesystem itself to handle.  The netfs helper lib also handles reading
> from fscache if a cache is available, and interleaving reads from both
> sources.
> 
> This change also switches from the old fscache I/O API to the new one,
> meaning that fscache no longer keeps track of netfs pages and instead does
> async DIO between the backing files and the 9p file pagecache.  As a part
> of this change, the handling of PG_fscache changes.  It now just means that
> the cache has a write I/O operation in progress on a page (PG_locked
> is used for a read I/O op).
> 
> Note that this is a cut-down version of the fscache rewrite and does not
> change any of the cookie and cache coherency handling.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dominique Martinet <asmadeus@codewreck.org>

can add either my sob or a reviewed-by tag from me instead.
I'm honestly not familiar enough with some of the changes (parts
checking PAGE_SIZE or similar) but I didn't spot any obvious error
except the few ifdefs I commented on below, and will keep running a few
more tests until next merge window.

> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/9p/Kconfig    |    1 
>  fs/9p/cache.c    |  137 -------------------------------------------
>  fs/9p/cache.h    |   99 +------------------------------
>  fs/9p/v9fs.h     |    9 +++
>  fs/9p/vfs_addr.c |  174 ++++++++++++++++++++++++------------------------------
>  fs/9p/vfs_file.c |   21 +++++--
>  6 files changed, 108 insertions(+), 333 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index cce9ace651a2..a7e080916826 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -124,7 +117,14 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
>  {
>  	if (PagePrivate(page))
>  		return 0;
> -	return v9fs_fscache_release_page(page, gfp);
> +#ifdef CONFIG_AFS_FSCACHE

s/AFS/9P/

> +	if (PageFsCache(page)) {
> +		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
> +			return 0;
> +		wait_on_page_fscache(page);
> +	}
> +#endif
> +	return 1;
>  }
>  
>  /**
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index aab5e6538660..4b617d10cf28 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -542,14 +542,27 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	p9_debug(P9_DEBUG_VFS, "page %p fid %lx\n",
>  		 page, (unsigned long)filp->private_data);
>  
> +	v9inode = V9FS_I(inode);
> +
> +	/* Wait for the page to be written to the cache before we allow it to
> +	 * be modified.  We then assume the entire page will need writing back.
> +	 */
> +#ifdef CONFIG_V9FS_FSCACHE

s/V9FS/9P/


-- 
Dominique
