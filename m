Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1386C359D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 16:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCUP0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCUP0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:26:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9624FCC1;
        Tue, 21 Mar 2023 08:26:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 06D9A201A2;
        Tue, 21 Mar 2023 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679412387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHCbxvEjKOCYot1TTU/89XdN70pMiGLRyCU4Q3dVZWM=;
        b=BqM2UZjmV8ztE6hEHNUxaqezY8+lLRir4PU85eB4qM5Y/TUYY2Yqir8fVHhaUCmOEEEy9W
        CKpCu6RRvUknfCahvnkNJlKbnWxZhYBpgaCuOkEMV++tgnfWPPMVSqyqFHBoeK59P1z71L
        6jJ0t/citRikS93ERyilEzC4AYqwjOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679412387;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHCbxvEjKOCYot1TTU/89XdN70pMiGLRyCU4Q3dVZWM=;
        b=kh4QJnPp6A9z1s/gk+Je+Xxosy5KRUVMUm0VW6U7uzbHD+HZeeMv0Ob6U4C/5Mc5XletR+
        PG+uzlQE9zmvrcAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4A9113440;
        Tue, 21 Mar 2023 15:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DQ0UN6LMGWRrWAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 21 Mar 2023 15:26:26 +0000
Message-ID: <0e54cc51-e667-b343-74b0-4989e28d8982@suse.de>
Date:   Tue, 21 Mar 2023 16:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] brd: convert to folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-2-hare@suse.de> <ZAYk5wOUaXAIouQ5@casper.infradead.org>
 <76613838-fa4c-7f3e-3417-7a803fafc6c2@suse.de>
 <ZAboHUp/YUkEs/D1@casper.infradead.org>
 <a4489f7b-912c-e68f-4a4c-c14d96026bd6@suse.de>
 <ZBnGc4WbBOlnRUgd@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZBnGc4WbBOlnRUgd@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/21/23 16:00, Matthew Wilcox wrote:
> On Tue, Mar 07, 2023 at 09:14:27AM +0100, Hannes Reinecke wrote:
>> On 3/7/23 08:30, Matthew Wilcox wrote:
>>> On Tue, Mar 07, 2023 at 07:55:32AM +0100, Hannes Reinecke wrote:
>>>> On 3/6/23 18:37, Matthew Wilcox wrote:
>>>>> On Mon, Mar 06, 2023 at 01:01:23PM +0100, Hannes Reinecke wrote:
>>>>>> -	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
>>>>>> -	if (!page)
>>>>>> +	folio = folio_alloc(gfp | __GFP_ZERO, 0);
>>>>>> +	if (!folio)
>>>>>
>>>>> Did you drop HIGHMEM support on purpose?
>>>>
>>>> No; I thought that folios would be doing that implicitely.
>>>> Will be re-adding.
>>>
>>> We can't ... not all filesystems want to allocate every folio from
>>> HIGHMEM.  eg for superblocks, it often makes more sense to allocate the
>>> folio from lowmem than allocate it from highmem and keep it kmapped.
>>> The only GFP flag that folios force-set is __GFP_COMP because folios by
>>> definition are compound pages.
>>
>> Oh well.
>>
>> However, when playing with the modified brd and setting the logical&physical
>> blocksize to 16k the whole thing crashes
>> (not unexpectedly).
>> It does crash, however, in block_read_full_folio(), which rather
>> surprisingly (at least for me) is using create_page_buffers();
>> I would have expected something like create_folio_buffers().
>> Is this work in progress or what is the plan here?
> 
> Supporting folios > PAGE_SIZE in blockdev is definitely still WIP.
> I know of at least one bug, which is:
> 
> #define bh_offset(bh)           ((unsigned long)(bh)->b_data & ~PAGE_MASK)
> 
> That needs to be something like
> 
> static size_t bh_offset(const struct buffer_head *bh)
> {
> 	return (unsigned long)bh->b_data & (folio_size(bh->b_folio) - 1);
> }
> 
> I haven't done a thorough scan for folio-size problems in the block
> layer; I've just been fixing up things as I notice them.
> 
And not to mention the various instances of (PAGE_SHIFT - blkbits)
which will get happily into negative numbers for large block sizes,
resulting in interesting effects for a shift left operation ...

> Yes, create_page_buffers() should now be create_folio_buffers().  Just
> didn't get round to it yet.

Ah, so I was on the right track after all.

But I was wondering ... couldn't we use the physical block size as a 
hint on how many pages to allocate?
With that we can work on updating the stack even with existing hardware, 
and we wouldn't crash immediately if we miss the odd conversion ...

Hmm?

Cheers,

Hannes

