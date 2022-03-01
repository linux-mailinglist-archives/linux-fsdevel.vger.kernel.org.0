Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBBA4C8E86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 16:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiCAPGk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 1 Mar 2022 10:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiCAPGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:06:40 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA570A6468;
        Tue,  1 Mar 2022 07:05:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B0E44609B3C0;
        Tue,  1 Mar 2022 16:05:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0v40nSVbi-hE; Tue,  1 Mar 2022 16:05:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 33003609B3D3;
        Tue,  1 Mar 2022 16:05:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kz-2b_1qeBCK; Tue,  1 Mar 2022 16:05:55 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F2CA5609B3C0;
        Tue,  1 Mar 2022 16:05:54 +0100 (CET)
Date:   Tue, 1 Mar 2022 16:05:54 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Jan Kara <jack@suse.cz>
Cc:     wuchi zero <wuchi.zero@gmail.com>,
        =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        tj <tj@kernel.org>, mszeredi <mszeredi@redhat.com>,
        sedat dilek <sedat.dilek@gmail.com>, axboe <axboe@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <719960584.100772.1646147154879.JavaMail.zimbra@nod.at>
In-Reply-To: <20220301103218.ulbmakdy4gbw2fso@quack3.lan>
References: <2104629126.100059.1646129517209.JavaMail.zimbra@nod.at> <20220301103218.ulbmakdy4gbw2fso@quack3.lan>
Subject: Re: Different writeback timing since v5.14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Different writeback timing since v5.14
Thread-Index: A7tsGqUsSQ3AY4M1uWfsU/0uR9rf+A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

----- Ursprüngliche Mail -----
> Von: "Jan Kara" <jack@suse.cz>
>> Is this expected?
>> Just want to make sure that the said commit didn't uncover an UBIFS issue.
> 
> Yes, I think it is expected. Likely the background threshold for UBIFS bdi
> is very small (probably UBIFS is not used much for writeback compared to
> other filesystems). Previously, we just used wb_stat() which returned 0
> (PCP counter inexact value) and so background writeback didn't trigger. Now
> we use wb_stat_sum() when threshold is small, get exact value of dirty
> pages and decide to start background writeback.

Thanks for the prompt reply!

> The only thing is, whether it is really expected that the threshold for
> UBIFS bdi is so small. You can check the values in
> /sys/kernel/debug/bdi/<bdi>/stats.

BdiDirtyThresh is indeed 0.

BdiWriteback:                0 kB
BdiReclaimable:              0 kB
BdiDirtyThresh:              0 kB
DirtyThresh:            772620 kB
BackgroundThresh:       385836 kB
BdiDirtied:                  0 kB
BdiWritten:                  0 kB
BdiWriteBandwidth:      102400 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1

Thanks,
//richard
