Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313D37A5239
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIRSm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjIRSmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:42:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277CC119;
        Mon, 18 Sep 2023 11:42:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D640322038;
        Mon, 18 Sep 2023 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695062537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0/5tXDr/+zZG5DOnZsO5Nl+pfdm9qTkOFBP2JNaICQ=;
        b=DhjMrLma4oOxFndMq/PfF00nlYAmMcA2N7VDW07xe8CQsNPWPQplml00iY2eajbZXYOX0E
        fNjXBWblBtqTwUBhlNSYi/T4LLswLzqQrCsboZJtGMDx3YAVXjUcXvrwy1ryc9RCRIIWuW
        rXqN6CV04C1Olt5dHevp/kUBE2vZp2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695062537;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0/5tXDr/+zZG5DOnZsO5Nl+pfdm9qTkOFBP2JNaICQ=;
        b=KnKnqJcJs6VWh5PZE7jfSKkavEP525/NYCUT3sH3MY6NHT0g59ENQlmOdJxE9lXbmOt30s
        MnA10pkOqw/RM4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFEC713480;
        Mon, 18 Sep 2023 18:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FL/qNgeaCGW4NwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 18 Sep 2023 18:42:15 +0000
Message-ID: <a9cebdc5-d9e6-4c24-b69b-cc9e9ff7566d@suse.de>
Date:   Mon, 18 Sep 2023 20:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        brauner@kernel.org, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, ziy@nvidia.com, ryan.roberts@arm.com,
        patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, dan.helmick@samsung.com
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQTR0NorkxJlcNBW@casper.infradead.org>
 <ZQiE5HHTLdJOsVPq@bombadil.infradead.org>
 <ZQiTxGxpzPBETLTw@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQiTxGxpzPBETLTw@casper.infradead.org>
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

On 9/18/23 20:15, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 10:12:04AM -0700, Luis Chamberlain wrote:
>> On Fri, Sep 15, 2023 at 10:51:12PM +0100, Matthew Wilcox wrote:
>>> On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
>>>> However, an issue is that disabling CONFIG_BUFFER_HEAD in practice is not viable
>>>> for many Linux distributions since it also means disabling support for most
>>>> filesystems other than btrfs and XFS. So we either support larger order folios
>>>> on buffer-heads, or we draw up a solution to enable co-existence. Since at LSFMM
>>>> 2023 it was decided we would not support larger order folios on buffer-heads,
>>>
>>> Um, I didn't agree to that.
>>
>> Coverage on sunsetting buffer-heads talk by LWN:
>>
>> https://lwn.net/Articles/931809/
>>
>> "the apparent conclusion from the session: the buffer-head layer will be
>> converted to use folios internally while minimizing changes visible to
>> the filesystems using it. Only single-page folios will be used within
>> this new buffer-head layer. Any other desires, he said, can be addressed
>> later after this problem has been solved."
> 
> Other people said that.  Not me.  I said it was fine for single
> buffer_head per folio.

And my patchset proves that to be the case.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

