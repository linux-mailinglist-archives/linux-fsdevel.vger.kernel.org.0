Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3F51FACEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgFPJls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgFPJlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:41:47 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BB2C05BD43
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:41:47 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id s1so10498595ybo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbO9qGecYmWXUD37SUob42kXBPCWyMyGCznqgXAEuis=;
        b=Keh5C5dNltLNDS2F1Npj/VN3K++TmHgh7nTPacEIM2BOK+xGgVI7UcTLmX/G1wxYLV
         bH3I8lohkmiAv+0i53hLMJefz/kGA6oQ0pJp80i3BesKw5osPZMjaq6yUOtdlR7/JAsB
         iNjzi0tNPIeQx8YAxxsHUz2hTsz5jDigZC7IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbO9qGecYmWXUD37SUob42kXBPCWyMyGCznqgXAEuis=;
        b=aEKs3jcP7oV/jJ06iaN2VXGQkPMCS0zmEcRsWaN9VIo3rHdcQMwT0nORmhrtklW4Ra
         qT/XXz7ZKo4JQZ5SPa3YNgXdJz83YWF1VRK2Tfppn5M/iADW/SSS227/k+ZJEDxIqtUx
         afEoCQgcde9ukrtd6RSXO5x9k51MFAyoSeMv9GeVX7HE5hk166qCDVBrelltor3h7yix
         a7FFjLaaj7tBkVMcNPwj0ooruuJjR20VBqF861IU25+XIok+OjmP6Pe6wuTmelp/bjHc
         abcuwFEGX0bMVmPIXYyMzka9EFfcBAKyApiFSp/3fPJT4am5VHbBFgsf4vrFqx8RVXWG
         TAsA==
X-Gm-Message-State: AOAM530Da1nRw1UG/6d7MpkPBZ8mH6TMxjurlA2vQAoOls2X5nAXnf3V
        9OmdDpWM8b7+EwFY9fM0yblUPAG69NN3A1ohsMetlg==
X-Google-Smtp-Source: ABdhPJyejTI8yLpgfZih9eQjzy7khF5CLVxMp/nJMhZT/j2dwjryehwEPuCN9HPZHR7Fvlb7YW7eVszX0DE6YsYx+hs=
X-Received: by 2002:a25:6b4d:: with SMTP id o13mr2991612ybm.496.1592300506643;
 Tue, 16 Jun 2020 02:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200601053214.201723-1-chirantan@chromium.org>
 <20200610092744.140038-1-chirantan@chromium.org> <CAJfpegs4Dt9gjQPQch=i_GW5EtBVaycG0_nD11xspG3x8f_W9Q@mail.gmail.com>
In-Reply-To: <CAJfpegs4Dt9gjQPQch=i_GW5EtBVaycG0_nD11xspG3x8f_W9Q@mail.gmail.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Tue, 16 Jun 2020 18:41:35 +0900
Message-ID: <CAJFHJrr7VKD-gumaG5uQ_SPKUTzN+g98rh-rKFWUV7vcGNafHQ@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: fuse: Call security hooks on new inodes
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 6:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Jun 10, 2020 at 11:27 AM Chirantan Ekbote
> <chirantan@chromium.org> wrote:
> >
> >
> > When set to true, get the security context for a newly created inode via
> > `security_dentry_init_security` and append it to the create, mkdir,
> > mknod, and symlink requests.  The server should use this context by
> > writing it to `/proc/thread-self/attr/fscreate` before creating the
> > requested inode.
>
> This is confusing.  You mean if the server is stacking on top of a
> real fs, then it can force the created new inode to have the given
> security attributes by writing to that proc file?
>

Yes that's correct.  Writing to that proc file ends up setting a field
in an selinux struct in the kernel.  Later, when an inode is created
the selinux security hook uses that field to determine the label that
should be applied to the inode.  This ensures that inodes appear
atomically with the correct selinux labels.  Most users actually end
up using setfscreatecon from libselinux but all that does is write to
/proc/thread-self/attr/fscreate itself after doing some
conversion/validation.

> >
> >  static void fuse_advise_use_readdirplus(struct inode *dir)
> >  {
> > @@ -442,6 +445,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         struct fuse_entry_out outentry;
> >         struct fuse_inode *fi;
> >         struct fuse_file *ff;
> > +       void *security_ctx = NULL;
> > +       u32 security_ctxlen = 0;
> >
> >         /* Userspace expects S_IFREG in create mode */
> >         BUG_ON((mode & S_IFMT) != S_IFREG);
> > @@ -477,6 +482,21 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         args.out_args[0].value = &outentry;
> >         args.out_args[1].size = sizeof(outopen);
> >         args.out_args[1].value = &outopen;
> > +
> > +       if (fc->init_security) {
> > +               err = security_dentry_init_security(entry, mode, &entry->d_name,
> > +                                                   &security_ctx,
> > +                                                   &security_ctxlen);
> > +               if (err)
> > +                       goto out_put_forget_req;
> > +
> > +               if (security_ctxlen > 0) {
> > +                       args.in_numargs = 3;
> > +                       args.in_args[2].size = security_ctxlen;
> > +                       args.in_args[2].value = security_ctx;
> > +               }
> > +       }
> > +
>
> The above is quadruplicated, a helper is in order.

Ack.

>
> >         err = fuse_simple_request(fc, &args);
> >         if (err)
> >                 goto out_free_ff;
> > @@ -513,6 +533,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         return err;
> >
> >  out_free_ff:
> > +       if (security_ctxlen > 0)
> > +               kfree(security_ctx);
>
> Freeing NULL is okay, if that's guaranteed in case of security_ctxlen
> == 0, then you need not check that condition.

Ack.  Will fix in v3.
