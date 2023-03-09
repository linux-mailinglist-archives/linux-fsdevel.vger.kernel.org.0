Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0C6B2296
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCILUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 06:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjCILTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:19:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079C2E8CE1;
        Thu,  9 Mar 2023 03:15:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678360541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2T4EINMRBzFPJZwN9INT1SBZTuErj3LgYj+eGYMBez4=;
        b=xNpDjRXQV0w7qPgya0qSCdZnSvmsrN5+D9NiSJ8W7hjH5L2FSA+U6IN9eEzcQZC7D8T5lK
        2jeIPTwQzAHtm0mgcdkiISsF3TMELVZouR90SaoeddVA7rD+nBl1Z0lA+12sWh1A2ucRU1
        9sxYh/OHiJAJlhMeuJD+eYFjCeJ1sTt9eC4EG20MN2VRK+BUEanoTkJG8xJ20C8lrw4Pr0
        p7cCxe6KQxTE5s8/VBhqxDM0RqsHWGiTHIp6DEifweeAWTXFMLZJ3fFpnyf5rYYb4WHYgR
        EJDMharKYDDXgTsngzUBYpmLZPQpA0qy+wRSVyiQAu1zdkjZtw/nBGLFfbAKxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678360541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2T4EINMRBzFPJZwN9INT1SBZTuErj3LgYj+eGYMBez4=;
        b=VShMsCoDjVA3oby2Q1oOFnBZanLOGCI+zDVwjZ9sjp/xVkU1xQZ/INoTHMFZ2j56lye20h
        QlIUhfmOf6szpdDg==
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v1 00/18] threaded/atomic console support
In-Reply-To: <20230309105539.GA83145@aspen.lan>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230309105539.GA83145@aspen.lan>
Date:   Thu, 09 Mar 2023 12:20:13 +0106
Message-ID: <87a60mjhx6.fsf@jogness.linutronix.de>
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

On 2023-03-09, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> So I grabbed the whole series and pointed it at the kgdb test suite.
>
> Don't get too excited about that (the test suite only exercises 8250
> and PL011... and IIUC little in the set should impact UART polling
> anyway) but FWIW:
>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

One of the claims of this series is that it does not break any existing
drivers/infrastructure. So any successful test results are certainly of
value.

John
