Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC51546C325
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 19:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhLGSyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 13:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhLGSyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:54:25 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26802C061756
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 10:50:54 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k2so29182023lji.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gmb+Apudh+c3b4tBgmQNZgnlcpZS4tKe6ho/6WlprlI=;
        b=QDFc9P5aML7+YtJ4kv8ohPRs/NxD8Xl31/KC9meyRbjsUWaCD8+eUYuX6yVUlGqPHd
         KK5IUmkhYJUj3NsARjU1eko53272JkmdRrJUgX+l9Aw8osNMVvggDJ3o5a2SoDGLt8Xb
         QZuDre4bR/z4KskwYlkuCw9lTYA7xJJPi1fr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gmb+Apudh+c3b4tBgmQNZgnlcpZS4tKe6ho/6WlprlI=;
        b=K5HLE0CMoZcoY1AHWw5c530hZH5orwSwaN2wLaAlUJi6v2Af+VGUbZSjHc1r0FXgON
         nADLbGlnMY1jdygpD4uGbmsuZHpc6I2AakAqjAZyAfOcU4Wf39wGJ0dqTxs9BKzGCcNc
         SJYtvZVlRpEAGjq7U9AShL0COFAHdxC9Z6GKo6B+jdN90a0Gy3W2vx6tHNcAgkKOLtPC
         z6UOIpfcufiTmRr89QX3zXcsm58jY7HK/57h0ClcWmHQ9xI0jyLkzKeR+4BUhd1qsiAj
         oehkLrJOg3RAflP9XNDWgDJL+wiCSlqfqCr3iX3T8UJqyWxUzUZX3IoVxXiU53Tz6K+7
         AyyQ==
X-Gm-Message-State: AOAM530HEinHu00kF+KJUzyR1+YDepzPI/ZfwDzsyXPj1mOrpSo3c8sm
        TfqkdlP4rO1enEdE3epik2H9KFd3o/2mqbeMUmU=
X-Google-Smtp-Source: ABdhPJyjr/HDMh/J20zgtYOm3gke+VkhrX9aOMdD76SDdWB0xJYPBavYosm0s+JgI2jKVXPw3w2NKw==
X-Received: by 2002:a2e:a376:: with SMTP id i22mr44105241ljn.201.1638903051303;
        Tue, 07 Dec 2021 10:50:51 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a23sm32156ljh.140.2021.12.07.10.50.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:50:51 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id p8so29175948ljo.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 10:50:51 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr54258440wrn.318.1638903040805;
 Tue, 07 Dec 2021 10:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20211207150927.3042197-1-arnd@kernel.org> <20211207150927.3042197-3-arnd@kernel.org>
 <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
In-Reply-To: <CAHk-=wgwQg=5gZZ6ewusLHEAw-DQm7wWm7aoQt6TYO_xb0cBog@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 10:50:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjsdmyN3qYjA-Z4bqhin2ZFkssRaaTRm_LdJBqexTxWfQ@mail.gmail.com>
Message-ID: <CAHk-=wjsdmyN3qYjA-Z4bqhin2ZFkssRaaTRm_LdJBqexTxWfQ@mail.gmail.com>
Subject: Re: [RFC 2/3] headers: introduce linux/struct_types.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 7, 2021 at 10:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ugh. I liked your 1/3 patch, but I absolutely detest this one.

Actually, it was 3/3 I liked and that made sense to me.

1/3 isn't pretty, but I can live with it.

          Linus
