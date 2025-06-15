Return-Path: <linux-fsdevel+bounces-51686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21169ADA1E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205A6188D41B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551A26A1B9;
	Sun, 15 Jun 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvHSKc3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D459322A;
	Sun, 15 Jun 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749994136; cv=none; b=EohCn4zgjKCmWMD6PHMr2VgXTVG8Fj77f8u8vjKVa0GiMqLxEjOXNDMfcS0zMqlNh3ENb5OakPQVZ/1F4rF+XW8FrOmP+QrKdST0c1QqqBOUUKgBtMOgCdJQUbZoTIGReOhXw+5EKDLNO+1Pr41KH4DOFsM6fkFGydBomYvYq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749994136; c=relaxed/simple;
	bh=sWAssjyEI19FZAiGhHjYqcuvewEk9PvOIDIT68my4gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXFS1cz6kLo3gb6fLWIzY+FFu6cE4UwHnJGk7//s3Wp5fp2homc5t9RzZh31fw030KYB6pOYSZfPgat1g6eFtYvHPHzuu1Z2Ubrl9XfPkElWmJECgNpZqPpZZ5iAm/W0LRPZcy02h/gJKzRHluqUOa+ODl5B1JDwBxMy3Fu2sVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvHSKc3c; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso6576865a12.0;
        Sun, 15 Jun 2025 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749994133; x=1750598933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjiH1xK6fYQmGjxEPvPdDfi2YzSjG40dEI9e3IGwPTE=;
        b=TvHSKc3cg5pbTc8bArNEd/V4RqxkoEE7FxORxQ23zLMcyVsEmnLYVnVFW3xHzYj/Bt
         KNrwWgky5R4RaDIOwW/wH8tclfcy8fw9z3VV83SCujzqnQtFHrwqY7FujKZTgl9tmcXu
         p17hN0vr+ep6tevM1tlR/9q4sXGOJn4V6sNVpSFmVTmmknLEbGMCnwnwdpUkwQcuBHRl
         v/SZ7kAo5kw5i242oB75cDrrvqiTToorPlFz6+ATvbMDU7gOiuxNQkj8l8lu8KVWOGJ9
         bChaA+QR3c4fnQwMItEKIWSWNABKAEw4y0PZzNsanNpe8EKBBKxIcXt3Mmcluuuu6C5u
         tt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749994133; x=1750598933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjiH1xK6fYQmGjxEPvPdDfi2YzSjG40dEI9e3IGwPTE=;
        b=X18OM0EykNOAfB+uPouHaeeRz4AYC2jHpQIyOtBZI7UE2k6wM3MgdJYJMmD40SccL5
         hg6uYzimFhHbJu6AiOoAbN8VbdipXpFgoQqE4gkLp03lEt/izvgThQpOL054yZ45cezN
         h2UlKSu4h9ZghlMR/QmjPz4xN/mj2dkQfr82ow1xrhY8LSEf5x/PQCd6J/rDuFtdaPAx
         WqHAzmZxvP++1GPiUsy0fj54WhFxO2i/+fVmytXG4nU8sWeNyEhX28pRpf0PqpetPFKj
         1I6UEa0t2agVtmQSMvm2JLYrgkIDrNNUZl0c7FsFzeQCHZ3Ft9aqZ5q5FgmpVK71OeKd
         8zjA==
X-Forwarded-Encrypted: i=1; AJvYcCUu1oA2rIyA86ASeyvfBYPusXEYYoLOFN4tSlXVsFByAYAletZ2JTWw79fI2f5gDkxzQZNmg9RTpa1LkPtF@vger.kernel.org, AJvYcCWW+NMVoXGxkPrnR/n85ofchsXDUWzq+gGb9t6/DkCQgRT8ZCQfYKN8rAJWSKscVuYLlSCSgjJwbQz3UiCi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/cKyS0XKoRYyuu49ID84p0q9Vd+wO/NhOaDM97MCTz1aT4Ws1
	DqzmIKurgwJkgLvOmFW7q5dJ2UPu7Sfdyqbzc2QBZTyw1rsgpufJX+eGXBb8ZG++M56+K4x627w
	RQLCIenhGgmdkbCTcKRVPe2WNjtYmgCk=
X-Gm-Gg: ASbGncsH1JRIMqyc/qCiWGaN2wvNPn5oTNWd7pR02qyy1u74cKkGcRErFqT0nnRg02Z
	2etn/YCzm9phedGnP2oZX1zf0304LwE2V7FGnnsEq9odkpVws8sHzdMy426nhCZMpOPX5TIkSvI
	RMUew/CqgPC6P4OogyQ5J1MnkyR4Bx5/QKtDULExZ5Qw==
X-Google-Smtp-Source: AGHT+IEfPwOQQW3BYE3BbET2rMawKMlJdtkVUQC6mHkl795b/83dj9ucpxE8YPdhun56cwNQV3GZRCl8O6dhcwJxOwM=
X-Received: by 2002:a17:907:3f10:b0:ade:3015:534e with SMTP id
 a640c23a62f3a-adfad39c71emr510352566b.14.1749994132726; Sun, 15 Jun 2025
 06:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613055051.1873-1-lirongqing@baidu.com>
In-Reply-To: <20250613055051.1873-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 15 Jun 2025 09:28:40 -0400
X-Gm-Features: AX0GCFvWiMT6P3Ve9qL9VUU1ghgL0MnzvSUQp9Ds_FjN69brmotJ2fLC6Yboi7U
Message-ID: <CAJSP0QWrqb9m0jY00xvxz+Mfsi+UtE-D_Q5TE45RCKbS_ZkgZg@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:51=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Since clear_bit is an atomic operation, the spinlock is redundant and
> can be removed, reducing lock contention is good for performance.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  fs/fuse/virtio_fs.c | 2 --
>  1 file changed, 2 deletions(-)

The spin lock originally protected req->list, so the lock has no use here.

The initial req->list access is still protected by fpq->lock in
virtio_fs_requests_done_work():
  while ((req =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
      spin_lock(&fpq->lock);
      list_move_tail(&req->list, &reqs);
      spin_unlock(&fpq->lock);
  }

Looks safe, but please see the kernel test robot email about an unused
variable warning.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8f2e2f3..de34179 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -791,9 +791,7 @@ static void virtio_fs_request_complete(struct fuse_re=
q *req,
>                 }
>         }
>
> -       spin_lock(&fpq->lock);
>         clear_bit(FR_SENT, &req->flags);
> -       spin_unlock(&fpq->lock);
>
>         fuse_request_end(req);
>         spin_lock(&fsvq->lock);
> --
> 2.9.4
>
>

