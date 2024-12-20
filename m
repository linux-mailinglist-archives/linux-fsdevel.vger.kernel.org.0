Return-Path: <linux-fsdevel+bounces-37987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBC9F9BFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201EF188CAFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 21:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0362210C0;
	Fri, 20 Dec 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxYal1Og"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129221C180
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730397; cv=none; b=sFG08+omEB9mDKd2Vaw0FzMq4kp0rTxuTDwG5x5V6TVJL56sj0cFubBzG1gi9EsjC0+47+BCDuxOuqzqqOwjwMWDgornq9tRDGCtQVm1dO65sKIB425Z89c2pDYxcA7gUZnTGhDOnko1xWAAW14TxPtFZWG44OsiQAyABj5MpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730397; c=relaxed/simple;
	bh=G214dxzAGZaly00MllnhOIHGnQMWmrqw0lqcLwgs/rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFXG0blq4evVnm1DtQatGE121eBx/0psCN6fF27du4gQOa1UW/pDWB/pN6dPJtcphM4x5JtWCva+nlMe7WKqf8E3MHAOKJlz6qbnlcauGQkNxHwGcjzHDuYRnmoubPQIHnf+/H8rE2nSjE0m4CIh8ureDHFUvT3J2+/1niwtHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxYal1Og; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6ea711805so241862185a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 13:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734730395; x=1735335195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cFWKOlxSZoJIJ1vxCLlA1/1+k3o83VDoCpDUNVcgi8=;
        b=lxYal1OgfesEjHcd1Yqtl+KiATjqzdMm1NW0OqH5dzMb6Gd4cGF3UUrMqZ7pNl19Zq
         yVc1l47yaKdmCCa7FF4Ph4IiXNNa4NLipi59SJkSYbvHk9C87+fySIG2uvZLLZKlzk41
         bPkYeZFMfaQq9Zds050NOuggTmVcgISvGSIEHUKl/IjQiyX7bVzXaFOdb/3fnhJIHAQJ
         L0rCMwxlIAzoHIgrfH9LhtlNOQZVr2HdEufKGYMXI2BAaAQwTsDQndLpr6obG7HP5PaD
         kU53TZLcSETPeUn8rnK0e7nlS513dK6F5jciG8j4iluMdIiU7osj8s8MMey55Raqh7zT
         Azmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734730395; x=1735335195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cFWKOlxSZoJIJ1vxCLlA1/1+k3o83VDoCpDUNVcgi8=;
        b=Uxp2vEptbAUbPDI/2GyPUf/mZ5zIJKygpaSz7iANyyDKvC14VDEPGelxn/7Xk4epvu
         4VX9RZ9c+1HcfQb13fsr8dy9v8ZhCGU6m/WHvYcN/b3zehcK/OaMk4VhW8sr3SHTEKUY
         UnrkW4d4V3MGHjU71wkuyL8KcVAacalp0Fu6AdBQCLCkRutZt2I4Q3uOdGh/p00dVrsy
         QelP96T6yJgmJXvytFCUmgj6gcQHnC2OQ+C5w7Z4gxZjLiWxb8MWqi1n4gDeAxfiaXA+
         QgHfe15wyZRrglU8bYn1XrDr7ke0ngbDlX1u26AHKP1bmbANRRj3I46hr2vfpe+BnfX/
         xZGQ==
X-Gm-Message-State: AOJu0YyzVsgDUx9plXoV+Uwx7U/gIfh8a1rUHfSPgjYtFBgiqmrPlle7
	l7Lj3RstNXGDTEPLJR5DvuZuJxE3NYGB42uICeIR1D4esnLXdygyrTZ1hoP3Vg2SJujZvaKQB3W
	nOCvKHuEjwemmDMpu1dMjCnpuwCw=
X-Gm-Gg: ASbGncv1OX6wvJo2nknbAgydRJohdeBMxmMDhPmecib8UDOw6/AFNbQYLLrOdJNcyWq
	qqfLF3YuGvIOu8q6IX5oiW6qEUW/7BvL5OCCIsOQ=
X-Google-Smtp-Source: AGHT+IHK/HMgeHjwDRxXsCl78k4xPjfZzOnZLbTz+GgmN5Zec8urISCozr/JRJf+wdLUxXwnOX1Inm5paAH6tSiM6uQ=
X-Received: by 2002:a05:620a:440b:b0:7b6:d3b3:5757 with SMTP id
 af79cd13be357-7b9ba715ff2mr753730585a.13.1734730394685; Fri, 20 Dec 2024
 13:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219204149.11958-1-etmartin4313@gmail.com> <20241219204149.11958-2-etmartin4313@gmail.com>
