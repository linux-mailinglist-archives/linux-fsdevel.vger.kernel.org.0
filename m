Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D794EBAB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 08:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbiC3GXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 02:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiC3GXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:23:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3125046D;
        Tue, 29 Mar 2022 23:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9D0AB81AD5;
        Wed, 30 Mar 2022 06:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A357AC340EC;
        Wed, 30 Mar 2022 06:21:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ty2Q3C+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648621276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2eRrPnqhTJjokXQOdORL7R4K689Hcih8p/XLm4p+Fvc=;
        b=Ty2Q3C+nxdjUQaGjzpqGcNWXhdezVxMLyN15NAoBzzwwlIQXJcfOnqRrOFLwMyyx2Xe2dy
        /7xX+lea48DGH7t3FxoPzw9ydT8Vlt1HH5VdQ1cqC/Rt2unU+agicblhqnyTLLjqmN57OJ
        WBaDiPIKKHn3Ig+J3hKmgdfa2vJo2eo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 042fe011 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 30 Mar 2022 06:21:15 +0000 (UTC)
Date:   Wed, 30 Mar 2022 02:21:14 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
Message-ID: <YkP2hKKeMeFrdpBW@zx2c4.com>
References: <20220326114009.1690-1-aissur0002@gmail.com>
 <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67>
 <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
 <YkPo0N/CVHFDlB6v@zx2c4.com>
 <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Tue, Mar 29, 2022 at 11:08:55PM -0700, Linus Torvalds wrote:
> So does it help if you just remove that
> 
>         max_fds = ALIGN(max_fds, BITS_PER_LONG);
> 
> and instead make the final return be
> 
>         return ALIGN(min(count, max_fds), BITS_PER_LONG);
> 
> instead?

Yep, that works:

diff --git a/fs/file.c b/fs/file.c
index c01c29417ae6..ee9317346702 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -303,10 +303,9 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
 	unsigned int count;

 	count = count_open_files(fdt);
-	max_fds = ALIGN(max_fds, BITS_PER_LONG);
 	if (max_fds < NR_OPEN_DEFAULT)
 		max_fds = NR_OPEN_DEFAULT;
-	return min(count, max_fds);
+	return ALIGN(min(count, max_fds), BITS_PER_LONG);
 }

 /*

Jason
