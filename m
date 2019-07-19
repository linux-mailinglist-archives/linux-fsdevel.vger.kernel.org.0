Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 532BD6E6AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfGSNhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 09:37:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39034 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbfGSNhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:37:51 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so58470448ioh.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2019 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZjbY0MaT6UAbPH1wjXD/28Vzvm/xrV41gWCDtH/Zgc=;
        b=CFMJqLm8STRXF20f8x5Scl80Jvrnq7e0wqiZJfZxXCAu1VhsIA7eBko5wd6eS1OEw5
         Uy42PvzmsnI6FwM+axqYz7Z0vY/owPz8hNge4q2iBf83vDVxqykAPd9hYOApcMK1qBS3
         uGbARDadMZv8c5LxATRua3tUulE9864iGWNLvMcWHARqCqc5JXtOY94tt9uiai/RzmeT
         mvA/lO4xITNKXLoA/VoHsaifsLyUiK0F5TAQIZPBhwD0JxESy+nqp34n2YIyYLQHqXKg
         WtDdkR5UMBB32tTcmiwCZ7NLWASFIRaCZzeVODmLvm7KNg2STC1hcyjQcXWsYgLk2Ifg
         Sj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZjbY0MaT6UAbPH1wjXD/28Vzvm/xrV41gWCDtH/Zgc=;
        b=SMl52YU3NP83PKM8s7YD4DVtjPkug08UeEh2Gk/CLm+W64aqVKdcTiqjK4GH0vpmBV
         GEZn8lJGv0Tr0APzdVQUY0zrXlEB0ZDNa8IsaUTM+XZgi/PNwCMxLtDDyT5ZySkKhZi+
         3b95mNwP2nVLxJD7Ha2JuUVJ7E/iyyUKo9T/pBArtXC4AuBaZd5V8fKTotsqpQgKb8HQ
         UPQoyzd7SHdKMs6E8OAyxHV9JiqOFWdsayd6cbjpYnzsKGEQOwlxZkjqSb6ltPFc1WCF
         UDNtFb8EdQBGxDxW8Ud1J+lsQ+7NoyOgNatNBefqXCchA45BsqI+IXfdplccCv2dvP9k
         spoQ==
X-Gm-Message-State: APjAAAVv54IJYKsAauO4mj0yXjnP2h9cfXXprrGi6lDA3xeQ0t6+SSJT
        sPwtLng53VKcNkwDRjqZU8lZ8R+MZwxz96EpfUtAMA==
X-Google-Smtp-Source: APXvYqyBhZpTSPfvsPmtieVyZpieljJsIsnw3wZLtW5Q7oA/SdVcTnOz10NqjvVRw9/mQWgrE57FGHsmh11BaU/x1Us=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr26351958ior.231.1563543470069;
 Fri, 19 Jul 2019 06:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190719124329.23207-1-nh26223.lmm@gmail.com>
In-Reply-To: <20190719124329.23207-1-nh26223.lmm@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Jul 2019 15:37:37 +0200
Message-ID: <CACT4Y+aVS5nn0Pv31tAOujcAPvCAOuK_iPZ1CCNbgAOL=JDvvg@mail.gmail.com>
Subject: Re: [PATCH] fs: fs_parser: avoid NULL param->string to kstrtouint
To:     Yin Fengwei <nh26223.lmm@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 19, 2019 at 2:44 PM Yin Fengwei <nh26223.lmm@gmail.com> wrote:
>
> syzbot reported general protection fault in kstrtouint:
> https://lkml.org/lkml/2019/7/18/328
>
> From the log, if the mount option is something like:
>    fd,XXXXXXXXXXXXXXXXXXXX
>
> The default parameter (which has NULL param->string) will be
> passed to vfs_parse_fs_param. Finally, this NULL param->string
> is passed to kstrtouint and trigger NULL pointer access.
>
> Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
> Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")
>
> Signed-off-by: Yin Fengwei <nh26223.lmm@gmail.com>
> ---
>  fs/fs_parser.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index d13fe7d797c2..578e6880ac67 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -210,6 +210,10 @@ int fs_parse(struct fs_context *fc,
>         case fs_param_is_fd: {
>                 switch (param->type) {
>                 case fs_value_is_string:
> +                       if (result->has_value) {

!result->has_value ?

> +                               goto bad_value;
> +                       }
> +
>                         ret = kstrtouint(param->string, 0, &result->uint_32);
>                         break;
>                 case fs_value_is_file:
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190719124329.23207-1-nh26223.lmm%40gmail.com.