In-Reply-To: <20241219204149.11958-2-etmartin4313@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 20 Dec 2024 13:33:03 -0800
Message-ID: <CAJnrk1Ye2UxfrtSa8_LCJsF2cN5a5jXTg0708i8Vn1e4rxSuOA@mail.gmail.com>
Subject: Re: [RFC] fuse: Abort connection if FUSE server get stuck
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, jlayton@kernel.org, 
	etmartin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:42=E2=80=AFPM Etienne Martineau
<etmartin4313@gmail.com> wrote:
>
> Signed-off-by: Etienne Martineau <etmartin4313@gmail.com>
> ---
>  fs/fuse/dev.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 13 +++++++++
>  fs/fuse/inode.c  |  7 +++++
>  3 files changed, 88 insertions(+)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..351787363444 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -21,6 +21,8 @@
>  #include <linux/swap.h>
>  #include <linux/splice.h>
>  #include <linux/sched.h>
> +#include <linux/completion.h>
> +#include <linux/sched/sysctl.h>
>
>  #define CREATE_TRACE_POINTS
>  #include "fuse_trace.h"
> @@ -307,11 +309,75 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
>
> +static void fuse_timeout_checkpoint_in(struct fuse_req *req)
> +{
> +       int idx;
> +       struct fuse_conn *fc =3D req->fm->fc;
> +
> +       if (!sysctl_hung_task_timeout_secs)
> +               return;
> +       req->checkpoint_time =3D jiffies;
> +       idx =3D (req->checkpoint_time >> FUSE_TIMEOUT_JIFFIES) % FUSE_TIM=
EOUT_DISTRIBUTION;
> +       atomic_inc(&fc->timeout_distribution[idx]);
> +}
> +
> +static void fuse_timeout_checkpoint_out(struct fuse_req *req)
> +{
> +       int idx;
> +       struct fuse_conn *fc =3D req->fm->fc;
> +
> +       if (!sysctl_hung_task_timeout_secs)
> +               return;
> +       idx =3D (req->checkpoint_time >> FUSE_TIMEOUT_JIFFIES) % FUSE_TIM=
EOUT_DISTRIBUTION;
> +       atomic_dec(&fc->timeout_distribution[idx]);
> +}
> +
> +/*
> + * The fuse timeout logic maintain a time distribution sliding window
> + * made of FUSE_TIMEOUT_DISTRIBUTION entries where each entries span ove=
r a
> + * number of jiffies defined by FUSE_TIMEOUT_JIFFIES in base 2.
> + * Just before sending the request to the server, we increment the cores=
ponding
> + * distribution entry and once the request is ack back, we decrement tha=
t same
> + * entry because we remember req->checkpoint_time.
> + * Now, a timeout can be detected by simply looking at the old entries i=
n the
> + * distribution and see if there is something hanging past a certain poi=
nt.
> + */
> +void fuse_check_timeout(struct work_struct *wk)
> +{
> +       int idx, x;
> +       struct timespec64 t;
> +       struct fuse_conn *fc =3D container_of(wk, struct fuse_conn, work.=
work);
> +
> +       if (!atomic_read(&fc->num_waiting))
> +               goto out;
> +
> +       /* Current position in the distribution */
> +       idx =3D (jiffies >> FUSE_TIMEOUT_JIFFIES) % FUSE_TIMEOUT_DISTRIBU=
TION;
> +
> +       /* Walk back and trigger abort when detecting old entries in the =
second half */
> +       for (x =3D 0; x < FUSE_TIMEOUT_DISTRIBUTION; x++,
> +                       idx =3D=3D 0 ? idx =3D FUSE_TIMEOUT_DISTRIBUTION-=
1 : idx--) {
> +               /* First half, keep going */
> +               if (x < FUSE_TIMEOUT_DISTRIBUTION>>1)
> +                       continue;
> +               if (atomic_read(&fc->timeout_distribution[idx])) {
> +                       pr_info("fuse %u is stuck, aborting\n", fc->dev);
> +                       fuse_abort_conn(fc);
> +                       return;
> +               }
> +       }
> +out:
> +       if (sysctl_hung_task_timeout_secs)
> +               queue_delayed_work(system_wq, &fc->work,
> +                       sysctl_hung_task_timeout_secs * (HZ / 2));
> +}

