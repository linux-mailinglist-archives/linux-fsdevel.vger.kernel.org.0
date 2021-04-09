Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED8A359160
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhDIBYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 21:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIBYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:24:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA83C061760;
        Thu,  8 Apr 2021 18:24:40 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUfsw-003sCi-JE; Fri, 09 Apr 2021 01:24:34 +0000
Date:   Fri, 9 Apr 2021 01:24:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
Message-ID: <YG+s0iw5o91KQIlW@zeniv-ca.linux.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
 <161789064740.6155.11932541175173658065.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161789064740.6155.11932541175173658065.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:04:07PM +0100, David Howells wrote:
> Add an iterator, ITER_XARRAY, that walks through a set of pages attached to
> an xarray, starting at a given page and offset and walking for the
> specified amount of bytes.  The iterator supports transparent huge pages.
> 
> The iterate_xarray() macro calls the helper function with rcu_access()
> helped.  I think that this is only a problem for iov_iter_for_each_range()
> - and that returns an error for ITER_XARRAY (also, this function does not
> appear to be called).

Unused since lustre had gone away.

> +#define iterate_all_kinds(i, n, v, I, B, K, X) {		\

Do you have any users that would pass different B and X?

> @@ -1440,7 +1665,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>  		return v.bv_len;
>  	}),({
>  		return -EFAULT;
> -	})
> +	}), 0

Correction - users that might get that flavour.  This one explicitly checks
for xarray and doesn't get to iterate_... in that case.
