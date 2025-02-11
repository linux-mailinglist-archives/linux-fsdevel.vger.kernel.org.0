Return-Path: <linux-fsdevel+bounces-41507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30630A307E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55DB188A538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC021F2B92;
	Tue, 11 Feb 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsKaqWki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE2B1F2396;
	Tue, 11 Feb 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268140; cv=none; b=EQN47H1hbIDlsl+sHvqD9KwsSAOZeiCwI7xiPB1b568aKdz7NeM3fF1cXiU7g+rJhDTfi2DPDzQIW0uHVXfhkeSJi0m6KMxC9o8RBJ0KOQQirea5xlZHtKuybDN7WbZKoMfhJlKzZd5drY3mTF0erMlfWEIUXS2uQ95XayHtMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268140; c=relaxed/simple;
	bh=S1RUrjTsYuldRS53Y0wnxLNR1irESTHWaLAVSdnbNEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzxJjbTZ++xMLr+WqckSZlZr4P7ctjrlZmNiOK2PwhZ+FCkvoHjGhRH6C/rivTa6fkmn/ngao3VBl2Zuq7cVXcn5WdrfT72+S7fK1J+pSia18VLAjGC5LfQ7TNhkfEw1Q6uHuBGs/ve9MKusNVEEKcU9G4DFUgYiDsbULUYI/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsKaqWki; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de6e26d4e4so4832345a12.1;
        Tue, 11 Feb 2025 02:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739268137; x=1739872937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcGS6UCbGHb5oxo+EDRgwiLzKfnAHwzvUCP7UJie9sA=;
        b=TsKaqWkippj0/7CdXRjpPsLYgaUbk5ZVoAfYQegLpNzJra/tn8wolGXHJ04VlTLxUg
         GyzqHX/PchZmrQISHB00ahxMeucC+II7i4CP82I2uvz04P/ZTHDkAUkciqn08SQlr50Y
         lzJ0sZNZffy7doKHY3ik+h6I0SvYbOq4Thcvsnr7otuPyKK7OoYyYON0+CMsTFmv473c
         aI14KjGn2K+R0cssLp/hwcUZgYlT8+uEDr+ekir43UzI5r0zxQHFuPXljVGciiYVnze2
         PyYoAYwVw2yKg8QmVGodetsPMe+R8Ptx5v6RcK9ynL2x3ycu5GQAjxFMRcY3a7Egm9Vn
         tJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268137; x=1739872937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcGS6UCbGHb5oxo+EDRgwiLzKfnAHwzvUCP7UJie9sA=;
        b=Kt4iOMCUgYOUvdYievfnOtV+R7GyZMFllCaqXB/MqDT6rLY+ze42qCJmA/sI5lGPRb
         fuqzeZRdHOBiJ+4/x4eKbr8Jxa8fI5AW9AK32rzGuwUBqRUdUYlSa7invpiS1ez5g/AT
         rsEadEWtbnJ4jRNUvYLRPtSrlArtwVqn73f4HlfbyF2v1SbPrFARYRSgKuo7PxlJou7z
         w7Rh0XEuo8z1BcVFlSUEkny+spuyHisZ+Ij2HE9+JMkogT8JSDsRTWeqjyWvXvz4aJyI
         JetknwHAj98H6fM3yWztNYXgr9ZRWlstWzU1YAan+hoV74e7WDBRRZQDpJSJuphLbIfY
         RQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLBCxgXMcQrWpgNhJodPeQ+RLDnvJLoCjpZxX9jiXIIWegtFPQK0g7inH4/j02SWsuqZSc8lMKFH0bd5Bh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1JKL4NpDOytNgy+wK6I3pVjEFvv5+ebnU/3bBdYb0EaNGt4dS
	rwKEvMEM74H9iOC0uzFrooNcZme3J5CVJhJGey8q0R/53c6GBqRj5RpZQEoOk81fExg1/zRz97Y
	ZcV2Fkw7FC7fDfTJ1D6UswjhMkVg=
X-Gm-Gg: ASbGncsOYat3UTZk6qDKpWLsOaHfOvXSLYKdif4KLPxxLAfthIrzDMRqtfoOyXx4Hxn
	aZ2Sdv6mhCjIn0RYf1KkVwbLCEQQNcMfvNWISzuKXQyVBAnIllJkMWdvMQfVd/hRjYGnzvk75
X-Google-Smtp-Source: AGHT+IF/MC5h4tqa8nTowJ3Ny7BSI0o+2FHpuTJfBFWLpPUdXrVg82SPCr26RvTuSt1YUqcB33YWxeUS1UTAqc0TATs=
X-Received: by 2002:a05:6402:2546:b0:5d9:f21a:aa26 with SMTP id
 4fb4d7f45d1cf-5de450a9e4cmr16531818a12.24.1739268136920; Tue, 11 Feb 2025
 02:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-2-mszeredi@redhat.com>
In-Reply-To: <20250210194512.417339-2-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 11:02:05 +0100
X-Gm-Features: AWEUYZlE4c1txpQvmKDdEhm7259DhcfXAGl1SNSHqgv6Nf6q0Pk6xgZordsRZlw
Message-ID: <CAOQ4uxg6O=yKdhN8WB7pma9d8qAVYpAx4Zrq1fhg0ag755LDDA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ovl: remove unused forward declaration
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> From: Giuseppe Scrivano <gscrivan@redhat.com>
>
> The ovl_get_verity_xattr() function was never added only its declaration.
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/overlayfs.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0021e2025020..be86d2ed71d6 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -540,8 +540,6 @@ int ovl_set_metacopy_xattr(struct ovl_fs *ofs, struct=
 dentry *d,
>  bool ovl_is_metacopy_dentry(struct dentry *dentry);
>  char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path=
, int padding);
>  int ovl_ensure_verity_loaded(struct path *path);
> -int ovl_get_verity_xattr(struct ovl_fs *ofs, const struct path *path,
> -                        u8 *digest_buf, int *buf_length);
>  int ovl_validate_verity(struct ovl_fs *ofs,
>                         struct path *metapath,
>                         struct path *datapath);
> --
> 2.48.1
>

