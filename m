Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24C94C8A24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 11:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiCAK6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 05:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiCAK5u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:57:50 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E890CFE;
        Tue,  1 Mar 2022 02:57:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m185so17964603iof.10;
        Tue, 01 Mar 2022 02:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Loh7bdYNX/I5LM6DgutE9O2JeFz/enkY0xHKKq5rGk0=;
        b=f6ajJnJOJgM/5JcG5ttKjr34OgR0RfRHsBfbeVF1+Dj5GC8XhpoulPztYtebksjlIX
         r0XcZe410mOeHsOrHo7jkFAJZzQ/hKKJOR8QjND1Q2FotxQkn4RGi76zQ4tf5kJdFDDu
         +RxKrbatqxPpwpBVv87rafKxRImXdcAp+DwSdcZvE/UEtOXOjR7djhUoCSNQudSgKMUv
         VBLfZq+nXGUQAya1B0iVkSDUP/gmA5sw1Ctx+dq2ueK2y9AOpEeZGGmotaK5psD16X2O
         QBVux4lhoL1C0xifpZ9Ahn3pThTKE/sJOut84+IOMowOs3njn5M7Ry4BHFQOeAExZN0P
         t/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Loh7bdYNX/I5LM6DgutE9O2JeFz/enkY0xHKKq5rGk0=;
        b=zi66aDNYnBWrQ5MUxXm3wadGo861NqSLmommt+IWTM4jlOt9de7q+/iSjNch4AQTs2
         XZCirgp43PyjFDCsQi/LM9ePHrjp2TwvX633HNxwxmLPNP5XvE2mZ/gyWC76vfeC10K+
         2GW6B29ZHtpv2W/8Z5hXbsi6xL+rIqid4kUCWUX+MXt0dq2npFDPMecUhcdVhf1z9sQ9
         PwnJlA7hsBDx2n/UrEBib0UaEci9UX0lw9MInhsBRXZ5cDQ/iqEothrfxcQtp0zofDI2
         2ipFZ/dg7jrD5W56cKPtCEzi+YF0CibHHvF4QZroffSSGRgfzHemSkvMugeXQ1YCNB+G
         o8xA==
X-Gm-Message-State: AOAM530wj7i8Ja175AI73Cp+qkB5WGAGF1GxgoH3xRpcCtnaIR6x28q6
        3C3ZWr4iyyEIBAk5yyLbcRgijAnsISgXDh/T7YDG2XpiVJg=
X-Google-Smtp-Source: ABdhPJzcozKmQtDtbv3zVoWlNydsST/3QVj++U3+KcR8jnzg5AFKVL+304v4XrYxw1o9HuSCeWHWLpdu0A0fqr4KHYE=
X-Received: by 2002:a02:a1c7:0:b0:314:cc99:3c4f with SMTP id
 o7-20020a02a1c7000000b00314cc993c4fmr20338776jah.53.1646132229437; Tue, 01
 Mar 2022 02:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20220228113910.1727819-1-amir73il@gmail.com> <20220228113910.1727819-5-amir73il@gmail.com>
 <20220228211113.GB3927073@dread.disaster.area> <CAOQ4uxjPHxO+S3tOarO5w_rBwyFTgd7oMcC4f5xW7opCWb4LVQ@mail.gmail.com>
 <20220301094640.GD3927073@dread.disaster.area>
