Return-Path: <linux-fsdevel+bounces-58726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F0B30A34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C51D06E7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D76FC3;
	Fri, 22 Aug 2025 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icfWBs4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCF522F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821764; cv=none; b=M/fVOemkDR8AtyDKXrSAvfFS4SYtnRHGtkovay6GsIIHCAboUyHKd/vuH+3WUyhj30HMi2uTZMRI6VeZxaU7Ze39gQkwdM2OeHQf+SvS4hBDif4NQsdCPLSBq+YgsKlp05dz7rDT9zV8IMtG0PVNLzvf7RJMLG+dCBVbEMRKQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821764; c=relaxed/simple;
	bh=/0sydYJkthAOuc2kNzwqYyGsN2AVAPL5xdFnfeCn9MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZKZeVU07tGSzA1rPiDW72K5Njs3I9a0Hdxt1bl7tR5Tltvjcg+nfsABMv3JRGXxrtpRuZfD8mZ5ec4t1X3z/xugw88bh2AaOjQVuXKREMUirFInpGYmRFqNxJfizEceF+Lno4Z3nrGbCynUGOiwrGUOZim/fqe/e/6IF6Vqb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icfWBs4K; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109c58e29so25061301cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755821762; x=1756426562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9jPzh5KapuxdOitpgNlQdTXvWQoITQJEMjsHhigEr8=;
        b=icfWBs4K1KSSyVOpAFT+td2bCDysSub2DKQ1cuFC/4xIyQ4cVB6gr6MzNFgI4s1kDi
         AQ0GnJZZGoSsasUIruTvUyuGfauve1oSnic9ygB8KxJDwORruaqKBl4ggQ9/OwXTwre7
         uOiamDv6k3kmq8RsAIoXFqd4FlYx78igfMrgyVKcwRZW4cT8yz8/lqgA0F9qqg5EXxxK
         O2FNsZx4i71AmAR+hCtHOICjAea5LwVqtr9aMBiSE76b1/QPzGDBJXN8RXpnRbn5cGbB
         GnoxhgIRFgV8P5v74d7uM+olywWXM//5tThCRmq1Qw98SZeqjLWWgMAcOH4qGyvL9Fht
         24yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755821762; x=1756426562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9jPzh5KapuxdOitpgNlQdTXvWQoITQJEMjsHhigEr8=;
        b=AV5YNBbSQtEkngJJbq6MCzHgBueYoYM/3LFhx0hZErox4WCILRWEJMVmIDRudc/O+h
         IhWypO/PTKJ4ngRsPi9oaVS/pt7bBnFZZ4bJHryZB6Jut94u+gU/Q5mRLsStqKebbk/v
         ea3LWR6GzsFwtyKDQcXTLmhUZwMxIjzpekgwwKAnmPsc4EPTareurUCSBeNVHBBVxLNT
         KY35Tjo9sPW9ruVSb3EQkoRGdH2Sy0BMZKU8ccKiYOKCKYSFLJ2iZsXgyMmp0MUO6sTm
         6XWOzV7afR3RGdPm0RgVENqllwL9WvRz0mdBAL+2cHIlLOCfRLN/pJKXgXVEZwlkM45s
         OQow==
X-Forwarded-Encrypted: i=1; AJvYcCXVt2rF+Y8CEjxr24pIpwmTu7mbuaM2xMXW1vm0utuRWzGJ/gIhpKw+qR/0CB7QVvoFnq0juODXHl7V8fNL@vger.kernel.org
X-Gm-Message-State: AOJu0YwKo1qnh3MaXek3HLCeSriEwggW5BagO0MQ6/RgzmUlBSevj4IT
	TOiF1vev2zZpCrZQcRalwTVMbY6CnNr9EHePZ2dzDWGVHXpCnoxco7zw7Y2epKuHEjk2UwqHC7s
	YuqDHlqcekhr+/S+9SupXZ/O6obQibHo=
