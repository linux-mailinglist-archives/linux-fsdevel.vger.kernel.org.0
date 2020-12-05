Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43D2CFB9F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 15:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgLEO45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 09:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLEOxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:53:08 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E90DC02B8F4;
        Sat,  5 Dec 2020 06:51:21 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z136so8896597iof.3;
        Sat, 05 Dec 2020 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6NQ9ycamfVAHPSF5hrisg0pA0mvJ+mft6vLxWBd6ec=;
        b=Ykzaa6G36yvI6S6WhkxCfe+8kGWMQLZsEiXDoX0LVygALOi/mOhsFeIa3kNvg/svHQ
         LScV163iipg3Z13VnW/1qmOQNjOBR7+924M7sEWFXMW/Kky5g3tvI7HqNLKBOCciCKIQ
         iuXzhd/rp4Suu2YrvwZUhmspcjepbfkTn2Xbk1G9RyuH2wsBHcenw/A49Zi9YOORAgZv
         4etI9j9Iu0HScv7xKLqKQBGCHthq/AAGpH2BnQCs4R3dDj2VPIfZgdafrSkfLoUH91cS
         Nnf37HuVbULxQptpS6njOCdYJuCb52xcXAkbIWDQQs0LIXWEV98xk4C1V3VTlyTCvPUG
         mcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6NQ9ycamfVAHPSF5hrisg0pA0mvJ+mft6vLxWBd6ec=;
        b=ULlJfExZofnxBeBrW7AQ4mZA1zQ7W9iBdkn5o69O78QHsghEFFmG6Xq9Yyv91W5wWo
         TgJt8cLdZwmE+urFSCi5/iTcriYsNojs75rQtH5fWwSUFK030SsQoJDK2WI+Tck3weFN
         DtpB9/p76uOD8nJv8odnbez31A5WZpQcPEHLQYjeHT0+ELv7LXhZTHu/fp8nUB8uD+4S
         SijWn7IiS4NzdzpAmji/Soow1P7u86Hn/MbMT9wg24a7xMhqzSEYaC2a4OSZ/VZGm+hD
         qcTU9OkDAeLXqrEbpS6Yt8NPeilkHPLz78WU85dZy7NhBWvbfOTDa95aUDuRmx0Ptyxz
         O9Zg==
X-Gm-Message-State: AOAM530yV63UDRlxlqqCLbLy+FhsFGimeH8djr0XynYEoCmH4DVPIAJi
        JaodE+1BueU9yBYQq2CqjpCc/kUhrNs2d/D/UQ8=
X-Google-Smtp-Source: ABdhPJw3PNkTAx+EM2gJMInq6sThR2pJBiyBwrpBkA6Zw8bmnZrE4m8ErIHgc4hncmUkZr1FVPbO0dwyU5B/SkGDSO0=
X-Received: by 2002:a05:6602:1608:: with SMTP id x8mr11110479iow.72.1607179880992;
 Sat, 05 Dec 2020 06:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-5-sargun@sargun.me>
 <20201130191509.GC14328@redhat.com> <CAOQ4uxjeG4N7i95D+YFr0zo82nLOjUCdUhD8e1WABFtwtQYzrQ@mail.gmail.com>
 <5468a450ac7e9626af1a61a29ef17a6855d6692f.camel@redhat.com>
