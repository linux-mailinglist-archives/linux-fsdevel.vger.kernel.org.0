Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE81156200
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 01:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBHAoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 19:44:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36571 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgBHAoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 19:44:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id j20so1107976otq.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 16:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HIScyM8HTPuRFkGrTkGhKjCkbYZS1XwH37oLGXBpCas=;
        b=avXpkzIbujb+uPKp91557WSYk1wCOMOMq3jAwBf90XEMptoj/zthaPim9WYa6pipC5
         GrjxYNyj/SPOUJFoWmReRB/ZAD09cmN/f+8KN7iCM+7YEIU3rV3Td6NIATO5XKfolCoP
         vbMNtpiu1bP1dqGRs3qJbZD8ygrGf9mqgAEso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HIScyM8HTPuRFkGrTkGhKjCkbYZS1XwH37oLGXBpCas=;
        b=rCOn8+FBYXTATvxf5PMD5zuRy3+Iw7Z4e35abPqGrLnFHuUjTMDysuAIieti/9f7zT
         SL6lvI2YjR7dNmdsGpciE13yWdf0HGKyBZZq+dWrSI8J8KUwdxmUS7fO+HzB8+bRfeXh
         w8Qmm+UL+Qbyp4qdeau8QLZSOJ8nb/a5xEoI2Urf9DHPdzICg2nG1MbGk17ivDHQMLZY
         VwubSygLMV1mgXjV10t10KHFHUpjlASgCVQFzFmm3PARB99cqQM8qlqO0Rodt0UJQh4m
         cSCO4mty0DGZRw8ofkwirMNxMH39iIaz0dJtK/W/y0Popeu6lPGTQR51yj5h1P8WfbRj
         vj1Q==
X-Gm-Message-State: APjAAAU7JD8uJD2ENmn9x2Hsl5Z1krwkfojyfVY4wTWJX6xSZu2+BLFr
        Gr3mJnce7yGL0E3yZRmX3/h5ig==
X-Google-Smtp-Source: APXvYqw8k83YOjDWA0nTWY/jcrmxSrRZZmuXh7Ai1F4W4gp9BStR/jNOCiboW48TPVd+yq9ue2AV3A==
X-Received: by 2002:a05:6830:18ce:: with SMTP id v14mr1593596ote.36.1581122691485;
        Fri, 07 Feb 2020 16:44:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e21sm1596188oib.16.2020.02.07.16.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 16:44:50 -0800 (PST)
Date:   Fri, 7 Feb 2020 16:44:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH v6 08/22] bootconfig: init: Allow admin to use bootconfig
 for init command line
Message-ID: <202002071640.49BFDA2D1A@keescook>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867229521.17873.654222294326542349.stgit@devnote2>
 <202002070954.C18E7F58B@keescook>
 <20200207144603.30688b94@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207144603.30688b94@oasis.local.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 02:46:03PM -0500, Steven Rostedt wrote:
> On Fri, 7 Feb 2020 10:03:16 -0800
> Kees Cook <keescook@chromium.org> wrote:
> > > +		len = strlen(saved_command_line);
> > > +		if (!strstr(boot_command_line, " -- ")) {
> > > +			strcpy(saved_command_line + len, " -- ");
> > > +			len += 4;
> > > +		} else
> > > +			saved_command_line[len++] = ' ';
> > > +
> > > +		strcpy(saved_command_line + len, extra_init_args);
> > > +	}  
> > 
> > This isn't safe because it will destroy any argument with " -- " in
> > quotes and anything after it. For example, booting with:
> > 
> > thing=on acpi_osi="! -- " other=setting
> > 
> > will wreck acpi_osi's value and potentially overwrite "other=settings",
> > etc.
> > 
> > (Yes, this seems very unlikely, but you can't treat " -- " as special,
> > the command line string must be correct parsed for double quotes, as
> > parse_args() does.)
> > 
> 
> This is not the args you are looking for. ;-)
> 
> There is a slight bug, but not as bad as you may think it is.
> bootconfig (when added to the command line) will look for a json like
> file appended to the initrd, and it will parse that. That's what all the
> xbc_*() functions do (extended boot commandline). If one of the options
> in that json like file is "init", then it will create the
> extra_init_args, which will make ilen greater than zero.
> 
> The above if statement looks for that ' -- ', and if it doesn't find it
> (strcmp() returns NULL when not found) it will than append " -- " to
> the boot_command_line. If it is found, then the " -- " is not added. In
> either case, the init args found in the json like file in the initrd is
> appended to the saved_command_line.
> 
> I did say there's a slight bug here. If you have your condition, and
> you add init arguments to that json file, it wont properly add the " --
> ", and the init arguments in that file will be ignored.

Ah, right, it's even more slight, sorry, I had the strstr() in my head
still. So, yes, with an "init" section and a very goofy " -- " present
in a kernel bootparam string value, the appended init args will be
parsed as kernel options.

-- 
Kees Cook
