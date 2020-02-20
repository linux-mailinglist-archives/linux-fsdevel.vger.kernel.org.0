Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C25166395
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBTQ5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 11:57:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBTQ5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qHvBZa6xH4q8QoO0XjztoHEsiwUeumDdhpQiwafJ4fA=; b=XxNghq7rFzqnKm0SVydd0tHTdn
        n4s70eVOvmXv6xE4upQLTZABvYZeabWIKMlGk6r1YJRae6i8tpYXe5dtM9zo+Nvpbtu1wnMIhCRDY
        nXaWx7ub/Z7OzeYS+E/BNUzS6JOhGzIvL1BAO8xZgolQ++p6TjxSiG17Yqf5R/+hI5Tk6WktBEQFl
        ALA1Z2m00fN67lT/dRb+VmatCW5BfMt0zqFVJecwEgC4ipDl7wtLI+budHd68slvGKbN8MEQRduxB
        hi02UijAGWWe/BHat9owg4eLO9dGnV9K9muMrZ8ZBwLUooYgWOvcD2lcfCIagHu0PZetNNM4A6azz
        Ltap/rvQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4p8p-0005KC-2B; Thu, 20 Feb 2020 16:57:35 +0000
Date:   Thu, 20 Feb 2020 08:57:34 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200220165734.GZ24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
 <20200220154912.GC19577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220154912.GC19577@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:49:12AM -0800, Christoph Hellwig wrote:
> > +/**
> > + * iomap_readahead - Attempt to read pages from a file.
> > + * @rac: Describes the pages to be read.
> > + * @ops: The operations vector for the filesystem.
> > + *
> > + * This function is for filesystems to call to implement their readahead
> > + * address_space operation.
> > + *
> > + * Context: The file is pinned by the caller, and the pages to be read are
> > + * all locked and have an elevated refcount.  This function will unlock
> > + * the pages (once I/O has completed on them, or I/O has been determined to
> > + * not be necessary).  It will also decrease the refcount once the pages
> > + * have been submitted for I/O.  After this point, the page may be removed
> > + * from the page cache, and should not be referenced.
> > + */
> 
> Isn't the context documentation something that belongs into the aop
> documentation?  I've never really seen the value of duplicating this
> information in method instances, as it is just bound to be out of date
> rather sooner than later.

I'm in two minds about it as well.  There's definitely no value in
providing kernel-doc for implementations of a common interface ... so
rather than fixing the nilfs2 kernel-doc, I just deleted it.  But this
isn't just the implementation, like nilfs2_readahead() is, it's a library
function for filesystems to call, so it deserves documentation.  On the
other hand, there's no real thought to this on the part of the filesystem;
the implementation just calls this with the appropriate ops pointer.

Then again, I kind of feel like we need more documentation of iomap to
help filesystems convert to using it.  But maybe kernel-doc isn't the
mechanism to provide that.
