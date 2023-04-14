Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F266E248C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDNNrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjDNNrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:47:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8E9ED5;
        Fri, 14 Apr 2023 06:47:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B86411FD93;
        Fri, 14 Apr 2023 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681480033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajmFE6Zi5E0kFarCrrp3zOpi52yQcaNcPX2buw3jjfE=;
        b=AXdz1Ud+8140tiPHlpnkqBvDKNa0sSnPbave2PZdeAtOPIiQKjrh/wCIKijiAtKfxjQx4P
        tW6bNksV0IFXF3SL1VFPwt9ad/CQ24Gtz49NJug3puJkNteq4fwIx1clk2tPIIlSRq+77g
        oTw4gXTZf/+VC9vrk/wh04d44c7U+X4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681480033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajmFE6Zi5E0kFarCrrp3zOpi52yQcaNcPX2buw3jjfE=;
        b=TgfKKamaEXaEkVgxr+kQCWNGX9vVeG8nFYlTkCxxpQTxG9c7xquRgnszt5DXMz5heqirHl
        GD7xXyI6gU5pCTBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C4C913498;
        Fri, 14 Apr 2023 13:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KNPUIWFZOWS1EQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 14 Apr 2023 13:47:13 +0000
Message-ID: <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
Date:   Fri, 14 Apr 2023 15:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230414110821.21548-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/14/23 13:08, Pankaj Raghav wrote:
> One of the first kernel panic we hit when we try to increase the
> block size > 4k is inside create_page_buffers()[1]. Even though buffer.c
> function do not support large folios (folios > PAGE_SIZE) at the moment,
> these changes are required when we want to remove that constraint.
> 
> Willy had already mentioned that he wanted to convert create_page_buffers to
> create_folio_buffers but didn't get to it yet, so I decided to take a
> shot.
> 
> No functional changes introduced.
> 
> OI:
> - I don't like the fact that I had to introduce
>    folio_create_empty_buffers() as create_empty_buffers() is used in
>    many parts of the kernel. Should I do a big bang change as a part of
>    this series where we convert create_empty_buffers to take a folio and
>    change the callers to pass a folio instead of a page?
> 
> - I split the series into 4 commits for clarity. I could squash them
>    into one patch if needed.
> 
> [1] https://lore.kernel.org/all/ZBnGc4WbBOlnRUgd@casper.infradead.org/
> 
> Pankaj Raghav (4):
>    fs/buffer: add set_bh_folio helper
>    buffer: add alloc_folio_buffers() helper
>    fs/buffer: add folio_create_empty_buffers helper
>    fs/buffer: convert create_page_buffers to create_folio_buffers
> 
>   fs/buffer.c                 | 131 +++++++++++++++++++++++++++++++++---
>   include/linux/buffer_head.h |   4 ++
>   2 files changed, 125 insertions(+), 10 deletions(-)
> 
Funnily enough, I've been tinkering along the same lines, and ended up 
with pretty similar patches.
I've had to use two additional patches to get my modified 'brd' driver 
off the ground with logical blocksize of 16k:
- mm/filemap: allocate folios according to the blocksize
   (will be sending the patch separately)
- Modify read_folio() to use the correct order:

@@ -2333,13 +2395,15 @@ int block_read_full_folio(struct folio *folio, 
get_block_t *get_block)
         if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
                 limit = inode->i_sb->s_maxbytes;

-       VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
-
         head = create_folio_buffers(folio, inode, 0);
         blocksize = head->b_size;
         bbits = block_size_bits(blocksize);

-       iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+       if (WARN_ON(PAGE_SHIFT < bbits)) {
+               iblock = (sector_t)folio->index >> (bbits - PAGE_SHIFT);
+       } else {
+               iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
+       }
         lblock = (limit+blocksize-1) >> bbits;
         bh = head;
         nr = 0;


With that (and my modified brd driver) I've been able to set the logical 
blocksize to 16k for brd and have it happily loaded.
Haven't tested the write path yet, though; there's surely quite some 
work to be done.

BTW; I've got another patch replacing 'writepage' with 'write_folio'
(and the corresponding argument update). Is that a direction you want to go?

Cheers,

Hannes

