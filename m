Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112A45E88CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiIXGoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiIXGoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 02:44:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1504811D0D1;
        Fri, 23 Sep 2022 23:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EDA4DCE0A1D;
        Sat, 24 Sep 2022 06:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B217FC433D6;
        Sat, 24 Sep 2022 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664001847;
        bh=XU+g1TD85eu+F7lKIDh9lt03VNI1wjjOGHmpCB5PpDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuBuothuIcm+Rf/8d4hwbhg/hA+Gss6N8vAry1R91LV411DY530k21Lse+D8jK9GG
         RpObjQM3WoK71AFU96BN6LRe54sLdG/uz1FMIPcnkAD74N/BuW+r/s/f/dz+lbhX0r
         cXIqKeTiJ/jKqhCUt4kEWx27bLxhdSydHSx5SXog=
Date:   Sat, 24 Sep 2022 08:44:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
Message-ID: <Yy6nVpd3+yogT5pJ@kroah.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 24, 2022 at 02:10:36AM +0206, John Ogness wrote:
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

These all look great to me, thanks for resending them.

Do you want them to go through my serial/tty tree, or is there some
other tree to take them through (printk?)

If they are to go through someone else's tree, feel free to add:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
