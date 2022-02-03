Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D64A8CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353874AbiBCTxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiBCTxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:53:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA69C061714;
        Thu,  3 Feb 2022 11:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4C4OCa1Nvs01R45W3Ay9R6lIjYfrb4U7/RUPw787LQ=; b=3L3r68S46ebKK9cqWNZF8HkI54
        J8mtXyCYmYNlqaERNHO5V1F29b+IU8JPO4OgbpQDQSUVZXoAw2dAMkUBoa9XyXol+ivw4/4XVfKJn
        XiBn8mxCoN9vC87Sh2qzN/ikL3VP+ahD3YA+4cSBe3rR57wfXAlYK9CrRARUTS7ciL77+0ZjZKhOO
        FJzSgm4EXqP6C9vEDj1QifOmMqIEzkclS9YfowjfchaY5zWe+fvWsolVY9NbXQo6wp3Mss2bw3dfb
        +49iFDJVMH0PZDwbThqWOvc2y8eavytlwbUBp6zUA0htlPJW5DZmbQcSfPRGWBlXVwskwgdX3Hct7
        ITvV0tIg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFiAd-002eDE-49; Thu, 03 Feb 2022 19:53:31 +0000
Date:   Thu, 3 Feb 2022 11:53:31 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        tangmeng <tangmeng@uniontech.com>, keescook@chromium.org,
        yzaikin@google.com, john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] kernel/time: move timer sysctls to its own file
Message-ID: <Yfwyu0N4+f51J9OU@bombadil.infradead.org>
References: <20220131102214.2284-1-tangmeng@uniontech.com>
 <87wnicssth.ffs@tglx>
 <YfstQeOpZuQzBmZJ@bombadil.infradead.org>
 <87r18ks379.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r18ks379.ffs@tglx>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:35:06AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 02 2022 at 17:17, Luis Chamberlain wrote:
> > On Thu, Feb 03, 2022 at 01:21:46AM +0100, Thomas Gleixner wrote:
> > *Today* all filesystem syctls now get reviewed by fs folks. They are
> > all tidied up there.
> >
> > In the future x86 folks can review their sysctls. But for no reason
> > should I have to review every single knob. That's not scalable.
> 
> Fair enough, but can we please have a changelog which explains the
> rationale to the people who have not been part of that discussion and
> decision.

Sure thing, tangmeng please update the commit log a bit better.

> >> That aside, I'm tired of this because this is now at V5 and you still
> >> failed to fix the fallout reported by the 0-day infrastructure vs. this
> >> part of the patch:
> >> 
> >> > +static int __init timer_sysctl_init(void)
> >> > +{
> >> > +	register_sysctl_init("kernel", timer_sysctl);
> >> > +	return 0;
> >> > +}
> >> 
> >>     kernel/time/timer.c: In function 'timer_sysctl_init':
> >>  >> kernel/time/timer.c:284:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'timer_sysctl_init'? [-Werror=implicit-function-declaration]
> >>       284 |         register_sysctl_init("kernel", timer_sysctl);
> >> 	  |         ^~~~~~~~~~~~~~~~~~~~
> >> 
> >
> > That's an issue with the patch being tested on a tree where that
> > routine is not present?
> 
> From the report:
> 
>   ...
>   [also build test ERROR on linus/master
> 
> Linus tree has this interface. So that's not the problem.
> 
> Hint #1: The interfaxce is not available unconditionally
> 
> Hint #2: The 0-day reports provide the config file which exposes the
>          fail

tangmeng, please fix.

  Luis
