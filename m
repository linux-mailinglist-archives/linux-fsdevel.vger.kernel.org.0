Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038DC23A910
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgHCPDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHCPDx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:03:53 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A94420775;
        Mon,  3 Aug 2020 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596467032;
        bh=VgYBpfCh+3wvKx5qa1i7epOht5IPxmnIi4NnDsqf3aU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E41ov8+ZhoApVBXsj5oknZt2xOSS0wtzfMGrn86vnBcUm4QdzZANM9Dp8sVKBMIm+
         7BOvhbCHkmFRN+0PjSDHbE/XcS5IQGcbAVM4Y3lgBfs8zDPOq53KYkr86VlBbQRCL4
         7+YQu7dwGCZYc0uKH9PqbsWoUUwjFAWwVDRxpS+w=
Date:   Tue, 4 Aug 2020 00:03:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
Subject: Re: [PATCH v6 08/22] bootconfig: init: Allow admin to use
 bootconfig for init command line
Message-Id: <20200804000345.f5727ac28647aa8c092cc109@kernel.org>
In-Reply-To: <20200802023318.GA3981683@rani.riverdale.lan>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
        <157867229521.17873.654222294326542349.stgit@devnote2>
        <202002070954.C18E7F58B@keescook>
        <20200207144603.30688b94@oasis.local.home>
        <20200802023318.GA3981683@rani.riverdale.lan>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 1 Aug 2020 22:33:18 -0400
Arvind Sankar <nivedita@alum.mit.edu> wrote:

> On Fri, Feb 07, 2020 at 02:46:03PM -0500, Steven Rostedt wrote:
> > 
> > diff --git a/init/main.c b/init/main.c
> > index 491f1cdb3105..113c8244e5f0 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -142,6 +142,15 @@ static char *extra_command_line;
> >  /* Extra init arguments */
> >  static char *extra_init_args;
> >  
> > +#ifdef CONFIG_BOOT_CONFIG
> > +/* Is bootconfig on command line? */
> > +static bool bootconfig_found;
> > +static bool initargs_found;
> > +#else
> > +# define bootconfig_found false
> > +# define initargs_found false
> > +#endif
> > +
> >  static char *execute_command;
> >  static char *ramdisk_execute_command;
> >  
> > @@ -336,17 +345,32 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
> >  	return ret;
> >  }
> >  
> > +static int __init bootconfig_params(char *param, char *val,
> > +				    const char *unused, void *arg)
> > +{
> > +	if (strcmp(param, "bootconfig") == 0) {
> > +		bootconfig_found = true;
> > +	} else if (strcmp(param, "--") == 0) {
> > +		initargs_found = true;
> > +	}
> > +	return 0;
> > +}
> > +
> 
> I came across this as I was poking around some of the command line
> parsing. AFAICT, initargs_found will never be set to true here, because
> parse_args handles "--" itself by immediately returning: it doesn't
> invoke the callback for it. So you'd instead have to check the return of
> parse_args("bootconfig"...) to detect the initargs_found case.

Oops, good catch!
Does this fixes the problem?

From b078e8b02ad54aea74f8c3645fc11dd3a1cdc1e7 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 3 Aug 2020 23:57:29 +0900
Subject: [PATCH] bootconfig: Fix to find the initargs correctly

Since the parse_args() stops parsing at '--', bootconfig_params()
will never get the '--' as param and initargs_found never be true.
In the result, if we pass some init arguments via the bootconfig,
those are always appended to the kernel command line with '--'
and user will see double '--'.

To fix this correctly, check the return value of parse_args()
and set initargs_found true if the return value is not an error
but a valid address.

Fixes: f61872bb58a1 ("bootconfig: Use parse_args() to find bootconfig and '--'")
Cc: stable@vger.kernel.org
Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 0ead83e86b5a..627f9230dbe8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -387,8 +387,6 @@ static int __init bootconfig_params(char *param, char *val,
 {
 	if (strcmp(param, "bootconfig") == 0) {
 		bootconfig_found = true;
-	} else if (strcmp(param, "--") == 0) {
-		initargs_found = true;
 	}
 	return 0;
 }
@@ -399,19 +397,23 @@ static void __init setup_boot_config(const char *cmdline)
 	const char *msg;
 	int pos;
 	u32 size, csum;
-	char *data, *copy;
+	char *data, *copy, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size, &csum);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
-		   bootconfig_params);
+	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+			 bootconfig_params);
 
-	if (!bootconfig_found)
+	if (IS_ERR(err) || !bootconfig_found)
 		return;
 
+	/* parse_args() stops at '--' and returns an address */
+	if (!IS_ERR(err) && err)
+		initargs_found = true;
+
 	if (!data) {
 		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 		return;
-- 
2.25.1
