Return-Path: <linux-fsdevel+bounces-31910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9A99D58D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 19:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56073283198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D731C232D;
	Mon, 14 Oct 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfSWxsVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F182729A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926672; cv=none; b=nls3eNGfJ1jEYCga6yPiEE7WtQ89Sj2w7S3WEPeLAr6KzHUnc0FPKJr7Sg4yAQ9zEtnZ8naLV6VK2nbdIcU7yHzfPkqBTk0UhyYEej9hTLzh7wxAhMtaKOz8s3J9kSEEMxr/E4eJtNCx9dMm+n/XJk2R3lGFZdk5lGo3fFFnc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926672; c=relaxed/simple;
	bh=pJ8KdWl1vbNcSex5xg+0BSxoAa8GdI7O9ks3zbD65hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5566GH1NV/Bd60kmaP8h2o3K2sRSI943m2GgTkmMtQYrHE9gLXSZeYOEwy01ZD2pCZ6oiBP45wBy4KTfHQveW/YR6JbzQ/DhTVUMGLbWJof5K8t4Z6aeFwJgauwLZoCAqQe5C3ksL0ikiWR0to9T/YUQxEwwOMApqZ3kkwVXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfSWxsVo; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a48ad60106so403397137.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728926669; x=1729531469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9d6Lt5yhR8qSLdnfYruYJJ7zyIejDaH/bNnbV3qrIk=;
        b=kfSWxsVop2Os8nYstjzPvErKqAyLXVggRPRlop8RA+7NBrSBIPcYTZQ7EOaCvVeQLQ
         PzGhdQkdGVlCrg6/v6l1wP4B6sSJmFd9X/+7l/EQqoS7sVm9zfxNi3voYiG8C4t/t7tb
         zXKC5RKrmbwNVB/3rlniTWTv/LIqcC8KTRFXQelSkdK0AeO5eQZ3mRupRdxnuOk7JBIA
         m0LsnQ5CrFtcSI3prG7VwZGYtGUIsPTgvDLD7vcnhlcxrlqMnUgk6wMR0sAJxTzZ2AT5
         QPDdQ4xOisxbCUWN7EW65Bjk6V2LVftcTe3sDzBlekDRgvErtuScdAJ7IhZbAAXr4RVy
         0n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728926669; x=1729531469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9d6Lt5yhR8qSLdnfYruYJJ7zyIejDaH/bNnbV3qrIk=;
        b=tT1BrM4SwgsUuxzouwoF9icfDd7dmTLNB1Yc9NqOXgWrxnEoxSvmkVvM2p7W3e/soQ
         dKMp8B1ZooXj95rrOIIupVBdZ9Eq2dl3xZHZoz7jWefamIpiXSuIpsV+xlvuldgMOs3/
         rgFPqTWkHnAE4lWVrUZv/zbEeagFF7Uka+PUkFgL/74+0JZ8UQVfWiiIRqKcVFW5Qqml
         3zlvIrD08kgeg3iaJoeJXtcWYzx1+1SpcWR0tgo3MvMcwrjbM44diFK2T5uRh8PNeZ+Y
         odUUlZGojTdoJx6kt1TaMk2V/fCOL9Pf3s/Lf08sbCPU7kbP4mMHelRot4jTpsYmMovr
         MH4w==
X-Forwarded-Encrypted: i=1; AJvYcCUK965crqHzcPhuDN1yZd+laInznG+1WnWaEBcgyMTQyvsP5Kb17yrg10dBbhFrtg9hxZrrOWRMzicFjl9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+E1XaLp4x5+61x7uB4Sv97L+jEb1GdSFvpajUBrIVV3wDGzi
	GxHB84WJKWhBsuUIRxOPhyw/GhIC8R8rlsSZpX1mEVnv2l6CmdClUvnRwOITT9oyq6EpJkdvYbh
	zuVwLTbSvMIu+uF2XsgEv+WlCGKQ=
