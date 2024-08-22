Return-Path: <linux-fsdevel+bounces-26704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5E95B27E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C59D281C48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F7B17E46E;
	Thu, 22 Aug 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QTUdZay/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865D1CF8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320791; cv=none; b=MWWVlzQY4iKP7AZySo/wy4ELaAJkqKEjRUwPUzFjP55QmrgpRCKL54ow1CItoqM58BTg00euI/uQCxa2ZdqL007KfDPNQ250qIDtvsN4WSN3B40LZKy5PEb/yyWiiWERw9r7NiYeWKT4Dgu4XFCbru3pCNuTbcpFL1jloo7qRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320791; c=relaxed/simple;
	bh=QS1ZkpFR6WCbiv5Hh4Baraxy6WPn1Au6N2SxSNs/dgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5vvWpcMG5CEkVGohKPh3ADM63+0EHWBivMVxchotVY1avHM/LOp3IktCY5HEowp4aMDOr2idGAL4qsRLCrIk75e5FIC8Jx2dfspF3h2TpwrizLl4OGlueuYIfwxKIKLfV+07q+VhBLG6cKmwnki3oiaC0b1rokxev4zNBFHGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QTUdZay/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-690af536546so6472647b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724320789; x=1724925589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=did1meGQlcIlyg+tEIrzIaFeQaxhuWF0aq/dJD3DwZs=;
        b=QTUdZay/6/3/5W5V9tRAtnkkNp/srxDVz1XZ72Xbsq5dsz1ZM+qDFUGUaa7kCUrAlV
         ZMx6pCLQLNXHhN+mBpGTHbmCQxFpCUmq7SN6z8FCo/GWBvc4hElr4PjhI0ARmtwkEyg7
         Pyo3fsTvEuoYD8dbJyedPl8caPf8oty3FrtMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320789; x=1724925589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=did1meGQlcIlyg+tEIrzIaFeQaxhuWF0aq/dJD3DwZs=;
        b=sXhKKbowaw7ThVGRF1To+bmsCJGVeW9ZKKidpb0NRdepJwLmooh0bCiEDMd64LSzsT
         ckGE4LR8tLzZS+lLiZze+g+CowmPGSS+tl/hpsOifxfjRduA26PRfiXs4d0jngRc8VBh
         ky6SLTHQFXwWOSscskoNWKOWxmvU2n3YZBrQgWjHqRXteVb35wIqwdfKuostcFY9l6kb
         FXcmFh4a4xl8DvBamhRCQLdoYZO0Y/MNJIxTvAOoXN0/PNNJQFk3VCGsY8s6vkMbBrr0
         f3yv+tvDdvpS4BAMolRWjQ6IfTD4ms4nikIlrUtJJBMZ/w0321+d/FxtGDDbwMFXwn2m
         t2uw==
X-Gm-Message-State: AOJu0YyMqxoI7Akf0XrHlnCyptVBi9/X8+bq2t1oi8kqVkzn0qzl31t9
	c+e1q68RqnK321bfG6tSoWJzDjzn5CR7So5Nm+rIaP11FHs+N7zHqNnwKPzY+zJFASuzJcyXV6X
	nTDqrq0LaRFnmuRwETPIG5zWNp04z2JKw2NiXVA==
X-Google-Smtp-Source: AGHT+IE7DH0X/PfYqShJe7+vqHn5GNu0scBSSMPwOTtWbQYxnrD/c+mTSkKQXw+pR6WGj9KlRluBKbj1JQ3eCsinNhY=
X-Received: by 2002:a05:690c:2787:b0:650:1ee7:7689 with SMTP id
 00721157ae682-6c09fa8aec9mr47709327b3.35.1724320789058; Thu, 22 Aug 2024
 02:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821232241.3573997-1-joannelkoong@gmail.com> <20240821232241.3573997-10-joannelkoong@gmail.com>
In-Reply-To: <20240821232241.3573997-10-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 11:59:37 +0200
Message-ID: <CAJfpegtH+7-jGpQZUu56fCNhmRm34afG=snN-Sx8EqQB7zgJzQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] fuse: tidy up error paths in fuse_writepages_fill()
 and fuse_writepage_locked()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 01:25, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Tidy up the error paths in fuse_writepages_fill() and
> fuse_writepage_locked() to be easier to read / less cluttered.
>
> No functional changes added.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index fe8ae19587fb..0a3a92ef645d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2098,16 +2098,19 @@ static int fuse_writepage_locked(struct folio *folio)
>         struct fuse_args_pages *ap;
>         struct folio *tmp_folio;
>         struct fuse_file *ff;
> -       int error = -ENOMEM;
> +       int error;
>
>         tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
> -       if (!tmp_folio)
> +       if (!tmp_folio) {
> +               error = -ENOMEM;
>                 goto err;
> +       }

Same comment as previous patch.

Thanks,
Miklos

