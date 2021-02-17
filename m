Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1CD31D765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 11:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhBQKPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 05:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhBQKOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:14:23 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5AC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 02:13:43 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id f6so13240730ioz.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKfxMFVu6wM5TmVRPOZl4AFQkSSRjyFUCSD1V+/6/3g=;
        b=Agb1X8wmEadoKF89mMXp0oxNBBfRmwKeQNdzBCLuYgP8bnfveqqkMHlZEjcLQm2taG
         777B0q4P+0hc607Bi8q9URwogFq0p7bXE9qpd/vikjIwoQynjxeSQXhcMrFDu0Mx8rQ3
         av/Mt5q63iPFbohHyNuPpeXr32yUSJxIIrbsM0yXJKIVukFikkZvwwtKBVUDJuFCUiif
         GgV4+jjnUcUbsSeAOeNVGd0zGtYhvbyhASuoDeAQKJJPOCIkN4CB+HSCmmNaXeEs0hPE
         mwOm3gzUbjg4vxAq5M0WDHVj2qWSVwOOLellcgdklRRzNr8DfvBGsx9khyPpr6xt/4aI
         1RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKfxMFVu6wM5TmVRPOZl4AFQkSSRjyFUCSD1V+/6/3g=;
        b=jIDcZ8V69Mov7RRTKcXEJSNx3Qk4nPrwjIqalx7/+uVd4DNFt/JLWtxvJsP5vCl/ul
         SGhrubV/mYE+iSc6G1+qkEgyBUJNAbkVsaN8BTI+IVf5d4VLw2ooj8T89S2FJmffghq/
         fU6WU5dd3TW3QKzEd08EujVxeV8IMRCDOLteu4D4fDG0SnFqJ9Varh8fXhG8i0UTHjaI
         lJpD9gF2ovRDQdOKFZa2+UyR6AwCrDSLeqUNd1gouyiJktIF/dtPJ1iMrM1lAeJcczv/
         Zgy0eDCXBuee5KXrVuTk2DPis9E44qYOzShlGWhsHbo6wE0EKAWQJys+1fz0Lm/LVOSu
         ASxQ==
X-Gm-Message-State: AOAM530SjuaDtzrS6xjJOeKAlzLsWcSMovRKBGvuzWgXHVp5x1t8Oj72
        9TkSDKLRAyEI8kXuU9356VAP+IHiNoXzMEWyMA4V0TO8/mY=
X-Google-Smtp-Source: ABdhPJx+fCHvYgQ/Q4OZsdWUFMO0V/fdhwKoTxyL9kxplKABD3qC8OACTOTTGTiFr7sxY0WT92mgVlLQjRINsMcKIXg=
X-Received: by 2002:a05:6602:2c52:: with SMTP id x18mr20374991iov.5.1613556822919;
 Wed, 17 Feb 2021 02:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20210202162010.305971-1-amir73il@gmail.com> <20210202162010.305971-7-amir73il@gmail.com>
 <20210216153943.GD21108@quack2.suse.cz>
In-Reply-To: <20210216153943.GD21108@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 17 Feb 2021 12:13:31 +0200
Message-ID: <CAOQ4uxhpJ=pNsKTpRwGYUancosdLRNaf596he4Ykmd8u=fPFBw@mail.gmail.com>
Subject: Re: [PATCH 6/7] fanotify: mix event info into merge key hash
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 5:39 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 02-02-21 18:20:09, Amir Goldstein wrote:
> > Improve the balance of hashed queue lists by mixing more event info
> > relevant for merge.
> >
> > For example, all FAN_CREATE name events in the same dir used to have the
> > same merge key based on the dir inode.  With this change the created
> > file name is mixed into the merge key.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c | 33 +++++++++++++++++++++++++++------
> >  fs/notify/fanotify/fanotify.h | 20 +++++++++++++++++---
> >  2 files changed, 44 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 6d3807012851..b19fef1c6f64 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> ...
> > @@ -476,8 +485,11 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
> >
> >       ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
> >       ffe->fsid = *fsid;
> > -     fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
> > -                        gfp);
> > +     fh = &ffe->object_fh;
> > +     fanotify_encode_fh(fh, id, fanotify_encode_fh_len(id), gfp);
> > +
> > +     /* Mix fsid+fid info into event merge key */
> > +     ffe->fae.info_hash = full_name_hash(ffe->fskey, fanotify_fh_buf(fh), fh->len);
>
> Is it really sensible to hash FID with full_name_hash()? It would make more
> sense to treat it as binary data, not strings...

See the actual implementation of full_name_hash() for 64bit.
it treats the string as an array of ulong, which is quite perfect for FID.

