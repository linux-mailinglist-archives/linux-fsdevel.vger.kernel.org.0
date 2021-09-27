Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8131419D6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhI0RuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 13:50:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51452 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhI0Rt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:49:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8FBE320192;
        Mon, 27 Sep 2021 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632764896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvaIb84bs5CgKY5BLmHg7hDoz9uS7G9WON/VtG1lE74=;
        b=CjuOevw7QHHLIbmgMINaDx0qqfZZyQvCXYgJwvNuLGBCBZ1NG6UeG6BcmXOO+byn5U2p4h
        anSg3DnUK5Gtndnn5szyops0DQ+dui5D9bl84dmHn1CS81DzC8zBU+My//HAoe6sk9e7ek
        i/lFD/hQv3QgEpYoeaHVwYaqMW3q2ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632764896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvaIb84bs5CgKY5BLmHg7hDoz9uS7G9WON/VtG1lE74=;
        b=DenipbnoSkR7n8VIdteCv23hMvy9k/bn16u4tyXYAwDWjw6QDusoHbcq1+XG/HY0sL8E7q
        haY7qLweQf0CtQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 650B6132D4;
        Mon, 27 Sep 2021 17:48:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gGTZF+ADUmHNHAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Sep 2021 17:48:16 +0000
Message-ID: <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
Date:   Mon, 27 Sep 2021 19:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Struct page proposal
In-Reply-To: <YUvWm6G16+ib+Wnb@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/21 03:21, Kent Overstreet wrote:
> So if we have this:
> 
> struct page {
> 	unsigned long	allocator;
> 	unsigned long	allocatee;
> };
> 
> The allocator field would be used for either a pointer to slab/slub's state, if
> it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> allocation - like compound order today, and probably whether or not the
> (compound group of) pages is free.

The "free page in buddy allocator" case will be interesting to implement.
What the buddy allocator uses today is:

- PageBuddy - determine if page is free; a page_type (part of mapcount
field) today, could be a bit in "allocator" field that would have to be 0 in
all other "page is allocated" contexts.
- nid/zid - to prevent merging accross node/zone boundaries, now part of
page flags
- buddy order
- a list_head (reusing the "lru") to hold the struct page on the appropriate
free list, which has to be double-linked so page can be taken from the
middle of the list instantly

Won't be easy to cram all that into two unsigned long's, or even a single
one. We should avoid storing anything in the free page itself. Allocating
some external structures to track free pages is going to have funny
bootstrap problems. Probably a major redesign would be needed...

