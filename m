Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF313191BE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgCXVWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 17:22:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46344 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCXVWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:22:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so213245ljk.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0AQOrscsNAyPOgnjIz1wdZ8BwbWscK7BvSW7dZFNMU=;
        b=TU+v6vgTqqL8DSRyHNIS3zPA2Au3s8bOdz4RjYVrI59y/xJG37DuCzUkFedo8prEM1
         kEhbDC8RUbuZ44J4woqibSX2DnsCF77IrNvFFBgUdsgFnP87BEfOj65kKyLU5UPa/XiH
         yLDUovevdVM9pFj6antE7mF1/9gnUPays5DSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0AQOrscsNAyPOgnjIz1wdZ8BwbWscK7BvSW7dZFNMU=;
        b=W/ItHOoNYnen73W4VDmwnigh4JDIbv4YoEB7/ICm+gq+BTy8nk9L+tAuG92tiQkftb
         B4tTLp08rJtfp4Ru/CyqotmQ2T/7w45FkGw8HggKPd+ZNnLBgBv627tnGI/EMX0uZLv7
         bl3kYAUBvhaJTUdq0j8HRoJo9gxVPDHjL3CG5iqNtF0qxywDTV8+nuhfUUM7FDKfwzRR
         OfuGBzyA+F5+Wm7XSiiRkkOhT+JhCGhwBvFiRxzgZei22ML0qSr0O3JSLyUmh/lrAQ9G
         pwBdp7aI1j7oSZdkvu6n5ELZGOVIAnFao68l47p8PWBX0Plj6ObxeDpKRUP6kxheGOJ8
         h4kg==
X-Gm-Message-State: ANhLgQ1oDdvKaHRpEDYxYN2QMvo4xgynRL/LuW7VQfHIKpx2KOBF1z7r
        78xslclgMV5KQ/KGrb6rlRJaukq6Bko=
X-Google-Smtp-Source: ADFU+vv3CZ806Ccmm+5xlweKDXFW/yghqgQ5+YsxEwW0hNnGS+9iC8/+gUkPBRuMQVLmITXvhln/1Q==
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr18564110ljh.18.1585084936720;
        Tue, 24 Mar 2020 14:22:16 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t13sm10400413lfc.68.2020.03.24.14.22.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:22:15 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id m15so55156lfp.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2020 14:22:15 -0700 (PDT)
X-Received: by 2002:a19:f015:: with SMTP id p21mr60990lfc.10.1585084934903;
 Tue, 24 Mar 2020 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200324204449.7263-1-gladkov.alexey@gmail.com> <20200324204449.7263-4-gladkov.alexey@gmail.com>
In-Reply-To: <20200324204449.7263-4-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 14:21:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
Message-ID: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 3/8] proc: move hide_pid, pid_gid from
 pid_namespace to proc_fs_info
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:46 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> +/* definitions for hide_pid field */
> +enum {
> +       HIDEPID_OFF       = 0,
> +       HIDEPID_NO_ACCESS = 1,
> +       HIDEPID_INVISIBLE = 2,
> +};

Should this enum be named...

>  struct proc_fs_info {
>         struct pid_namespace *pid_ns;
>         struct dentry *proc_self;        /* For /proc/self */
>         struct dentry *proc_thread_self; /* For /proc/thread-self */
> +       kgid_t pid_gid;
> +       int hide_pid;
>  };

.. and then used here instead of "int"?

Same goes for 'struct proc_fs_context' too, for that matter?

And maybe in the function declarations and definitions too? In things
like 'has_pid_permissions()' (the series adds some other cases later,
like hidepid2str() etc)

Yeah, enums and ints are kind of interchangeable in C, but even if it
wouldn't give us any more typechecking (except perhaps with sparse if
you mark it so), it would be documenting the use.

Or am I missing something?

Anyway, I continue to think the series looks fine, bnut would love to
see it in -next and perhaps comments from Al and Alexey Dobriyan..

            Linus
