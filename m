Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5743F9A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhJ2JUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 05:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhJ2JTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:19:15 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30560C061227
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 02:16:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v138so17146836ybb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ii1VwS4bdocl/9x/wQu5Dr4Dw4xnbfm4TdQdq5Q+Azo=;
        b=tm8FL5NwJB2u6qrHnZtD84LIMRI/iboApguCXaLUq9SaX/qb19ml1AcKQ5CH/E5h3w
         S9284fol2t6LhXShzy6SrMbZi0J6usF0oon3W6pWM2clShpwDU9VOz67NU9Cb5OUDXV2
         m/wWU94FmxgrtjlewS0P+DH13dd98L+7UgsawCrJQNo+3+Rm+mLWAmCFh+KiX4xwbd5n
         kFAr/FEBKKvEUJ+v76aHUXx/FLgFjl6axzWrtcSI7kT//aqC4IIz0+4fnT7uhBbsoNHq
         7IhyXKurVXnHNSNJ4YpxGWCVkY6iPwQrMXjRT1215vFhwZxrdXCuFYpo4RZUfAEMV2pV
         BafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ii1VwS4bdocl/9x/wQu5Dr4Dw4xnbfm4TdQdq5Q+Azo=;
        b=XweCa9h4F1jszccYvpKbE82ULzNmqQUI3/kNEdv4H+FpszbHlT4kixiHNkUtJSctxq
         fRlI8DojwQM8emRa8+NAx1/6b/skkpYX5AqXz5bAbh6uCTND3prD8sAyeLh3MPKP0SR0
         p198S2OgH1W3jhsHY/5od9XqF8lSe85V7wc3eMmiN1tIlmdr/zSDe6nFXcIjMMnt7bef
         gf/Qgi1UcVzWdA1BuvxYOl6WYS97B8gv1k7JYRXV1E5q+F8WaIDT26+L3E6ddqi0crss
         kXU7x7pbbgPHpXjgKN53uEoWmN2L+J3m4BNJ+955WN2Zlu18QHXsokGq5//tQKjmHFnV
         AZYA==
X-Gm-Message-State: AOAM532EJRFtQix/bOpmOw2ZI8T2Wb6kCLrFRcCm1XzQPsVChsXlJEcR
        CS+ZXVNzCsoV0/KbO3f8Ye/4FB0ZK/esiFPp/Vy4IQ==
X-Google-Smtp-Source: ABdhPJwW4nO+fDJURAek2VDCfkH2XNLlc3gfnKCDXjWDPT8d0Z9cEu/hrBUNVInc9gyOaceJ1Hk/R0u7QAnkp0Ry9yc=
X-Received: by 2002:a25:ad02:: with SMTP id y2mr10644935ybi.141.1635499006377;
 Fri, 29 Oct 2021 02:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211029032638.84884-1-songmuchun@bytedance.com>
 <20211029082620.jlnauplkyqmaz3ze@wittgenstein> <CAMZfGtUMLD183qHVt6=8gU4nnQD2pn1gZwZJOjCHFK73wK0=kQ@mail.gmail.com>
 <20211029085041.fhyi2kn3bdmxt6h4@wittgenstein>
In-Reply-To: <20211029085041.fhyi2kn3bdmxt6h4@wittgenstein>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 29 Oct 2021 17:16:10 +0800
Message-ID: <CAMZfGtXMKSiOoswVNLCp41kMkK0o5WVyhQSeEpzUT-D-yf9V1w@mail.gmail.com>
Subject: Re: [PATCH] seq_file: fix passing wrong private data
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     andriy.shevchenko@linux.intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, revest@chromium.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 4:50 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Oct 29, 2021 at 04:43:40PM +0800, Muchun Song wrote:
> > On Fri, Oct 29, 2021 at 4:26 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Fri, Oct 29, 2021 at 11:26:38AM +0800, Muchun Song wrote:
> > > > DEFINE_PROC_SHOW_ATTRIBUTE() is supposed to be used to define a series
> > > > of functions and variables to register proc file easily. And the users
> > > > can use proc_create_data() to pass their own private data and get it
> > > > via seq->private in the callback. Unfortunately, the proc file system
> > > > use PDE_DATA() to get private data instead of inode->i_private. So fix
> > > > it. Fortunately, there only one user of it which does not pass any
> > > > private data, so this bug does not break any in-tree codes.
> > > >
> > > > Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  include/linux/seq_file.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> > > > index 103776e18555..72dbb44a4573 100644
> > > > --- a/include/linux/seq_file.h
> > > > +++ b/include/linux/seq_file.h
> > > > @@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {                   \
> > > >  #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)                           \
> > > >  static int __name ## _open(struct inode *inode, struct file *file)   \
> > > >  {                                                                    \
> > > > -     return single_open(file, __name ## _show, inode->i_private);    \
> > > > +     return single_open(file, __name ## _show, PDE_DATA(inode));     \
> > > >  }                                                                    \
> > > >                                                                       \
> > > >  static const struct proc_ops __name ## _proc_ops = {                 \
> > >
> > > Hm, after your change DEFINE_SHOW_ATTRIBUTE() and
> > > DEFINE_PROC_SHOW_ATTRIBUTE() macros do exactly the same things, right?:
> >
> > Unfortunately, they are not the same. The difference is the
> > operation structure, namely "struct file_operations" and
> > "struct proc_ops".
> >
> > DEFINE_SHOW_ATTRIBUTE() is usually used by
> > debugfs while DEFINE_SHOW_ATTRIBUTE() is
> > used by procfs.
>
> Ugh, right, thanks for pointing that out. I overlooked the _proc_ops
> appendix. Not sure what's right here. There seem to have been earlier
> callers to DEFINE_PROC_SHOW_ATTRIBUTE() that relied on PDE_DATA() but
> there's only one caller so that change wouldn't be too bad, I guess.

From my point of view, I think the macro is useful which can
simplify the code. However there is only one user of it. I suppose
few people know about it. For instance, the following ops can
become the user of it.

    cifs_mount_params_proc_ops
    nfsd_proc_ops
    rpc_proc_ops

Thanks.
