Return-Path: <linux-fsdevel+bounces-28001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7122965CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A51F1F2485D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA3117A931;
	Fri, 30 Aug 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="esw2zVbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260B175D34
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010203; cv=none; b=mfPqTiSdoQrGd9yob0T2+DX5SU0fETHkpHLKpLLjZu5jVg6GL7zg7nUSrNKbzw7GcnAlv2wIMpwFIKNcnlHgcRmPeCmP79Qrl52C2P26oz6hkJiZPs1xJFIdl30dO9nGIynu96ajCS/a8HbSU66H4bsqv45lOh33i4Tui2bUDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010203; c=relaxed/simple;
	bh=gok4qIrvd8eZ/lG1tSzczlS1npoo3BXRdtP0ko1TibQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acODZ2VDpBXvV4I0c0hWzUqGwA3yaZlHdxy0UO4REgoR+nv8OtlTleyYgGDMVkOpprSLfpsaw+yNDrNfdWR7dkGM5+5OGkhzLOCi0puZ3R6WdBkFCTE6xlzxTeQNGH2PW9NFKROhhx+8bZUhEOOnkKOh7Ha89XET0qbXWNc345Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=esw2zVbz; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e1a2264e907so1655273276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725010199; x=1725614999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/O5tyTZ8QanHZlKQ8JnQz0hbXvqfng0bQvJeFbqyrQ=;
        b=esw2zVbz2OdxjZyao6edtBCHKf++0d3N8S71w/zdyquQ+olfAufZNHSsT/z64YIbDG
         QZr7/P6L816rghsOeS4kz7H/txw5h4AiWvnCEWPylVYVJU1XfYHS3CZ27vq2b4Cn+u8N
         UpFUjNxM0yUPjWyXsXAdBRplpuhETckvMAe00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010199; x=1725614999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/O5tyTZ8QanHZlKQ8JnQz0hbXvqfng0bQvJeFbqyrQ=;
        b=ZTPN9III/ARuUYeSyQJuJIid5XJ2JUeA+NYghbsoOrDWl0RXh26FVIlBP9xXhYQxWd
         UWiZ9xZX+0mDDmcNlfSrtZbh0TOZcuTCGBTrdm/iuo7MSEo5D6OLv6p36ZQgmgCw4IqS
         6jFwEbr6slxUKbc2a5X0YPh/CdMUopuyerrqnhh304yD/YYPrGtPwo28+DqzuzlU1r9s
         0n4ELJaE6OFYGOr3Cv+V79PBVD0/FJ1AwK+vV1gyTCtbTJBrMVueqovyWbmd9xvKynf2
         ROcFCEjsY3aTSfRjjTw1UZFrBWpzET5EAS8pjZnPrJaR+7k2m168cKiY7qMfcQ9NQ5IY
         esVQ==
X-Gm-Message-State: AOJu0YxBWnVkLfuWIxY/MEFPmcI+l1tnW2fzf13yglk+ZFJ3v+ONwtL4
	URtI/A/o3OYRFrLc8s7zHNUGsFvXWtOX+YC+lblLwamTqJpXVLtRRSkCsQ3eq/84be7AxkCOqBp
	XFyJw1xITPRwW5GU1UHQzbuOKEKaei8gaiXIfNBzQ/cKlNYVX0YA=
X-Google-Smtp-Source: AGHT+IHANSr1rO4Ht3P1FD0JTFCc+u2PUhAGPaFwhdoDevBLpxTuliEN4c4TzJGk2KcYX302MtwVf1BGDGmhcuLtNn4=
X-Received: by 2002:a05:6902:2309:b0:e13:83fd:cf01 with SMTP id
 3f1490d57ef6-e1a7a1d1dc1mr1683623276.49.1725010199518; Fri, 30 Aug 2024
 02:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827091920.80449-1-shenlichuan@vivo.com>
In-Reply-To: <20240827091920.80449-1-shenlichuan@vivo.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Aug 2024 11:29:47 +0200
Message-ID: <CAJfpeguHFqZF=R=WH2zuECDWHRDD3bYtZGaSrYV-Am0zopbShw@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use min() macro
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 11:19, Shen Lichuan <shenlichuan@vivo.com> wrote:
>
> Use the min() macro to simplify the function and improve
> its readability.
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8ead93e775f4..aedeaa6014a6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -977,7 +977,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
>                         return;
>         } else {
>                 res = fuse_simple_request(fm, &ap->args);
> -               err = res < 0 ? res : 0;
> +               err = min(res, 0);


I find it more readable the way it is, because it's not a mathematical
minimum, rather a "if error, return error, otherwise return zero".

Thanks,
Miklos

