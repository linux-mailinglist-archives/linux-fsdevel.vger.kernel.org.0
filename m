Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE5742558A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbhJGOjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 10:39:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37528 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:39:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E33DB2244C;
        Thu,  7 Oct 2021 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633617428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPSnZbkEIcq104FYIBgq5TYP7yBK8f8mhYAs6+fTXHY=;
        b=N7w8whBYhLCUJLtssd8NxyFVAUHAZNclAacxDzzbzMlzczZtvTgV/U5uXBE8qZVxTR6qh3
        +4n1AwmAErSpozZYBwrVFZC+UwWXQzOtRMBzhJLf+xGX95D0OXWzGuP8Ho6k2828wIUrFj
        Fh56O975vW/P3LQn+q3sUSHE16lcfNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633617428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YPSnZbkEIcq104FYIBgq5TYP7yBK8f8mhYAs6+fTXHY=;
        b=1Rs2jlHdc0fuDgTYW9nLD3KOAJm4zQd6HW0GLu1kYfsm/HJswNvZqfAC1uxIlCmwfW0Zvx
        zgipvAA1C2UDk7AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7B0D13CE5;
        Thu,  7 Oct 2021 14:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sCUfMBQGX2EkXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Oct 2021 14:37:08 +0000
Message-ID: <a8cdcb3c-26e5-33b5-44f9-459df8a40dbb@suse.cz>
Date:   Thu, 7 Oct 2021 16:37:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC] pgflags_t
In-Reply-To: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/21 16:58, Matthew Wilcox wrote:
> David expressed some unease about the lack of typesafety in patches
> 1 & 2 of the page->slab conversion [1], and I'll admit to not being
> particularly a fan of passing around an unsigned long.  That crystallised
> in a discussion with Kent [2] about how to lock a page when you don't know
> its type (solution: every memory descriptor type starts with a
> pgflags_t)
> 
> So this patch is a step towards typesafety for pgflags_lock() by
> changing the type of page->flags from a bare unsigned long to a
> struct encapsulating an unsigned long.  A few users can already benefit
> from passing around a pgflags_t, but most just append '.f' to get at
> the unsigned long.  Also, most of them only do it for logging/tracing.
> 
> [1] https://lore.kernel.org/linux-mm/02a055cd-19d6-6e1d-59bb-e9e5f9f1da5b@redhat.com/
> [2] https://lore.kernel.org/linux-mm/YVyQpPuwIGFSSEQ8@casper.infradead.org/
> 
...
> diff --git a/mm/debug.c b/mm/debug.c
> index fae0f81ad831..48af9829aee9 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -162,7 +162,7 @@ static void __dump_page(struct page *page)
>  out_mapping:
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
> -	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
> +	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags.f, &head->flags.f,

The %pGp case (here and elsewhere) could perhaps take the new type, no?
Would need to change format_page_flags() and flags_string() in lib/vsprintf.c
