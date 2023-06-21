Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F37381AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 13:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjFULCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFULCf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:02:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7BBBC;
        Wed, 21 Jun 2023 04:02:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 297B01FD6A;
        Wed, 21 Jun 2023 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687345353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnziWqeIZNrvl2O+xZ1w8A8qnxuxPCpJZgtJgpYEvPU=;
        b=Adb4Tgacrd4bHVu9MkzkWN+QTgjcjTbEFFwPNjYONgsefwqitUgPD1ytt2T6caVvkj3Fdw
        hiUw2rsfQilqCdwW8FPWoymED3AJCvWXDjUebGmVTBsrRj/kXKbDGZfWbcVyM2MfVZq55O
        WGTQ3o0S3ud8xZaOsahm9OexgHg8XYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687345353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pnziWqeIZNrvl2O+xZ1w8A8qnxuxPCpJZgtJgpYEvPU=;
        b=EthIC3W/BETDoJ0qFd58aXLAEe6J6/tyoI3oud+epXosaZbJS4OnTDNuExvY52kNt+f1PJ
        Bqwubvsd0gJ7KkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13EF9134B1;
        Wed, 21 Jun 2023 11:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sCJfBMnYkmTMHgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 21 Jun 2023 11:02:33 +0000
Message-ID: <58279efe-141b-5d6b-b319-7bd1a0d5347d@suse.de>
Date:   Wed, 21 Jun 2023 13:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 3/4] block: set mapping order for the block cache in
 set_init_blocksize
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        david@fromorbit.com
Cc:     gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230621083823.1724337-1-p.raghav@samsung.com>
 <CGME20230621083828eucas1p23222cae535297f9536f12dddd485f97b@eucas1p2.samsung.com>
 <20230621083823.1724337-4-p.raghav@samsung.com>
 <a25eb5ce-b71c-2a38-d8eb-f8de8b8b449e@suse.de>
 <d275b49a-b6be-a08f-cfd8-d213eb452dd1@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <d275b49a-b6be-a08f-cfd8-d213eb452dd1@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 12:42, Pankaj Raghav wrote:
>>>        bdev->bd_inode->i_blkbits = blksize_bits(bsize);
>>> +    order = bdev->bd_inode->i_blkbits - PAGE_SHIFT;
>>> +    folio_order = mapping_min_folio_order(bdev->bd_inode->i_mapping);
>>> +
>>> +    if (!IS_ENABLED(CONFIG_BUFFER_HEAD)) {
>>> +        /* Do not allow changing the folio order after it is set */
>>> +        WARN_ON_ONCE(folio_order && (folio_order != order));
>>> +        mapping_set_folio_orders(bdev->bd_inode->i_mapping, order, 31);
>>> +    }
>>>    }
>>>      int set_blocksize(struct block_device *bdev, int size)
>> This really has nothing to do with buffer heads.
>>
>> In fact, I've got a patchset to make it work _with_ buffer heads.
>>
>> So please, don't make it conditional on CONFIG_BUFFER_HEAD.
>>
>> And we should be calling into 'mapping_set_folio_order()' only if the 'order' argument is larger
>> than PAGE_ORDER, otherwise we end up enabling
>> large folio support for _every_ block device.
>> Which I doubt we want.
>>
> 
> Hmm, which aops are you using for the block device? If you are using the old aops, then we will be
> using helpers from buffer.c and mpage.c which do not support large folios. I am getting a BUG_ON
> when I don't use iomap based aops for the block device:
> 
I know. I haven't said that mpage.c / buffer.c support large folios 
_now_. All I'm saying is that I have a patchset enabling it to support 
large folios :-)

Cheers,

Hannes

