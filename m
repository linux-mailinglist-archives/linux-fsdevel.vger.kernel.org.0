Return-Path: <linux-fsdevel+bounces-13898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD18753FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF201F23B0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A412F5A7;
	Thu,  7 Mar 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HBlENkZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC8212EBF6
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828030; cv=none; b=qtvNwW1SQLxBkMuxgd2z8CwdlsrJKerGfX4JN+4xj95rRsnlKQr82ZUQywsQx64WJA8yrNWhOfh2ZY69ixLoWtSoDCasOyXc5weIbbMXSIIz9V5EdoMZdtSAPuynaF+WmjboP3/SfLR+BW3WUHiYhlaznFVhot0I0ezqbHhNLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828030; c=relaxed/simple;
	bh=i0U24/urDM3ZStm8ZkCHIYCnC1hztYjfNpKOAHUwB5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AujP4D/xv5625zBQRgcwTortKTP+Lsh/LGu2H4vt7ynGR4ULh8BrhXwDuuCB/0sSuIu2tODmSho854gJj8fvVskoQ/Kuu23lptUq1oi/ftP3Y5sVIPk3jg69UvKe5iZkaKasE/HfHgNiN3We0YE3mGusbpGTIJnaGTYF7mAeggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HBlENkZv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so148863566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709828027; x=1710432827; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0U24/urDM3ZStm8ZkCHIYCnC1hztYjfNpKOAHUwB5o=;
        b=HBlENkZvuZMko93KWDs3qXNVESLeeYLQdqfafMaCTE/0a+2/RWu3goeni1mbPHTl1Y
         JubgKNHkqDCJaP9kJMvzpMFg5GMh9Lzb5T8Yep3TAaQHM7zq7iX5Ks4UBr3Ud2Fyr30v
         wTXoGX59BLiDJPklUTL8f19yO4OQL9FjJ6aKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828027; x=1710432827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0U24/urDM3ZStm8ZkCHIYCnC1hztYjfNpKOAHUwB5o=;
        b=kOHetPDkL+4PP5tNzsiXsUJ+MhtYo2epagrAyytx+KZH60pBg6UAFJOVbsxrS6gAni
         mh5XjqikBMEzL5YCXG3au4FsJ0TBooMPmi3092yu1BVy1KklSw1+FpCm2PfoUbtt5aBt
         yXqg7jDndfxuyhTwLzI72ZSwxz8tUfxP2N4oXaIL7pDB9Pq6EPjuJenzIDxXWkfcL185
         3vnvAVNZ3YELwCtml2aGs2iu73wV+tV6ephwbofAcMEbpnpl58RH3WGIL2AYeoYsSurN
         4SLCm0VvOQdYb5WWcIoDKo0zAWZXhckbY8iw55O7A+k+knug22XdvLZdlEocC04WO8Of
         eH+A==
X-Forwarded-Encrypted: i=1; AJvYcCU/QSsN9D7ZBTFnLd70mAxBQ+8WjTzUlOLFaq2aW7BidPhaVIwuW025O7QGsNnkLasEMtcQdprWaB4qYh4FV1F7q/Lgb1fdR1+XuoIyPg==
X-Gm-Message-State: AOJu0YwYQ4mAAL2Ud05UM5c/sbCux/QRJhQURDyXC43BHTq1zoGjEznw
	EZqz1++asVnf3QgdSmW6t2zGZab1zspy4oZ4ecAeUGTiZjrMB2A9xqMmR9vzBCKoUeI5vp0v8mM
	Yv5os/malyKzDDlxSJVgD70dDXvs2IgmTt7By7w==
X-Google-Smtp-Source: AGHT+IHk/9+/evK2ilREFWV6zHusdSb+zwWTXNf21peTvmXuM5pPqvESUAKu6ZWeHfE2GiSv/7MakcpK2jorozDiHlo=
X-Received: by 2002:a17:906:2417:b0:a45:ad5d:98ac with SMTP id
 z23-20020a170906241700b00a45ad5d98acmr5201835eja.44.1709828027330; Thu, 07
 Mar 2024 08:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307110217.203064-1-mszeredi@redhat.com> <20240307110217.203064-3-mszeredi@redhat.com>
 <CAOQ4uxh9sKB0XyKwzDt74MtaVcBGbZhVJMLZ3fyDTY-TUQo7VA@mail.gmail.com> <CAJfpegsQrwuG7Cm=1WaMChUg_ZtBE9eK-jK1m_69THZEG3JkBQ@mail.gmail.com>
In-Reply-To: <CAJfpegsQrwuG7Cm=1WaMChUg_ZtBE9eK-jK1m_69THZEG3JkBQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 7 Mar 2024 17:13:35 +0100
Message-ID: <CAJfpegv8RyP_FaCWGZPkhQoEV2_WcM0_z5gwb=mVELNcExY5zQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: only lock readdir for accessing the cache
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 15:09, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 7 Mar 2024 at 14:11, Amir Goldstein <amir73il@gmail.com> wrote:

> > P.S. A guard for ovl_inode_lock() would have been useful in this patch set,
> > but it's up to you if you want to define one and use it.

I like the concept of guards, though documentation and examples are
lacking and the API is not trivial to understand at first sight.

For overlayfs I'd start with ovl_override_creds(), since that is used
much more extensively than ovl_inode_lock().

Thanks,
Miklos

