Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE371170E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 16:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLIPyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 10:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfLIPyH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:54:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900B82073D;
        Mon,  9 Dec 2019 15:54:04 +0000 (UTC)
Date:   Mon, 9 Dec 2019 10:54:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20191209105403.788f492a@gandalf.local.home>
In-Reply-To: <20191209145009.502ece2e58ffab5e31430a0e@kernel.org>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
        <157528160980.22451.2034344493364709160.stgit@devnote2>
        <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
        <20191209145009.502ece2e58ffab5e31430a0e@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Dec 2019 14:50:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Randy,
> 
> Thank you for your review!
> 
> On Sun, 8 Dec 2019 11:34:32 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > Hi,
> > 
> > On 12/2/19 2:13 AM, Masami Hiramatsu wrote:  
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 67a602ee17f1..13bb3eac804c 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1235,6 +1235,17 @@ source "usr/Kconfig"
> > >  
> > >  endif
> > >  
> > > +config BOOT_CONFIG
> > > +	bool "Boot config support"
> > > +	select LIBXBC
> > > +	default y  
> > 
> > questionable "default y".
> > That needs lots of justification.  
> 
> OK, I can make it 'n' by default.
> 
> I thought that was OK because most of the memories for the
> bootconfig support were released after initialization.
> If user doesn't pass the bootconfig, only the code for
> /proc/bootconfig remains on runtime memory.

As 'n' is usually the default, I will argue this should be 'y'!

This is not some new fancy feature, or device that Linus
complains about "my X is important!". I will say this X *is* important!
This will (I hope) become standard in all kernel configs. One could even
argue that there shouldn't even be a config for this at all (forced
'y'). This would hurt more not to have than to have. I would hate to
try to load special options only to find out that the kernel was
compiled with default configs and this wasn't enabled.

This is extended boot config support that can be useful for most
developers. The only ones that should say 'n' are those that are
working to get a "tiny" kernel at boot up. As Masami said, the memory
is freed after init, thus this should not be an issue for 99.9% of
kernel users.

-- Steve


> 
> > > +	help
> > > +	 Extra boot config allows system admin to pass a config file as
> > > +	 complemental extension of kernel cmdline when boot.  
> > 
> > 	                                          when booting.  
>
