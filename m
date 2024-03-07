Return-Path: <linux-fsdevel+bounces-13838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F28874773
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 05:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A7A2810F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 04:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D61B964;
	Thu,  7 Mar 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cu5UtBI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65481F;
	Thu,  7 Mar 2024 04:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709786727; cv=none; b=k7UBgyUl5dQmh6sjKsjfLHQR9aVcn7Dhj4phe9R714V4B5/8UCQ0EDq4RsY2dXmoLTduylQy3ZK9itvzmw9HISzbuBXQRN8zJpMmaTN2n9WZdgAGhqtlYtlcOnjdDBLGBQA9UXGfG+atU30dvlIxJMhVe9vu2bPf2GvB7M/60Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709786727; c=relaxed/simple;
	bh=ILfV+QLUtMLblEU3EmuqMHD8odHprdbiQe9rdJMt+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVMKxzLDZLasbshyYeXc46gIAyDLjrfCIIXiLutZYsRRNZDM0TjubemWAPgDtDBSc+6UD5a5RBIsWWvfyHbNCAXpTD0Xr36kKQcu5hqe/f0Kk3BBjk7ggONYAWg/8DCROjym8mlaujwrrqoV11LvywOwEyyrBoz09WeE+icz2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cu5UtBI+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r8w2DNfyKL2/tLJTtAySKLQRqT812RnWeFEltkFTF8c=; b=Cu5UtBI+YyYOWL2AUGLQTNt1FK
	kGRmBYcZ5LzKErtlKR8XYNMFxZjzP031zLs0ZtzzWdiCk8zS0Z1YfnvNAeLT+1UYi69cFr/k5MT7q
	8ZHbNNKiTYzCwdnJrOTD1V8pn6V1r79vE3MopVrLyUdNJPu6dr/19HywX3LN9Ac+VrvxspVZdAqtu
	zAbfZG9+0Sem/3BRus9T0O98YG/B+Qb1G3llp8PxeJCp/CEU4vmQzHAlLoVpbtkX5uZoKMPULH597
	71xabJgGXVWMg0YA5p5KllDvbcofYVvG1AYoDF1dON1Gz4UwFdJZ+Pt9CpZxksDgjiHvwjcmgIu5b
	ybLdNwUA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri5d9-00000008NNo-3J6E;
	Thu, 07 Mar 2024 04:45:19 +0000
Date: Thu, 7 Mar 2024 04:45:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Message-ID: <ZelGX3vVlGfEZm8H@casper.infradead.org>
References: <1668172.1709764777@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668172.1709764777@warthog.procyon.org.uk>

On Wed, Mar 06, 2024 at 10:39:37PM +0000, David Howells wrote:
> Here's a patch to have a go at getting rid of ->launder_folio().  Since it's
> failable and cannot guarantee that pages in the range are removed, I've tried
> to replace laundering with just flush-and-wait, dropping the folio lock around
> the I/O.

My sense is that ->launder_folio doesn't actually need to be replaced.

commit e3db7691e9f3dff3289f64e3d98583e28afe03db
Author: Trond Myklebust <Trond.Myklebust@netapp.com>
Date:   Wed Jan 10 23:15:39 2007 -0800

    [PATCH] NFS: Fix race in nfs_release_page()

        NFS: Fix race in nfs_release_page()

        invalidate_inode_pages2() may find the dirty bit has been set on a page
        owing to the fact that the page may still be mapped after it was locked.
        Only after the call to unmap_mapping_range() are we sure that the page
        can no longer be dirtied.
        In order to fix this, NFS has hooked the releasepage() method and tries
        to write the page out between the call to unmap_mapping_range() and the
        call to remove_mapping(). This, however leads to deadlocks in the page
        reclaim code, where the page may be locked without holding a reference
        to the inode or dentry.

        Fix is to add a new address_space_operation, launder_page(), which will
        attempt to write out a dirty page without releasing the page lock.

    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

I don't understand why this couldn't've been solved by page_mkwrite.
NFS did later add nfs_vm_page_mkwrite in July 2007, and maybe it's just
not needed any more?  I haven't looked into it enough to make sure,
but my belief is that we should be able to get rid of it.

