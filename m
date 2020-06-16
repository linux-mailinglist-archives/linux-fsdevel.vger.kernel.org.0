Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC61FADF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgFPK2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFPK2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:28:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED203C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 03:28:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s28so11779762edw.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2020 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2RIyeJm0xM8abNF+/WtYZGOzvjkk7mCrM8JO7f4jIk=;
        b=CHfybsnYs3riJWYIIErEI+2CcGnmzcvnSZ6qQtjTMjdcMcemP4k3IWpjudDSs4Gvdf
         85rXDu2i203erGLJtrJxPH8SW7sbWeHkvP2Xcs0+AWZyM0nk13eKv1iQgcBTAwscMXPz
         zNkPgz10Vfua3jKlMPON0il3gJlZYWCFVpPLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2RIyeJm0xM8abNF+/WtYZGOzvjkk7mCrM8JO7f4jIk=;
        b=aYm+grL8ljHCB7lOz3TCobK7SWoUDsV2m/IZDbHZuy2ie68ExsGIQzl66nsLwv1SjS
         6DVCZ7VtUbpxRfhQ5WibU2FHqVk5sWSO4brfjTn4SSOT7DXMZeI8T24A1ahA07TTHdNn
         RvKK8s6kuUdIN1LlRMgMpHTqTbpzIPClg6jFJztTphUHYFKZp35wLSSlRH5ncv/HgTf3
         5MDphzc95ynxGTzZ+4+5asHI/6qNfThSirXpDMxDaNwLET/fpuR3L/A9vjIv2ZxRgqCc
         F/9whyi2BKcF0zAFSk6rEIIc4mkWdmU1HIIc5JtrHRe9r6h5whit5XFhE2i68DeXGOqw
         z2bA==
X-Gm-Message-State: AOAM533RVcEQ0TV+dmHHRaoioVECZHYJ70kNh1JlWULTQjdToetnM/hT
        EugnEv2EPbME9e/dyZHECFLfbcVCGCZaJ0VcyX0TNg==
X-Google-Smtp-Source: ABdhPJzo/EeBLGO3OP4tRRLl+DLvv11dLrWAvxx7rkEN45ulgIYM9RXvdIZg4wesv/uGm96ZWmwSdlZbTBoI4rQgltw=
X-Received: by 2002:a50:ee8f:: with SMTP id f15mr1933207edr.168.1592303281402;
 Tue, 16 Jun 2020 03:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200601053214.201723-1-chirantan@chromium.org>
 <20200610092744.140038-1-chirantan@chromium.org> <CAJfpegs4Dt9gjQPQch=i_GW5EtBVaycG0_nD11xspG3x8f_W9Q@mail.gmail.com>
 <CAJFHJrr7VKD-gumaG5uQ_SPKUTzN+g98rh-rKFWUV7vcGNafHQ@mail.gmail.com>
In-Reply-To: <CAJFHJrr7VKD-gumaG5uQ_SPKUTzN+g98rh-rKFWUV7vcGNafHQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Jun 2020 12:27:50 +0200
Message-ID: <CAJfpegvpxXRcT+AgqidBexiRQ+=+wbN+aeLkJEucQnsRW9EhnQ@mail.gmail.com>
Subject: Re: [PATCH v2] RFC: fuse: Call security hooks on new inodes
To:     Chirantan Ekbote <chirantan@chromium.org>
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

On Tue, Jun 16, 2020 at 11:41 AM Chirantan Ekbote
<chirantan@chromium.org> wrote:
>
> On Tue, Jun 16, 2020 at 6:29 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, Jun 10, 2020 at 11:27 AM Chirantan Ekbote
> > <chirantan@chromium.org> wrote:
> > >
> > >
> > > When set to true, get the security context for a newly created inode via
> > > `security_dentry_init_security` and append it to the create, mkdir,
> > > mknod, and symlink requests.  The server should use this context by
> > > writing it to `/proc/thread-self/attr/fscreate` before creating the
> > > requested inode.
> >
> > This is confusing.  You mean if the server is stacking on top of a
> > real fs, then it can force the created new inode to have the given
> > security attributes by writing to that proc file?
> >
>
> Yes that's correct.  Writing to that proc file ends up setting a field
> in an selinux struct in the kernel.  Later, when an inode is created
> the selinux security hook uses that field to determine the label that
> should be applied to the inode.  This ensures that inodes appear
> atomically with the correct selinux labels.  Most users actually end
> up using setfscreatecon from libselinux but all that does is write to
> /proc/thread-self/attr/fscreate itself after doing some
> conversion/validation.

 FUSE servers do not necessarily use a real filesystem as a backing
store (e.g. network filesystems), so you should clarify that in the
description.

>
> > >
> > >  static void fuse_advise_use_readdirplus(struct inode *dir)
> > >  {
> > > @@ -442,6 +445,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >         struct fuse_entry_out outentry;
> > >         struct fuse_inode *fi;
> > >         struct fuse_file *ff;
> > > +       void *security_ctx = NULL;
> > > +       u32 security_ctxlen = 0;
> > >
> > >         /* Userspace expects S_IFREG in create mode */
> > >         BUG_ON((mode & S_IFMT) != S_IFREG);
> > > @@ -477,6 +482,21 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >         args.out_args[0].value = &outentry;
> > >         args.out_args[1].size = sizeof(outopen);
> > >         args.out_args[1].value = &outopen;
> > > +
> > > +       if (fc->init_security) {
> > > +               err = security_dentry_init_security(entry, mode, &entry->d_name,
> > > +                                                   &security_ctx,
> > > +                                                   &security_ctxlen);
> > > +               if (err)
> > > +                       goto out_put_forget_req;
> > > +
> > > +               if (security_ctxlen > 0) {
> > > +                       args.in_numargs = 3;
> > > +                       args.in_args[2].size = security_ctxlen;
> > > +                       args.in_args[2].value = security_ctx;
> > > +               }
> > > +       }
> > > +
> >
> > The above is quadruplicated, a helper is in order.
>
> Ack.
>
> >
> > >         err = fuse_simple_request(fc, &args);
> > >         if (err)
> > >                 goto out_free_ff;
> > > @@ -513,6 +533,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >         return err;
> > >
> > >  out_free_ff:
> > > +       if (security_ctxlen > 0)
> > > +               kfree(security_ctx);
> >
> > Freeing NULL is okay, if that's guaranteed in case of security_ctxlen
> > == 0, then you need not check that condition.
>
> Ack.  Will fix in v3.
