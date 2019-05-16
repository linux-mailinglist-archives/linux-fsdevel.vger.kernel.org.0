Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7D204C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEPLcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:32:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38403 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPLca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:32:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so3405210qth.5;
        Thu, 16 May 2019 04:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydL0AVpxpBQr3oXgUFpxFdenM7xgTXs5eRpgBYQlCOw=;
        b=XROCaWkUbv9U50wxZKrt0PyUlYy2Fpdj1U+dvgARwHLVuxJazPG56V7hdXizr65om9
         tPRVGq32DYAEEVw5mQ4A0warM5PBGPP9CfKkjAmL4vAq0dnn5smaqhse9lbMRGGQICAL
         BGX0MJb0YeVDF85sL38M7b34/NzF8P03ZsXxIEpRjrt2rWWhXOPSO5MlvMtlVRypUsHC
         zhmfb5tdD7yIhH+bP5PLVRddx1eOUBFkus7cMn+HuZsKJnchc85MmyMUuxGLYs71vlgz
         MdM3U+YRhhKbMX2JVb+YROFCM9+R5qpX1QjxysLkg6iR73dya7FgWu1UFGuWIbl7bPTk
         gxMQ==
X-Gm-Message-State: APjAAAXDvYqsGCVLB+D0IB8M3nFMcZe/bkmq8TWp9uTld/wSCUPeCFOs
        6R17/+O7m0pllwzrOZC9D+wCUWx1PdDS71ZqNcA=
X-Google-Smtp-Source: APXvYqx2s83mejatIA/qQaDzZ/nly61kJ1tjGG0PdDvRx4+UG1Kcp2UUDUlEKUQRMBaq5O4ubLJCUR/xxtr742m9qUA=
X-Received: by 2002:ac8:390e:: with SMTP id s14mr18347744qtb.343.1558006349693;
 Thu, 16 May 2019 04:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <155800581545.26930.2167325198332902897.stgit@warthog.procyon.org.uk>
 <155800584626.26930.8723624357941420192.stgit@warthog.procyon.org.uk>
In-Reply-To: <155800584626.26930.8723624357941420192.stgit@warthog.procyon.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 13:32:13 +0200
Message-ID: <CAK8P3a1mUoph0xwmxPfYAcRU=uhQj83VmgTfthVnQ0H1cQpHQQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] uapi: Wire up the mount API syscalls on non-x86 arches
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 1:24 PM David Howells <dhowells@redhat.com> wrote:
>
> Wire up the mount API syscalls on non-x86 arches.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

but found a small mistake that breaks compilation on the
asm-generic architectures:

> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 23f1a44acada..3734789e9f25 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -874,6 +874,18 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
>  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
>  #define __NR_io_uring_register 427
>  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> +#define __NR_open_tree 428
> +__SYSCALL(__NR_open_tree, open_tree)
> +#define __NR_move_mount 429
> +__SYSCALL(__NR_move_mount, move_mount)
> +#define __NR_fsopen 430
> +__SYSCALL(__NR_fsopen, fsopen)
> +#define __NR_fsconfig 431
> +__SYSCALL(__NR_fsconfig, fsconfig)
> +#define __NR_fsmount 432
> +__SYSCALL(__NR_fsmount, fsmount)
> +#define __NR_fspick 433
> +__SYSCALL(__NR_fspick, fspick)

This needs a sys_ prefix for each of the entry point names

> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index dee7292e1df6..29bf3bbcce78 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -832,9 +832,21 @@ __SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
>  __SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
>  #define __NR_io_uring_register 427
>  __SYSCALL(__NR_io_uring_register, sys_io_uring_register)
> +#define __NR_open_tree 428
> +__SYSCALL(__NR_open_tree, open_tree)
> +#define __NR_move_mount 429
> +__SYSCALL(__NR_move_mount, move_mount)
> +#define __NR_fsopen 430
> +__SYSCALL(__NR_fsopen, fsopen)
> +#define __NR_fsconfig 431
> +__SYSCALL(__NR_fsconfig, fsconfig)
> +#define __NR_fsmount 432
> +__SYSCALL(__NR_fsmount, fsmount)
> +#define __NR_fspick 433
> +__SYSCALL(__NR_fspick, fspick)
>
>  #undef __NR_syscalls
> -#define __NR_syscalls 428
> +#define __NR_syscalls 434

Same here.

      Arnd
