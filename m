Return-Path: <linux-fsdevel+bounces-37627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468C9F4B06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1B216E11C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C581D90AD;
	Tue, 17 Dec 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BOulncX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1341F130D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438924; cv=none; b=uCeW6nZg9a5jdf2D7Rwc/3+vtK8iVcgpv+vnR+sngqDvSKyO4TbaQARxP+O3o1YYSjA88alSvNsdPybLz86AQ10XxBy3sNgckpJcUR5saQpS1ixBxML7Yz5QyCA1Z+lZ0J4/7NgPkeqIE3wnu8jyLQLf+mdQlYttX35n6GD3ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438924; c=relaxed/simple;
	bh=imt9bBeNwylTSw2gSi9BpqSMhj/Gy9xxD1aQayahjCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haQ7DpmUTIC/UTV2Y+RDkYbKZyOu0licUSDqtMDRR6XFAhmExhaCaOtI9o0IqKRiZXHVkVl5cAtvIm2hfdp5yriFlbu4OKszvD46oqarX+tkbLW+8yXfN2HdNauTjWbOw4qYcF+dY5INi8x4OZyOq7oVQyO9LXraS3upW94hLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BOulncX+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so45591976d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734438920; x=1735043720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rDenadz4dGJTZLbTVld1SlFL1r9JcjdB0paJyJvOt44=;
        b=BOulncX+sWiTiAKVdFD1tenUZUUwjZz8GgpXX7zdkUsI9r6UuSWIFDwR3ceDQ6OmoJ
         URIrKm4mLRDi3tKqFIi2L6jfZw4i9nkHVw6y5r5A7aI36IhEMyRY4Shdm1bNna6IGGwA
         E5Z001YbE/9C4aYGVr2G4rA8aPyu/Dd+yT96U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438920; x=1735043720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDenadz4dGJTZLbTVld1SlFL1r9JcjdB0paJyJvOt44=;
        b=XEyiJ5Ky4iQ8MU1qVfa2hxjHf+o8vux70hfxXAkJ8CDgJadwmQorA4hgT4BmLwPqX+
         5xt/bVnuqaLTf4Mjv0YbuK0q6d13avJs21iGyN/wLX15vPgr2qmxxPv3q8mDTnJ4ySCf
         iqki5V0W/Bzk+LOdzocr4tDpGlj7QSIWM/a62CKwvTF6ue/rctJWhFb6DAEJMptO2F6M
         pn+R6ss7DKOBdw+KFJP7ErT3XbGmVdAXW0eI/Cuhy+cO2yScwkfuBtKNpltnPH/YDOBL
         eh4Obkrt1gqPRYRLq3W5DyEpKDthUJXwHu0myU+eE9PkRd+PQOgdnl1j9xBF7hnDrbpC
         xI7w==
X-Gm-Message-State: AOJu0YxtBh2pEfD48I3zZkbMlSxTiFgkSTmmWD70ZYKIxRoGKHmxNX7g
	XuJZkcahDSiENxVSTJdaxBNFW5SYsnj8zQKiUFbBiDA6ZO2R2Ny3FjV7UHTavhPcgBkWOa0B8RH
	gfFZdarLqdRiSf3fAAI5Rzw8zYp3cyYVmF0pn9Clo3RfNKJ4G
X-Gm-Gg: ASbGncup5m7/3e5wj1N6wv/RtGh0Pquz4HMO+TPeCYMFtkt1DrTmO8ZGRHiCWl64YJ8
	Qd8w9wdtOQRfui+AEPgyw9kUAC541gFBhI/i92jI=
X-Google-Smtp-Source: AGHT+IHN9CpreNQPXb+yElTVbdtmiekyKHlTVli9FOQfJWq7rQTXG4WM2GJE1+BW6AcMQqBA89V3sMZbJk1e/bS/xEY=
X-Received: by 2002:ad4:5f8a:0:b0:6d8:a48e:a027 with SMTP id
 6a1803df08f44-6dc8ca3c5d0mr320280446d6.2.1734438920531; Tue, 17 Dec 2024
 04:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217-erhielten-regung-44bb1604ca8f@brauner>
In-Reply-To: <20241217-erhielten-regung-44bb1604ca8f@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 17 Dec 2024 13:35:09 +0100
Message-ID: <CAJfpegsn+anx7nHQbD7HCf301DyvaWqg-pAi6FUAgfhGLiZurA@mail.gmail.com>
Subject: Re: [PATCH] fs: use xarray for old mount id
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 13:23, Christian Brauner <brauner@kernel.org> wrote:

> @@ -270,18 +270,19 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
>
>  static int mnt_alloc_id(struct mount *mnt)
>  {
> -       int res = ida_alloc(&mnt_id_ida, GFP_KERNEL);
> +       int res;
>
> -       if (res < 0)
> -               return res;
> -       mnt->mnt_id = res;
> -       mnt->mnt_id_unique = atomic64_inc_return(&mnt_id_ctr);
> +       xa_lock(&mnt_id_xa);
> +       res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, XA_LIMIT(1, INT_MAX), GFP_KERNEL);

This uses a different allocation strategy, right?  That would be a
user visible change, which is somewhat risky.

> +       if (!res)
> +               mnt->mnt_id_unique = ++mnt_id_ctr;
> +       xa_unlock(&mnt_id_xa);
>         return 0;

        return res;

Thanks,
Miklos

