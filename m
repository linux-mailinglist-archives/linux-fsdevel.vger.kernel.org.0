Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EFE2B7DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 13:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgKRMso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 07:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKRMso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:48:44 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE84C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 04:48:44 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9480DC009; Wed, 18 Nov 2020 13:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1605703721; bh=PODBhYa4eqg5SsAKwLi7N4d6sQhfEDKLSvLvLhMBzfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5tNWIk2VSS8T7V29HtJ3Qe38OORtBVjP6d7WLgio1ZTJqNjCGTdcuQETm3400mnb
         ujbzmA8DLrZOk1zQyhw1i+Jy+bcbXhCSLOAM01SVMIeqCcAGnUQsyPKUcVD3sf4R+c
         pvrm4yShO0Yri3Dbc7k95D9L7W8Rgv9qlOwMifSXq2w/eK4ydyZ+2vHQfmxLdBBYKL
         aP4MW1E5txB5a3x4T8RiFx9/thhhCOlTHcOC0k9MivfcJvKeZjbg79vR5FC6od2rPw
         Adq/z8iYcQC7/AXwYjI9gAnAvw0SbTrYBB4+JBfPjmJS0trNp0fbTGqsdZjaP1901G
         BuVCHT6ucmKQw==
Date:   Wed, 18 Nov 2020 13:48:26 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: Convert to new fscache API
Message-ID: <20201118124826.GA17850@nautica>
References: <1514086.1605697347@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1514086.1605697347@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote on Wed, Nov 18, 2020:
> Here's a rough draft of a patch to convert 9P to use the rewritten fscache
> API.  It compiles, but I've no way to test it.  This is built on top of my
> fscache-iter branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

Thanks, I'm ashamed I hadn't found time to work on this it's a great
help.
I can get some test running with this.

What's the current schedule/plan for the fscache branch merging? Will
you be trying this merge window next month?

Couple more questions below

> Notes:
> 
>  (*) I've switched to use ITER_XATTR rather than ITER_BVEC in some places.
> 
>  (*) I've added a pair of helper functions to get the cookie:
> 
> 	v9fs_inode_cookie()
> 	v9fs_session_cache()
> 
>      These return NULL if CONFIG_9P_FSCACHE=n.
> 
>  (*) I've moved some of the fscache accesses inline.  Using the above helper
>      functions, it all compiles away due to NULL pointer checks in the header
>      file if fscache is disabled.
> 
>  (*) 9P's readpage and readpages now just jump into the netfs helpers, as does
>      write_begin.  v9fs_req_issue_op() initiates the I/O on behalf of the
>      helpers.
> 
>  (*) v9fs_write_begin() now returns the subpage and v9fs_write_end() goes back
>      out to the head page.  thp_size() is also used.  This should mean you
>      handle transparent huge pages (THPs) and can turn that on.
> 
>  (*) I have made an assumption that 9p_client_read() and write can handle I/Os
>      larger than a page.  If this is not the case, v9fs_req_ops will need
>      clamp_length() implementing.

There's a max driven by the client's msize (client->msize - P9_IOHDRSZ ;
unfortunately msize is just guaranted to be >= 4k so that means the
actual IO size would be smaller in that case even if that's not intended
to be common)

>  (*) The expand_readahead() and clamp_length() ops should perhaps be
>      implemented to align and trim with respect to maximum I/O size.
> 
>  (*) iget and evict acquire and relinquish a cookie.
> 
>  (*) open and release use and unuse that cookie.
> 
>  (*) writepage writes the dirty data to the cache.
> 
>  (*) setattr resizes the cache if necessary.
> 
>  (*) The cache needs to be invalidated if a 3rd-party change happens, but I
>      haven't done that.

There's no concurrent access logic in 9p as far as I'm aware (like NFS
does if the mtime changes for example), so I assume we can keep ignoring
this.

>  (*) With these changes, 9p should cache local changes too, not just data
>      read.
> 
>  (*) If 9p supports DIO writes, it should invalidate a cache object with
>      FSCACHE_INVAL_DIO_WRITE when one happens - thereby stopping caching for
>      that file until all file handles on it are closed.

Not 100% sure actually there is some code about it but comment says it's
disabled when cache is active; I'll check just found another problem
with some queued patch that need fixing first...

> I forgot something: netfs_subreq_terminated() needs to be called when
> the read is complete.  If p9_client_read() is synchronous, then that
> would be here,

(it is synchronous; I'll add that suggestion)

-- 
Dominique
