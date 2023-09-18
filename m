Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34EC7A4889
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjIRLg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbjIRLfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:35:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91809CC7;
        Mon, 18 Sep 2023 04:34:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4409021B04;
        Mon, 18 Sep 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695036886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsDDklBjIFoM7Jl8EU+BYlHZ0g3Sye7Xs6k5RDaXpUQ=;
        b=1Ma+WufOY6MNQBSldMuieR9ZpirsJTdWcZsxqGoF3hzkrSmWYdUzna299yvRM5B3QCSSra
        /JRoQvQMcnCpDBDCZwK+FqMy4pbuDhN+IQjN3aUGfjBWq10TYlBDowLFK/iFg0p58MO8WZ
        PNgDtYb8GfwbFTLuknhCQayMBKCbPMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695036886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsDDklBjIFoM7Jl8EU+BYlHZ0g3Sye7Xs6k5RDaXpUQ=;
        b=lWxYWMG8V1e8y9ZvkPybRmpUpLTWqw/jpn9kAQofvAoPUVWxscsPv0GWi4rsXS3NH9Nk2b
        06wsECm6iRw7PZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDBA913480;
        Mon, 18 Sep 2023 11:34:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 33muM9M1CGXIWgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 18 Sep 2023 11:34:43 +0000
Message-ID: <7dbf0a76-d811-4cb0-a38e-8375334710b2@suse.de>
Date:   Mon, 18 Sep 2023 13:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        djwong@kernel.org, dchinner@redhat.com, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, brauner@kernel.org,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQd/7RYfDZgvR0n2@dread.disaster.area>
 <ZQeIaN2WC+whc/OP@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQeIaN2WC+whc/OP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 01:14, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 08:38:37AM +1000, Dave Chinner wrote:
>> On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
>>> LBS devices. This in turn allows filesystems which support bs > 4k to be
>>> enabled on a 4k PAGE_SIZE world on LBS block devices. This alows LBS
>>> device then to take advantage of the recenlty posted work today to enable
>>> LBS support for filesystems [0].
>>
>> Why do we need LBS devices to support bs > ps in XFS?
> 
> It's the other way round -- we need the support in the page cache to
> reject sub-block-size folios (which is in the other patches) before we
> can sensibly talk about enabling any filesystems on top of LBS devices.
> Even XFS, or for that matter ext2 which support 16k block sizes on
> CONFIG_PAGE_SIZE_16K (or 64K) kernels need that support first.
> 
> [snipping the parts I agree with; this should not be the first you're
> hearing about a format change to XFS]
> 
>>> There might be a better way to do this than do deal with the switching
>>> of the aops dynamically, ideas welcomed!
>>
>> Is it even safe to switch aops dynamically? We know there are
>> inherent race conditions in doing this w.r.t. mmap and page faults,
>> as the write fault part of the processing is directly dependent
>> on the page being correctly initialised during the initial
>> population of the page data (the "read fault" side of the write
>> fault).
>>
>> Hence it's not generally considered safe to change aops from one
>> mechanism to another dynamically. Block devices can be mmap()d, but
>> I don't see anything in this patch set that ensures there are no
>> other users of the block device when the swaps are done. What am I
>> missing?
> 
> We need to evict all pages from the page cache before switching aops to
> prevent misinterpretation of folio->private.  If switching aops is even
> the right thing to do.  I don't see the problem with allowing buffer heads
> on block devices, but I haven't been involved with the discussion here.

Did we even have that conversation?
That's one of the first things I've stumbled across when doing my 
patchset, and found the implications too horrible to consider.

Not a big fan, plus I don't think we need that.
Cf my patchset :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

