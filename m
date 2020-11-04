Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244BB2A6FAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 22:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgKDVaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 16:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKDVaI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:30:08 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD159C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 13:30:08 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id dj6so6673523qvb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3+zXT0ZYOby8hWKYMGFt34/uulfjtP08kQZov5QZ75I=;
        b=m4RN2sSbqxc8rV+Zif5XM7fx60QmgeD5ToR1HlNPou0tahS+27tfZ6KEBVQTHJQ0QY
         DRZxpGGcixEdab69VNAFKsV+09XBrOrQ5rnM1lmO4YzJO/E6HSDDIx/hb2qVUg1RRQSS
         Bo5XI9l8Ds+p3YMVvOb3WRgD2ZnGMPE253JLF03XCb/C0QY5y28kyng76DG68iq2Fn1F
         aJqWbzgEkNsiFjaFkSpt6VYImxlXMHuCPWE7lpbxX2PLhv9FT8N7vVgff7ZziKF6FUu1
         dDybythwOdh3tO/WmSGh150ksSWlAXJV2LDw0UZTr2LXydzO8pKRo1xfdqWf7+gekJGr
         YUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3+zXT0ZYOby8hWKYMGFt34/uulfjtP08kQZov5QZ75I=;
        b=Qy3KUrdqjyjd/05o5XlFcqVEEZpwC0/Wimzvw7kSJxlW6izqOhZFxrktAXHDPECmCA
         h6wjLXjm0MNWAr1ub62yEajVqyALl1hixb09CKXcs7aadtJf4G58MsAe9N0UFEMTdBUb
         4Nl5y2v1L6mSJ76Hi8Z8uIfgB7d5D8PAspQdfALGYt01/LqjWlURH9Ihcn7JOWQVE6OS
         UNWcynTYkhYS1bZ+kurjCUuDAwVXp3vAyyOz3cWlAQ73k16iKfgVDAXP6btFrgAshL4d
         oKFZUBobenX1wpiMSNDGJ0AfARnC9BJLTvbloWU8W3tjZ3u2bPTQHH6+j9W5t34yebaY
         ryUw==
X-Gm-Message-State: AOAM5313nW6SFm/+Gc5Ctl94bcO/5hE0+GzPXTW2q1i3DTyRn5UixT1J
        nvIY3/xe1Az/q06ahYWVWg==
X-Google-Smtp-Source: ABdhPJwJy//iBXjMYAqf2jMLNHB1sbOLvak7uBr7wJAh+MH4pIjNJapq8KoQakjtPlNedmikjqtEuQ==
X-Received: by 2002:a05:6214:951:: with SMTP id dn17mr31153qvb.9.1604525407914;
        Wed, 04 Nov 2020 13:30:07 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g9sm1108439qti.86.2020.11.04.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:30:07 -0800 (PST)
Date:   Wed, 4 Nov 2020 16:30:05 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH v2 02/18] mm/filemap: Remove dynamically allocated array
 from filemap_read
Message-ID: <20201104213005.GB3365678@moria.home.lan>
References: <20201104204219.23810-1-willy@infradead.org>
 <20201104204219.23810-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104204219.23810-3-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:42:03PM +0000, Matthew Wilcox (Oracle) wrote:
> Increasing the batch size runs into diminishing returns.  It's probably
> better to make, eg, three calls to filemap_get_pages() than it is to
> call into kmalloc().

I have to disagree. Working with PAGEVEC_SIZE pages is eventually going to be
like working with 4k pages today, and have you actually read the slub code for
the kmalloc fast path? It's _really_ fast, there's no atomic operations and it
doesn't even have to disable preemption - which is why you never see it showing
up in profiles ever since we switched to slub.

It would however be better to have a standard abstraction for this rather than
open coding it - perhaps adding it to the pagevec code. Please don't just drop
it, though.


> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 23e3781b3aef..bb1c42d0223c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2429,8 +2429,8 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  	struct file_ra_state *ra = &filp->f_ra;
>  	struct address_space *mapping = filp->f_mapping;
>  	struct inode *inode = mapping->host;
> -	struct page *pages_onstack[PAGEVEC_SIZE], **pages = NULL;
> -	unsigned int nr_pages = min_t(unsigned int, 512,
> +	struct page *pages[PAGEVEC_SIZE];
> +	unsigned int nr_pages = min_t(unsigned int, PAGEVEC_SIZE,
>  			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
>  			(iocb->ki_pos >> PAGE_SHIFT));
>  	int i, pg_nr, error = 0;
> @@ -2441,14 +2441,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		return 0;
>  	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
>  
> -	if (nr_pages > ARRAY_SIZE(pages_onstack))
> -		pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
> -
> -	if (!pages) {
> -		pages = pages_onstack;
> -		nr_pages = min_t(unsigned int, nr_pages, ARRAY_SIZE(pages_onstack));
> -	}
> -
>  	do {
>  		cond_resched();
>  
> @@ -2533,9 +2525,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  
>  	file_accessed(filp);
>  
> -	if (pages != pages_onstack)
> -		kfree(pages);
> -
>  	return written ? written : error;
>  }
>  EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> -- 
> 2.28.0
> 
