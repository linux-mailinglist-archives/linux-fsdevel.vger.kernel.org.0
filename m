Return-Path: <linux-fsdevel+bounces-44040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C018FA61B28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D2B3B4EF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C562204C32;
	Fri, 14 Mar 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQix6Sdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEEC153800
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982189; cv=none; b=Z0+8oKgrGJxS4laDirtdWeUGDEL2AsmyB6avU7VAHaqNLXg2WBGm5r8y4o11iJD3+6hagBLZMBsKCr4jvEFHoc7cLb20pL7lL6gSNYinJrCe3/+dZT92h8CMW+AzcJXZPzD604rCMnBLRVt2h/0Ql6KXCzNJ5R8PVGILaYpVzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982189; c=relaxed/simple;
	bh=QPcbFVwyiceU+LXCADi3lN+9436QlvVPA0OUyYcy+ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOuU0MoftI5f6Yw1YHIX1Y90J07jDYZAR4yT7SHBKhcQyfUnJ+hTdZe4nVRXYnKEm0OGy3A9X+0Kq151gXWw6631f1QM2hLGXqHfHBXUa7F6aNMztdcS6MYyfozBwySVr2QQZB6ZG7Y9hizm6IjrDv8AkhD6hHXvAHS+oPnL9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQix6Sdt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476af5479feso25010591cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741982187; x=1742586987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMhMFDBfRsg+OapRO9H7Neo+GvLuO2S2uAxpdfU4glQ=;
        b=PQix6SdtkFsoZU7E8Etz8ZwGmU03cv3DJlUgFXgjkaywjrD+Va53MfYGz1QQrRVu+z
         tZGl9bh3fLcgzwQ8oI/9i5YA7Zp/caF4BmdxxHHeiXCNeWup6D8C7vaIR/u02aaqaIss
         1sXsvXap7j0e5MCVyGuab4mIfJAMhlyrcZxU1pBJlAJDgT2vuZNx2cXMlMifXsxlFKRf
         /5xYty2qKHn88Jf2Emrbfi/V8/+mVYuNLHLHrF/RUnpTEDAZvYfsaSSjF8y/9nsT/sp9
         dsXV722RYTkAq7HBksB9tFG4EfKxV3U68K6fvT03ZiJAeRlzgfi5vNTdCjbal8aJNmmZ
         ldBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982187; x=1742586987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMhMFDBfRsg+OapRO9H7Neo+GvLuO2S2uAxpdfU4glQ=;
        b=Nc3NLilTugcWPH+bAy7XbBPLHj8CR19FeLpqHkwrxmtKAcX9eRuSn5K76ca3dkzmTJ
         OP7/dq/VdSN0muM0JbAj/xOZn8r3VrN8dSypEOoqqXqizxxY2lDPoDIqpBP6/jv40WRJ
         NCtqXL7j4o9EbnUHqyTseUE8nLt8SrFGxKaFOFFADgTPLtjXqT2IpmznVXmPXm3muVXQ
         +mt0XzVpvRNjqb437WPsLkyFY+1b93ZrXuPh+fkG2CiGkBh3SdyLxi171BJfWNleJMB3
         UMcyPfv5w1M0Pd6UaHLSaO4ZjC1r7mStuOsblR4lKm47cTTifkNohImBblCCK6MTMfw2
         MWkw==
X-Forwarded-Encrypted: i=1; AJvYcCWy7g9ru8Y2Ip4Mqty7+arFg5xj6wRjyZjy4/p+0E8Halxmj/DQz5HiNXtJFqR5DSgUhf17q2fi7yDIg85U@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUqkxW3RfC6KQVZ4ghuj9RPpwSlWRQv3ClzpzzZ/970fqVB8C
	jbE7pPiO4KNvpQAVLzrFYhqM0Ytl56DhoWEj+8QMzuNP+zhdJ+EEYrk8tCLON1hXxF+Kco9GE/r
	WJ5jt2Ta5UO3oBZUkMkxVuEs9goA=
X-Gm-Gg: ASbGncuav0PsU8n8ZkLfuLej5kHOb4Qx5n/jrgf28T6Ms/FfofN83VOmSef66aY3a4m
	Xz1GY/ihNuImJYTOFQ3b9kFgxzwDP0PiQOa/wd1sch+nYMNG83K/gI0nTCk4tncChhjjYxXsAvE
	2QM4fgrEOXNTaOSbQR7N8dmJDFMnU=
