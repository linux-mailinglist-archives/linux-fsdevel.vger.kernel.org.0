Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC9730F3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbjFOGXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbjFOGXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:23:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9932706;
        Wed, 14 Jun 2023 23:23:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88ED9223D0;
        Thu, 15 Jun 2023 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686810191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs33CZKfGT57/Ub45dzwYiHADzKVIY5aHpMiEOy4AHo=;
        b=V/ygG2ShNSnMr+RlJmd5qneEEBnVbA6KXUNj5F+O7cQaARjpXmlhCpT3Zltyl8Q5j0K6yb
        u0SBZM6tt5p3MJA4NiBZtfhooxYgBW5bb7dm7ed7dC39MLs7NlN5GliFAWCTZz4ATge0v/
        QW73MeWNU2CrE5wKesn83Om6dxEKJOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686810191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs33CZKfGT57/Ub45dzwYiHADzKVIY5aHpMiEOy4AHo=;
        b=hyTu6i2DSS9shXPFNWV4rX456bKKvnhzm4t22sQZMNAgWbi9mPGPSIDz9qTAUNPPn/QQaJ
        EG+hv7xO+yqo7PBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57F4013467;
        Thu, 15 Jun 2023 06:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 77QaFE+uimTzcAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 15 Jun 2023 06:23:11 +0000
Message-ID: <df899b21-8200-84c1-49ae-8562a571d7c8@suse.de>
Date:   Thu, 15 Jun 2023 08:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-5-hare@suse.de> <ZIp0qH3CAMr1mGzX@dread.disaster.area>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZIp0qH3CAMr1mGzX@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/15/23 04:17, Dave Chinner wrote:
> On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
>> @@ -310,6 +312,10 @@ static int max_part = 1;
>>   module_param(max_part, int, 0444);
>>   MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>>   
>> +static unsigned int rd_blksize = PAGE_SIZE;
>> +module_param(rd_blksize, uint, 0444);
>> +MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
> 
> This needs CONFIG_BLK_DEV_RAM_BLOCK_SIZE to set the default size
> for those of us who don't use modular kernels....
> Ok, will do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

