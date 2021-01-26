Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C110304935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbhAZFag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbhAZEHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:07:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C99C06174A;
        Mon, 25 Jan 2021 20:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jq3N/pNATTXIAMrmJ6obiwvtVc5gjKpBnS3S5QeZ+pY=; b=k5jINKlmfQbKVkIc/QXlhf3x+a
        KKgGtH3mPaUaM/OfdSzQ+q/lrTQwHicbG/JKAJXzk0VSiUhlqqPvKPVFRLaBTrRuO1/yfo8oXx4H7
        l5bG5GO4+RnFNJfsM67J/D3YIEbQJo/k3q5HfWbJUgK5sd+tFUMejnRDHyDxk4LZuWyvCQDnB+gjq
        zOKsiZ2Lv5B5lLMYuuMKn/gA2xwSBl2THbsXjL87EiEHQ8EhQ2ImbIqpEatXX2aFYhUkw9YYNfLrv
        aarEqm3k+Xt/QvaRlG8bjW49UmSAtOfxlmHpnv165FYQ6iMzlCp2siLkBG/QSBVFjVvAWTbVZmcGv
        JFMI27LA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4Fbo-0053Bl-Gu; Tue, 26 Jan 2021 04:05:43 +0000
Date:   Tue, 26 Jan 2021 04:05:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/32] NFS: Refactor nfs_readpage() and
 nfs_readpage_async() to use nfs_readdesc
Message-ID: <20210126040540.GK308988@casper.infradead.org>
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161057357.2537118.6542184374596533032.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161161057357.2537118.6542184374596533032.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 09:36:13PM +0000, David Howells wrote:
> +int nfs_readpage_async(void *data, struct inode *inode,
>  		       struct page *page)
>  {
> +	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;

You don't need a cast to cast from void.

> @@ -440,17 +439,16 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
>  	if (ret == 0)
>  		goto read_complete; /* all pages were read */
>  
> -	desc.pgio = &pgio;
> -	nfs_pageio_init_read(&pgio, inode, false,
> +	nfs_pageio_init_read(&desc.pgio, inode, false,

I like what you've done here, embedding the pgio in the desc.

