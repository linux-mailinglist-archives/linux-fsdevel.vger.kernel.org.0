Return-Path: <linux-fsdevel+bounces-49222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBEFAB9948
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FF7167F98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECBA231839;
	Fri, 16 May 2025 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GWjPHHDh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1E21FF32
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388855; cv=none; b=h5M65KKvrbDHT4jyIMJ6nXh+6b1Iw8wfjmJz4S2HAdo1rmq/JNqPmkoJNIMBohHD376r335N66biPLpnX/pmx+xPXpQCgLzeTSQX8j8HQfx4jeO7yrs5wmgiHhBlMKsgF6c2utcR/SPhzkbolIc/EO0IlTOxA/0EcafwMVx5btI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388855; c=relaxed/simple;
	bh=VyNXlnIsyU7Pn2oQnvd6lafM5AHbo6YOW4yK1RDa+KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiVfEL9TkybRV0EJv2kJCezy0jXQCLIvzBHX/eOKUOTEaimPfbnpiRfQi8E6XUag/8Mpt28WsS+g3wgIJH3jInI2+CohfbyODsPqTN9qFFhMf9qt7bU+i0J5ZZDGhyCSqM+Sh/novKxbfbNgrF7tt2xccmZ2t8rwYiipoeFZpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GWjPHHDh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so27777861cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747388852; x=1747993652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbUpl0d+T1S8svk4HaUwewA4jDm1R4jn3fO0arupCZw=;
        b=GWjPHHDh/erLx4SYdqt2i8Y8b2MW0GLov1rgu2Nxsh8anRLnfI3lWpB8jAhektHYhH
         WAAP5EOIxP9ZFEqUjYzKhOIaBIAt5tKpjet1HJYaMWyVEUXuKy7jvKKc68mZRF5IbATp
         IQOZvruFTlt+7OVUafalYzfPBFuR2K5aCVXtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747388852; x=1747993652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbUpl0d+T1S8svk4HaUwewA4jDm1R4jn3fO0arupCZw=;
        b=p1q9QscA73Q04u8vuiLs1RVEQb2gAMO0ybKU8fSJZm9z8A0iklNz6F8fbOP9qCgXXN
         TQddgqV7JOH+qb5/EEZ2kiWoGkE77yAyf1CN79v+fGipOfXkgUEbY902HZuvWa7dtSdB
         F7znEM2mtSBpC+pXJ8N0Wl+FyoFXKtJ1PZoTOyl5UE9CVqKoxSwWhNCET1az9hqdhkSm
         vCbblnH30gIO+FbGSY7VhHJjlnTuYsOuN4diZiWXSBw9SOYnY+81+DZ7I4EURkndsLjh
         tMvwId9fQyLFUwDbkgoFKe4XtcEBRb0abbTOXbKvBKyZVo8Hth+Oi/m6qpXvSEk8KdTj
         1g/w==
X-Forwarded-Encrypted: i=1; AJvYcCUdTDtiF66skDDxIMSdS+o9gxkmbhUXTOxpHBNRPIBbhWn7zio+Pntvlwle1d+7hYTW9rGGDWyJfwXxN/Y+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FDI4vCmkVilu9kUmLu+0E457smrmjy8rJXVNe+jVupj2mqYc
	q+qxgCBoDvJLZc2Shl+nF4+3FCvQK1NSHjnmfr9ZkphhHxsfCihqE8SrLhZOTBGJxASNDdqxhaf
	leNAEbS3E+jkoWQEDDFIS58/FbgvbNrBlAUvUF6BqZg==
X-Gm-Gg: ASbGncvFlhYLy2iDvsqkGYOufdQdltBGOazPk4s77a9p7OM5c29u6S+bcOCnR8ZrXP4
	I3sd8D3Z0g2DG5Az9s1730yKyUm+qZ2u9IFLuCkgmFYDwvCMDv87eSnrTReuqrY42wAJDTzNviU
	XGLz1M8UEsF98nzXrQ1jkpzWMr7xjbTQA=
X-Google-Smtp-Source: AGHT+IEucT6+ocAS5iJ7NiE7vtGjsFd0UQMdSdNntZTlhGEHhSvLihGLewHZNCc/bWcl8zL00O1TmswSpOV0shrgy9g=
X-Received: by 2002:a05:622a:22a9:b0:476:923a:f1cb with SMTP id
 d75a77b69052e-494ae4600damr48413131cf.41.1747388852725; Fri, 16 May 2025
 02:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com> <aCPhbVxmfmBjC8Jh@casper.infradead.org>
 <CAJfpegtrBHea1j3uzwgwk3etvhqYRHxW7bmp+t-aVQ0W8+D2VQ@mail.gmail.com> <CAJnrk1aVcT5ZWT-KgrThQ4jxnd0=AvTggvE0CbaMG+9zOFxfZA@mail.gmail.com>
In-Reply-To: <CAJnrk1aVcT5ZWT-KgrThQ4jxnd0=AvTggvE0CbaMG+9zOFxfZA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 May 2025 11:47:22 +0200
X-Gm-Features: AX0GCFvzRTYik5sj930jz_MkmeC6KoPEAvpN4y7T3LfKSC60cuF-q6XGe3VjyYg
Message-ID: <CAJfpegsiSEfs-i-uZ-RJu7ZaQ0+HWvbTDonzBJHgGP8YuB_e1w@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jlayton@kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 19:54, Joanne Koong <joannelkoong@gmail.com> wrote:

> I think this needs to be:
>
>                 if (folio) {
>                         void *mapaddr = kmap_local_folio(folio, offset);
>                         void *buf = mapaddr;
>                         unsigned copy = count;
>                         unsigned bytes_copied;
>
>                         if (folio_test_highmem(folio) && count >
> PAGE_SIZE - offset_in_page(offset))
>                                 copy = PAGE_SIZE - offset_in_page(offset);
>
>                         bytes_copied = fuse_copy_do(cs, &buf, &copy);
>                         kunmap_local(mapaddr);
>                         offset += bytes_copied;
>                         count -= bytes_copied;
>
> else it will only copy the first page of the highmem folio.

Right.  Fix applied.

Thanks,
Miklos

