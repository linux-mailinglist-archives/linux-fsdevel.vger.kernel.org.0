Return-Path: <linux-fsdevel+bounces-26700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED5295B1FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AE81F21A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DBA187875;
	Thu, 22 Aug 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dEw5xY+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD0187874
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319601; cv=none; b=CWyglJpTsM/X5NDj6Ehtn8Q+pVc7jYr/qseb46zlRtHXL/lOdKYOqVVbCbV+HzLbQsZG3A8sWlguYPkeMOP2oANXrUwDKb9D6SopLeXgBTkVICoJxKGQ3R/GXMYvwbo0pJqjjuaZ2BlE07aLZaI1JSfnhqFsHEakckRyl0Pfr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319601; c=relaxed/simple;
	bh=RhFz+Z3jpnxzYaSzDOAVvmJjK2SCsbAP2VQNVckmDUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVfT6okyFmLe8tCr+uZ+FG/DnaIURNjsJF9TFcDUHdCRTmmGMb/XqlL9nBT2SleDo6NmVRvuhaLDOoUgo4/97WbXcvBHMfr0ndHgfI20fWNe3Lhz3VvXzjsaMSuX9CMJuL1puJ85SxNJWWMwdftqUaOgIEtM3Y0t3KVCEMGMI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dEw5xY+M; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a843bef98so71911666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724319598; x=1724924398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3J76NjLOb4JrXPKvUTSl+xn61TpvQ/dAS4Pfke9ck0I=;
        b=dEw5xY+Mwqh0WT1v57JOKCoQv/GCoVDXvaHSh3SqbPgVBfx1W6NR+2GPV0hnA53mKr
         H7+hQCxTNwMJDyqGhsChn9ZhWTEQUxRuRBoM9W3R/P2KjtI4HMwHBIV0SB9o8eiM4IVe
         asB4P/D+hKFJ9k/tjtggqQTrAziD0arcOIgdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319598; x=1724924398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3J76NjLOb4JrXPKvUTSl+xn61TpvQ/dAS4Pfke9ck0I=;
        b=IIKZGWRlov+aqsOWcXD1TgzbHy0M1MgPgep5aR4vvZI4cUTtFAHSEV4dXu+mwO+bIr
         XOn/hRI8CLZX6jJpgvEz/RCG0BKj4mWZMKXiX6sieZkPCu5H7yxMv2Fc6W0s7MvEGy5D
         vdeemVx5rDRT0ApPjbdCfHMrf0AAx9NRaLu7pRX0twid9f0B0ic8Px4qgplQaNaSkYMi
         nTQid49jsAKkbv1Zd+IQP+GX30PkCd3NPNB+bRoWN8HMGSsmtNOI2t+dtHllfOACdqc4
         GaarzX1IYVm+gItmsPEEdKovmkAaF/w/RH9FzeH10NTu6E95VkiR2FldMxvYowdEUT7L
         Dd/g==
X-Gm-Message-State: AOJu0YzZQB2sblv5QhTOytkHW5qQhLNgZLmtcLmEslgrQ6//kMvv3grs
	IOtBMmOKepIzS9eDorkDKjlUqfiBs2J4sSQnWQi0Yn3aR/0upBogypZUIUrHAGy7j/GJUTQG1p8
	i/p03G0AA3z1ZQDJTqvzpNUqxX82G/CTHYa46yg==
X-Google-Smtp-Source: AGHT+IGKhBe49vLtSwlDkYUu7GdcBQlsOQQjhhxR/BNQ4l9YUrpx6GOfPuniCpykUAtCtewGEfHZLVAIwjLUXZHB24Q=
X-Received: by 2002:a17:907:2da9:b0:a86:8ec7:11b2 with SMTP id
 a640c23a62f3a-a8691cbab9cmr99230866b.59.1724319597616; Thu, 22 Aug 2024
 02:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821232241.3573997-1-joannelkoong@gmail.com> <20240821232241.3573997-6-joannelkoong@gmail.com>
In-Reply-To: <20240821232241.3573997-6-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 11:39:45 +0200
Message-ID: <CAJfpegtWqJZTum-v4tP0inZ0tU5fV1C9xsKkHfiniKKW-ZuU3g@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] fuse: move initialization of fuse_file to
 fuse_writepages() instead of in callback
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 01:25, Joanne Koong <joannelkoong@gmail.com> wrote:

> @@ -2361,21 +2355,25 @@ static int fuse_writepages(struct address_space *mapping,
>
>         data.inode = inode;
>         data.wpa = NULL;
> -       data.ff = NULL;
> +       data.ff = fuse_write_file_get(fi);
> +       if (!data.ff)
> +               return -EIO;
>
>         data.orig_pages = kcalloc(fc->max_pages,
>                                   sizeof(struct page *),
>                                   GFP_NOFS);
> -       if (!data.orig_pages)
> +       if (!data.orig_pages) {
> +               fuse_file_put(data.ff, false);

I'd prefer a cleanup label at the end of the function.

Thanks,
Miklos

