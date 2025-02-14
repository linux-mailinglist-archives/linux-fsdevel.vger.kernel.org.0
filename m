Return-Path: <linux-fsdevel+bounces-41713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1447A35B55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E047716B2BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F13255E42;
	Fri, 14 Feb 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LWjv5omc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F042AAF
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528270; cv=none; b=iJ81v+VS8z49TwuetILMMUNNx6EoYo5tuLCPkwQc5F06hEvKFqrtv6tji7FKwKFrjW7En7GYkwkSCqGSL/DnAAWFLujwlVhBrpegN/zEeeR2f0CMXrGtJq18pWV+kiHj6j9/xCziVGG88n/sZaRHgdcjAEXIH6Lpn96MmRxnopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528270; c=relaxed/simple;
	bh=Gr6byYJ9M8CPC9sGIW1C7Afb2eDq+IKbUI4St6uD8kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJ1xVNdX9LByY7jZnHpZHrpX/lPDv37XH2y+IWa7DJZaaf3OnUIF0cGzBrdJaSwn7C+yFeicSlV497+G/MozXYAdIyoDAGckHYBd/OvQCKOZLAU8kdRsJz65XmsBf+bv3bFzLNiigBYwVPP9WZGuXgwYAh9qc/wk3scBpd9Z1LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LWjv5omc; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471963ae31bso20954861cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739528267; x=1740133067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3yD68siaD/I9UgRfvv+/Zcj4LmxGh3rVL8Upyuh46WM=;
        b=LWjv5omcJkf1sCni0F1Rfq5cBxi2paiaTUICH8/NzY37BfSH3avu10LVYnu1kiMGx2
         y6iC3dHfwO3twhTokQBELhqlIXxv+Ttjd3DCjKMt20MMGQfQrE7yF4BRHMrMdTEDK3SU
         E/PL8FL+TaCwLJeARp2xFHGnjZhQ2SQXoCIRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528267; x=1740133067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yD68siaD/I9UgRfvv+/Zcj4LmxGh3rVL8Upyuh46WM=;
        b=Gi9Ct5UY/sbyxIcAOlkbJrEO5CPZqHruY1Ym7zYmI669C9XGn6wV6dQoCq8jeXr1tO
         4Zfk2nLMhXf1XRawD7F4qfKDKjph2jvju3N//NFLytXIjDKUV+rPQMgs2siQu0XBE0PC
         LFbb1l4Fksr9a76o7IntI0h6QHyxPr4U+JdEN2TjQvyuNRyVI45sKfjtPxOC+I0WycVy
         RMZeDTTOUIt3aYgT9bLlgBEnOI2toTPQ45XUXVxBvT4ykWguhfRBHk0Siy2kZeAfE2ad
         brBudsXgjStjSrlrt3wWo2e2spxgWeEkF4g+LfLzuCb7jHORV9NGDSPgjUz7DVmFdI5v
         YbAQ==
X-Gm-Message-State: AOJu0YxCo1rI7IxOzBBwHjg0lzPTFQQEU6zYI1ZaQXy5H8LcgI+AKD4B
	jU9x45Aqt1GpeOW0hAOEgMs5p0JBDza03WdVYaxCSWeylH8T3XNhby6bxm6wfOMzjmjGkbHEvrF
	qV7ZMnNxhGDxTBh6/TCwkzSrN3Zp8VBd1B2bPRw==
X-Gm-Gg: ASbGncu5L5i6yPrl3UaGk3uk4lxx93mR8a8U3wqGC+SBE0l6P02HBjNN26CyCcrMAzn
	g5hW5qWeL7AJqJM33McdYJClRPpqcgTdNT1w/YR+DgD7mT2QCy9BSr+BsZXgQavUlz+cLqOo=
X-Google-Smtp-Source: AGHT+IG3mKwmLnvWbK44lR51bl7+ldcBa+nQug5GaveJDGSkAeqK8YsrvWrGfFD9Z44VTq+oRGlo0S30jmbiT6EXMdM=
X-Received: by 2002:ac8:5e4e:0:b0:471:ac69:eb8b with SMTP id
 d75a77b69052e-471bee89accmr96603261cf.51.1739528267456; Fri, 14 Feb 2025
 02:17:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
In-Reply-To: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Feb 2025 11:17:36 +0100
X-Gm-Features: AWEUYZkl5LMMKq4x27aNE4jBCskO4FurzwsUpNO4-oLw8724QP2Ofox5ftiFHmo
Message-ID: <CAJfpegsOOv7c3R5zQZWWvYEgZxyWGCJyf8z=A8swQQZsGyvuDQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: don't set file->private_data in fuse_conn_waiting_read
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 16:04, Jeff Layton <jlayton@kernel.org> wrote:
>
> I see no reason to set the private_data on the file to this value. Just
> grab the result of the atomic_read() and output it without setting
> private_data.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/fuse/control.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..17ef07cf0c38e44bd7eadb3450bd53a8acc5e885 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -49,18 +49,17 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
>  {
>         char tmp[32];
>         size_t size;
> +       int value;
>
>         if (!*ppos) {
> -               long value;
>                 struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
>                 if (!fc)
>                         return 0;
>
>                 value = atomic_read(&fc->num_waiting);
> -               file->private_data = (void *)value;
>                 fuse_conn_put(fc);
>         }

"value" is uninitialized if *ppos is non-zero.

I also wonder why this patch is an improvement (with the bug fixed)?

Thanks,
Mikos

