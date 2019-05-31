Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05095315B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfEaT44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:56:56 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37023 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfEaT44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:56:56 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so2408226qtk.4;
        Fri, 31 May 2019 12:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/rGGdWu5XycD5C8N2GrP1YfPaYIiEt1+UzdCzQQwTA=;
        b=IRDgGMYuAvaE1GSIOI3o/tLy6QghUC/gn59W8EGZYnnrf9ygntjzbieiQ3dlEsllbU
         ztyyIguVbB2eHpmI9PkEJ2BwAS9VlMhKzI+fhGp2Lgr6qdZSii2rAWmai/dO1jFO5bxB
         cVXi/mZFGbSbMsIAvroXJO/nn9LYuVE7T9DyKs4KHkS08aDguFsrE07Ml8RNFFXZ+X5G
         svudypRSxUBdUObaug++K1UclxUiicg5g+AnqXx5puXnX8UkMleopia6girdXGU8pZcl
         pfT6fHEXuCzscjxIpLM04Vewl7J3jbV0wGGhX+nv5qLlnJHgkDn9NqEepMNlBbte9z++
         nkvw==
X-Gm-Message-State: APjAAAVtQFKrl/qfDJBgj/1KCyOFg3tHCbU4gYtI8oWsyc+lJhSUS3W9
        1U8LurkPcqIvnSneESH1GxXBaWFmkXz/x/3ap9g=
X-Google-Smtp-Source: APXvYqz07GsQb18PQEuYoOrVPB5qWAwO/Z2Je+evEIb3JjUC/80MFu0dsduMvyyuzYa7wz7Pj3pRLV9pSmAglB0lGPc=
X-Received: by 2002:a0c:b78a:: with SMTP id l10mr10482109qve.62.1559332615542;
 Fri, 31 May 2019 12:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190531191204.4044-1-palmer@sifive.com> <20190531191204.4044-4-palmer@sifive.com>
In-Reply-To: <20190531191204.4044-4-palmer@sifive.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 21:56:39 +0200
Message-ID: <CAK8P3a2=xko56LbwV4tyhyyyX+tw+EV-NGavYEYj0q61t=mnwg@mail.gmail.com>
Subject: Re: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

As usual, each patch needs a changelog text. I would prefer having a single
patch here that changes /all/ system call tables at once, rather than doing one
at a time like we used to.

In linux-next, we are at number 434 now, and there are a couple of other
new system calls being proposed right now (more than usual), so you may
have to change the number a few times.

Note: most architectures use .tbl files now, the exceptions are
include/uapi/asm-generic/unistd.h and arch/arm64/include/asm/unistd32.h,
and the latter also requires changing __NR_compat_syscalls in asm/unistd.h.

Numbers should now be the same across architectures, except for alpha,
which has a +110 offset. We have discussed ways to have a single
file to modify for a new call on all architectures, but no patches yet.

     Arnd
