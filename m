Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69E51831
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfFXQOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:14:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46376 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfFXQOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:14:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id x18so10135178qkn.13;
        Mon, 24 Jun 2019 09:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTF/nS1+qdBT86jDRSsd6Qn5jIsT6F1veuGsXftHOjc=;
        b=rRlkfi9Bf+ds070dsCIXgWVZaMDuDV2wmQdcfYy7uD13+zOkxauLv0fEC85tUhfe9r
         RRbF98+lp3sC4rJAhHYHxz8djuyEqIhbIzpTlsBbBbUy1zZCeC847i5o372T9ONj0Bu9
         jZS/zk+VdeKk/MgFgXjnGl7M+eLUAZks5I/zjcvHIOExCgCPA6rQXn6nGLwYP3WX0hyF
         6xTuCLZ3yleylPF3X7icnnl/PwhQfosotcKUFWLdmFukHkXOoIm9gSJlNB6N7uk7Fix6
         AYeX9+m4QYR3n8kh60DRMRc80zks0CIUAZnYLXRDszNM/lkVmWudxLQWQxoSqQtyKxGQ
         LjKQ==
X-Gm-Message-State: APjAAAXJy0KJ2zQ46oLFnVCpPudej7BxYLCiMXiM01kSTa9ASsrx5dnm
        tkmFkzvUcle6GQWPo1Vd1vJU8XsaJLQ4NG3XrzU=
X-Google-Smtp-Source: APXvYqyfH93Six0OcO4zr/WcQbQNutoi7R+T6yeai3iSMLU6xDTPFUfvRcImY2k2OlF7h86FZYep6Q4xr3oJIgOgFSM=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr17681349qkc.394.1561392882315;
 Mon, 24 Jun 2019 09:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190624144151.22688-1-rpenyaev@suse.de> <20190624144151.22688-14-rpenyaev@suse.de>
In-Reply-To: <20190624144151.22688-14-rpenyaev@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Jun 2019 18:14:25 +0200
Message-ID: <CAK8P3a3YgKZbF=nx4nsbj5mvgcSk8OfjU1HNvSjC19RPsyVMsQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] epoll: implement epoll_create2() syscall
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 4:42 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> epoll_create2() is needed to accept EPOLL_USERPOLL flags
> and size, i.e. this patch wires up polling from userspace.

Can you explain in the patch description more what it's needed for?

The man page only states that "Since Linux 2.6.8, the size argument
is ignored", so your description above does not explain why you need
to add the size argument back.

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 1db9bbcfb84e..a1d7b695063d 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -474,3 +474,5 @@
>  542    common  fsmount                         sys_fsmount
>  543    common  fspick                          sys_fspick
>  544    common  pidfd_open                      sys_pidfd_open
> +# 546  common  clone3                  sys_clone3
> +547    common  epoll_create2                   sys_epoll_create2
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index ff45d8807cb8..1497f3c87d54 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -449,3 +449,4 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  436    common  clone3                          sys_clone3
> +437    common  epoll_create2                   sys_epoll_create2

The table changes all look correct and complete, provided we
don't get another patch picking the same number.

          Arnd
