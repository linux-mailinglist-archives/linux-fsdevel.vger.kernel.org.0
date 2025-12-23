Return-Path: <linux-fsdevel+bounces-71999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D8CDAC7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04C8530115C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBA030DED8;
	Tue, 23 Dec 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIUJilDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B4262808
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530699; cv=none; b=EwxNMpZfgsDxEopOwpMMuhTzF4ppGfoffI2wSYPwcOS9pNoKG9AQAbAMDVQ8O1SxuT9Q+X08qXlVlhwkSQemsoMAy++IzZKX7a4DT7chAULMgX6dxXy81p9+QIEbg+Dj110pPFeSNfWc1v/GZ0S088xhw0+bdmUxDJzxWmzrxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530699; c=relaxed/simple;
	bh=kQzF/8oECQMk4FieDLGQEeBzx1LqEWQwLBvksnNprvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNp/WKyxaIWJaQOKfprxz5fJ6mdQ4qiN3RqI7BOPlfY0blJbeifFqrYkXyDDei10PXefSIvvgmJHo2nvYO+8Xu1oNR5wjl4HUUvg2PzaotflP9lpMEmloUTvMnAP7AMZLDyEVHMZ4G8qRoEuVL+KUgcX1jHYN6iR7WuSPOV5TGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIUJilDt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda057f3c0so58685431cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 14:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766530697; x=1767135497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvHmmPBhOs/SNu+ABYNBzz6sMmiPEYo06bBcvBpbjbk=;
        b=QIUJilDtndvytBmfNIwosn2Zf3N3crRwqZehO/SsH97JxuUwk7TxL15iVtCj5HXZf3
         BLPDZw8mOj4b1bfgOrGymZrZ2V6cSduKghauZ9mcSdGC04Fioaz/+DeNZMs6e2Z5MsMm
         L4gP65/CUoGrLNdr1QA756ZNsjE4Je/60p9UIuBywl20j4Tv6RTjp0uHj78NLb57LIOG
         2M4gxAlemiFxVzm/SWIwqa8uw1USFdyjYwo0zwppeQRRenih1pgT5wN6rZmIonjsTXmQ
         sPJwVvZhPT5o6nREhqXyGe4xyBCnqEBwmKjhn+YUSvKdr5D4uWZwE6WdxPwTKFI+PnZQ
         /tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766530697; x=1767135497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvHmmPBhOs/SNu+ABYNBzz6sMmiPEYo06bBcvBpbjbk=;
        b=f3ga0nXR2dvhKnjhDD+6HfCTs+zDCv96YeTkkcsR3mPM68yOdho9/vV1i4Vx05CJb7
         bSMTrB3sijNadTQHe7UB8QJdzLkiNIq5U7Ui2KvtLop6VfQo7dVAMiqqelneSMX4Rye2
         zRzW3lovn4LO/zdFTRRFoOru7orGBAUrDqE5Y6zIQSpK7JajCvR4za1hOWcnyu+Tq7jR
         cQO7cA/QPFgzcR0iSlt/fJu0gDF71UbwkVtfTCDNmazRu1VUnnipmfgaaKrcUjGrKe8l
         QiQb9kh97ZbnUWUfH0yHLip9RY3/BUEOOruacW02JcZn0qIopoVdbGG1IghJgXfWGJMw
         9VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0bjl3gQHicvR/3jmOBCUojPvWtjxMgKdi676pZeewAMWVcwWyvwLyDafc/hBHwpTDx+kPRWF89zmuV1P8@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPLSC5DU2+BpaGAJnAjbSEgQs3AIOlv545X+T+/P6sFNSQL5R
	aWsVlLAQ5gRtxAcmeqe6e3lE9SMHM2lhvIepyGujd1SF5Ftds3Ie/eNj/sDNUxKHbK6b2QdTVZw
	E3G/kfxGpSqYcZK172lTnZHAiVrCChE8=
X-Gm-Gg: AY/fxX6+8gn0In/QWETz+S31PAYq2VZg7usg0KFD9zNWOribY2f172LpWtbVtf8vo/S
	OZ9a3vFlCh18H2Q6cbnahUyJl3RAfaL5REkO+50tqpXW+P2z7nWz/TAzBdhv9n0ICpOSLTesyZH
	Xx9878fULjoSAhyiOXaxYk0vDMk5GUAr46oCTaoGoZYxdb7b93EiWYs8v9z7yC4hbeVVcgSjsJE
	xnn8NRRG72MwQGf7ihlk16x1hUI/5mZbBYH3XGmz1NjlzKljAxcJ+rP0BYwzMr84PiNTA==
X-Google-Smtp-Source: AGHT+IH7XTIbLJqd1yinGm8aDcQ/n7qsG0pK/wbvh2xP66gcvywwBFaHI/q6Fs6fh+kNMhSENVLZtJjnjlqnl8Ga6UE=
X-Received: by 2002:a05:622a:1f13:b0:4ed:af7b:69cf with SMTP id
 d75a77b69052e-4f4abd103f5mr271953021cf.37.1766530696847; Tue, 23 Dec 2025
 14:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223215442.720828-1-arnd@kernel.org>
In-Reply-To: <20251223215442.720828-1-arnd@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Dec 2025 14:58:06 -0800
X-Gm-Features: AQt7F2oPY308TljMnt5Vjs47zwMBfZ3Ih74mXxk59hmrQePgs-V-kucDDqUoX3c
Message-ID: <CAJnrk1bW+OoiZSFOzO8VAtHjS_Us=-AtuBSZZCvnrdvqK-qqfw@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: fix max() of incompatible types
To: Arnd Bergmann <arnd@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Darrick J. Wong" <djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 1:54=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The 'max()' value of a 'long long' and an 'unsigned int' is problematic
> if the former is negative:
>
> In function 'fuse_wr_pages',
>     inlined from 'fuse_perform_write' at fs/fuse/file.c:1347:27:
> include/linux/compiler_types.h:652:45: error: call to '__compiletime_asse=
rt_390' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >=
> 12) + 1, max_pages) signedness error
>   652 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |                                             ^
>
> Use a temporary variable to make it clearer what is going on here.
>
> Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

I believe there was a patch sent last week [1] by David that addresses
this as well.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20251216141647.13911-1-david.laig=
ht.linux@gmail.com/

> ---
>  fs/fuse/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 4f71eb5a9bac..d3dec67d73fc 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1323,8 +1323,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_i=
o_args *ia,
>  static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
>                                      unsigned int max_pages)
>  {
> -       return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) =
+ 1,
> -                  max_pages);
> +       unsigned int pages =3D ((pos + len - 1) >> PAGE_SHIFT) -
> +                            (pos >> PAGE_SHIFT) + 1;
> +
> +       return min(pages, max_pages);
>  }
>
>  static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *i=
i)
> --
> 2.39.5
>

