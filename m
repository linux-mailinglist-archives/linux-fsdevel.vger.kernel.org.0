Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA8730F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbjFOGel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbjFOGeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:34:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EAD2D73;
        Wed, 14 Jun 2023 23:33:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B4E2D22323;
        Thu, 15 Jun 2023 06:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686810812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKb4/LPHtY0XYaNTrO1aD5csiltOHFQtIbms7/cEaA8=;
        b=anVz8nIQMGRqFNaioPCf42++S+9a/l8YYCNBXI1IJiDHheXnJrojTxl7F+cr21P+Poeuya
        JcpbmdEIPzwwvjuos+UCflr/tY4jGCgD9RgBHCJHJw70n3M5Bn5oJ7v0ID60TRw443GIPn
        H9/phTpwRAlB/LoIIiJuKAJ77E9RYVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686810812;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKb4/LPHtY0XYaNTrO1aD5csiltOHFQtIbms7/cEaA8=;
        b=mJ16Sy4bfIEyNRLNFyNjB1MZE8XjkM01dDeeTPjRtouSQFdWw2IhGd3oxggakrtLLuUaGz
        o+xsDtQNAjDqAwAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E4F913467;
        Thu, 15 Jun 2023 06:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4XbGGbywimRZdQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 15 Jun 2023 06:33:32 +0000
Message-ID: <b5367951-ef57-023b-840a-4b4dea8be307@suse.de>
Date:   Thu, 15 Jun 2023 08:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-5-hare@suse.de> <ZIp0qH3CAMr1mGzX@dread.disaster.area>
 <20230615055540.GA5561@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230615055540.GA5561@lst.de>
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

On 6/15/23 07:55, Christoph Hellwig wrote:
> On Thu, Jun 15, 2023 at 12:17:12PM +1000, Dave Chinner wrote:
>> On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
>>> @@ -310,6 +312,10 @@ static int max_part = 1;
>>>   module_param(max_part, int, 0444);
>>>   MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>>>   
>>> +static unsigned int rd_blksize = PAGE_SIZE;
>>> +module_param(rd_blksize, uint, 0444);
>>> +MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
>>
>> This needs CONFIG_BLK_DEV_RAM_BLOCK_SIZE to set the default size
>> for those of us who don't use modular kernels....
> 
> You can set module parameter on the command line for built-in code
> like brd.rd_blksize=8196
> 
> While we're at it, why that weird rd_ prefix for the parameter?
> 
Because that's what's used for all the existing parameters, too.

We can remove it, though, but then we either have inconsistent naming
(some parameters with 'rd_', others without), or break existing setups.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

