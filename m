Return-Path: <linux-fsdevel+bounces-40170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C5DA201BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5F73A40F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A81DC9AD;
	Mon, 27 Jan 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA9SlpG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772571DB346
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020785; cv=none; b=L7teiDICrRRZVs5fOTsz6tOYxJ4sYrdONVUmgaAkptiMVRqtVU6CUIrI+3EmkRC+UUiMduWj2JVvWKjoJ27A9JsnpLjCJuOPzSr/xjYmeAjPVRiLwKdXu7BQD059JrvIfycwVO/ZKN1FGS4191spJ1++FsJleD6M92/D7xvA4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020785; c=relaxed/simple;
	bh=UEXcA93KbREFFSweeZ9DQ7R9P+NPXT1y8de/aDOUudM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCetCsM8RPSiVRfJifQE30DujLptmxI5OoGDpHMH5/g4OutntsT0qH55KSCreQfOQktpANrUiZB9TjF17l7Q7zdTXLQTXWTQz74lLc+u0BxvIIuHEzfeZ2DfjEXRCcxUsPP8TMepxOFarnvFec6O2u8XzCGBKjJEpScZSv27xl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA9SlpG/; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46c7855df10so83047981cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 15:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738020782; x=1738625582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h642IZb3suZ4SX4kpeeMQl5ioeWZStycs864zw0UW78=;
        b=CA9SlpG/Y9O+M3zCrUmC/bGvxp6yROVa+MfqgJUobinOHXJtkSpl/mKAZ7WclMo7R1
         DW7QbvBt40LPRUssyl3QDzTzXzdh1Jvw5674b+od1Jkb0q1GPCcUfVJAGS6s4vt9Pq1K
         PRtPJjPcEXvzJLw5fdDY8bFRJE5+JMPXTWxgHTbvRL8gf7N0PQRoDEzHZ/Mz4PlDTZoX
         ENkgQpIInAaEu/k8ihyV6Nm/T67IDV+nPyDJGzI1PSu09l+Qc4zxiXjAQGSrl1PhSPDv
         aLPj7agB4FaDI5TjzwhtW10lis8IPskEFLNJf/vT66sL8/awa0AEdjiKKfEBTf3rqiJF
         7Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738020782; x=1738625582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h642IZb3suZ4SX4kpeeMQl5ioeWZStycs864zw0UW78=;
        b=FMkylO4mDvuSX7FCuM61v3lOmU6iC21H0DO0gaHqrobm4KgBb2R+8jTbJ0/03LOUS8
         PKopOYicrmRqMUCksDKxBRY7XQbozyHRT/8Aw6ONgBOZBNCrsdN3uUB8CNobYvxJDhQt
         TxGsWbo/5yJePuOn57Yc8WLGV/ximS+4F7V2soidL+SOukbCNQf88mTPt9m8GXGNXrUM
         YjfeSHcMDir8lRCE3ASAUt+/CV8fTpx4WTe5CcYiusQJK3yQtgoYy9ykkkTc65SJwSyD
         1fOT9Gj7Ak3g45VCki1vdIAk0VRoXErR0OpQ8Ng7RbcxlvmSRWCkalfHLZrWCAq/hCSm
         qTMw==
X-Forwarded-Encrypted: i=1; AJvYcCVVXSgmB2ZLSv+PbQXkgkNAQ1ZpKltCZPVHiuixEZwv1bfifIX8bEsIPUlmq2yGyjDSX14bLvp2izaRZVKL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhg7VDz0XFQKmQfFVy1ulM+A6wcJBkcAufVdYEqo2ukIVWzxnK
	z044Uv4f2esGDyc7pG0+xbTKp2fMMnZKaWTcpLzZWps2cpwvMWRDbiIjsKUcTvrdtNKcqeMcxeq
	YyuKVQ2823+36DGGi7lY3rmpSALc=
X-Gm-Gg: ASbGncvkXN5i6a2Lf1M2GZcPypOCQGXLOJo49k+MYceHnPADiuBxZUZ/a/SYBzmMxRo
	iABnMcLCedItvP7dPt7UT+LY58ZtihrsohxsdFvdnxaap2b7bg7OBus8RPiTBOpQtpMAwZADcD8
	jsNQ==
X-Google-Smtp-Source: AGHT+IHNZTWT/bZGS+jpW+noq8LaCdoiXOiqgFT1qldCyPY4c8UBgvB1MvKVTl4RHXmQH9Ny1dE1eBkkx3Vne3117YE=
X-Received: by 2002:a05:622a:350:b0:466:9018:c91f with SMTP id
 d75a77b69052e-46e12a3a608mr538423251cf.1.1738020782295; Mon, 27 Jan 2025
 15:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-1-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-1-7771a2300343@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Jan 2025 15:32:51 -0800
X-Gm-Features: AWEUYZmwElsuynZuk2-hbrYhIGNxXPYibdjb2Yl3U_BeaUwwnJrLP3byizRM9UI
Message-ID: <CAJnrk1bB+GvMUCnOmEh2NZRL-VBfU+jmuCNA48gnu8zdKcnkDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] fuse: Access fuse_req under lock in fuse_uring_req_end
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 9:44=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> We should better read and set ent->fuse_req while holding
> a lock, at it can be accessed from other threads, for
> example during teardown.
>
> This was part of a patch from Joanne for timeout optimizations
> and I had split it out.
>
> Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev_uring.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5c9b5a5fb7f7539149840378e224eb640cf8ef08..2477bbdfcbab7cd27a513bbcf=
9b6ed69e90d2e72 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -78,12 +78,14 @@ static void fuse_uring_flush_bg(struct fuse_ring_queu=
e *queue)
>  static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
>  {
>         struct fuse_ring_queue *queue =3D ent->queue;
> -       struct fuse_req *req =3D ent->fuse_req;
> +       struct fuse_req *req;
>         struct fuse_ring *ring =3D queue->ring;
>         struct fuse_conn *fc =3D ring->fc;
>
>         lockdep_assert_not_held(&queue->lock);
>         spin_lock(&queue->lock);
> +       req =3D ent->fuse_req;
> +       ent->fuse_req =3D NULL;
>         if (test_bit(FR_BACKGROUND, &req->flags)) {
>                 queue->active_background--;
>                 spin_lock(&fc->bg_lock);
> @@ -97,8 +99,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *en=
t, int error)
>                 req->out.h.error =3D error;
>
>         clear_bit(FR_SENT, &req->flags);
> -       fuse_request_end(ent->fuse_req);
> -       ent->fuse_req =3D NULL;
> +       fuse_request_end(req);
>  }
>
>  /* Abort all list queued request on the given ring queue */
>
> --
> 2.43.0
>