X-Google-Smtp-Source: AGHT+IEeeW+z6uzXKTojIbLml75slpZT7o6F/6LksIjdrdFMipXF82ot9LYjN2udV3XdgBrxCR+QJhCAGoYDVIK6pX4=
X-Received: by 2002:a05:6102:a49:b0:4a4:79cf:be83 with SMTP id
 ada2fe7eead31-4a479cfc130mr4497825137.10.1728926668528; Mon, 14 Oct 2024
 10:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011223434.1307300-1-joannelkoong@gmail.com>
 <20241011223434.1307300-3-joannelkoong@gmail.com> <dwosyxxos65perwq4xbc5lyuszlrfh653q2gwkggmkgq7dxkcl@uvldhzaphfzz>
In-Reply-To: <dwosyxxos65perwq4xbc5lyuszlrfh653q2gwkggmkgq7dxkcl@uvldhzaphfzz>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 14 Oct 2024 10:24:17 -0700
Message-ID: <CAJnrk1aOeJPrpTj+eHU-2wv8s-KegRt5=Pg_HV=AsHpyLQ=HGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: remove tmp folio for writebacks and internal rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 9:56=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Oct 11, 2024 at 03:34:34PM GMT, Joanne Koong wrote:
> > Currently, we allocate and copy data to a temporary folio when
> > handling writeback in order to mitigate the following deadlock scenario
> > that may arise if reclaim waits on writeback to complete:
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> >
> > To work around this, we allocate a temporary folio and copy over the
> > original folio to the temporary folio so that writeback can be
> > immediately cleared on the original folio. This additionally requires u=
s
> > to maintain an internal rb tree to keep track of writeback state on the
> > temporary folios.
> >
> > This change sets the address space operations flag
> > ASOP_NO_RECLAIM_IN_WRITEBACK so that FUSE folios are not reclaimed and
>
> I couldn't find where ASOP_NO_RECLAIM_IN_WRITEBACK is being set for
> fuse.

Agh this patch was from an earlier branch in my tree and I forgot to
add this line when I patched it in:

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9fee9f3062db..192b9f5f6b25 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3094,6 +3094,7 @@ static const struct address_space_operations
fuse_file_aops  =3D {
        .direct_IO      =3D fuse_direct_IO,
        .write_begin    =3D fuse_write_begin,
        .write_end      =3D fuse_write_end,
+       .asop_flags     =3D ASOP_NO_RECLAIM_IN_WRITEBACK,
 };

sorry about that. With your suggestion of adding the flag instead to
the "enum mapping_flags", I'll be setting it in v2 in the
fuse_init_file_inode() function.


Thanks,
Joanne

>
> > waited on while in writeback, and removes the temporary folio +
> > extra copying and the internal rb tree.
> >
> > fio benchmarks --
> > (using averages observed from 10 runs, throwing away outliers)
> >
> > Setup:
> > sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
> >  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=3D4=
 -o source=3D~/tmp_mount ~/fuse_mount
> >
> > fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1M}=
 --size=3D2G
