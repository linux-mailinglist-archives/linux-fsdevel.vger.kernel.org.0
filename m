Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5F6D048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 16:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbfGROsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 10:48:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33814 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390694AbfGROsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:48:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so27655166ljg.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qOzcTnaZtrCxVZ+wrCV9j1v3ZSJaRvDDDE3Ip4m8PX4=;
        b=BvozhdyNjQm5IKs1TT9YoWn3Ui6wySHrveALu6p1t7AtDp7QFxBLfHh88f5ww+lLJn
         uwy3k971xxqR/HSbz4pAOIhSLMVdxGZ//qhiRBmEGbP5iSimOi3DrF8NmakZGMPtS2dX
         7klk9Axk//12MJN1Z1lHBXwZgwDxdfLj6taYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qOzcTnaZtrCxVZ+wrCV9j1v3ZSJaRvDDDE3Ip4m8PX4=;
        b=EeP6uO01VK/0gOi4nEAoU6dm92H0QXgDsY+3tl4T2Eu7fuxnkHV4KGbVIUEixufEzi
         0UV4mdvCsz8RMhrnrFQnPb6MKxRync17AZBIlrrQCkX47N/UxKPB1CneDV4TBeEpq7Ky
         fROcWuezkDQRv/Heif2JKIIjJ2rlm56w3/xRj6zM0W+9cGSVi1A4YyTA7kyGrwj9uZHT
         qsJ94q+Le4dEVuZDJqSslofZLWiuN0qddDnaivW2P1YanR5tFwdCkTTkPgnujJiQQsk1
         EFwUotkMCteiU5nyBbOzDXPpo7pXGT0FLY9ZHlylmCm4HVfWlpzQsh73bK8o/MqtkvMg
         DmJg==
X-Gm-Message-State: APjAAAWlYcKo3pexfwzjnMr7zMLRgReaiZyaka7EbGGIb0rPlGuzOgLH
        Fh6gL+yOG43SmM+uCU/Khbc=
X-Google-Smtp-Source: APXvYqxmTPpUAHG/iv/MbFly8EXHSdBuBHGZ2qYmzwo/cj6avvxhzmR7eZRDDVHxMRGQ2XfudRkVGQ==
X-Received: by 2002:a05:651c:d1:: with SMTP id 17mr24822389ljr.174.1563461295757;
        Thu, 18 Jul 2019 07:48:15 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t4sm5672901ljh.9.2019.07.18.07.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 07:48:15 -0700 (PDT)
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <845e4364-685f-343b-46fb-c418766dce3e@rasmusvillemoes.dk>
Date:   Thu, 18 Jul 2019 16:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190706145737.5299-9-cyphar@cyphar.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/07/2019 16.57, Aleksa Sarai wrote:
> 
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -928,24 +928,32 @@ struct file *open_with_fake_path(const struct path *path, int flags,
>  }
>  EXPORT_SYMBOL(open_with_fake_path);
>  
> -static inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
> +static inline int build_open_flags(struct open_how how, struct open_flags *op)
>  {

How does passing such a huge struct by value affect code generation?
Does gcc actually inline the function (and does it even inline the old
one given that it's already non-trivial and has more than one caller).

>  	int lookup_flags = 0;
> -	int acc_mode = ACC_MODE(flags);
> +	int opath_mask = 0;
> +	int acc_mode = ACC_MODE(how.flags);
> +
> +	if (how.resolve & ~VALID_RESOLVE_FLAGS)
> +		return -EINVAL;
> +	if (!(how.flags & (O_PATH | O_CREAT | __O_TMPFILE)) && how.mode != 0)
> +		return -EINVAL;
> +	if (memchr_inv(how.reserved, 0, sizeof(how.reserved)))
> +		return -EINVAL;

How about passing how by const reference, and copy the few fields you
need to local variables. That would at least simplify this patch by
eliminating a lot of the

> -	flags &= VALID_OPEN_FLAGS;
> +	how.flags &= VALID_OPEN_FLAGS;
>  
> -	if (flags & (O_CREAT | __O_TMPFILE))
> -		op->mode = (mode & S_IALLUGO) | S_IFREG;
> +	if (how.flags & (O_CREAT | __O_TMPFILE))
> +		op->mode = (how.mode & S_IALLUGO) | S_IFREG;

churn.

>  
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 2868ae6c8fc1..e59917292213 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -4,13 +4,26 @@
>  
>  #include <uapi/linux/fcntl.h>
>  
> -/* list of all valid flags for the open/openat flags argument: */
> +/* Should open_how.mode be set for older syscalls wrappers? */
> +#define OPENHOW_MODE(flags, mode) \
> +	(((flags) | (O_CREAT | __O_TMPFILE)) ? (mode) : 0)
> +

Typo: (((flags) & (O_CREAT | __O_TMPFILE)) ? (mode) : 0)

> +/**
> + * Arguments for how openat2(2) should open the target path. If @extra is zero,
> + * then openat2(2) is identical to openat(2).
> + *
> + * @flags: O_* flags (unknown flags ignored).
> + * @mode: O_CREAT file mode (ignored otherwise).

should probably say "O_CREAT/O_TMPFILE file mode".

> + * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored otherwise).
> + * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).
> + * @reserved: reserved for future extensions, must be zeroed.
> + */
> +struct open_how {
> +	__u32 flags;
> +	union {
> +		__u16 mode;
> +		__u16 upgrade_mask;
> +	};
> +	__u16 resolve;

So mode and upgrade_mask are naturally u16 aka mode_t. And yes, they
probably never need to be used together, so the union works. That then
makes the next member 2-byte aligned, so using a u16 for the resolve
flags brings us to an 8-byte boundary, and 11 unused flag bits should be
enough for a while. But it seems a bit artificial to cram all this
together and then add 56 bytes of reserved space.

Rasmus
