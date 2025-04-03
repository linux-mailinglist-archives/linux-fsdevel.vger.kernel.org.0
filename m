Return-Path: <linux-fsdevel+bounces-45677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE20A7A957
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB4918851A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA202517B9;
	Thu,  3 Apr 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUlU/lX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A52517B5
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704865; cv=none; b=XYgSXjyPotFDWaAoQ1A+n2fA7ZXXZWxkwWOSlU4575lgp16yd125BMLYiCmfoE3rL7DFXxpTEIKzVfQ1HiEID9yB/Iuk+JR3J2G/BxkIYi5f2p+OsflEWbWQN8ASJ8Sc7SQ0uTsBPDkpuscfN4aFilYR5ZBQOdiA78vRUPQ6wjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704865; c=relaxed/simple;
	bh=s6lpRAxQjvU2iDNWo8mSjyE8CTyowqItrDA2/AbUCNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCvX0xF1C6kaOFoKxhQpto8UGS+wkIfZSpqDuITBT+XY5/HBBzC1Wi+w3HryQnenV384MufYQXupSvK28aPC6dSoSLLMML5y0mXOaGpBPYtLeio5o3nKjevdL5D8XZc8mUcW6pqxy3Izqv35oBjAlCn2qxORRFgz4Hd0DDtTlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUlU/lX8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4766631a6a4so11911731cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704861; x=1744309661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLvGbUctTK1azwDAdhKQVhKd8ZHAO8rnA8vUK/DSL0E=;
        b=kUlU/lX82f77GmfhEzj8AzRqb5hqgbaTclWMF6piv0tckE1vkTL5Vfj/WKc7BK6Bd5
         /UqnCcpy0XDnZ3c57s2bGXloL7NUYdAGfZU+pTruWd1Fa9HZbD47JA7vGbpOrzoJwl/E
         tIKRQCNvjSezLiNWlLsPcl8KZiraPeVIub0PQlEAA8YHZDLAO6J01Eswgj/nndIs9ba2
         vrLoetUEaurD6SWKVqUiJ+0ene2V+uLPOh0nkAniYlhINcq/agyUBB+PdfdqMsyz0ljs
         53iSpQ3HyiSj+5fJQFDaDblRZygBOQXyZyg6FEajag0PSThrPzOUU7q0kpaQSq11w7w/
         b0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704861; x=1744309661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLvGbUctTK1azwDAdhKQVhKd8ZHAO8rnA8vUK/DSL0E=;
        b=IputVX3s6thhgqzb17dys+F0ZgMS3Ssg6WaY/VthpdiKP7fchtMlnkJbwwEG2Kbpb0
         WTOCsx0dSLYeLwuJkbUXkQjUHigDboE9RIIGcURVaHB84dCqh3MsKPTVGR30QoJXimqX
         zimKstqRJyPOj0r4TBIg5Nqo4CbNAETkwKwgjVMLYqH8lIp+j935eI5j3klMPDeUC2wV
         OiO3Sl1Gg9RDPT6g/0LjsJNPh/9WPNLLF3LKnKlxTAF99amNlgPHDRkByxHEGOCQ9hep
         3U+xs+3sVxeT3QX7fAvxzL+8X+FhZZPXwFwA0sH/M1Huyxl1kIcYOON2cMvcwC9UBNHB
         3DXw==
X-Forwarded-Encrypted: i=1; AJvYcCXL9HOM7A+N1pyACNDpYlrvILP6JWUJE3VzPDsGeInYqCBUBOZidRopCxwlFMfu+mnIF+THr5uZlZ9SSJGt@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzqEf04zAC7k0DjEYZQvxHlF4fM9srRMTEgV9y8Xi6oSnzsAn
	HtDbiZcDtSq3B3VI/6uy3VoxGIsgKnBdSubtuksR9ovEvPs+VLu440aSB5PgBb7lhUPGdo6B15N
	dZTO3lSKgzwnlNz67SHGaqFDElzk=
