Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF14A818A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 10:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiBCJfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 04:35:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiBCJfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:35:08 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643880907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4niGU0MsRpZHoaPG3ycpTgf3GT1iqYBqPQhEgMj1fg=;
        b=0deUg20vq2mbgKBr4VvIlYVyP9ZU64oP5pRbhlEBMCFP1y4uPecyB7KplTDbjGIZB/nUrm
        Qfc7AwsRnnmQ05lFrKmfoVkjHeEW+qKtp7MaLfJQ2DvHqqrN5NechgPuN/MNkhDVEvEjzR
        BxwVyg9DT9brSWUROBc5DJ/oxKQxceHRujWRgE3Ri1Ua3p65BxJlthNrQZxw1YXPJGeeEz
        Q32X91IIR4GTy9MWODnpt+tPjQWZmVwo/C/1xWfYnX1tkp0CG5cr/lVOQNNU7eXX2ZZp2a
        e8Cwj1ek67ZJMcYHND+fdo0fl+XOFMCXQJSvwXDO6ePuaDRrDj5ucqwiIQuWIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643880907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b4niGU0MsRpZHoaPG3ycpTgf3GT1iqYBqPQhEgMj1fg=;
        b=MAxLSLRBTTV0ilKIuy2fIp3BpvJN7QHQoa7UpaqG/hhe/eeJST2DfcPH9NakwnNhWjh+8d
        J2vJY5ocA6QZjhCA==
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     tangmeng <tangmeng@uniontech.com>, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] kernel/time: move timer sysctls to its own file
In-Reply-To: <YfstQeOpZuQzBmZJ@bombadil.infradead.org>
References: <20220131102214.2284-1-tangmeng@uniontech.com>
 <87wnicssth.ffs@tglx> <YfstQeOpZuQzBmZJ@bombadil.infradead.org>
Date:   Thu, 03 Feb 2022 10:35:06 +0100
Message-ID: <87r18ks379.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 02 2022 at 17:17, Luis Chamberlain wrote:
> On Thu, Feb 03, 2022 at 01:21:46AM +0100, Thomas Gleixner wrote:
> *Today* all filesystem syctls now get reviewed by fs folks. They are
> all tidied up there.
>
> In the future x86 folks can review their sysctls. But for no reason
> should I have to review every single knob. That's not scalable.

Fair enough, but can we please have a changelog which explains the
rationale to the people who have not been part of that discussion and
decision.

>> That aside, I'm tired of this because this is now at V5 and you still
>> failed to fix the fallout reported by the 0-day infrastructure vs. this
>> part of the patch:
>> 
>> > +static int __init timer_sysctl_init(void)
>> > +{
>> > +	register_sysctl_init("kernel", timer_sysctl);
>> > +	return 0;
>> > +}
>> 
>>     kernel/time/timer.c: In function 'timer_sysctl_init':
>>  >> kernel/time/timer.c:284:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
>>       284 |         register_sysctl_init("kernel", timer_sysctl);
>> 	  |         ^~~~~~~~~~~~~~~~~~~~
>> 
>
> That's an issue with the patch being tested on a tree where that
> routine is not present?

From the report:

  ...
  [also build test ERROR on linus/master

Linus tree has this interface. So that's not the problem.

Hint #1: The interfaxce is not available unconditionally

Hint #2: The 0-day reports provide the config file which exposes the
         fail

Let me know if you need more hints. :)

Thanks,

        tglx

