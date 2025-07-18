Return-Path: <linux-fsdevel+bounces-55436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DADFB0A65D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 16:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F703A2404
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9A2DCBE6;
	Fri, 18 Jul 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V20Z4jO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60962DC32D
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848886; cv=none; b=lLJtSq59/b+zIr/agja0MGWVhXHAjUzKbszj8xEWl75KuYp9HH3aljfi5eniza21RDAwPxJnVNoF6ZDetXwQxwqnmytOsIzxOIxLGVrgOxq9T1o+abptuG6/eVFKwKXf5MouQQOa/ACG/ztu/Dv3DhbKOmwuMr/NUu7odPo0LIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848886; c=relaxed/simple;
	bh=I0zcEHd7lRfAWq0xPiKJEhTy3Iadr31KesCF8Bwg2iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm+3p8fCMl8tNvh0XgRKR8AJrE/cPwC8IBhUZ7PoNYqbf7vaBoxIsGK/odwHgpqWWO04+0VsC8iAnr3UUD4t8cN7H0q/X21igQktHt1dBHMOp0O0HMcHDBJwerkoKAtw3gpNiaXT2z232hZE3K2EM/E3krOEMklTTbl0vTT9FvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V20Z4jO4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3a604b43bso361453166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752848882; x=1753453682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7xtxMKvUa60yS3pjF1eYqhdb8cngoVAkiXuubsPVGY=;
        b=V20Z4jO4bVKHBopurpI1+XdfnwSZbkZARKN94vu5i++qHUkB8AeqfNCKltRte1UgVc
         FXl1GFi20ZNrkF2zQlHCltPPW7lwxkup0/9/Nl3x1La6h2Ox/SNgZSCA3QmwxP+rX1Wz
         iXgq6eBaB14vnBWbL25UVm4/VkEO7qh3H5pGqpbBCWg4kt2qWVpF6hmfA75vnYeCjgWR
         Taf49YhqLGmDQGKhOkpunT6qpIKawD+PzN/nOI7Or4rl9LPNxJzToQi94ndwyWZK/EEE
         qVj2IZvAmDiKsZ/yU10JNvhtwNu3G/IS22OUP0N7gCf1C7hDyqVR4hrCbBTAqBeCqFCe
         WWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848882; x=1753453682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7xtxMKvUa60yS3pjF1eYqhdb8cngoVAkiXuubsPVGY=;
        b=YpSnSugJBovqGmFV8uJYObUxnieogvve1CrP3rlgf6uLP+zcVlE7RC42vjDjAuD36m
         Cbn+fPY/CPgXaZPH8FTd5B83TjJbnYuhJX00oDrwcsVpGg80zzDv0qTVPEIQUom3DEHC
         63Lzle6plFVbctHsMzW3L3AFqHTjLAxxZEGi7wvhAF8+m7nDtk1M8UdXQJRKu1HGzq7G
         yaJ9VI1qlYTqfK0LdBbBNwB0NLvRge6fW4aZJuPqRS41J5NnyllKlOj04A5/UKK1KXYm
         TxxPtPG+UKWy3ou2fSHGks+XfuLtVkfJ4EEvvQY+rMkka0qV/seL0qYmOW3aXqVvy+Ts
         W1xA==
X-Forwarded-Encrypted: i=1; AJvYcCVOOWTlUqT4jadEi+jBe35fE7fV7PLOfvhkYdaXqHexuwhwCslA/UB5J+SFGRxNVTCkLQMjvevo810nobfB@vger.kernel.org
X-Gm-Message-State: AOJu0YxL/DnvBaYYMF1jMEJRsZuGTo1wX9l3Cjlj7IZLm29N9cW5TxZM
	cup2keYbDMZrYU15llOPSbiCAKR75uE/rw4AS8N40HxOWqBK6jGcMfyt5H+1xULzF/VK1h0N3SI
	Y9+nEsiaCamS0lKAZDRVOq5+IhwK64og=
X-Gm-Gg: ASbGncsbHloFJi94lxuipWiM/R1UBPczBN0l3x75TAwllSCwJp8Mkbbb9qHxOixLf5i
	0P5b0jbWQn1lt4ID6zZJJfYqYQNCT+1oAF/GqFvWp4GiSC5HsxVkPDltlQrtwZq8reMyBQY6vwa
	waKMM1lB8cPFBSPD56f4FbSw5+cie9km5R7VdSS6gLqkScExNi9DINXV5JQjA9sD0BqpkJQdB7r
	lJ9Omo=
