Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2C4A7CBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 01:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbiBCAVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 19:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiBCAVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:21:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5810BC061714;
        Wed,  2 Feb 2022 16:21:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643847707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEbNuUaeESsbucNNxWCSNAVotbkzKzn/eOuBs8ycKg0=;
        b=IMnepHfdalRiGysYHX7LfnKshsG5zdFcG6DYWr7nwEuByFG9qxqYnv7rrSDQFRC54UiNUt
        mvd1AXERhe64nvhyFI+ahmenkr9hK0A0S8+64Raq7PQDtsjPIROFK0lYgqfFvbW9XkwbzQ
        BhMSpdcO3/6IcqzlF0u28L2YwIuOYeqxpK6ahSaibD9qPADHldgwKjahrWIVFR2gSuKLiV
        WT1GHAPXrzjgax1zfOLrqLJxECVk8jjtqTisPcy8vhXZQcCkyvJ150+KipQMIf82n8rtN/
        CpmCj07Ipp4wybFpiwExkRYBNlKQzP+Dnq1YMagiIQFi75Ml3NqU33WnO8wYnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643847707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEbNuUaeESsbucNNxWCSNAVotbkzKzn/eOuBs8ycKg0=;
        b=ttdkmFz2pO6CB9U65vVYu3aA5mjj/UcMMXrDKsiJED0oOMRdTFbbHgc+Cs8YeGKvx0hHgw
        z/cTrL+kqOiYo5Aw==
To:     tangmeng <tangmeng@uniontech.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] kernel/time: move timer sysctls to its own file
In-Reply-To: <20220131102214.2284-1-tangmeng@uniontech.com>
References: <20220131102214.2284-1-tangmeng@uniontech.com>
Date:   Thu, 03 Feb 2022 01:21:46 +0100
Message-ID: <87wnicssth.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tangmeng,

On Mon, Jan 31 2022 at 18:22, tangmeng wrote:
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.

Sorry. That's just a lame argument. What exactly is hard to maintain on
that file? A large table of ifdeffed sysctl entries which changes once
in a blue moon is hardly a maintenance problem.

Aside of that, sysctl.c is a very conveniant way to look up the zoo of
sysctls which you now spread out all over the source tree.

So you really need to come up with a technical and sensical explanation
for this change.

> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.

In other words, invite everyone to add random sysctls as they see fit
w/o a central review authority. That's not an improvement at all. Quite
the contrary.

That aside, I'm tired of this because this is now at V5 and you still
failed to fix the fallout reported by the 0-day infrastructure vs. this
part of the patch:

> +static int __init timer_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", timer_sysctl);
> +	return 0;
> +}

    kernel/time/timer.c: In function 'timer_sysctl_init':
 >> kernel/time/timer.c:284:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
      284 |         register_sysctl_init("kernel", timer_sysctl);
	  |         ^~~~~~~~~~~~~~~~~~~~

It's pretty damned obvious why this fails to compile and the 0-day
reports have all the information you need to reproduce and address this,
but you prefer to ignore it and just resend yet another incarnation.

Feel free to ignore these reports, but then please do not be surprised
when I ignore your patches. Our development process is well documented
and it's not subject to your personal interpretation.

Thanks,

        tglx
