Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3144431BF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 16:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhKBPdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 11:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234624AbhKBPdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635867039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/b19brKVPxLCuyWiyjGwQtI8zouzZomDfRSbXCqcWAE=;
        b=jJcG0EUuJRCvOi1lTJSoLCI3mDJyMWyppZWsAfHKzYyWBdYmz4igoHsyU1K4geWLyUf8Rw
        O4dwKbK3DNopCOrgM2JgIlaa9cOuU0I5R10FcbSNlF37CHn7Ymm9irPrwqR6NFWrx5yoA6
        qaogtk743c1IPej1KmqbeNynLNYH5JI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-gPXX8nxEP1CnZQKRxN1yig-1; Tue, 02 Nov 2021 11:30:33 -0400
X-MC-Unique: gPXX8nxEP1CnZQKRxN1yig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63FDC102CB76;
        Tue,  2 Nov 2021 15:30:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E87162B0B8;
        Tue,  2 Nov 2021 15:30:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 714D2222F94; Tue,  2 Nov 2021 11:30:31 -0400 (EDT)
Date:   Tue, 2 Nov 2021 11:30:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2 2/2] fuse: Send security context of inode on file
 creation
Message-ID: <YYFZl3egeX88G3FQ@redhat.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
 <20211012180624.447474-3-vgoyal@redhat.com>
 <CAJfpegs-EHBjjnsVQdPWfH=idVENj9Aw0e-L4tjcgx3v38NJtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs-EHBjjnsVQdPWfH=idVENj9Aw0e-L4tjcgx3v38NJtg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:00:30PM +0100, Miklos Szeredi wrote:
