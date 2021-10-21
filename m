Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915C84368C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJURL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJURLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:11:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041D6C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 10:09:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so3639741pjl.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/h3z+ZI1NEezvcalKf2dOAyWJ+jaOF20N5IW04VxMnA=;
        b=EDjRl+XfT9L+B0/Ui2ATB7qVPuwaM4acCWeRrcT+9g5GbxL0WJjmTq5c1ovmol2FJ0
         1fskzEINTfsYw8g8nAAbg2ogfzpc+mC2cO++Uro/3Z17oY0UGCsaxq0L4FpQ5hTR0B+i
         4F82TStCNcJSBnVJ6HHpuKiPMrmrBZjNNQaQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/h3z+ZI1NEezvcalKf2dOAyWJ+jaOF20N5IW04VxMnA=;
        b=1UEBSMakcnGK8QmUNaRHgIoUbgl1Nuooj7HdSFcTIQXlw7msOA4nSuBJi2C06/zALX
         +MTWsAZlSy7x4PqJ7OiNK83YcjOnVW+fwW6W779YvqgudrARizQQ3JYb7FJYQU2WRmoB
         3v4Gas/ERh9v2I/OqR7wv1TupuM6vgaSGxUeizHH69qPBYqfkMoHv7CJ0pK9hM/iwzjP
         t/FjG1zL07Wv6Buw91Dyhi0giurqDeSyi0m9OgikRr6o686ABfQRYnSXDJZHX4flbgaK
         nZnQ2UMA36oCjTdKJsLm66Mb8xTw0s9AqjqIKaQNsPAZgsqVt5FSvd/B3wmK7lAOqd1E
         6Wng==
X-Gm-Message-State: AOAM533TgygI662SBiDD5fsvthuTNDMmTU4bcSiyLOE7PU/tYlwMzQeD
        84d6pnOjqO+N8yEJ732kDsDwEAAYtKjmEA==
X-Google-Smtp-Source: ABdhPJx8xZPWUk8RdvIXPnnT/qf52D2k5QZILuisiCA7VHLuTMbbMXlu18CbRyoTtGgVOEZWXBbOqw==
X-Received: by 2002:a17:90b:38c6:: with SMTP id nn6mr8039311pjb.246.1634836174380;
        Thu, 21 Oct 2021 10:09:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y13sm6032193pgc.46.2021.10.21.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 10:09:34 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:09:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>, jannh@google.com,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian.brauner@ubuntu.com,
        amistry@google.com, Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, axboe@kernel.dk,
        metze@samba.org, laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Make sure wchan works when it exists
Message-ID: <202110211008.CC8B26A@keescook>
References: <20211008235504.2957528-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008235504.2957528-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 04:55:04PM -0700, Kees Cook wrote:
> This makes sure that wchan contains a sensible symbol when a process is
> blocked. Specifically this calls the sleep() syscall, and expects the
> architecture to have called schedule() from a function that has "sleep"
> somewhere in its name. For example, on the architectures I tested
> (x86_64, arm64, arm, mips, and powerpc) this is "hrtimer_nanosleep":
> 
> $ tools/testing/selftests/proc/proc-pid-wchan
> ok: found 'sleep' in wchan 'hrtimer_nanosleep'
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping.

> ---
> Hi Peter,
> 
> Can you add this to the wchan series, please? This should help wchan from
> regressing in the future, and allow us to notice if the depth accidentally
> changes, like Mark saw.
> ---

I'd like to make sure we have a regression test for this. Will you add
this to the wchan series please?

-Kees

-- 
Kees Cook
