Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B838A7A8651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjITONR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjITONP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:13:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C4CE;
        Wed, 20 Sep 2023 07:13:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 330EA200ED;
        Wed, 20 Sep 2023 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695219188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvtsDZGdfrYmBMovePryJn8q41Ubc0jqUjXK9bF1o9Y=;
        b=x35iR6EYbKXEKCY5R4YfjOaf+3n3PjvzSAn/On3msECOMArthtLToUKwPn0j/mpkieHPeo
        LYSm9uu/ofKLf7D5r6H2DECFy4465syF7jQwxAEwuBoqJ9jSNZHxpV3WxNqy9D+t6QWRCa
        iVgpUEnruE5OvbxDwj/qoF0yOeZ/bBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695219188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvtsDZGdfrYmBMovePryJn8q41Ubc0jqUjXK9bF1o9Y=;
        b=2VCiUvnk9w62+p68kzPZ/SG+zsK/EvAEFrWo/D6mDRbY5tBEI9MBHr7GoJmWqNlw44ojU6
        nX1zniikk8S6vlCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94C911333E;
        Wed, 20 Sep 2023 14:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EkdWIfP9CmVwGgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 20 Sep 2023 14:13:07 +0000
Message-ID: <ed7fd7b8-3271-4dee-b5bb-84bdd4c3db49@suse.de>
Date:   Wed, 20 Sep 2023 16:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] mm/readahead: rework loop in
 page_cache_ra_unbounded()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-2-hare@suse.de>
 <CGME20230920115645eucas1p1c8ed9bf515c4532b3e6995f8078a863b@eucas1p1.samsung.com>
 <20230920115643.ohzza3x3cpgbo54s@localhost>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230920115643.ohzza3x3cpgbo54s@localhost>
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

On 9/20/23 13:56, Pankaj Raghav wrote:
> On Mon, Sep 18, 2023 at 01:04:53PM +0200, Hannes Reinecke wrote:
>>   		if (folio && !xa_is_value(folio)) {
>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>   			 * not worth getting one just for that.
>>   			 */
>>   			read_pages(ractl);
>> -			ractl->_index++;
>> -			i = ractl->_index + ractl->_nr_pages - index - 1;
>> +			ractl->_index += folio_nr_pages(folio);
>> +			i = ractl->_index + ractl->_nr_pages - index;
> I am not entirely sure if this is correct.
> 
> The above if condition only verifies if a folio is in the page cache but
> doesn't tell if it is uptodate. But we are advancing the ractl->index
> past this folio irrespective of that.
> 
> Am I missing something?

Confused. Which condition?
I'm not changing the condition at all, just changing the way how the 'i' 
index is calculated during the loop (ie getting rid of the weird 
decrement and increment on 'i' during the loop).
Please clarify.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