X-Google-Smtp-Source: AGHT+IFWb43u5RuylL6jgpLnfIVMpRQL+0k9xpgt3dKGkEV8BgeWmger1r+y0HSHRBd1UGhYfps9NYW2sWUMTuZEdyE=
X-Received: by 2002:a05:622a:2b0d:b0:476:8eb5:1669 with SMTP id
 d75a77b69052e-476c81c84cemr56972811cf.32.1741982187090; Fri, 14 Mar 2025
 12:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314191334.215741-1-joannelkoong@gmail.com> <3d85f45f-a04d-4f79-9d07-4836f8cf422c@fastmail.fm>
In-Reply-To: <3d85f45f-a04d-4f79-9d07-4836f8cf422c@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 14 Mar 2025 12:56:16 -0700
X-Gm-Features: AQ5f1Jr01HEkhMmM3ZUhKpg8H17crvTHgDAlUir8ThDbfp6oqRgiexoTtSEmYdQ
Message-ID: <CAJnrk1ZNu4-TKQ8Onr8kGUhuzmrN0kyaT=pmFQtdgYM_MZ63gQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix uring race condition for null dereference of fc
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:46=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 3/14/25 20:13, Joanne Koong wrote:
> > There is a race condition leading to a kernel crash from a null
> > dereference when attemping to access fc->lock in
> > fuse_uring_create_queue(). fc may be NULL in the case where another
> > thread is creating the uring in fuse_uring_create() and has set
> > fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> > reads ring->fc.
> >
> > This fix sets fc->ring only after ring->fc has been set, which
> > guarantees now that ring->fc is a proper pointer when any queues are
> > created.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands"=
)
> > ---
> >  fs/fuse/dev_uring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index ab8c26042aa8..618a413ef400 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -235,9 +235,9 @@ static struct fuse_ring *fuse_uring_create(struct f=
use_conn *fc)
> >
> >       init_waitqueue_head(&ring->stop_waitq);
> >
> > -     fc->ring =3D ring;
> >       ring->nr_queues =3D nr_queues;
> >       ring->fc =3D fc;
> > +     fc->ring =3D ring;
> >       ring->max_payload_sz =3D max_payload_size;
> >       atomic_set(&ring->queue_refs, 0);
> >
>
> oh, I  didn't get that and even KCSAN didn't complain. But I see that it
> would be possible. I'm just a bit scared that the compiler might
> re-order things on its own.
>
> What about this?

Hi Bernd,

I think an easier way then might just be

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ab8c26042aa8..64f1ae308dc4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -250,10 +250,10 @@ static struct fuse_ring
*fuse_uring_create(struct fuse_conn *fc)
        return res;
 }

-static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *r=
ing,
+static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_conn *f=
c,
+                                                      struct fuse_ring *ri=
ng,
                                                       int qid)
 {
-       struct fuse_conn *fc =3D ring->fc;
        struct fuse_ring_queue *queue;
        struct list_head *pq;

@@ -1088,7 +1088,7 @@ static int fuse_uring_register(struct io_uring_cmd *c=
md,

        queue =3D ring->queues[qid];
        if (!queue) {
-               queue =3D fuse_uring_create_queue(ring, qid);
+               queue =3D fuse_uring_create_queue(fc, ring, qid);
                if (!queue)
                        return err;
        }

where we pass fc directly. I'll submit this as v2. i couldn't make up
my mind between the two initially :)

Thanks,
Joanne

>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9d78c9f29a09..f33a7e6f5ec3 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -241,11 +241,12 @@ static struct fuse_ring *fuse_uring_create(struct f=
use_conn *fc)
>
>         init_waitqueue_head(&ring->stop_waitq);
>
> -       fc->ring =3D ring;
>         ring->nr_queues =3D nr_queues;
>         ring->fc =3D fc;
>         ring->max_payload_sz =3D max_payload_size;
>         atomic_set(&ring->queue_refs, 0);
> +       /* Ensures initialization is visible before ring pointer */
> +       smp_store_release(&fc->ring, ring);
>
>         spin_unlock(&fc->lock);
>         return ring;
>
>
>
> Thanks,
> Bernd

