Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B1133960
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 04:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgAHDDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 22:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHDDx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:03:53 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67FDC2075A;
        Wed,  8 Jan 2020 03:03:51 +0000 (UTC)
Date:   Tue, 7 Jan 2020 22:03:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH v5 01/22] bootconfig: Add Extra Boot Config support
Message-ID: <20200107220349.1e7424f9@rorschach.local.home>
In-Reply-To: <20200107205945.63e5d35a@rorschach.local.home>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
        <157736904075.11126.16068256892686522924.stgit@devnote2>
        <20200107205945.63e5d35a@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Jan 2020 20:59:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> > +
> > +/*
> > + * Return delimiter or error, no node added. As same as lib/cmdline.c,
> > + * you can use " around spaces, but can't escape " for value.
> > + */
> > +static int __init __xbc_parse_value(char **__v, char **__n)
> > +{
> > +	char *p, *v = *__v;
> > +	int c, quotes = 0;
> > +
> > +	v = skip_spaces(v);
> > +	while (*v == '#') {
> > +		v = skip_comment(v);
> > +		v = skip_spaces(v);
> > +	}
> > +	if (*v == '"' || *v == '\'') {
> > +		quotes = *v;
> > +		v++;
> > +	}
> > +	p = v - 1;
> > +	while ((c = *++p)) {
> > +		if (!isprint(c) && !isspace(c))
> > +			return xbc_parse_error("Non printable value", p);
> > +		if (quotes) {
> > +			if (c != quotes)
> > +				continue;
> > +			quotes = 0;
> > +			*p++ = '\0';
> > +			p = skip_spaces(p);  
> 
> Hmm, if p here == "    \0" then skip_spaces() will make p == "\0"
> 
> > +			c = *p;
> > +			if (c && !strchr(",;\n#}", c))
> > +				return xbc_parse_error("No value delimiter", p);
> > +			p++;  
> 
> Now p == one passed "\0" which is in unknown territory.

I like how you have patch 3 use this code. It makes it easy to test,
and valgrind pointed out that this is a bug. With a file that just
contained:

   foo = "1"

I ran this:

  $ valgrind -v --leak-check=full ./tools/bootconfig/bootconfig -a /tmp/boot-bad /tmp/initrd  2>/tmp/out

Which gave me this:

==18929== Invalid read of size 1
==18929==    at 0x483FC02: strpbrk (vg_replace_strmem.c:1690)
==18929==    by 0x40263C: xbc_init (bootconfig.c:724)
==18929==    by 0x403162: apply_xbc (main.c:255)
==18929==    by 0x403346: main (main.c:331)
==18929==  Address 0x4a4e09f is 0 bytes after a block of size 15 alloc'd
==18929==    at 0x483780B: malloc (vg_replace_malloc.c:309)
==18929==    by 0x402B9D: load_xbc_fd (main.c:95)
==18929==    by 0x402C87: load_xbc_file (main.c:120)
==18929==    by 0x4030AC: apply_xbc (main.c:238)
==18929==    by 0x403346: main (main.c:331)

Which proves this the issue as when I apply the patch below, this goes
away:

-- Steve

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 7a7cdc45bf62..0793ef9f48b8 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -468,7 +468,8 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 			c = *p;
 			if (c && !strchr(",;\n#}", c))
 				return xbc_parse_error("No value delimiter", p);
-			p++;
+			if (*p)
+				p++;
 			break;
 		}
 		if (strchr(",;\n#}", c)) {
