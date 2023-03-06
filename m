Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C056ABAAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 11:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCFKF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 05:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCFKFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:05:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBF712F1A;
        Mon,  6 Mar 2023 02:05:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 303971FDDD;
        Mon,  6 Mar 2023 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678097121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRb9m2gaQoCLctLOiYS3tE6uGi3yOZ0FLkQqw+fFybA=;
        b=TCnLqFQlPrObIJ2juVIYjrKmRoTrx3k99z6KhVWYekZPPw4ynNrbxuEsuJyGzff3GXyFrc
        CT1C3eappXnvVCbJf0hQ0fzjmVpnF9YlkcQBlsqQDlNpTvb3caMPsk4txIfgvmN4gv/vN/
        0r9LGeBBDqu5g9VOWeI5mjwMNpGveMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678097121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRb9m2gaQoCLctLOiYS3tE6uGi3yOZ0FLkQqw+fFybA=;
        b=7QsEJHCXVvi7r+XMVVSbIhVXqO5yz9jL2VMCXu13ylzuQLIZRnMx4a1gUJcfr6lVtP1Xi1
        dvhhF7CN5Z15hZBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17ACE13A66;
        Mon,  6 Mar 2023 10:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BJXfBOG6BWSXbwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 06 Mar 2023 10:05:21 +0000
Message-ID: <d1976bc4-0350-256e-2f88-028278a3b9fa@suse.de>
Date:   Mon, 6 Mar 2023 11:05:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
 <ZAWi5KwrsYL+0Uru@casper.infradead.org>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAWi5KwrsYL+0Uru@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/6/23 09:23, Matthew Wilcox wrote:
> On Sun, Mar 05, 2023 at 12:22:15PM +0100, Hannes Reinecke wrote:
>> On 3/4/23 18:54, Matthew Wilcox wrote:
>>> I think we're talking about different things (probably different storage
>>> vendors want different things, or even different people at the same
>>> storage vendor want different things).
>>>
>>> Luis and I are talking about larger LBA sizes.  That is, the minimum
>>> read/write size from the block device is 16kB or 64kB or whatever.
>>> In this scenario, the minimum amount of space occupied by a file goes
>>> up from 512 bytes or 4kB to 64kB.  That's doable, even if somewhat
>>> suboptimal.
>>>
>> And so do I. One can view zones as really large LBAs.
>>
>> Indeed it might be suboptimal from the OS point of view.
>> But from the device point of view it won't.
>> And, in fact, with devices becoming faster and faster the question is
>> whether sticking with relatively small sectors won't become a limiting
>> factor eventually.
>>
>>> Your concern seems to be more around shingled devices (or their equivalent
>>> in SSD terms) where there are large zones which are append-only, but
>>> you can still random-read 512 byte LBAs.  I think there are different
>>> solutions to these problems, and people are working on both of these
>>> problems.
>>>
>> My point being that zones are just there because the I/O stack can only deal
>> with sectors up to 4k. If the I/O stack would be capable of dealing
>> with larger LBAs one could identify a zone with an LBA, and the entire issue
>> of append-only and sequential writes would be moot.
>> Even the entire concept of zones becomes irrelevant as the OS would
>> trivially only write entire zones.
> 
> All current filesystems that I'm aware of require their fs block size
> to be >= LBA size.  That is, you can't take a 512-byte blocksize ext2
> filesystem and put it on a 4kB LBA storage device.
> 
> That means that files can only grow/shrink in 256MB increments.  I
> don't think that amount of wasted space is going to be acceptable.
> So if we're serious about going down this path, we need to tell
> filesystem people to start working out how to support fs block
> size < LBA size.
> 
> That's a big ask, so let's be sure storage vendors actually want
> this.  Both supporting zoned devices & suporting 16k/64k block
> sizes are easier asks.

Why, I know. And this really is a future goal.
(Possibly a very _distant_ future goal.)

Indeed we should concentrate on getting 16k/64k blocks initially.
Or maybe 128k blocks to help our RAIDed friends.

Cheers,

Hannes

