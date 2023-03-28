Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0836CBFD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjC1Mx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 08:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjC1Mw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:52:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0662B446;
        Tue, 28 Mar 2023 05:52:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A88C421A1C;
        Tue, 28 Mar 2023 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680007925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+VUczrl0KAxI7EZN7FCXQRJ3Opnej6HpZXA3PfYYOIY=;
        b=rgFMGzQUiwPIo9UZ0Tt9qM0SwjsEFRZmQbwj5nHSIzv70eyH18ICVfJP+j9ZsGEz+BloqC
        8G9ulxvsFiJl0olk6pP0HZr1QSE06eXGfaq4a62OOa0OcOYyp33r4+vqW2VGvz5x2tSi/l
        YHkncyrlf/3M71M3IURyyFKNDtK0RWQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 474132C141;
        Tue, 28 Mar 2023 12:52:05 +0000 (UTC)
Date:   Tue, 28 Mar 2023 14:52:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: union: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL
 console basic infrastructure
Message-ID: <ZCLi8kWOdq8dwxSH@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
 <ZBnVkarywpyWlDWW@alley>
 <87y1nip3a1.fsf@jogness.linutronix.de>
 <ZCKjSpDbiBVabbP5@alley>
 <87cz4tus9d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz4tus9d.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2023-03-28 11:48:06, John Ogness wrote:
> On 2023-03-28, Petr Mladek <pmladek@suse.com> wrote:
> >> A compilation check would be nice. Is that possible?
> >
> > I think the following might do the trick:
> >
> > static_assert(sizeof(struct cons_state) == sizeof(atomic_long_t));
> 
> I never realized the kernel code was allowed to have that. But it is
> everywhere! :-) Thanks. I've added and tested the following:
> 
> /*
>  * The nbcon_state struct is used to easily create and interpret values that
>  * are stored in the console.nbcon_state variable. Make sure this struct stays
>  * within the size boundaries of that atomic variable's underlying type in
>  * order to avoid any accidental truncation.
>  */
> static_assert(sizeof(struct nbcon_state) <= sizeof(long));
> 
> Note that I am checking against sizeof(long), the underlying variable
> type. We probably shouldn't assume sizeof(atomic_long_t) is always
> sizeof(long).

Makes sense and looks good to me.

Best Regards,
Petr
