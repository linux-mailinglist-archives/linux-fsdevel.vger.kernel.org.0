Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3697D149330
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 04:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgAYD5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 22:57:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAYD5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 22:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lx0lKKnkqhl0zcGVWH7r4Ty17wTgyP7eWJIw8u2UES8=; b=iH3BlPfu1A1X7J+NKyJSKjuXD
        GWqzxemtGZlidnfLckCSUlh3uxKqlLMl5js8/AGNlozsz4suLtaPnBfhlU0ZoR+ZBeDsuH61dOSi9
        ZeCNNq2MEgScp7QeMzsvrUxdbQB0gMj4y9N2wWBUt05isit6e3rne6azh/ncYVIpgl4BC0/x/geV3
        MxZcb38PFW5p4FysEyJvIi7Y7pQaG+3E4cv/YbsbMWHUeep1VQx1+AgB/Uj2eAtxRH9cLv+G5hgRX
        V/9VG8Kw9BgHVjEoUccJi2nM2CqhQSk0BLKO4Rw8wV+GqKIjZvJ0JAa8O8aKC06qH7YJEoRiGaNeD
        QO9xevOAg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivCZp-0007SX-Sz; Sat, 25 Jan 2020 03:57:41 +0000
Subject: Re: [PATCH 04/12] mm: Add readahead address space operation
To:     Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4e28eb80-d602-47e6-51ec-63bb39e1a296@infradead.org>
Date:   Fri, 24 Jan 2020 19:57:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200125013553.24899-5-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/20 5:35 PM, Matthew Wilcox wrote:
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..bb06fb7b120b 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,8 @@ cache in your filesystem.  The following members are defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *);
>  		int (*set_page_dirty)(struct page *page);
> +		unsigned (*readahead)(struct file *filp, struct address_space *mapping,
> +				 pgoff_t start, unsigned nr_pages);
>  		int (*readpages)(struct file *filp, struct address_space *mapping,
>  				 struct list_head *pages, unsigned nr_pages);
>  		int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -781,6 +783,15 @@ cache in your filesystem.  The following members are defined:
>  	If defined, it should set the PageDirty flag, and the
>  	PAGECACHE_TAG_DIRTY tag in the radix tree.
>  
> +``readahead``
> +	called by the VM to read pages associated with the address_space
> +	object.  The pages are consecutive in the page cache and are
> +        locked.  The implementation should decrement the page refcount after
> +        attempting I/O on each page.  Usually the page will be unlocked by
> +        the I/O completion handler.  If the function does not attempt I/O on
> +        some pages, return the number of pages which were not read so the
> +        common code can unlock the pages for you.
> +

Please use consistent indentation (tabs).

>  ``readpages``
>  	called by the VM to read pages associated with the address_space
>  	object.  This is essentially just a vector version of readpage.


cheers.
-- 
~Randy

