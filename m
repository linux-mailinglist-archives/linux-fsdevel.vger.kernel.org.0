Return-Path: <linux-fsdevel+bounces-53219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD0AEC526
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 07:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDB57B1E02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D23A21FF5D;
	Sat, 28 Jun 2025 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/XuTb0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2A18FDA5;
	Sat, 28 Jun 2025 05:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087778; cv=none; b=uvapKOPFoe+dTGSeIdsPC+bytMQ+J27bCGFZONbD4vyc73L/rtSe1//pcYb99XpRZTbTt4RUtCu6es9AxbIIE7ug/iYbBTZeDDGOshOwM2oH4VRLjd+T2fo0OherDLTOsNHsrPakxVyb1KyaZy0lrjUgNilSvbDWE2iupRaPy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087778; c=relaxed/simple;
	bh=kmUNxobeB0njNMzwF7LrNaylmg8DHAlPL5J+TyxuS5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfkQcVjzgoKTWFq+coIyGqJaoMgG43VlRvarmjGRo/eOkDjNY3/+BJw56TM76kZbgI44VET5VNfNdMILEXtiV/eGxPOzvu96nBMYJed7jl8wQ8NLdXWKDvB+w6H3GZFIJKfnM9CV8q0HfDxayVxenUG63hyWrobV1+jkKEbPBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/XuTb0s; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fb3bba0730so44114606d6.0;
        Fri, 27 Jun 2025 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751087776; x=1751692576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZzuLz3ZdZm/BXeBE3Uu6Q075nf+/ZJsx7az6Vf24W8=;
        b=W/XuTb0sL3m2qM2XUzOp9zZAt9LpnGOGPW+eKPKRcSFpyRsq8ifMkPcJvPSpd52N7q
         ogQJfLOFTiTtmO2uJVPEg8v4L4hDHVfjFibLJcsjRICsLDnMo5hRN/SnYDFg3PCJbUC0
         800jmMh3BX7FlkA/JxxSb5yGXJjDupRJKTajtsDOVMMdFlnq8Pfe0AgxRh5X7spPb6Na
         40/IxuQjAYcKlluUIz7tHfXjaSMormbismePsUDOti/uEMgooieLUiZSPYbXsZg1a95F
         SzA3NRSITGE5CTPTXI6r3Bh9gLKrUhVKExtaiY5fu8YOaYTDPnQhZz73b2glA89PibRU
         AZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751087776; x=1751692576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZzuLz3ZdZm/BXeBE3Uu6Q075nf+/ZJsx7az6Vf24W8=;
        b=KI7n/g/x4FN6yZbuTQGki3DJ5ul0NmiEX/w9X8LpprjihgqYI+U763krQyk2yCqhGB
         OchlKauds7/J4XAKnCDK98FP1M2YyOArSzpZ2VjBENIkx40axG+oObjiTze4h6Ll7BjK
         kvSmRvQQUR26NbFI2731FPW6jHTuuut6qggcrl7j/NgGeExTpV5OU8sX+r1bVTtC00t5
         kUm+y/o62QHFVeC9BvjIBfawKciYIwN0oDd5VEOkW/+MbNysD//tTJBuB5B35uBpziJl
         LxxC5tqXWMXMz72COgJFUjg96Xu9YFgnPqNEwU2rALSyZeInKS4cW3GUx1/UOEeFq/AL
         1GCw==
X-Forwarded-Encrypted: i=1; AJvYcCUlbWs26uqN1UUSkUxEZaYMzMVp0JFA+UsHeDuVK22oaFf253v99DN/QQyVY8gj3qalTO0nEB/hdhSMdY8cyw==@vger.kernel.org, AJvYcCW7muEbhjCyghkM7YLg8q0dYi52ZgobKH+hVUd/65ACn0FK/Dq78j9LNzUnOpBwCQewAfDzYiQJNGYAiw==@vger.kernel.org, AJvYcCWIbkeXD8CZG3Q9GoB3pMswwzO7KjuaE4IJaA9uOORodWFHPSpMHQpbTM53RhzSCPI0BRAMJE+1+LDo@vger.kernel.org, AJvYcCWS0El6SmHZ7mMtSeSIaBUcS9bia5y1Z/cQ3tD9j7N0l84K66o6lnSMiKsIfeD8/0vdCDkTAvoNa9YB1DPz@vger.kernel.org, AJvYcCXltXwkBwTDWawhkW5P22vqHHWwF47rPYo0CL5xh8cLMYLsXUZsitAD1Yam4ugfGNEYXJyXjucSrzz4@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKeM14n/z1jxFoCZ9Qto6wqLZ0sP4/hH4waN97ZjoOA+BZ85q
	QZHv0HTwDJAB/HkhEu+Gc4+9vgbwFU9V/bBiPq4RtGC9ofprYUjexYL1F5JztoD57E/h/K+npxr
	Dsuxyeq0KDgj0UNcJGXmZ04+HwHJyZFE=
