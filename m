Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CC6E24DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDNN4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNN4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:56:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C6A276;
        Fri, 14 Apr 2023 06:56:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F1B1219D7;
        Fri, 14 Apr 2023 13:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681480579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96hCN+ciy7etdeUypDLwA2iULJg5jzHgXTrCStgsPRM=;
        b=b9bUP/oVyJdI6rufBFfxFaCns6kjsy22eY89h1bV1yHE0SBPZ4FgSbzPwwuTXX0A+xE3q3
        4gx1Un8T/RAqBTWsMcB8UmBsTaMFmQ7jbEDw5Rf3JLrAMRQ62Xhc41ViLOk5Gpzn4c2uge
        i+y6WyzR1YV/G0HTF40lkDllrbCkCTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681480579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=96hCN+ciy7etdeUypDLwA2iULJg5jzHgXTrCStgsPRM=;
        b=+08MtxAiw/YvXwRixi37dgpuSbF+Vm5iw0N+K4DkbYEw2nACwa0f7rg/MxzJNBmHBxzRdO
        dsb9g9xJlBN3MVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A7C813498;
        Fri, 14 Apr 2023 13:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AKmJGYNbOWTbFgAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 14 Apr 2023 13:56:19 +0000
Message-ID: <d7bc4553-05c7-f4db-e38a-19980cec90d6@suse.de>
Date:   Fri, 14 Apr 2023 15:56:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDlaaJxjXFbh+xSI@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZDlaaJxjXFbh+xSI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/14/23 15:51, Matthew Wilcox wrote:
> On Fri, Apr 14, 2023 at 03:47:13PM +0200, Hannes Reinecke wrote:
>> BTW; I've got another patch replacing 'writepage' with 'write_folio'
>> (and the corresponding argument update). Is that a direction you want to go?
> 
> No; ->writepage is being deleted.  It's already gone from ext4 and xfs.

Aw.
And here's me having converted block/fops over to using iomap w/ 
iomap_writepage(). Tough.

Oh well.
Wasn't a great fit anyway as for a sb_bread() replacement we would need 
a sub-page access for iomap.
Question is whether we really need that or shouldn't read PAGE_SIZE 
sectors always. Surely would make life easier. And would save us all the 
logic with bh_lru etc as we can rely on the page cache.

But probably an item for the iomap discussion at LSF.

Unless you got plans already ...

Cheers,

Hannes

