Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D766A51DFEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391726AbiEFUKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 16:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347028AbiEFUKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 16:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F794186E0
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651867588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eQKxEXuDWy6VlDvRqzhoAH8J/b40Hn3m2KvLFtLyRy0=;
        b=O6gVPN81SvSZqS41XFNShksGJk95NB2HkoNtpqcE0We1DIupIGD15CKNWp1zGcq5CHVOaz
        TuNLoiXR6GW0DfJkqKAhOKD7ID6LpjLOKBDJG7tmx6NB+dQRVLfkPe9B17Vi32HPY/maxT
        zmsUI1p3649GMsPPjWJRnODVL4K6p6E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-p7XfbaH1PE2deHi9vIEuLQ-1; Fri, 06 May 2022 16:06:24 -0400
X-MC-Unique: p7XfbaH1PE2deHi9vIEuLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB90929DD986;
        Fri,  6 May 2022 20:06:23 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B66D941047E9;
        Fri,  6 May 2022 20:06:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 70853220463; Fri,  6 May 2022 16:06:23 -0400 (EDT)
Date:   Fri, 6 May 2022 16:06:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [PATCH v3 1/3] FUSE: Implement atomic lookup + create
Message-ID: <YnV/v/vtVOLBQ7XS@redhat.com>
References: <20220502054628.25826-1-dharamhans87@gmail.com>
 <20220502054628.25826-2-dharamhans87@gmail.com>
 <YnKX2wsvsafp/uw3@redhat.com>
 <CACUYsyGE=cnrnan4=7opOtunmx=NEaurMjSOjKUK0gdnKdjORw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACUYsyGE=cnrnan4=7opOtunmx=NEaurMjSOjKUK0gdnKdjORw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 01:03:45PM +0530, Dharmendra Hans wrote:
