Return-Path: <linux-fsdevel+bounces-29189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A91976E9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 18:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939DD286331
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C878F15250F;
	Thu, 12 Sep 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a92Fn/1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD53126C0E;
	Thu, 12 Sep 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158259; cv=none; b=Qyd+GnhvbN+Vk5UKzzpnXYmFQS3ELAJVj8SchT4bhMCWVcl7pMFP5Msu4crZllVBKUGGz6XtZbdpnrE27YGgQwyCQtSJ8jHcRNVy+cz2ilE4UBuX3N3FYbhwHFiR5Mcjm6OKtak2i3gXd1Lszrvqa25cNbT8Zb768he2BSYZy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158259; c=relaxed/simple;
	bh=f9mJ/Uh32dDaHr2+VRWvs2+Fg/4sZPPfeCbiu9X1MsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHSZu9/rUHv+XWIzleRMbojJYEdZM6AachhPeae2fcklFzdz3fVJ7EpjKYvAEiqYvA6XE7Ubf1a6LoyHfTv9y+25hUqjKV9MsGPcOcI89+7FdKxQlXrZF1m1rmmm3m+3QiGZ5+P33axnJDbcNJ+MULlrDa+n5FxcL4ZQuxj34hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a92Fn/1f; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so1390421e87.3;
        Thu, 12 Sep 2024 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726158256; x=1726763056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiLlf1hoInqPJk8sDtJDxagapQpk3Yj07i/CZovnACY=;
        b=a92Fn/1fg5loSa2ArrMkWm88sEw1ccZ/Rotmld/XfApG86J/FWj9aAEeLbQaG7XFQp
         nJvA4mpRGL8AQ8o5KDJdgH1WjtzDK+b6q/8bYnS+OE/yaeQOHwMbtZoKQmACm5mva4Bp
         qevq0DZ5prqPa+uXz8VLvw3vZF4c9ZZkqTW0He15qPxnQtaYN8+LFEghKJp2+aV/W3F2
         1gw6qy2rXnLt2lC3Iw0r/DjIQt7fYgCI/th0oQPhdiIW6/kevCU/pBFU+NoT5ynrmktZ
         99R9m1Lx5eOyOCEHzAhSSTzyuaSM38wZCaQ7NPcfm6gxnQUFk3M22JsjFng/xZDouDvu
         H+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158256; x=1726763056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiLlf1hoInqPJk8sDtJDxagapQpk3Yj07i/CZovnACY=;
        b=Z5ICKTZJTAt3E/9WYdJI5fyHP4h1+yX9UB3MjrefaphE984lp2XLkTNT2ocstaRiOw
         evDzX06t3BNFDEO93/LUd6HmPBHDmRzxcyfd3zSgq6v1Sc2Sv6mRTpHeUeUgWQzFCtH5
         BGl4glA0N+vZeOwqNgE8qbWC8okNyw1xGcm8fpVefHZXZFrm/4rCdjmo86DbLdo1vx+Y
         fGdRr9FQ3sgizE9YNbqQkfOpG1qOlug4D6z0/IULQDj48iG7/CIGzmzlku1308Hr54z4
         T02H0TDEda+KYCh1nSE6IJ3Y/BrO3sSI6HQSLBiAqgDRfOGAqFil4z/fJbN0e80u3bqJ
         DucQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3q+it2F+fCmU8ATkuriZTlh6vgXkWlYDL5eyxh0UQ1XoLWE6mdGn69tyHGoqA9aeEhLU4RSpV2eo9+e0u@vger.kernel.org, AJvYcCXZIz5RWqubmq28AUxLxE8rEl3J4amC7X0CG4Pg61DTlLS6gV38DXLedWvq7hOIHuzm4Uhgd2WUUIqe@vger.kernel.org, AJvYcCXv23ksT0b5ALQjfjsXA050/Ycdad0MAGukIThkRqtbF7DsLAiBimpUZ/l4+HDjWY+HYm9f1YKBD8mRUusIAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7024fHv9HfaqKOan/DlPsHy8tAvc2IybkEYsbBzPJkzTRU5S
	AO1AAKpMCjOW0n65KaTeQNx/qzLNZWgr+pJI6nWqB7Fg03ot0CdXxC3u+BkZyp9NRWXZgQqHbHO
	dL30gE3ZrsgoOJHbcB2gQIS7nPX0=
X-Google-Smtp-Source: AGHT+IGwfOIECbj79V7s6bnAokjRAAFfqr5874TYEO+eZnkwoXU/hqGJa2R0ILSir04h0qjaOEQ1oi/4B403MYYQLeE=
X-Received: by 2002:a05:6512:3e1a:b0:536:56d6:ea4f with SMTP id
 2adb3069b0e04-53678fceb9emr2478050e87.29.1726158255481; Thu, 12 Sep 2024
 09:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1197027.1726156728@warthog.procyon.org.uk>
In-Reply-To: <1197027.1726156728@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Thu, 12 Sep 2024 11:24:03 -0500
Message-ID: <CAH2r5ms+7qDhOkxf=ti4Lifh1Tm0k2ipy8_rXaHhL7ygEqXvsw@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix signature miscalculation
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

looks like this fixes the problem - merged into cifs-2.6.git for-next

On Thu, Sep 12, 2024 at 10:59=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
>
> Fix the calculation of packet signatures by adding the offset into a page
> in the read or write data payload when hashing the pages from it.
>
> Fixes: 39bc58203f04 ("cifs: Add a function to Hash the contents of an ite=
rator")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifsencrypt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
> index 6322f0f68a17..b0473c2567fe 100644
> --- a/fs/smb/client/cifsencrypt.c
> +++ b/fs/smb/client/cifsencrypt.c
> @@ -129,7 +129,7 @@ static ssize_t cifs_shash_xarray(const struct iov_ite=
r *iter, ssize_t maxsize,
>                         for (j =3D foffset / PAGE_SIZE; j < npages; j++) =
{
>                                 len =3D min_t(size_t, maxsize, PAGE_SIZE =
- offset);
>                                 p =3D kmap_local_page(folio_page(folio, j=
));
> -                               ret =3D crypto_shash_update(shash, p, len=
);
> +                               ret =3D crypto_shash_update(shash, p + of=
fset, len);
>                                 kunmap_local(p);
>                                 if (ret < 0)
>                                         return ret;
>
>


--=20
Thanks,

Steve

