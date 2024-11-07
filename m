Return-Path: <linux-fsdevel+bounces-33980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352799C1280
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FD3283988
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427291F12F5;
	Thu,  7 Nov 2024 23:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvuBWEi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE841E25F5
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022529; cv=none; b=pzCWy7TqhsGySTbYqAcPO4p/+FQkJS6YR+SgvdymVHaZ8zn5UusGtMD91licYxrELh8DzZameVty2QHEDVGSXvEgKO4aRwF7YQKoYocvSWptieFD4y4qu00EpaDDFz2ZCh5HWVoHLNnkga51orK+yww6FwLkMD68TlaNZjaZ164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022529; c=relaxed/simple;
	bh=qSsI9xFoH++Yt0GhVOmtX8h2WlzDAJJBgrC7nEslX9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOKbhEpU08yCeunT1S66nd5uteWIKUR63Qso/E/446uKkQB0vDyY+2fT3unl9wgy4sZM+ayiypKwdcOuJENvjFDyvnEuVeABosVC23sZvJ74IKMfJwC3m9/2rRWqP1CGyLh5nPI1IqapAhKzfZcgawE6Qzx3uBGNZLWOWcZPN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvuBWEi2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460ad98b043so13677921cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731022526; x=1731627326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAlgOi/JMBLzPHgNog4LkgN5O/zebTGjimFoFemW6JU=;
        b=VvuBWEi2WmOfpWLQ753Up4sy/0jMSlh/8FN6RkHxtb68RJgjCn4JKJBw6Qo7XioNCk
         pD+Bpa+Btddc18101kQZhEqq0Bj2kGfXowKFQpFE1TabaY2zPmf4BtScWcrlccIUPUae
         NLOoj/prBBGpssv5Wt693HoUkV44apvCCzx3FUSPkKe60HiSalGsOJZ7M7S8Qwy6MRCj
         Zqg+8ETV1kvwFUqci8bL684KClbyHalMSLG1onIq4nrt5Ws0uiP+CdqdVWuRp7LQ7vvQ
         zxosc5bFc6Dv8YCcvSHlHzfEeLByaUprXQS4GBDhHJA3G7EutYKRdkUdkZI6hoU4HlUQ
         ZPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022526; x=1731627326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAlgOi/JMBLzPHgNog4LkgN5O/zebTGjimFoFemW6JU=;
        b=RzbztoTzmBZvA7g9TgumbhWFmeIXjc6jZ4ICb4ELu/22+qVrEjHtei5A5QpsgojrOF
         AKxcAmflA3AhTWzPo/EwPF8DsrGxTj+rAOC+Y6j9XSfGKXCRJ3ORi8mk3d6nS66MYIIk
         qIaxc4EpCpGowENf+vv9u5VkKbRtq9pajEcPA01GKxuPVyTv9/kpCx9gRWZ7Pa9STpA8
         h5ifwrQ3EFdS1ydovn9+mb9yfhhsE6hJqyjx1NeZ6lqrMppCextPX/S6Eew4Bv1e7VxM
         3EJYTZ0BkccoaOROrMbk6LzQatZQvVZ10+CybdBB1DegpBIfCo5GHPYOrQtW6Ju8fpk4
         5C9g==
X-Forwarded-Encrypted: i=1; AJvYcCVeS2wfPOvfS7t6BBOoOCg7jXv78N4XW2PTqJ+TU/xGAvLO88O1DxxliWwXFG90SMav2mVEscnrUVQSHk9q@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZ2+TD77thtd75RsH/4ppRftppSS8MLhz6nITsfg8W8ymqtJN
	2q14WOlBdEzlcTA63esaBttY/oiR3T6OVoPYDUkztABBOzGH51OnEYNLDlFx9GDupoFfFMsscQF
	NJvEJdYP12eK5jVKVtgl7+m/Y5AI=
