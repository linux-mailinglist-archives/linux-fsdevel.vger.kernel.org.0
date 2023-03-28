Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF916CBB67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC1Jo3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 05:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjC1Jnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:43:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A73619C;
        Tue, 28 Mar 2023 02:43:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679996626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJUsCpyk++InuJD8c8lxndmlf4x2V623RySxbdpxX/k=;
        b=Uyj1ACFTSvJ37+qTPnzpaAJOMaiSAelVgF1p9i/ti4EZvOobjhHWGgYRRN5sMBjcETUXWR
        1cMdDksX6+EgiwtW6YvmB/kfDTZoBXT7sZrUg01dFAEQ5SvSb0DPTwSla6hBQMI/PQKSWp
        F4eJdNhm2nnljlMOt+yub+n8x7paNu18P2CLLBfbcypP4ViRkic5BnZU4BBmM59Nk/9LZk
        Kksd2lf2VOoed6cIxk7ScVaSPVZmZUGEDFKrGQllQn8LxRbKrPA8ZDpbbkXDtpIO3NHn3n
        DDfIcE76WdRVye+lTkl0k+auwIijCwhdh19hUgAFbuZLFmLaWmELSRkabjZGzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679996626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJUsCpyk++InuJD8c8lxndmlf4x2V623RySxbdpxX/k=;
        b=IplZafMHsF4nv815SX/K+f2hvIwBR0S2XIVpBTpNkVSGZYRCb/mxkvMLfvuGcxKOR0QBGZ
        s7+2n3ygmO8H4JDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: union: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL
 console basic infrastructure
In-Reply-To: <ZCKjSpDbiBVabbP5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
 <ZBnVkarywpyWlDWW@alley> <87y1nip3a1.fsf@jogness.linutronix.de>
 <ZCKjSpDbiBVabbP5@alley>
Date:   Tue, 28 Mar 2023 11:48:06 +0206
Message-ID: <87cz4tus9d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-28, Petr Mladek <pmladek@suse.com> wrote:
>> A compilation check would be nice. Is that possible?
>
> I think the following might do the trick:
>
> static_assert(sizeof(struct cons_state) == sizeof(atomic_long_t));

I never realized the kernel code was allowed to have that. But it is
everywhere! :-) Thanks. I've added and tested the following:

/*
 * The nbcon_state struct is used to easily create and interpret values that
 * are stored in the console.nbcon_state variable. Make sure this struct stays
 * within the size boundaries of that atomic variable's underlying type in
 * order to avoid any accidental truncation.
 */
static_assert(sizeof(struct nbcon_state) <= sizeof(long));

Note that I am checking against sizeof(long), the underlying variable
type. We probably shouldn't assume sizeof(atomic_long_t) is always
sizeof(long).

John
