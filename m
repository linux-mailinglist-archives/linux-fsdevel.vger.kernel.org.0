Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA27E1398C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAMSWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 13:22:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:52928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgAMSWp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:22:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30EE2AFCB;
        Mon, 13 Jan 2020 18:22:43 +0000 (UTC)
Date:   Mon, 13 Jan 2020 19:22:42 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jlayton@kernel.org, hch@infradead.org
Subject: Re: [PATCH 4/8] mm/fs: Add a_ops->readahead
Message-ID: <20200113182242.byzbv5frzyymbddi@beryllium.lan>
References: <20200113153746.26654-1-willy@infradead.org>
 <20200113153746.26654-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113153746.26654-5-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, Jan 13, 2020 at 07:37:42AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This will replace ->readpages with a saner interface:
>  - No return type (errors are ignored for read ahead anyway)
>  - Pages are already in the page cache when ->readpages is called
>  - Pages are passed in a pagevec instead of a linked list
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  8 +++++-
>  Documentation/filesystems/vfs.rst     |  9 ++++++
>  include/linux/fs.h                    |  3 ++
>  mm/readahead.c                        | 40 ++++++++++++++++++++++++++-
>  4 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 5057e4d9dcd1..1e2f1186fd1a 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -239,6 +239,8 @@ prototypes::
>  	int (*readpage)(struct file *, struct page *);
>  	int (*writepages)(struct address_space *, struct writeback_control *);
>  	int (*set_page_dirty)(struct page *page);
> +	int (*readahead)(struct file *, struct address_space *,
> +			struct pagevec *, pgoff_t index);

Shouldn't this be no return type? Just trying to map your commit
message to the code.


>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
>  	int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -271,7 +273,8 @@ writepage:		yes, unlocks (see below)
>  readpage:		yes, unlocks
>  writepages:
>  set_page_dirty		no
> -readpages:
> +readpages:              no
> +readahead:              yes, unlocks
>  write_begin:		locks the page		 exclusive
>  write_end:		yes, unlocks		 exclusive
>  bmap:
> @@ -298,6 +301,9 @@ completion.
>  ->readpages() populates the pagecache with the passed pages and starts
>  I/O against them.  They come unlocked upon I/O completion.
>  
> +->readahead() starts I/O against the pages.  They come unlocked upon
> +I/O completion.
> +
>  ->writepage() is used for two purposes: for "memory cleansing" and for
>  "sync".  These are quite different operations and the behaviour may differ
>  depending upon the mode.
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..63d0f0dbbf9c 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,8 @@ cache in your filesystem.  The following members are defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *);
>  		int (*set_page_dirty)(struct page *page);
> +		int (*readahead)(struct file *, struct address_space *,
> +				 struct pagevec *, pgoff_t index);

Same here?

Maybe I just miss the point, in the case, sorry for the noise.

Thanks,
Daniel

