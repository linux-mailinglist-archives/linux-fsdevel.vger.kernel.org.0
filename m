Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88F5EFAD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 18:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiI2Qdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 12:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiI2Qdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:33:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1355A4;
        Thu, 29 Sep 2022 09:33:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 019CD1F8BE;
        Thu, 29 Sep 2022 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664469220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eShIPYqu7E10XqA1YXAoCftbC0rFatAmpe4+4vsscI=;
        b=HrytoeWsHGUIH5VJtyPUoJbyv0xaregBL9fpxSePMNf0cHw5nf+aDFmL36YJQ3Jn1YmQyx
        eW5zw2346C+FqG7Q8ICq/meKC/T4wcj0j0RThkBCrDcJvCJ2tPtNO0Qoh6JhVRHBOSmqte
        nBCLwjNhPnV0W1Yoa/c5AWzNQtWFceo=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2A212C14E;
        Thu, 29 Sep 2022 16:33:38 +0000 (UTC)
Date:   Thu, 29 Sep 2022 18:33:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sven Schnelle <svens@stackframe.org>,
        John David Anglin <dave.anglin@bell.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-parisc@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH printk 00/18] preparation for threaded/atomic printing
Message-ID: <YzXI3ztt3kpMbFt1@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 2022-09-24 02:10:36, John Ogness wrote:
> Hi,
> 
> This series is essentially the first 18 patches of tglx's RFC series
> [0] with only minor changes in comments and commit messages. It's
> purpose is to lay the groundwork for the upcoming threaded/atomic
> console printing posted as the RFC series and demonstrated at
> LPC2022 [1].
> 
> This series is interesting for mainline because it cleans up various
> code and documentation quirks discovered while working on the new
> console printing implementation.
> 
> Aside from cleanups, the main features introduced here are:
> 
> - Converts the console's DIY linked list implementation to hlist.
> 
> - Introduces a console list lock (mutex) so that readers (such as
>   /proc/consoles) can safely iterate the consoles without blocking
>   console printing.
> 
> - Adds SRCU support to the console list to prepare for safe console
>   list iterating from any context.
> 
> - Refactors buffer handling to prepare for per-console, per-cpu,
>   per-context atomic printing.
> 
> The series has the following parts:
> 
>    Patches  1 - 5:   Cleanups
> 
>    Patches  6 - 12:  Locking and list conversion
> 
>    Patches 13 - 18:  Improved output buffer handling to prepare for
>                      code sharing
> 
> Thomas Gleixner (18):
>   printk: Make pr_flush() static
>   printk: Declare log_wait properly
>   printk: Remove write only variable nr_ext_console_drivers
>   printk: Remove bogus comment vs. boot consoles
>   printk: Mark __printk percpu data ready __ro_after_init

JFYI, I have pushed the first 5 cleanup patches into printk/linux.git,
branch rework/kthreads. The aim is to get them into 6.1.

The rest of the patchset is still being discussed.

Best Regards,
Petr
