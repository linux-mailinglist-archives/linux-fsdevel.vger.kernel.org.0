Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38042211EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgGOQG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOQGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:06:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB922C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 09:06:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f23so2782717iof.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hrojdj5uCn0tmxMrQMhRcyO0cn3wP1WvX545W+ZWEvI=;
        b=VDDDNBe/ja1QxSYJ7u3yFK3OweBahrKJ6xnOm7bCy0TqqekwmezZ3/OldyCywJUUkV
         9hAPvBMCRgk8RxppXqo8+RtnsJ+IJs/IyiTU2ksPcc2sU1ovm8awuIHGWTpNk2FJ4f4b
         X4U+dV+R1QmX6W+pwyNe3zhbx2ydzxeFOl/TlTVZSlI8HPYVFSB2D6Z4R2JCOYaLDwb6
         JX4x6p02y7+uaRcom+DS6+QiNBBYQRTbut4xGiWNCJJrgff74UJk77Mk6037LwhEmr8B
         nE40o0+TiiVFSewx2cWcWWU9WecC4Cw32pKzGh3EcIYCvd/HTIsnvsbPCX0riqQUGTbB
         I33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hrojdj5uCn0tmxMrQMhRcyO0cn3wP1WvX545W+ZWEvI=;
        b=gPGv3C0LuwlnbuLtERNU196UN7lTvvxtW39/17HhImrrLdiz5adGkaN8ZauySbc8KZ
         mnu97Pl+fMbM5WrcY5lMvJhLp/xkXM+xlfsT/gS17IjW1mMbVGEfzlHgZ6JrCc6zvPKU
         jw8Dntgl5xyluZzY5yAPsJm1y3NA+lUWHweUWJQCz++362e0rA6XtwVV1GeXp54PAlnY
         9c0HUQst6v3zkInUGa3Kvsk+4gzKs4o6c99pV+kFfqWzWDd8kSU66B8lejJcUj5XPyU4
         FPp63fg+edj7Pi3uQHyamjWb2kHCmA0Lmk0gS+26dFVePWvAPnT3z3FlYL6B82xqNfhc
         HOMw==
X-Gm-Message-State: AOAM532d3AGENVHwNsKn3t/OFo2SHwlGdARIi7g6+H6vuUf3XBZFkiNl
        9fPu6AT/KdvNo9mZI5/X1vzNwkITR2lKrahbelYziA==
X-Google-Smtp-Source: ABdhPJx8cZLtHc3rtQlCzzfUv4GVmq03SosYCReOqw+xxIqcnz91MfIl3jhGXOC5UwBnTKgjwoYzGUJs7pW9usSzC9U=
X-Received: by 2002:a05:6602:1225:: with SMTP id z5mr33303iot.64.1594829163305;
 Wed, 15 Jul 2020 09:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200708111156.24659-1-amir73il@gmail.com> <20200708111156.24659-20-amir73il@gmail.com>
 <20200715153454.GO23073@quack2.suse.cz>
In-Reply-To: <20200715153454.GO23073@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jul 2020 19:05:52 +0300
Message-ID: <CAOQ4uxg+75abXiNtPXqh6tybUAGfJ7=we9nmxSnaCsfNGBjZcQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/20] fanotify: no external fh buffer in fanotify_name_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 6:34 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 08-07-20 14:11:55, Amir Goldstein wrote:
> > The fanotify_fh struct has an inline buffer of size 12 which is enough
> > to store the most common local filesystem file handles (e.g. ext4, xfs).
> > For file handles that do not fit in the inline buffer (e.g. btrfs), an
> > external buffer is allocated to store the file handle.
> >
> > When allocating a variable size fanotify_name_event, there is no point
> > in allocating also an external fh buffer when file handle does not fit
> > in the inline buffer.
> >
> > Check required size for encoding fh, preallocate an event buffer
> > sufficient to contain both file handle and name and store the name after
> > the file handle.
> >
> > At this time, when not reporting name in event, we still allocate
> > the fixed size fanotify_fid_event and an external buffer for large
> > file handles, but fanotify_alloc_name_event() has already been prepared
> > to accept a NULL file_name.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Just one tiny nit below:
>
> > @@ -305,27 +323,34 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
> >   * Return 0 on failure to encode.
> >   */
> >  static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> > -                           gfp_t gfp)
> > +                           unsigned int fh_len, gfp_t gfp)
> >  {
> > -     int dwords, type, bytes = 0;
> > +     int dwords, bytes, type = 0;
> >       char *ext_buf = NULL;
> >       void *buf = fh->buf;
> >       int err;
> >
> >       fh->type = FILEID_ROOT;
> >       fh->len = 0;
> > +     fh->flags = 0;
> >       if (!inode)
> >               return 0;
> >
> > -     dwords = 0;
> > +     /*
> > +      * !gpf means preallocated variable size fh, but fh_len could
> > +      * be zero in that case if encoding fh len failed.
> > +      */
> >       err = -ENOENT;
> > -     type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
> > -     if (!dwords)
> > +     if (!gfp)
> > +             bytes = fh_len;
> > +     else
> > +             bytes = fanotify_encode_fh_len(inode);
>
> Any reason why proper fh len is not passed in by both callers?

No good reason.
It's just how the function evolved and I missed this simplification.

> We could then get rid of this 'if' and 'bytes' variable.

Yap. sounds good.
I will test and push the branches.
Let me know if you want me to re-post anything.

Thanks,
Amir.
