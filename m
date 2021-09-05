Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65168401094
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhIEPdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 11:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIEPdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 11:33:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C6C061575;
        Sun,  5 Sep 2021 08:32:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so5454206otk.9;
        Sun, 05 Sep 2021 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XoAlzqJi3De8B+VzmGNnnTIvew9rejsmVUIc2D4Tpw0=;
        b=LurNh+xXN3Seno1v6vKCeczmHg5jkp75T7+rEOTZc9poUVG66GYg/QUXCpVw/gZFaz
         UrOiFKVGus5FSJFr25SxzrUPwkqmdBOL2RrQ9cqQnQV+zeT6US5zUeogQAglGZ9aQRpu
         g+f4EQwqe1RumBAG3axpcqPQtpkxvocGhMlE2O7dmqkW0U/qx0C36GKaVq1rhDbNs7Aq
         d0kmTanGwQiiXk849oEBv1wsz2C3u5LbNaV8lb9H9tcU+UWwtp/6tZUNqAZ+LW9AQmmY
         /cbJ4ru1mUxJ8CmChZjh79C9VmP5PfoaUWgv6dfo692Lw8w0YblbPX71SpcZgzh3TgZj
         pi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XoAlzqJi3De8B+VzmGNnnTIvew9rejsmVUIc2D4Tpw0=;
        b=RdLpgm2pEKZXzVPjHyLD4MO8Mx20ZFkjn6KH29aovOh5bnpe4vnxOvEhPNFAodRfUj
         dWc8w8IZoHkreTKd/nUD7r3jcA3z8G1C2kq+L7hpLHVklmfROz0qSfI1RXT54MyMXlI5
         DtEqbhWaFTAu9/fAwlGkrW5qkf66NxZd2no3yMf/m7EQcwMQ72/JaIW+kHkNg+eGf2ue
         aAXNj1RH5aYjmSEmHvVHFzXzRh9sY8ogSXS2/J3pMsdlwSe8PfkbxAVfSpMFxU09zpis
         W3zolk0P4G83Zzqvm01Z7/JFrrIih/W8pIKITBBHlXhiArHrXbLxAkRXGqIEULQkaJbT
         2Jjg==
X-Gm-Message-State: AOAM532nR+HRfvqAnD6c0Oed8K7sNP8K5idjzZw92uF0dwklSgiQP2o0
        ds2WVENpqpfaobJvhkpbs43jH7QKL9w=
X-Google-Smtp-Source: ABdhPJzbxr3wcNwbKxd3onpfBStc77h8RDWiIefjN+/Q69lK78BTudJW3loI0eDagfkU7WkIR01wsQ==
X-Received: by 2002:a9d:6359:: with SMTP id y25mr7629665otk.274.1630855952160;
        Sun, 05 Sep 2021 08:32:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x12sm999383oie.56.2021.09.05.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 08:32:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Sep 2021 08:32:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/7] binfmt: don't use MAP_DENYWRITE when loading
 shared libraries via uselib()
Message-ID: <20210905153229.GA3019909@roeck-us.net>
References: <20210816194840.42769-1-david@redhat.com>
 <20210816194840.42769-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816194840.42769-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 09:48:34PM +0200, David Hildenbrand wrote:
> uselib() is the legacy systemcall for loading shared libraries.
> Nowadays, applications use dlopen() to load shared libraries, completely
> implemented in user space via mmap().
> 
> For example, glibc uses MAP_COPY to mmap shared libraries. While this
> maps to MAP_PRIVATE | MAP_DENYWRITE on Linux, Linux ignores any
> MAP_DENYWRITE specification from user space in mmap.
> 
> With this change, all remaining in-tree users of MAP_DENYWRITE use it
> to map an executable. We will be able to open shared libraries loaded
> via uselib() writable, just as we already can via dlopen() from user
> space.
> 
> This is one step into the direction of removing MAP_DENYWRITE from the
> kernel. This can be considered a minor user space visible change.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/x86/ia32/ia32_aout.c | 2 +-
>  fs/binfmt_aout.c          | 2 +-
>  fs/binfmt_elf.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
> index 5e5b9fc2747f..321d7b22ad2d 100644
> --- a/arch/x86/ia32/ia32_aout.c
> +++ b/arch/x86/ia32/ia32_aout.c
> @@ -293,7 +293,7 @@ static int load_aout_library(struct file *file)
>  	/* Now use mmap to map the library into memory. */
>  	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
>  			PROT_READ | PROT_WRITE | PROT_EXEC,
> -			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE | MAP_32BIT,
> +			MAP_FIXED | MAP_PRIVATE | MAP_32BIT,
>  			N_TXTOFF(ex));
>  	retval = error;
>  	if (error != start_addr)
> diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
> index 145917f734fe..d29de971d3f3 100644
> --- a/fs/binfmt_aout.c
> +++ b/fs/binfmt_aout.c
> @@ -309,7 +309,7 @@ static int load_aout_library(struct file *file)
>  	/* Now use mmap to map the library into memory. */
>  	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
>  			PROT_READ | PROT_WRITE | PROT_EXEC,
> -			MAP_FIXED | MAP_PRIVATE | MAP_DENYWRITE,
> +			MAP_FIXED | MAP_PRIVATE;
>  			N_TXTOFF(ex));

Guess someone didn't care compile testing their code. This is now in
mainline.

Guenter
