Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02CF7A3567
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Sep 2023 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjIQLu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjIQLuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 07:50:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2271E128;
        Sun, 17 Sep 2023 04:50:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD46A1F88C;
        Sun, 17 Sep 2023 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694951447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loxy3PBfksAESFkI1XAMKVCrdymCRMcZU0rlFvXm9wo=;
        b=VrRFMWYN7WZf9NEILYObPxsQfRf+Nrw0gAYnf8drrbpLNg9QTmVbyETIISqBaae5muZod0
        W92ZWtOA9hJz5Ujak5p4T9D0icchXCxcji5s5t/G/U7FdKVtkA1IcRjpSegMn6dvXszQgG
        tCJohYYvaYF4079js8Ooykg5pgIMuDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694951447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loxy3PBfksAESFkI1XAMKVCrdymCRMcZU0rlFvXm9wo=;
        b=c946s20XW6AXt0yX0ux/PcEEvdw0vz3mJhHQJAxihMn1iCLmIquwG/RjInho2BHPhakhKW
        C3BucqY19c0OoxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C839134F3;
        Sun, 17 Sep 2023 11:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0i76GBboBmV7MwAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 17 Sep 2023 11:50:46 +0000
Message-ID: <5e5eb1f0-d197-4a25-b8bb-5734b9c57c1c@suse.de>
Date:   Sun, 17 Sep 2023 13:50:45 +0200
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
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQTR0NorkxJlcNBW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/23 23:51, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
>> However, an issue is that disabling CONFIG_BUFFER_HEAD in practice is not viable
>> for many Linux distributions since it also means disabling support for most
>> filesystems other than btrfs and XFS. So we either support larger order folios
>> on buffer-heads, or we draw up a solution to enable co-existence. Since at LSFMM
>> 2023 it was decided we would not support larger order folios on buffer-heads,
> 
> Um, I didn't agree to that.  If block size is equal to folio size, there
> are no problems supporting one buffer head per folio.  In fact, we could
> probably go up to 8 buffer heads per folio without any trouble (but I'm
> not signing up to do that work).
> 
Entirely correct.
I have a patchset ready for doing just that (ie having one buffer head 
per folio); hope I'll find some time next week to get it cleaned up and 
posted.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

