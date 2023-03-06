Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC76ABF04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCFMEN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 07:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCFMEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:04:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4F22000;
        Mon,  6 Mar 2023 04:04:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 144651FE65;
        Mon,  6 Mar 2023 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLNDYnpl5Xel5rnk0bBhZ9HfM1ScJkIYMJK4yAfABqI=;
        b=yvivUIiDTsVyhHd/0L1pRMpDzoB/MiI4w//DZvw3XaQAnjNopd96nix0GFWS1wimijtrv2
        PQ/5m7AqEhNxv98Lfs24nNPQqmNOBtqfsZMGlpZHlxd6QXNIRJ9NSL+9xlsNh4mstUFELD
        A3y885Uz0pJJnV9SpkvYtkL3Imr06Gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104242;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vLNDYnpl5Xel5rnk0bBhZ9HfM1ScJkIYMJK4yAfABqI=;
        b=X2K10tSZduj/mpNTfYMhnDz5eGDj2NQ2uEXvBz0xEZhoWHD8x/jNDOdUxjRqMSpKkP989u
        nNW0FZUWttCw34CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0388713A66;
        Mon,  6 Mar 2023 12:04:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TuQfALLWBWTkLwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 06 Mar 2023 12:04:02 +0000
Message-ID: <d3e359f6-8c23-c624-688b-5dc1b40b6ee1@suse.de>
Date:   Mon, 6 Mar 2023 13:04:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
 <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
 <ZAN0JkklyCRIXVo6@casper.infradead.org>
 <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAQXduwAcAtIZHkB@bombadil.infradead.org>
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

On 3/5/23 05:15, Luis Chamberlain wrote:
> On Sat, Mar 04, 2023 at 04:39:02PM +0000, Matthew Wilcox wrote:
>> I'm getting more and more
>> comfortable with the idea that "Linux doesn't support block sizes >
>> PAGE_SIZE on 32-bit machines" is an acceptable answer.
> 
> First of all filesystems would need to add support for a larger block
> sizes > PAGE_SIZE, and that takes effort. It is also a support question
> too.
> 
> I think garnering consensus from filesystem developers we don't want
> to support block sizes > PAGE_SIZE on 32-bit systems would be a good
> thing to review at LSFMM or even on this list. I hightly doubt anyone
> is interested in that support.
> 
>> XFS already works with arbitrary-order folios.
> 
> But block sizes > PAGE_SIZE is work which is still not merged. It
> *can* be with time. That would allow one to muck with larger block
> sizes than 4k on x86-64 for instance. Without this, you can't play
> ball.
> 
>> The only needed piece is
>> specifying to the VFS that there's a minimum order for this particular
>> inode, and having the VFS honour that everywhere.
> 
> Other than the above too, don't we still also need to figure out what
> fs APIs would incur larger order folios? And then what about corner cases
> with the page cache?
> 
> I was hoping some of these nooks and crannies could be explored with tmpfs.
> 
I have just posted patchset for 'brd' to linux-block for supporting 
arbitrary block sizes, both physical and logical. That should be giving 
us a good starting point for experimenting.

Cheers,

Hannes

