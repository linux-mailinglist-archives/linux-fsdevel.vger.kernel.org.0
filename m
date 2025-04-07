Return-Path: <linux-fsdevel+bounces-45886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDBA7E1E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560DF44076E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9FA1F63DD;
	Mon,  7 Apr 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HekbsPYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DA1F7911
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035888; cv=none; b=lT7yhdKniYtN29LuVL29LWvnqIof4d5LsNEabMe7aUt4eptumE0RlA+SsTm8GXeonqvzHw/kz3sQ2/napYVkhvTisNNwIxyRiET9xyQordPUoEp/XE0NJWG1zfrUHhYep+z3704OM22+oQh59K9FUneDyVE50VkfxEBPOv/4mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035888; c=relaxed/simple;
	bh=FNL+NAWFI0GxoBJ167yJeoBFSWA7FvYgScloIAzLUeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFGRb2pyikfA/B1ZG5bHuK3EuDLv9R4Bpm1Acyq8GuJ4rd45dldjlJf8jr8dQDfcbZCPq6FynBaQuCKgnc5huyfIhZVvdDivspMFbzbCk4t2jdu9ughPpxmzOoa+X4lBUuFfpuFrrrNoXiXW3nLM28+gRZ6rc0excTZPbCA08zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HekbsPYU; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4766631a6a4so44284211cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Apr 2025 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744035884; x=1744640684; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNL+NAWFI0GxoBJ167yJeoBFSWA7FvYgScloIAzLUeo=;
        b=HekbsPYUXk7zhTOruFnRnQckKhfaxTWzEjMmsaJBlgqabCZ6jjZ+LqGVA1xI/whr50
         LIx8t49SNes4OXnO8Nr0MCEy1a+9jhSQt/D1vYdIOKlHDUTcA0QOF8uLj6eKXxnWFsXl
         hSW+mdJEr0QcPCOm/WX4dHqoW581abar4frAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744035884; x=1744640684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNL+NAWFI0GxoBJ167yJeoBFSWA7FvYgScloIAzLUeo=;
        b=lGNQ7fUvrCn4NPQr8X5LWN1tS2WcYw+4f+1cd/C6r3uFXx8ztGhbgvWfa1jCkBFtpO
         0vS550Smiuoj+sCmpCAgKTM5UVoUfvHIhBiX0NuN/Vr+MxaHCdCj30Gj1n8hfK2KnQkL
         frw56JYQ/LtAJpWUTUxy1etyjM6eoTcMhieg1vgPKDFHQDxpgpOmY6TS0TNi+NFXnNaL
         1clw8coVsRPYAfl/2BQHHrElj+HWY4MZySdz+/9Dj/4nTggUtq5qe6PDqEb+weK9Z/jy
         ng8vLNOA44sTW5YxKoCgWzuYlP8hJQIbxae4cUQvVuPsYgspfGWqcDF5Zvzpq53SqMUn
         E+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEpXkQHHRf6koxq19y8PMpGlMrj97ra8a4WFGUjVDsEKUEXJZnYKnSvtiswO6NWLLv4kUGjQoTIJJNEWmp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9aNkQmloikj+taW9NUiN839wiRljYtqmyYbzbHIxXwnpZJWC
	yZlYOYkgsYSoi+ICJYnqAnEl+KTRwn3uengR5iauXBefX+vQrHNCHr4PFhCdQm4nkYEO1x39obA
	esKt1YHODuuQ+YU/94J0psFQbzvblT2ibemvSPQ==
X-Gm-Gg: ASbGnctK0khZRJgCuyb9qITZ+Sie4y6cTnVAKNZhUN1N7x6RoIlq4b0tFY/prdaiuzK
	trt4+K9PnGXw0S0eOe/crvjqyM4rYo8wRqNt7Ufj9lyWlI5GyPcNsd/j//tGRxvn7jlzGwrz1Si
	KqRG7sNUMwZSwyEC+/0ojuSp7iFVU=
X-Google-Smtp-Source: AGHT+IFQd4jHNyMbSuzJ059jvOO/iExVzCO/KphR667EKFZiLjHNp+k+91snAGwPCrKp9DxvzNZfuI0F/c1qQXQ410A=
X-Received: by 2002:a05:622a:199f:b0:472:bbb:1bab with SMTP id
 d75a77b69052e-47930fe7403mr104524641cf.24.1744035883851; Mon, 07 Apr 2025
 07:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
In-Reply-To: <20250407115111.25535-1-xiangsheng.hou@mediatek.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Apr 2025 16:24:32 +0200
X-Gm-Features: ATxdqUEaLGT2M3QdvlukIOwAEuscXulm8_kXjOV6iVYrWf5p1vewCG0W1HdKGiE
Message-ID: <CAJfpegsN47xDbVFsu=-TLW+A2=-33fNY83zt5bhebFqH67LAVA@mail.gmail.com>
Subject: Re: [RESEND] virtiofs: add filesystem context source name check
To: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, eperezma@redhat.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	benliang.zhao@mediatek.com, bin.zhang@mediatek.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Apr 2025 at 13:51, Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
>
> In certain scenarios, for example, during fuzz testing, the source
> name may be NULL, which could lead to a kernel panic. Therefore, an
> extra check for the source name should be added.
>
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos

