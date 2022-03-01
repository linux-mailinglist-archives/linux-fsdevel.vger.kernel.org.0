Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA6C4C8956
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 11:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiCAKdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 05:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiCAKdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:33:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787E2654A1;
        Tue,  1 Mar 2022 02:32:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2FF4121637;
        Tue,  1 Mar 2022 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646130739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=La5buFbnjrPhn2o1sUWwzQOTEyfMerZi3ZYeAU8/Uv0=;
        b=ir6wKv7+9TEqXDAv3qmydQ5wBbusxZq25vcTSERRcfsYAthVuwyzGudcKtcu5nR7eD8N9w
        Xf1dhJfFABjK3gR6RVu2WwBtXG7aTJA9ivU3pX+9IyTxtrODSdDHmoGMphU/lnLO+kWTuX
        xskgcZyntzbQGHPrndLL+oVBRDjnBFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646130739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=La5buFbnjrPhn2o1sUWwzQOTEyfMerZi3ZYeAU8/Uv0=;
        b=tKcMBac1PgJGoG8rsYC6c4tom0Ydqe9lf86KLgjfVmM5zQc0oUPxg2PqqyEdGUi7u05yLw
        yje4esCKuBhlKoAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19928A3B89;
        Tue,  1 Mar 2022 10:32:19 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8B603A0608; Tue,  1 Mar 2022 11:32:18 +0100 (CET)
Date:   Tue, 1 Mar 2022 11:32:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Weinberger <richard@nod.at>
Cc:     wuchi.zero@gmail.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        jack@suse.cz, tj@kernel.org, mszeredi@redhat.com,
        sedat.dilek@gmail.com, axboe@fb.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux-mm <linux-mm@kvack.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Different writeback timing since v5.14
Message-ID: <20220301103218.ulbmakdy4gbw2fso@quack3.lan>
References: <2104629126.100059.1646129517209.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2104629126.100059.1646129517209.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Tue 01-03-22 11:11:57, Richard Weinberger wrote:
> Rafał and I discovered that page writeback on UBIFS behaves different since v5.14.
> When a simple write, such as "echo foo > /mnt/ubibfs/bar.txt", happens it takes
> a few seconds until writeback calls ubifs_writepage().
> 
> Before commit ab19939a6a50 ("mm/page-writeback: Fix performance when BDI's share of ratio is 0.")
> it was 30 seconds (vm.dirty_expire_centisecs), after this change it happens after 5 seconds
> (vm.dirty_writeback_centisecs).
> 
> Is this expected?
> Just want to make sure that the said commit didn't uncover an UBIFS issue.

Yes, I think it is expected. Likely the background threshold for UBIFS bdi
is very small (probably UBIFS is not used much for writeback compared to
other filesystems). Previously, we just used wb_stat() which returned 0
(PCP counter inexact value) and so background writeback didn't trigger. Now
we use wb_stat_sum() when threshold is small, get exact value of dirty
pages and decide to start background writeback.

The only thing is, whether it is really expected that the threshold for
UBIFS bdi is so small. You can check the values in
/sys/kernel/debug/bdi/<bdi>/stats.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
