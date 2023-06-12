Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2C172B956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjFLH5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjFLH4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89461BC1;
        Mon, 12 Jun 2023 00:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC6C612B2;
        Mon, 12 Jun 2023 07:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C1DC433D2;
        Mon, 12 Jun 2023 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686556546;
        bh=2gPnJ150vj4k57eQRP9j48Yi0jmTwxujXueuKrnqsz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rb5fmTJkshXqhyuEJDJWsQHdNARr+xD1ws5jUkbTiCH/KhTwVWbFvE4pRQdW4vsBQ
         KvNUp/q5tg4IS91TxSIAEFf7v/KhDdOLuk/avhb7gfzIv/FhLONBy4E8ejlsCq3Mo+
         HXLf0gYjJvFGMRWxrnaSLx7/8kPlxItzxnWUJyf7z37qB+JkP0kiyT4F2jgp/Ibt6r
         dUe8I4UzuRWakp2zj0AdTroErS6qjrpueb8C7C8YTtvJSASlRMvBqGmecdYHqCr9BT
         Itf2jDu7BRLf7eOqZKNSQ8zv1B8k7DBn2Wt+E5Zt51UIRuf7EnZCNK5lF4QeZkUe/8
         VD/vey1au5oBQ==
Date:   Mon, 12 Jun 2023 09:55:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: use fake_file container for internal files with
 fake f_path
Message-ID: <20230612-fotoalben-drohung-914d38334dcf@brauner>
References: <20230609073239.957184-1-amir73il@gmail.com>
 <20230609073239.957184-2-amir73il@gmail.com>
 <20230609-umwandeln-zuhalten-dc8b985a7ad1@brauner>
 <CAOQ4uxgR5z3yGqJ7jna=r45_Gru5LePU57XG++Ew_9pGWKcwCQ@mail.gmail.com>
 <20230609-fakten-bildt-4bda22b203f8@brauner>
 <CAOQ4uxi0q1AawSbxC0Fo3+bifjW0EGSk0m-iBA54Nq+36_70wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi0q1AawSbxC0Fo3+bifjW0EGSk0m-iBA54Nq+36_70wg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 10:11:29PM +0300, Amir Goldstein wrote:
> On Fri, Jun 9, 2023 at 3:12 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Jun 09, 2023 at 02:57:20PM +0300, Amir Goldstein wrote:
> > > On Fri, Jun 9, 2023 at 2:32 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Fri, Jun 09, 2023 at 10:32:37AM +0300, Amir Goldstein wrote:
> > > > > Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> > > > > files, where overlayfs also puts a "fake" path in f_path - a path which
> > > > > is not on the same fs as f_inode.
> > > > >
> > > > > Allocate a container struct file_fake for those internal files, that
> > > > > will be used to hold the fake path qlong with the real path.
> > > > >
> > > > > This commit does not populate the extra fake_path field and leaves the
> > > > > overlayfs internal file's f_path fake.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  fs/cachefiles/namei.c |  2 +-
> > > > >  fs/file_table.c       | 85 +++++++++++++++++++++++++++++++++++--------
> > > > >  fs/internal.h         |  5 ++-
> > > > >  fs/namei.c            |  2 +-
> > > > >  fs/open.c             | 11 +++---
> > > > >  fs/overlayfs/file.c   |  2 +-
> > > > >  include/linux/fs.h    | 13 ++++---
> > > > >  7 files changed, 90 insertions(+), 30 deletions(-)
> > > > >
> > > > > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > > > > index 82219a8f6084..a71bdf2d03ba 100644
> > > > > --- a/fs/cachefiles/namei.c
> > > > > +++ b/fs/cachefiles/namei.c
> > > > > @@ -561,7 +561,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
> > > > >       path.mnt = cache->mnt;
> > > > >       path.dentry = dentry;
> > > > >       file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
> > > > > -                                d_backing_inode(dentry), cache->cache_cred);
> > > > > +                                &path, cache->cache_cred);
> > > > >       if (IS_ERR(file)) {
> > > > >               trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
> > > > >                                          PTR_ERR(file),
> > > > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > > > index 372653b92617..adc2a92faa52 100644
> > > > > --- a/fs/file_table.c
> > > > > +++ b/fs/file_table.c
> > > > > @@ -44,18 +44,48 @@ static struct kmem_cache *filp_cachep __read_mostly;
> > > > >
> > > > >  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
> > > > >
> > > > > +/* Container for file with optional fake path to display in /proc files */
> > > > > +struct file_fake {
> > > > > +     struct file file;
> > > > > +     struct path fake_path;
> > > > > +};
> > > > > +
> > > > > +static inline struct file_fake *file_fake(struct file *f)
> > > > > +{
> > > > > +     return container_of(f, struct file_fake, file);
> > > > > +}
> > > > > +
> > > > > +/* Returns fake_path if one exists, f_path otherwise */
> > > > > +const struct path *file_fake_path(struct file *f)
> > > > > +{
> > > > > +     struct file_fake *ff = file_fake(f);
> > > > > +
> > > > > +     if (!(f->f_mode & FMODE_FAKE_PATH) || !ff->fake_path.dentry)
> > > > > +             return &f->f_path;
> > > > > +
> > > > > +     return &ff->fake_path;
> > > > > +}
> > > > > +EXPORT_SYMBOL(file_fake_path);
> > > > > +
> > > > >  static void file_free_rcu(struct rcu_head *head)
> > > > >  {
> > > > >       struct file *f = container_of(head, struct file, f_rcuhead);
> > > > >
> > > > >       put_cred(f->f_cred);
> > > > > -     kmem_cache_free(filp_cachep, f);
> > > > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > > > +             kfree(file_fake(f));
> > > > > +     else
> > > > > +             kmem_cache_free(filp_cachep, f);
> > > > >  }
> > > > >
> > > > >  static inline void file_free(struct file *f)
> > > > >  {
> > > > > +     struct file_fake *ff = file_fake(f);
> > > > > +
> > > > >       security_file_free(f);
> > > > > -     if (!(f->f_mode & FMODE_NOACCOUNT))
> > > > > +     if (f->f_mode & FMODE_FAKE_PATH)
> > > > > +             path_put(&ff->fake_path);
> > > > > +     else
> > > > >               percpu_counter_dec(&nr_files);
> > > > >       call_rcu(&f->f_rcuhead, file_free_rcu);
> > > > >  }
> > > > > @@ -131,20 +161,15 @@ static int __init init_fs_stat_sysctls(void)
> > > > >  fs_initcall(init_fs_stat_sysctls);
> > > > >  #endif
> > > > >
> > > > > -static struct file *__alloc_file(int flags, const struct cred *cred)
> > > > > +static int init_file(struct file *f, int flags, const struct cred *cred)
> > > > >  {
> > > > > -     struct file *f;
> > > > >       int error;
> > > > >
> > > > > -     f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > > > > -     if (unlikely(!f))
> > > > > -             return ERR_PTR(-ENOMEM);
> > > > > -
> > > > >       f->f_cred = get_cred(cred);
> > > > >       error = security_file_alloc(f);
> > > > >       if (unlikely(error)) {
> > > > >               file_free_rcu(&f->f_rcuhead);
> > > > > -             return ERR_PTR(error);
> > > > > +             return error;
> > > > >       }
> > > > >
> > > > >       atomic_long_set(&f->f_count, 1);
> > > > > @@ -155,6 +180,22 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
> > > > >       f->f_mode = OPEN_FMODE(flags);
> > > > >       /* f->f_version: 0 */
> > > > >
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static struct file *__alloc_file(int flags, const struct cred *cred)
> > > > > +{
> > > > > +     struct file *f;
> > > > > +     int error;
> > > > > +
> > > > > +     f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
> > > > > +     if (unlikely(!f))
> > > > > +             return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +     error = init_file(f, flags, cred);
> > > > > +     if (unlikely(error))
> > > > > +             return ERR_PTR(error);
> > > > > +
> > > > >       return f;
> > > > >  }
> > > > >
> > > > > @@ -201,18 +242,32 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
> > > > >  }
> > > > >
> > > > >  /*
> > > > > - * Variant of alloc_empty_file() that doesn't check and modify nr_files.
> > > > > + * Variant of alloc_empty_file() that allocates a file_fake container
> > > > > + * and doesn't check and modify nr_files.
> > > > >   *
> > > > >   * Should not be used unless there's a very good reason to do so.
> > > > >   */
> > > > > -struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
> > > > > +struct file *alloc_empty_file_fake(const struct path *fake_path, int flags,
> > > > > +                                const struct cred *cred)
> > > > >  {
> > > > > -     struct file *f = __alloc_file(flags, cred);
> > > > > +     struct file_fake *ff;
> > > > > +     int error;
> > > > >
> > > > > -     if (!IS_ERR(f))
> > > > > -             f->f_mode |= FMODE_NOACCOUNT;
> > > > > +     ff = kzalloc(sizeof(struct file_fake), GFP_KERNEL);
> > > > > +     if (unlikely(!ff))
> > > > > +             return ERR_PTR(-ENOMEM);
> > > > >
> > > > > -     return f;
> > > > > +     error = init_file(&ff->file, flags, cred);
> > > > > +     if (unlikely(error))
> > > > > +             return ERR_PTR(error);
> > > > > +
> > > > > +     ff->file.f_mode |= FMODE_FAKE_PATH;
> > > > > +     if (fake_path) {
> > > > > +             path_get(fake_path);
> > > > > +             ff->fake_path = *fake_path;
> > > > > +     }
> > > >
> > > > Hm, I see that this check is mostly done for vfs_tmpfile_open() which
> > > > only fills in file->f_path in vfs_tmpfile() but leaves ff->fake_path
> > > > NULL.
> > > >
> > > > So really I think having FMODE_FAKE_PATH set but ff->fake_path be NULL
> > > > is an invitation for NULL derefs sooner or later. I would simply
> > > > document that it's required to set ff->fake_path. For callers such as
> > > > vfs_tmpfile_open() it can just be path itself. IOW, vfs_tmpfile_open()
> > > > should set ff->fake_path to file->f_path.
> > >
> > > Makes sense.
> > > I also took the liberty to re-arrange vfs_tmpfile_open() without the
> > > unneeded if (!error) { nesting depth.
> >
> > Yes, please. I had a rough sketch just for my own amusement...
> >
> > fs/namei.c
> >   struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
> >                                 const struct path *parentpath, umode_t mode,
> >                                 int open_flag, const struct cred *cred)
> >   {
> >           struct file *file;
> >           int error;
> >
> >           file = alloc_empty_file_fake(open_flag, cred);
> >           if (IS_ERR(file))
> >                   return file;
> >
> >           error = vfs_tmpfile(idmap, parentpath, file, mode);
> >           if (error) {
> >                   fput(file);
> >                   return ERR_PTR(error);
> >           }
> >
> >           return file_set_fake_path(file, &file->f_path);
> 
> FYI, this is not enough to guarantee that the fake_path cannot
> be empty, for example in fput() above.
> So I did keep the real_path empty in this case in v3 and
> I have an accessor that verifies that real_path is not empty
> before returning it.

Ok, I'm just making it to v3 now.