I haven't looked too closely at the exact logic in this yet but at a
first glance, some things don't seem robust. For example, if the
fuse_check_timeout() gets rescheduled right after the "idx =3D ..." and
before the for loop, then it could falsely abort connections that
haven't actually expired. imo this implementation is a lot more
confusing to follow and harder to prove correctness for. don't see the
logic in [1] as being too slow as yes it grabs locks but it only
checks against the head of each list and the job runs every 15 or so
seconds with no overhead for queueing and dequeueing.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20241218222630.99920-2-joannelkoo=
ng@gmail.com/

> +
>  static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
>  {
>         req->in.h.len =3D sizeof(struct fuse_in_header) +
>                 fuse_len_args(req->args->in_numargs,
>                               (struct fuse_arg *) req->args->in_args);
> +       fuse_timeout_checkpoint_in(req);
>         trace_fuse_request_send(req);
>         fiq->ops->send_req(fiq, req);
>  }
> @@ -359,6 +425,7 @@ void fuse_request_end(struct fuse_req *req)
>         if (test_and_set_bit(FR_FINISHED, &req->flags))
>                 goto put_request;
>
> +       fuse_timeout_checkpoint_out(req);
>         trace_fuse_request_end(req);
>         /*
>          * test_and_set_bit() implies smp_mb() between bit
> @@ -2260,6 +2327,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
>                 LIST_HEAD(to_end);
>                 unsigned int i;
>
> +               cancel_delayed_work(&fc->work);
>                 /* Background queuing checks fc->connected under bg_lock =
*/
>                 spin_lock(&fc->bg_lock);
>                 fc->connected =3D 0;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f2860..243d482a057d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -44,6 +44,12 @@
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>
> +/** Request timeout handling */
> +#define FUSE_TIMEOUT_DISTRIBUTION_SHIFT 3
> +#define FUSE_TIMEOUT_DISTRIBUTION (1L << FUSE_TIMEOUT_DISTRIBUTION_SHIFT=
)
> +#define FUSE_TIMEOUT_JIFFIES (order_base_2( \
> +       (sysctl_hung_task_timeout_secs * HZ) >> FUSE_TIMEOUT_DISTRIBUTION=
_SHIFT))
> +
>  /** Maximum of max_pages received in init_out */
>  extern unsigned int fuse_max_pages_limit;
>
> @@ -438,6 +444,8 @@ struct fuse_req {
>
>         /** fuse_mount this request belongs to */
>         struct fuse_mount *fm;
> +
> +       unsigned long checkpoint_time;
>  };
>
>  struct fuse_iqueue;
> @@ -923,8 +931,12 @@ struct fuse_conn {
>         /** IDR for backing files ids */
>         struct idr backing_files_map;
>  #endif
> +
> +       atomic_t timeout_distribution[FUSE_TIMEOUT_DISTRIBUTION];
> +       struct delayed_work work;
>  };
>
> +
>  /*
>   * Represents a mounted filesystem, potentially a submount.
>   *
> @@ -1190,6 +1202,7 @@ void fuse_request_end(struct fuse_req *req);
>  /* Abort all requests */
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
> +void fuse_check_timeout(struct work_struct *wk);
>
>  /**
>   * Invalidate inode attributes
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 3ce4f4e81d09..9f8fe17801c4 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -23,6 +23,8 @@
>  #include <linux/exportfs.h>
>  #include <linux/posix_acl.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/completion.h>
> +#include <linux/sched/sysctl.h>
>  #include <uapi/linux/magic.h>
>
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -1002,6 +1004,7 @@ void fuse_conn_put(struct fuse_conn *fc)
>                 struct fuse_iqueue *fiq =3D &fc->iq;
>                 struct fuse_sync_bucket *bucket;
>
> +               cancel_delayed_work_sync(&fc->work);
>                 if (IS_ENABLED(CONFIG_FUSE_DAX))
>                         fuse_dax_conn_free(fc);
>                 if (fiq->ops->release)
> @@ -1785,6 +1788,10 @@ int fuse_fill_super_common(struct super_block *sb,=
 struct fuse_fs_context *ctx)
>         fc->destroy =3D ctx->destroy;
>         fc->no_control =3D ctx->no_control;
>         fc->no_force_umount =3D ctx->no_force_umount;
> +       INIT_DELAYED_WORK(&fc->work, fuse_check_timeout);
> +       if (sysctl_hung_task_timeout_secs)
> +               queue_delayed_work(system_wq, &fc->work,
> +                       sysctl_hung_task_timeout_secs * (HZ / 2));
>
>         err =3D -ENOMEM;
>         root =3D fuse_get_root_inode(sb, ctx->rootmode);
> --
> 2.34.1
>

