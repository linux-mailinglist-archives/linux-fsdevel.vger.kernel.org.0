Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE732CFAD3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgLEJ20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 04:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbgLEJXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 04:23:43 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D5C061A51;
        Sat,  5 Dec 2020 01:13:25 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id n14so8303665iom.10;
        Sat, 05 Dec 2020 01:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pPN7UPtT6pJjG7XMJVzwK80KCiuqM/7+qfCK3uEZntA=;
        b=t22m7PqMtNTzJhPfZzuOXb2kEljECEe2iqQ2Olmzt/VDu71xwDJob5LZ6LXKxHclsp
         G62/obD8cFlivAI6FiCzMtPdHwf6wRuvjp3kWehGCgNGN8yPmdM5BUQC2Hj5w3k/Jw2Y
         ++GI6e/QIFIosVPazvz8vOrZooRvBH3tudyfeivY6ZUZVTqdhQGTYlqPZgZD0gPE3/6b
         FFAAJrIPj0V0IjfLSbrygZRJ/AbHtubPiDlQQoAJmM3PbxR7zt4XTGEE4XJqhOGjHDG0
         I4e3zvzpViYf7XVNXkH7Q0t2ehb9IrJpwSryo7JAZNOT2OAKdXqkymU/GKGbKDEi1hXG
         /xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pPN7UPtT6pJjG7XMJVzwK80KCiuqM/7+qfCK3uEZntA=;
        b=YCq4TahD3DV5h49ygJa/GfFDoRCkQkvfdTZqaNzHx1RoFe5JPpaYxt5tSsOon+Peat
         d5rCuzA0XZkHmA0l45OOcjeYBcLhXuB/2oD7vzV7dy93owP7ISvgDa9orDZ1kPc7i+Ev
         Cgx4nPR6t/nZ6vWfnUTqLJ85w6o3az29ES6vhFHcbJ6b9xfNJB7uHGktCfY57nZDr1ki
         /TqPe5se9zV8pnffSlIFyP0nyYnMxqhby4pOIxPtguTo8D6YsnlaSrx874P1tXAdvZ+4
         WRwGOFLKUtyeGEZsDlzpeI3U88qcJPnU5g96F72MQKsddy19sExQr9IS10zj00Lgc0JL
         97EA==
X-Gm-Message-State: AOAM532CXGbdet290QfkP8D2gECJAfK/6ONsptdWzux4PmJJqTizRQhE
        NiitSh0bKM6LMmX3diY21RrAS/k3FP5zOkILcfk=
X-Google-Smtp-Source: ABdhPJzO1kNL+9qzYppuh3BSCu5zYYcgYegA6H8Z2sZldrGEiCj5r4d3+7Gbeh3L//mTw8ZetXHtiXedVIZsASBRfFs=
X-Received: by 2002:a6b:fd03:: with SMTP id c3mr10156175ioi.64.1607159604914;
 Sat, 05 Dec 2020 01:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-5-sargun@sargun.me>
 <20201130191509.GC14328@redhat.com>
In-Reply-To: <20201130191509.GC14328@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 5 Dec 2020 11:13:13 +0200
Message-ID: <CAOQ4uxjeG4N7i95D+YFr0zo82nLOjUCdUhD8e1WABFtwtQYzrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
To:     Vivek Goyal <vgoyal@redhat.com>, Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 9:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Nov 27, 2020 at 01:20:58AM -0800, Sargun Dhillon wrote:
> > Volatile remounts validate the following at the moment:
> >  * Has the module been reloaded / the system rebooted
> >  * Has the workdir been remounted
> >
> > This adds a new check for errors detected via the superblock's
> > errseq_t. At mount time, the errseq_t is snapshotted to disk,
> > and upon remount it's re-verified. This allows for kernel-level
> > detection of errors without forcing userspace to perform a
> > sync and allows for the hidden detection of writeback errors.
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/overlayfs/overlayfs.h | 1 +
> >  fs/overlayfs/readdir.c   | 6 ++++++
> >  fs/overlayfs/super.c     | 1 +
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > index de694ee99d7c..e8a711953b64 100644
> > --- a/fs/overlayfs/overlayfs.h
> > +++ b/fs/overlayfs/overlayfs.h
> > @@ -85,6 +85,7 @@ struct ovl_volatile_info {
> >        */
> >       uuid_t          ovl_boot_id;    /* Must stay first member */
> >       u64             s_instance_id;
> > +     errseq_t        errseq; /* Implemented as a u32 */
> >  } __packed;
> >
> >  /*
> > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > index 7b66fbb20261..5795b28bb4cf 100644
> > --- a/fs/overlayfs/readdir.c
> > +++ b/fs/overlayfs/readdir.c
> > @@ -1117,6 +1117,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> >               return -EINVAL;
> >       }
> >
> > +     err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> > +     if (err) {
> > +             pr_debug("Workdir filesystem reports errors: %d\n", err);
> > +             return -EINVAL;
> > +     }
> > +
> >       return 1;
> >  }
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index a8ee3ba4ebbd..2e473f8c75dd 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
> >       int err;
> >       struct ovl_volatile_info info = {
> >               .s_instance_id = volatiledir->d_sb->s_instance_id,
> > +             .errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),
>
> errse_sample() seems to return 0 if nobody has seen the error yet. That
> means on remount we will fail. It is a false failure from our perspective
> and we are not interested in knowing if somebody else has seen the
> failure or not.
>
> Maybe we need a flag in errseq_sample() to get us current value
> irrespective of the fact whether anybody has seen the error or not?
>
> If we end up making this change, then we probably will have to somehow
> mask ERRSEQ_SEEN bit in errseq_check() comparison. Because if we
> sampled ->s_wb_err when nobody saw it and later by the remount time
> say ERRSEQ_SEEN is set, we don't want remount to fail.
>

Hopping back to this review, looks like for volatile mount we need
something like (in this order):
1. check if re-use and get sampled errseq from volatiledir xattr
2. otherwise errseq_sample() upper_sb and store in volatiledir xattr
3. errseq_check() since stored or sampled errseq (0 for fresh mount
with unseen error)
4. fail volatile mount if errseq_check() failed
5. errseq_check() since stored errseq on fsync()/syncfs()

For fresh volatile mount, syncfs can fix the temporary mount error.
For re-used volatile mount, the mount error is permanent.

Did I miss anything?
Is the mount safe for both seen and unseen error cases? no error case?
Are we safe if a syncfs on upper_sb sneaks in between 2 and 3?

Thanks,
Amir.
