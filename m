Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AC2736350
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 07:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFTF5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 01:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjFTF5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:57:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26E9F;
        Mon, 19 Jun 2023 22:57:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF03D1F37C;
        Tue, 20 Jun 2023 05:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687240657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ayFb5oiOMa7P0FFFenkCC9cGwnzrTDxXXKPXgM4AhE=;
        b=N1kkG9u0d155mx+J83T10EP+QNExs6U2frPSfhzVgHYkeMoZGps9ysD/j/ylmCIsdolUeK
        1sXELFfpFJi29+lZ0Q+DPMglkROZCNQdRT/IngDRRAnYbBE0t8v5BdsZrNUMltqxtt1Nol
        UE12AEtPWinc9VRIvy/YT1v/ZXLQYi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687240657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ayFb5oiOMa7P0FFFenkCC9cGwnzrTDxXXKPXgM4AhE=;
        b=W4Xm9Aw5Q+1CDF49chTCkropaeMNoS3ojhjj8g5I8QMepTofcqrKnxMvW2jIXUXcdFGuX5
        YmVFkOdqSoUTPbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C3431346D;
        Tue, 20 Jun 2023 05:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qSApFdE/kWTdVAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 20 Jun 2023 05:57:37 +0000
Message-ID: <7c96006e-ac67-5b06-52e3-000389a638d1@suse.de>
Date:   Tue, 20 Jun 2023 07:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/7] mm/filemap: allocate folios with mapping blocksize
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>, gost.dev@samsung.com
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-7-hare@suse.de>
 <CGME20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67@eucas1p2.samsung.com>
 <20230619080857.qxx5c7uaz6pm4h3m@localhost>
 <b6d982ce-3e7e-e433-8339-28ec8474df03@suse.de>
 <ZJDdbPwfXI6eR5vB@dread.disaster.area>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZJDdbPwfXI6eR5vB@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/20/23 00:57, Dave Chinner wrote:
> On Mon, Jun 19, 2023 at 10:42:38AM +0200, Hannes Reinecke wrote:
>> On 6/19/23 10:08, Pankaj Raghav wrote:
>>> Hi Hannes,
>>> On Wed, Jun 14, 2023 at 01:46:36PM +0200, Hannes Reinecke wrote:
>>>> The mapping has an underlying blocksize (by virtue of
>>>> mapping->host->i_blkbits), so if the mapping blocksize
>>>> is larger than the pagesize we should allocate folios
>>>> in the correct order.
>>>>
>>> Network filesystems such as 9pfs set the blkbits to be maximum data it
>>> wants to transfer leading to unnecessary memory pressure as we will try
>>> to allocate higher order folios(Order 5 in my setup). Isn't it better
>>> for each filesystem to request the minimum folio order it needs for its
>>> page cache early on? Block devices can do the same for its block cache.
> 
> Folio size is not a "filesystem wide" thing - it's a per-inode
> configuration. We can have inodes within a filesystem that have
> different "block" sizes. A prime example of this is XFS directories
> - they can have 64kB block sizes on 4kB block size filesystem.
> 
> Another example is extent size hints in XFS data files - they
> trigger aligned allocation-around similar to using large folios in
> the page cache for small writes. Effectively this gives data files a
> "block size" of the extent size hint regardless of the filesystem
> block size.
> 
> Hence in future we might want different sizes of folios for
> different types of inodes and so whatever we do we need to support
> per-inode folio size configuration for the inode mapping tree.
> 
Sure. Using some mapping tree configuration was what I had in mind, too.

>>> I have prototype along those lines and I will it soon. This is also
>>> something willy indicated before in a mailing list conversation.
>>>
>> Well; I _though_ that's why we had things like optimal I/O size and
>> maximal I/O size. But this seem to be relegated to request queue limits,
>> so I guess it's not available from 'struct block_device' or 'struct
>> gendisk'.
> 
> Yes, those are block device constructs to enable block device based
> filesystems to be laid out best for the given block device. They
> don't exist for non-block-based filesystems like network
> filesystems...
> 
>> So I've been thinking of adding a flag somewhere (possibly in
>> 'struct address_space') to indicate that blkbits is a hard limit
>> and not just an advisory thing.
> 
> This still relies on interpreting inode->i_blkbits repeatedly at
> runtime in some way, in mm code that really has no business looking
> at filesystem block sizes.
> 
> What is needed is a field into the mapping that defines the
> folio order that all folios allocated for the page cache must be
> aligned/sized to to allow them to be inserted into the mapping.
> 
> This means the minimum folio order and alignment is maintained
> entirely by the mapping (e.g. it allows truncate to do the right
> thing), and the filesystem/device side code does not need to do
> anything special (except support large folios) to ensure that the
> page cache always contains folios that are block sized and aligned.
> 
> We already have mapping_set_large_folios() that we use at
> inode/mapping instantiation time to enable large folios in the page
> cache for that mapping. What we need is a new
> mapping_set_large_folio_order() API to enable the filesystem/device
> to set the base folio order for the mapping tree at instantiation
> time, and for all the page cache instantiation code to align/size to
> the order stored in the mapping...
> 
Having a mapping_set_large_folio_order() (or maybe 
mapping_set_folio_order(), for as soon as order > 0 we will have large
folios ...) looks like a good idea.
I'll give it a go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

