Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD2322D10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhBWPCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhBWPCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:02:24 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA1C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:01:44 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b14so16403016qkk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hp3qEo1mGTYNWoUMN5eqstUYboCeaha+fsI0VeFao8I=;
        b=NpoxNpI2xc6id5NxW69KE4oQHURDwpHadhXC0xgwScEvzu6B3BYS65Ts2ipL2b5x5i
         9qRzpx2cp0UuMcYS9wNZU99DI50I20Lzx28ST3d5Fy/tm1Jb39w/+yLFSNZFCj/jn/p2
         PzofcMolX+u5QUpmMwyRWtWgWUs3YdEnUXpqHV/DloHT9TlmY/sY46fmBdMPZrqkRcne
         ruvrrRPv4mjFdUobX6w+4f+lJ2UyFGZTId6fyo2yNNQAfefhmP8iRRqQfhgm/54mrhCN
         nDJCdPLLxzzScamPVTLgEkOsmHLBb/Rmy3HUyrMfPmwd8k8zPPzuN24RhheyuowY/zUH
         HwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hp3qEo1mGTYNWoUMN5eqstUYboCeaha+fsI0VeFao8I=;
        b=t0SRb864A17Ltgd9Ui2krLpn20HU1G82bwR8pJE0yRAt2DxanSoF56h3XcWDDe02x2
         NnJuBNSZPgVUyY2dUVlXpaA5bqX2jAHY+ttbhx7IKOySQe/I/EEgZBAHdmFf23M9Hv3B
         eSnPD/60EmIx2rgEKJdMwpOytNWRfPr99mz8csdKwUinG4nb4dE9NQXHWWNP6FuUMWTo
         odS76+1hUGl+D3tjIkU1Lhtnno2nYDe50Y7HFkkilxHNhUnOAu3ny08c55WblU7mPTnY
         QrWfy9lMaZDXr6tGTzJUFg8oxewkQ///ld3k90yPoHdOqyfLr1ZpzmToUzigpxSLF/db
         xXzg==
X-Gm-Message-State: AOAM5320LtzFd3cNmvWPLc2YYhzbAYO99UqWbeT9m7LsrKxQf2p2Wziu
        ucZ9e2AWF/2ZfEa59s4K78yUu+hOeHMSQVKM1OMzHw==
X-Google-Smtp-Source: ABdhPJw6UKYVFPz/CXh42YoBul3onc+AZoBiJMkC1Af1LwZeOWz/AmT0zvsZAKnQDZgJNcF2m+3XhRxKkp71viQlf0I=
X-Received: by 2002:a37:46cf:: with SMTP id t198mr26670036qka.265.1614092503361;
 Tue, 23 Feb 2021 07:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-5-elver@google.com>
In-Reply-To: <20210223143426.2412737-5-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Feb 2021 16:01:32 +0100
Message-ID: <CACT4Y+aq6voiAEfs0d5Vd9trumVbnQhv-PHYfns2LefijmfyoQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] perf/core: Add breakpoint information to siginfo
 on SIGTRAP
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 3:34 PM Marco Elver <elver@google.com> wrote:
>
> Encode information from breakpoint attributes into siginfo_t, which
> helps disambiguate which breakpoint fired.
>
> Note, providing the event fd may be unreliable, since the event may have
> been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
> triggering and the signal being delivered to user space.
>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  kernel/events/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8718763045fd..d7908322d796 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6296,6 +6296,17 @@ static void perf_sigtrap(struct perf_event *event)
>         info.si_signo = SIGTRAP;
>         info.si_code = TRAP_PERF;
>         info.si_errno = event->attr.type;
> +
> +       switch (event->attr.type) {
> +       case PERF_TYPE_BREAKPOINT:
> +               info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
> +               info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
> +               break;
> +       default:
> +               /* No additional info set. */

Should we prohibit using attr.sigtrap for !PERF_TYPE_BREAKPOINT if we
don't know what info to pass yet?

> +               break;
> +       }
> +
>         force_sig_info(&info);
>  }
>
> --
> 2.30.0.617.g56c4b15f3c-goog
>
