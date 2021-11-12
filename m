Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D062F44ED28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 20:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbhKLTS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 14:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhKLTS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:18:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84546C06127A;
        Fri, 12 Nov 2021 11:16:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so7563110wmd.1;
        Fri, 12 Nov 2021 11:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R4ezy0Y4KPXp1tXNQDpaUBacCpK19eND/tfIECpPASc=;
        b=YBAsL5+dMv+AtdCI71meU1aglw9me3H8v1QOrePgPB15Qdk6rfgsmCdUa3yRRslChm
         ZvwFGybUYmH0pUsRB4iG1vgM5KuZsjKJedZTGh9aqBW5D7uE8Zhq4sadE0/TJznNFJJv
         vkafBQ6sMgd0Iu2yRmQLoXMAQCuTVFhemjROjYpBjO77jx+BxZ9HyKBbFAhPT9Y91Mqw
         6ZDocCpHjmTV53A+K8h4+cTq7LsnGH7HYUqNUxGkRDidrKfR/dMZFR3ZbllKD7NW/SJ8
         xHA3zhUcjwK7nluuLxnneD0QK9CXYo2T8596s7qhzcqLGGplshe7hfyK18Y+2/guOa18
         wvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R4ezy0Y4KPXp1tXNQDpaUBacCpK19eND/tfIECpPASc=;
        b=v6f//MRtxMtC3U1K0vSeWTOSDAJ75y2i0LOA5FZ6BMcSyZ6kJNs6aI2KbECO0uLj8j
         fmGtmd6ouiyKoTWL1N7a3LC5DGjGf/pchcZJzIHcK8XAtLN0tQVJ2O4VWd8WZm99d7ro
         uG8myOO3c8Q93Rze2Bm8CjrtAJVadUJLHQGNOd1xjfEiRuK+g6QVr8TDlw4sD5pqv4MT
         WoZohFxCCyZAIPY1ua2USt75Ps3zYESU/AUJvp7sx4AWkZai/YmZfEIofzDjrrDPL+85
         FntF4BytoDFD1UYwTfKfbswxITWWTjbhZpSV1I2WobN8kZo8JGCqD/htDtDUiFq8/LIu
         2KeQ==
X-Gm-Message-State: AOAM530NgCOxWQABjTAYCKoWPq/eYCTC2CcyS8J1BKM3RnDDoYiMaaWH
        0iT04/45UXbBdw20i0ixGWs=
X-Google-Smtp-Source: ABdhPJztY+FW6YVXoupcUTvo6LglloVd3KdIeP82Ahk9x8OJslbogmifLiXmtGgsz7nnMioMPxUcgQ==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr19436348wmp.73.1636744565070;
        Fri, 12 Nov 2021 11:16:05 -0800 (PST)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id t127sm12995735wma.9.2021.11.12.11.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 11:16:04 -0800 (PST)
Message-ID: <8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com>
Date:   Fri, 12 Nov 2021 20:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v16 1/3] fs: Add trusted_for(2) syscall implementation and
 related sysctl
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yin Fengwei <fengwei.yin@intel.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20211110190626.257017-1-mic@digikod.net>
 <20211110190626.257017-2-mic@digikod.net>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <20211110190626.257017-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mickaël,

On 11/10/21 20:06, Mickaël Salaün wrote:
> diff --git a/fs/open.c b/fs/open.c
> index f732fb94600c..96a80abec41b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -480,6 +482,114 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
>   	return do_faccessat(AT_FDCWD, filename, mode, 0);
>   }
>   
> +#define TRUST_POLICY_EXEC_MOUNT			BIT(0)
> +#define TRUST_POLICY_EXEC_FILE			BIT(1)
> +
> +int sysctl_trusted_for_policy __read_mostly;
> +
> +/**
...
> + */
> +SYSCALL_DEFINE3(trusted_for, const int, fd, const enum trusted_for_usage, usage,

Please, don't use enums for interfaces.  They are implementation defined 
types, and vary between compilers and within the same compiler also 
depending on optimization flags.

C17::6.7.2.2.4:
[
Each enumerated type shall be compatible with char,
a signed integer type, or an unsigned integer type.
The choice of type is implementation-defined,130)
but shall be capable of representing the values of
all the members of the enumeration.
]

See also:
<https://stackoverflow.com/questions/366017/what-is-the-size-of-an-enum-in-c>

So, please use only standard integer types for interfaces.

And in the case of enums, since the language specifies that enumeration 
constants (the macro-like identifiers) are of type int, it makes sense 
for functions to use int.

C17::6.7.2.2.3:
[
The identifiers in an enumerator list are declared as constants
that have type int and may appear wherever such are permitted.
]

I'd use an int for the API/ABI, even if it's expected to be assigned 
values of 'enum trusted_for_usage' (that should be specified in the 
manual page in DESCRIPTION, but not in SYNOPSIS, which should specify int).



TL;DR:

ISO C specifies that for the following code:

	enum foo {BAR};

	enum foo foobar;

typeof(foo)    shall be int
typeof(foobar) is implementation-defined

Since foobar = BAR; assigns an int, the best thing to do to avoid 
implementation-defined behavior, is to declare foobar as int too.


> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 528a478dbda8..c535e0e43cc8 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -462,6 +463,7 @@ asmlinkage long sys_fallocate(int fd, int mode, loff_t offset, loff_t len);
>   asmlinkage long sys_faccessat(int dfd, const char __user *filename, int mode);
>   asmlinkage long sys_faccessat2(int dfd, const char __user *filename, int mode,
>   			       int flags);
> +asmlinkage long sys_trusted_for(int fd, enum trusted_for_usage usage, u32 flags);

Same here.

>   asmlinkage long sys_chdir(const char __user *filename);
>   asmlinkage long sys_fchdir(unsigned int fd);
>   asmlinkage long sys_chroot(const char __user *filename);

Thanks,
Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