In-Reply-To: <5468a450ac7e9626af1a61a29ef17a6855d6692f.camel@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 5 Dec 2020 16:51:09 +0200
Message-ID: <CAOQ4uxgHKqLjMV2nD5vOfAHbef+geso25DfqG3hu-PWyc25b9Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 5, 2020 at 3:51 PM Jeff Layton <jlayton@redhat.com> wrote:
>
> On Sat, 2020-12-05 at 11:13 +0200, Amir Goldstein wrote:
> > On Mon, Nov 30, 2020 at 9:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Fri, Nov 27, 2020 at 01:20:58AM -0800, Sargun Dhillon wrote:
> > > > Volatile remounts validate the following at the moment:
> > > >  * Has the module been reloaded / the system rebooted
> > > >  * Has the workdir been remounted
> > > >
> > > > This adds a new check for errors detected via the superblock's
> > > > errseq_t. At mount time, the errseq_t is snapshotted to disk,
> > > > and upon remount it's re-verified. This allows for kernel-level
> > > > detection of errors without forcing userspace to perform a
> > > > sync and allows for the hidden detection of writeback errors.
> > > >
> > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > Cc: linux-fsdevel@vger.kernel.org
> > > > Cc: linux-unionfs@vger.kernel.org
> > > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > ---
> > > >  fs/overlayfs/overlayfs.h | 1 +
> > > >  fs/overlayfs/readdir.c   | 6 ++++++
> > > >  fs/overlayfs/super.c     | 1 +
> > > >  3 files changed, 8 insertions(+)
> > > >
> > > > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > > > index de694ee99d7c..e8a711953b64 100644
> > > > --- a/fs/overlayfs/overlayfs.h
> > > > +++ b/fs/overlayfs/overlayfs.h
> > > > @@ -85,6 +85,7 @@ struct ovl_volatile_info {
> > > >        */
> > > >       uuid_t          ovl_boot_id;    /* Must stay first member */
> > > >       u64             s_instance_id;
> > > > +     errseq_t        errseq; /* Implemented as a u32 */
> > > >  } __packed;
> > > >
> > > >  /*
> > > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > > > index 7b66fbb20261..5795b28bb4cf 100644
> > > > --- a/fs/overlayfs/readdir.c
> > > > +++ b/fs/overlayfs/readdir.c
> > > > @@ -1117,6 +1117,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > +     err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> > > > +     if (err) {
> > > > +             pr_debug("Workdir filesystem reports errors: %d\n", err);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > >       return 1;
> > > >  }
> > > >
> > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > index a8ee3ba4ebbd..2e473f8c75dd 100644
> > > > --- a/fs/overlayfs/super.c
> > > > +++ b/fs/overlayfs/super.c
> > > > @@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
> > > >       int err;
> > > >       struct ovl_volatile_info info = {
> > > >               .s_instance_id = volatiledir->d_sb->s_instance_id,
> > > > +             .errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),
> > >
> > > errse_sample() seems to return 0 if nobody has seen the error yet. That
> > > means on remount we will fail. It is a false failure from our perspective
> > > and we are not interested in knowing if somebody else has seen the
> > > failure or not.
> > >
> > > Maybe we need a flag in errseq_sample() to get us current value
> > > irrespective of the fact whether anybody has seen the error or not?
> > >
> > > If we end up making this change, then we probably will have to somehow
> > > mask ERRSEQ_SEEN bit in errseq_check() comparison. Because if we
> > > sampled ->s_wb_err when nobody saw it and later by the remount time
> > > say ERRSEQ_SEEN is set, we don't want remount to fail.
> > >
> >
> > Hopping back to this review, looks like for volatile mount we need
> > something like (in this order):
> > 1. check if re-use and get sampled errseq from volatiledir xattr
> > 2. otherwise errseq_sample() upper_sb and store in volatiledir xattr
>
> I'm not sure I follow. Why does this need to go into an xattr?
>
> errseq_t is never persisted on stable storage. It's an entirely
> in-memory thing.
>

We know, but that was the purpose of this patch series [1].
Reusing volatile overlay layers is not allowed in v5.9.
Sargun is trying to allow that by verifying that since the first volatile
mount there was:
* no reboot
* no overlay module reload
* no underlying fs re-mount
* [and with this patch] no writeback error on upper fs

[1] https://lore.kernel.org/linux-unionfs/20201127092058.15117-1-sargun@sargun.me/T/#mb2f1c770a47898d8781e62a46fcc7526535e5dde

>
> > 3. errseq_check() since stored or sampled errseq (0 for fresh mount
> > with unseen error)
> > 4. fail volatile mount if errseq_check() failed
> > 5. errseq_check() since stored errseq on fsync()/syncfs()
> >
>
> I think this is simpler than that. You just need a new errseq_t helper
> that only conditionally samples if the thing is 0 or if the error has
> already been seen. Something like this (hopefully with a better name):
>
> bool errseq_sample_no_unseen(errseq_t *eseq, errseq_t *sample)
> {
>         errseq_t old = READ_ONCE(*eseq);
>
>         if (old && !(old & ERRSEQ_SEEN))
>                 return false;
>         *sample = old;
>         return true;
> }
>
> If that returns false, fail the mount. If it's true, then save off the
> sample and proceed.
>

Yes, but that wasn't the purpose of the original patch set,
it was just something else that needed fixing that we found during
review of this patch for which Sargun posted a separate patch.

Thank,
Amir.
