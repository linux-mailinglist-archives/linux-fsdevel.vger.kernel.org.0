Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644802331DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgG3MQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgG3MQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:16:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD88C061794;
        Thu, 30 Jul 2020 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GuSgBCY5Dc+vZPEZj8RCz93A4JYgZmNr3NqXQV1PNYU=; b=a7GCCI+Sq/NXl6y3iQLleRnLms
        4p1ZsjInJKj/tAsDpcjI9usZM2vENPG03Df+sSsNojrv4V1EBT3j/wFU5/RBzQbJ3/l7PJs6gs6wF
        KvMrbG1qCvxYYQzyjA+rd2mVdNqtu69fgGCmUxDcA0RgS0og/RM9yM94JvkDJKFpuRee0vYNFOCsj
        eIut78fgYXyBEr7Kb1rNIa6xqLVa4ibM/5Ak08hEKjq3YHCiAEjyb2MEXtAZyXxOh9m0FVN6dax9i
        2yquBpLaOry0D0qgZd4Jj4uVCYZwyhrpcaUPuA9nI+bcdLL3RQRs7hH1muyyDrTPpdvxlanB3eUMs
        K6nwbsWA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k17Ty-0003OY-Jv; Thu, 30 Jul 2020 12:16:22 +0000
Date:   Thu, 30 Jul 2020 13:16:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Upcoming: fscache rewrite
Message-ID: <20200730121622.GB23808@casper.infradead.org>
References: <447452.1596109876@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447452.1596109876@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 12:51:16PM +0100, David Howells wrote:
>  (3) Al has objections to the ITER_MAPPING iov_iter type that I added
> 
> 	https://lore.kernel.org/linux-fsdevel/20200719014436.GG2786714@ZenIV.linux.org.uk/
> 
>      but note that iov_iter_for_each_range() is not actually used by anything.
> 
>      However, Willy likes it and would prefer to make it ITER_XARRAY instead
>      as he might be able to use it in other places, though there's an issue
>      where I'm calling find_get_pages_contig() which takes a mapping (though
>      all it does is then get the xarray out of it).

I suspect you don't need to call find_get_pages_contig().  If you look
at __readahead_batch() in pagemap.h, it does basically what you want
(other than being wrapped up inside the readahead iterator).  You require
the pages already be pinned in the xarray, so there's no need for the
page_cache_get_speculative() dance that find_get_pages_contig) does,
nor the check for xa_is_value().

My main concern with your patchset is that it introduces a new page flag
to sleep on which basically means "I am writing this page to the fscache".
I don't understand why you need it; you've elevated the refcount on
the pages so they're not going to get reused for another purpose.
All it does (as far as I can tell) is make a task calling truncate()
wait for the page to finish being written to cache, which isn't actually
necessary.

Overall, I do like the patch series!  It's a big improvement over what we
currently have and will make it easier to finish the readpages->readahead
conversion.
