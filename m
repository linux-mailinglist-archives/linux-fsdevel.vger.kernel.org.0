Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663AA74CE8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 09:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjGJHgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGJHgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:36:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94254EC;
        Mon, 10 Jul 2023 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688974570; bh=wtMH4x5k93+5UQkNxRZ4qkKRzT5QI5tjnFGasrZuo2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/kTCuYSi/lR7oEx1oCIS8+4w5z4MlZrR+nxs2VaSfqBX4g6/9jOaYmstXSJ3ulWK
         vEkZDVodH9IcixSiSXY6lkO+R1FKb8gx1aU3ZF5QjnwcXlicEWASUo2Uy7mNpNe+uC
         fhWUBh0IrItdgKttpXyxdVMAibbDTwbO9wPrVN3s=
Date:   Mon, 10 Jul 2023 09:36:09 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 0/2] proc: proc_setattr for /proc/$PID/net
Message-ID: <7d4163ad-f9bc-4361-ab8a-673eb9336b63@t-8ch.de>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
 <20230630140609.263790-1-falcon@tinylab.org>
 <20230709092947.GF9321@1wt.eu>
 <3261fa5b-b239-48a2-b1a8-34f80567cde1@t-8ch.de>
 <20230709172753.GA22287@1wt.eu>
 <df91b1d3-2c66-4a6b-9a8a-544679bc09a8@t-8ch.de>
 <20230709180432.GA22685@1wt.eu>
 <74eddce8-4f59-40c8-bc49-38c286a3cbb0@t-8ch.de>
 <ZKuuoB6fcAV3ucFM@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKuuoB6fcAV3ucFM@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-07-10 09:09:20+0200, Willy Tarreau wrote:
> On Sun, Jul 09, 2023 at 08:22:31PM +0200, Thomas Weißschuh wrote:
> > On 2023-07-09 20:04:32+0200, Willy Tarreau wrote:

> [..]

> > That should work fine, too.
> > Can you add the Fixes and Cc-stable tags in your tree and let the fs
> > maintainers know?
> 
> OK here's what it's like now, let me know if you'd prefer any change:
> 
>   commit 8c2e51e174ed0f998b6bd90244324a4966a55efc
>   Author: Thomas Weißschuh <linux@weissschuh.net>
>   Date:   Sat Jun 24 12:30:46 2023 +0200
> 
>     selftests/nolibc: drop test chmod_net
>     
>     The test relies on /proc/$PID/net to allow chmod() operations.
>     It is the only file or directory in /proc/$PID/ to allow this and a bug.
>     That bug will be fixed in the next patch in the series and therefore
>     the test would start failing.

As the patch is now standalone the part "fixed in the next patch in the
series" is not accurate anymore.
Maybe only "When this bug gets fixed the test would start failing"?

>     Link: https://lore.kernel.org/lkml/d0d111ef-edae-4760-83fb-36db84278da1@t-8ch.de/
>     Fixes: b4844fa0bdb4 ("selftests/nolibc: implement a few tests for various syscalls")

+ Cc: stable@vger.kernel.org

The Fixes tag alone is not enough to trigger the formalized backport
process. It may be picked up anyways through heuristics but that would
only be luck.

>     Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>     Tested-by: Zhangjin Wu <falcon@tinylab.org>
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> > Or do you want me to split and resend the series?
> 
> Not needed, thank you.

Thanks!

Thomas