X-Gm-Gg: ASbGncvL6rdgsnQ0ro1iuBwS/yavBCn9GD/dBm9f5ve9wqmkQwti2C509je+WoNfPd0
	3lN30ShnBBxKEnWcffHgImt3Xv1MoLrJ28SwjLDs0+fM7ZXOL3NwVhkwlpiTOe2kFT5NfKMeofu
	fOwiSXKbIrKY5wTJ4HKmeIaLwf8fVQGI2H/Ru5L/GwyKIia2v/hrh/awK8KZss8Qw9byc+ByduY
	4Y3
X-Google-Smtp-Source: AGHT+IE3pV2VIZ8GVDu8D3pAn+xP9KrFnsfkAKfJDtc+HIgTfF3yrwoj4qZhhy4gTbGbHZchNndWk9tFbBpQfYxX40s=
X-Received: by 2002:a05:6214:c26:b0:6fb:265:a2c3 with SMTP id
 6a1803df08f44-7009ec17fcbmr75209046d6.17.1751087775584; Fri, 27 Jun 2025
 22:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625164213.1408754-1-dhowells@redhat.com> <20250625164213.1408754-2-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-2-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 28 Jun 2025 00:16:04 -0500
X-Gm-Features: Ac12FXwcDHZq4ogM0eCqt7A4iCsu0Kuzvz-14NRnkkfT6DFtusqJyok4ECDYnws
Message-ID: <CAH2r5mv2m3z+PHC_t1AaFAoV0+tU3fHU+HvX1HeK5S11u_KspA@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] netfs: Fix hang due to missing case in final DIO
 read result collection
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can add my tested by to the first 11 in the series.  I have
verified that they fix the netfs regression (e.g. hangs in xfstest
generic/013 etc.).  The series appears important to make sure gets in
6.16

On Wed, Jun 25, 2025 at 11:44=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> When doing a DIO read, if the subrequests we issue fail and cause the
> request PAUSE flag to be set to put a pause on subrequest generation, we
> may complete collection of the subrequests (possibly discarding them) pri=
or
> to the ALL_QUEUED flags being set.
>
> In such a case, netfs_read_collection() doesn't see ALL_QUEUED being set
> after netfs_collect_read_results() returns and will just return to the ap=
p
> (the collector can be seen unpausing the generator in the trace log).
>
> The subrequest generator can then set ALL_QUEUED and the app thread reach=
es
> netfs_wait_for_request().  This causes netfs_collect_in_app() to be calle=
d
> to see if we're done yet, but there's missing case here.
>
> netfs_collect_in_app() will see that a thread is active and set inactive =
to
> false, but won't see any subrequests in the read stream, and so won't set
> need_collect to true.  The function will then just return 0, indicating
> that the caller should just sleep until further activity (which won't be
> forthcoming) occurs.
>
> Fix this by making netfs_collect_in_app() check to see if an active threa=
d
> is complete - i.e. that ALL_QUEUED is set and the subrequests list is emp=
ty
> - and to skip the sleep return path.  The collector will then be called
> which will clear the request IN_PROGRESS flag, allowing the app to
> progress.
>
> Fixes: 2b1424cd131c ("netfs: Fix wait/wake to be consistent about the wai=
tqueue used")
> Reported-by: Steve French <sfrench@samba.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/misc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 43b67a28a8fa..0a54b1203486 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -381,7 +381,7 @@ void netfs_wait_for_in_progress_stream(struct netfs_i=
o_request *rreq,
>  static int netfs_collect_in_app(struct netfs_io_request *rreq,
>                                 bool (*collector)(struct netfs_io_request=
 *rreq))
>  {
> -       bool need_collect =3D false, inactive =3D true;
> +       bool need_collect =3D false, inactive =3D true, done =3D true;
>
>         for (int i =3D 0; i < NR_IO_STREAMS; i++) {
>                 struct netfs_io_subrequest *subreq;
> @@ -400,9 +400,11 @@ static int netfs_collect_in_app(struct netfs_io_requ=
est *rreq,
>                         need_collect =3D true;
>                         break;
>                 }
> +               if (subreq || !test_bit(NETFS_RREQ_ALL_QUEUED, &rreq->fla=
gs))
> +                       done =3D false;
>         }
>
> -       if (!need_collect && !inactive)
> +       if (!need_collect && !inactive && !done)
>                 return 0; /* Sleep */
>
>         __set_current_state(TASK_RUNNING);
>
>


--=20
Thanks,

Steve

