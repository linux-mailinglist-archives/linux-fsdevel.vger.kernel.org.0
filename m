Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC24F03B2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiDBOEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiDBOE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:04:29 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360E1877CF;
        Sat,  2 Apr 2022 07:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=icAzEvW9eshnhDDfO4k2r0xUbbSJoCJF2BriJcmZNbs=; b=T2f5fscevlWSEb+/xhKV5fAIlF
        wpTfSa4ML3NUQn7Iy4w0Cl+WmkLxWaCwKZjCghK+UY3ec6GKTY3Dtju3O3r9RI7nhzCPVIqH+fnlH
        QvklxrbXyWJspyn/YcMmekOM/Nh1Iybs+P+2WQQqA9Uu7d/FmPo34+BxVaYspiZFaUtJ3Oju5oQVq
        Oyj9h+sR9w+Xzs0rTsg1ultpfEA5VgXRtfI6yOSAVNj3siEvv67mYnZ8ZGZjSfRzTj5XKzjBGDkl4
        kEae9d4Ols3FfRk0gXyTpI/v0B67+W74Rnic+6Az+L/pFPMmlnA3SK/+DsJ+r6om94wQMglZ+mLgo
        sw5jmdlw==;
Received: from [177.138.180.15] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1naeKT-0006Wc-Lz; Sat, 02 Apr 2022 16:02:14 +0200
Message-ID: <f2fe220f-70c9-7b95-a9cb-4709752e4bdc@igalia.com>
Date:   Sat, 2 Apr 2022 11:01:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC 0/1] Add sysctl entry for controlling
 crash_kexec_post_notifiers
Content-Language: en-US
To:     Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, corbet@lwn.net,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        ebiggers@google.com, peterz@infradead.org, ying.huang@intel.com,
        mchehab+huawei@kernel.org, Jason@zx2c4.com, daniel@iogearbox.net,
        robh@kernel.org, wangqing@vivo.com, prestwoj@gmail.com,
        dsahern@kernel.org, stephen.s.brennan@oracle.com
References: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220401202300.12660-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/04/2022 17:22, Alejandro Jimenez wrote:
> I noticed that in contrast to other kernel core parameters (e.g. kernel.panic,
> kernel.panic_on_warn, kernel.panic_print) crash_kexec_post_notifiers is not
> available as a sysctl tunable. I am aware that because it is a kernel core
> parameter, there is already an entry under:
> 
>   /sys/module/kernel/parameters/crash_kexec_post_notifiers
> 
> and that allows us to read/modify it at runtime. However, I thought it should
> also be available via sysctl, since users that want to read/set this value at
> runtime might look there first.
> 
> I believe there is an ongoing effort to clean up kernel/sysctl.c, but it wasn't
> clear to me if this entry (and perhaps the other panic related entries too)
> should be placed on kernel/panic.c. I wanted to verify first that this change
> would be welcomed before doing additional refactoring work.
> 
> I'd appreciate any comments or suggestions.
> 
> Thank you,
> Alejandro

Hi Alejandro, thanks for you patch. I have a "selfish" concern though,
I'll expose it here.

I'm working a panic refactor, in order to split the panic notifiers in
more lists - good summary of this discussion at [0].
I'm in the half of the patches, hopefully next 2 weeks I have something
ready to submit (I'll be out next week).

As part of this effort, I plan to have a more fine-grained control of
this parameter, and it's going to be a sysctl, but not
"crash_kexec_post_notifiers" - this one should be kept I guess due to
retro-compatibility, but it'd be a layer on top oh the new one.
With that said, unless you have urgent needs for this patch to be
reviewed/merged , I'd like to ask you to wait the series and I can loop
you there, so you may review/comment and see if it fits your use case.

Thanks,


Guilherme


[0] https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/
