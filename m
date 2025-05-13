Return-Path: <linux-fsdevel+bounces-48898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEACEAB5689
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32521467B65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632602BCF49;
	Tue, 13 May 2025 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1UWc8Ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6828D827
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144497; cv=none; b=Nydvc0DTDqrm10sf7p00bt9QyqGm45pd8VcW7e3M2CKF39dgzoBGyCGVVoCThMVebNV8CoNvVzxv6XIrvk5pDMmxKe/RvCRvT2U7WY2OBD0AqOivpB/2vwMGK+2CzfYJAoDcAfPFDMTdV12LaOaaeRdCf++Mz6BhUk91QzSN0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144497; c=relaxed/simple;
	bh=BBXUUSB9iWZeQPRqILuouyb5HEspbhoSWW6iGEAzCo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feIwSUyZF8Q48WDqbi036OP87AevREJg65FLttDwgGskv8RouOFZiQF4SvTdXw4Y+16SAiaF6xJZPwr9eFrrQdnpqMkL3XLQSeyvj3xl5AeH3GmP5WTVaMc7Yw3Zi8ZLrHo7GxwycK5GoXFebtAoy7PbPfrnSTPliNRdu3GJoEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1UWc8Ug; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbf52aad74so11417891a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747144494; x=1747749294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGRGtJuDy8YYmrg/o/VMGgpMkOMyLZiL+HOI5zWLhNc=;
        b=V1UWc8UgVTT5L32O8iPxv4H3t9i2+o0xI4CPDf6pL4+D3D1ZuWRlm54qnqGirr4Em+
         F8cTc1pLRfEfkZjylhfxmGinDwaVt39j9RMLWtkSqmZmw7Om/apekj1zqWK+4v89xd7n
         x5pnRTEgjHob65t+1tZHqmfvnFYashp9g5tWdEnRjbup2uBhGyz/6a6KA7QUEoaRxWtR
         0Xidd+K2Wj0tPUU9ecFQlBsg/LDbfJ3uZLfMu27rIus1RKOqyRW0QvMBG2nqJJ+/UScP
         pShEfCGxoLoMA9I7wVRYh3nmuUizCG/jWWAUKBbkg2Wpwb6Bz2Pa4eOoRWqY/MVqCM2F
         vbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144494; x=1747749294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGRGtJuDy8YYmrg/o/VMGgpMkOMyLZiL+HOI5zWLhNc=;
        b=VYuaqUQ+vKKahVVlUQeIQLu1AmuknRRZ/YvFk9dYtRo0Szk4+4JVC3JKFytyycluQv
         5bPaFxuo8zlNyWon/3Pea0ZYOkkIFoYvgI9ApBes4mF/tSzY/2zhNDlsX2YQKrMbuM33
         D3bmujtPU++JYitR2tNHuL0W4dFSr+rk/kE6iZ8KkhY5LhT3cQo/amdyJsCSZKHslp/v
         +jGhqHAyw9q2XmqNzaykh7cIOsSefIZoT7EFYnzrtK/O9G0rnWNeyOpKjRwZiDHl+5xK
         5624wM3TCA+UA5yx3VIf0WaVg/SThPxrDQB0/aS6j7YZb4bbRSTDl4yXt2emORmEhYxZ
         eU7A==
X-Gm-Message-State: AOJu0YzOzkhzgiO3reg4lMWd2dMmjxmnYQL9+O8ZeUlDcWQxao9CI9fI
	7MeU29O9MG9TqIkjE7Ag7SB/bYDwWgzbMfyz9W+ZNwS/fuxwud97/dni3vWNSSHOEMgNR/JyA0b
	7jQCg53Lsks+YNlUZt2Zsh6kmoiYLhvVKmkKL59jE
X-Gm-Gg: ASbGncvsh4IAng8wChge+NKhDgSaSagVta8/r7AfBqjE3KJof+pN/I2P4vzEOehMLED
	GLLpRsOdi/QZW3RLBUQNM1tvBEXaWF0hoWKN2InLeqX9FIEjscml+6Ijqh3fQLBQ+OF4ZWB27iN
	nlyp7i2hmeTkf0sfVOpCgLkzyrSLKZtxm8
