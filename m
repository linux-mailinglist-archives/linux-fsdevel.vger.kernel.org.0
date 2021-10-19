Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF4433E71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhJSScN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhJSScN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:32:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D57C06161C;
        Tue, 19 Oct 2021 11:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZ9xrxMcNRI8ZuFFAy2iTPbxahYga2XstNQpPO9cMgE=; b=cn4Pc1pEaoHMVy8gIsrUIPBp6n
        IvhYVvPxLOGXmopmvPBIi8Z01toSzSmWvibfLFkBjdaHyUYJOrxR08qrwOT8UZ0xqUlec+T5luiVg
        GzIFfFKh4dwXqT/lDoAJASJwu3IC6cN7Nd7fTUc4kJHy6UjU9MOVZASY6Q/pq5RXGcHm+wZiqO5xJ
        L7mBvfVKYZM/Ih213xkdpm9shfhx35HfA4lgljh8ZVAEeC0fdP+lXyV7QW2BHwjDKms8f+xacEzUx
        RYX/9mTfEdCpiyeJAUYH1Hz1l6jJXF6KG6nNRl9qXwdGZU88BN3vWFIH5MDv87MotH6YVNyhJZwtM
        Byq3EC8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mctqE-00Bvpr-F1; Tue, 19 Oct 2021 18:28:14 +0000
Date:   Tue, 19 Oct 2021 19:28:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/67] mm: Stop filemap_read() from grabbing a
 superfluous page
Message-ID: <YW8OMsrEzrY8aSxo@casper.infradead.org>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
 <163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163456863216.2614702.6384850026368833133.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 03:50:32PM +0100, David Howells wrote:
> @@ -2625,6 +2625,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
>  			iocb->ki_flags |= IOCB_NOWAIT;
>  
> +		isize = i_size_read(inode);
> +		if (unlikely(iocb->ki_pos >= isize))
> +			goto put_pages;
> +

Is there a good reason to assign to isize here?  I'd rather not,
because it complicates analysis, and a later change might look at
the isize read here, not realising it was a racy use.  So I'd
rather see:

		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
			goto put_pages;
