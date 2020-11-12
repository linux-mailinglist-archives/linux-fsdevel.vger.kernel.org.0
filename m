Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2251E2B0B72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgKLRl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 12:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgKLRl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:41:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F5BC0613D1;
        Thu, 12 Nov 2020 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eaX1+ATZFX5QaZboVsjA3nZdkItK9osiOb9syEljGl4=; b=Uj8oHNbSuyqpEQWRlw8PlugXFK
        x7uOsrfD57/4YXq/Ovu8hrqbA/PHGjQC5k6mm1/wC7/4uqolMu9lxkxtJd7pIx+xiSISFW6beSVlr
        fd1RCLn7PzPDAwgtoD5H1y1zC7zu1T5hDdD651ERepHfnbkMkGxVM8SVMa8prsSm2AWfqeTpuPcTA
        zdTQ95X5WI0i0i4neQ0di7zSYTzKCtOU/c18Z6wW8XKYDJVXfQ6MWUR439Ng9+iOu0g6cEU9xL5OV
        2f3tSz5ExLhNngGnWV6YO/jrjYLYulNPCP5vKNAuU6sHK7WWb8UF9utT3MS/X/ML+G3C2WqMbKu+U
        u1bWu1Sw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdGbW-0001cV-FZ; Thu, 12 Nov 2020 17:41:50 +0000
Date:   Thu, 12 Nov 2020 17:41:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 01/12] mm: Make pagecache tagged lookups return only
 head pages
Message-ID: <20201112174150.GC17076@casper.infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-2-willy@infradead.org>
 <20201028075056.GB1362354@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028075056.GB1362354@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 09:50:56AM +0200, Mike Rapoport wrote:
> > @@ -2074,8 +2074,8 @@ EXPORT_SYMBOL(find_get_pages_contig);
> >   * @nr_pages:	the maximum number of pages
> >   * @pages:	where the resulting pages are placed
> >   *
> > - * Like find_get_pages, except we only return pages which are tagged with
> > - * @tag.   We update @index to index the next page for the traversal.
> > + * Like find_get_pages(), except we only return head pages which are tagged
> > + * with @tag.   We update @index to index the next page for the traversal.
> 
> Nit:                                           ^ next head page

I don't love the sentence anyway.  How about:

 * Like find_get_pages(), except we only return head pages which are tagged
 * with @tag.  @index is updated to the index immediately after the last
 * page we return, ready for the next iteration.