X-Google-Smtp-Source: AGHT+IFXa7vF+tLoDuxKGM3jD7epHYocD0AoEgwoCBVaBOkLRfK57e8brwuqnc0W0h/z7v5nZfrKdfvh6TGbbxhRceE=
X-Received: by 2002:a17:907:2ce4:b0:ad2:3c4e:2fc2 with SMTP id
 a640c23a62f3a-ad4d52be8e5mr366461966b.29.1747144493842; Tue, 13 May 2025
 06:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513131745.2808-2-jack@suse.cz>
In-Reply-To: <20250513131745.2808-2-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 May 2025 15:54:42 +0200
X-Gm-Features: AX0GCFud2MO8SrjrYohjCo1frPyh4sDAdhsIXFfbXS0Xgv-cpTafhYtneMWI-BY
Message-ID: <CAOQ4uxig8mE0y_OrK5CCnXVopqFsCyhMEaGE1BMApyoHpypwSQ@mail.gmail.com>
Subject: Re: [PATCH] fanotify: Drop use of flex array in fanotify_fh
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> We use flex array 'buf' in fanotify_fh to contain the file handle
> content. However the buffer is not a proper flex array. It has a
> preconfigured fixed size. Furthermore if fixed size is not big enough,
> we use external separately allocated buffer. Hence don't pretend buf is
> a flex array since we have to use special accessors anyway and instead
> just modify the accessors to do the pointer math without flex array.
> This fixes warnings that flex array is not the last struct member in
> fanotify_fid_event or fanotify_error_event.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Makes sense.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  fs/notify/fanotify/fanotify.h | 9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> Amir, how about this solution for the flex array warnings?
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 6d386080faf2..7bc5580a91dc 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -415,7 +415,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh,=
 struct inode *inode,
>  {
>         int dwords, type =3D 0;
>         char *ext_buf =3D NULL;
> -       void *buf =3D fh->buf;
> +       void *buf =3D fh + 1;
>         int err;
>
>         fh->type =3D FILEID_ROOT;
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index b44e70e44be6..b78308975082 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -25,7 +25,7 @@ enum {
>   * stored in either the first or last 2 dwords.
>   */
>  #define FANOTIFY_INLINE_FH_LEN (3 << 2)
> -#define FANOTIFY_FH_HDR_LEN    offsetof(struct fanotify_fh, buf)
> +#define FANOTIFY_FH_HDR_LEN    sizeof(struct fanotify_fh)
>
>  /* Fixed size struct for file handle */
>  struct fanotify_fh {
> @@ -34,7 +34,6 @@ struct fanotify_fh {
>  #define FANOTIFY_FH_FLAG_EXT_BUF 1
>         u8 flags;
>         u8 pad;
> -       unsigned char buf[];
>  } __aligned(4);
>
>  /* Variable size struct for dir file handle + child file handle + name *=
/
> @@ -92,7 +91,7 @@ static inline char **fanotify_fh_ext_buf_ptr(struct fan=
otify_fh *fh)
>         BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN % 4);
>         BUILD_BUG_ON(__alignof__(char *) - 4 + sizeof(char *) >
>                      FANOTIFY_INLINE_FH_LEN);
> -       return (char **)ALIGN((unsigned long)(fh->buf), __alignof__(char =
*));
> +       return (char **)ALIGN((unsigned long)(fh + 1), __alignof__(char *=
));
>  }
>
>  static inline void *fanotify_fh_ext_buf(struct fanotify_fh *fh)
> @@ -102,7 +101,7 @@ static inline void *fanotify_fh_ext_buf(struct fanoti=
fy_fh *fh)
>
>  static inline void *fanotify_fh_buf(struct fanotify_fh *fh)
>  {
> -       return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh=
->buf;
> +       return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh=
 + 1;
>  }
>
>  static inline int fanotify_info_dir_fh_len(struct fanotify_info *info)
> @@ -278,7 +277,7 @@ static inline void fanotify_init_event(struct fanotif=
y_event *event,
>  #define FANOTIFY_INLINE_FH(name, size)                                 \
>  struct {                                                               \
>         struct fanotify_fh name;                                        \
> -       /* Space for object_fh.buf[] - access with fanotify_fh_buf() */ \
> +       /* Space for filehandle - access with fanotify_fh_buf() */      \
>         unsigned char _inline_fh_buf[size];                             \
>  }
>
> --
> 2.43.0
>

