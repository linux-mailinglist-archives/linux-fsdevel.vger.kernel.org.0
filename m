Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D326814A08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 14:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEFMng (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 08:43:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39305 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfEFMng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 08:43:36 -0400
Received: by mail-yw1-f66.google.com with SMTP id w21so1104726ywd.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jufXrFv6tNWtxYgbczAuVN67fOYGhMeKFgCPtlnADPA=;
        b=OEP6sPlB0piKBo+e1Gnz94Lwv+WuJI3d2d8aAzKy5tzkzNhymQVE41Nf0IxKQvObAD
         1du8yPv2nEjOe0xgPXzVrlNj0gxBjCMgr0ozEaQcCZuoNXZm0fenrtvDoDMXi1X023JQ
         UeB3LxZBMIwpfKHZEe3CVeXdbQr9XOvhp+DNhUAbkBvH8jCoXW/UvD/YOBgvmdHwlO2Y
         Hpnlzl8LuwnLu95iIz3BhMabfEqMjZal6gdvEi+ZG6O7SatmVqSfehBbC0rV5G6VnQMn
         LuOpUdBLGA/APpJWe9/nuHYKA864lrvVaxuK3WkPtWII6/LvDUPwtEkEAx6fVAu02gNa
         202w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jufXrFv6tNWtxYgbczAuVN67fOYGhMeKFgCPtlnADPA=;
        b=tyVI1+q0GFbttCXrpuhIUgc6x8A5a9RHXhzlZmP82fqQJ56Fe9ARtyOtHGNS5uSvqR
         v/vo9T5aD0sUaKlU7zOg2VALqialT0jUSug0bi2zQoeCD0pjEukqn0cnrFEQAUcb3I4j
         mVZ7IgT4mn4A/OTo6HfWkPawJZ4dpZJgQ/qR/YHGFuYAByS1JS3jAeXd+5v4oyqkQQuL
         UTr/BckRY6ASktzNkf4I958U9lKzr0QMVeFyC0HnaUJkIbK7SIAYFmH0bVGMglFY9kWh
         iRFeIJjF3xYPQji2rnhuGIJhDgG40j0AZSFCT76BLXJo3lfz/Ix8ovLKKxN8sIsFZHfQ
         KFqw==
X-Gm-Message-State: APjAAAUQ3ZE2IfKmIHI4zuk9GaTvwcsYJ8XgjfFbSdLZPp+3uf8cvJG9
        jeMSLduXdyIttvBLogUaFumC0GcfqilviYw3lDeJIYGl
X-Google-Smtp-Source: APXvYqwSwI++1tcRBxBG6V5XtDnR9zVpfdNDnlTajFqI593V8fwt9GJp08EZTAGU3B0n/LFjGvA5Lr+/H6MT6e2w2rc=
X-Received: by 2002:a25:b948:: with SMTP id s8mr17161131ybm.325.1557146615423;
 Mon, 06 May 2019 05:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190505091549.1934-1-amir73il@gmail.com> <20190505130528.GA23075@ZenIV.linux.org.uk>
 <CAOQ4uxhEWLXQ+cb4UQcworPQoJpXvf59HJYi2dv5pumvbxpA9w@mail.gmail.com> <20190505134706.GB23075@ZenIV.linux.org.uk>
In-Reply-To: <20190505134706.GB23075@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 May 2019 15:43:24 +0300
Message-ID: <CAOQ4uxhY0WmA7bTHhBXJLery2NmLKb_kGxoQY-hae3CrBA2sXQ@mail.gmail.com>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 5, 2019 at 4:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, May 05, 2019 at 04:19:02PM +0300, Amir Goldstein wrote:
>
> > I have made an analysis of callers to d_delete() and found that all callers
> > either hold parent inode lock or name is stable for another reason:
> > https://lore.kernel.org/linux-fsdevel/20190104090357.GD22409@quack2.suse.cz/
> >
> > But Jan preferred to keep take_dentry_name_snapshot() to be safe.
> > I think the right thing to do is assert that parent inode is locked or
> > no rename op in d_delete() and take the lock in ceph/ocfs2 to conform
> > to the standard.
>
> Any messing with the locking in ceph_fill_trace() would have to come
> with very detailed proof of correctness, convincingly stable wrt
> future changes in ceph...

OK. What do you have to say about this statement?

    Because fsnotify_nameremove() is called from d_delete() with negative
    or unhashed dentry, d_move() is not expected on this dentry, so it is
    safe to use d_parent/d_name without take_dentry_name_snapshot().

I assume it is not correct, but cannot figure out why.
Under what circumstances is d_move() expected to move an unhashed
dentry and hash it?

If this is not expected then wouldn't we be better off with:
@@ -2774,9 +2774,9 @@ static void __d_move(struct dentry *dentry,
struct dentry *target,

        /* unhash both */
-       if (!d_unhashed(dentry))
+       if (!WARN_ON(d_unhashed(dentry)))
                ___d_drop(dentry);
-       if (!d_unhashed(target))
+       if (!WARN_ON(d_unhashed(target)))
                ___d_drop(target);

And then we can get rid of take_dentry_name_snapshot() in fsnotify_nameremove()
and leave an assertion instead:

+       /* Proof of stability of d_parent and d_name */
+       WARN_ON_ONCE(d_inode(dentry) && !d_unhashed(dentry));
+

My other thought is why is fsnotify_nameremove() in d_delete() and
not in vfs_unlink()/vfs_rmdir() under parent inode lock like the rest
of the fsnotify_create/fsnotify_move hooks?

In what case would we need the fsnotify event that is not coming
from vfs_unlink()/vfs_rmdir()?

Thanks,
Amir.
