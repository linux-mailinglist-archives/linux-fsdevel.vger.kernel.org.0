Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136C23B1BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFWOED (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:04:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52454 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhFWOD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:03:59 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B3891FD36;
        Wed, 23 Jun 2021 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624456901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/XMjSd1ArDZiIdvvGl7Gc1Zip3z1VcHSbThBZcRsbU=;
        b=Liy48y4JOsar34wdSnIy6K5wq1ggqhq6uhJwS3fOzYB6q+I9JmDN7Semc1W+vqgcijH8kP
        OxT8FNFGp8bGHL1afLHaWHL7rDIAbiIMaveQtXCVeuw5/HjBwg1eszoRrUUcy/nfa3z8/p
        ICjBvLTTts9DdFwMiuBucu2L65nmBuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624456901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/XMjSd1ArDZiIdvvGl7Gc1Zip3z1VcHSbThBZcRsbU=;
        b=vV9it4GNyXZqJ98l4XIea1URtJ/rCX++dM0Jenmg4X9Yfr9ISPNGHxzFRRZ3srBwesAgTM
        N6yiVJ/Qg/qIyqBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A7EC711A97;
        Wed, 23 Jun 2021 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624456901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/XMjSd1ArDZiIdvvGl7Gc1Zip3z1VcHSbThBZcRsbU=;
        b=Liy48y4JOsar34wdSnIy6K5wq1ggqhq6uhJwS3fOzYB6q+I9JmDN7Semc1W+vqgcijH8kP
        OxT8FNFGp8bGHL1afLHaWHL7rDIAbiIMaveQtXCVeuw5/HjBwg1eszoRrUUcy/nfa3z8/p
        ICjBvLTTts9DdFwMiuBucu2L65nmBuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624456901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/XMjSd1ArDZiIdvvGl7Gc1Zip3z1VcHSbThBZcRsbU=;
        b=vV9it4GNyXZqJ98l4XIea1URtJ/rCX++dM0Jenmg4X9Yfr9ISPNGHxzFRRZ3srBwesAgTM
        N6yiVJ/Qg/qIyqBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id DRUgKMQ+02BcTwAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 23 Jun 2021 14:01:40 +0000
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
To:     Lennart Poettering <mzxreary@0pointer.de>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
 <YNM8T44v5FTViVWM@gardel-login>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
Date:   Wed, 23 Jun 2021 16:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YNM8T44v5FTViVWM@gardel-login>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/21 3:51 PM, Lennart Poettering wrote:
> On Mi, 23.06.21 15:10, Matteo Croce (mcroce@linux.microsoft.com) wrote:
> 
>> On Wed, Jun 23, 2021 at 1:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> On Wed, Jun 23, 2021 at 12:58:53PM +0200, Matteo Croce wrote:
>>>> +void inc_diskseq(struct gendisk *disk)
>>>> +{
>>>> +     static atomic64_t diskseq;
>>>
>>> Please don't hide file scope variables in functions.
>>>
>>
>> I just didn't want to clobber that file namespace, as that is the only
>> point where it's used.
>>
>>> Can you explain a little more why we need a global sequence count vs
>>> a per-disk one here?
>>
>> The point of the whole series is to have an unique sequence number for
>> all the disks.
>> Events can arrive to the userspace delayed or out-of-order, so this
>> helps to correlate events to the disk.
>> It might seem strange, but there isn't a way to do this yet, so I come
>> up with a global, monotonically incrementing number.
> 
> To extend on this and given an example why the *global* sequence number
> matters:
> 
> Consider you plug in a USB storage key, and it gets named
> /dev/sda. You unplug it, the kernel structures for that device all
> disappear. Then you plug in a different USB storage key, and since
> it's the only one it will too be called /dev/sda.
> 
> With the global sequence number we can still distinguish these two
> devices even though otherwise they can look pretty much identical. If
> we had per-device counters then this would fall flat because the
> counter would be flushed out when the device disappears and when a device
> reappears under the same generic name we couldn't assign it a
> different sequence number than before.
> 
> Thus: a global instead of local sequence number counter is absolutely
> *key* for the problem this is supposed to solve
> 
Well ... except that you'll need to keep track of the numbers (otherwise 
you wouldn't know if the numbers changed, right?).
And if you keep track of the numbers you probably will have to implement 
an uevent listener to get the events in time.
But if you have an uevent listener you will also get the add/remove 
events for these devices.
And if you get add and remove events you can as well implement sequence 
numbers in your application, seeing that you have all information 
allowing you to do so.
So why burden the kernel with it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