X-Google-Smtp-Source: AGHT+IGe24N4nE6CFY9u4cB8BgqZSa+qwq0iIXCtpQ47b79YWCQaTFG69zcuJkiC0YPapbS/7CyACwiJa3tHQL2Gk+I=
X-Received: by 2002:ac8:7c4d:0:b0:460:8993:cab4 with SMTP id
 d75a77b69052e-46309ba7e53mr14077791cf.23.1731022526060; Thu, 07 Nov 2024
 15:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107191618.2011146-1-joannelkoong@gmail.com> <20241107191618.2011146-8-joannelkoong@gmail.com>
In-Reply-To: <20241107191618.2011146-8-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 7 Nov 2024 15:35:15 -0800
Message-ID: <CAJnrk1Zsn1mLd5zSvuGexcFowwnAY5XN-+2Assg0MARy3BxTHw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] fuse: remove tmp folio for writebacks and internal
 rb tree
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:17=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Currently, we allocate and copy data to a temporary folio when
> handling writeback in order to mitigate the following deadlock scenario
> that may arise if reclaim waits on writeback to complete:
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
>
> To work around this, we allocate a temporary folio and copy over the
> original folio to the temporary folio so that writeback can be
> immediately cleared on the original folio. This additionally requires us
> to maintain an internal rb tree to keep track of writeback state on the
> temporary folios.
>
> A recent change prevents reclaim logic from waiting on writeback for
> folios whose mappings have the AS_WRITEBACK_MAY_BLOCK flag set in it.
> This commit sets AS_WRITEBACK_MAY_BLOCK on FUSE inode mappings (which
> will prevent FUSE folios from running into the reclaim deadlock described
> above) and removes the temporary folio + extra copying and the internal
> rb tree.
>
> fio benchmarks --
> (using averages observed from 10 runs, throwing away outliers)
>
> Setup:
> sudo mount -t tmpfs -o size=3D30G tmpfs ~/tmp_mount
>  ./libfuse/build/example/passthrough_ll -o writeback -o max_threads=3D4 -=
o source=3D~/tmp_mount ~/fuse_mount
>
> fio --name=3Dwriteback --ioengine=3Dsync --rw=3Dwrite --bs=3D{1k,4k,1M} -=
-size=3D2G
> --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1 --directory=3D/root/=
fuse_mount
>
>         bs =3D  1k          4k            1M
> Before  351 MiB/s     1818 MiB/s     1851 MiB/s
> After   341 MiB/s     2246 MiB/s     2685 MiB/s
> % diff        -3%          23%         45%
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 339 +++++--------------------------------------------
>  1 file changed, 30 insertions(+), 309 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc9..a2e91fdd8521 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -415,89 +415,11 @@ u64 fuse_lock_owner_id(struct fuse_conn *fc, fl_own=
er_t id)
>
>  struct fuse_writepage_args {
>         struct fuse_io_args ia;
> -       struct rb_node writepages_entry;
>         struct list_head queue_entry;
> -       struct fuse_writepage_args *next;
>         struct inode *inode;
>         struct fuse_sync_bucket *bucket;
>  };
>
> -static struct fuse_writepage_args *fuse_find_writeback(struct fuse_inode=
 *fi,
> -                                           pgoff_t idx_from, pgoff_t idx=
_to)
> -{
> -       struct rb_node *n;
> -
> -       n =3D fi->writepages.rb_node;
> -
> -       while (n) {
> -               struct fuse_writepage_args *wpa;
> -               pgoff_t curr_index;
> -
> -               wpa =3D rb_entry(n, struct fuse_writepage_args, writepage=
s_entry);
> -               WARN_ON(get_fuse_inode(wpa->inode) !=3D fi);
> -               curr_index =3D wpa->ia.write.in.offset >> PAGE_SHIFT;
> -               if (idx_from >=3D curr_index + wpa->ia.ap.num_folios)
> -                       n =3D n->rb_right;
> -               else if (idx_to < curr_index)
> -                       n =3D n->rb_left;
> -               else
> -                       return wpa;
> -       }
> -       return NULL;
> -}
> -
> -/*
> - * Check if any page in a range is under writeback
> - */
> -static bool fuse_range_is_writeback(struct inode *inode, pgoff_t idx_fro=
m,
> -                                  pgoff_t idx_to)
> -{
> -       struct fuse_inode *fi =3D get_fuse_inode(inode);
> -       bool found;
> -
> -       if (RB_EMPTY_ROOT(&fi->writepages))
> -               return false;
> -
> -       spin_lock(&fi->lock);
> -       found =3D fuse_find_writeback(fi, idx_from, idx_to);
> -       spin_unlock(&fi->lock);
> -
> -       return found;
> -}
> -
> -static inline bool fuse_page_is_writeback(struct inode *inode, pgoff_t i=
ndex)
> -{
> -       return fuse_range_is_writeback(inode, index, index);
> -}
> -
> -/*
> - * Wait for page writeback to be completed.
> - *
> - * Since fuse doesn't rely on the VM writeback tracking, this has to
> - * use some other means.
> - */
> -static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t ind=
ex)
> -{
> -       struct fuse_inode *fi =3D get_fuse_inode(inode);
> -
> -       wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index))=
;
> -}
> -
> -static inline bool fuse_folio_is_writeback(struct inode *inode,
> -                                          struct folio *folio)
> -{
> -       pgoff_t last =3D folio_next_index(folio) - 1;
> -       return fuse_range_is_writeback(inode, folio_index(folio), last);
> -}
> -
> -static void fuse_wait_on_folio_writeback(struct inode *inode,
> -                                        struct folio *folio)
> -{
> -       struct fuse_inode *fi =3D get_fuse_inode(inode);
> -
> -       wait_event(fi->page_waitq, !fuse_folio_is_writeback(inode, folio)=
);
> -}
> -
>  /*
>   * Wait for all pending writepages on the inode to finish.
>   *
> @@ -891,7 +813,7 @@ static int fuse_do_readfolio(struct file *file, struc=
t folio *folio)
>          * have writeback that extends beyond the lifetime of the folio. =
 So
>          * make sure we read a properly synced folio.
>          */
> -       fuse_wait_on_folio_writeback(inode, folio);
> +       folio_wait_writeback(folio);
>
>         attr_ver =3D fuse_get_attr_version(fm->fc);
>
> @@ -1006,13 +928,14 @@ static void fuse_readahead(struct readahead_contro=
l *rac)
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         unsigned int max_pages, nr_pages;
> -       pgoff_t first =3D readahead_index(rac);
> -       pgoff_t last =3D first + readahead_count(rac) - 1;
> +       loff_t first =3D readahead_pos(rac);
> +       loff_t last =3D first + readahead_length(rac) - 1;
>
>         if (fuse_is_bad(inode))
>                 return;
>
> -       wait_event(fi->page_waitq, !fuse_range_is_writeback(inode, first,=
 last));
