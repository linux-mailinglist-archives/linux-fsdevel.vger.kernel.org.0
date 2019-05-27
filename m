Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F1D2B689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE0Niy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 09:38:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45603 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE0Niy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 09:38:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id t24so14801110otl.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2019 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMFxRGlKUpvBvlbQG58xrVAgA23tAIXMetii0uOnwLo=;
        b=bKSDOlnNh1cedFkO7cgRQsvU+SSGTdbdaXYpVewl+/Qr5s/W5HZ2p5wW6xe3KU6Dzp
         za2OilPy0X4hy44OStoNDLirumw6BRgEWfvN7eTX6EcFekxvNjeyHo3toAls/KbqezUG
         fqX/moYkcTQhCJ3LZ3TgpxBoJY/MqcGKfOD9LpcvMbJZQ2pKcNbw8qSgEgBRVJ2l8RpI
         dPp+7S9+RrItjw3Ncld7Bru6Z5gs6prjOlX4rudOG3cEZx8XIfFfgzvPgpryIf77yuks
         PYg/QVt/TmD5+sTivN1hcl+ik2t7vropjLpWNF4qUwlRkSo+C4EhMqSxgGOm07en+dpQ
         qCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMFxRGlKUpvBvlbQG58xrVAgA23tAIXMetii0uOnwLo=;
        b=aUj/jm5YdlN6aOy+2f5svx3z5EskroJstWmNFbEpE8ol4Q/7PZ6vUI47L5TrKHCZNY
         po/hd2TqbvAFzlqLUmrMs95q73mnCLI+FN6ZGq59/YKN6TG7rOW7pMKeXeGjUOizZ+mq
         57auiZeFj+rc37LE8BmvnT8O8ZzTLATHyhiUISddbeYiwkZG4S26iIEeBzbGdkdEcT9l
         Cw3+ETzIe6tzdovPG5EbxWZhY7+FHI2V+eLiXgHDDJdtuWvFrYspD1Wtii7Z4r0J2lBG
         xrcIkhqY9IB4fmMViIw1+CiB52Nw8myBjun4XV5hkIv5y5LXL7NO7CUqOVM2T6ApIR/e
         ZXMg==
X-Gm-Message-State: APjAAAVfa3oEXRrEobZJWIp/x4TyGpmz3+sjVkQ8KRLZ+QS4oYbXsX0v
        +LBCJLgFFECbAUmqQAeBvK8HIFRjfQS5ubMUHabKaw==
X-Google-Smtp-Source: APXvYqxoth4mkHbnO0TqcFaUQ9vqz3CUKV8OQ74qrszPxEyAAEGmVBkSK/g9hXXDRNCb6YoL30BzLj001zsiH9XVnNI=
X-Received: by 2002:a9d:148:: with SMTP id 66mr21992873otu.32.1558964332814;
 Mon, 27 May 2019 06:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
In-Reply-To: <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 May 2019 15:38:26 +0200
Message-ID: <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 25, 2019 at 11:43 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
> > load_flat_shared_library() is broken: It only calls load_flat_file() if
> > prepare_binprm() returns zero, but prepare_binprm() returns the number of
> > bytes read - so this only happens if the file is empty.
>
> ouch.
>
> > Instead, call into load_flat_file() if the number of bytes read is
> > non-negative. (Even if the number of bytes is zero - in that case,
> > load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
> >
> > In addition, remove the code related to bprm creds and stop using
> > prepare_binprm() - this code is loading a library, not a main executable,
> > and it only actually uses the members "buf", "file" and "filename" of the
> > linux_binprm struct. Instead, call kernel_read() directly.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I only found the bug by looking at the code, I have not verified its
> > existence at runtime.
> > Also, this patch is compile-tested only.
> > It would be nice if someone who works with nommu Linux could have a
> > look at this patch.
>
> 287980e49ffc was three years ago!  Has it really been broken for all
> that time?  If so, it seems a good source of freed disk space...

Maybe... but I didn't want to rip it out without having one of the
maintainers confirm that this really isn't likely to be used anymore.
