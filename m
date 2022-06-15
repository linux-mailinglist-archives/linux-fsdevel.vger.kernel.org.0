Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEE354CF0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348992AbiFOQtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFOQtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:49:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E11612CDC7;
        Wed, 15 Jun 2022 09:49:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 691F2153B;
        Wed, 15 Jun 2022 09:49:39 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE5EA3F7F5;
        Wed, 15 Jun 2022 09:49:35 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:49:58 +0100
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, sunjunchao2870@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <YqoNtvyZA2s4cSgW@monolith.localdoman>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
 <Yqh9xIwBVcabpSLe@alley>
 <YqiJH1phG/LWu9bs@monolith.localdoman>
 <YqiidNPMUZQPRIvy@alley>
 <YqnVWCYx0L2RlckB@monolith.localdoman>
 <20220615163949.z22puioui322ktla@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615163949.z22puioui322ktla@quack3.lan>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Jun 15, 2022 at 06:39:49PM +0200, Jan Kara wrote:
> Hi Alexandru!
> 
> On Wed 15-06-22 13:50:24, Alexandru Elisei wrote:
> > On Tue, Jun 14, 2022 at 05:00:04PM +0200, Petr Mladek wrote:
> > > > > > I've booted a kernel compiled with CONFIG_PROVE_LOCKING=y, as the offending
> > > > > > commit fiddles with locks, but no splat was produced that would explain the
> > > > > > hang. I've also tried to boot a v5,19-rc2 kernel on my odroid-c4, the board
> > > > > > is booting just fine, so I'm guessing it only affects of subset of arm64
> > > > > > boards.
> > > > > 
> > > > > You might try to switch the order of console_init() and lockdep_init()
> > > > > in start_kernel() in init/main.c
> > > > 
> > > > Did so above.
> > > 
> > > Unfortunately, it did not print anything :-(
> > 
> > With this patch [1] I was able to succefully boot the board. So I guess
> > problem should be fixed.
> > 
> > [1] https://lore.kernel.org/all/20220614124618.2830569-1-suzuki.poulose@arm.com/
> 
> Can you please try booting with the patch I've posted at [2]? After some
> discussion with Linus that would be a preferable fix... Thanks!
> 
> [2] https://lore.kernel.org/all/20220615133845.o2lzfe5s4dzdfvtg@quack3.lan

The patch works for me, thank you!

Do you also need me to reply to the discussion?

Alex

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
