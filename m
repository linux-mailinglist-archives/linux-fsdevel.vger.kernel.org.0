Return-Path: <linux-fsdevel+bounces-40172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E8A201C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B75E166061
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA21DC1A7;
	Mon, 27 Jan 2025 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf3ZwjT6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619AB1DB346
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020871; cv=none; b=LJCDT20B1+SBKHSkTPuC++IiRDRp0DIc5rsgv4xIRgYUDdzjbt7aB9cDY3aBwuiSJmOgxrVZNsxsHWJ13/eHQKu+rIbDnZA3KsG0m8QiBgdYB+OskbsW7tEbmOZ4//TP80ryzRoORRBo1e8Vf78WLeJV9yK54QQa+4HV077LiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020871; c=relaxed/simple;
	bh=3C0wVvZV9WSS1+BtatK3BDRQzUJYjDbs/fw3ib+jfQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZWFVRU5v71juGuheK3GEcLOPmjBggekFEvAkh5JRaOe9W7b4CTSUHTwuGPnDLrCIc2RFNZB4QiWNczVJWNwaQWjO4L6Js8jg4THhkQfqPQ0tDVK7piEZH4tw68JZ/flHHoc89amQSx5RxRCg+WXYNeZTBPkhK1t2iT42nsa+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf3ZwjT6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467a6781bc8so41453211cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738020869; x=1738625669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmryrEpzFa0GmSfdf4qwmrLfbGFNXuP4KOZQhXQZFgQ=;
        b=nf3ZwjT6nmVDytCPZXzbG2YtJBjT8XIc6mOqePABtcLvGcrHFzjnDfhxJKxAvoNWRu
         9xkCbHZDSuR5Eyx4n/4Y0a57aSE83hK3PJIoSCK+TtbLWLqd5oVhzlffgHc2DT80g7DH
         tsYP5xmeoELM5O2l7jzDKTo1F5QXj1xdI8DOol1HfO2hyVlq52HRpN0Q4FSzkizsPcal
         9cimwnqMb9Ok5k50bXPh5f51quDCjfnbGaXW11Jjl1vFDXTBkXXlZac0UEM3XzWouA9i
         EVTLPURTGAGuaS8FRn76fVk93SIp/AAIVEjnAk0+Tzdvl99tQ1Zhquf1J7RREuoas0Pq
         LPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738020869; x=1738625669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmryrEpzFa0GmSfdf4qwmrLfbGFNXuP4KOZQhXQZFgQ=;
        b=pMvCSq7uN52PAtwlOC47VTEWmCzUko4iXKbNI+Q/gsdXNyS9tc00wih+vC1TERRvCl
         X9XkprATgfJpxbngOvLNiH2D0jKSRGqYp2MBe3y9goIFF8+xVynHO2+o8zd3MbU2mNaN
         /cQEgDLqQZvDJEnkxFFgjtGkauVi20imQQR+EqDzRR34/W/FuqP0dxQ+tR/WyamKfpWR
         z874rAABxlX4uY7iWJp71KUJVgWQWpMivuTFJif58AGaD9NvIKjyr5+62h2hN2Kvypk1
         wON67iuiNAEEVlrM45qKd7H86hlpfmlf0Tj4SFCByeyyqcEypl1Hwly+RGcCAiM1Hghk
         7YjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMsbP7ZAoz/fKfHqrrIOAOQtdAc2T/zj7qbSIkLdrAPP0FSW+hpi2xTZ2Fb7gIm6BZ3KqBxC6khyInIG1@vger.kernel.org
X-Gm-Message-State: AOJu0YzwDXsGKyiVHpbGTnla6n8W0o1wiSHdSxoBIowFMUurqlEyAKec
	mnp7qr7hQp3ah2z1vNpHZzexL0OVJ81UQ9whLiz/9rcN3XCvDf9JwvtHzkzfenolGx56eN00sZX
	hGt4A/D6eijD8dOCeRqVyrJnt+Xs=
X-Gm-Gg: ASbGncvoSkOw87miGG9WfhVKs5MUwpiPaiYB5Sxt8NFxmjKy9i5ugF8ED8lAftuBb4C
	c1CgMXBh+8iaMCcizjPIbpox5fhLAvvrc5KeDLEZBR6wfbRqzi2H/n3KblwfPKRgm/242xorNQe
	F/aImQUl0UzSZR
X-Google-Smtp-Source: AGHT+IFhxPW07D79LOCUzVqNeSORNRJw8SGJeUCsCw3vBr5TSHlnzgJ87wO4FI1RgD1fjVZOpLddJ8xQIkghMMUEK5A=
X-Received: by 2002:a05:622a:2c5:b0:467:5d0b:c744 with SMTP id
 d75a77b69052e-46e12b213abmr609751031cf.16.1738020869146; Mon, 27 Jan 2025
 15:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-2-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-2-7771a2300343@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Jan 2025 15:34:18 -0800
X-Gm-Features: AWEUYZmxbdHGbKix5eTdtLPMU8LTjRaEJ3H_5vfuHCndMrn_NF4M7J4pBZYmM9s
Message-ID: <CAJnrk1Y629Xv297RbRtCiRWgqe-qggvcvaG35sC2FNJpYJcXtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] fuse: Use the existing fuse_req in fuse_uring_commit
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 9:44=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> fuse_uring_commit_fetch() has obtained a fuse_req and while holding
> a lock - we can use that for fuse_uring_commit.
>
> Fixes: 2981fcfd7af1 ("fuse: Add io-uring sqe commit and fetch support")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 2477bbdfcbab7cd27a513bbcf9b6ed69e90d2e72..3f2aef702694444cb3b817fd2=
f58b898a0af86bd 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -796,12 +796,11 @@ static bool fuse_uring_ent_assign_req(struct fuse_r=
ing_ent *ent)
>   * This is comparible with handling of classical write(/dev/fuse).
>   * Also make the ring request available again for new fuse requests.
>   */
> -static void fuse_uring_commit(struct fuse_ring_ent *ent,
> +static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req=
 *req,
>                               unsigned int issue_flags)
>  {
>         struct fuse_ring *ring =3D ent->queue->ring;
>         struct fuse_conn *fc =3D ring->fc;
> -       struct fuse_req *req =3D ent->fuse_req;
>         ssize_t err =3D 0;
>
>         err =3D copy_from_user(&req->out.h, &ent->headers->in_out,
> @@ -923,7 +922,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cm=
d *cmd, int issue_flags,
>
>         /* without the queue lock, as other locks are taken */
>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> -       fuse_uring_commit(ent, issue_flags);
> +       fuse_uring_commit(ent, req, issue_flags);
>
>         /*
>          * Fetching the next request is absolutely required as queued
>
> --
> 2.43.0
>