> > --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/roo=
t/fuse_mount
> >
> >         bs =3D  1k          4k            1M
> > Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> > After   341 MiB/s     2246 MiB/s     2685 MiB/s
> > % diff        -3%          23%         45%
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 321 +++++--------------------------------------------
> >  1 file changed, 27 insertions(+), 294 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 4304e44f32e6..9fee9f3062db 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -415,74 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_o=
wner_t id)
> >
> >  struct fuse_writepage_args {
> >       struct fuse_io_args ia;
> > -     struct rb_node writepages_entry;
> >       struct list_head queue_entry;
> > -     struct fuse_writepage_args *next;
> >       struct inode *inode;
> >       struct fuse_sync_bucket *bucket;
> >  };
> >
> > -static struct fuse_writepage_args *fuse_find_writeback(struct fuse_ino=
de *fi,
> > -                                         pgoff_t idx_from, pgoff_t idx=
_to)
> > -{
> > -     struct rb_node *n;
> > -
> > -     n =3D fi->writepages.rb_node;
> > -
> > -     while (n) {
> > -             struct fuse_writepage_args *wpa;
> > -             pgoff_t curr_index;
> > -
> > -             wpa =3D rb_entry(n, struct fuse_writepage_args, writepage=
s_entry);
> > -             WARN_ON(get_fuse_inode(wpa->inode) !=3D fi);
> > -             curr_index =3D wpa->ia.write.in.offset >> PAGE_SHIFT;
> > -             if (idx_from >=3D curr_index + wpa->ia.ap.num_pages)
> > -                     n =3D n->rb_right;
> > -             else if (idx_to < curr_index)
> > -                     n =3D n->rb_left;
> > -             else
> > -                     return wpa;
> > -     }
> > -     return NULL;
> > -}
> > -
> > -/*
> > - * Check if any page in a range is under writeback
> > - */
> > -static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_f=
rom,
> > -                                pgoff_t idx_to)
> > -{
> > -     struct fuse_inode *fi =3D get_fuse_inode(inode);
> > -     bool found;
> > -
> > -     if (RB_EMPTY_ROOT(&fi->writepages))
> > -             return false;
> > -
> > -     spin_lock(&fi->lock);
> > -     found =3D fuse_find_writeback(fi, idx_from, idx_to);
> > -     spin_unlock(&fi->lock);
> > -
> > -     return found;
> > -}
> > -
> > -static inline bool fuse_page_is_writeback(struct inode *inode, pgoff_t=
 index)
