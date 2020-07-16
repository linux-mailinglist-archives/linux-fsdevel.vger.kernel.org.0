Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA4222803
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgGPQIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 12:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPQIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:08:36 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA45C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 09:08:36 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so5498279ill.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O47mfUBVOt+vsdDCqqvsg/aMVyy9NzMv8RpPVc2C3G8=;
        b=SjtIxj+BDgCmQKCOnua4Snfp7t0mp0CCZ/Gcuu6gi5XO25RafG7zshsbc5+EfzeZjW
         29gFmS2vAJSuW4K+QPPGHcuDQ5icYTU0jGVbwYwGhs1anT4FLcTUVxbHn1KnYbkMBZGe
         q+jzHkGWzOIDlUwcwimzYY9LB3eQDIQxJNmJkcIqzuPHJsxdbdoLh5WDakpoXLsB2Kbu
         Bl1D/o63KuB+cYSAUXdD8T46TTmU6l/gMNe1LKwUmb9ow99KNuOUHn/4O7hvC5K4Nma5
         +EFPsPyxWhOyTU4OocG1MT0Bd+cMuIvlYUkBcsi242T+JeHkMuTLvJMbKiwxqsh9cOGg
         ddtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O47mfUBVOt+vsdDCqqvsg/aMVyy9NzMv8RpPVc2C3G8=;
        b=Ln5Ag1fLHLAkYA/O9JEv1uGnZNbahZCx04USwTMuuU4XXQdhEsHOqoA3cCJ1ZnGi/x
         Hcm+NuB+Q97uFzGvLIdGlr3VaFRleGY2mKlSJDFQDS94jQ6VhK73l+VEnxplzOC2Ra0j
         1qqka9UQ4UkMBQcqg5uscHCrCa7sy/VT97NyeQqQZwUPD4aLfkjqOXw8FERR3YwI0Ggb
         Jh6FOkYRNL7wmf7kx5FU69byRbE0Rfp8SGiAyJrbQAq6HSNd2S5NU+yaGMAqnBV3TFlV
         4RhZYrh9qrnocdnEnKTFcsClxkffQfgtcirDScToJgAFzXs04XpfJXtC7E8cDHuZq/3t
         ourw==
X-Gm-Message-State: AOAM531j3oIKJQumISFWtLEpsbkxVy4mQpmRhmwew8x7PpeFhG1Ioy2M
        QwjleJmFK/M1ZYUOIOS1mGGxupDj9vLUgHAF3eMr5mzi
X-Google-Smtp-Source: ABdhPJzUXn4FqiQkFn9FBHbo1ReWG1cltsGAR5wVQz8ITqsUCOh+iRGfhfkUEInr3qL3tga59anGme3XlkfHP/E7gnY=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr5447409ilj.9.1594915715792;
 Thu, 16 Jul 2020 09:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-22-amir73il@gmail.com>
 <20200716155932.GH5022@quack2.suse.cz>
In-Reply-To: <20200716155932.GH5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 19:08:23 +0300
Message-ID: <CAOQ4uxi-GB0OAwGgBVnDAMCM5nEECN3pQA2Zrp3z-EGJjwt6Hw@mail.gmail.com>
Subject: Re: [PATCH v5 21/22] fanotify: report parent fid + name + child fid
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 6:59 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 11:42:29, Amir Goldstein wrote:
> > For a group with fanotify_init() flag FAN_REPORT_DFID_NAME, the parent
> > fid and name are reported for events on non-directory objects with an
> > info record of type FAN_EVENT_INFO_TYPE_DFID_NAME.
> >
> > If the group also has the init flag FAN_REPORT_FID, the child fid
> > is also reported with another info record that follows the first info
> > record. The second info record is the same info record that would have
> > been reported to a group with only FAN_REPORT_FID flag.
> >
> > When the child fid needs to be recorded, the variable size struct
> > fanotify_name_event is preallocated with enough space to store the
> > child fh between the dir fh and the name.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fanotify/fanotify.c      | 30 ++++++++++++++++++++++++++----
> >  fs/notify/fanotify/fanotify.h      |  8 +++++++-
> >  fs/notify/fanotify/fanotify_user.c |  3 ++-
> >  3 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index c77b37eb33a9..1d8eb886fe08 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -479,15 +479,22 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
> >  static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> >                                                       __kernel_fsid_t *fsid,
> >                                                       const struct qstr *file_name,
> > +                                                     struct inode *child,
> >                                                       gfp_t gfp)
> >  {
> >       struct fanotify_name_event *fne;
> >       struct fanotify_info *info;
> > -     struct fanotify_fh *dfh;
> > +     struct fanotify_fh *dfh, *ffh;
> >       unsigned int dir_fh_len = fanotify_encode_fh_len(id);
> > +     unsigned int child_fh_len = fanotify_encode_fh_len(child);
> >       unsigned int size;
> >
> > +     if (WARN_ON_ONCE(dir_fh_len % FANOTIFY_FH_HDR_LEN))
> > +             child_fh_len = 0;
> > +
>
> Why this check? Do you want to check everything is 4-byte aligned? But then
> FANOTIFY_FH_HDR_LEN works mostly by accident...

Good catch.
That's indeed a mistake.
Should be % 4 which is expected because
...
        return dwords << 2;

If you think that is over defensive, you can drop it.

Thanks,
Amir.
