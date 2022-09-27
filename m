Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD75EC57D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiI0OHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiI0OHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:07:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3193113940B;
        Tue, 27 Sep 2022 07:07:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E35621E8E;
        Tue, 27 Sep 2022 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664287633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIU3e8VKH70dw1DweZz2Ipe29gs7JBQEVsw+CaMYFWQ=;
        b=XI9wUmedMf6E1UyuWc4e3n79LzQubDy33YGPFwjBlfACKRnDjZyR7HEY30BmRQLbaUe0Cd
        qSD+VJb4hDaNJVohyul9WGMIRkObQhYCRD+u0fnDEFPzn/ND/e4I+3XQeHX6AnN8drkelU
        dBXjPszwCK2CCOOPC5Jj3VoDX23XI10=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D9B932C166;
        Tue, 27 Sep 2022 14:07:12 +0000 (UTC)
Date:   Tue, 27 Sep 2022 16:07:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 07/18] printk: Convert console list walks for
 readers to list lock
Message-ID: <YzMDjbrPNqK9xJp3@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 2022-09-24 02:10:43, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Facilities which expose console information to sysfs or procfs can use the
> new list protection to keep the list stable. No need to hold console lock.
>
>  drivers/tty/tty_io.c   | 6 +++---
>  fs/proc/consoles.c     | 6 +++---
>  kernel/printk/printk.c | 8 ++++----

As described in the review of the 6th patch, the semantic of
the list_lock (module_mutex) is not well defined from my POV.
I would prefer to keep only one global console lock.

That said, the procf and sysfs interface is read-only. It seems
to be safe to show the info under the new console_srcu read lock.

On the other hand, console_device() should see the console
list in a consistent state. The first console with tty console->driver
should have the CON_CONSDEV flag set. Alternatively, we could
manipulate the list and the flag a safe way from the SRCU POV
but it is not worth it. So, I would keep console_lock()
in console_device() for now.

Best Regards,
Petr
