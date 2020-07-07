Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18C3216484
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGGDWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 23:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGDWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:22:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C912C061755
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 20:22:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n24so31074801otr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 20:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=f01bq7PCE4zcrXSwiqBzMzuXWl0giDaNlE6tVrRXevU=;
        b=cdeEDQquqBM8cstZOYSqhSP1/PMDJDOMuxfYhidTqB4Qn/bMlmTeNMlUh0FzOD0dTx
         bdCdO1Had/tS8C1UkfrWQb2wNl9sM0pepTPDCVcxSL7feVRmdalJNrT1/LMLc6FEVzd4
         3aozt7zy/prvm29YdxzFPKnYShkdbsiAYdbIr+qeT8/pIUiooyALkI2lR2oghcczmq6O
         UPUaJQLFuDFS7qj6cog+jo6O/iSkPU0K4GETUEfGZ5KgdvoqGfrVVmLf+heA+nh3ldR4
         IK6d+q/d54oMxjgME43LaTdVsyDxgrpksxUNYx8ns7GsLZTohws/ZcSonofnS5i0SQxN
         eoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=f01bq7PCE4zcrXSwiqBzMzuXWl0giDaNlE6tVrRXevU=;
        b=MapzQxszD88D+rYT7Im+LXn20yv5ctd0og97pAJzVq+7+g/nAnQmNTaSrSQCoNHA9I
         kSYkL9HbL7kwSbMGOKdLOlX2Ht1fGx6bQUAiqW/Qq1RQa/XSg2Ues9Bq1qrrrFg3XcP+
         VXjtJb2grrM8COFHhHlFY0U8bQp5xqbRSku8Pt/tC4EaSn7G1wYZx3/89c46NZTOqZry
         ii/nNctRcefKTm/4jaaNoLyJ42Jzzd3n45j4R0wG9eBHeugtI3IRLhw7D+iaYRB7OFNj
         tkiPyzbZV9nEVgRXvgWllhxg4g7iqyUg8FQOb43swUwyhMcfkTsOcgmNg3ptZ8Z3lzDk
         GccQ==
X-Gm-Message-State: AOAM533WHjx8fIDZxGatXEcMVawsJOrdjmVjFPIF7crd0FbsWZQF+m8E
        vjADH/7opMBbvRPFc/XLaUrhcw==
X-Google-Smtp-Source: ABdhPJy6ZgLHtp7JIhv6JRU8E0pbLQO9cwz14BTRSV+xv7RWn3averCX96Sk8TwSYuiijgmMEX7dVw==
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr44664228otn.75.1594092128292;
        Mon, 06 Jul 2020 20:22:08 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s123sm1762550oie.47.2020.07.06.20.22.06
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2020 20:22:07 -0700 (PDT)
Date:   Mon, 6 Jul 2020 20:21:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
In-Reply-To: <20200706144320.GB25523@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2007061946180.2346@eggly.anvils>
References: <20200629152033.16175-1-willy@infradead.org> <alpine.LSU.2.11.2007041206270.1056@eggly.anvils> <20200706144320.GB25523@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Jul 2020, Matthew Wilcox wrote:
> On Sat, Jul 04, 2020 at 01:20:19PM -0700, Hugh Dickins wrote:
> 
> > The original non-THP machine ran the same load for
> > ten hours yesterday, but hit no problem. The only significant
> > difference in what ran successfully, is that I've been surprised
> > by all the non-zero entries I saw in xarray nodes, exceeding
> > total entry "count" (I've also been bothered by non-zero "offset"
> > at root, but imagine that's just noise that never gets used).
> > So I've changed the kmem_cache_alloc()s in lib/radix-tree.c to
> > kmem_cache_zalloc()s, as in the diff below: not suggesting that
> > as necessary, just a temporary precaution in case something is
> > not being initialized as intended.
> 
> Umm.  ->count should always be accurate and match the number of non-NULL
> entries in a node.  the zalloc shouldn't be necessary, and will probably
> break the workingset code.  Actually, it should BUG because we have both
> a constructor and an instruction to zero the allocation, and they can't
> both be right.

Those kmem_cache_zalloc()s did not cause BUGs because I did them in
lib/radix-tree.c: it occurred to me yesterday morning that that was
an odd choice to have made! so I then extended them to lib/xarray.c,
immediately hit the BUGs you point out, so also added INIT_LIST_HEADs.

And very interestingly, the little huge tmpfs xfstests script I gave
last time then usually succeeds without any crash; but not always.

To me that suggests that there's somewhere you omit to clear a slot;
and that usually those xfstests don't encounter that stale slot again,
before the node is recycled for use elsewhere (with the zalloc making
it right again); but occasionally the tests do hit the bogus entry
before the node is recycled.

Before the zallocs, I had noticed a node with count 4, but filled
with non-zero entries (most of them looking like huge head pointers).

> 
> You're right that ->offset is never used at root.  I had plans to
> repurpose that to support smaller files more efficiently, but never
> got round to implementing those plans.
> 
> > These problems were either mm/filemap.c:1565 find_lock_entry()
> > VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page); or hangs, which
> > (at least the ones that I went on to investigate) turned out also to be
> > find_lock_entry(), circling around with page_mapping(page) != mapping.
> > It seems that find_get_entry() is sometimes supplying the wrong page,
> > and you will work out why much quicker than I shall.  (One tantalizing
> > detail of the bad offset crashes: very often page pgoff is exactly one
> > less than the requested offset.)
> 
> I added this:
> 
> @@ -1535,6 +1535,11 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
>                 goto repeat;
>         }
>         page = find_subpage(page, offset);
> +       if (page_to_index(page) != offset) {
> +               printk("offset %ld xas index %ld offset %d\n", offset, xas.xa_index, xas.xa_offset);

(It's much easier to spot huge page issues with %x than with %d.)

> +               dump_page(page, "index mismatch");
> +               printk("xa_load %p\n", xa_load(&mapping->i_pages, offset));
> +       }
>  out:
>         rcu_read_unlock();
>  
> and I have a good clue now:
> 
> 1322 offset 631 xas index 631 offset 48
> 1322 page:000000008c9a9bc3 refcount:4 mapcount:0 mapping:00000000d8615d47 index:0x276

(You appear to have more patience with all this ghastly hashing of
kernel addresses in debug messages than I have: it really gets in our way.)

> 1322 flags: 0x4000000000002026(referenced|uptodate|active|private)
> 1322 mapping->aops:0xffffffff88a2ebc0 ino 1800b82 dentry name:"f1141"
> 1322 raw: 4000000000002026 dead000000000100 dead000000000122 ffff98ff2a8b8a20
> 1322 raw: 0000000000000276 ffff98ff1ac271a0 00000004ffffffff 0000000000000000
> 1322 page dumped because: index mismatch
> 1322 xa_load 000000008c9a9bc3
> 
> 0x276 is decimal 630.  So we're looking up a tail page and getting its

Index 630 for offset 631, yes, that's exactly the kind of off-by-one
I saw so frequently.

> erstwhile head page.  I'll dig in and figure out exactly how that's
> happening.

Very pleasing to see the word "erstwhile" in use (and I'm serious about
that); but I don't get your head for tail point - I can't make heads or
tails of what you're saying there :) Neither 631 nor 630 is close to 512.

Certainly it's finding a bogus page, and that's related to the multi-order
splitting (I saw no problem with your 1-7 series), I think it's from a
stale entry being left behind. (But that does not at all explain the
off-by-one pattern.)

Hugh
