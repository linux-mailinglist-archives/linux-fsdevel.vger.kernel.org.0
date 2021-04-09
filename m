Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F13C359DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhDILqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDILqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:46:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2970C061760;
        Fri,  9 Apr 2021 04:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c1r8qKf2WZUBFC6KK+MUpMLPvRW0EBtQK/vl4+qTDxg=; b=NOPeCLY4PZdlE1Sl+vERrsPYCI
        kaU09fmm4qGEaxVbWWYfFtOZ0dfLZ0wlHt1TzAnVRj0Z2OnnJiJQ0JujMFGZxOCpvd+X6kmCbo3AS
        s5+ioH0yGL6LgNWu2HItUFI8XLwGijzp9kyjepKmcaUnw64YW8EIvsTg/nnJn/u6n330Gve2P9cwj
        rXMtz0FIN995Nc8299Q4VfAqFO+HJOxpNwc+t30qega9f7aXSdDzrTspNvtwCRTmQ5YA6Ul7BgXXa
        UlbaHzCLXvvLEl1pr2Gck45gORD7uhzGD0ESWrGa2jpa3n0HxAGKyWlmP+ZsmPzLNoVPdMTj/I6Rm
        mdx5vNFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUpZI-000Iht-4A; Fri, 09 Apr 2021 11:45:05 +0000
Date:   Fri, 9 Apr 2021 12:44:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/30] iov_iter: Add ITER_XARRAY
Message-ID: <20210409114456.GT2531743@casper.infradead.org>
References: <YG+s0iw5o91KQIlW@zeniv-ca.linux.org.uk>
 <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
 <161789064740.6155.11932541175173658065.stgit@warthog.procyon.org.uk>
 <289825.1617959345@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <289825.1617959345@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 10:09:05AM +0100, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > > +#define iterate_all_kinds(i, n, v, I, B, K, X) {		\
> > 
> > Do you have any users that would pass different B and X?
> > 
> > > @@ -1440,7 +1665,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> > >  		return v.bv_len;
> > >  	}),({
> > >  		return -EFAULT;
> > > -	})
> > > +	}), 0
> > 
> > Correction - users that might get that flavour.  This one explicitly checks
> > for xarray and doesn't get to iterate_... in that case.
> 
> This is the case for iterate_all_kinds(), but not for iterate_and_advance().
> 
> See _copy_mc_to_iter() for example: that can return directly out of the middle
> of the loop, so the X variant must drop the rcu_read_lock(), but the B variant
> doesn't need to.  You also can't just use break to get out as the X variant
> has a loop within a loop to handle iteration over the subelements of a THP.

"Why does it need a loop? bvecs can contain multi-page vectors"
"memcpy_from_page can't handle that"
"doesn't that mean that iterating over a bvec is already broken?"
"yes"