> +       wait_event(fi->page_waitq,
> +                  !filemap_range_has_writeback(rac->mapping, first, last=
));

I messed this up when rebasing. As it turns out,
filemap_range_has_writeback() returns true if there's any folio in the
mapping that's locked, regardless of writeback state. I'm going to
replace this line with filemap_fdatawait_range() instead.

>
>         max_pages =3D min_t(unsigned int, fc->max_pages,
>                         fc->max_read / PAGE_SIZE);
> @@ -1172,7 +1095,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io=
_args *ia,
>         int err;
>
>         for (i =3D 0; i < ap->num_folios; i++)
> -               fuse_wait_on_folio_writeback(inode, ap->folios[i]);
> +               folio_wait_writeback(ap->folios[i]);
>
>         fuse_write_args_fill(ia, ff, pos, count);
>         ia->write.in.flags =3D fuse_write_flags(iocb);
> @@ -1622,7 +1545,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, str=
uct iov_iter *iter,
>                         return res;
>                 }
>         }
> -       if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> +       if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + cou=
nt - 1))) {
>                 if (!write)
>                         inode_lock(inode);
>                 fuse_sync_writes(inode);
> @@ -1824,8 +1747,10 @@ static void fuse_writepage_free(struct fuse_writep=
age_args *wpa)
>         if (wpa->bucket)
>                 fuse_sync_bucket_dec(wpa->bucket);
>
> -       for (i =3D 0; i < ap->num_folios; i++)
> +       for (i =3D 0; i < ap->num_folios; i++) {
> +               folio_end_writeback(ap->folios[i]);
>                 folio_put(ap->folios[i]);
> +       }
>
>         fuse_file_put(wpa->ia.ff, false);
>
> @@ -1838,7 +1763,7 @@ static void fuse_writepage_finish_stat(struct inode=
 *inode, struct folio *folio)
>         struct backing_dev_info *bdi =3D inode_to_bdi(inode);
>
>         dec_wb_stat(&bdi->wb, WB_WRITEBACK);
> -       node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
> +       node_stat_sub_folio(folio, NR_WRITEBACK);
>         wb_writeout_inc(&bdi->wb);
>  }
>
> @@ -1861,7 +1786,6 @@ static void fuse_send_writepage(struct fuse_mount *=
fm,
>  __releases(fi->lock)
>  __acquires(fi->lock)
>  {
> -       struct fuse_writepage_args *aux, *next;
>         struct fuse_inode *fi =3D get_fuse_inode(wpa->inode);
>         struct fuse_write_in *inarg =3D &wpa->ia.write.in;
>         struct fuse_args *args =3D &wpa->ia.ap.args;
> @@ -1898,19 +1822,8 @@ __acquires(fi->lock)
>
>   out_free:
>         fi->writectr--;
> -       rb_erase(&wpa->writepages_entry, &fi->writepages);
>         fuse_writepage_finish(wpa);
>         spin_unlock(&fi->lock);
> -
> -       /* After rb_erase() aux request list is private */
> -       for (aux =3D wpa->next; aux; aux =3D next) {
> -               next =3D aux->next;
> -               aux->next =3D NULL;
> -               fuse_writepage_finish_stat(aux->inode,
> -                                          aux->ia.ap.folios[0]);
> -               fuse_writepage_free(aux);
> -       }
> -
>         fuse_writepage_free(wpa);
>         spin_lock(&fi->lock);
>  }
> @@ -1938,43 +1851,6 @@ __acquires(fi->lock)
>         }
>  }
>
> -static struct fuse_writepage_args *fuse_insert_writeback(struct rb_root =
*root,
> -                                               struct fuse_writepage_arg=
s *wpa)
> -{
> -       pgoff_t idx_from =3D wpa->ia.write.in.offset >> PAGE_SHIFT;
> -       pgoff_t idx_to =3D idx_from + wpa->ia.ap.num_folios - 1;
> -       struct rb_node **p =3D &root->rb_node;
> -       struct rb_node  *parent =3D NULL;
> -
> -       WARN_ON(!wpa->ia.ap.num_folios);
> -       while (*p) {
> -               struct fuse_writepage_args *curr;
> -               pgoff_t curr_index;
> -
> -               parent =3D *p;
> -               curr =3D rb_entry(parent, struct fuse_writepage_args,
> -                               writepages_entry);
> -               WARN_ON(curr->inode !=3D wpa->inode);
> -               curr_index =3D curr->ia.write.in.offset >> PAGE_SHIFT;
> -
> -               if (idx_from >=3D curr_index + curr->ia.ap.num_folios)
> -                       p =3D &(*p)->rb_right;
> -               else if (idx_to < curr_index)
> -                       p =3D &(*p)->rb_left;
> -               else
> -                       return curr;
> -       }
> -
> -       rb_link_node(&wpa->writepages_entry, parent, p);
> -       rb_insert_color(&wpa->writepages_entry, root);
> -       return NULL;
> -}
> -
> -static void tree_insert(struct rb_root *root, struct fuse_writepage_args=
 *wpa)
