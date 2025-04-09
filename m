Return-Path: <linux-fsdevel+bounces-46138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C824A833F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 00:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66EF461204
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EF21A420;
	Wed,  9 Apr 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRr/hS+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B41E0DE2;
	Wed,  9 Apr 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236443; cv=none; b=G9C27scLluEkiBQ2RRNjuEb53cBc08ia/oZ0wdAjmqpeZkzkMqIkO+oU7dGS4LUKsqhJ/DiLyqnUbw85v5A5o/7F2fbIcgUV7crQHy4lQDkIbd55mW7QkjH+oePN9jSKNqd5/xP8YxiRTsCg/Qd8p0k2dbnEoWL5B1D2mYUrZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236443; c=relaxed/simple;
	bh=O9woQGbersVOClCNGaxuMWRzQhHfVfWWjwg9cP12/8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+ccgfGAqEf7/CfwaDLfYixySHVGyO6bunqNSYLODI5AgJcgEAJBaHHE1/+ZuFA+r4hWY2UU68J89yLLQfvUTMEkWeFjUT7ZDQRggwhcjWZrFkMg15dACHXc+a6ORqlyrhekGsR+hdTDiklib5xK8YQt9AGKP7nFWS4JAr/1d2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRr/hS+8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso324791a12.3;
        Wed, 09 Apr 2025 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744236439; x=1744841239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki9TeCZEbRmCOv6OXgbkCZwfFS1t1qQ+7G0GN/K5IJc=;
        b=ZRr/hS+8tIAcSXSOfdXhvk817BfnbEA08NdlCisTB6D3csk33eTDGOdYpTh0mjCM6I
         K1HvpkaJY5Wnevtyi5MObPFBTOeABOjyYfZbXhZQ1LtYtvBJxl5QM9X3uaAztTNNMre7
         Tj+NmXofENOZv42HRGvogF23GlZhbqF3dsv9n/b1m+RQNMKWXc4K48hLWg4KeG8RoGRB
         upNZPnzyfmD90sKpfhAf28blzZ/459ndyJ1DS3Us60s2/n90anK262bPS+fMwOb49vFG
         VL+3PrYc4V6OXw/jNOwxkar7Ni7Sn914wXNBZcVMtSCx5uDfF3TWY4EtTw8WlxYWA9XN
         95bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744236439; x=1744841239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki9TeCZEbRmCOv6OXgbkCZwfFS1t1qQ+7G0GN/K5IJc=;
        b=PjnlRqgP6lYkWWr11gOP0yNuqxz29geH1nB70Z3zEZkEwBrupJVLPsubVMr9Sj88GC
         5cdQ7jTSjhigGN5HToJNTLkr92Aj5gbxC8IyLZ/6pPCe/Uiutnh0aPCXZrh1L5ZvVHSl
         utgw/PL3vTKop0WRebq+WSUw7hNl7Cq/RofNd8PtOxayZSQ9l/rCboAVYGR95msEQmGT
         ef0ukKmrohmH3lsR7LeeZLutKbwIKnk9h4acHECPUNf6yaZTxN3E2TYK86TRZ/IumIE2
         DlYsHQTOBu+n8HAhBlSmpP/+S7kY8bcvzWtAPxMkAbmP0ZoacnXuuURCSnwb+kfgkqrp
         FMNA==
X-Forwarded-Encrypted: i=1; AJvYcCWoySeFG83zCUS8n0ep9z7inyJ/XS1T75G4wqf1nWbKN3WieAjT0sKSyhPSPNiE0runpfJrrzrfIyd4ljHU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QTiKiQlfQNHAsCH9agaxER/kG8gGlQY2xs3/Qr11QyOj5h70
	QSxAqycXc6kyNw3Pym7J87GhX+g1kug/0lBLIAbmD9jtvuz82scLkpG+iE+lFEyS3uPh/xOfTD/
	UdxTd3YGm1XyyiCHlv0YXIin/GFw=
X-Gm-Gg: ASbGncscmKiJBJe/LE9xFclvSpdnUmSLhXTcolOxFWBug0KC0xYzaAKk43DESLliOtV
	A1DGwMLA8/hzrRgF+kYXwlwkQ6kf474boa8YmdmiCb21NhJYpZSP8u4zQjY1vITDf/e77oUWv9R
	xQTAn0VyLpMZt7zV4Ceprm
X-Google-Smtp-Source: AGHT+IGrnlPCRtRnpiq8xFc6pGbTK1yY+/iNNVWewvw2p+JwbzCUY3j8RsCZr2jJfKZA1JW6+k8JUcFiFBc4UpvfR2g=
X-Received: by 2002:a17:907:60d4:b0:ac2:d6d1:fe65 with SMTP id
 a640c23a62f3a-acabd3ac9f0mr25178466b.41.1744236438391; Wed, 09 Apr 2025
 15:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409220534.3635801-1-song@kernel.org>
In-Reply-To: <20250409220534.3635801-1-song@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 10 Apr 2025 00:07:06 +0200
X-Gm-Features: ATxdqUFg02q6FCXwHbvvWfhL4kPFU5S9d95rMMwjxB2hnKGMSm7_-j5-pYRi-vA
Message-ID: <CAGudoHFvgCeJC4HH_1d5x6qUEkTGdCPruid7MQFP+U5Ogb=PNw@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix filename init after recent refactoring
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kernel-team@meta.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ouch, I'm so sorry :)

On Thu, Apr 10, 2025 at 12:05=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> getname_flags() should save __user pointer "filename" in filename->uptr.
> However, this logic is broken by a recent refactoring. Fix it by passing
> __user pointer filename to helper initname().
>
> Fixes: 611851010c74 ("fs: dedup handling of struct filename init and refc=
ounts bumps")
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namei.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 360a86ca1f02..8510ff53f12e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -125,9 +125,9 @@
>
>  #define EMBEDDED_NAME_MAX      (PATH_MAX - offsetof(struct filename, ina=
me))
>
> -static inline void initname(struct filename *name)
> +static inline void initname(struct filename *name, const char __user *up=
tr)
>  {
> -       name->uptr =3D NULL;
> +       name->uptr =3D uptr;
>         name->aname =3D NULL;
>         atomic_set(&name->refcnt, 1);
>  }
> @@ -210,7 +210,7 @@ getname_flags(const char __user *filename, int flags)
>                         return ERR_PTR(-ENAMETOOLONG);
>                 }
>         }
> -       initname(result);
> +       initname(result, filename);
>         audit_getname(result);
>         return result;
>  }
> @@ -268,7 +268,7 @@ struct filename *getname_kernel(const char * filename=
)
>                 return ERR_PTR(-ENAMETOOLONG);
>         }
>         memcpy((char *)result->name, filename, len);
> -       initname(result);
> +       initname(result, NULL);
>         audit_getname(result);
>         return result;
>  }
> --
> 2.47.1
>


--=20
Mateusz Guzik <mjguzik gmail.com>

