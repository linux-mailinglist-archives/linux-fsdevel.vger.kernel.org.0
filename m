Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A343C676A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 02:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhGMA1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 20:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhGMA1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 20:27:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660D2C0613E9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 17:24:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e14so19851248qkl.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 17:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yB5qAIs9Fc7CEvMMJ8HjSEc+CJeHsMb3Z3r28kd1YEE=;
        b=01/+1PeyYqpCfkWSPiQzQ1/4ZzPCpTK75chfxFtWF7xgFFxO8o4Rb6MeI8H1ivl+R1
         1ebZc2s7qCJgIHtRRFKwbcgLSUa4zIa4Kn6y6NMGTV1QlR87DV9iAeYNqMq5bDoBrrmC
         XSi53W67knvsyOnZ1i+6YWyZWQNWcAk+m6zx/QRcYOJTWpZRpKDsnGM0zk4Tqb3GXrN3
         beKx5CGDrwhitiApD8OyX43Jrc3VFvy31lLfrNz0N5XDSD7AxLj9gFkWp+qDmeu0p9Yb
         o+evI0jqah2VbXE5Lt/o15HtAEE+yZjiMaIPwdVonhgkYelnStKJwaS/TWNSzoI3xkZq
         sQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yB5qAIs9Fc7CEvMMJ8HjSEc+CJeHsMb3Z3r28kd1YEE=;
        b=ldlxVpq/GKSFZ7Uq0XsinkK125JGWPt+UupcvvlA8uO2BcpmFBnN/PJ5Ctg+28r7jZ
         9OCneGE82A8OSUtEWg9yEf7EKi2C04O8VJ8Z/kE8guPIYlUvtyOH7DeBkA4aksXTjhVj
         n03lm77XXzI5fnaCudR4wx/EHmPoHNg2rBfJsUTXL1pRRKqxPAaFgYJMuUs/iuqmLBzf
         XgYYEk856EB9sYY7PyZnkwIzt6L8L4G6S0U2SHDdR/Ssbh3+RYHNpZ2Az7oExxGO4EZv
         vORCNZHe7UZUGFeIQdz2MWJ221/9AodIfAPwjH8QMNFYfCeTRJ+Z2CEGGBnJv+1YzC/7
         NnZw==
X-Gm-Message-State: AOAM530bhGZqjiwpO6f8fSmutqBouCVH6JX9FdVYTklKoUo0n2OW5IUi
        JI4JTmilAUUjMIKpAPJnjIyksQ==
X-Google-Smtp-Source: ABdhPJyNS88bT9lchdE/k2l0s9hF0E9K9iY57Ozrhl0XABc1zYmIZo6n9Z6iN5rSiOntQZCXbF+IQw==
X-Received: by 2002:ae9:dd06:: with SMTP id r6mr1467355qkf.74.1626135851341;
        Mon, 12 Jul 2021 17:24:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a40c])
        by smtp.gmail.com with ESMTPSA id x20sm7394463qkp.15.2021.07.12.17.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 17:24:10 -0700 (PDT)
Date:   Mon, 12 Jul 2021 20:24:09 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v13 010/137] mm: Add folio flag manipulation functions
Message-ID: <YOzdKYejOEUbjvMj@cmpxchg.org>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712030701.4000097-11-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 04:04:54AM +0100, Matthew Wilcox (Oracle) wrote:
> +/* Whether there are one or multiple pages in a folio */
> +static inline bool folio_single(struct folio *folio)
> +{
> +	return !folio_head(folio);
> +}

Reading more converted code in the series, I keep tripping over the
new non-camelcased flag testers.

It's not an issue when it's adjectives: folio_uptodate(),
folio_referenced(), folio_locked() etc. - those are obvious. But nouns
and words that overlap with struct member names can easily be confused
with non-bool accessors and lookups. Pop quiz: flag test or accessor?

folio_private()
folio_lru()
folio_nid()
folio_head()
folio_mapping()
folio_slab()
folio_waiters()

This requires a lot of double-taking on what is actually being
queried. Bool types, ! etc. don't help, since we test pointers for
NULL/non-NULL all the time.

I see in a later patch you changed the existing page_lru() (which
returns an enum) to folio_lru_list() to avoid the obvious collision
with the PG_lru flag test. page_private() has the same problem but it
changed into folio_get_private() (no refcounting involved). There
doesn't seem to be a consistent, future-proof scheme to avoid this new
class of collisions between flag testing and member accessors.

There is also an inconsistency between flag test and set that makes me
pause to think if they're actually testing and setting the same thing:

	if (folio_idle(folio))
		folio_clear_idle_flag(folio);

Compare this to check_move_unevictable_pages(), where we do

	if (page_evictable(page))
		ClearPageUnevictable(page);

where one queries a more complex, contextual userpage state and the
other updates the corresponding pageframe bit flag.

The camelcase stuff we use for page flag testing is unusual for kernel
code. But the page API is also unusually rich and sprawling. What
would actually come close? task? inode? Having those multiple
namespaces to structure and organize the API has been quite helpful.

On top of losing the flagops namespacing, this series also disappears
many <verb>_page() operations (which currently optically distinguish
themselves from page_<noun>() accessors) into the shared folio_
namespace. This further increases the opportunities for collisions,
which force undesirable naming compromises and/or ambiguity.

More double-taking when the verb can be read as a noun: lock_folio()
vs folio_lock().

Now, is anybody going to mistake folio_lock() for an accessor? Not
once they think about it. Can you figure out and remember what
folio_head() returns? Probably. What about all the examples above at
the same time? Personally, I'm starting to struggle. It certainly
eliminates syntactic help and pattern matching, and puts much more
weight on semantic analysis and remembering API definitions.

What about functions like shrink_page_list() which are long sequences
of page queries and manipulations? Many lines would be folio_<foo>
with no further cue whether you're looking at tests, accessors, or a
high-level state change that is being tested for success. There are
fewer visual anchors to orient yourself when you page up and down. It
quite literally turns some code into blah_(), blah_(), blah_():

       if (!folio_active(folio) && !folio_unevictable(folio)) {
	       folio_del_from_lru_list(folio, lruvec);
	       folio_set_active_flag(folio);
	       folio_add_to_lru_list(folio, lruvec);
	       trace_mm_lru_activate(&folio->page);
	}

Think about the mental strain of reading and writing complicated
memory management code with such a degree of syntactic parsimony, let
alone the repetetive monotony.

In those few lines of example code alone, readers will pause on things
that should be obvious, and miss grave errors that should stand out.

Add compatible return types to similarly named functions and we'll
provoke subtle bugs that the compiler won't catch either.

There are warts and inconsistencies in our naming patterns that could
use cleanups. But I think this compresses a vast API into one template
that isn't nearly expressive enough to adequately communicate and
manage the complexity of the underlying structure and its operations.
