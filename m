Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F723F601D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhHXOWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhHXOWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A5C061764;
        Tue, 24 Aug 2021 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8p5CUy6U95FpiQX1SR3TxR7Nlkajc1FQ/FDXrLP/IZA=; b=gmQStllbsDfxhL9Ny4Ypbajc9B
        AcuIKR5UEnqGNmPSkJNryXHo5K3/qGo9XisKSp4PeViL70tVZCfRyRIKM7Pks/gR9+1c5gQ8LslCE
        SwlnwVu44kJZYljS4J28VFqBfsedgtIbfgNV+mKLPBwX5dG6ZrZh4GpFUgasRfkCN2d6Cpe4XhaKk
        vZKrFRVJp4LlVBwycN4++0xmAyx8gkb59zc4Q/ObQ6dGehVPbiL5bLdNO++PT2MbsqGzl+qcZAJ1o
        jV+e2RD+b6OxzRYZB3sHiu2ugQDMIiokhnWGSmZdK3BgXAXapjC1f5WzNYiljdPWmKNgGgdFNCi8F
        mIdXxPTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIXGU-00B9sS-0V; Tue, 24 Aug 2021 14:19:23 +0000
Date:   Tue, 24 Aug 2021 15:18:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] afs: Fix afs_launder_page() to set correct start
 file position
Message-ID: <YST/0e92OdSH0zjg@casper.infradead.org>
References: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
 <162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 02:24:47PM +0100, David Howells wrote:
> +++ b/fs/afs/write.c
> @@ -950,8 +950,8 @@ int afs_launder_page(struct page *page)
>  		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
>  
>  		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
> -		ret = afs_store_data(vnode, &iter, (loff_t)page->index * PAGE_SIZE,
> -				     true);
> +		ret = afs_store_data(vnode, &iter,
> +				     (loff_t)page->index * PAGE_SIZE + f, true);

This could be page_offset(page), which reads better to me:

		ret = afs_store_data(vnode, &iter, page_offset(page) + f, true);

