Return-Path: <linux-fsdevel+bounces-40100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74CA1BFE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 01:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3271615AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F75CB8;
	Sat, 25 Jan 2025 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d27you7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4217991
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765452; cv=none; b=eP6JTswDywZ4KQ09Dv85oSSJRRuSSWcdzJv22icb629FVANtTHmI5Ct9KZXFADpA5OElK29SmTPdj5c8da4L+dLEXl4j41a5X9DjtWiveFo5ivMDVl9y8gqkM0ASuotmcokOLtvZyzqJyrtX/OW87npBG8v0dgE2AFOoeXJLe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765452; c=relaxed/simple;
	bh=0MTH9Sj+lAW8Fq2EpCpoeH94r85m1Dc1k1NA0sPKm+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iF5euEnOQ+IA2QWuElUPb39GvfiN9AeL1U+R26vf1pL28N51hH4ADaxlhAy94GotZrrP4Q+0F8PRfIV7Gs1WqUyLHIAOurwC/NIfcvqgUZ547imqXTjMfbdKnwEqPfomkebL0cLu4ljxfxarq4FLaXHGpce/CzBGGGtZKTdHnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d27you7r; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4679eacf2c5so26670111cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 16:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737765449; x=1738370249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYg1XfbIthKforMXXSuHq2DMtHDb0qAUfQUDcKpK7tM=;
        b=d27you7r4YWjvgP0BvxcoE+XtiVXrxH6AwG6FPJUu/L0zIwIch2TGzz56/utptX29U
         8Z9rMPL/KwC3Im0QCSV57wL0Krk4RM7dFyfJZkrGanOtbEYlWGeCqjZqfXg9NGkobhus
         w8Ilq3+8fdS5R6VgmCeDZceFt01j74MpzLWXdfoZ57SpYOwQUA2nagY8Pm98PvPQ/0Wh
         liXAUTgLe2lCnDFjTtb2f6MS+v/A8unFHfIAngH8wA0aQmlDr5fH+7yWgCx9LflGi4WQ
         Ob/uyzWV6cT0yX1ixNSfGgi2jWIntMkvAWqIWNicDUjDP5eEXMBYOktQ8PDKtLx7PTdM
         8DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737765449; x=1738370249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYg1XfbIthKforMXXSuHq2DMtHDb0qAUfQUDcKpK7tM=;
        b=Gewpi5YfyoLsv0yMFPoOnqMaeFmx69TDaI/sxklJBhW4/+sBCyQv+Iji1H+WysJ3u1
         NWWtXwzgdcgRduKBAbT0a00A/9bv7wkr1fqqNV2WtWofkV2vQ0H1cge2SYLC419qbBZE
         jsoKlDXqqFn7fgYgc4ko1gVzVYCQQiHduBCjX/67cMweldkr5qvyERHd+UpBhTjNhzUK
         22bPLzit+bqgBDnsi3OaH7MaE4Xe0t9abHX1fBi+qMdLIxlnE/pUUiZ61mLj291ErcNS
         RP1vk81JTw8M+iLD2UOT07S9FfeJvRig2nH5S7pQJ1COL3Eq2mWm5XFkEbNvBd3+c/5v
         soJA==
X-Forwarded-Encrypted: i=1; AJvYcCWMkzezGZON77ca9otFsziJUZsXl+ot21LTa9VijFqY/Mo7RONpc9BexclM3FWjsPw0CAydy/jiQUlInq4g@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmRjbDjZE175kFr49c0yPWc0d0QzskgJYnq57/hwZ6qeaI3WR
	fAha6HMGR9BEFoMkkxBXiB0aygxuqweb44gkiG4prv3CMkhg4ca8TxBpw7UUBkEOT1GQG5x3uzP
	HI5GpHmnqWaNdOGbg1FcjiicB5xo=
X-Gm-Gg: ASbGnctXBufgBMJwR6o35GhnchfOx5hD3UMPbibGsjeuhbZwVaHZcwuTmaIdqmeQIpr
	J2n0+3Ox5SCMd+Yb8CE2DOgVqGkZkEsUP1/3QqtbeDCofSRZfDAE/64MvlcGqBYde/OmWlPD0ug
	==
X-Google-Smtp-Source: AGHT+IHEGEbOw0FLWtuH39I14O3FGMe5nPkiwdhyBxPYPqQwzqSbsFFiELH9bbmmvmGR4oc+Q2wpV3iCMU+wYdvWtKE=
X-Received: by 2002:ac8:7d13:0:b0:46c:7252:927f with SMTP id
 d75a77b69052e-46e12a1ff3cmr445847701cf.6.1737765449405; Fri, 24 Jan 2025
 16:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124-optimize-fuse-uring-req-timeouts-v1-0-b834b5f32e85@ddn.com>
 <20250124-optimize-fuse-uring-req-timeouts-v1-2-b834b5f32e85@ddn.com>
In-Reply-To: <20250124-optimize-fuse-uring-req-timeouts-v1-2-b834b5f32e85@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jan 2025 16:37:18 -0800
X-Gm-Features: AWEUYZngHxeRHJwK6GGxrIkJYrB2ywiYsepz0DhMFzvDLPy7k_nBKfegYBTiezs
Message-ID: <CAJnrk1ZB0u6jb3=oReHex=C=f1chEQ0RdPu9LxG=o7OeAk1qGw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fuse: {io-uring} Access entries with queue lock in fuse_uring_entry_teardown
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 8:47=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This ensures that ent->cmd and ent->fuse_req are accessed in
> fuse_uring_entry_teardown while holding the queue lock.
>
> Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 1834c1933d2bbab0342257fde4b030f06506c55d..87bb89994c311f435c370f789=
84be060fcb8036f 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -315,14 +315,20 @@ static void fuse_uring_stop_fuse_req_end(struct fus=
e_ring_ent *ent)
>   */
>  static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
>  {
> -       struct fuse_ring_queue *queue =3D ent->queue;
> -       if (ent->cmd) {
> -               io_uring_cmd_done(ent->cmd, -ENOTCONN, 0, IO_URING_F_UNLO=
CKED);
> -               ent->cmd =3D NULL;
> -       }
> +       struct fuse_req *req;
> +       struct io_uring_cmd *cmd;
>
> -       if (ent->fuse_req)
> -               fuse_uring_stop_fuse_req_end(ent);
> +       struct fuse_ring_queue *queue =3D ent->queue;
> +
> +       spin_lock(&queue->lock);
> +       ent->fuse_req =3D NULL;
> +
> +       req =3D ent->fuse_req;

I think you meant here to switch these two lines? otherwise i think
req will alwyas be null here.

Thanks,
Joanne

> +       if (req)
> +               list_del_init(&req->list);
> +
> +       cmd =3D ent->cmd;
> +       ent->cmd =3D NULL;
>
>         /*
>          * The entry must not be freed immediately, due to access of dire=
ct
> @@ -330,10 +336,15 @@ static void fuse_uring_entry_teardown(struct fuse_r=
ing_ent *ent)
>          * of race between daemon termination (which triggers IO_URING_F_=
CANCEL
>          * and accesses entries without checking the list state first
>          */
> -       spin_lock(&queue->lock);
>         list_move(&ent->list, &queue->ent_released);
>         ent->state =3D FRRS_RELEASED;
>         spin_unlock(&queue->lock);
> +
> +       if (cmd)
> +               io_uring_cmd_done(cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED)=
;
> +
> +       if (req)
> +               fuse_uring_stop_fuse_req_end(req);
>  }
>
>  static void fuse_uring_stop_list_entries(struct list_head *head,
>
> --
> 2.43.0
>

