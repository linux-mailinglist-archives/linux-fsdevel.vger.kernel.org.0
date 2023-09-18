Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049977A5118
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIRRie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRRid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:38:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AD9DB;
        Mon, 18 Sep 2023 10:38:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0A5B2004E;
        Mon, 18 Sep 2023 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695058706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmStrfUuoPZS6/Xa68Kv22qJopA4ragzNopNOcDtSkY=;
        b=rskQZP0pvuTLU8FBQ+58EDrNcUZq+QntrTy+LcQdbJXe9DPnSZcLDcO6k8n886LDqgfrxX
        4LTnS5FZsn/pdlXY0jN5tarDFcvGGttHB/RWh0H16cApZX4KjjG4WCS3HNTW7vCkTo9Utt
        uFcYbiqnVTR6KdTnNCiLuW5x/QO3/zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695058706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DmStrfUuoPZS6/Xa68Kv22qJopA4ragzNopNOcDtSkY=;
        b=3iiY4DORI3CT135kT9jH0mu0tQ490EyhAGpfOj10X9A4GXpBcPB5pxmve0Z0bqUN7uZl9u
        ZFdM12HoU/PY5JAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 526451358A;
        Mon, 18 Sep 2023 17:38:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hWHeDBKLCGVnHAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 18 Sep 2023 17:38:26 +0000
Message-ID: <6d28c70f-703b-4e4d-a8be-663c5dbf2cc7@suse.de>
Date:   Mon, 18 Sep 2023 19:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] fs/buffer: use mapping order in grow_dev_page()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-10-hare@suse.de>
 <ZQhX6Zt5iqZp4GJ0@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZQhX6Zt5iqZp4GJ0@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 16:00, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:05:01PM +0200, Hannes Reinecke wrote:
>> Use the correct mapping order in grow_dev_page() to ensure folios
>> are created with the correct order.
> 
> I see why you did this, but I think it's fragile.  __filemap_get_folio()
> will happily decrease 'order' if memory allocation fails.  I think
> __filemap_get_folio() needs to become aware of the minimum folio
> order for this mapping, and then we don't need this patch.
> 
> Overall, I like bits of this patchset and I like bits of Pankaj's ;-)

To be expected. It's basically parallel development, me and Pankaj 
working independently and arriving at different patchsets.
Will see next week at ALPSS if we can merge them into something sensible.

And 'grow_dev_page()' was really done by audit, and I'm not sure if my 
tests even exercised this particular codepath. So yeah, I'm with you.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

