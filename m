Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5AD6E3FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 08:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDQGat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 02:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDQGa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:30:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8EC1709;
        Sun, 16 Apr 2023 23:30:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2740A1F381;
        Mon, 17 Apr 2023 06:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681713022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=roBouqcwrrL48gYZgmbmYU0kUH5SEah2GFkcNfYxmOI=;
        b=ck8Z3Wqum42wIEZqp4vzxAuQXzIrDeywyEiGIMSSpaaFUG9pPnDv0u/Fqlu5Cein/TWoqC
        1bkI5TXDEQMtEl6y0+CPx5Yg0jI+jSSAKZLfTuD/e4WFQO9pvJ4PNm4haiA/JugtprIaGq
        pF+HdrFQilGJb2+QSLwbUTaRcqMgzbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681713022;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=roBouqcwrrL48gYZgmbmYU0kUH5SEah2GFkcNfYxmOI=;
        b=A85iskxesfGUQMCDpxgU5nzMknneXeCJICtFvNxfWVAbX+AhFwUnsqxooHan3nhyTOyPwH
        n/iD3DroorisHtBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04A1D13319;
        Mon, 17 Apr 2023 06:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id si+ZO33nPGSLBQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 06:30:21 +0000
Message-ID: <71f872a5-781d-c805-9789-cd3aed024658@suse.de>
Date:   Mon, 17 Apr 2023 08:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/filemap: allocate folios according to the blocksize
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
References: <20230414134908.103932-1-hare@suse.de>
 <ZDzM6A0w4seEumVo@infradead.org>
 <df36a72c-5b20-f071-ec1c-312f43939ebc@suse.de>
 <ZDzmtK64elHn6yPg@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZDzmtK64elHn6yPg@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/17/23 08:27, Christoph Hellwig wrote:
> On Mon, Apr 17, 2023 at 08:08:04AM +0200, Hannes Reinecke wrote:
>> On 4/17/23 06:36, Christoph Hellwig wrote:
>>> On Fri, Apr 14, 2023 at 03:49:08PM +0200, Hannes Reinecke wrote:
>>>> If the blocksize is larger than the pagesize allocate folios
>>>> with the correct order.
>>>
>>> And how is that supposed to actually happen?
>>
>> By using my patcheset to brd and set the logical blocksize to eg 16k.
> 
> Then add it to your patchset instead of trying to add dead code to the
> kernel while also losing context.

Yeah, sorry. Was a bit overexcited here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

