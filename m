Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F915E93EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiIYPYC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIYPXv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:23:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4702E68A;
        Sun, 25 Sep 2022 08:23:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664119422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYuGfRxRRD8ElWe/MX6vcbHsXtJqzWLNDRr3hQbeYms=;
        b=4o6/Yi8W8TR3wYtjLafNd4nWDKzlEQ5gkc02I+3sxBfpo+9vezn8sQ19N6+TlWDlvcFoeo
        RFsRvT62TZBgT97wmFthNJKAUVJFU+5Ihq6xusXNWhKXuYjLiOY+vfq8S0q1K3s7Q95lUX
        J7bvje9GBQyCD1rofPDn9fo5Jlz8JpsSPmb2PjYpgTAp4leKgkth0ix2cBy4gFQWIpnCAc
        g/ni0Cr0XwYUTLPmDMCLOQyDKr20tfasmCoAkeq8fdWTqwUMU4hUVefInzz2MW6iYhTgCx
        ZWjQioSQ2Ure1/UJBQvd+vyXD3njCGMVlXy2axBfZ7zb4e3BxjdG+6ZDPlTpnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664119422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYuGfRxRRD8ElWe/MX6vcbHsXtJqzWLNDRr3hQbeYms=;
        b=H6VsHstNf5MPQfIzMB81iwdLZoKfcg9RiYTwfM9z+i652PjiqjMzynDssmCOuun7W04ekK
        8/JHdHOKiDhav9CA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
In-Reply-To: <Yy6nVpd3+yogT5pJ@kroah.com>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <Yy6nVpd3+yogT5pJ@kroah.com>
Date:   Sun, 25 Sep 2022 17:29:41 +0206
Message-ID: <87czbj7a0y.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-09-24, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> These all look great to me, thanks for resending them.
>
> Do you want them to go through my serial/tty tree, or is there some
> other tree to take them through (printk?)

Thanks Greg. but I would prefer they go through the printk tree. In
particular, I want Petr to have the chance to review patches 15-18.

> If they are to go through someone else's tree, feel free to add:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

John
