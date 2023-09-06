Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B9979382B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjIFJ1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjIFJ1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:27:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B24171F;
        Wed,  6 Sep 2023 02:26:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF7A222443;
        Wed,  6 Sep 2023 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693992414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3rIv+HN01Web1KGJNNDUY+0CQGW+JW+xYMEz2h5hWo=;
        b=lhq5Wdk3BgvB+cWFcsR0byMu0ym4CyA2QpF28RXJwBCt1WYds8ndsSH2LdYQTUZfLHuY1c
        4wJX/hlGWwlkxjRmQS/pP9qiDCl5dcUCtsrDR5Qk1UDqF9V5AOxXRd0uIZl0ZoqHM4rU+H
        0wNNBWWWRUUi7YbHS3uFmwBg2ts13as=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693992414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3rIv+HN01Web1KGJNNDUY+0CQGW+JW+xYMEz2h5hWo=;
        b=Nnz/GWrGwYjJ1ViI8zDUOPZTlsWutz/riRUdXQ5yRYApSlIfmfMJJatwh31cFr9ERdBax8
        RrUmWYiAQXnzCKDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9046A1333E;
        Wed,  6 Sep 2023 09:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wKO1Id5F+GSJDQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 06 Sep 2023 09:26:54 +0000
Message-ID: <71c1213b-a5e0-4d14-9bbd-352d85361d67@suse.de>
Date:   Wed, 6 Sep 2023 11:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in
 iomap_to_bh
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, djwong@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
References: <20230905124120.325518-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230905124120.325518-1-hch@lst.de>
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

On 9/5/23 14:41, Christoph Hellwig wrote:
> iomap_to_bh currently BUG()s when the passed in block number is not
> in the iomap.  For file systems that have proper synchronization this
> should never happen and so far hasn't in mainline, but for block devices
> size changes aren't fully synchronized against ongoing I/O.  Instead
> of BUG()ing in this case, return -EIO to the caller, which already has
> proper error handling.  While we're at it, also return -EIO for an
> unknown iomap state instead of returning garbage.
> 
> Fixes: 487c607df790 ("block: use iomap for writes to block devices")
> Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/buffer.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

