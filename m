Return-Path: <linux-fsdevel+bounces-51584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C14AAD8994
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880DF188D570
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B202C326F;
	Fri, 13 Jun 2025 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czOErQYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABB79E1;
	Fri, 13 Jun 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810941; cv=none; b=ERBwI7WDKenmKYyeapU+z+7qgWoM7guzJTcaxBSarYCvPFbbRd9yTXjqdT8Er4ENICPybvOtZww7zlzXpqz9+/VxhI8XWip1I37ALVooGiHeEBnqklokojfatDT+OCd5Q41SGKXfg8pnvmh0NsETiqduIbtXUV1DOO97GE7CTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810941; c=relaxed/simple;
	bh=TnbuuaFXflGc/rCk8aiN+olOX/vOi5g3IaRdtUlFnAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mL81A9zjNM8H5BwE0RHBTMbbjr1oq7EIQ8Q4vGZGMJYQbPTERv65J26GhHxIg7SZh3vsb9S9NobDQWPK8tdZCwcrUosXdvBtjibjrY95iQfyP5Lao5N2N1KtC2VHI8Vga/6YG9qrn74s6a1mxpddDvKGpGFwG0ES7Y+1dcisRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czOErQYj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad883afdf0cso386401366b.0;
        Fri, 13 Jun 2025 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749810937; x=1750415737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um8WIzMEpACnf9R59q9VDvyXlQNmMunrYEvCxR3bbcQ=;
        b=czOErQYjNd2M9BNAESwjP/9/zxQzR9OQVearFd6zGJ59dvzaaF/WT7aoyrPfeVFBFw
         3x/Gixh+w4H//0sBAIPYY2GJsCHDg2HN5G0QK/atQ/GD5Ld9O8nBXxFdmCtPBqcDlHkJ
         d4C3D9m327OydvZpLZl5ZIHAlYjI0AGm/n+uyBzC3M+r3R+NvP9/e6ycrhtVPMm8ygb9
         tECMYJ8HgTf+jnnnILbr9l+eTKzyv7I8J14gDBYGo12cvKnt/NBFJR5yR8E0iZPUiUjY
         7BFbe/yl2jLp1dqKzi8VZpaZDCH+b1xsIg7LB1Y8Kog/6RUfLBRhnmPS+T7PmO+5DJNH
         7RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810937; x=1750415737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um8WIzMEpACnf9R59q9VDvyXlQNmMunrYEvCxR3bbcQ=;
        b=oy3oYYAJJittsPtG/uLDhQXcd7CEsWcT3dwaY6KvStGool2mBKOb648HK6xsx1LCkO
         sNAxIB6R4ZmQGtJu/2lQU89co7dVnE6hvTzWq45vmTzj8UDraEFhpoHQyRkyzLXdxYY8
         Corw9nDzbgKpOLCVmNT3I/ajJP1UJROFK9nYEGN5c8SXDJxNRTYyLcw3wyELYufZTqaG
         U1tjOyJ4FJDuDNDmG85jBAOkzSSI4J5g46YwvR4V72rEIInsuFOSD3+DIMDKhbpFd3ih
         FN9aPdOPjwu+SCstRCbYFUihfygTH69f4VnI3jK+wKIJpKkMJ4pHa8cZOnFWj3w5beMk
         kXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUdWT8qYiNx+TIOqhQDt6xAsUJ86Vn1P/svrOLucuf/I1CnxrftOecd+wd6p0sy/PuO6buRPVYfwTWEtnaw@vger.kernel.org, AJvYcCW1y/51lfGcZJ74IB9dmt4GxlTwR5ESXLt4iocceXn8ljK0CfJsbEOAifT1JaXFEnHiswA7Ww6goPetwayp@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAsfs0GglXkc2wjaMGS/0R8KRSNvdZdQaruWoeQi6Ryo3qOpB
	Od3OK0roLzCiLsroye2erERbBaXFlcjxC+seY2MXhTPhjs9l/AkmdHpWHdy/iSknoLaIpiXBE/4
	b6pBvuH//KoaX5ThlM7SGZ9k2LDeBzy8=
X-Gm-Gg: ASbGncsVHGwrEUHYACDXFsAxTfQgmRZcdHRS8bL3CyCEu2tO3YyxDdgR6PbRTwrfBIB
	RqxlwXz1o9DIzeZZz/eGfFR4zc5XSkTLQrhKu+J2VZ1WqhGjlHbErrkCIDeqHrrxJbviy86JPvr
	XXl6ye5wqPlKenu3pX9cBkACc3D86FAOgG3nUj5rxqHUA=
X-Google-Smtp-Source: AGHT+IE0Ed+LzM3wZqfUgv1QO1VkqAtgLXZRkCKOCmoe3mJkU4FRUHCQ3q1iNK/cFYAjlmUccsN/3Kxa5zQ1XSSDLAo=
X-Received: by 2002:a17:907:a08a:b0:add:f189:1214 with SMTP id
 a640c23a62f3a-adec562fe77mr218113466b.24.1749810936844; Fri, 13 Jun 2025
 03:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com>
 <20250613101111.17716-1-luis@igalia.com>
In-Reply-To: <20250613101111.17716-1-luis@igalia.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 13 Jun 2025 12:35:24 +0200
X-Gm-Features: AX0GCFslrH7-bJufkZwsq4W6csqtHJM0UkhdC0uVdrklAs2PQTd6MkZXdSgqELY
Message-ID: <CAGudoHEu2v4MisyGO6gcBcnfKMgK41Y1=syhZoPm4exvj4fLQA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: drop assert in file_seek_cur_needs_f_lock
To: Luis Henriques <luis@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:11=E2=80=AFPM Luis Henriques <luis@igalia.com> w=
rote:
>
> The assert in function file_seek_cur_needs_f_lock() can be triggered very
> easily because there are many users of vfs_llseek() (such as overlayfs)
> that do their custom locking around llseek instead of relying on
> fdget_pos(). Just drop the overzealous assertion.
>
> Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Hi!
>
> As suggested by Mateusz, I'm adding a comment (also suggested by him!) to
> replace the assertion.  I'm also adding the 'Suggested-by:' tags, althoug=
h
> I'm not sure it's the correct tag to use -- the authorship of this patch
> isn't really clear at this point :-)
>
>  fs/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 3a3146664cf3..b6db031545e6 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1198,8 +1198,12 @@ bool file_seek_cur_needs_f_lock(struct file *file)
>         if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_sh=
ared)
>                 return false;
>
> -       VFS_WARN_ON_ONCE((file_count(file) > 1) &&
> -                        !mutex_is_locked(&file->f_pos_lock));
> +       /*
> +        * Note that we are not guaranteed to be called after fdget_pos()=
 on
> +        * this file obj, in which case the caller is expected to provide=
 the
> +        * appropriate locking.
> +        */
> +
>         return true;
>  }
>

well i think this is fine, obviously ;-)

I was hoping a native speaker would do some touch ups on the comment though=
.
--=20
Mateusz Guzik <mjguzik gmail.com>

