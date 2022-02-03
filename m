Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE834A7D62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 02:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348768AbiBCBSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 20:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiBCBSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:18:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D43DC061714;
        Wed,  2 Feb 2022 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mJU2H5U0ZcOcPwMNnUPSpSU79DaLOwiDWUjkvLctXEM=; b=hUWT+V8HJQPlcDLLdldM3+sEDt
        8qqkCKpWwDyRMcku4wEXF+brknScwvtcglKT7KJlfrUm58mKfQa6ROQuzhDr5cVk2Qn/AC4FvdFzS
        s7bAaALKKc6gg/pVCnnmihuKZ/eA5kLFomRSksc0xrJmdmDAc081eai4j40piCYRLmx+emPETQQ2Q
        Sc6pfbT/eVSjdfSGduHXJ6YOm4QYQ7I7bvLsZrAcHRoIQEAlH3t3qaLgvNJvwAF2XyZ/slvuOa+4K
        wPT8gU3zS6Eq7TFfvb53Jus+9AppLj00XLdSoR1RMdbLj5cDaWNofsyWTPfKGqL8zbauMnSEnQXsS
        hbLzedMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFQkz-00HI1W-BW; Thu, 03 Feb 2022 01:17:53 +0000
Date:   Wed, 2 Feb 2022 17:17:53 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     tangmeng <tangmeng@uniontech.com>, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] kernel/time: move timer sysctls to its own file
Message-ID: <YfstQeOpZuQzBmZJ@bombadil.infradead.org>
References: <20220131102214.2284-1-tangmeng@uniontech.com>
 <87wnicssth.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnicssth.ffs@tglx>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 01:21:46AM +0100, Thomas Gleixner wrote:
> In other words, invite everyone to add random sysctls as they see fit
> w/o a central review authority.

Everyone already can do that already. We can't stop that.

> That's not an improvement at all. Quite
> the contrary.

The idea is to move them to the respective subsystem / driver.

To be clear the argument put forwards to move sysctls out of one file
was not started by tangmeng but by me and that work is already mostly
merged for at least all the fs stuff. The rest of the patches coming
through is help to move the other stuff to other areas.

The truth is kernel/sysctl.c as of the last 2 kernel releases before
*was* huge and it can lead to tons of conflicts when doing merges.
This makes it hard to maintain and even review changes.

*Today* all filesystem syctls now get reviewed by fs folks. They are
all tidied up there.

In the future x86 folks can review their sysctls. But for no reason
should I have to review every single knob. That's not scalable.

> That aside, I'm tired of this because this is now at V5 and you still
> failed to fix the fallout reported by the 0-day infrastructure vs. this
> part of the patch:
> 
> > +static int __init timer_sysctl_init(void)
> > +{
> > +	register_sysctl_init("kernel", timer_sysctl);
> > +	return 0;
> > +}
> 
>     kernel/time/timer.c: In function 'timer_sysctl_init':
>  >> kernel/time/timer.c:284:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
>       284 |         register_sysctl_init("kernel", timer_sysctl);
> 	  |         ^~~~~~~~~~~~~~~~~~~~
> 

That's an issue with the patch being tested on a tree where that
routine is not present?

  Luis
