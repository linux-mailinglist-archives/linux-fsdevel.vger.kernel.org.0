Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F10D380D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhENPml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 11:42:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:51466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhENPmk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 11:42:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67574B05C;
        Fri, 14 May 2021 15:41:28 +0000 (UTC)
Subject: Re: [PATCH v10 11/33] mm: Handle per-folio private data
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-12-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9a748624-5f07-acf2-667a-39fc271f830d@suse.cz>
Date:   Fri, 14 May 2021 17:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-12-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Add folio_get_private() which mirrors page_private() -- ie folio private
> data is the same as page private data.  The only difference is that these
> return a void * instead of an unsigned long, which matches the majority
> of users.
> 
> Turn attach_page_private() into folio_attach_private() and reimplement
> attach_page_private() as a wrapper.  No filesystem which uses page private
> data currently supports compound pages, so we're free to define the rules.
> attach_page_private() may only be called on a head page; if you want
> to add private data to a tail page, you can call set_page_private()
> directly (and shouldn't increment the page refcount!  That should be
> done when adding private data to the head page / folio).
> 
> This saves 597 bytes of text with the distro-derived config that I'm
> testing due to removing the calls to compound_head() in get_page()
> & put_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>


Acked-by: Vlastimil Babka <vbabka@suse.cz>
