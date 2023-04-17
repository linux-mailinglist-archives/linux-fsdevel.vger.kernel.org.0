Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD996E3F63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 08:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDQGII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 02:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQGIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:08:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B93730F4;
        Sun, 16 Apr 2023 23:08:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 07EE121A3F;
        Mon, 17 Apr 2023 06:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681711685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57APiRN5jmkxHW5qmrqEqSD4orbsmDmR3FRnoe94H+8=;
        b=nYAzHSqJwsSlksYUDBfan7/Sam5ZBe93jlwB/R2D+CUocq2G6NTQwX9VEtiyCHGDvF4hX3
        HbODDmSCOUzvWJ0lWToqn1KriceumR6eZqgkVX0M3M/nMHCT/k+paQK0xx9xsnJCzmRMto
        hc4j7xf1dg3fXnN8/9JzR9V1mNzICYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681711685;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57APiRN5jmkxHW5qmrqEqSD4orbsmDmR3FRnoe94H+8=;
        b=kgoPt0Oq6wA5BtJfFT/NP9ZN5UBRc0ZOOok0eybP0nORcqCDrmsPtkFSGt52ZWuoDhuKky
        o5V9oapmkD7do6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D93071390E;
        Mon, 17 Apr 2023 06:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c9MsNETiPGRYewAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 17 Apr 2023 06:08:04 +0000
Message-ID: <df36a72c-5b20-f071-ec1c-312f43939ebc@suse.de>
Date:   Mon, 17 Apr 2023 08:08:04 +0200
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
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZDzM6A0w4seEumVo@infradead.org>
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

On 4/17/23 06:36, Christoph Hellwig wrote:
> On Fri, Apr 14, 2023 at 03:49:08PM +0200, Hannes Reinecke wrote:
>> If the blocksize is larger than the pagesize allocate folios
>> with the correct order.
> 
> And how is that supposed to actually happen?

By using my patcheset to brd and set the logical blocksize to eg 16k.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

