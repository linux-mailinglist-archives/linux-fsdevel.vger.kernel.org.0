Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6124B6B28E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCIPdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjCIPc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:32:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5B44A4;
        Thu,  9 Mar 2023 07:32:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C713820157;
        Thu,  9 Mar 2023 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678375973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=quA1wtVIFMTnXp+eZD0K7wbRNFsGXtBDlP7KMrESYkA=;
        b=CfvWCEqTzpt7CElb+91qOk57anSKDNu9Ooj51pNUc1qvS3X2ojSoChPAr3jKNESlO76ctX
        6SkehSo5gpGLRGZUwrPcWCo2FywrtlNZos75QhTHDuBDSjYZrgpzVhHTHu3q772feu1vZP
        Lw0vFF2EPZh0dYwsyssFp/wxAOSH1yU=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B1092C141;
        Thu,  9 Mar 2023 15:32:52 +0000 (UTC)
Date:   Thu, 9 Mar 2023 16:32:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: naming: Re: [PATCH printk v1 05/18] printk: Add non-BKL console
 basic infrastructure
Message-ID: <ZAn8IC+hj+y01vgs@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2023-03-02 21:02:05, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current console/printk subsystem is protected by a Big Kernel Lock,
> (aka console_lock) which has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and
> makes forced takeover and output in emergency and panic situations a
> fragile endavour which is based on try and pray.
> 
> The goal of non-BKL consoles is to break out of the console lock jail
> and to provide a new infrastructure that avoids the pitfalls and
> allows console drivers to be gradually converted over.
> 
> The proposed infrastructure aims for the following properties:
> 
>   - Per console locking instead of global locking
>   - Per console state which allows to make informed decisions
>   - Stateful handover and takeover
> 

So, this patch adds:

	CON_NO_BKL		= BIT(8),

	struct cons_state {

	atomic_long_t		__private atomic_state[2];

	include/linux/console.h
	kernel/printk/printk_nobkl.c

	enum state_selector {
		CON_STATE_CUR,

	cons_state_set()
	cons_state_try_cmpxchg()

	cons_nobkl_init()
	cons_nobkl_cleanup()


later patches add:

	console_can_proceed(struct cons_write_context *wctxt);
	console_enter_unsafe(struct cons_write_context *wctxt);

	cons_atomic_enter()
	cons_atomic_flush();

	static bool cons_emit_record(struct cons_write_context *wctxt)


All the above names seem to be used only by the NOBLK consoles.
And they use "cons", "NO_BKL", "nobkl", "cons_atomic", "atomic", "console".

I wonder if there is a system or if the names just evolved during several
reworks.

Please, let me know if I am over the edge, like too picky and that it
is not worth it. But you know me. I think that it should help to be
more consistent. And it actually might be a good idea to separate
API specific to the NOBKL consoles.

Here is my opinion:

1. I am not even sure if "nobkl", aka "no_big_kernel_lock" is the
   major property of these consoles.

   It might get confused by the real famous big kernel lock.
   Also I tend to confuse this with "noblk", aka "non-blocking".

   I always liked the "atomic consoles" description.


2. More importantly, an easy to distinguish shortcat would be nice
   as a common prefix. The following comes to my mind:

   + nbcon - aka nobkl/noblk consoles API
   + acon  - atomic console API


It would look like:

a) variant with nbcom:


	CON_NB		= BIT(8),

	struct nbcon_state {
	atomic_long_t		__private atomic_nbcon_state[2];

	include/linux/console.h
	kernel/printk/nbcon.c

	enum nbcon_state_selector {
		NBCON_STATE_CUR,

	nbcon_state_set()
	nbcon_state_try_cmpxchg()

	nbcon_init()
	nbcon_cleanup()

	nbcon_can_proceed(struct cons_write_context *wctxt);
	nbcon_enter_unsafe(struct cons_write_context *wctxt);

	nbcon_enter()
	nbcon_flush_all();

	nbcon_emit_next_record()


a) varianta with atomic:


	CON_ATOMIC		= BIT(8),

	struct acon_state {
	atomic_long_t		__private acon_state[2];

	include/linux/console.h
	kernel/printk/acon.c  or atomic_console.c

	enum acon_state_selector {
		ACON_STATE_CUR,

	acon_state_set()
	acon_state_try_cmpxchg()

	acon_init()
	acon_cleanup()

	acon_can_proceed(struct cons_write_context *wctxt);
	acon_enter_unsafe(struct cons_write_context *wctxt);

	acon_enter()
	acon_flush_all();

	acon_emit_next_record()


I would prefer the variant with "nbcon" because

	$> git grep nbcon | wc -l
	0

vs.

	$> git grep acon | wc -l
	11544


Again, feel free to tell me that I ask for too much. I am not
sure how complicated would be to do this mass change and if it
is worth it. I can review this patchset even with the current names.

My main concern is about the long term maintainability. It is
always easier to see patches than a monolitic source code.
I would like to reduce the risk of people hating us for what "a mess"
we made ;-)

Well, the current names might be fine when the legacy code gets
removed one day. The question is how realistic it is. Also we
probably should make them slightly more consistent anyway.

Best Regards,
Petr
