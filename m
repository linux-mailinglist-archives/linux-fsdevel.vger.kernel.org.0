Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F754C7C8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 22:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiB1V6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 16:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiB1V6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:58:11 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFBF1E3D0;
        Mon, 28 Feb 2022 13:57:31 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h16so16338755iol.11;
        Mon, 28 Feb 2022 13:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xf4uBhhIfQHVx53ho/xTmpxUaDsjAI9m8Hj30e+skGc=;
        b=Y6+Logc2zBCIyJE3KzDomF2MV4Dbe7WAM4QvT08NJcqXn1pY0wWBEheV5ZMmpSVDPO
         nNZBVl1vXboi+78HGHlm2axbj58NbOly1YGVP3P7TmKzE9Eg0iyqzejsCPWDqhK7FPIo
         I+C4CfBNQTGLx99L2GphGQ0GkiCJQYbDQoIyLlEv8Nvm2tZgRnoKUPmUYbg0zGnGAEdp
         DKGDXF2cFUijgy7Hprghpao6D3abP1HWsfn4sDKU5vrFGeQlIoSZqVf0dN2scCunPEK/
         P+3OXAQNiSj3pRPW7WKxXdvZN/N0KBhT+78sUTDUy29O2YDaoGNlcMkSVXg0W/tBOK1t
         Nelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xf4uBhhIfQHVx53ho/xTmpxUaDsjAI9m8Hj30e+skGc=;
        b=ZYHhWuPcrSIMyaDaQnLwahreIMMRH1tWahDqRNt0NS6VLRkr6HsTHdhatof7uBl53q
         8oGiY1iW5dztJrqRCfXWPpPf2cXJ9luAwkpLZ2s7m99ZQIjzLSMeIPfF7/vyav89cMNI
         HzIgjW4L1Uratx300YPJByZ2JU/cLdXbSGXplbxeibZ/AymgWYGnwWm0St4Woo7zeF6C
         pArVyBtyMVswzsKMXDRrtwrIv//+mPVv9HvfShX3THxyiooMAaJ5mg1Ohzt5iByOXQ2A
         LHJmKuGa4NoKuc/YdfSKyCke7HPhoVLfCnNZL3eIGiPk5TXh6bvsglF+wRnxXM2h+zNk
         Pzww==
X-Gm-Message-State: AOAM53170wEoPaPXRyWgIyX7GWLdgmKQ5GuVUyVnfHEnhQKuH3wlSsTE
        9YXo4q73rIC2LUsfPYbS/FN5kVHhNv4r2AIXiMFpWUEpQdI=
X-Google-Smtp-Source: ABdhPJym/U0tkp+DoUcf2t/SPX3ZBBoSc4j+hwaUEIMi00iKKzffQT96aocNZlp5TKUfUzWxWpHKGlQYvc+OsO0ofiU=
X-Received: by 2002:a5d:8f98:0:b0:640:dedf:63ed with SMTP id
 l24-20020a5d8f98000000b00640dedf63edmr16776426iol.52.1646085450109; Mon, 28
 Feb 2022 13:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20220228113910.1727819-1-amir73il@gmail.com> <20220228113910.1727819-5-amir73il@gmail.com>
 <20220228211113.GB3927073@dread.disaster.area>
In-Reply-To: <20220228211113.GB3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 28 Feb 2022 23:57:19 +0200
Message-ID: <CAOQ4uxjPHxO+S3tOarO5w_rBwyFTgd7oMcC4f5xW7opCWb4LVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fs: report per-mount io stats
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        containers@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:11 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Feb 28, 2022 at 01:39:08PM +0200, Amir Goldstein wrote:
> > Show optional collected per-mount io stats in /proc/<pid>/mountstats
> > for filesystems that do not implement their own show_stats() method
> > and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/mount.h          |  1 +
> >  fs/namespace.c      |  2 ++
> >  fs/proc_namespace.c | 13 +++++++++++++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/fs/mount.h b/fs/mount.h
> > index f98bf4cd5b1a..2ab6308af78b 100644
> > --- a/fs/mount.h
> > +++ b/fs/mount.h
> > @@ -91,6 +91,7 @@ struct mount {
> >       int mnt_id;                     /* mount identifier */
> >       int mnt_group_id;               /* peer group identifier */
> >       int mnt_expiry_mark;            /* true if marked for expiry */
> > +     time64_t mnt_time;              /* time of mount */
> >       struct hlist_head mnt_pins;
> >       struct hlist_head mnt_stuck_children;
> >  } __randomize_layout;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 3fb8f11a42a1..546f07ed44c5 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -220,6 +220,8 @@ static struct mount *alloc_vfsmnt(const char *name)
> >               mnt->mnt_count = 1;
> >               mnt->mnt_writers = 0;
> >  #endif
> > +             /* For proc/<pid>/mountstats */
> > +             mnt->mnt_time = ktime_get_seconds();
> >
> >               INIT_HLIST_NODE(&mnt->mnt_hash);
> >               INIT_LIST_HEAD(&mnt->mnt_child);
> > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > index 49650e54d2f8..d744fb8543f5 100644
> > --- a/fs/proc_namespace.c
> > +++ b/fs/proc_namespace.c
> > @@ -232,6 +232,19 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
> >       if (sb->s_op->show_stats) {
> >               seq_putc(m, ' ');
> >               err = sb->s_op->show_stats(m, mnt_path.dentry);
> > +     } else if (mnt_has_stats(mnt)) {
> > +             /* Similar to /proc/<pid>/io */
> > +             seq_printf(m, "\n"
> > +                        "\ttimes: %lld %lld\n"
> > +                        "\trchar: %lld\n"
> > +                        "\twchar: %lld\n"
> > +                        "\tsyscr: %lld\n"
> > +                        "\tsyscw: %lld\n",
> > +                        r->mnt_time, ktime_get_seconds(),
> > +                        mnt_iostats_counter_read(r, MNTIOS_CHARS_RD),
> > +                        mnt_iostats_counter_read(r, MNTIOS_CHARS_WR),
> > +                        mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_RD),
> > +                        mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_WR));
>
> This doesn't scale as {cpus, mounts, counters, read frequency}
> matrix explodes.  Please iterate the per-mount per cpu counters
> once, adding up all counters in one pass to an array on stack, then
> print them all from the array.

I am planning to move to per-sb iostats and was thinking of using
an array of 4 struct percpu_counter. That will make this sort of iteration
more challenging.

Do you really think the read frequency of /proc/self/mountstats
warrants such performance optimization?

It's not like the case of the mighty struct xfsstats.
It is only going to fold 4 per cpu iterations into 1.
This doesn't look like a game changer to me.
Am I missing something?

Thanks,
Amir.
