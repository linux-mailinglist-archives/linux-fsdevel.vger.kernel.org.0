Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0F72FF66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244810AbjFNNDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjFNNDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:03:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDAD199C;
        Wed, 14 Jun 2023 06:03:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9F35219A1;
        Wed, 14 Jun 2023 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686747808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MU22H/MNDJGEWTigTjVbKwhrgWPT8oAuPxOTZnn1eHM=;
        b=RB7pkRCivSsE7KU1e6+RdYW6iTT0HlugUyrVn51a7TWkTduIH6/DOz7IuceXhn+9wnTZhS
        jNWIKLM6QF4ULmrK7MEuJBaiz07Gihq9s+2HMuT98sEGzglKEVCCfJw6nLnJAEM98KCGG8
        6+FR0kxGLGpe/n0Arg04TVD3fuWwxjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686747808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MU22H/MNDJGEWTigTjVbKwhrgWPT8oAuPxOTZnn1eHM=;
        b=lGUd2w/L0TFJ/VWS7jRtIrk6i8FIpWdj7zrzpZ98yqiDKIN2dMv+yY2roBSIyXlFgtiW1h
        QiBUbTTBlP4myiDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C74021357F;
        Wed, 14 Jun 2023 13:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zJwLMKC6iWRjTwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 13:03:28 +0000
Message-ID: <549489d7-ff60-b8d0-9241-60e54e454c14@suse.de>
Date:   Wed, 14 Jun 2023 15:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/7] brd: use XArray instead of radix-tree to index
 backing pages
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-2-hare@suse.de>
 <CGME20230614124605eucas1p13e57b1da46266467a71f124e40ab8252@eucas1p1.samsung.com>
 <ZIm2fqesAKAHHh5j@casper.infradead.org>
 <25657702-19a7-6523-21bd-c671935c2c2e@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <25657702-19a7-6523-21bd-c671935c2c2e@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/23 14:50, Pankaj Raghav wrote:
>>>   
>>> -		/*
>>> -		 * It takes 3.4 seconds to remove 80GiB ramdisk.
>>> -		 * So, we need cond_resched to avoid stalling the CPU.
>>> -		 */
>>> -		cond_resched();
>>> +	xa_for_each(&brd->brd_pages, idx, page) {
>>> +		__free_page(page);
>>> +		cond_resched_rcu();
>>
>> This should be a regular cond_resched().  The body of the loop is run
>> without the RCU read lock held.  Surprised none of the bots have noticed
>> an unlock-underflow.  Perhaps they don't test brd ;-)
>>
>> With that fixed,
>>
>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This patch is already queued up for 6.5 in Jens's tree.
> I will send this as a fix soon. Thanks.

Ah. Hence. I've been running off akpms mm-unstable branch, which doesn't 
have that patch (yet).

Cheers,

Hannes

