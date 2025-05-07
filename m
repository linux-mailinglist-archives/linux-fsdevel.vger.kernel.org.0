Return-Path: <linux-fsdevel+bounces-48326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C3AAD58D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 07:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C76F46716A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F22C1FCF41;
	Wed,  7 May 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc0tUcbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02D1C84BF;
	Wed,  7 May 2025 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746597397; cv=none; b=uyGfxCJr5UfkbAeA02Ck5bwyD85qzxtZoL/vsA/HB/8551Ht7RPzMsu+qrviGd4HYIUltjAiZLJizngnwhNZPBPtq/ZDh55VIJEtNa/anaQsdeAOEvJ/RO2acPStUtvKiN5sjaDWpgiGMGv19RGsTiEtFwNSByf12/UWej3PjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746597397; c=relaxed/simple;
	bh=6cyED29jzbddJnC+N61WpxIYXyD6aCPF1bT78J1ef6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4GWmAxa9yvNRyXwzk279sEHSF5Cu+xWkqBi+473MgJJ4367qnUL2jzUSiKGORiBccc3a+IycENHSFnLtMeBKImK3sr9qxtLjZFNs5hEfUv5uOb3Av8OEtMm1xcP/CR3Nj5saxxGG2cvCD2DCBSmqkev1ynM4U1Lu0Pdf+Oybw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc0tUcbb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ace3b03c043so983967866b.2;
        Tue, 06 May 2025 22:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746597393; x=1747202193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOgMR57k7i25Wq4gi9BHM2O3kuDXS8jsXlCOxBJd3jA=;
        b=dc0tUcbbCoUx1jyZeK0K+iCatjTJ2IIxBWIYzv+711G/ADiXh0WuJRnupxwWSc/bgh
         0qLovMOZNvzWxctxkcv/qNXPz0bfGIFhrD4smbisfZ3GzPEZnzkp0rw/aycnO/JcLVp7
         qO4fjC81TkNkIi3DNmUzu8ZVnzG9Zls/IUmjPoZui6Yjmz2gnLMkateesfwdF8cD7f13
         X865yVbl+7zQTK+AgdkZWiTyrcTqoyuFJODnVjNAzi3JAEvigycpfENSbRjukE31tnHu
         1ScZfnt+iyEI/+V2tBSaIhLpd/nJNw76FXIfjis22uoPV/uMI0C7gH6gSLHfhO7PL5xp
         GhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746597393; x=1747202193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOgMR57k7i25Wq4gi9BHM2O3kuDXS8jsXlCOxBJd3jA=;
        b=cS1bFRfhZDv4wAo3inq35ywqBrMiEK9qjLKB5VR6YxZaD/X8FoFTVTUOfZ9Y3D9G5J
         QFzTClKlt4rsypQP1y1B8za+LTYlXA+2xGduXBrXhDp2pP7tQOd3D9SFZEGpR+pOEPiD
         Hz8uadhP+2a87uZVl16i5AQJYxsRzUZGemaoJu6NhsicdXz+SahxHTRc3BdgzZH+phHq
         zMddl5kiJ4owRXQm83eVdELVJI0kOgWZ+T2Es49qfh9l0eOHKYC4ipC1Tn+ds2hOQINE
         uhU5Z2iip2buEdUvPIsKheFGYXdDgzozo9GAfcL22Uv8OxE7T69piWLQzV0na8wCfbt8
         us9w==
X-Forwarded-Encrypted: i=1; AJvYcCUgZsyS5JBFg0OWUhJNF3Wyz1r3CP8dJ8maIn/yzc1YbmNeE/g4SM9tD2cbblSyGjugvWxa78a9wn1UbcXN@vger.kernel.org, AJvYcCVwSyvibYdhtdRDs3NIfZTYeC+XFj+Zh37/SZ2rrbLzsbjLo3W41/pykIdTPogO7zWhoFsKwqPILs6qqxeOp6GD@vger.kernel.org, AJvYcCXPu0LXeRI1C/2UKODPhl7qs6LrUfVZlQVHnA2ShltlFu9oxlInhFo9RVZgiFJLU9OmuILOLYV2bD5/h5yj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07Hdu2LdWpmX/qjlJW5Ee6HaCRp1/6uC8I1XkjHfnl3O7vjfH
	dYOVKJuiH592wjNjISBWubPvtCFN1h7rtOS+XNyIkCypBukZBR8e1GIH8NaeOe9ZyhOOY/ypF7Q
	YMEQDOc6Rdjz0Opr7c9Xf5HEYr8o=
X-Gm-Gg: ASbGncs/PjqDzBtTDJRPw59cQe8HncCcp6t2fnxaKFgRe34ti830nQtYDRxYUtH8V9G
	JDts/8FdBEISXeVvWHiJXz12z6+nVJ6KFF1hEl511x4fLJOLJJ0Yfa7ibBYj0DPusOu1b13mLJ2
	XdKWvgrqPrbobv0HwDiJLxwA==