> On Wed, May 4, 2022 at 8:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Mon, May 02, 2022 at 11:16:26AM +0530, Dharmendra Singh wrote:
> > > From: Dharmendra Singh <dsingh@ddn.com>
> > >
> > > When we go for creating a file (O_CREAT), we trigger
> > > a lookup to FUSE USER SPACE. It is very  much likely
> > > that file does not exist yet as O_CREAT is passed to
> > > open(). This lookup can be avoided and can be performed
> > > as part of create call into libfuse.
> > >
> > > This lookup + create in single call to libfuse and finally
> > > to USER SPACE has been named as atomic create. It is expected
> > > that USER SPACE create the file, open it and fills in the
> > > attributes which are then used to make inode stand/revalidate
> > > in the kernel cache. Also if file was newly created(does not
> > > exist yet by this time) in USER SPACE then it should be indicated
> > > in `struct fuse_file_info` by setting a bit which is again used by
> > > libfuse to send some flags back to fuse kernel to indicate that
> > > that file was newly created. These flags are used by kernel to
> > > indicate changes in parent directory.
> > >
> > > Fuse kernel automatically detects if atomic create is implemented
> > > by libfuse/USER SPACE or not. And depending upon the outcome of
> > > this check all further creates are decided to be atomic or non-atomic
> > > creates.
> > >
> > > If libfuse/USER SPACE has not implemented the atomic create operation
> > > then by default behaviour remains same i.e we do not optimize lookup
> > > calls which are triggered before create calls into libfuse.
> > >
> > > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > > ---
> > >  fs/fuse/dir.c             | 82 +++++++++++++++++++++++++++++++++++----
> > >  fs/fuse/fuse_i.h          |  3 ++
> > >  include/uapi/linux/fuse.h |  3 ++
> > >  3 files changed, 81 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > > index 656e921f3506..cad3322a007f 100644
> > > --- a/fs/fuse/dir.c
> > > +++ b/fs/fuse/dir.c
> > > @@ -523,7 +523,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
> > >   */
> > >  static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >                           struct file *file, unsigned int flags,
> > > -                         umode_t mode)
> > > +                         umode_t mode, uint32_t opcode)
> > >  {
> > >       int err;
> > >       struct inode *inode;
> > > @@ -535,8 +535,10 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >       struct fuse_entry_out outentry;
> > >       struct fuse_inode *fi;
> > >       struct fuse_file *ff;
> > > +     struct dentry *res = NULL;
> > >       void *security_ctx = NULL;
> > >       u32 security_ctxlen;
> > > +     bool atomic_create = (opcode == FUSE_ATOMIC_CREATE ? true : false);
> > >
> > >       /* Userspace expects S_IFREG in create mode */
> > >       BUG_ON((mode & S_IFMT) != S_IFREG);
> > > @@ -566,7 +568,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >               inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> > >       }
> > >
> > > -     args.opcode = FUSE_CREATE;
> > > +     args.opcode = opcode;
> > >       args.nodeid = get_node_id(dir);
> > >       args.in_numargs = 2;
> > >       args.in_args[0].size = sizeof(inarg);
> > > @@ -613,9 +615,44 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >               goto out_err;
> > >       }
> > >       kfree(forget);
> > > -     d_instantiate(entry, inode);
> > > +     /*
> > > +      * In atomic create, we skipped lookup and it is very much likely that
> > > +      * dentry has DCACHE_PAR_LOOKUP flag set on it so call d_splice_alias().
> > > +      * Note: Only REG file is allowed under create/atomic create.
> > > +      */
> > > +     /* There is special case when at very first call where we check if
> > > +      * atomic create is implemented by USER SPACE/libfuse or not, we
> > > +      * skipped lookup. Now, in case where atomic create is not implemented
> > > +      * underlying, we fall back to FUSE_CREATE. here we are required to handle
> > > +      * DCACHE_PAR_LOOKUP flag.
> > > +      */
> > > +     if (!atomic_create && !d_in_lookup(entry) && fm->fc->no_atomic_create)
> > > +             d_instantiate(entry, inode);
> > > +     else {
> > > +             res = d_splice_alias(inode, entry);
> > > +             if (res) {
> > > +                      /* Close the file in user space, but do not unlink it,
> > > +                       * if it was created - with network file systems other
> > > +                       * clients might have already accessed it.
> > > +                       */
> > > +                     if (IS_ERR(res)) {
> > > +                             fi = get_fuse_inode(inode);
> > > +                             fuse_sync_release(fi, ff, flags);
> > > +                             fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> > > +                             err = PTR_ERR(res);
> > > +                             goto out_err;
> > > +                     }
> > > +                     /* res is expected to be NULL since its REG file */
> > > +                     WARN_ON(res);
> >
> > This WARN_ON(res) is strange. We enter if (res) block only if res is
> > non null. So effectively we are doing this.
> 
> In create mode, we expect only REG files. It can happen that we
> encountered an error on inode for REG files. We are detecting that
> case. In all cases res should be null.
> 
> >
> > if (res) {
> >    WARN_ON(res);
> > }
> >
> > Will it not trigger all the time?
> 
> No, it will not trigger for REG files and we do not expect spliced dentry here.

Ok, Its little twisted to understand. So you do not expect directories
here. So d_splice_alias() will either reuturn NULL or error.

I guess folllowing kind of construct is more readable.

res = d_splice_alias()
if (res) {
	if (!IS_ERR(res))
		warn(1);
	else {
		/* Do error handling. */
	}
}

> 
> >
> > I think I already asked the question in previous email that what's the
> > difference between d_instanatiate() and d_splice_alias() and why we
> > need d_splice_alias() in this case instead.
> 
> Since we skipped d_lookup() and came here( whether atomic create is
> implemented or not, all cases), dentry can have DCACHE_PAR_LOOKUP flag
> on it (This flag prevents parallel dentry creation for same file name
> in hash, other dentry insert for same file name in hash if came for
> allocation would wait until this flag gets cleared on the dentry).
> d_splice_alias() awaknes those sleeping on this flag but
> d_instantiate() does nothing related to dentry waiters awake/flag
> clear etc. It just links inode with dentry. So we need
> d_splice_alias() here instead of d_instantiate().

Ok. Are there other filesystems in kernel doing the same thing?

I spending some time reading through DCACHE_PAR_LOOKUP logic and
realized that if two lookup are happening in parallel with shared
inode lock held, then one lookup will proceed with DCACHE_PAR_LOOKUP
flag and other will wait on wait queue and will be woken up
when d_lookup_done() is called.

I see that d_splice_alias() does that.

d_splice_alias()
  __d_add()
     if (d_in_lookup(dentry))
         __d_lookup_done(dentry);

Also I was concerned about security_d_instantiate() hook being called
and it looks like that's called as well.

d_splice_alias()
  security_d_instantiate(dentry, inode);

Hmm.., If some other filesystem is doing the same thing it becomes
little easier to believe that all this works and we are not breaking
anything by replacing d_instantiate() with d_splice_alias(). :-)

Thanks
Vivek

> 
> Please note that we are auto detecting the atomic create so even in
> normal create case we would avoid lookup first until
> fc->no_atomic_create is set. it is after we confirm with lower layers
> that atomic create is not implemented, we do not avoid lookups so
> would be calling d_instantiate() instead of d_splice_alias();
> 
> 
> 
> > Thanks
> > Vivek
> > > +             }
> > > +     }
> > >       fuse_change_entry_timeout(entry, &outentry);
> > > -     fuse_dir_changed(dir);
> > > +     /*
> > > +      * In case of atomic create, we want to indicate directory change
> > > +      * only if USER SPACE actually created the file.
> > > +      */
> > > +     if (!atomic_create || (outopen.open_flags & FOPEN_FILE_CREATED))
> > > +             fuse_dir_changed(dir);
> > >       err = finish_open(file, entry, generic_file_open);
> > >       if (err) {
> > >               fi = get_fuse_inode(inode);
> > > @@ -634,6 +671,29 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
> > >       return err;
> > >  }
> > >
> > > +static int fuse_atomic_create(struct inode *dir, struct dentry *entry,
> > > +                           struct file *file, unsigned int flags,
> > > +                           umode_t mode)
> > > +{
> > > +     int err;
> > > +     struct fuse_conn *fc = get_fuse_conn(dir);
> > > +
> > > +     if (fc->no_atomic_create)
> > > +             return -ENOSYS;
> > > +
> > > +     err = fuse_create_open(dir, entry, file, flags, mode,
> > > +                            FUSE_ATOMIC_CREATE);
> > > +     /* If atomic create is not implemented then indicate in fc so that next
> > > +      * request falls back to normal create instead of going into libufse and
> > > +      * returning with -ENOSYS.
> > > +      */
> > > +     if (err == -ENOSYS) {
> > > +             if (!fc->no_atomic_create)
> > > +                     fc->no_atomic_create = 1;
> > > +     }
> > > +     return err;
> > > +}
> > > +
> > >  static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
> > >                     umode_t, dev_t);
> > >  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> > > @@ -643,11 +703,12 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> > >       int err;
> > >       struct fuse_conn *fc = get_fuse_conn(dir);
> > >       struct dentry *res = NULL;
> > > +     bool create = flags & O_CREAT ? true : false;
> > >
> > >       if (fuse_is_bad(dir))
> > >               return -EIO;
> > >
> > > -     if (d_in_lookup(entry)) {
> > > +     if ((!create || fc->no_atomic_create) && d_in_lookup(entry)) {
> > >               res = fuse_lookup(dir, entry, 0);
> > >               if (IS_ERR(res))
> > >                       return PTR_ERR(res);
> > > @@ -656,7 +717,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> > >                       entry = res;
> > >       }
> > >
> > > -     if (!(flags & O_CREAT) || d_really_is_positive(entry))
> > > +     if (!create || d_really_is_positive(entry))
> > >               goto no_open;
> > >
> > >       /* Only creates */
> > > @@ -665,7 +726,13 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> > >       if (fc->no_create)
> > >               goto mknod;
> > >
> > > -     err = fuse_create_open(dir, entry, file, flags, mode);
> > > +     err = fuse_atomic_create(dir, entry, file, flags, mode);
> > > +     /* Libfuse/user space has not implemented atomic create, therefore
> > > +      * fall back to normal create.
> > > +      */
> > > +     if (err == -ENOSYS)
> > > +             err = fuse_create_open(dir, entry, file, flags, mode,
> > > +                                    FUSE_CREATE);
> > >       if (err == -ENOSYS) {
> > >               fc->no_create = 1;
> > >               goto mknod;
> > > @@ -683,6 +750,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> > >  }
> > >
> > >  /*
> > > +
> > >   * Code shared between mknod, mkdir, symlink and link
> > >   */
> > >  static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index e8e59fbdefeb..d577a591ab16 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -669,6 +669,9 @@ struct fuse_conn {
> > >       /** Is open/release not implemented by fs? */
> > >       unsigned no_open:1;
> > >
> > > +     /** Is atomic create not implemented by fs? */
> > > +     unsigned no_atomic_create:1;
> > > +
> > >       /** Is opendir/releasedir not implemented by fs? */
> > >       unsigned no_opendir:1;
> > >
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index d6ccee961891..e4b56004b148 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -301,6 +301,7 @@ struct fuse_file_lock {
> > >   * FOPEN_CACHE_DIR: allow caching this directory
> > >   * FOPEN_STREAM: the file is stream-like (no file position at all)
> > >   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
> > > + * FOPEN_FILE_CREATED: the file was actually created
> > >   */
> > >  #define FOPEN_DIRECT_IO              (1 << 0)
> > >  #define FOPEN_KEEP_CACHE     (1 << 1)
> > > @@ -308,6 +309,7 @@ struct fuse_file_lock {
> > >  #define FOPEN_CACHE_DIR              (1 << 3)
> > >  #define FOPEN_STREAM         (1 << 4)
> > >  #define FOPEN_NOFLUSH                (1 << 5)
> > > +#define FOPEN_FILE_CREATED   (1 << 6)
> > >
> > >  /**
> > >   * INIT request/reply flags
> > > @@ -537,6 +539,7 @@ enum fuse_opcode {
> > >       FUSE_SETUPMAPPING       = 48,
> > >       FUSE_REMOVEMAPPING      = 49,
> > >       FUSE_SYNCFS             = 50,
> > > +     FUSE_ATOMIC_CREATE      = 51,
> > >
> > >       /* CUSE specific operations */
> > >       CUSE_INIT               = 4096,
> > > --
> > > 2.17.1
> > >
> >
> 

