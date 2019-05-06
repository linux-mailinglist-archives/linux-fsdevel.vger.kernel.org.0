Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2815125
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEFQWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 12:22:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40526 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfEFQWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 12:22:33 -0400
Received: by mail-yw1-f67.google.com with SMTP id 18so5979817ywe.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GqBG37Bgodcv7rbI0ITf8OMb9NZKMdZYJ363tMB0Ag=;
        b=l88/3n6Gok1I8Vcb6mTz9erJxcpEQBBs+wIDogAqzL9CgJhXT6Y5l0RNc8WetqFS/P
         dKl0kvJWrGgSfMAghFwN5AtRV6g9Q033ZFbLr0ZIknHHBReJULbj+OciGayhftDjABgB
         FMcCoo18+3H7ZxnjIADJZ8IY1k9FzKA0GEMIlj2HscCS+tRs6L6JKzZJH9s6O2IyIr6C
         aWEGuIEaTCWr8YX+mImieWwL6jKlFBH/b6GSH3kfNYkuT/DfQXhfnx3iaDhvqA1sV5nx
         1r5WhUakyroWo8t0LdUOnL3OBvckEp7hWUsksyHq/TtJBWHt9N0Il9EfUIdcHOOHEJMK
         4pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GqBG37Bgodcv7rbI0ITf8OMb9NZKMdZYJ363tMB0Ag=;
        b=lClmnjWbaz8ZQ+4a/MLuiXzmMafHuWA3J4jDJmzRVrMX6QrMAjBfaHkeKsGhYahShz
         gKrnnUrVMVTHy7S+HbLtCmwcCjU4fY/j9WAiyBzuFrgY3mgi7qSXY2GrQmCiHVsh6LXL
         WlG5pkWkAHKoOMxYAUw/L6L40uEasdS5Lm8yvNoJ+wRbDj1mGf4xdyJi3EzsbDk9Csn3
         tpxQfSNHweRx56ZRabe5xnAD39eA/doARpORzEeEhmjH8+II3hmzPv84eRK1QspJPA+K
         TViaOsaXcQzIPvur2ZVW/EesUoO7J4KHw7LDp8KrDzp2JQ48QjitZkpXPv3a7DKIp7Re
         0/yw==
X-Gm-Message-State: APjAAAXvT5e63WSoNVNZUuBe30Xy50hDo4sNvHNxWLHmt6ef7N2oQF3S
        UfpkfjeDmisUjo8b3CbstEmKdPwDOUAq1Zr5TjSQ5rdD
X-Google-Smtp-Source: APXvYqwOtlXWfHzQDfWlHmbGFTCDlBbyh46VEFb4/n4CDZzDq6CIQMxKIDRXkArWj5Ew06V13qPhVkR7ikN0qVAlpNE=
X-Received: by 2002:a0d:ff82:: with SMTP id p124mr19019168ywf.409.1557159752573;
 Mon, 06 May 2019 09:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190505091549.1934-1-amir73il@gmail.com> <20190505130528.GA23075@ZenIV.linux.org.uk>
 <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com>
 <20190505134706.GB23075@ZenIV.linux.org.uk> <CAOQ4uxhY0WmA7bTHhBXJLery2NmLKb_kGxoQY-hae3CrBA2sXQ@mail.gmail.com>
 <20190506142641.GD23075@ZenIV.linux.org.uk>
In-Reply-To: <20190506142641.GD23075@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 May 2019 19:22:21 +0300
Message-ID: <CAOQ4uxh9B_m-NKigL0506UNK_s0A0zuZbOvZ69geC=ZUZo9dFA@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 6, 2019 at 5:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 06, 2019 at 03:43:24PM +0300, Amir Goldstein wrote:
> > OK. What do you have to say about this statement?
> >
> >     Because fsnotify_nameremove() is called from d_delete() with negative
> >     or unhashed dentry, d_move() is not expected on this dentry, so it is
> >     safe to use d_parent/d_name without take_dentry_name_snapshot().
> >
> > I assume it is not correct, but cannot figure out why.
> > Under what circumstances is d_move() expected to move an unhashed
> > dentry and hash it?
>
> For starters, d_splice_alias() picking an exising alias for given directory
> inode.

Ok. But seeing that we are already in d_delete() said directory is already
IS_DEADDIR, so that can be added to the assertion that proves the
stability of d_name.
Are there any other cases? weird filesystems?

>
> > My other thought is why is fsnotify_nameremove() in d_delete() and
> > not in vfs_unlink()/vfs_rmdir() under parent inode lock like the rest
> > of the fsnotify_create/fsnotify_move hooks?
> >
> > In what case would we need the fsnotify event that is not coming
> > from vfs_unlink()/vfs_rmdir()?
>
> *snort*
>
> You can thank those who whine about notifications on sysfs/devpts/whatnot.
> Go talk to them if you wish, but don't ask me to translate what you'll get
> into something coherent - I'd never been able to.

I see. So all of those fs that are interested in notifications already have
fsnotify_create()/fsnotify_move() calls in them.
There are only 5 of them: binderfs, debugfs, devpts, tracefs, sunrpc.
It would be easier and less convoluted to also add the fsnotify_nameremove()
explicit calls in those fs.
With those fs either d_name is inherently stable or (debugfs) locks on parent
are taken properly.

But d_delete() effectively provides something else. If provides "remote server
change notifications" for clustered/networking filesystems when server
invalidates the local dentry. This is not a feature that is guarantied
by fsnotify.
notifications will be delivered randomly based on existence of local entry
in dcache. Only networking fs that provide proper remote notifications
(cifs is interested in doing that) should really be calling the fsnofity hooks.

Of course, we remove the random remote notifications from clustered/network
fs, there is bound to be someone unhappy. Urgh! out of those fs, only ocfs2
calls fsnotify_create(). If it is deemed important, can add
fsnotify_nameremove()
to ocfs2 as well.

Dare we make this change and see if people shout?
It's easy to add the random remote fsnotify_nameremove() calls per request
for a filesystems that want it.

Thanks,
Amir.
