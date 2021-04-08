Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D987835838A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhDHMpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHMpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:45:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A391C061761
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 05:45:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r12so2812775ejr.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 05:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMuAklHy/tPt7YPBozpvIQsmWDAIa3a/la6+zoUVcdI=;
        b=JXlbvdv6BKxL2QLt+A6EZMYCjKur7zKVGHA+SPjjhttU3LjU5J8CTsvMPL70CwGYsq
         CUXz1jkKLkBNcttlxCmAirFDD+kjBSkQXhxTFfLF/zDE+suTqi1E02kHIf/SGivtkXXC
         r7MEDlKMlo41vpb3rOrLkq/HnnmBY745AuXsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMuAklHy/tPt7YPBozpvIQsmWDAIa3a/la6+zoUVcdI=;
        b=PVKG+i2eKKSQMitZdxpv5GLKEc2BxeBA44UBigSRobFddgkXeYZGDjBoDCEh+ArS1V
         5/xYbSiZEV1zlLsHmnYyIFeP3ztV8tFkP6OpfuLfTXjMtI7EMPaQzHlGbqfSRlQLE7yc
         J5PB0gbLEmWy0Px3W/kH2wZ3NIHGMeai3jQSFigFXd4pIG3t3DYxiWie9wyISO2aRr40
         nSklIkcziZPyaQ3e1fKQDB0NKiAG6yEYBuV2/28LWXqDWbbcfBIyRSGz3AB42o8POA4y
         LWvTEiWL7BvZchr5VGdHozzMobwawJ4HyRZnSGnWeyNj6lee8VRkcnxqAEHk/mmeBZck
         +ASw==
X-Gm-Message-State: AOAM530TSj///vc2EfBfEFVGQ2+/HszSxhEM8gaan3gEj5KAY+ziF8Cy
        beR+8b0MiUNG+po1WTuAtmCcfA==
X-Google-Smtp-Source: ABdhPJwq7QZNDA3D6CGhNZXcz6mj8YzK/fNHfbq7NkBvOdUqzkgcZZF3Ehka2wUefbZcZbtsp6oq8w==
X-Received: by 2002:a17:906:1fd7:: with SMTP id e23mr400958ejt.528.1617885914623;
        Thu, 08 Apr 2021 05:45:14 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id r4sm14262813ejd.125.2021.04.08.05.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 05:45:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <03be4ed9-8e8d-e2c2-611d-ac09c61d84f9@rasmusvillemoes.dk>
Date:   Thu, 8 Apr 2021 14:45:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/04/2021 15.31, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.

Yay.

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.

I think it would be good to have some place to note that "This #include
is just for backwards compatibility, it will go away RealSoonNow, so if
you rely on something from linux/panic.h, include that explicitly
yourself TYVM. And if you're looking for a janitorial task, write a
script to check that every file that uses some identifier defined in
panic.h actually includes that file. When all offenders are found and
dealt with, remove the #include and this note.".

> +
> +struct taint_flag {
> +	char c_true;	/* character printed when tainted */
> +	char c_false;	/* character printed when not tainted */
> +	bool module;	/* also show as a per-module taint flag */
> +};
> +
> +extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];

While you're doing this, nothing outside of kernel/panic.c cares about
the definition of struct taint_flag or use the taint_flags array, so
could you make the definition private to that file and make the array
static? (Another patch, of course.)

> +enum lockdep_ok {
> +	LOCKDEP_STILL_OK,
> +	LOCKDEP_NOW_UNRELIABLE,
> +};
> +
> +extern const char *print_tainted(void);
> +extern void add_taint(unsigned flag, enum lockdep_ok);
> +extern int test_taint(unsigned flag);
> +extern unsigned long get_taint(void);

I know you're just moving code, but it would be a nice opportunity to
drop the redundant externs.

Rasmus
