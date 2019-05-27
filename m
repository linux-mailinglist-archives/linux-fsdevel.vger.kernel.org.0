Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBD62B193
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0Jtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 05:49:36 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46625 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfE0Jtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 05:49:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id o81so2213493ybc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2019 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKkjUv4zO2ZGyCSeKwcrLI2L7wy0xnWXlENnMuYZuHM=;
        b=LG0j9S0mpyF5RnkO+xV8Rg4KQn9/pT7uGqZHGeZmLimeWbWiY0KgEOWKyOV+04VRF8
         OmT4aRbMw4JH0XQ/gULpfBA3USANtkckCOlc5j4dAF5ydFZjwHYoeeILy7ZDFk/RPsmn
         Ec2bcOB0I1YY0OGivk1SN4OUT/VH7m1DvUQTzaFswqeTM5CoJUYUGmv4OxwHh9L/IfqW
         HWWySu1nrbBKQL5hM+liLDd0cg1WMpqTcHFwc41WY/INZfl9wD2fQhbRLeZ5OURZUx/F
         WFDqK6IA8n6ZGRyS73fWIUFed2TZMsATL7d8HssGPfnqYTFGBnw/uuCsXnDdbmpoqZAl
         NlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKkjUv4zO2ZGyCSeKwcrLI2L7wy0xnWXlENnMuYZuHM=;
        b=kq+mLmeNKiZA8Iu3LziLs4VBk+ntF/GxSY/A0w7hvmjFOhAgeQPmUbDYv++Gv3eEmz
         YIUP208fOdr6r1v6JQXrq7W4nGzIl/7Ou/ZFKyacgTOuhzTV5ln+6YDF8qAbzJWNrJkj
         E4YLGF7E2zUQnq6IJx+3YtcajbONuFhTfD1X3Fl/Y7w/lmJq6lYEOXTYRzpKmcjvxctM
         f4jBQEhNvLJ42vd379yV3qH6gOf9o2EBwE0waJo/TNbJ6CuvXiE0jvAgV1j+O+LkRnIK
         nPbYc/KiV+Nu9DPaDWdYnZQhXE1/2d4ZklbV9fmYheOvUGQaDgqREmECzEb4QX8ox/mQ
         RfRA==
X-Gm-Message-State: APjAAAUy/BoTb98iFlij9TwRHUN1RnTOGOd5yZhDFmJzylFjkbn0utZr
        l06U6ox8lhxQmFovXLSjBCZrtQy2u7zkubc31ew=
X-Google-Smtp-Source: APXvYqzMXGf0mNoO0j2xL+7fpUvH52fVLTJxRgoQqLhctVihZFmjhCIQS1nZkEONwBqqWeQ4KF2WrsTtF59XmnBJOPs=
X-Received: by 2002:a25:8109:: with SMTP id o9mr22899857ybk.132.1558950575214;
 Mon, 27 May 2019 02:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190527082457.GE21124@kroah.com>
In-Reply-To: <20190527082457.GE21124@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 May 2019 12:49:23 +0300
Message-ID: <CAOQ4uxjyg5AVPrcR4bPm4zMY9BKmgV8g7TAuH--cfKNJv8pRYQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Sort out fsnotify_nameremove() mess
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 11:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 26, 2019 at 05:34:01PM +0300, Amir Goldstein wrote:
> > Jan,
> >
> > For v3 I went with a straight forward approach.
> > Filesystems that have fsnotify_{create,mkdir} hooks also get
> > explicit fsnotify_{unlink,rmdir} hooks.
> >
> > Hopefully, this approach is orthogonal to whatever changes Al is
> > planning for recursive tree remove code, because in many of the
> > cases, the hooks are added at the entry point for the recursive
> > tree remove.
> >
> > After looking closer at all the filesystems that were converted to
> > simple_remove in v2, I decided to exempt another 3 filesystems from
> > the fsnotify delete hooks: hypfs,qibfs and aafs.
> > hypfs is pure cleanup (*). qibfs and aafs can remove dentry on user
> > configuration change, but they do not generate create events, so it
> > is less likely that users depend on the delete events.
> >
> > That leaves configfs the only filesystem that gets the new delete hooks
> > even though it does not have create hooks.
>
> why doesn't configfs have create hooks? That's what userspace does in
> configfs, shouldn't it be notified about it?  Keeping it "unequal" seems
> odd to me.
>

So it's not exactly that configfs has no create hooks at all.
For "normal" filesystems mkdir (for example) is only possible
by mkdir(2) syscall and there is create hook in vfs_mkdir().

The configfs (as well as debugfs/tracefs/etc), there are other code paths
that create directories, namely: configfs_register_grup/subsystem().
Those code paths have explicit fsnotify_mkdir() hook in debugfs/tracefs/etc,
but not in configfs. Why? because nobody put the hooks and no user
complained.

Should we add fsnotify_mkdir() hooks in configfs - probably yes.
I can do it as followup, but this is not the purpose of this patch set.
The purpose of this patch set (achieved in the last patch) is to simplify
the implementation of the fsnotify delete hook.
Today it is overly complicated by the fact that the hooks was placed
in d_delete() and d_delete() is called from some code paths that have
no business with fsnotify notifications at all.

Once this patch set is done sprinkling fsnotify_rmdir/unlink() hooks
in "proper" places, it removes the current fsnotify hook from d_delete().
d_delete() is called from configfs_unregister_group/subsystem(), so if
we do not add fsnotify delete hooks to configfs we will regress the existing
"unequal" behavior.
Maybe there are no users depending on fsnotify delete notifications from
configfs - I do not know. If we believe that is the case, we can drop the
configfs patch.
Maybe there *are* user depending on fsnotify delete notifications from aafs
(apparmorfs), which I decided to exclude from v3 patch set.
If we believe that is the case, or if we find out later that in case -
no problem
it is simple to add the missing fsnotify hooks in apparmorfs.

Thought? About inclusion of configfs? About exclusion of apparmorfs?
Again this is only exclusion/inclusion of hooks from code path that does
NOT come from vfs syscalls (e.g. aa_remove_profiles()).

Thanks,
Amir.