X-Google-Smtp-Source: AGHT+IFTSGPgKADIjMvGu2WpqjpfTT8QnmEBLbFDimNQmDGQsTdXiftdCYFiC30MoDZpOMrBRSziThnXKWHuiDcaFEA=
X-Received: by 2002:a17:907:a641:b0:abf:fb78:673a with SMTP id
 a640c23a62f3a-ad1e8bf960emr203549166b.29.1746597393032; Tue, 06 May 2025
 22:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBqdlxlBtb9s7ydc@kspp>
In-Reply-To: <aBqdlxlBtb9s7ydc@kspp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 May 2025 07:56:21 +0200
X-Gm-Features: ATxdqUGTSqz3KnQdRZ3IH1yq8eYeJHK6Og4UwM0Vg4vZu3RKSGjwvBhhRCVgfdU
Message-ID: <CAOQ4uxj-tsr5XWXfu3BHRygubA5kzZVsb_x6ELb_U_N77AA96A@mail.gmail.com>
Subject: Re: [PATCH][next] fanotify: Avoid a couple of -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:39=E2=80=AFAM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> Modify FANOTIFY_INLINE_FH() macro, which defines a struct containing a
> flexible-array member in the middle (struct fanotify_fh::buf), to use
> struct_size_t() to pre-allocate space for both struct fanotify_fh and
> its flexible-array member. Replace the struct with a union and relocate
> the flexible structure (struct fanotify_fh) to the end.
>
> See the memory layout of struct fanotify_fid_event before and after
> changes below.
>
> pahole -C fanotify_fid_event fs/notify/fanotify/fanotify.o
>
> BEFORE:
> struct fanotify_fid_event {
>         struct fanotify_event      fae;                  /*     0    48 *=
/
>         __kernel_fsid_t            fsid;                 /*    48     8 *=
/
>         struct {
>                 struct fanotify_fh object_fh;            /*    56     4 *=
/
>                 unsigned char      _inline_fh_buf[12];   /*    60    12 *=
/
>         };                                               /*    56    16 *=
/
>
>         /* size: 72, cachelines: 2, members: 3 */
>         /* last cacheline: 8 bytes */
> };
>
> AFTER:
> struct fanotify_fid_event {
>         struct fanotify_event      fae;                  /*     0    48 *=
/
>         __kernel_fsid_t            fsid;                 /*    48     8 *=
/
>         union {
>                 unsigned char      _inline_fh_buf[16];   /*    56    16 *=
/
>                 struct fanotify_fh object_fh __attribute__((__aligned__(1=
))); /*    56     4 */

I'm not that familiar with pahole, but I find it surprising to see this mem=
ber
aligned(1), when struct fanotify_fh is defined as __aligned(4).

>         } __attribute__((__aligned__(1)));               /*    56    16 *=
/
>
>         /* size: 72, cachelines: 2, members: 3 */
>         /* forced alignments: 1 */
>         /* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));
>
> So, with these changes, fix the following warnings:
>
> fs/notify/fanotify/fanotify.h:317:28: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
> fs/notify/fanotify/fanotify.h:289:28: warning: structure containing a fle=
xible array member is not at the end of another structure [-Wflex-array-mem=
ber-not-at-end]
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/notify/fanotify/fanotify.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index b44e70e44be6..91c26b1c1d32 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -275,12 +275,12 @@ static inline void fanotify_init_event(struct fanot=
ify_event *event,
>         event->pid =3D NULL;
>  }
>
> -#define FANOTIFY_INLINE_FH(name, size)                                 \
> -struct {                                                               \
> -       struct fanotify_fh name;                                        \
> -       /* Space for object_fh.buf[] - access with fanotify_fh_buf() */ \
> -       unsigned char _inline_fh_buf[size];                             \
> -}
> +#define FANOTIFY_INLINE_FH(name, size)                                  =
             \
> +union {                                                                 =
                     \
> +       /* Space for object_fh and object_fh.buf[] - access with fanotify=
_fh_buf() */ \
> +       unsigned char _inline_fh_buf[struct_size_t(struct fanotify_fh, bu=
f, size)];   \

The name _inline_fh_buf is confusing in this setting
better use bytes[] as in DEFINE_FLEX() or maybe even consider
a generic helper DEFINE_FLEX_MEMBER() to use instead of
FANOTIFY_INLINE_FH(), because this is not fanotify specific,
except maybe for alignment (see below).

> +       struct fanotify_fh name;                                         =
             \
> +} __packed

Why added __packed?

The fact that struct fanotify_fh is 4 bytes aligned could end up with less
bytes reserved for the inline buffer if the union is not also 4 bytes align=
ed.

So maybe something like this:

#define FANOTIFY_INLINE_FH(name, size) \
    DEFINE_FLEX_MEMBER(struct fanotify_fh, name, size) __aligned(4)

Thanks,
Amir.

