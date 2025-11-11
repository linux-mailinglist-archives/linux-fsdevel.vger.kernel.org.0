Return-Path: <linux-fsdevel+bounces-67962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A3C4EBA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3916F4F1867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D335BDBE;
	Tue, 11 Nov 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UhjGN027"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AA35BDA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873710; cv=none; b=jMq1s+kgzGAvIi/KVaGK72cWdQk1HLkXoP6uQqLCypxR7NQl4HhK5Fe5+ikSreQWWoLJtuGpiAqJtUR4rLjTBmvcQuqXY7c4VIoF0kp86MbUcOa86MNMfI9cggfkaI3EYwXn4fo9p4nB8xKn6fucJPZlVQWWPG3WsobWAB2JWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873710; c=relaxed/simple;
	bh=Xta2MvlZu3CQWRZS+oQzk+wp+MTHAV8yo94rNuOB0Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q33bb/6pZMi39Joh0gX3nei7IU/3+xutOx4u23iz9Ldo4EdCzysnffHY6cCCSm5goUrqNZlLikLrrdLIeDqOswyHNpDd6chPf3TX7iCyKCrKfRo/vH2DWCdzEh5YKUnnhX2hU6VU75iUuEqWcHVlLcdhl8MOpI/D+hlMrShzpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UhjGN027; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109c6b9fcso32938871cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762873708; x=1763478508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFQcYhT1UN/BdLra6ZICJpJxbL9J8g75Rx8chmg733k=;
        b=UhjGN027u0i1SiNYA0tH48ihn+btQM+7rrcPSsNEPhxLYKe/p4x3dH4ksmMBGzQi7u
         3memNEC1QY5JyzsZ5NrqSBp8PzM5w/a/Rp8vPJ8KpvVuzciJVgiVIFRDPCuWECrRhx8p
         y+6kmZMBscgmS76Z9cPUi+QVNfPj8O4Zwv3NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873708; x=1763478508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFQcYhT1UN/BdLra6ZICJpJxbL9J8g75Rx8chmg733k=;
        b=CnEKv7+CK4DpHtxUvXuhnlOKwdRPPk8hkkFZ7q44CcBtzPiOePUlfTVLafmWdufHTy
         orZyN3d7gTwnECimWIv7XWgqiSFOhg5OqnmwFkFomhVgP/ROwl4EOvAVPuYcejuwFxeM
         CrgpfKV3wIlcGEJWX+Xtomu9Uv0wEmL86UJ6lIbuxybYoWbuNfbjcnq7e0gva848tCSm
         J04aa8YzpQ6voseFheguI/4wL3nss4NQnnYfhPyMl66YJgOcgK4HQvksA/FkWV1Uh+fg
         WG6EvxP7ev8l8XImFXlHf5VbwqwdUr3M/lWcZQyX7U7WXjFCLJxoJ6ZuJ6H1lqGbOpk8
         UxHQ==
X-Gm-Message-State: AOJu0YwTFDK0e3PFA0ohmH12PjqQ/N/8VFIwghWgG1wlkQkDFRrCrflH
	pc+h8keNcUGz2RKeYA5ohNoFTljb3MKteRK15pvaTe7LsK+vyDElRLIGpyw6HQ87DG+nI1dGT85
	Ut4oDm4Kc5z4MnmltNKlTx2bkv57Jmeh69k0jw3hMdw==
X-Gm-Gg: ASbGncsIEnxvZg3/8Buqq7HUHwTp/psh+2B3UGqV51GCoWzSp1hoDSH5AbMTUERUQEp
	UdiH5qTtCPB0fF0GSkqKXsAVvwhgXGi9SkXg2OgqonDI8bVTAsQGPdSFsz0rrRyz30Enn/ZAZay
	U8MOwmhpqBUUtLqs7693QcsvXhecTj8V6w7jm6vAJG1LCxPM4ByEs/Ibn4CCxfvo2gRf9bqlDkm
	RQz6CKsvSeSiUL6vMOSsuPKtcaIksdjSBJR1qIVY9Gf8xFDvSsZGoOvenonn40TikVkQA==
X-Google-Smtp-Source: AGHT+IGXw/+UkoN4jkqPn720diGcBgscMO4ai6PZknNP18Vmw/GLSm3jiiH43yVB2r34WCebUYV3Zhiy4R9PZZEabTw=
X-Received: by 2002:a05:622a:4e8d:b0:4ed:aa7b:db9a with SMTP id
 d75a77b69052e-4edaa7bdedemr134400811cf.79.1762873707134; Tue, 11 Nov 2025
 07:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010220738.3674538-1-joannelkoong@gmail.com> <20251010220738.3674538-2-joannelkoong@gmail.com>
In-Reply-To: <20251010220738.3674538-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 16:08:16 +0100
X-Gm-Features: AWmQ_bmHMQPQEUpSNB-Y7kkwlPoWl7xahS_phRTvRX4OCSa4FJeaLKf9HXN4Qes
Message-ID: <CAJfpegtCiEGxnnvQE=6K_otzhCkB4+SVLV74_nP4Oj4S_yeKPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, osandov@fb.com, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 00:08, Joanne Koong <joannelkoong@gmail.com> wrote:

> @@ -110,7 +110,9 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
>                         fuse_file_io_release(ff, ra->inode);
>
>                 if (!args) {
> -                       /* Do nothing when server does not implement 'open' */
> +                       /* Do nothing when server does not implement 'opendir' */
> +               } else if (!isdir && ff->fm->fc->no_open) {

How about (args->opcode == FUSE_RELEASE && ff->fm->fc->no_open) instead?

I think it's more readable here and also removes the need for multiple
bool args, which can confusing.

No need to resend if you agree, I'll apply with this change.

Thanks,
Miklos

