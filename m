Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760484CA09A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 10:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiCBJZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 04:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbiCBJZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:25:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48F3FDBB;
        Wed,  2 Mar 2022 01:24:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 696FD1F39D;
        Wed,  2 Mar 2022 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646213056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clM0yYlLqEX7Y5ui9U1ErugOMUrW/ceVhGC6xR2tAew=;
        b=GxV9t9jA8UzFp10mgfTYqscDn3mqAyjQkUDkNOZ6WudDgkD7fZ24C2xIm1J1lwjPWv5Hqx
        KAwG4h+6/IKc3x4mcMJTcacF5wckqSBifZjASvkwxdtNedohTlXsBSH6VACa8L07DZFfwg
        JNMv0pJ3iN3bsv52RjAy+hn8LSMzPpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646213056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clM0yYlLqEX7Y5ui9U1ErugOMUrW/ceVhGC6xR2tAew=;
        b=//kv8L4NT9j55yEeAww5drvSB7x88AZTHCxd6ugQ9HVtKzCBWy2rLFVIP1Y5dDzFAPITnN
        yxItsAQPEssSgTCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 48383A3B87;
        Wed,  2 Mar 2022 09:24:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EBD45A0608; Wed,  2 Mar 2022 10:24:15 +0100 (CET)
Date:   Wed, 2 Mar 2022 10:24:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Weinberger <richard@nod.at>
Cc:     Jan Kara <jack@suse.cz>, wuchi zero <wuchi.zero@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        tj <tj@kernel.org>, mszeredi <mszeredi@redhat.com>,
        sedat dilek <sedat.dilek@gmail.com>, axboe <axboe@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Different writeback timing since v5.14
Message-ID: <20220302092415.4sikhzup7sorhxgy@quack3.lan>
References: <2104629126.100059.1646129517209.JavaMail.zimbra@nod.at>
 <20220301103218.ulbmakdy4gbw2fso@quack3.lan>
 <719960584.100772.1646147154879.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719960584.100772.1646147154879.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 01-03-22 16:05:54, Richard Weinberger wrote:
> Jan,
> 
> ----- Ursprüngliche Mail -----
> > Von: "Jan Kara" <jack@suse.cz>
> >> Is this expected?
> >> Just want to make sure that the said commit didn't uncover an UBIFS issue.
> > 
> > Yes, I think it is expected. Likely the background threshold for UBIFS bdi
> > is very small (probably UBIFS is not used much for writeback compared to
> > other filesystems). Previously, we just used wb_stat() which returned 0
> > (PCP counter inexact value) and so background writeback didn't trigger. Now
> > we use wb_stat_sum() when threshold is small, get exact value of dirty
> > pages and decide to start background writeback.
> 
> Thanks for the prompt reply!
> 
> > The only thing is, whether it is really expected that the threshold for
> > UBIFS bdi is so small. You can check the values in
> > /sys/kernel/debug/bdi/<bdi>/stats.
> 
> BdiDirtyThresh is indeed 0.
> 
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:              0 kB
> DirtyThresh:            772620 kB
> BackgroundThresh:       385836 kB
> BdiDirtied:                  0 kB
> BdiWritten:                  0 kB
> BdiWriteBandwidth:      102400 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1

Yes, so this looks expected given the BDI wasn't active yet at all...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
