Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF56AAB8B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCDRRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 12:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDRRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:17:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFB6E94;
        Sat,  4 Mar 2023 09:17:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8024B22B84;
        Sat,  4 Mar 2023 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677950257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ffr+G/XTnNX5sutfA/xaUbfn1Y64DxDY55IeB5PEHY=;
        b=jfpVqDVMSXSe5Kq65s+A/aMIMODTc90cu5nvrpGe/m0n9f7BYyfc1J9jO/0YG0EI6UQlps
        s1wTUxaly4GG92KrO/OyEgdXyv8TjuYw+bjLklFfZ5BCh7z1MJKdyKHQorIZ3LFP5BzT/D
        xBDATOkexNyh05PZiU/bi/Ql+6/UvDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677950257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ffr+G/XTnNX5sutfA/xaUbfn1Y64DxDY55IeB5PEHY=;
        b=VWkOtwNFuAnKnmMJhHMOf6Jj6F51bxUu1xH0SizlXF05QL4Ajf0oiziZSOFJoufQZAGSPU
        pXQ0OlHfgSVkecAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E9B213901;
        Sat,  4 Mar 2023 17:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g6arAjF9A2R5NgAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 04 Mar 2023 17:17:37 +0000
Message-ID: <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
Date:   Sat, 4 Mar 2023 18:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZAN2HYXDI+hIsf6W@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/23 17:47, Matthew Wilcox wrote:
> On Sat, Mar 04, 2023 at 12:08:36PM +0100, Hannes Reinecke wrote:
>> We could implement a (virtual) zoned device, and expose each zone as a
>> block. That gives us the required large block characteristics, and with
>> a bit of luck we might be able to dial up to really large block sizes
>> like the 256M sizes on current SMR drives.
>> ublk might be a good starting point.
> 
> Ummmm.  Is supporting 256MB block sizes really a desired goal?  I suggest
> that is far past the knee of the curve; if we can only write 256MB chunks
> as a single entity, we're looking more at a filesystem redesign than we
> are at making filesystems and the MM support 256MB size blocks.
> 
Naa, not really. It _would_ be cool as we could get rid of all the 
cludges which have nowadays re sequential writes.
And, remember, 256M is just a number someone thought to be a good 
compromise. If we end up with a lower number (16M?) we might be able
to convince the powers that be to change their zone size.
Heck, with 16M block size there wouldn't be a _need_ for zones in
the first place.

But yeah, 256M is excessive. Initially I would shoot for something
like 2M.

> The current work is all going towards tracking memory in larger chunks,
> so writing back, eg, 64kB chunks of the file.  But if 256MB is where
> we're going, we need to be thinking more like a RAID device and
> accumulating writes into a log that we can then blast out in a single
> giant write.
> 
Yeah. I _do_ remember someone hch-ish presenting something two years
back at ALPSS, but guess that's still on the back-burner.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

