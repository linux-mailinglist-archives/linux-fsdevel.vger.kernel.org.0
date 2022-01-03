Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC066482D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 02:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiACB1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 20:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACB1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:27:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF7C061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 17:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=asrZc5LTL5DHianwRxAk5rRUPojsPJQaGJE4Z527nNM=; b=Qt5cGnGgd+F7q+IWiU3faSTbFQ
        niSJyimfUVlDLKwW3ens4YcLHaR8F/Rxw4XWwQo9UiNz0x09WDLBG4yk24PYGvYjjiqpd+/j1HGCu
        3CCkmIw/Nt6xaPXzd6FKsn075r+bWr1ewEIs/VDPF8NJOrBf7ifJeUakJQnr9Y6nw4o7kUyeZQyDP
        PRIKjKXD5F99pjuVZ6Qr6i2xp8TVqNi++KVflW53PMAv7NCZwLy6HXm3S55AVpkShQqeX5PouRyiO
        ziU+qybeTdMg0hl3HB2Y5LFqK6li5unUkk+M+qlBrrmqaRnwy4wEOjjzTLao2lWSFV7OSGjRCKNoV
        mpzLKe4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4C8G-00CSap-2x; Mon, 03 Jan 2022 01:27:28 +0000
Date:   Mon, 3 Jan 2022 01:27:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 00/48] Folios for 5.17
Message-ID: <YdJRAC0ksaDW9M4Z@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <D0BCCF0D-FCC6-4A36-8FC9-D5F18072E50A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0BCCF0D-FCC6-4A36-8FC9-D5F18072E50A@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry I missed this while travelling.

On Sun, Dec 26, 2021 at 10:26:23PM +0000, William Kucharski wrote:
> Consolidated multiple review comments into one email, the majority are nits at
> best:
> 
> [PATCH 04/48]:
> 
> An obnoxiously pendantic English grammar nit:
> 
> + * lock).  This can also be called from mark_buffer_dirty(), which I
> 
> The period should be inside the paren, e.g.: "lock.)"

That's at least debatable.  The full context here is:

 [...] A few have the folio blocked from truncation through other
+ * means (eg zap_page_range() has it mapped and is holding the page table
+ * lock).

According to AP Style, the period goes outside the paren in this case:
https://blog.apastyle.org/apastyle/2013/03/punctuation-junction-periods-and-parentheses.html

I'm sure you can find an authority to support always placing a period
inside a paren, but we don't have a controlling authority for how to
punctuate our documentation.  I'm great fun at parties when I get going
on the subject of the Oxford comma.

> [PATCH 05/48]:
> 
> +       unsigned char aux[3];
> 
> I'd like to see an explanation of why this is "3."

I got rid of it ... for now ;-)

> +static inline void folio_batch_init(struct folio_batch *fbatch)
> +{
> +       fbatch->nr = 0;
> +}
> +
> +static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
> +{
> +       return fbatch->nr;
> +}
> +
> +static inline unsigned int fbatch_space(struct folio_batch *fbatch)
> +{
> +       return PAGEVEC_SIZE - fbatch->nr;
> +}
> +
> +/**
> + * folio_batch_add() - Add a folio to a batch.
> + * @fbatch: The folio batch.
> + * @folio: The folio to add.
> + *
> + * The folio is added to the end of the batch.
> + * The batch must have previously been initialised using folio_batch_init().
> + *
> + * Return: The number of slots still available.
> + */
> +static inline unsigned folio_batch_add(struct folio_batch *fbatch,
> +               struct folio *folio)
> +{
> +       fbatch->folios[fbatch->nr++] = folio;
> 
> Is there any need to validate fbatch in these inlines?

I don't think so?  At least, there's no validation for the pagevec
equivalents.  I'd be open to adding something cheap if it's likely to
catch a bug someone's likely to introduce.

> [PATCH 07/48]:
> 
> +       xas_for_each(&xas, folio, ULONG_MAX) {                  \
>                 unsigned left;                                  \
> -               if (xas_retry(&xas, head))                      \
> +               size_t offset = offset_in_folio(folio, start + __off);  \
> +               if (xas_retry(&xas, folio))                     \
>                         continue;                               \
> -               if (WARN_ON(xa_is_value(head)))                 \
> +               if (WARN_ON(xa_is_value(folio)))                \
>                         break;                                  \
> -               if (WARN_ON(PageHuge(head)))                    \
> +               if (WARN_ON(folio_test_hugetlb(folio)))         \
>                         break;                                  \
> -               for (j = (head->index < index) ? index - head->index : 0; \
> -                    j < thp_nr_pages(head); j++) {             \
> -                       void *kaddr = kmap_local_page(head + j);        \
> -                       base = kaddr + offset;                  \
> -                       len = PAGE_SIZE - offset;               \
> +               while (offset < folio_size(folio)) {            \
> 
> Since offset is not actually used until after a bunch of error conditions
> may exit or restart the loop, and isn't used at all in between, defer
> its calculation until just before its first use in the "while."

Hmm.  Those conditions aren't likely to occur, but ... now that you
mention it, checking xa_is_value() after using folio as if it's not a
value is Wrong.  So I'm going to fold in this:

@@ -78,13 +78,14 @@
        rcu_read_lock();                                        \
        xas_for_each(&xas, folio, ULONG_MAX) {                  \
                unsigned left;                                  \
-               size_t offset = offset_in_folio(folio, start + __off);  \
+               size_t offset;                                  \
                if (xas_retry(&xas, folio))                     \
                        continue;                               \
                if (WARN_ON(xa_is_value(folio)))                \
                        break;                                  \
                if (WARN_ON(folio_test_hugetlb(folio)))         \
                        break;                                  \
+               offset = offset_in_folio(folio, start + __off); \
                while (offset < folio_size(folio)) {            \
                        base = kmap_local_folio(folio, offset); \
                        len = min(n, len);                      \

> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Thanks.  I'll go through and add that in, then push again.
