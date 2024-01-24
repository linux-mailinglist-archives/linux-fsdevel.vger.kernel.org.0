Return-Path: <linux-fsdevel+bounces-8748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE683A9A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B671F2A27C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D86312A;
	Wed, 24 Jan 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HPbVp9vo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE063113
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099021; cv=none; b=uQ1OxRTO0JnZKozL+I/Me2+z4o9/V9b6QD9iTzjBP1QGhjYKHlbvEPtJZ0jdFhoGyaGKc/pr+gUsIvb3i3MrX8yaeGGXzbX8hhal5WF4EJr40/UA8OuNWGCRlahb/C/THzqU6aLUrTBs1v5LisS+F5/ocY6J0fHXUpIFPRJi9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099021; c=relaxed/simple;
	bh=5dyjjztVeMEAxqjCQmekyTt/14O/JPnAAQEh7nAcAVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sS8GTq1sDsFf3ixBPTNO0zWNI+1Ibso49D4IHN0St920vvGrzNUQX9Zp2QGziw79wNrLsKmNYyfM2UJpsOvVAyzGYqwO5jvfbHixeZfS0DAeQoakd0LmpciC0B4mQPcwDQYHpsqrkiDUa6kKOmIl/9FEtyp1kCJk/QneU9dtPeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HPbVp9vo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4445781276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706099018; x=1706703818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VQJj2Pvltg34D1JxmSzpikuY5oxwe75zkMRd1oYgk90=;
        b=HPbVp9voPLIVmz4Dh8+TSPBRDQD7ZINL4QriqM9x//SldYvLHSwUZGNDXYvpNOyG3N
         H8pwNbNdkAj/nrSHPWVl+frSYBErma/Ylv/4PsbflcVoekL2iw5SnjQIPSFDUU9XfA9v
         oi/J5eTiBb//TYHqXK4ASHWue5/Fdsyc+XnVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099018; x=1706703818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQJj2Pvltg34D1JxmSzpikuY5oxwe75zkMRd1oYgk90=;
        b=aGobVF0kQmYf5Rp2x6xY5bQ0IJUGhyI5xSzl+nn+u9+c3+xg4L+ZA9j817T3uUfC29
         fQsPpB3bu0DttnKJ0oHI2cQdw+93N+ZcWixo7qH4K1oxYeAVMoqzkjZOVRywXSSLs0nA
         aEFcVkeRUt7X9GIlisnW8o4N8ZqmkM4pRQTK/nY5fZKwgvOHPIStdGH/pawWm5GD40zX
         SjlWqwiafTzYmZDk7lEzTcKYp2s5XT13F5P7dmPWyq/CzU+kvvrXhhDGhgXumQ00J+48
         IGDzLH4oWcfMvLmbGlHvLds6IKnY/hF2V1VAU154OkvMsCe6z8yUN22g6pKPNot3Lmfl
         YD/w==
X-Gm-Message-State: AOJu0YzNVeeHzgdtHGQug5v99pk19dDNlE83TEwNHqx68nslmIxNqAo5
	sawTEVk7v9Aw907y2B0lEyIjmlYEQnYY+UUZ5o4xFNlbj/cc/b0iTIo3Vj6HYER0wfNutZmmknp
	EqkCre4gQTz9rXQrAZ2NdP+X3q/Oz0klfgLkltvXHrqpJKqL0
X-Google-Smtp-Source: AGHT+IE8szCTPfpSzvW9b+xBq8pihCslPhQeZGAadtd5+Z8bxnNbMVcT6WiZGDSQH25QtDuVHNtDzXqw2dWrBjzIcdc=
X-Received: by 2002:a5b:10a:0:b0:dc2:1ffe:92b3 with SMTP id
 10-20020a5b010a000000b00dc21ffe92b3mr501479ybx.81.1706099018730; Wed, 24 Jan
 2024 04:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Jan 2024 13:23:26 +0100
Message-ID: <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangjiachen.jaycee@bytedance.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> From: Xu Ji <laoji.jx@alibaba-inc.com>
>
> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
> single request is increased.

The only worry is about where this memory is getting accounted to.
This needs to be thought through, since the we are increasing the
possible memory that an unprivileged user is allowed to pin.



>
> This optimizes the write performance especially when the optimal IO size
> of the backend store at the fuse daemon side is greater than the original
> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
> 4096 PAGE_SIZE).
>
> Be noted that this only increases the upper limit of the maximum request
> size, while the real maximum request size relies on the FUSE_INIT
> negotiation with the fuse daemon.
>
> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
> Bytedance floks seems to had increased the maximum request size to 8M
> and saw a ~20% performance boost.

The 20% is against the 256 pages, I guess.  It would be interesting to
see the how the number of pages per request affects performance and
why.

Thanks,
Miklos