X-Google-Smtp-Source: AGHT+IETuo2fb6SWUvBZniV5vUxWejDDjdZGkkQGshLueplKRjw5BK4Lg+5SoInc5qszxT585qfBnMnmiqU59Sneo4g=
X-Received: by 2002:a17:907:3ea2:b0:adb:2bee:53c9 with SMTP id
 a640c23a62f3a-ae9cddb3a7dmr1162945666b.3.1752848881525; Fri, 18 Jul 2025
 07:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs> <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
In-Reply-To: <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 16:27:50 +0200
X-Gm-Features: Ac12FXyTBdzmUEnSsbV51wvvOUVCik-3qgnKTBqYgsJCNWPu83BpdF3fHrmfv0A
Message-ID: <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to fuse_reply_attr_iflags
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:36=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Create a new ->getattr_iflags function so that iomap filesystems can set
> the appropriate in-kernel inode flags on instantiation.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse.h |    7 ++
>  lib/fuse.c     |  219 ++++++++++++++++++++++++++++++++++++++++++++------=
------
>  2 files changed, 180 insertions(+), 46 deletions(-)
>
>
> diff --git a/include/fuse.h b/include/fuse.h
> index e2e7c950bf144d..f894dd5da0d106 100644
> --- a/include/fuse.h
> +++ b/include/fuse.h
> @@ -876,6 +876,13 @@ struct fuse_operations {
>                             uint64_t attr_ino, off_t pos_in, size_t writt=
en_in,
>                             uint32_t ioendflags_in, int error_in,
>                             uint64_t new_addr_in);
> +
> +       /**
> +        * Get file attributes and FUSE_IFLAG_* flags.  Otherwise the sam=
e as
> +        * getattr.
> +        */
> +       int (*getattr_iflags) (const char *path, struct stat *buf,
> +                              unsigned int *iflags, struct fuse_file_inf=
o *fi);
>  #endif /* FUSE_USE_VERSION >=3D 318 */
>  };
>
> diff --git a/lib/fuse.c b/lib/fuse.c
> index 8dbf88877dd37c..685d0181e569d0 100644
> --- a/lib/fuse.c
> +++ b/lib/fuse.c
> @@ -123,6 +123,7 @@ struct fuse {
>         struct list_head partial_slabs;
>         struct list_head full_slabs;
>         pthread_t prune_thread;
> +       bool want_iflags;
>  };
>
>  struct lock {
> @@ -144,6 +145,7 @@ struct node {
>         char *name;
>         uint64_t nlookup;
>         int open_count;
> +       unsigned int iflags;
>         struct timespec stat_updated;
>         struct timespec mtime;
>         off_t size;
> @@ -1605,6 +1607,24 @@ int fuse_fs_getattr(struct fuse_fs *fs, const char=
 *path, struct stat *buf,
>         return fs->op.getattr(path, buf, fi);
>  }
>
> +static int fuse_fs_getattr_iflags(struct fuse_fs *fs, const char *path,
> +                                 struct stat *buf, unsigned int *iflags,
> +                                 struct fuse_file_info *fi)
> +{
> +       fuse_get_context()->private_data =3D fs->user_data;
> +       if (!fs->op.getattr_iflags)
> +               return -ENOSYS;
> +
> +       if (fs->debug) {
> +               char buf[10];
> +
> +               fuse_log(FUSE_LOG_DEBUG, "getattr_iflags[%s] %s\n",
> +                       file_info_string(fi, buf, sizeof(buf)),
> +                       path);
> +       }
> +       return fs->op.getattr_iflags(path, buf, iflags, fi);
> +}
> +
>  int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath,
>                    const char *newpath, unsigned int flags)
>  {
> @@ -2417,7 +2437,7 @@ static void update_stat(struct node *node, const st=
ruct stat *stbuf)
>  }
>
>  static int do_lookup(struct fuse *f, fuse_ino_t nodeid, const char *name=
,
> -                    struct fuse_entry_param *e)
> +                    struct fuse_entry_param *e, unsigned int *iflags)
>  {
>         struct node *node;
>
> @@ -2435,25 +2455,59 @@ static int do_lookup(struct fuse *f, fuse_ino_t n=
odeid, const char *name,
>                 pthread_mutex_unlock(&f->lock);
>         }
>         set_stat(f, e->ino, &e->attr);
> +       *iflags =3D node->iflags;
> +       return 0;
> +}
> +
> +static int lookup_and_update(struct fuse *f, fuse_ino_t nodeid,
> +                            const char *name, struct fuse_entry_param *e=
,
> +                            unsigned int iflags)
> +{
> +       struct node *node;
> +
> +       node =3D find_node(f, nodeid, name);
> +       if (node =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       e->ino =3D node->nodeid;
> +       e->generation =3D node->generation;
> +       e->entry_timeout =3D f->conf.entry_timeout;
> +       e->attr_timeout =3D f->conf.attr_timeout;
> +       if (f->conf.auto_cache) {
> +               pthread_mutex_lock(&f->lock);
> +               update_stat(node, &e->attr);
> +               pthread_mutex_unlock(&f->lock);
> +       }
> +       set_stat(f, e->ino, &e->attr);
> +       node->iflags =3D iflags;
>         return 0;
>  }
>
>  static int lookup_path(struct fuse *f, fuse_ino_t nodeid,
>                        const char *name, const char *path,
> -                      struct fuse_entry_param *e, struct fuse_file_info =
*fi)
> +                      struct fuse_entry_param *e, unsigned int *iflags,
> +                      struct fuse_file_info *fi)
>  {
>         int res;
>
>         memset(e, 0, sizeof(struct fuse_entry_param));
> -       res =3D fuse_fs_getattr(f->fs, path, &e->attr, fi);
> -       if (res =3D=3D 0) {
> -               res =3D do_lookup(f, nodeid, name, e);
> -               if (res =3D=3D 0 && f->conf.debug) {
> -                       fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu\n",
> -                               (unsigned long long) e->ino);
> -               }
> -       }
> -       return res;
> +       *iflags =3D 0;
> +       if (f->want_iflags)
> +               res =3D fuse_fs_getattr_iflags(f->fs, path, &e->attr, ifl=
ags, fi);
> +       else
> +               res =3D fuse_fs_getattr(f->fs, path, &e->attr, fi);
> +       if (res)
> +               return res;
> +
> +       res =3D lookup_and_update(f, nodeid, name, e, *iflags);
> +       if (res)
> +               return res;
> +
> +       if (f->conf.debug)
> +               fuse_log(FUSE_LOG_DEBUG, "   NODEID: %llu iflags 0x%x\n",
> +                       (unsigned long long) e->ino, *iflags);
> +
> +       return 0;
>  }
>
>  static struct fuse_context_i *fuse_get_context_internal(void)
> @@ -2537,11 +2591,17 @@ static inline void reply_err(fuse_req_t req, int =
err)
>  }
>
>  static void reply_entry(fuse_req_t req, const struct fuse_entry_param *e=
,
> -                       int err)
> +                       unsigned int iflags, int err)
>  {
>         if (!err) {
>                 struct fuse *f =3D req_fuse(req);
> -               if (fuse_reply_entry(req, e) =3D=3D -ENOENT) {
> +               int entry_res;
> +
> +               if (f->want_iflags)
> +                       entry_res =3D fuse_reply_entry_iflags(req, e, ifl=
ags);
> +               else
> +                       entry_res =3D fuse_reply_entry(req, e);
> +               if (entry_res =3D=3D -ENOENT) {
>                         /* Skip forget for negative result */
>                         if  (e->ino !=3D 0)
>                                 forget_node(f, e->ino, 1);
> @@ -2582,6 +2642,9 @@ static void fuse_lib_init(void *data, struct fuse_c=
onn_info *conn)
>                 /* Disable the receiving and processing of FUSE_INTERRUPT=
 requests */
>                 conn->no_interrupt =3D 1;
>         }
> +
> +       if (fuse_get_feature_flag(conn, FUSE_CAP_IOMAP))
> +               f->want_iflags =3D true;
>  }
>
>  void fuse_fs_destroy(struct fuse_fs *fs)
> @@ -2605,6 +2668,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_in=
o_t parent,
>         struct fuse *f =3D req_fuse_prepare(req);
>         struct fuse_entry_param e;
>         char *path;
> +       unsigned int iflags =3D 0;
>         int err;
>         struct node *dot =3D NULL;
>
> @@ -2619,7 +2683,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_in=
o_t parent,
>                                 dot =3D get_node_nocheck(f, parent);
>                                 if (dot =3D=3D NULL) {
>                                         pthread_mutex_unlock(&f->lock);
> -                                       reply_entry(req, &e, -ESTALE);
> +                                       reply_entry(req, &e, -ESTALE, 0);
>                                         return;
>                                 }
>                                 dot->refctr++;
> @@ -2639,7 +2703,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_in=
o_t parent,
>                 if (f->conf.debug)
>                         fuse_log(FUSE_LOG_DEBUG, "LOOKUP %s\n", path);
>                 fuse_prepare_interrupt(f, req, &d);
> -               err =3D lookup_path(f, parent, name, path, &e, NULL);
> +               err =3D lookup_path(f, parent, name, path, &e, &iflags, N=
ULL);
>                 if (err =3D=3D -ENOENT && f->conf.negative_timeout !=3D 0=
.0) {
>                         e.ino =3D 0;
>                         e.entry_timeout =3D f->conf.negative_timeout;
> @@ -2653,7 +2717,7 @@ static void fuse_lib_lookup(fuse_req_t req, fuse_in=
o_t parent,
>                 unref_node(f, dot);
>                 pthread_mutex_unlock(&f->lock);
>         }
> -       reply_entry(req, &e, err);
> +       reply_entry(req, &e, iflags, err);
>  }
>
>  static void do_forget(struct fuse *f, fuse_ino_t ino, uint64_t nlookup)
> @@ -2689,6 +2753,7 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_i=
no_t ino,
>         struct fuse *f =3D req_fuse_prepare(req);
>         struct stat buf;
>         char *path;
> +       unsigned int iflags =3D 0;
>         int err;
>
>         memset(&buf, 0, sizeof(buf));
> @@ -2700,7 +2765,11 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_=
ino_t ino,
>         if (!err) {
>                 struct fuse_intr_data d;
>                 fuse_prepare_interrupt(f, req, &d);
> -               err =3D fuse_fs_getattr(f->fs, path, &buf, fi);
> +               if (f->want_iflags)
> +                       err =3D fuse_fs_getattr_iflags(f->fs, path, &buf,
> +                                                    &iflags, fi);
> +               else
> +                       err =3D fuse_fs_getattr(f->fs, path, &buf, fi);
>                 fuse_finish_interrupt(f, req, &d);
>                 free_path(f, ino, path);
>         }
> @@ -2713,9 +2782,14 @@ static void fuse_lib_getattr(fuse_req_t req, fuse_=
ino_t ino,
>                         buf.st_nlink--;
>                 if (f->conf.auto_cache)
>                         update_stat(node, &buf);
> +               node->iflags =3D iflags;
>                 pthread_mutex_unlock(&f->lock);
>                 set_stat(f, ino, &buf);
> -               fuse_reply_attr(req, &buf, f->conf.attr_timeout);
> +               if (f->want_iflags)
> +                       fuse_reply_attr_iflags(req, &buf, iflags,
> +                                              f->conf.attr_timeout);
> +               else
> +                       fuse_reply_attr(req, &buf, f->conf.attr_timeout);
>         } else
>                 reply_err(req, err);
>  }
> @@ -2802,6 +2876,7 @@ static void fuse_lib_setattr(fuse_req_t req, fuse_i=
no_t ino, struct stat *attr,
>         struct fuse *f =3D req_fuse_prepare(req);
>         struct stat buf;
>         char *path;
> +       unsigned int iflags =3D 0;
>         int err;
>
>         memset(&buf, 0, sizeof(buf));
> @@ -2860,19 +2935,30 @@ static void fuse_lib_setattr(fuse_req_t req, fuse=
_ino_t ino, struct stat *attr,
>                         err =3D fuse_fs_utimens(f->fs, path, tv, fi);
>                 }
>                 if (!err) {
> -                       err =3D fuse_fs_getattr(f->fs, path, &buf, fi);
> +                       if (f->want_iflags)
> +                               err =3D fuse_fs_getattr_iflags(f->fs, pat=
h, &buf,
> +                                                            &iflags, fi)=
;
> +                       else
> +                               err =3D fuse_fs_getattr(f->fs, path, &buf=
, fi);
>                 }
>                 fuse_finish_interrupt(f, req, &d);
>                 free_path(f, ino, path);
>         }
>         if (!err) {
> -               if (f->conf.auto_cache) {
> -                       pthread_mutex_lock(&f->lock);
> -                       update_stat(get_node(f, ino), &buf);
> -                       pthread_mutex_unlock(&f->lock);
> -               }
> +               struct node *node;
> +
> +               pthread_mutex_lock(&f->lock);
> +               node =3D get_node(f, ino);
> +               if (f->conf.auto_cache)
> +                       update_stat(node, &buf);
> +               node->iflags =3D iflags;
> +               pthread_mutex_unlock(&f->lock);
>                 set_stat(f, ino, &buf);
> -               fuse_reply_attr(req, &buf, f->conf.attr_timeout);
> +               if (f->want_iflags)
> +                       fuse_reply_attr_iflags(req, &buf, iflags,
> +                                              f->conf.attr_timeout);
> +               else
> +                       fuse_reply_attr(req, &buf, f->conf.attr_timeout);
>         } else
>                 reply_err(req, err);
>  }
> @@ -2923,6 +3009,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino=
_t parent, const char *name,
>         struct fuse *f =3D req_fuse_prepare(req);
>         struct fuse_entry_param e;
>         char *path;
> +       unsigned int iflags =3D 0;
>         int err;
>
>         err =3D get_path_name(f, parent, name, &path);
> @@ -2939,7 +3026,7 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_ino=
_t parent, const char *name,
>                         err =3D fuse_fs_create(f->fs, path, mode, &fi);
>                         if (!err) {
>                                 err =3D lookup_path(f, parent, name, path=
, &e,
> -                                                 &fi);
> +                                                 &iflags, &fi);
>                                 fuse_fs_release(f->fs, path, &fi);
>                         }
>                 }
> @@ -2947,12 +3034,12 @@ static void fuse_lib_mknod(fuse_req_t req, fuse_i=
no_t parent, const char *name,
>                         err =3D fuse_fs_mknod(f->fs, path, mode, rdev);
>                         if (!err)
>                                 err =3D lookup_path(f, parent, name, path=
, &e,
> -                                                 NULL);
> +                                                 &iflags, NULL);
>                 }
>                 fuse_finish_interrupt(f, req, &d);
>                 free_path(f, parent, path);
>         }
> -       reply_entry(req, &e, err);
> +       reply_entry(req, &e, iflags, err);
>  }
>
>  static void fuse_lib_mkdir(fuse_req_t req, fuse_ino_t parent, const char=
 *name,
> @@ -2961,6 +3048,7 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_ino=
_t parent, const char *name,
>         struct fuse *f =3D req_fuse_prepare(req);
>         struct fuse_entry_param e;
>         char *path;
> +       unsigned int iflags =3D 0;
>         int err;
>
>         err =3D get_path_name(f, parent, name, &path);
> @@ -2970,11 +3058,12 @@ static void fuse_lib_mkdir(fuse_req_t req, fuse_i=
no_t parent, const char *name,
>                 fuse_prepare_interrupt(f, req, &d);
>                 err =3D fuse_fs_mkdir(f->fs, path, mode);
>                 if (!err)
> -                       err =3D lookup_path(f, parent, name, path, &e, NU=
LL);
> +                       err =3D lookup_path(f, parent, name, path, &e, &i=
flags,
> +                                         NULL);
>                 fuse_finish_interrupt(f, req, &d);
>                 free_path(f, parent, path);
>         }
> -       reply_entry(req, &e, err);
> +       reply_entry(req, &e, iflags, err);
>  }
>
>  static void fuse_lib_unlink(fuse_req_t req, fuse_ino_t parent,
> @@ -3044,6 +3133,7 @@ static void fuse_lib_symlink(fuse_req_t req, const =
char *linkname,
>         struct fuse *f =3D req_fuse_prepare(req);
>         struct fuse_entry_param e;
>         char *path;
> +       unsigned int iflags =3D 0;
>         int err;
>
>         err =3D get_path_name(f, parent, name, &path);
> @@ -3053,11 +3143,12 @@ static void fuse_lib_symlink(fuse_req_t req, cons=
t char *linkname,
>                 fuse_prepare_interrupt(f, req, &d);
>                 err =3D fuse_fs_symlink(f->fs, linkname, path);
>                 if (!err)
> -                       err =3D lookup_path(f, parent, name, path, &e, NU=
LL);
> +                       err =3D lookup_path(f, parent, name, path, &e, &i=
flags,
> +                                         NULL);
>                 fuse_finish_interrupt(f, req, &d);
>                 free_path(f, parent, path);
>         }
> -       reply_entry(req, &e, err);
> +       reply_entry(req, &e, iflags, err);
>  }
>
>  static void fuse_lib_rename(fuse_req_t req, fuse_ino_t olddir,
> @@ -3105,6 +3196,7 @@ static void fuse_lib_link(fuse_req_t req, fuse_ino_=
t ino, fuse_ino_t newparent,
>         struct fuse_entry_param e;
>         char *oldpath;
>         char *newpath;
> +       unsigned int iflags =3D 0;
>         int err;
>
>         err =3D get_path2(f, ino, NULL, newparent, newname,
> @@ -3116,11 +3208,11 @@ static void fuse_lib_link(fuse_req_t req, fuse_in=
o_t ino, fuse_ino_t newparent,
>                 err =3D fuse_fs_link(f->fs, oldpath, newpath);
>                 if (!err)
>                         err =3D lookup_path(f, newparent, newname, newpat=
h,
> -                                         &e, NULL);
> +                                         &e, &iflags, NULL);
>                 fuse_finish_interrupt(f, req, &d);
>                 free_path2(f, ino, newparent, NULL, NULL, oldpath, newpat=
h);
>         }
> -       reply_entry(req, &e, err);
> +       reply_entry(req, &e, iflags, err);
>  }
>
>  static void fuse_do_release(struct fuse *f, fuse_ino_t ino, const char *=
path,
> @@ -3163,6 +3255,7 @@ static void fuse_lib_create(fuse_req_t req, fuse_in=
o_t parent,
>         struct fuse_intr_data d;
>         struct fuse_entry_param e;
>         char *path;
> +       unsigned int iflags;
>         int err;
>
>         err =3D get_path_name(f, parent, name, &path);
> @@ -3170,7 +3263,8 @@ static void fuse_lib_create(fuse_req_t req, fuse_in=
o_t parent,
>                 fuse_prepare_interrupt(f, req, &d);
>                 err =3D fuse_fs_create(f->fs, path, mode, fi);
>                 if (!err) {
> -                       err =3D lookup_path(f, parent, name, path, &e, fi=
);
> +                       err =3D lookup_path(f, parent, name, path, &e,
> +                                         &iflags, fi);
>                         if (err)
>                                 fuse_fs_release(f->fs, path, fi);
>                         else if (!S_ISREG(e.attr.st_mode)) {
> @@ -3190,10 +3284,18 @@ static void fuse_lib_create(fuse_req_t req, fuse_=
ino_t parent,
>                 fuse_finish_interrupt(f, req, &d);
>         }
>         if (!err) {
> +               int create_res;
> +
>                 pthread_mutex_lock(&f->lock);
>                 get_node(f, e.ino)->open_count++;
>                 pthread_mutex_unlock(&f->lock);
> -               if (fuse_reply_create(req, &e, fi) =3D=3D -ENOENT) {
> +
> +               if (f->want_iflags)
> +                       create_res =3D fuse_reply_create_iflags(req, &e, =
iflags,
> +                                                             fi);
> +               else
> +                       create_res =3D fuse_reply_create(req, &e, fi);
> +               if (create_res =3D=3D -ENOENT) {
>                         /* The open syscall was interrupted, so it
>                            must be cancelled */
>                         fuse_do_release(f, e.ino, path, fi);
> @@ -3227,13 +3329,21 @@ static void open_auto_cache(struct fuse *f, fuse_=
ino_t ino, const char *path,
>                 if (diff_timespec(&now, &node->stat_updated) >
>                     f->conf.ac_attr_timeout) {
>                         struct stat stbuf;
> +                       unsigned int iflags =3D 0;
>                         int err;
> +
>                         pthread_mutex_unlock(&f->lock);
> -                       err =3D fuse_fs_getattr(f->fs, path, &stbuf, fi);
> +                       if (f->want_iflags)
> +                               err =3D fuse_fs_getattr_iflags(f->fs, pat=
h,
> +                                                            &stbuf, &ifl=
ags,
> +                                                            fi);
> +                       else
> +                               err =3D fuse_fs_getattr(f->fs, path, &stb=
uf, fi);
>                         pthread_mutex_lock(&f->lock);
> -                       if (!err)
> +                       if (!err) {
>                                 update_stat(node, &stbuf);
> -                       else
> +                               node->iflags =3D iflags;
> +                       } else
>                                 node->cache_valid =3D 0;
>                 }
>         }
> @@ -3562,6 +3672,7 @@ static int fill_dir_plus(void *dh_, const char *nam=
e, const struct stat *statp,
>                 .ino =3D 0,
>         };
>         struct fuse *f =3D dh->fuse;
> +       unsigned int iflags =3D 0;
>         int res;
>
>         if ((flags & ~FUSE_FILL_DIR_PLUS) !=3D 0) {
> @@ -3586,6 +3697,7 @@ static int fill_dir_plus(void *dh_, const char *nam=
e, const struct stat *statp,
>
>         if (off) {
>                 size_t newlen;
> +               size_t thislen;
>
>                 if (dh->filled) {
>                         dh->error =3D -EIO;
> @@ -3601,7 +3713,8 @@ static int fill_dir_plus(void *dh_, const char *nam=
e, const struct stat *statp,
>
>                 if (statp && (flags & FUSE_FILL_DIR_PLUS)) {
>                         if (!is_dot_or_dotdot(name)) {
> -                               res =3D do_lookup(f, dh->nodeid, name, &e=
);
> +                               res =3D do_lookup(f, dh->nodeid, name, &e=
,
> +                                               &iflags);
>                                 if (res) {
>                                         dh->error =3D res;
>                                         return 1;
> @@ -3609,10 +3722,17 @@ static int fill_dir_plus(void *dh_, const char *n=
ame, const struct stat *statp,
>                         }
>                 }
>
> -               newlen =3D dh->len +
> -                       fuse_add_direntry_plus(dh->req, dh->contents + dh=
->len,
> -                                              dh->needlen - dh->len, nam=
e,
> -                                              &e, off);
> +               if (f->want_iflags)
> +                       thislen =3D fuse_add_direntry_plus_iflags(dh->req=
,
> +                                       dh->contents + dh->len,
> +                                       dh->needlen - dh->len, name, ifla=
gs,
> +                                       &e, off);
> +               else
> +                       thislen =3D fuse_add_direntry_plus(dh->req,
> +                                       dh->contents + dh->len,
> +                                       dh->needlen - dh->len, name, &e, =
off);
> +               newlen =3D dh->len + thislen;
> +
>                 if (newlen > dh->needlen)
>                         return 1;
>                 dh->len =3D newlen;
> @@ -3679,6 +3799,7 @@ static int readdir_fill(struct fuse *f, fuse_req_t =
req, fuse_ino_t ino,
>  static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
>                                   off_t off, enum fuse_readdir_flags flag=
s)
>  {
> +       struct fuse *f =3D req_fuse_prepare(req);
>         off_t pos;
>         struct fuse_direntry *de =3D dh->first;
>         int res;
> @@ -3699,6 +3820,7 @@ static int readdir_fill_from_list(fuse_req_t req, s=
truct fuse_dh *dh,
>                 unsigned rem =3D dh->needlen - dh->len;
>                 unsigned thislen;
>                 unsigned newlen;
> +               unsigned int iflags =3D 0;
>                 pos++;
>
>                 if (flags & FUSE_READDIR_PLUS) {
> @@ -3710,14 +3832,19 @@ static int readdir_fill_from_list(fuse_req_t req,=
 struct fuse_dh *dh,
>                         if (de->flags & FUSE_FILL_DIR_PLUS &&
>                             !is_dot_or_dotdot(de->name)) {
>                                 res =3D do_lookup(dh->fuse, dh->nodeid,
> -                                               de->name, &e);
> +                                               de->name, &e, &iflags);
>                                 if (res) {
>                                         dh->error =3D res;
>                                         return 1;
>                                 }
>                         }
>
> -                       thislen =3D fuse_add_direntry_plus(req, p, rem,
> +                       if (f->want_iflags)
> +                               thislen =3D fuse_add_direntry_plus_iflags=
(req, p,
> +                                                        rem, de->name, i=
flags,
> +                                                        &e, pos);
> +                       else
> +                               thislen =3D fuse_add_direntry_plus(req, p=
, rem,
>                                                          de->name, &e, po=
s);


All those conditional statements look pretty moot.
Can't we just force iflags to 0 if (!f->want_iflags)
and always call the *_iflags functions?

Thanks,
Amir.

