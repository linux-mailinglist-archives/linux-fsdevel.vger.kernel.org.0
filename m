Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A806E3F57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDQGEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 02:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQGEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:04:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F732116;
        Sun, 16 Apr 2023 23:04:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD91D21A36;
        Mon, 17 Apr 2023 06:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681711482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrkQqEZwaf8aOA/KoAyOi6UrBxwxGW9M2sCoRTZStv0=;
        b=WLod/41MS3MSM8lV3g7lnbAyQq7Oyz5uV1e6EO3ZzPMOgBYiP4qb3zeGAY1iqF1yl3QInK
        1wfcMkSadpsWfIN6IdrFUmbGUgxZK5S0HQhByvg9DTFYj10OsKDTdEQgo/ue7+xF3NGxAD
        Rzvzul7ksZPpwUAdKN5scAvVcK1aaEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681711482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrkQqEZwaf8aOA/KoAyOi6UrBxwxGW9M2sCoRTZStv0=;
        b=QOOo96nLPf9dmolrUwN/eUK2w3JW7nfFX/L5MBQEDvOZRGNOvozSje6+KzChcEILrKk9bQ
        FxSvSIP/VHgu04BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8269E1390E;
        Mon, 17 Apr 2023 06:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f+h9HXrhPGQEegAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 06:04:42 +0000
Message-ID: <a04dc769-9c4a-15e6-ad88-1cf11c646299@suse.de>
Date:   Mon, 17 Apr 2023 08:04:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDyuhmcc9OeJGUcJ@bombadil.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZDyuhmcc9OeJGUcJ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/17/23 04:27, Luis Chamberlain wrote:
> On Fri, Apr 14, 2023 at 03:47:13PM +0200, Hannes Reinecke wrote:
>> @@ -2333,13 +2395,15 @@ int block_read_full_folio(struct folio *folio,
>> get_block_t *get_block)
>>          if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
>>                  limit = inode->i_sb->s_maxbytes;
>>
>> -       VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>> -
>>          head = create_folio_buffers(folio, inode, 0);
>>          blocksize = head->b_size;
>>          bbits = block_size_bits(blocksize);
>>
>> -       iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
>> +       if (WARN_ON(PAGE_SHIFT < bbits)) {
>> +               iblock = (sector_t)folio->index >> (bbits - PAGE_SHIFT);
>> +       } else {
>> +               iblock = (sector_t)folio->index << (PAGE_SHIFT - bbits);
>> +       }
>>          lblock = (limit+blocksize-1) >> bbits;
>>          bh = head;
>>          nr = 0;
> 
> BTW I See this pattern in:
> 
> fs/mpage.c: do_mpage_readpage()
> fs/mpage.c: __mpage_writepage()
> 
> A helper might be in order.
> 

But only _iff_ we decide to stick with buffer_heads and upgrade the 
buffer_head code to handle multi-page block sizes.
The idea was to move over to iomap, hence I'm not sure into which
lengths we should go keeping buffer_heads alive ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

