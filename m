Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD49651F8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Dec 2022 12:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLTLSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Dec 2022 06:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLTLSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:18:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4455F9B;
        Tue, 20 Dec 2022 03:18:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A297D33C30;
        Tue, 20 Dec 2022 11:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671535081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFzpR3ITDH29coyW0R/YQvOd5YVJvu4hwuDQhKVr1dc=;
        b=Vh3OgJ3l3canONyLvqymtEPjSWpPWNY7ld/EuleZo2lQgBk8j2gYPhm92i1LM6pjciB0jq
        4U97lQn50BuxXa/Gewbuxa6VMwmelY7sCQsd81KDvzgvjg4Dry+l8JWZQO5Y6McEzHXS4f
        hKwvUGiHAiFNgyw0r5u+fKUO6VM9uX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671535081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lFzpR3ITDH29coyW0R/YQvOd5YVJvu4hwuDQhKVr1dc=;
        b=M0FaHbmOtv8X+d3hOcyF0AmbEX9CgGWXZrGvBpdOIiF2JhOY8WqG7l8AiHUtkapH4cE3TV
        yRS7EuIS5mrzl5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 953EC1390E;
        Tue, 20 Dec 2022 11:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GcFoJOmZoWODUgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 20 Dec 2022 11:18:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2796FA0732; Tue, 20 Dec 2022 12:18:01 +0100 (CET)
Date:   Tue, 20 Dec 2022 12:18:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, reiserfs-devel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 5/8] reiserfs: Convert do_journal_end() to use
 kmap_local_folio()
Message-ID: <20221220111801.jhukawk3lbuonxs3@quack3>
References: <20221216205348.3781217-1-willy@infradead.org>
 <20221216205348.3781217-6-willy@infradead.org>
 <Y55WUrzblTsw6FfQ@iweiny-mobl>
 <Y6GB75HMEKfcGcsO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6GB75HMEKfcGcsO@casper.infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-12-22 09:35:43, Matthew Wilcox wrote:
> But that doesn't solve the "What about fs block size > PAGE_SIZE"
> problem that we also want to solve.  Here's a concrete example:
> 
>  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
>  {
> -       struct page *page = bh->b_page;
> +       struct folio *folio = bh->b_folio;
>         char *addr;
>         __u32 checksum;
>  
> -       addr = kmap_atomic(page);
> -       checksum = crc32_be(crc32_sum,
> -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> -       kunmap_atomic(addr);
> +       BUG_ON(IS_ENABLED(CONFIG_HIGHMEM) && bh->b_size > PAGE_SIZE);
> +
> +       addr = kmap_local_folio(folio, offset_in_folio(folio, bh->b_data));
> +       checksum = crc32_be(crc32_sum, addr, bh->b_size);
> +       kunmap_local(addr);
>  
>         return checksum;
>  }
> 
> I don't want to add a lot of complexity to handle the case of b_size >
> PAGE_SIZE on a HIGHMEM machine since that's not going to benefit terribly
> many people.  I'd rather have the assertion that we don't support it.
> But if there's a good higher-level abstraction I'm missing here ...

Just out of curiosity: So far I was thinking folio is physically contiguous
chunk of memory. And if it is, then it does not seem as a huge overkill if
kmap_local_folio() just maps the whole folio? Or are you concerned about
the overhead of finding big enough hole in the vmap area?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
