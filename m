Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E125213B1A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgANSHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:07:08 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:41209 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgANSHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:07:08 -0500
Received: by mail-il1-f177.google.com with SMTP id f10so12303605ils.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7taV2PMFxE6hbl4m/aLoPpruKZEdd6Ozy/+oVuhDci0=;
        b=DstH4UKT+gSGau6cfMfXt+9VHsK0jGftB9Oai3BXwK70RSO9DyIn9Oj4MjckE1zNaa
         R6QSHDAW7LyliwpkvQir6NiYSlFrwKpKysnj4UaoyOTJXb7e2q5o3yd9vqfwY1m8jzLq
         D9/hZB7FRbHAC+4UGvGe/ShxYwIjw3a1+jO8Erpeq4JzNhW6ugizvw3IkRvt+FBIKSLj
         RR6Y6GFqi4IDUeXVQ0cs0ad+B2d6fcfHs5YqdjCUxyq3W0e5Q7Bv/ge1/kGS+Y6GKh/5
         jWVVDgkQJ92qk6GvE6m3hdaCOf48zxJQPPETj7a+G1jKP3X9pMF4MkcTnZ5KTbxXWoxH
         v9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7taV2PMFxE6hbl4m/aLoPpruKZEdd6Ozy/+oVuhDci0=;
        b=fQqSbqlqF7Y+oletRuOqZQ3gKAva5/BPxYPuCEc8qLw0cIFzkcYM0ORKieSdqF4pCq
         FcP4rmKOCtzMyEg0ZCbvjqLnGWumvu6E36jP5Q6TW3R8i2UAHknvCtpQHah2oT7R3/bU
         qr2nNUV+IUasyJ2InkNMMwQCHUXrSclHtrC+0vLvAdd1Y5REpPFZDLGgaXJYPXd7b+0e
         yL9VAYJBGs1a60+ds3rYRkpQVWu/fxMWbL1YuGkcAI4jGxDRqTRoFE5pt4ypvt+M/DeT
         xTdG1ZwriGjfwm/AoIUmjK6O8YHNL97f9hxAcjQ4V64hUgVBxEtXq+Kv7oO2v0R25l8D
         FBkQ==
X-Gm-Message-State: APjAAAXxjcMtn0XjH5d2YU+ZpF5+IA+GWPFLVxe2H5rpFpOTInqBGZKE
        nnQ7Qm8IMX+0zlbtohoAg++Ai506ItV/T/vWYnsthWcw
X-Google-Smtp-Source: APXvYqy/4UoRvLzzJj/t7GygB015VPGJBjsID5Y9R5g31A28EBSexrF3FlTdUg6+BqISg6CJFdEuTfJUVJm/Gi4ueXo=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr4635427ili.72.1579025227904;
 Tue, 14 Jan 2020 10:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20200114154034.30999-1-amir73il@gmail.com> <20200114162234.GZ8904@ZenIV.linux.org.uk>
In-Reply-To: <20200114162234.GZ8904@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jan 2020 20:06:56 +0200
Message-ID: <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com>
Subject: Re: dcache: abstract take_name_snapshot() interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 6:22 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jan 14, 2020 at 05:40:34PM +0200, Amir Goldstein wrote:
> > Generalize the take_name_snapshot()/release_name_snapshot() interface
> > so it is possible to snapshot either a dentry d_name or its snapshot.
> >
> > The order of fields d_name and d_inode in struct dentry is swapped
> > so d_name is adjacent to d_iname.  This does not change struct size
> > nor cache lines alignment.
> >
> > Currently, we snapshot the old name in vfs_rename() and we snapshot the
> > snapshot the dentry name in __fsnotify_parent() and then we pass qstr
> > to inotify which allocated a variable length event struct and copied the
> > name.
> >
> > This new interface allows us to snapshot the name directly into an
> > fanotify event struct instead of allocating a variable length struct
> > and copying the name to it.
>
> Ugh...  That looks like being too damn cute for no good reason.  That
> trick with union is _probably_ safe, but I wouldn't bet a dime on
> e.g. randomize_layout crap not screwing it over in random subset of
> gcc versions.  You are relying upon fairly subtle reading of 6.2.7
> and it feels like just the place for layout-mangling plugins to fuck
> up.
>
> With -fplan9-extensions we could go for renaming struct name_snapshot
> fields and using an anon member in struct dentry -
>         ...
>         struct inode *d_inode;
>         struct name_snapshot;   // d_name and d_iname
>         struct lockref d_lockref;
>         ...
>
> but IMO it's much safer to have an explicit
>
> // NOTE: release_dentry_name_snapshot() will be needed for both copies.
> clone_name_snapshot(struct name_snapshot *to, const struct name_snapshot *from)
> {
>         to->name = from->name;
>         if (likely(to->name.name == from->inline_name)) {
>                 memcpy(to->inline_name, from->inline_name,
>                         to->name.len);
>                 to->name.name = to->inline_name;
>         } else {
>                 struct external_name *p;
>                 p = container_of(to->name.name, struct external_name, name[0]);
>                 atomic_inc(&p->u.count);
>         }
> }
>
> and be done with that.  Avoids any extensions or tree-wide renamings, etc.

I started with something like this but than in one of the early
revisions I needed
to pass some abstract reference around before cloning the name into the event,
but with my current patches I can get away with a simple:

if (data_type == FANOTIFY_EVENT_NAME)
    clone_name_snapshot(&event->name, data);
else if (dentry)
    take_dentry_name_snapshot(&event->name, dentry);

So that simple interface should be good enough for my needs.

Thanks,
Amir.
