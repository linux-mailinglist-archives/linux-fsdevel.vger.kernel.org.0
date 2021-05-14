Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F4380D0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhENPbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 11:31:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:43534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhENPbJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 11:31:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3D57B03A;
        Fri, 14 May 2021 15:29:56 +0000 (UTC)
Subject: Re: [PATCH v10 09/33] mm: Add folio flag manipulation functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-10-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b577925b-cda8-c902-aa17-3588e8ab5d5a@suse.cz>
Date:   Fri, 14 May 2021 17:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-10-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> These new functions are the folio analogues of the various PageFlags
> functions.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio
> is not a tail page at every invocation.  This will also catch the
> PagePoisoned case as a poisoned page has every bit set, which would
> include PageTail.
> 
> This saves 1727 bytes of text with the distro-derived config that
> I'm testing due to removing a double call to compound_head() in
> PageSwapCache().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some nits:

...

>   * Macros to create function definitions for page flags
>   */
>  #define TESTPAGEFLAG(uname, lname, policy)				\
> +static __always_inline bool folio_##lname(struct folio *folio)		\
> +{ return test_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
>  static __always_inline int Page##uname(struct page *page)		\
>  	{ return test_bit(PG_##lname, &policy(page, 0)->flags); }

Maybe unify these idents while at it?

>  
>  #define SETPAGEFLAG(uname, lname, policy)				\
> +static __always_inline							\
> +void folio_set_##lname##_flag(struct folio *folio)			\
> +{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
>  static __always_inline void SetPage##uname(struct page *page)		\
>  	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
>  
>  #define CLEARPAGEFLAG(uname, lname, policy)				\
> +static __always_inline							\
> +void folio_clear_##lname##_flag(struct folio *folio)			\
> +{ clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
>  static __always_inline void ClearPage##uname(struct page *page)		\
>  	{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
>  
>  #define __SETPAGEFLAG(uname, lname, policy)				\
> +static __always_inline							\
> +void __folio_set_##lname##_flag(struct folio *folio)			\
> +{ __set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
>  static __always_inline void __SetPage##uname(struct page *page)		\
>  	{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
>  
>  #define __CLEARPAGEFLAG(uname, lname, policy)				\
> +static __always_inline							\
> +void __folio_clear_##lname##_flag(struct folio *folio)			\
> +{ __clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
>  static __always_inline void __ClearPage##uname(struct page *page)	\
>  	{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
>  
>  #define TESTSETFLAG(uname, lname, policy)				\
> +static __always_inline							\
> +bool folio_test_set_##lname##_flag(struct folio *folio)		\

The line above seems to need extra tab before '\'
(used vimdiff on your git tree)

