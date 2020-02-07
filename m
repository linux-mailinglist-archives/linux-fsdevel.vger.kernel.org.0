Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B97155EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBGTqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 14:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBGTqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:46:08 -0500
Received: from oasis.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B39220726;
        Fri,  7 Feb 2020 19:46:05 +0000 (UTC)
Date:   Fri, 7 Feb 2020 14:46:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <20200207144603.30688b94@oasis.local.home>
In-Reply-To: <202002070954.C18E7F58B@keescook>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
        <157867229521.17873.654222294326542349.stgit@devnote2>
        <202002070954.C18E7F58B@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Feb 2020 10:03:16 -0800
Kees Cook <keescook@chromium.org> wrote:

> >  static void __init setup_command_line(char *command_line)
> >  {
> > -	size_t len, xlen = 0;
> > +	size_t len, xlen = 0, ilen = 0;
> >  
> >  	if (extra_command_line)
> >  		xlen = strlen(extra_command_line);
> > +	if (extra_init_args)
> > +		ilen = strlen(extra_init_args) + 4; /* for " -- " */
> >  
> >  	len = xlen + strlen(boot_command_line) + 1;
> >  
> > -	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> > +	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
> >  	if (!saved_command_line)
> > -		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > +		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
> >  
> >  	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
> >  	if (!static_command_line)
> > @@ -533,6 +539,22 @@ static void __init setup_command_line(char *command_line)
> >  	}
> >  	strcpy(saved_command_line + xlen, boot_command_line);
> >  	strcpy(static_command_line + xlen, command_line);
> > +
> > +	if (ilen) {
> > +		/*
> > +		 * Append supplemental init boot args to saved_command_line
> > +		 * so that user can check what command line options passed
> > +		 * to init.
> > +		 */
> > +		len = strlen(saved_command_line);
> > +		if (!strstr(boot_command_line, " -- ")) {
> > +			strcpy(saved_command_line + len, " -- ");
> > +			len += 4;
> > +		} else
> > +			saved_command_line[len++] = ' ';
> > +
> > +		strcpy(saved_command_line + len, extra_init_args);
> > +	}  
> 
> This isn't safe because it will destroy any argument with " -- " in
> quotes and anything after it. For example, booting with:
> 
> thing=on acpi_osi="! -- " other=setting
> 
> will wreck acpi_osi's value and potentially overwrite "other=settings",
> etc.
> 
> (Yes, this seems very unlikely, but you can't treat " -- " as special,
> the command line string must be correct parsed for double quotes, as
> parse_args() does.)
> 

This is not the args you are looking for. ;-)

There is a slight bug, but not as bad as you may think it is.
bootconfig (when added to the command line) will look for a json like
file appended to the initrd, and it will parse that. That's what all the
xbc_*() functions do (extended boot commandline). If one of the options
in that json like file is "init", then it will create the
extra_init_args, which will make ilen greater than zero.

The above if statement looks for that ' -- ', and if it doesn't find it
(strcmp() returns NULL when not found) it will than append " -- " to
the boot_command_line. If it is found, then the " -- " is not added. In
either case, the init args found in the json like file in the initrd is
appended to the saved_command_line.

I did say there's a slight bug here. If you have your condition, and
you add init arguments to that json file, it wont properly add the " --
", and the init arguments in that file will be ignored.

That should be fixed, and I think I was able to do that below. I also
noticed that we don't properly look for "bootconfig" either.

-- Steve




> >  }
> >  
> >  /*
> > @@ -759,6 +781,9 @@ asmlinkage __visible void __init start_kernel(void)
> >  	if (!IS_ERR_OR_NULL(after_dashes))
> >  		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
> >  			   NULL, set_init_arg);
> > +	if (extra_init_args)
> > +		parse_args("Setting extra init args", extra_init_args,
> > +			   NULL, 0, -1, -1, NULL, set_init_arg);  

diff --git a/init/main.c b/init/main.c
index 491f1cdb3105..113c8244e5f0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -142,6 +142,15 @@ static char *extra_command_line;
 /* Extra init arguments */
 static char *extra_init_args;
 
+#ifdef CONFIG_BOOT_CONFIG
+/* Is bootconfig on command line? */
+static bool bootconfig_found;
+static bool initargs_found;
+#else
+# define bootconfig_found false
+# define initargs_found false
+#endif
+
 static char *execute_command;
 static char *ramdisk_execute_command;
 
@@ -336,17 +345,32 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
 	return ret;
 }
 
+static int __init bootconfig_params(char *param, char *val,
+				    const char *unused, void *arg)
+{
+	if (strcmp(param, "bootconfig") == 0) {
+		bootconfig_found = true;
+	} else if (strcmp(param, "--") == 0) {
+		initargs_found = true;
+	}
+	return 0;
+}
+
 static void __init setup_boot_config(const char *cmdline)
 {
+	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	u32 size, csum;
 	char *data, *copy;
 	const char *p;
 	u32 *hdr;
 	int ret;
 
-	p = strstr(cmdline, "bootconfig");
-	if (!p || (p != cmdline && !isspace(*(p-1))) ||
-	    (p[10] && !isspace(p[10])))
+	/* All fall through to do_early_param. */
+	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+		   bootconfig_params);
+
+	if (!bootconfig_found)
 		return;
 
 	if (!initrd_end)
@@ -563,11 +587,12 @@ static void __init setup_command_line(char *command_line)
 		 * to init.
 		 */
 		len = strlen(saved_command_line);
-		if (!strstr(boot_command_line, " -- ")) {
+		if (initargs_found) {
+			saved_command_line[len++] = ' ';
+		} else {
 			strcpy(saved_command_line + len, " -- ");
 			len += 4;
-		} else
-			saved_command_line[len++] = ' ';
+		}
 
 		strcpy(saved_command_line + len, extra_init_args);
 	}
