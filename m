Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DEC3231DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhBWUIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 15:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhBWUHf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:07:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 138C164EAD;
        Tue, 23 Feb 2021 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614110815;
        bh=18JzbvqWGWvOaX8sGgbXQ8ZBt6M8MWKzgoqyxsrjh/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jme//fgHeOes3SI3UlLbu8aQMEsNJIIdLE5iTobsvB3uDhkLnsCtKAu65fqamJwb2
         DKBCB6HqdngiG1fu/MIctv0Z0jFH/vl6oySNGLr99pvsQkYCdv9UXqIx0kU7+uSOMh
         m6wYMwMgjbxXHBtUs1JEQcYbhupQL1LVUMCM0kX1I6Rn075pFCBViKUvhkl5/FbtCm
         4ZwICoq+TTHFBvbeAWOnBjJIIyUEAj+mrNZWBW5U7B/Mzz66sYSTjN5nQY52SMj8n4
         kNf5FDHyfCs9SiQLoobtwQ75+NoGFoxMcpunKepSVwS5ixSnI02RAphdLJmVJEBcQ0
         IVnGZK0yjGhLw==
Received: by mail-oo1-f43.google.com with SMTP id g46so4170634ooi.9;
        Tue, 23 Feb 2021 12:06:54 -0800 (PST)
X-Gm-Message-State: AOAM532VG+Y2kou+AotlZ3C8/h/sCv7A0X0kXOT4Jf6d207jqeDJirMx
        HrMaWEMGh7V1Atn0PhuesiBnPH4++RgHnGep8Yk=
X-Google-Smtp-Source: ABdhPJwVq3FqhVZjTBFetpO3mOU7GL+78ojBZOQ2pjE3Bh7kqAyWdbPNnj/q23QeJRymW4tpB96Sgwc/UDkiyf761pQ=
X-Received: by 2002:a4a:8ed2:: with SMTP id c18mr19775387ool.66.1614110814282;
 Tue, 23 Feb 2021 12:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-3-elver@google.com>
 <CAMuHMdXVZ+UvNgoaNC-ZZoiuJ=DOsZs4oZzd8DubA7D+4iLCow@mail.gmail.com>
In-Reply-To: <CAMuHMdXVZ+UvNgoaNC-ZZoiuJ=DOsZs4oZzd8DubA7D+4iLCow@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 23 Feb 2021 21:06:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1nCxY=bF_Z_aDDqHFOFgOSJUmaN5X+46oXN7-x1o5z_g@mail.gmail.com>
Message-ID: <CAK8P3a1nCxY=bF_Z_aDDqHFOFgOSJUmaN5X+46oXN7-x1o5z_g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] signal: Introduce TRAP_PERF si_code and si_perf
 to siginfo
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        mascasa@google.com, Peter Collingbourne <pcc@google.com>,
        irogers@google.com, kasan-dev <kasan-dev@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 7:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Feb 23, 2021 at 3:52 PM Marco Elver <elver@google.com> wrote:
> > Introduces the TRAP_PERF si_code, and associated siginfo_t field
> > si_perf. These will be used by the perf event subsystem to send signals
> > (if requested) to the task where an event occurred.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> >  arch/m68k/kernel/signal.c          |  3 +++
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
