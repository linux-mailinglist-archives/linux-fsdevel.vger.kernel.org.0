Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D857842E200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhJNT04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 15:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhJNT0z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 954A6611CC;
        Thu, 14 Oct 2021 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634239490;
        bh=/k5KYCjk5tBAznS4xo9xEcQ0vWOZVh8Gj3SS5M1JqdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2nJBb+NcNRXUNZln3GTsnxIJozf4aDRJsh+TkJ6pI8fKn9Om8o1gA7/ZrmTHjJGr
         ODJSgnw1b6EucFSq8fokmlVDzZtcLOO1QizNQ7I20DSwPqlpuvzwsBrszozzwTOXg2
         EiPQK8u9h5L1tDfwE8Aq+5I16og4Zf62C7mhWS5biFExqQUPZspiBfqKiFJ1uCuQg8
         88+jsbbSQiOiLlslxGXEH51nupTh7ROBSOuHQG9Ys//HCWfAt0rEDgbgyxzh0b+3zP
         O/gvbdPvykkXtFqfSLOdjpRXMRc/Ati3KOuhb4FoKLGFKBq4baBd7ZrzB8eRecf9xc
         H6bley9Eo1T4Q==
Date:   Thu, 14 Oct 2021 12:24:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v7 8/8] fsdax: add exception for reflinked files
Message-ID: <20211014192450.GJ24307@magnolia>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-9-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:59PM +0800, Shiyang Ruan wrote:
> For reflinked files, one dax page may be associated more than once with
> different fime mapping and index.  It will report warning.  Now, since
> we have introduced dax-RMAP for this case and also have to keep its
> functionality for other filesystems who are not support rmap, I add this
> exception here.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 2536c105ec7f..1a57211b1bc9 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -352,9 +352,10 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		WARN_ON_ONCE(page->mapping);
> -		page->mapping = mapping;
> -		page->index = index + i++;
> +		if (!page->mapping) {
> +			page->mapping = mapping;
> +			page->index = index + i++;

It feels a little dangerous to have page->mapping for shared storage
point to an actual address_space when there are really multiple
potential address_spaces out there.  If the mm or dax folks are ok with
doing this this way then I'll live with it, but it seems like you'd want
to leave /some/ kind of marker once you know that the page has multiple
owners and therefore regular mm rmap via page->mapping won't work.

--D

> +		}
>  	}
>  }
>  
> @@ -370,9 +371,10 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		struct page *page = pfn_to_page(pfn);
>  
>  		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		page->mapping = NULL;
> -		page->index = 0;
> +		if (page->mapping == mapping) {
> +			page->mapping = NULL;
> +			page->index = 0;
> +		}
>  	}
>  }
>  
> -- 
> 2.33.0
> 
> 
> 
