Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE416AA942
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCDLIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCDLIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 06:08:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63903CDF2;
        Sat,  4 Mar 2023 03:08:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F34681F8A3;
        Sat,  4 Mar 2023 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677928118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8nRJtpacXYNk0+WXfCKEwQYrPwABhm/RayTz/uzNgw=;
        b=KPCSO8GPmt4qQVYlhAYmWT+4t7XAWh4RHgzjvspPmdR+MUpcqy8/s8xVECpBxRM6IKkI3x
        LOmd/NL5O3m3IgEsyKMoxMaPVROrpcHwTm3zWMH491aAZMSx5oLhM/UohEbQQsEl1jpE91
        6rUY07KzhMjrlz5iETceYQSt6yQKKu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677928118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8nRJtpacXYNk0+WXfCKEwQYrPwABhm/RayTz/uzNgw=;
        b=lb3KJ9H49XPaheuvU55FJLkgDmrInKpe2GMz7fDOhKjsh87iSGqbxOh5gMRETRk/Kwd7Gp
        7D5n8CvDKH+XOuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA5C913901;
        Sat,  4 Mar 2023 11:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P+QzLLUmA2SaTQAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 04 Mar 2023 11:08:37 +0000
Message-ID: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
Date:   Sat, 4 Mar 2023 12:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/23 22:45, Luis Chamberlain wrote:
> On Fri, Mar 03, 2023 at 03:49:29AM +0000, Matthew Wilcox wrote:
>> On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
>>> That said, I was hoping you were going to suggest supporting 16k logical block
>>> sizes. Not a problem on some arch's, but still problematic when PAGE_SIZE is
>>> 4k. :)
>>
>> I was hoping Luis was going to propose a session on LBA size > PAGE_SIZE.
>> Funnily, while the pressure is coming from the storage vendors, I don't
>> think there's any work to be done in the storage layers.  It's purely
>> a FS+MM problem.
> 
> You'd hope most of it is left to FS + MM, but I'm not yet sure that's
> quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
> physical & logical block NVMe devices gets brought down to 512 bytes.
> That seems odd to say the least. Would changing this be an issue now?
> 
> I'm gathering there is generic interest in this topic though. So one
> thing we *could* do is perhaps review lay-of-the-land of interest and
> break down what we all think are things likely could be done / needed.
> At the very least we can come out together knowing the unknowns together.
> 
> I started to think about some of these things a while ago and with the
> help of Willy I tried to break down some of the items I gathered from him
> into community OKRs (super informal itemization of goals and sub tasks which
> would complete such goals) and started trying to take a stab at them
> with our team, but obviously I think it would be great if we all just
> divide & and conquer here. So maybe reviewing these and extending them
> as a community would be good:
> 
> https://kernelnewbies.org/KernelProjects/large-block-size
> 
> I'm recently interested in tmpfs so will be taking a stab at higher
> order page size support there to see what blows up.
> 
Cool.

> The other stuff like general IOMAP conversion is pretty well known, and
> we already I think have a proposed session on that. But there is also
> even smaller fish to fry, like *just* doing a baseline with some
> filesystems with 4 KiB block size seems in order.
> 
> Hearing filesystem developer's thoughts on support for larger block
> size in light of lower order PAGE_SIZE would be good, given one of the
> odd situations some distributions / teams find themselves in is trying
> to support larger block sizes but with difficult access to higher
> PAGE_SIZE systems. Are there ways to simplify this / help us in general?
> Without it's a bit hard to muck around with some of this in terms of
> support long term. This also got me thinking about ways to try to replicate
> larger IO virtual devices a bit better too. While paying a cloud
> provider to test this is one nice option, it'd be great if I can just do
> this in house with some hacks too. For virtio-blk-pci at least, for instance,
> I wondered whether using just the host page cache suffices, or would a 4K
> page cache on the host modify say a 16 k emualated io controller results
> significantly? How do we most effectively virtualize 16k controllers
> in-house?
> 
> To help with experimenting with large io and NVMe / virtio-blk-pci I
> recented added support to intantiate tons of large IO devices to kdevops
> [0], with it it should be easy to reproduce odd issues we may come up
> with. For instnace it should be possible to subsequently extend the
> kdevops fstests or blktests automation support with just a few Kconfig files
> to use some of these largio devices to see what blows up.
> 
We could implement a (virtual) zoned device, and expose each zone as a 
block. That gives us the required large block characteristics, and with
a bit of luck we might be able to dial up to really large block sizes
like the 256M sizes on current SMR drives.
ublk might be a good starting point.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

