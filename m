Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9E29D4CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgJ1Vwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:52:40 -0400
Received: from casper.infradead.org ([90.155.50.34]:44318 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgJ1Vwc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=goA5wJsndJL71CyqHFXaVIdsUi4qYa0t0DekgleEdZg=; b=aGCyXro6jdMIKQtXTrBZGq1MjU
        uX+30tZuxwN7QjPuWa/msg9mo+UKxR+qPIiDYP7gCfoagaqbsD/amh7hVO+rsP8pPwHD6cUSe94X4
        aWiedg6gb5yK1fCVHFGkxnJ1JXDlONz3hv7+QxJSSCK3cn4ejd4AjzcYhOXmuv6Rvibibc/y8PqeZ
        iGGI3u9kAem+18o9/XPajqlvT1JMPCS1z8ob0q6L+AZMPqQOjIRs/SGAW0Sz0o6jExObu1Bx06T1S
        LYlI6I7dps93HWtfCcgPNNd49wwaeMbtV+uYBH/HJomz3oRNN4wugEZCx/hmEKizNukt8UG0owBiP
        T4i4N1Ag==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmJd-0003Uu-4S; Wed, 28 Oct 2020 14:20:41 +0000
Date:   Wed, 28 Oct 2020 14:20:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] afs: Fix to take ref on page when PG_private is set
Message-ID: <20201028142041.GZ20115@casper.infradead.org>
References: <160389418807.300137.8222864749005731859.stgit@warthog.procyon.org.uk>
 <160389422491.300137.18176057671220409936.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160389422491.300137.18176057671220409936.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:10:24PM +0000, David Howells wrote:
> +++ b/fs/afs/dir.c
> @@ -283,6 +283,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
>  
>  			set_page_private(req->pages[i], 1);
>  			SetPagePrivate(req->pages[i]);
> +			get_page(req->pages[i]);

Alternative spelling:

-			set_page_private(req->pages[i], 1);
-			SetPagePrivate(req->pages[i]);
+			attach_page_private(req->pages[i], (void *)1);

AFS is an anomaly; most filesystems actually stick a pointer in page->private.

> +++ b/fs/afs/write.c
> @@ -151,7 +151,8 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
>  	priv |= f;
>  	trace_afs_page_dirty(vnode, tracepoint_string("begin"),
>  			     page->index, priv);
> -	SetPagePrivate(page);
> +	if (!TestSetPagePrivate(page))
> +		get_page(page);
>  	set_page_private(page, priv);
>  	_leave(" = 0");
>  	return 0;

There's an efficiency question here that I can't answer ... how often do
you call afs_write_begin() on a page which already has PagePrivate set?
It's fewer atomic ops to do:

	if (PagePrivate(page))
		set_page_private(page, priv);
	else
		attach_page_private(page, (void *)priv);

I have no objection to adding TestSetPagePrivate per se; I just don't
know if it's really what you want or not.