> On Tue, 12 Oct 2021 at 20:06, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > When a new inode is created, send its security context to server along
> > with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_SYMLINK).
> > This gives server an opportunity to create new file and set security
> > context (possibly atomically). In all the configurations it might not
> > be possible to set context atomically.
> >
> > Like nfs and ceph, use security_dentry_init_security() to dermine security
> > context of inode and send it with create, mkdir, mknod, and symlink requests.
> >
> > Following is the information sent to server.
> >
> > - struct fuse_secctxs.
> >   This contains total number of security contexts being sent.
> >
> > - struct fuse_secctx.
> >   This contains total size of security context which follows this structure.
> >   There is one fuse_secctx instance per security context.
> >
> > - xattr name string.
> >   This string represents name of xattr which should be used while setting
> >   security context. As of now it is hardcoded to "security.selinux".
> >
> > - security context.
> >   This is the actual security context whose size is specified in fuse_secctx
> >   struct.
> >
> > This patch is modified version of patch from
> > Chirantan Ekbote <chirantan@chromium.org>
> >
> > v2:
> > - Added "fuse_secctxs" structure where one can specify how many security
> >   contexts are being sent. This can be useful down the line if we
> >   have more than one security contexts being set.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/dir.c             | 115 ++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h          |   3 +
> >  fs/fuse/inode.c           |   4 +-
> >  include/uapi/linux/fuse.h |  20 +++++++
> >  4 files changed, 136 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index d9b977c0f38d..ce62593a61f9 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -17,6 +17,9 @@
> >  #include <linux/xattr.h>
> >  #include <linux/iversion.h>
> >  #include <linux/posix_acl.h>
> > +#include <linux/security.h>
> > +#include <linux/types.h>
> > +#include <linux/kernel.h>
> >
> >  static void fuse_advise_use_readdirplus(struct inode *dir)
> >  {
> > @@ -456,6 +459,66 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
> >         return ERR_PTR(err);
> >  }
> >
> > +static int get_security_context(struct dentry *entry, umode_t mode,
> > +                               void **security_ctx, u32 *security_ctxlen)
> > +{
> > +       struct fuse_secctx *fsecctx;
> > +       struct fuse_secctxs *fsecctxs;
> > +       void *ctx, *full_ctx;
> > +       u32 ctxlen, full_ctxlen;
> > +       int err = 0;
> > +       const char *name;
> > +
> > +       err = security_dentry_init_security(entry, mode, &entry->d_name,
> > +                                           &name, &ctx, &ctxlen);
> > +       if (err) {
> > +               if (err != -EOPNOTSUPP)
> > +                       goto out_err;
> > +               /* No LSM is supporting this security hook. Ignore error */
> > +               err = 0;
> > +               ctxlen = 0;
> > +       }
> > +
> > +       if (ctxlen > 0) {
> > +               void *ptr;
> > +
> > +               full_ctxlen = sizeof(*fsecctxs) + sizeof(*fsecctx) +
> > +                             strlen(name) + ctxlen + 1;
> > +               full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
> > +               if (!full_ctx) {
> > +                       err = -ENOMEM;
> > +                       kfree(ctx);
> > +                       goto out_err;
> > +               }
> > +
> > +               ptr = full_ctx;
> > +               fsecctxs = (struct fuse_secctxs*) ptr;
> > +               fsecctxs->nr_secctx = 1;
> > +               ptr += sizeof(*fsecctxs);
> > +
> > +               fsecctx = (struct fuse_secctx*) ptr;
> > +               fsecctx->size = ctxlen;
> > +               ptr += sizeof(*fsecctx);
> > +
> > +               strcpy(ptr, name);
> > +               ptr += strlen(name) + 1;
> > +               memcpy(ptr, ctx, ctxlen);
> > +               kfree(ctx);
> > +       } else {
> > +               full_ctxlen = sizeof(*fsecctxs);
> > +               full_ctx = kzalloc(full_ctxlen, GFP_KERNEL);
> > +               if (!full_ctx) {
> > +                       err = -ENOMEM;
> > +                       goto out_err;
> > +               }
> > +       }
> > +
> > +       *security_ctxlen = full_ctxlen;
> > +       *security_ctx = full_ctx;
> > +out_err:
> > +       return err;
> > +}
> > +
> >  /*
> >   * Atomic create+open operation
> >   *
> > @@ -476,6 +539,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         struct fuse_entry_out outentry;
> >         struct fuse_inode *fi;
> >         struct fuse_file *ff;
> > +       void *security_ctx = NULL;
> > +       u32 security_ctxlen;
> >
> >         /* Userspace expects S_IFREG in create mode */
> >         BUG_ON((mode & S_IFMT) != S_IFREG);
> > @@ -517,6 +582,18 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >         args.out_args[0].value = &outentry;
> >         args.out_args[1].size = sizeof(outopen);
> >         args.out_args[1].value = &outopen;
> > +
> > +       if (fm->fc->init_security) {
> > +               err = get_security_context(entry, mode, &security_ctx,
> > +                                          &security_ctxlen);
> > +               if (err)
> > +                       goto out_put_forget_req;
> > +
> > +               args.in_numargs = 3;
> > +               args.in_args[2].size = security_ctxlen;
> > +               args.in_args[2].value = security_ctx;
> > +       }
> > +
> >         err = fuse_simple_request(fm, &args);
> >         if (err)
> >                 goto out_free_ff;
> > @@ -554,6 +631,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> >
> >  out_free_ff:
> >         fuse_file_free(ff);
> > +       kfree(security_ctx);
> >  out_put_forget_req:
> >         kfree(forget);
> >  out_err:
> > @@ -613,13 +691,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> >   */
> >  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> >                             struct inode *dir, struct dentry *entry,
> > -                           umode_t mode)
> > +                           umode_t mode, bool init_security)
> >  {
> >         struct fuse_entry_out outarg;
> >         struct inode *inode;
> >         struct dentry *d;
> >         int err;
> >         struct fuse_forget_link *forget;
> > +       void *security_ctx = NULL;
> > +       u32 security_ctxlen = 0;
> >
> >         if (fuse_is_bad(dir))
> >                 return -EIO;
> > @@ -633,7 +713,29 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> >         args->out_numargs = 1;
> >         args->out_args[0].size = sizeof(outarg);
> >         args->out_args[0].value = &outarg;
> > +
> > +       if (init_security) {
> 

Hi Miklos,

> Instead of a new arg to create_new_entry(), this could check
> args.opcode != FUSE_LINK.

Will do.

> 
> > +               unsigned short idx = args->in_numargs;
> > +
> > +               if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
> > +                       err = -ENOMEM;
> > +                       goto out_put_forget_req;
> > +               }
> > +
> > +               err = get_security_context(entry, mode, &security_ctx,
> > +                                          &security_ctxlen);
> > +               if (err)
> > +                       goto out_put_forget_req;
> > +
> > +               if (security_ctxlen > 0) {
> 
> This doesn't seem right.  How would the server know if this is arg is missing?
> 
> I think if FUSE_SECURITY_CTX was negotiated, then the secctx header
> will always need to be added to the MK* requests.

Even for the case of FUSE_LINK request? I think I put this check because
FUSE_LINK is not sending secctx header. Other requests are appending
this header even if a security module is not loaded/enabled.

I guess it makes more sense to add secctx header even for FUSE_LINK
request. Just that header will mention 0 security contexts are
following. This will interface more uniform. I will make this change.


> 
> > +                       args->in_args[idx].size = security_ctxlen;
> > +                       args->in_args[idx].value = security_ctx;
> > +                       args->in_numargs++;
> > +               }
> > +       }
> > +
> >         err = fuse_simple_request(fm, args);
> > +       kfree(security_ctx);
> >         if (err)
> >                 goto out_put_forget_req;
> >
> > @@ -691,7 +793,7 @@ static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = entry->d_name.len + 1;
> >         args.in_args[1].value = entry->d_name.name;
> > -       return create_new_entry(fm, &args, dir, entry, mode);
> > +       return create_new_entry(fm, &args, dir, entry, mode, fm->fc->init_security);
> >  }
> >
> >  static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
> > @@ -719,7 +821,8 @@ static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = entry->d_name.len + 1;
> >         args.in_args[1].value = entry->d_name.name;
> > -       return create_new_entry(fm, &args, dir, entry, S_IFDIR);
> > +       return create_new_entry(fm, &args, dir, entry, S_IFDIR,
> > +                               fm->fc->init_security);
> >  }
> >
> >  static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> > @@ -735,7 +838,8 @@ static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
> >         args.in_args[0].value = entry->d_name.name;
> >         args.in_args[1].size = len;
> >         args.in_args[1].value = link;
> > -       return create_new_entry(fm, &args, dir, entry, S_IFLNK);
> > +       return create_new_entry(fm, &args, dir, entry, S_IFLNK,
> > +                               fm->fc->init_security);
> >  }
> >
> >  void fuse_update_ctime(struct inode *inode)
> > @@ -915,7 +1019,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = newent->d_name.len + 1;
> >         args.in_args[1].value = newent->d_name.name;
> > -       err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
> > +       err = create_new_entry(fm, &args, newdir, newent, inode->i_mode,
> > +                              false);
> >         /* Contrary to "normal" filesystems it can happen that link
> >            makes two "logical" inodes point to the same "physical"
> >            inode.  We invalidate the attributes of the old one, so it
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 319596df5dc6..885f34f9967f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -765,6 +765,9 @@ struct fuse_conn {
> >         /* Propagate syncfs() to server */
> >         unsigned int sync_fs:1;
> >
> > +       /* Initialize security xattrs when creating a new inode */
> > +       unsigned int init_security:1;
> > +
> >         /** The number of requests waiting for completion */
> >         atomic_t num_waiting;
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 36cd03114b6d..343bc9cfbd92 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1152,6 +1152,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >                         }
> >                         if (arg->flags & FUSE_SETXATTR_EXT)
> >                                 fc->setxattr_ext = 1;
> > +                       if (arg->flags & FUSE_SECURITY_CTX)
> > +                               fc->init_security = 1;
> >                 } else {
> >                         ra_pages = fc->max_read / PAGE_SIZE;
> >                         fc->no_lock = 1;
> > @@ -1195,7 +1197,7 @@ void fuse_send_init(struct fuse_mount *fm)
> >                 FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
> >                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> >                 FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> > -               FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT;
> > +               FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_SECURITY_CTX;
> >  #ifdef CONFIG_FUSE_DAX
> >         if (fm->fc->dax)
> >                 ia->in.flags |= FUSE_MAP_ALIGNMENT;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 2fe54c80051a..b31a0f79fde8 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> 
> I don't see why the API changes are split between the first and the
> second patch in the series.   Please either move all API changes to
> 1/2 or fold 1/2 into this patch.

I guess I will fold first patch into this one, so that there is only
one patch.

> 
> > @@ -986,4 +986,24 @@ struct fuse_syncfs_in {
> >         uint64_t        padding;
> >  };
> >
> > +/*
> > + * For each security context, send fuse_secctx with size of security context
> > + * fuse_secctx will be followed by security context name and this in turn
> > + * will be followed by actual context label.
> > + * fuse_secctx, name, context
> > + * */
> > +struct fuse_secctx {
> > +       uint32_t        size;
> > +       uint32_t        padding;
> > +};
> > +
> > +/*
> > + * Contains the information about how many fuse_secctx structures are being
> > + * sent.
> > + */
> > +struct fuse_secctxs {
> > +       uint32_t        nr_secctx;
> > +       uint32_t        padding;
> > +};
> 
> The name of this struct is very confusing due to similarity with
> fuse_secctx.  How about "fuse_secctx_header"?

Sounds good.  Will do.

> 
> Also I'd add the total length of the security context (including the
> header), otherwise further args would need to parse the security
> context completely to find the position of the next arg.   The
> counterexample is null-terminated names; while parsing these is pretty
> trivial,  in hindsight it would probably have been better to add a
> header to names as well.

Agreed. Will add total length also to "fuse_secctx_header". That will
act as a strong check/verification mechanism as well as allow to
quickly skip to next args if one does not want to parse security contexts
for whatever reason.

Thanks
Vivek