> > -{
> > -     return fuse_range_is_writeback(inode, index, index);
> > -}
> > -
> > -/*
> > - * Wait for page writeback to be completed.
> > - *
> > - * Since fuse doesn't rely on the VM writeback tracking, this has to
> > - * use some other means.
> > - */
> > -static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t i=
ndex)
> > -{
> > -     struct fuse_inode *fi =3D get_fuse_inode(inode);
> > -
> > -     wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index))=
;
> > -}
> > -
> >  /*
> >   * Wait for all pending writepages on the inode to finish.
> >   *
> > @@ -876,7 +813,7 @@ static int fuse_do_readpage(struct file *file, stru=
ct page *page)
> >        * page-cache page, so make sure we read a properly synced
> >        * page.
> >        */
> > -     fuse_wait_on_page_writeback(inode, page->index);
> > +     folio_wait_writeback(page_folio(page));
> >
> >       attr_ver =3D fuse_get_attr_version(fm->fc);
> >
> > @@ -1024,8 +961,7 @@ static void fuse_readahead(struct readahead_contro=
l *rac)
> >               ap =3D &ia->ap;
> >               nr_pages =3D __readahead_batch(rac, ap->pages, nr_pages);
> >               for (i =3D 0; i < nr_pages; i++) {
> > -                     fuse_wait_on_page_writeback(inode,
> > -                                                 readahead_index(rac) =
+ i);
> > +                     folio_wait_writeback(page_folio(ap->pages[i]));
> >                       ap->descs[i].length =3D PAGE_SIZE;
> >               }
> >               ap->num_pages =3D nr_pages;
> > @@ -1147,7 +1083,7 @@ static ssize_t fuse_send_write_pages(struct fuse_=
io_args *ia,
> >       int err;
> >
> >       for (i =3D 0; i < ap->num_pages; i++)
> > -             fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
> > +             folio_wait_writeback(page_folio(ap->pages[i]));
> >
> >       fuse_write_args_fill(ia, ff, pos, count);
> >       ia->write.in.flags =3D fuse_write_flags(iocb);
> > @@ -1583,7 +1519,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, s=
truct iov_iter *iter,
> >                       return res;
> >               }
> >       }
> > -     if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> > +     if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + cou=
nt - 1))) {
> >               if (!write)
> >                       inode_lock(inode);
> >               fuse_sync_writes(inode);
> > @@ -1780,13 +1716,17 @@ static ssize_t fuse_splice_write(struct pipe_in=
ode_info *pipe, struct file *out,
> >  static void fuse_writepage_free(struct fuse_writepage_args *wpa)
> >  {
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> > +     struct folio *folio;
> >       int i;
> >
> >       if (wpa->bucket)
> >               fuse_sync_bucket_dec(wpa->bucket);
> >
> > -     for (i =3D 0; i < ap->num_pages; i++)
> > -             __free_page(ap->pages[i]);
> > +     for (i =3D 0; i < ap->num_pages; i++) {
> > +             folio =3D page_folio(ap->pages[i]);
> > +             folio_end_writeback(folio);
> > +             folio_put(folio);
> > +     }
> >
> >       fuse_file_put(wpa->ia.ff, false);
> >
> > @@ -1799,7 +1739,7 @@ static void fuse_writepage_finish_stat(struct ino=
de *inode, struct page *page)
> >       struct backing_dev_info *bdi =3D inode_to_bdi(inode);
> >
> >       dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> > -     dec_node_page_state(page, NR_WRITEBACK_TEMP);
> > +     dec_node_page_state(page, NR_WRITEBACK);
> >       wb_writeout_inc(&bdi->wb);
> >  }
> >
> > @@ -1822,7 +1762,6 @@ static void fuse_send_writepage(struct fuse_mount=
 *fm,
> >  __releases(fi->lock)
> >  __acquires(fi->lock)
> >  {
> > -     struct fuse_writepage_args *aux, *next;
> >       struct fuse_inode *fi =3D get_fuse_inode(wpa->inode);
> >       struct fuse_write_in *inarg =3D &wpa->ia.write.in;
> >       struct fuse_args *args =3D &wpa->ia.ap.args;
> > @@ -1858,18 +1797,8 @@ __acquires(fi->lock)
> >
> >   out_free:
> >       fi->writectr--;
> > -     rb_erase(&wpa->writepages_entry, &fi->writepages);
> >       fuse_writepage_finish(wpa);
> >       spin_unlock(&fi->lock);
> > -
> > -     /* After rb_erase() aux request list is private */
> > -     for (aux =3D wpa->next; aux; aux =3D next) {
> > -             next =3D aux->next;
> > -             aux->next =3D NULL;
> > -             fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0=
]);
> > -             fuse_writepage_free(aux);
> > -     }
> > -
> >       fuse_writepage_free(wpa);
> >       spin_lock(&fi->lock);
> >  }
> > @@ -1897,43 +1826,6 @@ __acquires(fi->lock)
> >       }
> >  }
> >
> > -static struct fuse_writepage_args *fuse_insert_writeback(struct rb_roo=
t *root,
> > -                                             struct fuse_writepage_arg=
s *wpa)
> > -{
> > -     pgoff_t idx_from =3D wpa->ia.write.in.offset >> PAGE_SHIFT;
> > -     pgoff_t idx_to =3D idx_from + wpa->ia.ap.num_pages - 1;
> > -     struct rb_node **p =3D &root->rb_node;
> > -     struct rb_node  *parent =3D NULL;
> > -
> > -     WARN_ON(!wpa->ia.ap.num_pages);
> > -     while (*p) {
> > -             struct fuse_writepage_args *curr;
> > -             pgoff_t curr_index;
> > -
> > -             parent =3D *p;
> > -             curr =3D rb_entry(parent, struct fuse_writepage_args,
> > -                             writepages_entry);
> > -             WARN_ON(curr->inode !=3D wpa->inode);
> > -             curr_index =3D curr->ia.write.in.offset >> PAGE_SHIFT;
> > -
> > -             if (idx_from >=3D curr_index + curr->ia.ap.num_pages)
> > -                     p =3D &(*p)->rb_right;
> > -             else if (idx_to < curr_index)
> > -                     p =3D &(*p)->rb_left;
> > -             else
> > -                     return curr;
> > -     }
> > -
> > -     rb_link_node(&wpa->writepages_entry, parent, p);
> > -     rb_insert_color(&wpa->writepages_entry, root);
> > -     return NULL;
> > -}
> > -
> > -static void tree_insert(struct rb_root *root, struct fuse_writepage_ar=
gs *wpa)
> > -{
> > -     WARN_ON(fuse_insert_writeback(root, wpa));
> > -}
> > -
> >  static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args=
 *args,
