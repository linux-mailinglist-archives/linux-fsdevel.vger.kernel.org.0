Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A49446AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392938AbfFMQxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:53:50 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45686 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404431AbfFMQxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:53:38 -0400
Received: by mail-yw1-f68.google.com with SMTP id m16so8606390ywh.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sPkTPdJ3wOyLAIYnFkdamPG63sZ+DeF7BYB5onzOKU=;
        b=lojDYtBtcdzshl4fWmF/BKJaI7rMcG9iFo3d/WVo5IJlaZbQDg8EFeHp9BfcyY82IL
         Y+wFGtqgiDOROUOSPEkeKXYTzYxVLwYzcoIfzWwOz86jJpDrIcSGMN6CG/VdeTA/q7aF
         zOGyOeeKWhY3EPdfv/GL7AWk2cV/lyitf+Zk66ImFj4mE+0qAwV9yviJfwXq+7nI6i1+
         qJ6OiNqID3sUoAudotTHlfgW8Huk2HadR8XHNYC5s6vOk3JqtXkSOTkG3WnxkG0LNJtk
         6a/NsvqEnfGRyO1quKtZSS5AIfUECw48N75AtuGg7bib8rLGbMhab5PWJ0GDC7R7gZwR
         rLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sPkTPdJ3wOyLAIYnFkdamPG63sZ+DeF7BYB5onzOKU=;
        b=YWE020hfvJCXpSfmNiitXcHBE44KBRyMiq3rj2yrL6QOdZdhOlYppdG0LN9ogkzhGU
         hm+s8wzMlL7KiuLxZrlG68XlYtMNfow3fEJFHqo/0uitnOi/t23cBrwm1WWVQ/ZGpwLM
         qo6m7ipDmD9ccYqUdZUQgU7p2YVsx9Y5ePEL5TOuuyYorxM8p8zsm07NFlAZ1x0wgxnD
         YS0AlgXSXrf9ZgK1LaqWM3EQP4slfga25/v6njEGoh9jBeHwyO85qfZ1d01McGehVc1d
         ByI/y15RW6NzMWo69RsurdFGP5b70rTyGWtkp5LL6lx7meis+R2GQ1A2jxdSIuD5q4jD
         rMRw==
X-Gm-Message-State: APjAAAWpjmw73JgKvxlLVgLnjHVl1KCnoXARShs08wB9n1xRU7+sjLWJ
        gz+9QyQG9bvJZNwW6YSSXy8z97kOUPfXBVCZKas=
X-Google-Smtp-Source: APXvYqxT7CSa1Fp1M4Dmj9UNPC0yB+eVMw913N8MwhuTGH+dbWfLCKeb6LXBboWSKfziMlOH43lSoEFk1vFh0jzO4fs=
X-Received: by 2002:a81:7096:: with SMTP id l144mr50488611ywc.294.1560444817087;
 Thu, 13 Jun 2019 09:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190526143411.11244-5-amir73il@gmail.com>
In-Reply-To: <20190526143411.11244-5-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Jun 2019 19:53:25 +0300
Message-ID: <CAOQ4uxg5e4zJ+GVCXs1X55TTBdNKHVASkA1Q-Xz_pyLnD8UDpA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] tracefs: call fsnotify_{unlink,rmdir}() hooks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> This will allow generating fsnotify delete events after the
> fsnotify_nameremove() hook is removed from d_delete().
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Hi Steven,

Would you be able to provide an ACK on this patch?
We need to add those explicit fsnotify hooks to match the existing
fsnotify_create/mkdir hooks in tracefs, because
the hook embedded inside d_delete() is going away [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190526143411.11244-1-amir73il@gmail.com/


> ---
>  fs/tracefs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7098c49f3693..497a8682b5b9 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -509,9 +509,12 @@ static int __tracefs_remove(struct dentry *dentry, struct dentry *parent)
>                         switch (dentry->d_inode->i_mode & S_IFMT) {
>                         case S_IFDIR:
>                                 ret = simple_rmdir(parent->d_inode, dentry);
> +                               if (!ret)
> +                                       fsnotify_rmdir(parent->d_inode, dentry);
>                                 break;
>                         default:
>                                 simple_unlink(parent->d_inode, dentry);
> +                               fsnotify_unlink(parent->d_inode, dentry);
>                                 break;
>                         }
>                         if (!ret)
> --
> 2.17.1
>
