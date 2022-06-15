Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734CB54D38F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 23:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348606AbiFOVWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237525AbiFOVWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:22:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA22554AD;
        Wed, 15 Jun 2022 14:22:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8F44F21C6E;
        Wed, 15 Jun 2022 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655328134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ju/eMyqeUm0258jtPSiVQvMQ8S4DYh43JQypxX85LS0=;
        b=tvVjQT8j7Nmk1o3lDboMNvBg/d58f0nHcA05n6KlqtgBjXBOcsJG00KwcFTTsR7kIDmG5p
        A1qF9bTlDtwhVxNCBhDObW322UmFGab0DmUbcgys7P4Via4ueoW9d86kJy4tl93aC7hIqB
        9JhNYUchoKWpTU3j6aWkKYqyK5MvsAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655328134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ju/eMyqeUm0258jtPSiVQvMQ8S4DYh43JQypxX85LS0=;
        b=rCczZZYy/8WlrQcEdPQqcld6RCBVFh79F6WeQJj7Qw8LSKrchYNFdkTaWHZm7CHQm5uJR4
        MDy+K223NdiyghCg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 77AF82C141;
        Wed, 15 Jun 2022 21:22:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9E410A062E; Wed, 15 Jun 2022 23:22:06 +0200 (CEST)
Date:   Wed, 15 Jun 2022 23:22:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     Jan Kara <jack@suse.cz>, Petr Mladek <pmladek@suse.com>,
        sunjunchao2870@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <20220615212206.ykqvui4tthpfme2u@quack3.lan>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
 <Yqh9xIwBVcabpSLe@alley>
 <YqiJH1phG/LWu9bs@monolith.localdoman>
 <YqiidNPMUZQPRIvy@alley>
 <YqnVWCYx0L2RlckB@monolith.localdoman>
 <20220615163949.z22puioui322ktla@quack3.lan>
 <YqoNtvyZA2s4cSgW@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqoNtvyZA2s4cSgW@monolith.localdoman>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-06-22 17:49:58, Alexandru Elisei wrote:
> Hi,
> 
> On Wed, Jun 15, 2022 at 06:39:49PM +0200, Jan Kara wrote:
> > Hi Alexandru!
> > 
> > On Wed 15-06-22 13:50:24, Alexandru Elisei wrote:
> > > On Tue, Jun 14, 2022 at 05:00:04PM +0200, Petr Mladek wrote:
> > > > > > > I've booted a kernel compiled with CONFIG_PROVE_LOCKING=y, as the offending
> > > > > > > commit fiddles with locks, but no splat was produced that would explain the
> > > > > > > hang. I've also tried to boot a v5,19-rc2 kernel on my odroid-c4, the board
> > > > > > > is booting just fine, so I'm guessing it only affects of subset of arm64
> > > > > > > boards.
> > > > > > 
> > > > > > You might try to switch the order of console_init() and lockdep_init()
> > > > > > in start_kernel() in init/main.c
> > > > > 
> > > > > Did so above.
> > > > 
> > > > Unfortunately, it did not print anything :-(
> > > 
> > > With this patch [1] I was able to succefully boot the board. So I guess
> > > problem should be fixed.
> > > 
> > > [1] https://lore.kernel.org/all/20220614124618.2830569-1-suzuki.poulose@arm.com/
> > 
> > Can you please try booting with the patch I've posted at [2]? After some
> > discussion with Linus that would be a preferable fix... Thanks!
> > 
> > [2] https://lore.kernel.org/all/20220615133845.o2lzfe5s4dzdfvtg@quack3.lan
> 
> The patch works for me, thank you!

Thanks for testing!
 
> Do you also need me to reply to the discussion?

No, I don't need that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