> >                              int error)
> >  {
> > @@ -1953,41 +1845,6 @@ static void fuse_writepage_end(struct fuse_mount=
 *fm, struct fuse_args *args,
> >       if (!fc->writeback_cache)
> >               fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
> >       spin_lock(&fi->lock);
> > -     rb_erase(&wpa->writepages_entry, &fi->writepages);
> > -     while (wpa->next) {
> > -             struct fuse_mount *fm =3D get_fuse_mount(inode);
> > -             struct fuse_write_in *inarg =3D &wpa->ia.write.in;
> > -             struct fuse_writepage_args *next =3D wpa->next;
> > -
> > -             wpa->next =3D next->next;
> > -             next->next =3D NULL;
> > -             tree_insert(&fi->writepages, next);
> > -
> > -             /*
> > -              * Skip fuse_flush_writepages() to make it easy to crop r=
equests
> > -              * based on primary request size.
> > -              *
> > -              * 1st case (trivial): there are no concurrent activities=
 using
> > -              * fuse_set/release_nowrite.  Then we're on safe side bec=
ause
> > -              * fuse_flush_writepages() would call fuse_send_writepage=
()
> > -              * anyway.
> > -              *
> > -              * 2nd case: someone called fuse_set_nowrite and it is wa=
iting
> > -              * now for completion of all in-flight requests.  This ha=
ppens
> > -              * rarely and no more than once per page, so this should =
be
> > -              * okay.
> > -              *
> > -              * 3rd case: someone (e.g. fuse_do_setattr()) is in the m=
iddle
> > -              * of fuse_set_nowrite..fuse_release_nowrite section.  Th=
e fact
> > -              * that fuse_set_nowrite returned implies that all in-fli=
ght
> > -              * requests were completed along with all of their second=
ary
> > -              * requests.  Further primary requests are blocked by neg=
ative
> > -              * writectr.  Hence there cannot be any in-flight request=
s and
> > -              * no invocations of fuse_writepage_end() while we're in
> > -              * fuse_set_nowrite..fuse_release_nowrite section.
> > -              */
> > -             fuse_send_writepage(fm, next, inarg->offset + inarg->size=
);
> > -     }
> >       fi->writectr--;
> >       fuse_writepage_finish(wpa);
> >       spin_unlock(&fi->lock);
> > @@ -2074,19 +1931,18 @@ static void fuse_writepage_add_to_bucket(struct=
 fuse_conn *fc,
> >  }
> >
> >  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *=
wpa, struct folio *folio,
> > -                                       struct folio *tmp_folio, uint32=
_t page_index)
> > +                                       uint32_t page_index)
> >  {
> >       struct inode *inode =3D folio->mapping->host;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >
> > -     folio_copy(tmp_folio, folio);
> > -
> > -     ap->pages[page_index] =3D &tmp_folio->page;
> > +     folio_get(folio);
> > +     ap->pages[page_index] =3D &folio->page;
> >       ap->descs[page_index].offset =3D 0;
> >       ap->descs[page_index].length =3D PAGE_SIZE;
> >
> >       inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> > -     inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
> > +     inc_node_page_state(&folio->page, NR_WRITEBACK);
> >  }
> >
> >  static struct fuse_writepage_args *fuse_writepage_args_setup(struct fo=
lio *folio,
> > @@ -2121,18 +1977,12 @@ static int fuse_writepage_locked(struct folio *=
folio)
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> >       struct fuse_writepage_args *wpa;
> >       struct fuse_args_pages *ap;
> > -     struct folio *tmp_folio;
> >       struct fuse_file *ff;
> > -     int error =3D -ENOMEM;
> > -
> > -     tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> > -     if (!tmp_folio)
> > -             goto err;
> > +     int error =3D -EIO;
> >
> > -     error =3D -EIO;
> >       ff =3D fuse_write_file_get(fi);
> >       if (!ff)
> > -             goto err_nofile;
> > +             goto err;
> >
> >       wpa =3D fuse_writepage_args_setup(folio, ff);
> >       error =3D -ENOMEM;
> > @@ -2143,22 +1993,17 @@ static int fuse_writepage_locked(struct folio *=
folio)
> >       ap->num_pages =3D 1;
> >
> >       folio_start_writeback(folio);
> > -     fuse_writepage_args_page_fill(wpa, folio, tmp_folio, 0);
> > +     fuse_writepage_args_page_fill(wpa, folio, 0);
> >
> >       spin_lock(&fi->lock);
> > -     tree_insert(&fi->writepages, wpa);
> >       list_add_tail(&wpa->queue_entry, &fi->queued_writes);
> >       fuse_flush_writepages(inode);
> >       spin_unlock(&fi->lock);
> >
> > -     folio_end_writeback(folio);
> > -
> >       return 0;
> >
> >  err_writepage_args:
> >       fuse_file_put(ff, false);
> > -err_nofile:
> > -     folio_put(tmp_folio);
> >  err:
> >       mapping_set_error(folio->mapping, error);
> >       return error;
> > @@ -2168,7 +2013,6 @@ struct fuse_fill_wb_data {
> >       struct fuse_writepage_args *wpa;
> >       struct fuse_file *ff;
> >       struct inode *inode;
> > -     struct page **orig_pages;
> >       unsigned int max_pages;
> >  };
> >
> > @@ -2203,68 +2047,11 @@ static void fuse_writepages_send(struct fuse_fi=
ll_wb_data *data)
> >       struct fuse_writepage_args *wpa =3D data->wpa;
> >       struct inode *inode =3D data->inode;
> >       struct fuse_inode *fi =3D get_fuse_inode(inode);
> > -     int num_pages =3D wpa->ia.ap.num_pages;
> > -     int i;
> >
> >       spin_lock(&fi->lock);
> >       list_add_tail(&wpa->queue_entry, &fi->queued_writes);
> >       fuse_flush_writepages(inode);
> >       spin_unlock(&fi->lock);
> > -
> > -     for (i =3D 0; i < num_pages; i++)
> > -             end_page_writeback(data->orig_pages[i]);
> > -}
> > -
> > -/*
> > - * Check under fi->lock if the page is under writeback, and insert it =
onto the
> > - * rb_tree if not. Otherwise iterate auxiliary write requests, to see =
if there's
> > - * one already added for a page at this offset.  If there's none, then=
 insert
> > - * this new request onto the auxiliary list, otherwise reuse the exist=
ing one by
> > - * swapping the new temp page with the old one.
> > - */
> > -static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
> > -                            struct page *page)
> > -{
> > -     struct fuse_inode *fi =3D get_fuse_inode(new_wpa->inode);
> > -     struct fuse_writepage_args *tmp;
> > -     struct fuse_writepage_args *old_wpa;
> > -     struct fuse_args_pages *new_ap =3D &new_wpa->ia.ap;
> > -
> > -     WARN_ON(new_ap->num_pages !=3D 0);
> > -     new_ap->num_pages =3D 1;
> > -
> > -     spin_lock(&fi->lock);
> > -     old_wpa =3D fuse_insert_writeback(&fi->writepages, new_wpa);
> > -     if (!old_wpa) {
> > -             spin_unlock(&fi->lock);
> > -             return true;
> > -     }
> > -
> > -     for (tmp =3D old_wpa->next; tmp; tmp =3D tmp->next) {
> > -             pgoff_t curr_index;
> > -
> > -             WARN_ON(tmp->inode !=3D new_wpa->inode);
> > -             curr_index =3D tmp->ia.write.in.offset >> PAGE_SHIFT;
> > -             if (curr_index =3D=3D page->index) {
> > -                     WARN_ON(tmp->ia.ap.num_pages !=3D 1);
> > -                     swap(tmp->ia.ap.pages[0], new_ap->pages[0]);
> > -                     break;
> > -             }
> > -     }
> > -
> > -     if (!tmp) {
> > -             new_wpa->next =3D old_wpa->next;
> > -             old_wpa->next =3D new_wpa;
> > -     }
> > -
> > -     spin_unlock(&fi->lock);
> > -
> > -     if (tmp) {
> > -             fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[=
0]);
> > -             fuse_writepage_free(new_wpa);
> > -     }
> > -
> > -     return false;
> >  }
> >
> >  static bool fuse_writepage_need_send(struct fuse_conn *fc, struct page=
 *page,
> > @@ -2273,15 +2060,6 @@ static bool fuse_writepage_need_send(struct fuse=
_conn *fc, struct page *page,
> >  {
> >       WARN_ON(!ap->num_pages);
> >
> > -     /*
> > -      * Being under writeback is unlikely but possible.  For example d=
irect
> > -      * read to an mmaped fuse file will set the page dirty twice; onc=
e when
> > -      * the pages are faulted with get_user_pages(), and then after th=
e read
> > -      * completed.
> > -      */
> > -     if (fuse_page_is_writeback(data->inode, page->index))
> > -             return true;
> > -
> >       /* Reached max pages */
> >       if (ap->num_pages =3D=3D fc->max_pages)
> >               return true;
> > @@ -2291,7 +2069,7 @@ static bool fuse_writepage_need_send(struct fuse_=
conn *fc, struct page *page,
> >               return true;
> >
> >       /* Discontinuity */
> > -     if (data->orig_pages[ap->num_pages - 1]->index + 1 !=3D page->ind=
ex)
> > +     if (ap->pages[ap->num_pages - 1]->index + 1 !=3D page->index)
> >               return true;
> >
> >       /* Need to grow the pages array?  If so, did the expansion fail? =
*/
> > @@ -2308,9 +2086,7 @@ static int fuse_writepages_fill(struct folio *fol=
io,
> >       struct fuse_writepage_args *wpa =3D data->wpa;
> >       struct fuse_args_pages *ap =3D &wpa->ia.ap;
> >       struct inode *inode =3D data->inode;
> > -     struct fuse_inode *fi =3D get_fuse_inode(inode);
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> > -     struct folio *tmp_folio;
> >       int err;
> >
> >       if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) =
{
> > @@ -2318,54 +2094,23 @@ static int fuse_writepages_fill(struct folio *f=
olio,
> >               data->wpa =3D NULL;
> >       }
> >
> > -     err =3D -ENOMEM;
> > -     tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> > -     if (!tmp_folio)
> > -             goto out_unlock;
> > -
> > -     /*
> > -      * The page must not be redirtied until the writeout is completed
> > -      * (i.e. userspace has sent a reply to the write request).  Other=
wise
> > -      * there could be more than one temporary page instance for each =
real
> > -      * page.
> > -      *
> > -      * This is ensured by holding the page lock in page_mkwrite() whi=
le
> > -      * checking fuse_page_is_writeback().  We already hold the page l=
ock
> > -      * since clear_page_dirty_for_io() and keep it held until we add =
the
> > -      * request to the fi->writepages list and increment ap->num_pages=
.
> > -      * After this fuse_page_is_writeback() will indicate that the pag=
e is
> > -      * under writeback, so we can release the page lock.
> > -      */
> >       if (data->wpa =3D=3D NULL) {
> >               err =3D -ENOMEM;
> >               wpa =3D fuse_writepage_args_setup(folio, data->ff);
> > -             if (!wpa) {
> > -                     folio_put(tmp_folio);
> > +             if (!wpa)
> >                       goto out_unlock;
> > -             }
> >               fuse_file_get(wpa->ia.ff);
> >               data->max_pages =3D 1;
> >               ap =3D &wpa->ia.ap;
> >       }
> >       folio_start_writeback(folio);
> >
> > -     fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_page=
s);
> > -     data->orig_pages[ap->num_pages] =3D &folio->page;
> > +     fuse_writepage_args_page_fill(wpa, folio, ap->num_pages);
> >
> >       err =3D 0;
> > -     if (data->wpa) {
> > -             /*
> > -              * Protected by fi->lock against concurrent access by
> > -              * fuse_page_is_writeback().
> > -              */
> > -             spin_lock(&fi->lock);
> > -             ap->num_pages++;
> > -             spin_unlock(&fi->lock);
> > -     } else if (fuse_writepage_add(wpa, &folio->page)) {
> > +     ap->num_pages++;
> > +     if (!data->wpa)
> >               data->wpa =3D wpa;
> > -     } else {
> > -             folio_end_writeback(folio);
> > -     }
> >  out_unlock:
> >       folio_unlock(folio);
> >
> > @@ -2394,21 +2139,12 @@ static int fuse_writepages(struct address_space=
 *mapping,
> >       if (!data.ff)
> >               return -EIO;
> >
> > -     err =3D -ENOMEM;
> > -     data.orig_pages =3D kcalloc(fc->max_pages,
> > -                               sizeof(struct page *),
> > -                               GFP_NOFS);
> > -     if (!data.orig_pages)
> > -             goto out;
> > -
> >       err =3D write_cache_pages(mapping, wbc, fuse_writepages_fill, &da=
ta);
> >       if (data.wpa) {
> >               WARN_ON(!data.wpa->ia.ap.num_pages);
> >               fuse_writepages_send(&data);
> >       }
> >
> > -     kfree(data.orig_pages);
> > -out:
> >       fuse_file_put(data.ff, false);
> >       return err;
> >  }
> > @@ -2433,7 +2169,7 @@ static int fuse_write_begin(struct file *file, st=
ruct address_space *mapping,
> >       if (IS_ERR(folio))
> >               goto error;
> >
> > -     fuse_wait_on_page_writeback(mapping->host, folio->index);
> > +     folio_wait_writeback(folio);
> >
> >       if (folio_test_uptodate(folio) || len >=3D folio_size(folio))
> >               goto success;
> > @@ -2497,13 +2233,11 @@ static int fuse_launder_folio(struct folio *fol=
io)
> >  {
> >       int err =3D 0;
> >       if (folio_clear_dirty_for_io(folio)) {
> > -             struct inode *inode =3D folio->mapping->host;
> > -
> >               /* Serialize with pending writeback for the same page */
> > -             fuse_wait_on_page_writeback(inode, folio->index);
> > +             folio_wait_writeback(folio);
> >               err =3D fuse_writepage_locked(folio);
> >               if (!err)
> > -                     fuse_wait_on_page_writeback(inode, folio->index);
> > +                     folio_wait_writeback(folio);
> >       }
> >       return err;
> >  }
> > @@ -2547,7 +2281,7 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fau=
lt *vmf)
> >               return VM_FAULT_NOPAGE;
> >       }
> >
> > -     fuse_wait_on_page_writeback(inode, page->index);
> > +     folio_wait_writeback(page_folio(page));
> >       return VM_FAULT_LOCKED;
> >  }
> >
> > @@ -3375,7 +3109,6 @@ void fuse_init_file_inode(struct inode *inode, un=
signed int flags)
> >       fi->iocachectr =3D 0;
> >       init_waitqueue_head(&fi->page_waitq);
> >       init_waitqueue_head(&fi->direct_io_waitq);
> > -     fi->writepages =3D RB_ROOT;
> >
> >       if (IS_ENABLED(CONFIG_FUSE_DAX))
> >               fuse_dax_inode_init(inode, flags);
> > --
> > 2.43.5
> >

