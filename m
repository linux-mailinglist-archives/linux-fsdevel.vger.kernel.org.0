Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3826734EDB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhC3QYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhC3QYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:24:14 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20197C061574;
        Tue, 30 Mar 2021 09:24:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j26so17005958iog.13;
        Tue, 30 Mar 2021 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Knh+HBabEcIpHLKAfb96iLF6cZ5htGgMZTF/1gEtTQ=;
        b=i7hnewJB51iYwjlZxbtWs9X/oVTTOUcx/J69a0fezpI67zWcYM4w8pZ/92IsmNYWGh
         L5GuRsoQai6VofmmL4qhAsMj/XiOTlwQNTbf67zi2LPcqD3NEQXhQpCYv6TjKjfjiw+M
         Fv5g0ESPFXk6+YgLHN3xDpkfbrY7oJfTJJLDA99oXNWwKf9hPJtalEjlob4iptWqhpCX
         tG1fuV+8HnmgKNl7PfUO7RudywRa7JSu5yrsCsuuWT050bY6uem1n3dIyJi60bZLMjMj
         MXPceoZJ8OslCteyNXA+hhxbg++tu/QNLeMKPqAiPhXwmqF8DkqdYf5F3bPpDtspTrz1
         UTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Knh+HBabEcIpHLKAfb96iLF6cZ5htGgMZTF/1gEtTQ=;
        b=pxiD5MDQcZ/quettOhQh3sPjhm++6sKgR6kv/+ygsh4y6aKDlKeGTHeOP67LwUECB2
         Wf02BhAA4q4zvZkn3ejRlo7IUnwtQrzTgphfgjB+2gBpdwPpHKHctN3XMjG1BZ8DNmRg
         0XffJ8AkJGe4P8j7+ldYO2NRnNEihYqgY20NsDUeEW7ilzF9gUNEWP2feqhaSRzG+Xoj
         37UclFiS5BoNzNoRm4d8NhMYyjOXlDCvy6ekX30nW6KO1Vel0dII4LNIfxT9R4w+Tz8U
         bddubCQSNbNChMFdI6pk9Jm4YmlD3NCGTla9/RQpkqzCqU9dwE7k+7r/lG1y66d64AEq
         1Njw==
X-Gm-Message-State: AOAM533xyd4i2tX84TipKI/lPu10WBqw51xBwM9+FdyZngdZik5h1ANP
        JhhUyugSLAgS0sN1sLK2QrLlEh3VNEQWUQ7xYIs=
X-Google-Smtp-Source: ABdhPJyzxxsv0BNcHrD/89YAfLRiQ3paJnj7ow/E3+GkwmFxaKcWEZVzl9KgZLH924GBq8722y4QiMdPWb8+w7Hx3vI=
X-Received: by 2002:a05:6638:1388:: with SMTP id w8mr23837889jad.30.1617121453564;
 Tue, 30 Mar 2021 09:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Mar 2021 19:24:02 +0300
Message-ID: <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 12:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Mar 30, 2021 at 10:31 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > > Add a high level hook fsnotify_path_create() which is called from
> > > syscall context where mount context is available, so that FAN_CREATE
> > > event can be added to a mount mark mask.
> > >
> > > This high level hook is called in addition to fsnotify_create(),
> > > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > > context is not available.
> > >
> > > In the context where fsnotify_path_create() will be called, a dentry flag
> > > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > > level hooks.
> > >
> > > This functionality was requested by Christian Brauner to replace
> > > recursive inotify watches for detecting when some path was created under
> > > an idmapped mount without having to monitor FAN_CREATE events in the
> > > entire filesystem.
> > >
> > > In combination with more changes to allow unprivileged fanotify listener
> > > to watch an idmapped mount, this functionality would be usable also by
> > > nested container managers.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
> > > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> >
> > Was about to look at this. Does this require preliminary patches since
> > it doesn't apply to current master. If so, can you just give me a link
> > to a branch so I can pull from that? :)
> >
>
> The patch is less useful on its own.
> Better take the entire work for the demo which includes this patch:
>
> [1] https://github.com/amir73il/linux/commits/fanotify_userns
> [2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns
>

Christian,

Apologies for the fast moving target.
I just force force the kernel+demo branches to include support for
the two extra events (delete and move) on mount mark.

3dd3d7f02717...6cfe8f7a9148 fanotify_userns -> fanotify_userns (forced update)

The same demo I described before with a mix of:
- CREATE event on MOUNT mark
- Rest of events on recursive inode marks
Still work when running demo script with --fanotify --recursive
on idmapped mount

But now the demo also works with --global on idmapped mount
by setting up only a mount mark to watch most events
excluding the unsupported events (see below).

Thanks,
Amir.

# ./test_demo.sh /mnt 0
+ WD=/mnt
+ ID=0
...
+ inotifywatch --global -w --timeout -2 /mnt
Establishing filesystem global watch...
...
total  modify  close_write  move_self  create  delete  filename
3      0       1            0          1       1       /mnt/a/1 (deleted)
2      0       1            0          1       0       /mnt/a/0 (deleted)
2      0       1            0          1       0       /mnt/a/2
2      0       1            0          1       0       /mnt/a/3
2      0       0            0          1       1       /mnt/a/dir1 (deleted)
2      0       1            0          1       0       /mnt/a/dir2/A/B/C/file2
1      0       0            0          1       0       /mnt/a/dir0 (deleted)
1      0       0            0          1       0       /mnt/a/dir2
1      0       0            0          1       0       /mnt/a/dir2/A
1      0       0            0          1       0       /mnt/a/dir2/A/B
1      0       0            0          1       0       /mnt/a/dir2/A/B/C
