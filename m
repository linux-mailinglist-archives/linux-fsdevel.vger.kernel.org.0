Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D967D1DA13B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgESTqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESTqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:46:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBFC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:46:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l73so1508675pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3Ivtwo+9O98WnhcJnwaFt95/Hwxgd+0h4XCSucwWQ0=;
        b=FlcR34MzrEghbl3vy0OL8MTgoR2QS5ql+EgOS6TLT9J/mjNPWyw1q/1x/GPc6spBVR
         zIBXeYd140wKdDH6I1j0BK7rPSzWRoIAU5pL+ymoblh8j7HDhXPXdrRuwb4KU4RHbbCX
         IkV25J7JchNWKWg80zDSG2ZDnZvColidCwd38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3Ivtwo+9O98WnhcJnwaFt95/Hwxgd+0h4XCSucwWQ0=;
        b=Qj1cX1pdPhWL/WDsq7Rs+30kOV/J0/EfCZmGsfyqxsL8fJVMSJLoyFUg9A5Tst4kLP
         Xt/SxyFl65o2r/SNJfemCLKgPzNxWCTobn5mE0iCZypNAKYIrYsXk2l+kWlPVl/OGqtG
         b+s/o0siUXxKp4QBcCdcSrUaQ0kqRXgfm8PzZflSnslSerMUuniyo8NmtNJMVLJFWBf0
         XMSNS1398+3hXxyBy15Qlhr8HoVuleB448QEh21FapdukTB4LRL2yjH6I+r8+Ew9IkmW
         W1dIA2zIhIEiTTTx9w9go0ukRsBgXPiRQw+t8dkOdw8hbiVGYh4m4h24AIzEWxGZ1B/F
         QTwQ==
X-Gm-Message-State: AOAM531ydOz6SePxLdzV5EVzFS7ZPRsK0iwfvsa+V6NBpIm0OVjrb/GX
        8z4VuP3ge1oK0XZ9XsTD2q9oXA==
X-Google-Smtp-Source: ABdhPJzdXNjb2gwJKNeMLT5AEIU9DnLXEYFye7s+DenXWUh8I4fQdMy4wmHogqrZPX7U/5jAByEZOA==
X-Received: by 2002:a17:90a:2ac2:: with SMTP id i2mr1186297pjg.80.1589917579552;
        Tue, 19 May 2020 12:46:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fw4sm288758pjb.31.2020.05.19.12.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:46:18 -0700 (PDT)
Date:   Tue, 19 May 2020 12:46:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
Message-ID: <202005191220.2DB7B7C7@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 07:33:46PM -0500, Eric W. Biederman wrote:
> 
> Most of the support for passing the file descriptor of an executable
> to an interpreter already lives in the generic code and in binfmt_elf.
> Rework the fields in binfmt_elf that deal with executable file
> descriptor passing to make executable file descriptor passing a first
> class concept.
> 
> Move the fd_install from binfmt_misc into begin_new_exec after the new
> creds have been installed.  This means that accessing the file through
> /proc/<pid>/fd/N is able to see the creds for the new executable
> before allowing access to the new executables files.
> 
> Performing the install of the executables file descriptor after
> the point of no return also means that nothing special needs to
> be done on error.  The exiting of the process will close all
> of it's open files.
> 
> Move the would_dump from binfmt_misc into begin_new_exec right
> after would_dump is called on the bprm->file.  This makes it
> obvious this case exists and that no nesting of bprm->file is
> currently supported.
> 
> In binfmt_misc the movement of fd_install into generic code means
> that it's special error exit path is no longer needed.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yes, this is so much nicer. :) My head did spin a little between changing
the management of bprm->executable between this patch and the next,
but I'm okay now. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

nits/thoughts below...

> [...]
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 8c7779d6bf19..653508b25815 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> [...]
> @@ -48,6 +51,7 @@ struct linux_binprm {
>  	unsigned int taso:1;
>  #endif
>  	unsigned int recursion_depth; /* only for search_binary_handler() */
> +	struct file * executable; /* Executable to pass to the interpreter */
>  	struct file * file;
>  	struct cred *cred;	/* new credentials */

nit: can we fix the "* " stuff here? This should be *file and *executable.

> [...]
> @@ -69,10 +73,6 @@ struct linux_binprm {
>  #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
>  #define BINPRM_FLAGS_ENFORCE_NONDUMP (1 << BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
>  
> -/* fd of the binary should be passed to the interpreter */
> -#define BINPRM_FLAGS_EXECFD_BIT 1
> -#define BINPRM_FLAGS_EXECFD (1 << BINPRM_FLAGS_EXECFD_BIT)
> -
>  /* filename of the binary will be inaccessible after exec */
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>  #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCESSIBLE_BIT)

nit: may as well renumber BINPRM_FLAGS_PATH_INACCESSIBLE_BIT to 1,
they're not UAPI. And, actually, nothing uses the *_BIT defines, so
probably the entire chunk of code could just be reduced to:

/* either interpreter or executable was unreadable */
#define BINPRM_FLAGS_ENFORCE_NONDUMP    BIT(0)
/* filename of the binary will be inaccessible after exec */
#define BINPRM_FLAGS_PATH_INACCESSIBLE  BIT(1)

Though frankly, I wonder if interp_flags could just be removed in favor
of two new bit members, especially since interp_data is gone:

+               /* Either interpreter or executable was unreadable. */
+               nondumpable:1;
+               /* Filename of the binary will be inaccessible after exec. */
+               path_inaccessible:1;
...
-       unsigned interp_flags;
...etc

-- 
Kees Cook