X-Gm-Gg: ASbGncukUL1Dib1qtcPaw7V6P3w+LR2gTQqy4c+65/zU6/T8ueRqe6MbwMFtub6+QxQ
	ODMyxviTCF6V4+N5Yf354+uiNccANHgH3jfGkvSWDBBY+l3aLnXlcvm5+mP1PdU1y2tLQz/saR7
	8/eEtFEp5vhVutyqtSYMYZEv1FrkQIR3VMlEIvEBHTRtdcypSsVC3KupVWqbghmCSujdpmVTK4Z
	RDikzsn
X-Google-Smtp-Source: AGHT+IGRGdJGWVLeBCr720t1VMXok6v3/3BvbXQrt10pQ0s+kYDG+RBjOzQTr0nBqE/eNj9VgSqFScCI6wVYYzq7CTc=
X-Received: by 2002:a05:622a:558a:b0:4b2:8ac4:f07a with SMTP id
 d75a77b69052e-4b2aab8ac87mr18547341cf.76.1755821761551; Thu, 21 Aug 2025
 17:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 21 Aug 2025 17:15:50 -0700
X-Gm-Features: Ac12FXzpjRBYhqbZGRqqGuEtlz6BRNGYd-j23PLPzrZtwTYhXNqSHNzmYVGddDs
Message-ID: <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being sent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:51=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> The fuse_request_{send,end} tracepoints capture the value of
> req->in.h.unique in the trace output.  It would be really nice if we
> could use this to match a request to its response for debugging and
> latency analysis, but the call to trace_fuse_request_send occurs before
> the unique id has been set:
>
> fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len=
 107
> fuse_request_end:     connection 8388608 req 6 len 16 error -2
>
> Move the callsites to trace_fuse_request_send to after the unique id has
> been set, or right before we decide to cancel a request having not set
> one.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/dev.c       |    6 +++++-
>  fs/fuse/dev_uring.c |    8 +++++++-

I think we'll also need to do the equivalent for virtio.

>  2 files changed, 12 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6f2b277973ca7d..05d6e7779387a4 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -376,10 +376,15 @@ static void fuse_dev_queue_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>         if (fiq->connected) {
>                 if (req->in.h.opcode !=3D FUSE_NOTIFY_REPLY)
>                         req->in.h.unique =3D fuse_get_unique_locked(fiq);
> +
> +               /* tracepoint captures in.h.unique */
> +               trace_fuse_request_send(req);
> +
>                 list_add_tail(&req->list, &fiq->pending);
>                 fuse_dev_wake_and_unlock(fiq);
>         } else {
>                 spin_unlock(&fiq->lock);
> +               trace_fuse_request_send(req);

Should this request still show up in the trace even though the request
doesn't actually get sent to the server? imo that makes it
misleading/confusing unless the trace also indicates -ENOTCONN.

>                 req->out.h.error =3D -ENOTCONN;
>                 clear_bit(FR_PENDING, &req->flags);
>                 fuse_request_end(req);
> @@ -398,7 +403,6 @@ static void fuse_send_one(struct fuse_iqueue *fiq, st=
ruct fuse_req *req)
>         req->in.h.len =3D sizeof(struct fuse_in_header) +
>                 fuse_len_args(req->args->in_numargs,
>                               (struct fuse_arg *) req->args->in_args);
> -       trace_fuse_request_send(req);
>         fiq->ops->send_req(fiq, req);
>  }
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 249b210becb1cc..14f263d4419392 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -7,6 +7,7 @@
>  #include "fuse_i.h"
>  #include "dev_uring_i.h"
>  #include "fuse_dev_i.h"
> +#include "fuse_trace.h"
>
>  #include <linux/fs.h>
>  #include <linux/io_uring/cmd.h>
> @@ -1265,12 +1266,17 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue=
 *fiq, struct fuse_req *req)
>
>         err =3D -EINVAL;
>         queue =3D fuse_uring_task_to_queue(ring);
> -       if (!queue)
> +       if (!queue) {
> +               trace_fuse_request_send(req);

Same question here.

Thanks,
Joanne

