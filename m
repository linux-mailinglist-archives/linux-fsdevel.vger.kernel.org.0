Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F3F36BE84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 06:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhD0Edx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 00:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0Edx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:33:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C06C061574;
        Mon, 26 Apr 2021 21:33:10 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b9so6334390iod.13;
        Mon, 26 Apr 2021 21:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75byu4pJI5MvVdXuEkvp2Epx9W4L2Xwgg1jlpxHJMmg=;
        b=CNyiUBfG1rbjUVeI9CcckQhm7wnVXu49jxkZUS90igZeP3kpiDkkJ1M0SjvBWjitEi
         M8EoquSnCrU3vkGIJ6j9bnHGzk2qjvETgMQJnQUv5nV7XbJv6nzPqLZ31JuOsAyXiMSd
         XXQ3O3mQlZc3/lLzZ5LXFrwV3dUK59Tgimv6U/L43phbOoTcTwXd4OkbjPBugVeVoUd2
         Jw5laEPDuB4j7lBWGsYsmxEqTOEgZuHIIR98iz9DYE0ddBmVBFrMbLKPqoUid0pqGAZf
         g97IOueTKcgHJ65tlXWY+8egqt2gZ8ZvmglwemWbI5TRFntl+CZwKHe/iMMK3+ICixkI
         8R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75byu4pJI5MvVdXuEkvp2Epx9W4L2Xwgg1jlpxHJMmg=;
        b=ACes2eW7+IXYWIV9tCFim6zt1WiSB8UIGvTnF3FR7B4bRlswRTZodKw4yNDK6dPm4z
         H6ItJAktdmgxx8hNoO8a/J01I3T7YxZMqywwfqw42p+jteBMmuEnEkBw11uWWAmQwj+B
         4gbXxeUTq2NvlNuK3NOW/UXW2BaLbYioBuN6MM9tHnAdhZMNPpIZyqyyvTnfIZeAxaIb
         B9EH0XBN8Uh1aY+t9rMKjav26xSvgtHso47XxSr3Fjbdv+cDyyPirzJXHsisdBClH9pN
         QqoFZBVwEFn0usd3E8EFjw2BhtlDaPaND2fC9xuffqOadwWudPpboQ+WFmmgnqt0zXLq
         OPIw==
X-Gm-Message-State: AOAM531PpgtPQS5/Xj4NzHAjHFzHc1uMtMQli5MrdTSHFHsLM9h1h1Fi
        WQCwJ+HiHVtKERhDYID1ZpcnsOjs7kseM0uNoLA=
X-Google-Smtp-Source: ABdhPJzfZEuPlT08eTaKA0UBV/3zfneBP1WIL9BM8FR33YWU59op1uyfgqIjnTe1N07YluIGeHTHBHTtM5lBZmTBph8=
X-Received: by 2002:a6b:d213:: with SMTP id q19mr17334976iob.203.1619497989818;
 Mon, 26 Apr 2021 21:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210426184201.4177978-1-krisman@collabora.com> <20210426184201.4177978-14-krisman@collabora.com>
In-Reply-To: <20210426184201.4177978-14-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Apr 2021 07:32:58 +0300
Message-ID: <CAOQ4uxg8X3UNjYpbLy-gksc=SuR0z4RWc=ZXru-zFQdNt5RyEw@mail.gmail.com>
Subject: Re: [PATCH RFC 13/15] ext4: Send notifications on error
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
>
> It also follows the current dmesg reporting in the format.  The
> filesystem message is composed mostly by the string that would be
> otherwise printed in dmesg.
>
> A new ext4 specific record format is exposed in the uapi, such that a
> monitoring tool knows what to expect when listening errors of an ext4
> filesystem.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/ext4/super.c                  | 60 ++++++++++++++++++++++++--------
>  include/uapi/linux/ext4-notify.h | 17 +++++++++
>  2 files changed, 62 insertions(+), 15 deletions(-)
>  create mode 100644 include/uapi/linux/ext4-notify.h
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..032e29e7ff6a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -46,6 +46,8 @@
>  #include <linux/part_stat.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/fsnotify.h>
> +#include <uapi/linux/ext4-notify.h>
>
>  #include "ext4.h"
>  #include "ext4_extents.h"      /* Needed for trace points definition */
> @@ -727,6 +729,22 @@ static void flush_stashed_error_work(struct work_struct *work)
>         ext4_commit_super(sbi->s_sb);
>  }
>
> +static void ext4_fsnotify_error(int error, struct inode *inode, __u64 block,
> +                               const char *func, int line,
> +                               const char *desc, struct va_format *vaf)
> +{
> +       struct ext4_error_inode_report report;
> +
> +       if (inode->i_sb->s_fsnotify_marks) {
> +               report.inode = inode ? inode->i_ino : -1L;
> +               report.block = block ? block : -1L;
> +
> +               snprintf(report.desc, EXT4_FSN_DESC_LEN, "%s%pV\n", desc?:"", vaf);
> +
> +               fsnotify_error_event(error, inode, func, line, &report, sizeof(report));
> +       }
> +}
> +
>  #define ext4_error_ratelimit(sb)                                       \
>                 ___ratelimit(&(EXT4_SB(sb)->s_err_ratelimit_state),     \
>                              "EXT4-fs error")
> @@ -742,15 +760,18 @@ void __ext4_error(struct super_block *sb, const char *function,
>                 return;
>
>         trace_ext4_error(sb, function, line);
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
>         if (ext4_error_ratelimit(sb)) {
> -               va_start(args, fmt);
> -               vaf.fmt = fmt;
> -               vaf.va = &args;
>                 printk(KERN_CRIT
>                        "EXT4-fs error (device %s): %s:%d: comm %s: %pV\n",
>                        sb->s_id, function, line, current->comm, &vaf);
> -               va_end(args);
> +
>         }
> +       ext4_fsnotify_error(error, sb->s_root->d_inode, block, function, line, NULL, &vaf);
> +       va_end(args);
>         ext4_handle_error(sb, force_ro, error, 0, block, function, line);
>  }
>

So error reporting to kernel log is ratelimited and error reporting to
fsnotify is limited by a fixed size ring buffer which may be filled by
report floods from another filesystem, so user can miss the first
important error report from this filesystem.

Not optimal.

With my proposal of keeping a single fsnotify_error_info in every
fsnotify_sb_mark, users will be guaranteed to get the first error
report from every filesystem and once they read that report they
will be guaranteed to also get the next report.

Thanks,
Amir.
