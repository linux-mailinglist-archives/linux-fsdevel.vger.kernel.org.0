Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1617B3BF8B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jul 2021 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhGHLMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jul 2021 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGHLMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:12:37 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB7EC061574;
        Thu,  8 Jul 2021 04:09:55 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w1so4232771ilg.10;
        Thu, 08 Jul 2021 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfAXaVLlEDvAAyz5Va+Gv8wCd6VdqhbJnOTraHfxGSM=;
        b=OttF/ZqTd3lL0V2CNP7dtfclx4RaVpCmyDLYlcbxEq4J4qeBbnZO2zbgSJ6YRh22Kq
         2TZphATVXukLb6zTJqNpFmgbGkVOboz88NRl0aadLg++EXeT9mUVMn8DGnvzh226ucNj
         6vofSop9pLNKMHrb5p0OPMGl4AEfw4jxeTuAOhO0099Em+4HfBfLDN/gtligOlEGe/dF
         Dx/GbCjCfRZnrrxs/MK+0+38+GtC6XA354bGLLi1uKR28Sm8jPGQUYfjfSnr9idXF/X7
         0bGTzuFH2IU5JAeU7yAGP+ulyprb58S2RS+IgqAxfS54SJKoLlS9yxSV16DwXx+LeJKH
         9uSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfAXaVLlEDvAAyz5Va+Gv8wCd6VdqhbJnOTraHfxGSM=;
        b=iMpDRHUZcMKYTPUozKqWuSbXZR4VL0UNnlDsJqWSif9fEqDzamR+5WGzjgOrfGmxVo
         d5qTEmO7m96H8sIQnC/q74T1Jli/th4Tkk9EBj2uVmkzl3oeYLlfGj6hq13gDVCXl8Yk
         92XM8Jb1TvRgq2w0GUFbYpoAxLy+Kp/Ol+ovpz8s1mnetArJmxioldYpUzWwWOkS97TU
         ds9YDoQ6SpGWGzHRvNighx/ipEXVgbM3dYimfrBisR+vwx2hSFjiu9tX7B4tMpdBQNxJ
         p/gqnRWHX85cewhN2wIaxAQYKa54AQ+N2rS4MGS18bfSeWG01/3M5FkOme4FDTjjRkEk
         43dQ==
X-Gm-Message-State: AOAM530j2/4LJfoHUqX9XMwy5HjL/NgTo9tN0d8lLb+L2ejSCdCzPsX4
        3k1CvLHB8kJJ6ebIyyksEat3QvGQZOfbNs3/K6s=
X-Google-Smtp-Source: ABdhPJwsJ7POncmJV1ftt16cscxO6V9Ki3Y2ukfc69NS/cvFAVPDA6FKKGSSn28H50+D42SXs876CsdPnpWp6JNv8LM=
X-Received: by 2002:a05:6e02:1074:: with SMTP id q20mr5546458ilj.137.1625742594528;
 Thu, 08 Jul 2021 04:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-8-krisman@collabora.com> <20210708104307.GA1656@quack2.suse.cz>
In-Reply-To: <20210708104307.GA1656@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 8 Jul 2021 14:09:43 +0300
Message-ID: <CAOQ4uxh2_vEiaPy1PQ-++Lpze90uUfNh6ymkE-SMYMVuN5_F1w@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 8, 2021 at 1:43 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 29-06-21 15:10:27, Gabriel Krisman Bertazi wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > There are a lot of arguments to fsnotify() and the handle_event() method.
> > Pass them in a const struct instead of on the argument list.
> >
> > Apart from being more tidy, this helps with passing error reports to the
> > backend.  __fsnotify_parent() argument list was intentionally left
> > untouched, because its argument list is still short enough and because
> > most of the event info arguments are initialized inside
> > __fsnotify_parent().
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  fs/notify/fanotify/fanotify.c    | 59 +++++++++++------------
> >  fs/notify/fsnotify.c             | 83 +++++++++++++++++---------------
> >  include/linux/fsnotify.h         | 15 ++++--
> >  include/linux/fsnotify_backend.h | 73 +++++++++++++++++++++-------
> >  4 files changed, 140 insertions(+), 90 deletions(-)
>
> Besides the noop function issue Amir has already pointed out I have just a
> few nits:
>
> > @@ -229,7 +229,11 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >       }
> >
> >  notify:
> > -     ret = fsnotify(mask, data, data_type, p_inode, file_name, inode, 0);
> > +     ret = __fsnotify(mask, &(struct fsnotify_event_info) {
> > +                             .data = data, .data_type = data_type,
> > +                             .dir = p_inode, .name = file_name,
> > +                             .inode = inode,
> > +                             });
>
> What's the advantage of using __fsnotify() here instead of fsnotify()? In
> terms of readability the fewer places with these initializers the better
> I'd say...
>
> >  static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
> > -                              const void *data, int data_type,
> > -                              struct inode *dir, const struct qstr *name,
> > -                              u32 cookie, struct fsnotify_iter_info *iter_info)
> > +                              const struct fsnotify_event_info *event_info,
> > +                              struct fsnotify_iter_info *iter_info)
> >  {
> >       struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
> >       struct fsnotify_mark *parent_mark = fsnotify_iter_parent_mark(iter_info);
> > +     struct fsnotify_event_info child_event_info = { };
> >       int ret;
>
> No need to init child_event_info. It is fully rewritten if it gets used...
>
> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index f8acddcf54fb..8c2c681b4495 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -30,7 +30,10 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
> >                                struct inode *child,
> >                                const struct qstr *name, u32 cookie)
> >  {
> > -     fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
> > +     __fsnotify(mask, &(struct fsnotify_event_info) {
> > +                     .data = child, .data_type = FSNOTIFY_EVENT_INODE,
> > +                     .dir = dir, .name = name, .cookie = cookie,
> > +                     });
> >  }
>
> Hmm, maybe we could have a macro initializer like:
>
> #define FSNOTIFY_EVENT_INFO(data, data_type, dir, name, inode, cookie)  \
>         (struct fsnotify_event_info) {                                  \
>                 .data = (data), .data_type = (data_type), .dir = (dir), \
>                 .name = (name), .inode = (inode), .cookie = (cookie)}
>
> Then we'd have:
>         __fsnotify(mask, &FSNOTIFY_EVENT_INFO(child, FSNOTIFY_EVENT_INODE,
>                                 dir, name, NULL, cookie));
>
> Which looks a bit nicer to me. What do you think guys?
>

Sure, looks good.
But I think it would be even better to have different "wrapper defines" like
FSNOTIFY_NAME_EVENT_INFO() will less irrelevant arguments.

Thanks,
Amir.
