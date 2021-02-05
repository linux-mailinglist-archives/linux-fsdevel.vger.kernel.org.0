Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7891310698
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 09:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhBEIYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 03:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhBEIX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:23:56 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6154C06178A
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 00:23:15 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h7so8678291lfc.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKkMww0BNMIIjBGgsKSMaOdR9a7fnTcLSV++vCaW8t0=;
        b=ZnD+NaeZeStZbPuoD4W6QndvFUB8KY+9O3YaHdTAtYEt+UFYfYO7T+9tnx7/Ff0+/m
         2+1H5LPss2NpZhJSZcarb+QwZ3lfsIjpPu5bgWGdAk5zujkoOiMoRFZtqul93nsA0PZj
         E8B1tAOIN1ClF1uisLcMUkNSZhiV6/ANj5QvCMwns/MK8y8hjxO3qVPw2xSIK6uSW0qH
         NjuFjTfG0vtP4/ZAkyF7TG+D6CjyUdAvO3kgA7sovG6k9njU4czYxvVujwNHC/43zGXB
         Wuab75zjryocxluJuugIJ2qbCI1Y+xRDXG2dW5hoagRnWMpve/+sgfdIZKXonKLNBv1s
         GzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKkMww0BNMIIjBGgsKSMaOdR9a7fnTcLSV++vCaW8t0=;
        b=eF7bs7p770wjDObVvLNQomyQL742Qd7EGxw/tVzZHnOQbyKo88GbgWuLfInbuT3tKc
         BC//vnd0n++RHYY4DRnvEryA7dberwxIte7G5J9rF7C85Mci6YtfRdtQGI+QWtSG7wPc
         vsytMZgthtUBKl0vWgXRMuxufdPlvXmACwNHDN9HOpTkGyGSzExGfzH9l4BZdpb4ia9t
         1W0VATdP1/EKXv5vPzcPC/BTiVU8pe6saYVAVFPDMM+ElFiw799FXhVVSx8hypa+ivmh
         jRlTl8DWcJDdJQNSF48g5VBLWA8ykLHj21jsqrLuvQOOoySE4hszxIjsl/tRb4FWb1VD
         1KRQ==
X-Gm-Message-State: AOAM5300p2gDhf1v1sitvG9yBPJKBjXRnTG0zeWksFXJZ5nMNxKwGhZ8
        6NlH8sPvut3MgehXn1FX2cKfJyPMyYaqUCxd4kE=
X-Google-Smtp-Source: ABdhPJzt7cgiYJXXTaSTfawmU7lVWZ6n6BGeYEIhHqowRYR4K7AInNgd61i78PPUWmQp1Sl/gZmwygmMXlRMS2ZZUbg=
X-Received: by 2002:a19:a410:: with SMTP id q16mr1937067lfc.252.1612513394210;
 Fri, 05 Feb 2021 00:23:14 -0800 (PST)
MIME-Version: 1.0
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net> <160862330474.291330.11664503360150456908.stgit@mickey.themaw.net>
In-Reply-To: <160862330474.291330.11664503360150456908.stgit@mickey.themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Fri, 5 Feb 2021 16:23:02 +0800
Message-ID: <CAC2o3DKc0expAJAiNHnU5dY8hpom4z6TdRegQxahRBrZKL+7qg@mail.gmail.com>
Subject: Re: [PATCH 5/6] kernfs: stay in rcu-walk mode if possible
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ian,

On Tue, Dec 22, 2020 at 3:48 PM Ian Kent <raven@themaw.net> wrote:
>
> During path walks in sysfs (kernfs) needing to take a reference to
> a mount doesn't happen often since the walk won't be crossing mount
> point boundaries.
>
> Also while staying in rcu-walk mode where possible wouldn't normally
> give much improvement.
>
> But when there are many concurrent path walks and there is high d_lock
> contention dget() will often need to resort to taking a spin lock to
> get the reference. And that could happen each time the reference is
> passed from component to component.
>
> So, in the high contention case, it will contribute to the contention.
>
> Therefore staying in rcu-walk mode when possible will reduce contention.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index fdeae2c6e7ba..50c5c8c886af 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1048,8 +1048,54 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>         struct kernfs_node *parent;
>         struct kernfs_node *kn;
>
> -       if (flags & LOOKUP_RCU)
> +       if (flags & LOOKUP_RCU) {
> +               parent = kernfs_dentry_node(dentry->d_parent);
> +
> +               /* Directory node changed, no, then don't search? */
> +               if (!kernfs_dir_changed(parent, dentry))
> +                       return 1;
> +
> +               kn = kernfs_dentry_node(dentry);
> +               if (!kn) {
> +                       /* Negative hashed dentry, tell the VFS to switch to
> +                        * ref-walk mode and call us again so that node
> +                        * existence can be checked.
> +                        */
> +                       if (!d_unhashed(dentry))
> +                               return -ECHILD;
> +
> +                       /* Negative unhashed dentry, this shouldn't happen
> +                        * because this case occurs in ref-walk mode after
> +                        * dentry allocation which is followed by a call
> +                        * to ->loopup(). But if it does happen the dentry
> +                        * is surely invalid.
> +                        */
> +                       return 0;
> +               }
> +
> +               /* Since the dentry is positive (we got the kernfs node) a
> +                * kernfs node reference was held at the time. Now if the
> +                * dentry reference count is still greater than 0 it's still
> +                * positive so take a reference to the node to perform an
> +                * active check.
> +                */
> +               if (d_count(dentry) <= 0 || !atomic_inc_not_zero(&kn->count))
> +                       return -ECHILD;
> +
> +               /* The kernfs node reference count was greater than 0, if
> +                * it's active continue in rcu-walk mode.
> +                */
> +               if (kernfs_active_read(kn)) {
We are in RCU-walk mode, kernfs_rwsem should not be held, however,
kernfs_active_read will assert the readlock is held. I believe it
should be kernfs_active(kn) here. Am I wrong??

> +                       kernfs_put(kn);
> +                       return 1;
> +               }
> +
> +               /* Otherwise, just tell the VFS to switch to ref-walk mode
> +                * and call us again so the kernfs node can be validated.
> +                */
> +               kernfs_put(kn);
>                 return -ECHILD;
> +       }
>
>         down_read(&kernfs_rwsem);
>
>
>

thanks,
fox
