Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09233377C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 09:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCJIhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 03:37:47 -0500
Received: from verein.lst.de ([213.95.11.211]:35158 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232289AbhCJIh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:37:26 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F87968B05; Wed, 10 Mar 2021 09:37:23 +0100 (CET)
Date:   Wed, 10 Mar 2021 09:37:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: make alloc_anon_inode more useful
Message-ID: <20210310083723.GC5217@lst.de>
References: <20210309155348.974875-1-hch@lst.de> <20210310040545.GM3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310040545.GM3479805@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:05:45AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 09, 2021 at 04:53:39PM +0100, Christoph Hellwig wrote:
> > this series first renames the existing alloc_anon_inode to
> > alloc_anon_inode_sb to clearly mark it as requiring a superblock.
> > 
> > It then adds a new alloc_anon_inode that works on the anon_inode
> > file system super block, thus removing tons of boilerplate code.
> > 
> > The few remainig callers of alloc_anon_inode_sb all use alloc_file_pseudo
> > later, but might also be ripe for some cleanup.
> 
> On a somewhat related note, could I get you to look at
> drivers/video/fbdev/core/fb_defio.c?
> 
> As far as I can tell, there's no need for fb_deferred_io_aops to exist.
> We could just set file->f_mapping->a_ops to NULL, and set_page_dirty()
> would do the exact same thing this code does (except it would get the
> return value correct).

> But maybe that would make something else go wrong that distinguishes
> between page->mapping being NULL and page->mapping->a_ops->foo being NULL?

I can't find any place in the kernel that treats a NULL aops different
from not having the method it is looking for. 

> Completely untested patch ...

the patch looks mostly good to me.

>  	}
> -#ifdef CONFIG_FB_DEFERRED_IO
> -	if (info->fbdefio)
> -		fb_deferred_io_open(info, inode, file);
> -#endif
> +	file->f_mapping->a_ops = NULL;

But I'd also skip this.  Drivers generally do not set aops, but if they
do a funtion like this really should not override it.  This will require
an audit of the callers, though.