>
> >       return &ffe->fae;
> >  }
> > @@ -517,6 +529,9 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> >       if (file_name)
> >               fanotify_info_copy_name(info, file_name);
> >
> > +     /* Mix fsid+dfid+name+fid info into event merge key */
> > +     fne->fae.info_hash = full_name_hash(fne->fskey, info->buf, fanotify_info_len(info));
> > +
>
> Similarly here...
>
> >       pr_debug("%s: ino=%lu size=%u dir_fh_len=%u child_fh_len=%u name_len=%u name='%.*s'\n",
> >                __func__, id->i_ino, size, dir_fh_len, child_fh_len,
> >                info->name_len, info->name_len, fanotify_info_name(info));
> > @@ -539,6 +554,8 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >       struct mem_cgroup *old_memcg;
> >       struct inode *child = NULL;
> >       bool name_event = false;
> > +     unsigned int hash = 0;
> > +     struct pid *pid;
> >
> >       if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
> >               /*
> > @@ -606,13 +623,17 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >        * Use the victim inode instead of the watching inode as the id for
> >        * event queue, so event reported on parent is merged with event
> >        * reported on child when both directory and child watches exist.
> > -      * Reduce object id to 32bit hash for hashed queue merge.
> > +      * Reduce object id and event info to 32bit hash for hashed queue merge.
> >        */
> > -     fanotify_init_event(event, hash_ptr(id, 32), mask);
> > +     hash = event->info_hash ^ hash_ptr(id, 32);
> >       if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> > -             event->pid = get_pid(task_pid(current));
> > +             pid = get_pid(task_pid(current));
> >       else
> > -             event->pid = get_pid(task_tgid(current));
> > +             pid = get_pid(task_tgid(current));
> > +     /* Mix pid info into event merge key */
> > +     hash ^= hash_ptr(pid, 32);
>
> hash_32() here?

I don't think so.
hash_32() looses the high bits of ptr before mixing them.
hash_ptr(pid, 32) looses the *low* bits which contain less entropy
after mixing all 64bits of ptr.

>
> > +     fanotify_init_event(event, hash, mask);
> > +     event->pid = pid;
> >
> >  out:
> >       set_active_memcg(old_memcg);
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > index 2e856372ffc8..522fb1a68b30 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -115,6 +115,11 @@ static inline void fanotify_info_init(struct fanotify_info *info)
> >       info->name_len = 0;
> >  }
> >
> > +static inline unsigned int fanotify_info_len(struct fanotify_info *info)
> > +{
> > +     return info->dir_fh_totlen + info->file_fh_totlen + info->name_len;
> > +}
> > +
> >  static inline void fanotify_info_copy_name(struct fanotify_info *info,
> >                                          const struct qstr *name)
> >  {
> > @@ -138,7 +143,10 @@ enum fanotify_event_type {
> >  };
> >
> >  struct fanotify_event {
> > -     struct fsnotify_event fse;
> > +     union {
> > +             struct fsnotify_event fse;
> > +             unsigned int info_hash;
> > +     };
> >       u32 mask;
> >       enum fanotify_event_type type;
> >       struct pid *pid;
>
> How is this ever safe? info_hash will likely overlay with 'list' in
> fsnotify_event.

Oh yeh. That's an ugly hack. Sorry for that.
I wanted to avoid adding an arg unsigned int *info_hash to all
fanotify_alloc_*_event() helpers, so I used this uninitialized space
in event instead.
I'll do it the proper way.

>
> > @@ -154,7 +162,10 @@ static inline void fanotify_init_event(struct fanotify_event *event,
> >
> >  struct fanotify_fid_event {
> >       struct fanotify_event fae;
> > -     __kernel_fsid_t fsid;
> > +     union {
> > +             __kernel_fsid_t fsid;
> > +             void *fskey;    /* 64 or 32 bits of fsid used for salt */
> > +     };
> >       struct fanotify_fh object_fh;
> >       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> >       unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
> > @@ -168,7 +179,10 @@ FANOTIFY_FE(struct fanotify_event *event)
> >
> >  struct fanotify_name_event {
> >       struct fanotify_event fae;
> > -     __kernel_fsid_t fsid;
> > +     union {
> > +             __kernel_fsid_t fsid;
> > +             void *fskey;    /* 64 or 32 bits of fsid used for salt */
> > +     };
> >       struct fanotify_info info;
> >  };
>
> What games are you playing here with the unions? I presume you can remove
> these 'fskey' unions and just use (void *)(event->fsid) at appropriate
> places? IMO much more comprehensible...

Ok.

Thanks,
Amir.