X-Gm-Gg: ASbGnct0NswMkK909yLI2fi+qJzRJWkxIAAcapgLH4OYYNUXuMS0mqJDj4UFdLvx50+
	8NwkfI73QadPHKNTFvnKgx+9fVZIc+w7iBkdHsplfViyjieQF6/EsCzCMRL1Owvu+UBUsG/2yDe
	JVTBqdL3lJtKaqhZHU+2OK4gvyteEIgmO+YlsuoHvoWg==
X-Google-Smtp-Source: AGHT+IGXBUUGEQteo8lHTMrWGX750Rv3VXHaMNtfOP14V7f53X+u2BoFiXgnlL0VJbfDMZv/YKxm2VC9M0v44L5UM3M=
X-Received: by 2002:a05:622a:191e:b0:476:7e6b:d28c with SMTP id
 d75a77b69052e-479249d5d91mr6414381cf.32.1743704860800; Thu, 03 Apr 2025
 11:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-fuse-io-uring-trace-points-v2-0-bd04f2b22f91@ddn.com> <20250403-fuse-io-uring-trace-points-v2-1-bd04f2b22f91@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v2-1-bd04f2b22f91@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 3 Apr 2025 11:27:29 -0700
X-Gm-Features: AQ5f1JpPL3f5JzyVlqK0_et3nlyQnH2IyJeLA-UAkFEc58pPI_W_ZuXvkzi2hbg
Message-ID: <CAJnrk1bMWWkDXUmrrUFsUgr6MDKH2XtoF1mtZwEfXNOyh9Kkow@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] fuse: Make the fuse unique value a per-cpu counter
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 6:05=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
> No need to take lock, we can have that per cpu and
> add in the current cpu as offset.
>
> fuse-io-uring and virtiofs especially benefit from it
> as they don't need the fiq lock at all.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c        | 24 +++---------------------
>  fs/fuse/fuse_dev_i.h |  4 ----
>  fs/fuse/fuse_i.h     | 23 ++++++++++++++++++-----
>  fs/fuse/inode.c      |  1 +
>  4 files changed, 22 insertions(+), 30 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 51e31df4c54613280a9c295f530b18e1d461a974..e9592ab092b948bacb5034018=
bd1f32c917d5c9f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -204,24 +204,6 @@ unsigned int fuse_len_args(unsigned int numargs, str=
uct fuse_arg *args)
>  }
>  EXPORT_SYMBOL_GPL(fuse_len_args);
>
> -static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
> -{
> -       fiq->reqctr +=3D FUSE_REQ_ID_STEP;
> -       return fiq->reqctr;
> -}
> -
> -u64 fuse_get_unique(struct fuse_iqueue *fiq)
> -{
> -       u64 ret;
> -
> -       spin_lock(&fiq->lock);
> -       ret =3D fuse_get_unique_locked(fiq);
> -       spin_unlock(&fiq->lock);
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL_GPL(fuse_get_unique);
> -
>  unsigned int fuse_req_hash(u64 unique)
>  {
>         return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
> @@ -278,7 +260,7 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fi=
q, struct fuse_req *req)
>         spin_lock(&fiq->lock);
>         if (fiq->connected) {
>                 if (req->in.h.opcode !=3D FUSE_NOTIFY_REPLY)
> -                       req->in.h.unique =3D fuse_get_unique_locked(fiq);
> +                       req->in.h.unique =3D fuse_get_unique(fiq);
>                 list_add_tail(&req->list, &fiq->pending);
>                 fuse_dev_wake_and_unlock(fiq);
>         } else {
> @@ -1177,7 +1159,7 @@ __releases(fiq->lock)
>         struct fuse_in_header ih =3D {
>                 .opcode =3D FUSE_FORGET,
>                 .nodeid =3D forget->forget_one.nodeid,
> -               .unique =3D fuse_get_unique_locked(fiq),
> +               .unique =3D fuse_get_unique(fiq),
>                 .len =3D sizeof(ih) + sizeof(arg),
>         };
>
> @@ -1208,7 +1190,7 @@ __releases(fiq->lock)
>         struct fuse_batch_forget_in arg =3D { .count =3D 0 };
>         struct fuse_in_header ih =3D {
>                 .opcode =3D FUSE_BATCH_FORGET,
> -               .unique =3D fuse_get_unique_locked(fiq),
> +               .unique =3D fuse_get_unique(fiq),
>                 .len =3D sizeof(ih) + sizeof(arg),
>         };
>
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 3b2bfe1248d3573abe3b144a6d4bf6a502f56a40..e0afd837a8024450bab77312c=
7eebdcc7a39bd36 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -8,10 +8,6 @@
>
>  #include <linux/types.h>
>
> -/* Ordinary requests have even IDs, while interrupts IDs are odd */
> -#define FUSE_INT_REQ_BIT (1ULL << 0)
> -#define FUSE_REQ_ID_STEP (1ULL << 1)
> -
>  struct fuse_arg;
>  struct fuse_args;
>  struct fuse_pqueue;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index fee96fe7887b30cd57b8a6bbda11447a228cf446..73c612dd58e45ecde0b8f72fd=
58ac603d12cf202 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -9,6 +9,8 @@
>  #ifndef _FS_FUSE_I_H
>  #define _FS_FUSE_I_H
>
> +#include "linux/percpu-defs.h"

Think the convention is #include <linux/percpu-defs.h> though I wonder
if you even need this. I see other filesystems using percpu counters
but they don't explicitly include this header. Compilation seems fine
without it.

> +#include "linux/threads.h"

Do you need threads.h?

>  #ifndef pr_fmt
>  # define pr_fmt(fmt) "fuse: " fmt
>  #endif
> @@ -44,6 +46,10 @@
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>
> +/* Ordinary requests have even IDs, while interrupts IDs are odd */
> +#define FUSE_INT_REQ_BIT (1ULL << 0)
> +#define FUSE_REQ_ID_STEP (1ULL << 1)
> +
>  /** Maximum of max_pages received in init_out */
>  extern unsigned int fuse_max_pages_limit;
>
> @@ -490,7 +496,7 @@ struct fuse_iqueue {
>         wait_queue_head_t waitq;
>
>         /** The next unique request id */
> -       u64 reqctr;
> +       u64 __percpu *reqctr;
>
>         /** The list of pending requests */
>         struct list_head pending;
> @@ -1065,6 +1071,17 @@ static inline void fuse_sync_bucket_dec(struct fus=
e_sync_bucket *bucket)
>         rcu_read_unlock();
>  }
>
> +/**
> + * Get the next unique ID for a request
> + */
> +static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
> +{
> +       int step =3D FUSE_REQ_ID_STEP * (task_cpu(current) + 1);

I don't think you need the + 1 here. This works fine even if
task_cpu() returns 0.

> +       u64 cntr =3D this_cpu_inc_return(*fiq->reqctr);
> +
> +       return cntr * FUSE_REQ_ID_STEP * NR_CPUS + step;

if you want to save a multiplication, I think we could just do

 static inline u64 fuse_get_unique(struct fuse_iqueue *fiq) {
   u64 cntr =3D this_cpu_inc_return(*fiq->reqctr);
   return (cntr * NR_CPUS + task_cpu(current)) * FUSE_REQ_ID_STEP;
}

> +}
> +
>  /** Device operations */
>  extern const struct file_operations fuse_dev_operations;
>
> @@ -1415,10 +1432,6 @@ int fuse_readdir(struct file *file, struct dir_con=
text *ctx);
>   */
>  unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
>
> -/**
> - * Get the next unique ID for a request
> - */
> -u64 fuse_get_unique(struct fuse_iqueue *fiq);
>  void fuse_free_conn(struct fuse_conn *fc);
>
>  /* dax.c */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9db2cb8c150878634728685af0fa15e7ade628f..12012bfbf59a93deb9d27e0e0=
641e4ea2ec4c233 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -930,6 +930,7 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
>         memset(fiq, 0, sizeof(struct fuse_iqueue));
>         spin_lock_init(&fiq->lock);
>         init_waitqueue_head(&fiq->waitq);
> +       fiq->reqctr =3D alloc_percpu(u64);
>         INIT_LIST_HEAD(&fiq->pending);
>         INIT_LIST_HEAD(&fiq->interrupts);
>         fiq->forget_list_tail =3D &fiq->forget_list_head;
>

I think we need a free_percpu(fiq->reqctr); as well when the last ref
on the connection is dropped or else this is leaked

Thanks,
Joanne

> --
> 2.43.0
>

