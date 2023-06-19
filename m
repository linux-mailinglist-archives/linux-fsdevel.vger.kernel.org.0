Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC6734E46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 10:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFSIpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFSIof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:44:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA612D57;
        Mon, 19 Jun 2023 01:42:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA5A5215EF;
        Mon, 19 Jun 2023 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687164158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iD5CAoRTyTuD6OXJhPQckuXzvJWsRZOlerzSNLKcC0k=;
        b=UZ7rMBzApu1QynkvxBQ9iruiOFPMQ5p06xamqiYbSI+JSkMI+gzLYMGi5ce+a3GId5iLen
        AxksH7wBqZB6/oo6KTaVxem9DJpsq01kaNCA516BAF2dwuajb4fNvQme4NZNGdPtEKVBjn
        w2jZFs8umMBf0YXW+YPdzCOnAVtkiXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687164158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iD5CAoRTyTuD6OXJhPQckuXzvJWsRZOlerzSNLKcC0k=;
        b=PgnY3DCl96IEFGNrgaNaV29S6rFlQLtOOurW3aJg6ck5740BWMdGMw11eEXYRzE6v0aKW3
        TzXf5bx14j7KMVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CADC9139C2;
        Mon, 19 Jun 2023 08:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vm7kMP4UkGQVGwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 19 Jun 2023 08:42:38 +0000
Message-ID: <b6d982ce-3e7e-e433-8339-28ec8474df03@suse.de>
Date:   Mon, 19 Jun 2023 10:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/7] mm/filemap: allocate folios with mapping blocksize
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>, gost.dev@samsung.com
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-7-hare@suse.de>
 <CGME20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67@eucas1p2.samsung.com>
 <20230619080857.qxx5c7uaz6pm4h3m@localhost>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230619080857.qxx5c7uaz6pm4h3m@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/23 10:08, Pankaj Raghav wrote:
> Hi Hannes,
> On Wed, Jun 14, 2023 at 01:46:36PM +0200, Hannes Reinecke wrote:
>> The mapping has an underlying blocksize (by virtue of
>> mapping->host->i_blkbits), so if the mapping blocksize
>> is larger than the pagesize we should allocate folios
>> in the correct order.
>>
> Network filesystems such as 9pfs set the blkbits to be maximum data it
> wants to transfer leading to unnecessary memory pressure as we will try
> to allocate higher order folios(Order 5 in my setup). Isn't it better
> for each filesystem to request the minimum folio order it needs for its
> page cache early on? Block devices can do the same for its block cache.
> 
> I have prototype along those lines and I will it soon. This is also
> something willy indicated before in a mailing list conversation.
> 
Well; I _though_ that's why we had things like optimal I/O size and
maximal I/O size. But this seem to be relegated to request queue limits,
so I guess it's not available from 'struct block_device' or 'struct 
gendisk'.

So I've been thinking of adding a flag somewhere (possibly in
'struct address_space') to indicate that blkbits is a hard limit
and not just an advisory thing.

But indeed, I've seen this with NFS, too, which insists on setting 
blkbits to something like 8.

Cheers,

Hannes

