Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9C6AAF44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Mar 2023 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCELWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Mar 2023 06:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCELWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Mar 2023 06:22:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F58A5F4;
        Sun,  5 Mar 2023 03:22:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84B8D1FD7C;
        Sun,  5 Mar 2023 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678015336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT2Kt/wYAneV6Cu1tgTYC07zTeFUojM/srzHygHKBtU=;
        b=WRXL6GpifPqmw4W8ELX7M424mNrEcN04dA8F7Qusm6xPxGWWB1phA7oIsLgeWA69iG8G2P
        OgF8cbg/5i1Eo0g7Cqr9arZ+YUEmQXfSq1dF0De5dSl75BtelmXZ51n++mVidOekQb9R5j
        nE58/h8IYoCwlvUF8t/HW+gKq0RQg74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678015336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT2Kt/wYAneV6Cu1tgTYC07zTeFUojM/srzHygHKBtU=;
        b=qvdLGlsSkSEZaROxqIHvRBGHmNxo0U7YNlfGJASUf/g/JEFqphjw9rHlEp2OM2iNkqUJjF
        2/+v+CVYCJG48SAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B4091339E;
        Sun,  5 Mar 2023 11:22:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iMgXBmh7BGTZYAAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 05 Mar 2023 11:22:16 +0000
Message-ID: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
Date:   Sun, 5 Mar 2023 12:22:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
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
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAOF3p+vqA6pd7px@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/23 18:54, Matthew Wilcox wrote:
> On Sat, Mar 04, 2023 at 06:17:35PM +0100, Hannes Reinecke wrote:
>> On 3/4/23 17:47, Matthew Wilcox wrote:
>>> On Sat, Mar 04, 2023 at 12:08:36PM +0100, Hannes Reinecke wrote:
>>>> We could implement a (virtual) zoned device, and expose each zone as a
>>>> block. That gives us the required large block characteristics, and with
>>>> a bit of luck we might be able to dial up to really large block sizes
>>>> like the 256M sizes on current SMR drives.
>>>> ublk might be a good starting point.
>>>
>>> Ummmm.  Is supporting 256MB block sizes really a desired goal?  I suggest
>>> that is far past the knee of the curve; if we can only write 256MB chunks
>>> as a single entity, we're looking more at a filesystem redesign than we
>>> are at making filesystems and the MM support 256MB size blocks.
>>>
>> Naa, not really. It _would_ be cool as we could get rid of all the cludges
>> which have nowadays re sequential writes.
>> And, remember, 256M is just a number someone thought to be a good
>> compromise. If we end up with a lower number (16M?) we might be able
>> to convince the powers that be to change their zone size.
>> Heck, with 16M block size there wouldn't be a _need_ for zones in
>> the first place.
>>
>> But yeah, 256M is excessive. Initially I would shoot for something
>> like 2M.
> 
> I think we're talking about different things (probably different storage
> vendors want different things, or even different people at the same
> storage vendor want different things).
> 
> Luis and I are talking about larger LBA sizes.  That is, the minimum
> read/write size from the block device is 16kB or 64kB or whatever.
> In this scenario, the minimum amount of space occupied by a file goes
> up from 512 bytes or 4kB to 64kB.  That's doable, even if somewhat
> suboptimal.
> 
And so do I. One can view zones as really large LBAs.

Indeed it might be suboptimal from the OS point of view.
But from the device point of view it won't.
And, in fact, with devices becoming faster and faster the question is
whether sticking with relatively small sectors won't become a limiting 
factor eventually.

> Your concern seems to be more around shingled devices (or their equivalent
> in SSD terms) where there are large zones which are append-only, but
> you can still random-read 512 byte LBAs.  I think there are different
> solutions to these problems, and people are working on both of these
> problems.
> 
My point being that zones are just there because the I/O stack can only 
deal with sectors up to 4k. If the I/O stack would be capable of dealing
with larger LBAs one could identify a zone with an LBA, and the entire 
issue of append-only and sequential writes would be moot.
Even the entire concept of zones becomes irrelevant as the OS would 
trivially only write entire zones.

> But if storage vendors are really pushing for 256MB LBAs, then that's
> going to need a third kind of solution, and I'm not aware of anyone
> working on that.

What I was saying is that 256M is not set in stone. It's just a 
compromise vendors used. Even if in the course of development we arrive
at a lower number of max LBA we can handle (say, 2MB) I am pretty
sure vendors will be quite interested in that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

