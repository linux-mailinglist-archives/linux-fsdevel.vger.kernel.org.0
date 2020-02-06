Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64D154149
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 10:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBFJls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 04:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgBFJlr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:41:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B5B21741;
        Thu,  6 Feb 2020 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580982107;
        bh=2c5VkcrMTLDJOXkXov1kg+fymPDCSK58y6deOzcfR1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xts8Bmj9q49MyyMUr60xTYP0b90f3+3jxTYPF0/D3BDh2THTZmY5ONIX2BZwNdt8T
         j96Lb7zac8SU0RpJMrDTbw4OSdAOsiAvJaVrZMbLxYAMJAPdETX3N9UMZXgUOO1nIM
         sl4uPThAVjQrHlXCRtwfciu7N8Jt6MIz3iKR9PfE=
Date:   Thu, 6 Feb 2020 18:41:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 01/22] bootconfig: Add Extra Boot Config support
Message-Id: <20200206184140.ef1a142f48cbca83e5f5acce@kernel.org>
In-Reply-To: <CAMuHMdWx4FmrGaefwkEBMGqCmJUSYxtAfkmFc7HM++fab2U-cw@mail.gmail.com>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
        <157528160980.22451.2034344493364709160.stgit@devnote2>
        <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
        <20191209145009.502ece2e58ffab5e31430a0e@kernel.org>
        <20191209105403.788f492a@gandalf.local.home>
        <CAMuHMdWx4FmrGaefwkEBMGqCmJUSYxtAfkmFc7HM++fab2U-cw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Geert,

On Thu, 6 Feb 2020 10:08:22 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Steven,
> 
> On Mon, Dec 9, 2019 at 4:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Mon, 9 Dec 2019 14:50:09 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > On Sun, 8 Dec 2019 11:34:32 -0800
> > > Randy Dunlap <rdunlap@infradead.org> wrote:
> > > > On 12/2/19 2:13 AM, Masami Hiramatsu wrote:
> > > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > > index 67a602ee17f1..13bb3eac804c 100644
> > > > > --- a/init/Kconfig
> > > > > +++ b/init/Kconfig
> > > > > @@ -1235,6 +1235,17 @@ source "usr/Kconfig"
> > > > >
> > > > >  endif
> > > > >
> > > > > +config BOOT_CONFIG
> > > > > + bool "Boot config support"
> > > > > + select LIBXBC
> > > > > + default y
> > > >
> > > > questionable "default y".
> > > > That needs lots of justification.
> > >
> > > OK, I can make it 'n' by default.
> > >
> > > I thought that was OK because most of the memories for the
> > > bootconfig support were released after initialization.
> > > If user doesn't pass the bootconfig, only the code for
> > > /proc/bootconfig remains on runtime memory.
> >
> > As 'n' is usually the default, I will argue this should be 'y'!
> >
> > This is not some new fancy feature, or device that Linus
> > complains about "my X is important!". I will say this X *is* important!
> > This will (I hope) become standard in all kernel configs. One could even
> > argue that there shouldn't even be a config for this at all (forced
> > 'y'). This would hurt more not to have than to have. I would hate to
> > try to load special options only to find out that the kernel was
> > compiled with default configs and this wasn't enabled.
> 
> Let's bite ;-)
> 
> If one could even argue that there shouldn't even be a config for this
> at all, then why are there two? There's a visible BOOT_CONFIG config,
> and an invisible LIBXBC config.

Oh, I just imitated LIBFDT. 

> Are there other users planned for LIBXBC?

No, no more. I had a plan to use it for ftrace scripting interface,
but I found it should be easy to make a userspace tool using
lib/bootconfig.c directly :)

So it is OK to replace it with BOOT_CONFIG now.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