In-Reply-To: <20220301094640.GD3927073@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Mar 2022 12:56:58 +0200
Message-ID: <CAOQ4uxi_J3xfJfpCXSG0g3PhiMQgAwP6dxLD18O-UJD0mMGjHg@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 11:46 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Feb 28, 2022 at 11:57:19PM +0200, Amir Goldstein wrote:
> > On Mon, Feb 28, 2022 at 11:11 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Feb 28, 2022 at 01:39:08PM +0200, Amir Goldstein wrote:
> > > > Show optional collected per-mount io stats in /proc/<pid>/mountstats
> > > > for filesystems that do not implement their own show_stats() method
> > > > and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/mount.h          |  1 +
> > > >  fs/namespace.c      |  2 ++
> > > >  fs/proc_namespace.c | 13 +++++++++++++
> > > >  3 files changed, 16 insertions(+)
> > > >
> > > > diff --git a/fs/mount.h b/fs/mount.h
> > > > index f98bf4cd5b1a..2ab6308af78b 100644
> > > > --- a/fs/mount.h
> > > > +++ b/fs/mount.h
> > > > @@ -91,6 +91,7 @@ struct mount {
> > > >       int mnt_id;                     /* mount identifier */
> > > >       int mnt_group_id;               /* peer group identifier */
> > > >       int mnt_expiry_mark;            /* true if marked for expiry */
> > > > +     time64_t mnt_time;              /* time of mount */
> > > >       struct hlist_head mnt_pins;
> > > >       struct hlist_head mnt_stuck_children;
> > > >  } __randomize_layout;
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index 3fb8f11a42a1..546f07ed44c5 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -220,6 +220,8 @@ static struct mount *alloc_vfsmnt(const char *name)
> > > >               mnt->mnt_count = 1;
> > > >               mnt->mnt_writers = 0;
> > > >  #endif
> > > > +             /* For proc/<pid>/mountstats */
> > > > +             mnt->mnt_time = ktime_get_seconds();
> > > >
> > > >               INIT_HLIST_NODE(&mnt->mnt_hash);
> > > >               INIT_LIST_HEAD(&mnt->mnt_child);
> > > > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > > > index 49650e54d2f8..d744fb8543f5 100644
> > > > --- a/fs/proc_namespace.c
> > > > +++ b/fs/proc_namespace.c
> > > > @@ -232,6 +232,19 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
> > > >       if (sb->s_op->show_stats) {
> > > >               seq_putc(m, ' ');
> > > >               err = sb->s_op->show_stats(m, mnt_path.dentry);
> > > > +     } else if (mnt_has_stats(mnt)) {
> > > > +             /* Similar to /proc/<pid>/io */
> > > > +             seq_printf(m, "\n"
> > > > +                        "\ttimes: %lld %lld\n"
> > > > +                        "\trchar: %lld\n"
> > > > +                        "\twchar: %lld\n"
> > > > +                        "\tsyscr: %lld\n"
> > > > +                        "\tsyscw: %lld\n",
> > > > +                        r->mnt_time, ktime_get_seconds(),
> > > > +                        mnt_iostats_counter_read(r, MNTIOS_CHARS_RD),
> > > > +                        mnt_iostats_counter_read(r, MNTIOS_CHARS_WR),
> > > > +                        mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_RD),
> > > > +                        mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_WR));
> > >
> > > This doesn't scale as {cpus, mounts, counters, read frequency}
> > > matrix explodes.  Please iterate the per-mount per cpu counters
> > > once, adding up all counters in one pass to an array on stack, then
> > > print them all from the array.
> >
> > I am planning to move to per-sb iostats and was thinking of using
> > an array of 4 struct percpu_counter. That will make this sort of iteration
> > more challenging.
>
> No, it would get rid of it entirely. percpu_counter_read_positive()
> does not require any summing at all - that's a much better solution
> than a hand rolled set of percpu counters. Please do this.
>
> > Do you really think the read frequency of /proc/self/mountstats
> > warrants such performance optimization?
>
> We get bug reports every so often about the overhead of frequently
> summing per-cpu stats on large systems. Nothing ratelimits or
> restricts access to /proc/self/mountstats, so when you have a
> thousand CPUs and a million monkeys...
>
> Rule of thumb: don't do computationally expensive things to generate
> data for globally accessible sysfs files.
>
> > It's not like the case of the mighty struct xfsstats.
> > It is only going to fold 4 per cpu iterations into 1.
> > This doesn't look like a game changer to me.
> > Am I missing something?
>
> I'm just pointing out something we've had problems with in
> the past and are trying to help you avoid making the same mistakes.
> That's what reviewers are supposed to do, yes?

Yes, thank you :)

Amir.
