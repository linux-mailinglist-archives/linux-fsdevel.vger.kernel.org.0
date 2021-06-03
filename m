Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E4339A3F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhFCPHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhFCPHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:07:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC088C06174A;
        Thu,  3 Jun 2021 08:05:22 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id i10so9341805lfj.2;
        Thu, 03 Jun 2021 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iH2YqRuX9TbVqFy+5J3qDQrY5ch5XHp+h4ttxH/MyQ=;
        b=GBnM2wZp9yQXhA9CUrLSHUX1wWuLlZkbRRtUXHAPLCZ1V7zajz8yxdfEwyvE4DEjsh
         P2Dlyrpxs1d+ZmkjjKeQsho0s6nBsMjb/+pMEGEzR6dyVzdsevm8uI0CkC3c/NKhbJYU
         VVzWOb7PsuN2XsC0qoARfu7PP+NfeRhDvL0u0fedqQP+6OHY+Jv2E0odXgj/DvepbTO5
         pjn68Lth2HK8rnUn/58kE9yuhZ9ITKXuFUteBZJk4U0HmsIG8N5wCNSJJmMX9eQjZXhZ
         4WOUB1xs5KKsIlqCSazCqnJtk5lKYBpTKYmsEhvweu15RDIJmEisOSPcekOZdKrjNRcv
         QIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iH2YqRuX9TbVqFy+5J3qDQrY5ch5XHp+h4ttxH/MyQ=;
        b=uktsQtlcWMV2naGt08lm+ArnN9qY5YNSkqoOutJlqIBLHA+HSjsMr+O0FudX0x21wy
         aDH9+7AKlu5hd/jqRfKbht2+dhoZuE0tJEW7W2VQYS9wKXdJkJUiLe2Xrj1G2yruQZK6
         Hm2KFQKg9IumVaTTbEmTeFQP8LSaUH5fZTUwYp993kHwY4wbI3TZdqgyR311VZXTK4NI
         9mPoQm+jEK8CmjIOFm+yRwtXHu0NA35sO/5m3oJsyK7v+hrU+KxDUzj4B9aqUxxMbyN9
         Jxe9biCraTSq912Sw3a6xONX5wKKZGLm9jRq/9uREzLlpxQqIZCg4TXDKxB5hGp4Pfzs
         ZW+g==
X-Gm-Message-State: AOAM533G6I2CBvB7sfueOtFY7zwm9GQWGAffZUkUkmVnysDFDL7c/BCC
        yuxa3bzGLCAeCTNHonKQAx1+AYMJkplK5quHFts=
X-Google-Smtp-Source: ABdhPJwQ9xBB550TWDnlNqjgr2U+Dv+fy/cjvhUI+PgFCJdk3956J4GG9gr2F9/dSF7ycTmRZePJzjgXKUZvoUjsZHo=
X-Received: by 2002:a05:6512:3045:: with SMTP id b5mr77288lfb.273.1622732720453;
 Thu, 03 Jun 2021 08:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210602144630.161982-1-dong.menglong@zte.com.cn>
 <20210602144630.161982-3-dong.menglong@zte.com.cn> <20210603133015.gvr5wpbotkyhhtqx@wittgenstein>
In-Reply-To: <20210603133015.gvr5wpbotkyhhtqx@wittgenstein>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 3 Jun 2021 23:05:08 +0800
Message-ID: <CADxym3YWUBf6W4pgeSPuYKFXPXeGse0t=DW8fAm-3WvgjWkRnA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] init/do_mounts.c: create second mount for initramfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Menglong Dong <dong.menglong@zte.com.cn>, masahiroy@kernel.org,
        joe@perches.com, hare@suse.de, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>, Barret Rhoden <brho@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        jeyu@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 3, 2021 at 9:30 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
[...]
>
> In fact you seem to be only using this struct you're introducing in this
> single place which makes me think that it's not needed at all. So what's
> preventing us from doing:
>
> > +
> > +     return do_mount_root(root->dev_name,
> > +                          root->fs_name,
> > +                          root_mountflags & ~MS_RDONLY,
> > +                          root_mount_data);
> > +}
>
> int __init prepare_mount_rootfs(void)
> {
>         if (is_tmpfs_enabled())
>                 return do_mount_root("tmpfs", "tmpfs",
>                                      root_mountflags & ~MS_RDONLY,
>                                      root_mount_data);
>
>         return do_mount_root("ramfs", "ramfs",
>                              root_mountflags & ~MS_RDONLY,
>                              root_mount_data);
> }

It seems to make sense, but I just feel that it is a little hardcode.
What if a new file system
of rootfs arises? Am I too sensitive?

[...]
>
> This is convoluted imho. I would simply use two tiny helpers:
>
> void __init finish_mount_rootfs(void)
> {
>         init_mount(".", "/", NULL, MS_MOVE, NULL);
>
>         if (ramdisk_exec_exist())
>                 init_chroot(".");
> }
>
> void __init revert_mount_rootfs(void)
> {
>         init_chdir("/");
>         init_umount(".", 0);
> }
>

This looks nice.


Thanks!
Menglong Dong
