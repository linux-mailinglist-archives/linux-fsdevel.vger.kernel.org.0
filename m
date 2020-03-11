Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E05181F72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgCKR2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:28:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43596 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgCKR2M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:28:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8so1400981plt.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+ZOcxNYeRd6TpeszjdotrOPkWTvdHdHQO1oDtgNPX8=;
        b=Ai6U69fgOeQagm7m54tZ/kv2BRIdWqCUY4mtzu3ozDt2KJcDMHB2H/nIy30zy4LVZ7
         P+KMtjsdHT2szUTCl4kgjifZ5d8NLMBzdMjmEclU9Qcuc6KfTv+H4Ud6y5gmcETF+2qf
         IuOwpOmDCaAuvZ08Q2lt1xXcScGHRVxvFQamo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+ZOcxNYeRd6TpeszjdotrOPkWTvdHdHQO1oDtgNPX8=;
        b=oUTY/IMmGiEWx6+/ja+V7kih9+VwMEeTQE2LVIWD6VJUtJmt2gfIyHpwRNKqMUoTWm
         Fx9Xnj1MCMCPvq0fxn9UGeAIbMqedZYIQ+SZi4k+1LBmTH4gT0+GR0JGIe+alMnGPtXr
         PTy9DZ3XoW+NZTfPdHZpgO+4Dplnq5vRR3QmY/307KYBnA6jlFtqrBDWyunjmCns59ez
         SUdHMbMt+YYHsVpzLoqQL474J+RA1+owEu9F8VFiWWFLlxGGAvUMWUOB28YqUjWd4MnG
         ftFKKMLSLzlAdrXNkYZzTwELIlrmnIJiCmDZ2izrBugf86Aoail8/cfcfgqe19Rvd7mi
         9ttA==
X-Gm-Message-State: ANhLgQ0rB8dzVwIL+UkhjxDjF8dxB4woFYdILPxAhyvRh54JqXnqVexL
        /BtAwHHr3w1YltwzReoloV34lA==
X-Google-Smtp-Source: ADFU+vutXRm+fkHXS0TmrOT9NyfU1c9AMzjC3IJilTwNdJ5JnjDYHz81GbmhbJDRJBAe6/k9MyWz2g==
X-Received: by 2002:a17:902:bd43:: with SMTP id b3mr3781526plx.230.1583947689481;
        Wed, 11 Mar 2020 10:28:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q43sm5166855pjc.40.2020.03.11.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:28:08 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:28:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] kmod: make request_module() return an error when
 autoloading is disabled
Message-ID: <202003111026.2BBE41C@keescook>
References: <20200310223731.126894-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310223731.126894-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:37:31PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> It's long been possible to disable kernel module autoloading completely
> by setting /proc/sys/kernel/modprobe to the empty string.  This can be

Hunh. I've never seen that before. :) I've always used;

echo 1 > /proc/sys/kernel/modules_disabled

Regardless,

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> preferable to setting it to a nonexistent file since it avoids the
> overhead of an attempted execve(), avoids potential deadlocks, and
> avoids the call to security_kernel_module_request() and thus on
> SELinux-based systems eliminates the need to write SELinux rules to
> dontaudit module_request.
> 
> However, when module autoloading is disabled in this way,
> request_module() returns 0.  This is broken because callers expect 0 to
> mean that the module was successfully loaded.
> 
> Apparently this was never noticed because this method of disabling
> module autoloading isn't used much, and also most callers don't use the
> return value of request_module() since it's always necessary to check
> whether the module registered its functionality or not anyway.  But
> improperly returning 0 can indeed confuse a few callers, for example
> get_fs_type() in fs/filesystems.c where it causes a WARNING to be hit:
> 
> 	if (!fs && (request_module("fs-%.*s", len, name) == 0)) {
> 		fs = __get_fs_type(name, len);
> 		WARN_ONCE(!fs, "request_module fs-%.*s succeeded, but still no fs?\n", len, name);
> 	}
> 
> This is easily reproduced with:
> 
> 	echo > /proc/sys/kernel/modprobe
> 	mount -t NONEXISTENT none /
> 
> It causes:
> 
> 	request_module fs-NONEXISTENT succeeded, but still no fs?
> 	WARNING: CPU: 1 PID: 1106 at fs/filesystems.c:275 get_fs_type+0xd6/0xf0
> 	[...]
> 
> Arguably this warning is broken and should be removed, since the module
> could have been unloaded already.  However, request_module() should also
> correctly return an error when it fails.  So let's make it return
> -ENOENT, which matches the error when the modprobe binary doesn't exist.
> 
> Cc: stable@vger.kernel.org
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jeff Vander Stoep <jeffv@google.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  kernel/kmod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index bc6addd9152b..a2de58de6ab6 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -120,7 +120,7 @@ static int call_modprobe(char *module_name, int wait)
>   * invoke it.
>   *
>   * If module auto-loading support is disabled then this function
> - * becomes a no-operation.
> + * simply returns -ENOENT.
>   */
>  int __request_module(bool wait, const char *fmt, ...)
>  {
> @@ -137,7 +137,7 @@ int __request_module(bool wait, const char *fmt, ...)
>  	WARN_ON_ONCE(wait && current_is_async());
>  
>  	if (!modprobe_path[0])
> -		return 0;
> +		return -ENOENT;
>  
>  	va_start(args, fmt);
>  	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 
Kees Cook