> -{
> -       WARN_ON(fuse_insert_writeback(root, wpa));
> -}
> -
>  static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *=
args,
>                                int error)
>  {
> @@ -1994,41 +1870,6 @@ static void fuse_writepage_end(struct fuse_mount *=
fm, struct fuse_args *args,
>         if (!fc->writeback_cache)
>                 fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
>         spin_lock(&fi->lock);
> -       rb_erase(&wpa->writepages_entry, &fi->writepages);
> -       while (wpa->next) {
> -               struct fuse_mount *fm =3D get_fuse_mount(inode);
> -               struct fuse_write_in *inarg =3D &wpa->ia.write.in;
> -               struct fuse_writepage_args *next =3D wpa->next;
> -
> -               wpa->next =3D next->next;
> -               next->next =3D NULL;
> -               tree_insert(&fi->writepages, next);
> -
> -               /*
> -                * Skip fuse_flush_writepages() to make it easy to crop r=
equests
> -                * based on primary request size.
> -                *
> -                * 1st case (trivial): there are no concurrent activities=
 using
> -                * fuse_set/release_nowrite.  Then we're on safe side bec=
ause
> -                * fuse_flush_writepages() would call fuse_send_writepage=
()
> -                * anyway.
> -                *
> -                * 2nd case: someone called fuse_set_nowrite and it is wa=
iting
> -                * now for completion of all in-flight requests.  This ha=
ppens
> -                * rarely and no more than once per page, so this should =
be
> -                * okay.
> -                *
> -                * 3rd case: someone (e.g. fuse_do_setattr()) is in the m=
iddle
> -                * of fuse_set_nowrite..fuse_release_nowrite section.  Th=
e fact
> -                * that fuse_set_nowrite returned implies that all in-fli=
ght
> -                * requests were completed along with all of their second=
ary
> -                * requests.  Further primary requests are blocked by neg=
ative
> -                * writectr.  Hence there cannot be any in-flight request=
s and
> -                * no invocations of fuse_writepage_end() while we're in
> -                * fuse_set_nowrite..fuse_release_nowrite section.
> -                */
> -               fuse_send_writepage(fm, next, inarg->offset + inarg->size=
);
> -       }
>         fi->writectr--;
>         fuse_writepage_finish(wpa);
>         spin_unlock(&fi->lock);
> @@ -2115,19 +1956,18 @@ static void fuse_writepage_add_to_bucket(struct f=
use_conn *fc,
>  }
>
>  static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wp=
a, struct folio *folio,
> -                                         struct folio *tmp_folio, uint32=
_t folio_index)
> +                                         uint32_t folio_index)
>  {
>         struct inode *inode =3D folio->mapping->host;
>         struct fuse_args_pages *ap =3D &wpa->ia.ap;
>
> -       folio_copy(tmp_folio, folio);
> -
> -       ap->folios[folio_index] =3D tmp_folio;
> +       folio_get(folio);
> +       ap->folios[folio_index] =3D folio;
>         ap->descs[folio_index].offset =3D 0;
>         ap->descs[folio_index].length =3D PAGE_SIZE;
>
>         inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
> -       node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
> +       node_stat_add_folio(folio, NR_WRITEBACK);
>  }
>
>  static struct fuse_writepage_args *fuse_writepage_args_setup(struct foli=
o *folio,
> @@ -2162,18 +2002,12 @@ static int fuse_writepage_locked(struct folio *fo=
lio)
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
>         struct fuse_writepage_args *wpa;
>         struct fuse_args_pages *ap;
> -       struct folio *tmp_folio;
>         struct fuse_file *ff;
> -       int error =3D -ENOMEM;
> -
> -       tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> -       if (!tmp_folio)
> -               goto err;
> +       int error =3D -EIO;
>
> -       error =3D -EIO;
>         ff =3D fuse_write_file_get(fi);
>         if (!ff)
> -               goto err_nofile;
> +               goto err;
>
>         wpa =3D fuse_writepage_args_setup(folio, ff);
>         error =3D -ENOMEM;
> @@ -2184,22 +2018,17 @@ static int fuse_writepage_locked(struct folio *fo=
lio)
>         ap->num_folios =3D 1;
>
>         folio_start_writeback(folio);
> -       fuse_writepage_args_page_fill(wpa, folio, tmp_folio, 0);
> +       fuse_writepage_args_page_fill(wpa, folio, 0);
>
>         spin_lock(&fi->lock);
> -       tree_insert(&fi->writepages, wpa);
>         list_add_tail(&wpa->queue_entry, &fi->queued_writes);
>         fuse_flush_writepages(inode);
>         spin_unlock(&fi->lock);
>
> -       folio_end_writeback(folio);
> -
>         return 0;
>
>  err_writepage_args:
>         fuse_file_put(ff, false);
> -err_nofile:
> -       folio_put(tmp_folio);
>  err:
>         mapping_set_error(folio->mapping, error);
>         return error;
> @@ -2209,7 +2038,6 @@ struct fuse_fill_wb_data {
>         struct fuse_writepage_args *wpa;
>         struct fuse_file *ff;
>         struct inode *inode;
> -       struct folio **orig_folios;
>         unsigned int max_folios;
>  };
>
> @@ -2244,69 +2072,11 @@ static void fuse_writepages_send(struct fuse_fill=
_wb_data *data)
>         struct fuse_writepage_args *wpa =3D data->wpa;
>         struct inode *inode =3D data->inode;
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> -       int num_folios =3D wpa->ia.ap.num_folios;
> -       int i;
>
>         spin_lock(&fi->lock);
>         list_add_tail(&wpa->queue_entry, &fi->queued_writes);
>         fuse_flush_writepages(inode);
>         spin_unlock(&fi->lock);
> -
> -       for (i =3D 0; i < num_folios; i++)
> -               folio_end_writeback(data->orig_folios[i]);
> -}
> -
> -/*
> - * Check under fi->lock if the page is under writeback, and insert it on=
to the
> - * rb_tree if not. Otherwise iterate auxiliary write requests, to see if=
 there's
> - * one already added for a page at this offset.  If there's none, then i=
nsert
> - * this new request onto the auxiliary list, otherwise reuse the existin=
g one by
> - * swapping the new temp page with the old one.
> - */
> -static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
> -                              struct folio *folio)
> -{
> -       struct fuse_inode *fi =3D get_fuse_inode(new_wpa->inode);
> -       struct fuse_writepage_args *tmp;
> -       struct fuse_writepage_args *old_wpa;
> -       struct fuse_args_pages *new_ap =3D &new_wpa->ia.ap;
> -
> -       WARN_ON(new_ap->num_folios !=3D 0);
> -       new_ap->num_folios =3D 1;
> -
> -       spin_lock(&fi->lock);
> -       old_wpa =3D fuse_insert_writeback(&fi->writepages, new_wpa);
> -       if (!old_wpa) {
> -               spin_unlock(&fi->lock);
> -               return true;
> -       }
> -
> -       for (tmp =3D old_wpa->next; tmp; tmp =3D tmp->next) {
> -               pgoff_t curr_index;
> -
> -               WARN_ON(tmp->inode !=3D new_wpa->inode);
> -               curr_index =3D tmp->ia.write.in.offset >> PAGE_SHIFT;
> -               if (curr_index =3D=3D folio->index) {
> -                       WARN_ON(tmp->ia.ap.num_folios !=3D 1);
> -                       swap(tmp->ia.ap.folios[0], new_ap->folios[0]);
> -                       break;
> -               }
> -       }
> -
> -       if (!tmp) {
> -               new_wpa->next =3D old_wpa->next;
> -               old_wpa->next =3D new_wpa;
> -       }
> -
> -       spin_unlock(&fi->lock);
> -
> -       if (tmp) {
> -               fuse_writepage_finish_stat(new_wpa->inode,
> -                                          folio);
> -               fuse_writepage_free(new_wpa);
> -       }
> -
> -       return false;
>  }
>
>  static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio =
*folio,
> @@ -2315,15 +2085,6 @@ static bool fuse_writepage_need_send(struct fuse_c=
onn *fc, struct folio *folio,
>  {
>         WARN_ON(!ap->num_folios);
>
> -       /*
> -        * Being under writeback is unlikely but possible.  For example d=
irect
> -        * read to an mmaped fuse file will set the page dirty twice; onc=
e when
> -        * the pages are faulted with get_user_pages(), and then after th=
e read
> -        * completed.
> -        */
> -       if (fuse_folio_is_writeback(data->inode, folio))
> -               return true;
> -
>         /* Reached max pages */
>         if (ap->num_folios =3D=3D fc->max_pages)
>                 return true;
> @@ -2333,7 +2094,7 @@ static bool fuse_writepage_need_send(struct fuse_co=
nn *fc, struct folio *folio,
>                 return true;
>
>         /* Discontinuity */
> -       if (data->orig_folios[ap->num_folios - 1]->index + 1 !=3D folio_i=
ndex(folio))
> +       if (ap->folios[ap->num_folios - 1]->index + 1 !=3D folio_index(fo=
lio))
>                 return true;
>
>         /* Need to grow the pages array?  If so, did the expansion fail? =
*/
> @@ -2352,7 +2113,6 @@ static int fuse_writepages_fill(struct folio *folio=
,
>         struct inode *inode =3D data->inode;
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
> -       struct folio *tmp_folio;
>         int err;
>
>         if (!data->ff) {
> @@ -2367,54 +2127,23 @@ static int fuse_writepages_fill(struct folio *fol=
io,
>                 data->wpa =3D NULL;
>         }
>
> -       err =3D -ENOMEM;
> -       tmp_folio =3D folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> -       if (!tmp_folio)
> -               goto out_unlock;
> -
> -       /*
> -        * The page must not be redirtied until the writeout is completed
> -        * (i.e. userspace has sent a reply to the write request).  Other=
wise
> -        * there could be more than one temporary page instance for each =
real
> -        * page.
> -        *
> -        * This is ensured by holding the page lock in page_mkwrite() whi=
le
> -        * checking fuse_page_is_writeback().  We already hold the page l=
ock
> -        * since clear_page_dirty_for_io() and keep it held until we add =
the
> -        * request to the fi->writepages list and increment ap->num_folio=
s.
> -        * After this fuse_page_is_writeback() will indicate that the pag=
e is
> -        * under writeback, so we can release the page lock.
> -        */
>         if (data->wpa =3D=3D NULL) {
>                 err =3D -ENOMEM;
>                 wpa =3D fuse_writepage_args_setup(folio, data->ff);
> -               if (!wpa) {
> -                       folio_put(tmp_folio);
> +               if (!wpa)
>                         goto out_unlock;
> -               }
>                 fuse_file_get(wpa->ia.ff);
>                 data->max_folios =3D 1;
>                 ap =3D &wpa->ia.ap;
>         }
>         folio_start_writeback(folio);
>
> -       fuse_writepage_args_page_fill(wpa, folio, tmp_folio, ap->num_foli=
os);
> -       data->orig_folios[ap->num_folios] =3D folio;
> +       fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
>
>         err =3D 0;
> -       if (data->wpa) {
> -               /*
> -                * Protected by fi->lock against concurrent access by
> -                * fuse_page_is_writeback().
> -                */
> -               spin_lock(&fi->lock);
> -               ap->num_folios++;
> -               spin_unlock(&fi->lock);
> -       } else if (fuse_writepage_add(wpa, folio)) {
> +       ap->num_folios++;
> +       if (!data->wpa)
>                 data->wpa =3D wpa;
> -       } else {
> -               folio_end_writeback(folio);
> -       }
>  out_unlock:
>         folio_unlock(folio);
>
> @@ -2441,13 +2170,6 @@ static int fuse_writepages(struct address_space *m=
apping,
>         data.wpa =3D NULL;
>         data.ff =3D NULL;
>
> -       err =3D -ENOMEM;
> -       data.orig_folios =3D kcalloc(fc->max_pages,
> -                                  sizeof(struct folio *),
> -                                  GFP_NOFS);
> -       if (!data.orig_folios)
> -               goto out;
> -
>         err =3D write_cache_pages(mapping, wbc, fuse_writepages_fill, &da=
ta);
>         if (data.wpa) {
>                 WARN_ON(!data.wpa->ia.ap.num_folios);
> @@ -2456,7 +2178,6 @@ static int fuse_writepages(struct address_space *ma=
pping,
>         if (data.ff)
>                 fuse_file_put(data.ff, false);
>
> -       kfree(data.orig_folios);
>  out:
>         return err;
>  }
> @@ -2481,7 +2202,7 @@ static int fuse_write_begin(struct file *file, stru=
ct address_space *mapping,
>         if (IS_ERR(folio))
>                 goto error;
>
> -       fuse_wait_on_page_writeback(mapping->host, folio->index);
> +       folio_wait_writeback(folio);
>
>         if (folio_test_uptodate(folio) || len >=3D folio_size(folio))
>                 goto success;
> @@ -2545,13 +2266,11 @@ static int fuse_launder_folio(struct folio *folio=
)
>  {
>         int err =3D 0;
>         if (folio_clear_dirty_for_io(folio)) {
> -               struct inode *inode =3D folio->mapping->host;
> -
>                 /* Serialize with pending writeback for the same page */
> -               fuse_wait_on_page_writeback(inode, folio->index);
> +               folio_wait_writeback(folio);
>                 err =3D fuse_writepage_locked(folio);
>                 if (!err)
> -                       fuse_wait_on_page_writeback(inode, folio->index);
> +                       folio_wait_writeback(folio);
>         }
>         return err;
>  }
> @@ -2595,7 +2314,7 @@ static vm_fault_t fuse_page_mkwrite(struct vm_fault=
 *vmf)
>                 return VM_FAULT_NOPAGE;
>         }
>
> -       fuse_wait_on_folio_writeback(inode, folio);
> +       folio_wait_writeback(folio);
>         return VM_FAULT_LOCKED;
>  }
>
> @@ -3413,9 +3132,12 @@ static const struct address_space_operations fuse_=
file_aops  =3D {
>  void fuse_init_file_inode(struct inode *inode, unsigned int flags)
>  {
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
>
>         inode->i_fop =3D &fuse_file_operations;
>         inode->i_data.a_ops =3D &fuse_file_aops;
> +       if (fc->writeback_cache)
> +               mapping_set_writeback_may_block(&inode->i_data);
>
>         INIT_LIST_HEAD(&fi->write_files);
>         INIT_LIST_HEAD(&fi->queued_writes);
> @@ -3423,7 +3145,6 @@ void fuse_init_file_inode(struct inode *inode, unsi=
gned int flags)
>         fi->iocachectr =3D 0;
>         init_waitqueue_head(&fi->page_waitq);
>         init_waitqueue_head(&fi->direct_io_waitq);
> -       fi->writepages =3D RB_ROOT;
>
>         if (IS_ENABLED(CONFIG_FUSE_DAX))
>                 fuse_dax_inode_init(inode, flags);
> --
> 2.43.5
>

