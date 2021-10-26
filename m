Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC143B991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhJZSal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbhJZSak (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:30:40 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F431C061745;
        Tue, 26 Oct 2021 11:28:16 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id o184so507601iof.6;
        Tue, 26 Oct 2021 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1dt/KdKFMZr2JEFVAnzlosUvMAPKJvNUI3HrMGiVQk=;
        b=bJLutzcpwGRmim77vYeHLzUMGz30PFRESyTQCEj5tmU+htvTwKeM+kVbBJv9RXhapo
         g4iLeGYtjuN8HzoMbHI7sw3TMCKi5ISgygHKwkYTBuyAb3JHUe7ACvQ2f+MRh2p97zHl
         gxMzo9HW3joMB2o0Dg4xUpRKCBL+HNXHDWQbcsTp/FjBN76VxtuVWdN2NSFSxl2uNix1
         jSpv8i028LGdAmbRuk7oJL6MWp0C1qJHsgkovc/7e82KZRIWZWzDKj0jMWOW4pg6Kjsr
         CVVpLrVDUeS9P2gU90B2hXYFn2y9n6eVXevRBFbjj2OHymCg/yFECxXR7q7SSdQRT60g
         S/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1dt/KdKFMZr2JEFVAnzlosUvMAPKJvNUI3HrMGiVQk=;
        b=InxS5KoscmytZL5dTsYY/qrusdcLxPemJ5Z/Ktjg8F1YvACFEdebKKz+KCMHwJiPR3
         EGqYCLYl92RdHXv57xcTwfFfewN3jSZvB3329JqztfBTcdEYgZOJhq6ipzGfmLHkeviQ
         clIxoQtYM79QCXEZZeXWP9C8O4xupP4Tq5EOVHp8Sy3lV4l0bQW8E43V1542U5l+IWiy
         XNtHbuhW8TsnXuWNAraSE18rXxrgC+Ur8tRUstFD0dbbPFfmSou/WcP7RdLVBGyI3yAD
         UjOcfVp4t12ctWZt/JoaKYVyAcsMoy7sGZWPpnzsQICiHYh0p63xHGD0fnxo5lHnqTXK
         zmtw==
X-Gm-Message-State: AOAM531vTf55gwtfsU2kHZVp+RHCv05QNXQpqubVvYFt4omeOntK8stN
        Ds+wmt2p+v5r3ePWXPbCejajrKMyevu7EuET4zZm11iB
X-Google-Smtp-Source: ABdhPJzatRdI3S4ueB2AsBYRGKzBpbKL6m4OMwo/V5Ew+YT67C41xvY1ezp4E8qQ5S/S8NU0okbMMnouI4DDqp6COoQ=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr16199689ion.52.1635272895859;
 Tue, 26 Oct 2021 11:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <20211025204634.2517-2-iangelak@redhat.com>
 <CAOQ4uxinGYb0QtgE8To5wc2iijT9VpTgDiXEp-9YXz=t_6eMbA@mail.gmail.com>
In-Reply-To: <CAOQ4uxinGYb0QtgE8To5wc2iijT9VpTgDiXEp-9YXz=t_6eMbA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 21:28:04 +0300
Message-ID: <CAOQ4uxj+32zyWNsSVyVO25xCGp+2BjEZtG1S9xmCzjVii4Skiw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] FUSE: Add the fsnotify opcode and in/out structs
 to FUSE
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 5:56 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Oct 25, 2021 at 11:47 PM Ioannis Angelakopoulos
> <iangelak@redhat.com> wrote:
> >
> > Since fsnotify is the backend for the inotify subsystem all the backend
> > code implementation we add is related to fsnotify.
> >
> > To support an fsnotify request in FUSE and specifically virtiofs we add a
> > new opcode for the FSNOTIFY (51) operation request in the "fuse.h" header.
> >
> > Also add the "fuse_notify_fsnotify_in" and "fuse_notify_fsnotify_out"
> > structs that are responsible for passing the fsnotify/inotify related data
> > to and from the FUSE server.
> >
> > Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
> > ---
> >  include/uapi/linux/fuse.h | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 46838551ea84..418b7fc72417 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -186,6 +186,9 @@
> >   *  - add FUSE_SYNCFS
> >   *  7.35
> >   *  - add FUSE_NOTIFY_LOCK
> > + *  7.36
> > + *  - add FUSE_HAVE_FSNOTIFY
> > + *  - add fuse_notify_fsnotify_(in,out)
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -221,7 +224,7 @@
> >  #define FUSE_KERNEL_VERSION 7
> >
> >  /** Minor version number of this interface */
> > -#define FUSE_KERNEL_MINOR_VERSION 35
> > +#define FUSE_KERNEL_MINOR_VERSION 36
> >
> >  /** The node ID of the root inode */
> >  #define FUSE_ROOT_ID 1
> > @@ -338,6 +341,7 @@ struct fuse_file_lock {
> >   *                     write/truncate sgid is killed only if file has group
> >   *                     execute permission. (Same as Linux VFS behavior).
> >   * FUSE_SETXATTR_EXT:  Server supports extended struct fuse_setxattr_in
> > + * FUSE_HAVE_FSNOTIFY: remote fsnotify/inotify event subsystem support
> >   */
> >  #define FUSE_ASYNC_READ                (1 << 0)
> >  #define FUSE_POSIX_LOCKS       (1 << 1)
> > @@ -369,6 +373,7 @@ struct fuse_file_lock {
> >  #define FUSE_SUBMOUNTS         (1 << 27)
> >  #define FUSE_HANDLE_KILLPRIV_V2        (1 << 28)
> >  #define FUSE_SETXATTR_EXT      (1 << 29)
> > +#define FUSE_HAVE_FSNOTIFY     (1 << 30)
> >
> >  /**
> >   * CUSE INIT request/reply flags
> > @@ -515,6 +520,7 @@ enum fuse_opcode {
> >         FUSE_SETUPMAPPING       = 48,
> >         FUSE_REMOVEMAPPING      = 49,
> >         FUSE_SYNCFS             = 50,
> > +       FUSE_FSNOTIFY           = 51,
> >
> >         /* CUSE specific operations */
> >         CUSE_INIT               = 4096,
> > @@ -532,6 +538,7 @@ enum fuse_notify_code {
> >         FUSE_NOTIFY_RETRIEVE = 5,
> >         FUSE_NOTIFY_DELETE = 6,
> >         FUSE_NOTIFY_LOCK = 7,
> > +       FUSE_NOTIFY_FSNOTIFY = 8,
> >         FUSE_NOTIFY_CODE_MAX,
> >  };
> >
> > @@ -571,6 +578,20 @@ struct fuse_getattr_in {
> >         uint64_t        fh;
> >  };
> >
> > +struct fuse_notify_fsnotify_out {
> > +       uint64_t inode;
>
> 64bit inode is not a good unique identifier of the object.
> you need to either include the generation in object identifier
> or much better use the object's nfs file handle, the same way
> that fanotify stores object identifiers.
>
> > +       uint64_t mask;
> > +       uint32_t namelen;
> > +       uint32_t cookie;
>
> I object to persisting with the two-events-joined-by-cookie design.
> Any new design should include a single event for rename
> with information about src and dst.
>
> I know this is inconvenient, but we are NOT going to create a "remote inotify"
> interface, we need to create a "remote fsnotify" interface and if server wants
> to use inotify, it will need to join the disjoined MOVE_FROM/TO event into
> a single "remote event", that FUSE will use to call fsnotify_move().
>

TBH, the disjoint vs. joint from/to event is an unfinished business
for fanotify.
So my objection above is more of a strong wish.
But I admit that if existing network protocols already encode the disjoint
from/to events semantics, I may need to fold back on that objection.

Thanks,
Amir.
