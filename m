Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240CB419EE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 21:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhI0TJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 15:09:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34036 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhI0TJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 15:09:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0AC2019A;
        Mon, 27 Sep 2021 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632769642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvQmsr9KDIk/ybWwa/XbnZPFi6Cbpz4zxjOROpthasw=;
        b=QIYjnEJYK9TA8nVtmxVejhun22JbUeFFTCXTktWWkDRTHp5OWB6O/D1JcBridXce7Oqram
        otzDqReVsbk7hXMsXfGluTMjjtXvjVaIAECMo2i6X5n7GnOz210EP/7U00rYZj1y5gqNlu
        fUXjEd/9AhmA4nHxkqbxku41tdtRZ5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632769642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvQmsr9KDIk/ybWwa/XbnZPFi6Cbpz4zxjOROpthasw=;
        b=98CjCdNazjUj6+mWP8tHbVijbFqQHzE/MCzDW+ukxs9mVdLHAHqpqhg2CooKce3OYzq+qR
        a19/ak1eBIRQt8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C30613BF2;
        Mon, 27 Sep 2021 19:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5VVJDWoWUmF4PQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Sep 2021 19:07:22 +0000
Message-ID: <751358b2-aec2-43a3-cbbe-1f8c4469b6d3@suse.cz>
Date:   Mon, 27 Sep 2021 21:07:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Struct page proposal
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org> <YVII7eM7P42riwoI@moria.home.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YVII7eM7P42riwoI@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/27/2021 8:09 PM, Kent Overstreet wrote:
> On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
>> On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
>>> Won't be easy to cram all that into two unsigned long's, or even a single
>>> one. We should avoid storing anything in the free page itself. Allocating
>>> some external structures to track free pages is going to have funny
>>> bootstrap problems. Probably a major redesign would be needed...
>>
>> Wait, why do we want to avoid using the memory that we're allocating?
> 
> The issue is where to stick the state for free pages. If that doesn't fit in two
> ulongs, then we'd need a separate allocation, which means slab needs to be up
> and running before free pages are initialized.

So that's what I meant by the funny bootstrap problems - slab allocates pages
from the buddy allocator. And well, not just bootstrap, imagine free memory
becomes low, we need to reclaim pages, and in order to turn full pages to free
buddy pages we need to allocate these slab structures, and the slab is full too
and needs to allocate more backing pages...

By "major redesign" I meant e.g. something along - bitmaps of free pages per
each order? (instead of the free lists) Hm but I guess no, the worst case times
searching for free pages would just suck...
