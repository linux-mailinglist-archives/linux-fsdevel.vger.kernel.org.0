Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22A13ECE18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 07:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhHPFg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 01:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbhHPFg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 01:36:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC56C061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 22:35:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lo4so29525074ejb.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 22:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkMzMi5SrHweNSLPy5u1W+MwnSKVZJ9kZs1cY/FIIcs=;
        b=zoxef1iSDX5I1qIB3TJvvApvfLkcfF7Wi+ffNHFZoUv2cHhHVmX9oROTtxCVkYMHUa
         kL/+XF5XXZrDjBKp035iK4n3iRLxMfAM4/mZGXTRjPOVugwGGK4KYKxCi516Sx5UC4zn
         O7Qb6n5wTpUM0RX839n1fpzk57BJOYx8nkCx4DJEicp5gl4eDnm9czIpDc3N2DJmm3gq
         GHCf8l35GaonL2/6rociMX//AbRqhpCEJppZE9wQ1J6Jh4O0XFWDmIkNbelyiH+pbIY6
         sFQM2wq0R2oIM5wMnj3mnJyCgVkwv78osCbrKK5XRxR0C1QBZSVAPwN8nWj/1W5pEta2
         9wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkMzMi5SrHweNSLPy5u1W+MwnSKVZJ9kZs1cY/FIIcs=;
        b=AY3xOO0KxkMlIcVsnRzwK4l7c9vdOvxJe7d/lBDjSiGjh6b6itcG2oJpnx+83RwMpi
         ppZx9rRaGvD6QcfcgBHF20Y8USb2fGVixMO1+t5kSL1LXBeQzMlz6cwS7hnTzEbYQYQM
         OOEIdvxFEAI1REY6jdS58N9WCD58qvoO4545exozcgu2B0OH+c9V7zt8Z+M65OKN1JCW
         0TcejiAJHVZejGZ2A7MNfvLMgm4tRfDPBSywOdelPklzinVSscqGzQsX9/LlwiBKnqoj
         PeS0slEXlqtgdEVEwSsYdwj85P2faNIboNfdnr8p434wa7JBSQ83VZNa4UOSoV/iUG6R
         +b7w==
X-Gm-Message-State: AOAM533iGt7ZAv4dyCjN5xh14fF4wml55c+3Fzn8z3sfwVN9M6CNcxSq
        n3LssFJDShe4VJW2svimQWrUmpfcgicp0b6uXWZc
X-Google-Smtp-Source: ABdhPJxv0nlNUp8A2KVC2xXSwgWcgyJWeuyEcxWD0svnh9CVOHswSixiBVyf8DwNVre4d0rDmU03Aa2SZxEGozr7yuc=
X-Received: by 2002:a17:906:8a79:: with SMTP id hy25mr14183029ejc.427.1629092154948;
 Sun, 15 Aug 2021 22:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210813093155.45-1-xieyongji@bytedance.com> <CA+a=Yy674ff4r-cVQ_QLyt0D1vh_6OdSeGXCPgNGHQ303mRV0Q@mail.gmail.com>
In-Reply-To: <CA+a=Yy674ff4r-cVQ_QLyt0D1vh_6OdSeGXCPgNGHQ303mRV0Q@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 16 Aug 2021 13:35:44 +0800
Message-ID: <CACycT3sTTgWG25cK0GjuJ3+P10Eyw7wskSMz_xkbnKkL4EDL8g@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix deadlock on open(O_TRUNC)
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:35 AM Peng Tao <bergwolf@gmail.com> wrote:
>
> On Fri, Aug 13, 2021 at 5:57 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > The invalidate_inode_pages2() might be called with FUSE_NOWRITE
> > set in fuse_finish_open(), which can lead to deadlock in
> > fuse_launder_page().
> >
> > To fix it, this tries to delay calling invalidate_inode_pages2()
> > until FUSE_NOWRITE is removed.
> >
> > Fixes: e4648309b85a ("fuse: truncate pending writes on O_TRUNC")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  fs/fuse/dir.c    |  2 +-
> >  fs/fuse/file.c   | 19 +++++++++++++++----
> >  fs/fuse/fuse_i.h |  2 +-
> >  3 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index eade6f965b2e..d919c3e89cb0 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -548,7 +548,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >                 fuse_sync_release(fi, ff, flags);
> >         } else {
> >                 file->private_data = ff;
> > -               fuse_finish_open(inode, file);
> > +               fuse_finish_open(inode, file, false);
> >         }
> >         return err;
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 97f860cfc195..035af9c88eaf 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -193,12 +193,12 @@ static void fuse_link_write_file(struct file *file)
> >         spin_unlock(&fi->lock);
> >  }
> >
> > -void fuse_finish_open(struct inode *inode, struct file *file)
> > +void fuse_finish_open(struct inode *inode, struct file *file, bool no_write)
> >  {
> >         struct fuse_file *ff = file->private_data;
> >         struct fuse_conn *fc = get_fuse_conn(inode);
> >
> > -       if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> > +       if (!(ff->open_flags & FOPEN_KEEP_CACHE) && !no_write)
> >                 invalidate_inode_pages2(inode->i_mapping);
> It would break !FOPEN_KEEP_CACHE semantics, right? Fuse server asks
> the kernel not to keep cache across open but kernel still keeps it?
>

The caller should call invalidate_inode_pages2() in another place, for
example, in our case:

@@ -259,6 +264,12 @@ int fuse_open_common(struct inode *inode, struct
file *file, bool isdir)

        if (is_wb_truncate | dax_truncate) {
                fuse_release_nowrite(inode);
+               /*
+                * Only call invalidate_inode_pages2() after removing
+                * FUSE_NOWRITE, otherwise fuse_launder_page() would deadlock.
+                */
+               if (!keep_cache)
+                       invalidate_inode_pages2(inode->i_mapping);
                inode_unlock(inode);
        }

Thanks,
Yongji
