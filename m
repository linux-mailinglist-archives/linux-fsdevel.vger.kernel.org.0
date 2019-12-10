Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9A118A95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLJOPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 09:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbfLJOPi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:15:38 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12884207FF;
        Tue, 10 Dec 2019 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575987337;
        bh=zoKHBYFK7ibeRR/odpe1m4xweRuBfc5NFuh1Z7lmORU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zh7mvxVg1ozMiDGwvPAJorU8QV2ffv9xlj8iZaEZsiLracEhwJt5OGyGIIEhIk2c3
         d61ELYXUXkQOU0hWo9Z1JG4/cenfPNhG5hKsS0sWso0CXPWbYe8wNGgQJ8CiXezD9w
         hzaWrcudL13UcQwWEdgEj9m2xo7rhVLPJfbX6/Zs=
Date:   Tue, 10 Dec 2019 23:15:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
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
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 01/22] bootconfig: Add Extra Boot Config support
Message-Id: <20191210231528.853ac9e7f84f2166fd4c4047@kernel.org>
In-Reply-To: <20191209105403.788f492a@gandalf.local.home>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
        <157528160980.22451.2034344493364709160.stgit@devnote2>
        <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
        <20191209145009.502ece2e58ffab5e31430a0e@kernel.org>
        <20191209105403.788f492a@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Dec 2019 10:54:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > > +config BOOT_CONFIG
> > > > +	bool "Boot config support"
> > > > +	select LIBXBC
> > > > +	default y  
> > > 
> > > questionable "default y".
> > > That needs lots of justification.  
> > 
> > OK, I can make it 'n' by default.
> > 
> > I thought that was OK because most of the memories for the
> > bootconfig support were released after initialization.
> > If user doesn't pass the bootconfig, only the code for
> > /proc/bootconfig remains on runtime memory.
> 
> As 'n' is usually the default, I will argue this should be 'y'!
> 
> This is not some new fancy feature, or device that Linus
> complains about "my X is important!". I will say this X *is* important!
> This will (I hope) become standard in all kernel configs. One could even
> argue that there shouldn't even be a config for this at all (forced
> 'y'). This would hurt more not to have than to have. I would hate to
> try to load special options only to find out that the kernel was
> compiled with default configs and this wasn't enabled.
> 
> This is extended boot config support that can be useful for most
> developers. The only ones that should say 'n' are those that are
> working to get a "tiny" kernel at boot up. As Masami said, the memory
> is freed after init, thus this should not be an issue for 99.9% of
> kernel users.

Thanks Steve!

Yes, for the users point of view, it is hard to notice that their kernel
can accept the boot config or not before boot.
To provide consistent system usability, I think it is better to be enabled
by default. Anyway, if there is no boot config, almost all buffers and
code are released after init (except for /proc/bootconfig entry point,
which will return an empty buffer).

It will increase the binary image size, but it must be small.
FYI, here is an example of vmlinux (non compressed image)

   text	   data	    bss	    dec	    hex	filename
16178353	5843418	13324364	35346135	21b56d7	vmlinux
16183993	5855858	13316172	35356023	21b7d77	vmlinux.xbc
16187248	5855870	13307980	35351098	21b6a3a	vmlinux.xbc.btt

So, for the extra boot config support, it will increase ~6KB code and
12KB data, the boot time tracing increase ~3KB code and 12bytes data
in binary file. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
