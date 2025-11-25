Return-Path: <linux-fsdevel+bounces-69828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7628C86958
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6123B2C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2032938F;
	Tue, 25 Nov 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8d/52dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0EC3016F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095033; cv=none; b=qmw423M9juj7xU2Txj3gXD92CGwKe32g/SdF5v+5nuSrURGDho7vfIfU1Zf/7HdDjtuM06d/yFMApgjd/ycN6/1cWI7rh6X7UjRGKiRqmdRqgZvwzhAWEPMtv1kzKY9nU24R2iedavdPtPZPQeZciua07Go/ObA8jaIin7wzid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095033; c=relaxed/simple;
	bh=jbgXOzCR/GZ217muZed1zRMD+l402zZKC7omM22Etb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcj2Vbe/A6oW7yKBKzoGUJrv3eX5ZfZ+7V4mw3bAdmw4skTUfPXMd8+5s286LnwO3GZIwd5hxAaNup+K1fdn1ZLgQtST0Dabw5aAp7VD5aNmiNu0Z/VjL0bU3myt/lIKjTJGfHRxWjoAO7YwDvwpvxK5GxS9XMtnllEu+tFBlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8d/52dm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed861eb98cso63042661cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764095031; x=1764699831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3tydmKvXCBQ5thZMPZm88UpOyDOUvzTtCssow991EE=;
        b=Q8d/52dmVh/bep2VHxLzSChABQGx2St6fjOdrIjjZLNUKpUc9py5ka05v8sLidxoUs
         D+Acfo0zNfe+AhB4wTxpM3WOJkTqhP2Md1SqJWGWuHOGpJ5u31tXdVsEKQbN5g2nWa2C
         DHhR0YLmEyGPNLSIzyyA8GMxeU3zgen3/F7Q1aFG5QBfKNrSdPIX6Vr+dIskqpuXhcFS
         K8WkmSEGqY7Z8D58h7OGfywY5kd2ZH6uZDiCFm7FFDtS7aWEgp1czdCoKq9J8O6WTtcc
         4TXKcyQNwyNFajzkP7MNaoegso8eSN04v4+pvkvA6w/aUt8bTY+/o7dj1Gayn6T/IElb
         qfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764095031; x=1764699831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3tydmKvXCBQ5thZMPZm88UpOyDOUvzTtCssow991EE=;
        b=oKlrYlB86W0vy63FS9CDBbylpp1E8DdsqailcAoxA2Sgp3CKpRJQvUhOGrZWIqN20P
         0AV4aJWA9YTZFcj09o9qkaf73M7CCw/qiMSM0SPZBnEG54G9To2QgYN3RSlRfUS+BQcc
         EZ6/RHPMpLfQH6l6xHcB8Gbrd8vRqLQoMb8p6aX0frAx1tSWgTwgS4hwrIECIapm+SSq
         wNZJsycUjTeGiLmCddE9dZCDN2g2BblsN8Ta/KzaJnNdYI8vJysAYuaBR5M/j7xDqy9b
         9JCitb5x0ZL92gAPSaGPBSeCtgOUR7FB6249wCVJopzdtv9B30vbNmrCWIesrujGCpmk
         rcfg==
X-Forwarded-Encrypted: i=1; AJvYcCUL0dGc2kh9MsSkw1oWEinSPwVrsSbRuhX/FCEgS7CUn1GGUVBsEqcuTsGgNay8y2Zzr3Wf9a5UMiCoveXl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7vJRCugSdUxDkck1egAikFoL+THJ2JAlrb9zce3PNfz54kSU
	vLIa9hXBiQo4KH39FApoYw1wFA5ro4ogYAtOY1rN6jPqmGOpTsJR1S54Su52Ajy08zbk7PXkTXv
	PLcILzLuPzGy0u/oV/tO4gj+7svbZrXn7UOvBX7I=
X-Gm-Gg: ASbGncsGmZLvTlkLg9o2qgQfBew3sDIRpaE/9UNWyu8L/EzUdQPPk/osWwkjIB5Y9rH
	eG4ubdYYYOd4xuU4HL9KfS08xLv0nmlb4fRoFTgaBBXHnuDzQC1rBHwlJQOR1auqWHsNmMW/iOd
	7lPyPrgD4yJiFvPKdRVPknrPBA/kSVZkELxAn32Qc7VxYcaq2WFR50xG0yXhvNT6ND3LxxBO6WD
	RieszFSiY9KcG2BPuXz47QB5ahuI/rs5XftTF2oVBJtM2WwK9Kh1eG6WcRqOF8LyV6Hcg==
X-Google-Smtp-Source: AGHT+IHH0/yc8vNLiTt4QwUBaRrKiAt2SaoPTELn+GAa9bZbtTZ9/A/quWX5m1L/0e5r+OgdHFfixxHNNWzg+xdnI6Y=
X-Received: by 2002:a05:622a:294:b0:4ee:19f2:9f1b with SMTP id
 d75a77b69052e-4ee58a79321mr256090841cf.37.1764095030614; Tue, 25 Nov 2025
 10:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125181347.667883-1-joannelkoong@gmail.com>
In-Reply-To: <20251125181347.667883-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 25 Nov 2025 10:23:39 -0800
X-Gm-Features: AWmQ_bkl5VDcemWfDtAk01TEc0j7nfDf_U_h9ZIrS3LFUcMxE4C9Y4oxt9ol7j0
Message-ID: <CAJnrk1Y+QR8OfRBkZDe6a4R56m62-Evsu2cbRoKHHnK1JB+i1w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix io-uring list corruption for terminated
 non-committed requests
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:15=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> When a request is terminated before it has been committed, the request
> is not removed from the queue's list. This leaves a dangling list entry
> that leads to list corruption and use-after-free issues.
>
> Remove the request from the queue's list for terminated non-committed
> requests.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")

Sorry, forgot to add the stable tag. There should be this line:

Cc: stable@vger.kernel.org

> ---
>  fs/fuse/dev_uring.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 0066c9c0a5d5..7760fe4e1f9e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -86,6 +86,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *en=
t, struct fuse_req *req,
>         lockdep_assert_not_held(&queue->lock);
>         spin_lock(&queue->lock);
>         ent->fuse_req =3D NULL;
> +       list_del_init(&req->list);
>         if (test_bit(FR_BACKGROUND, &req->flags)) {
>                 queue->active_background--;
>                 spin_lock(&fc->bg_lock);
> --
> 2.47.3
>

