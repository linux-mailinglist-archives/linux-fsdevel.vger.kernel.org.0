Return-Path: <linux-fsdevel+bounces-73274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA4D13D8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DB473007C1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A43624C6;
	Mon, 12 Jan 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="QPgf2kON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A62EBDE9
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233505; cv=none; b=Dou4r0WGxZbCzDVCTzyYUk0cWGd1qCe4/l1b25mAujYaC8X+Qfsm9mrbEJS/IMuNNGmP67t39Rx9FGzz9ZVLNg4Zf1QThJTTpXTFmibT7jhlwO/IQ9/QT6OVG3p9hOKOuEesTsAUrUrOLmhz9B/zRw8QZb/zmt9llLKNMlMy1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233505; c=relaxed/simple;
	bh=YBQAjiErfKix9qYjhzQtrpGfQvS5bwoW7oG/KWy9wl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dMQ/Vh3qpJl2d5augJlciRy3xR6bmIel0T9uYaIZ3ZKE+3raOrZJTPJVqnZTv09SRoXk/2KfBrguni45kjqziJvH0xJWrj5p3dHSYOEZju8EVIXqDOltxzOCYae7DWORbT5MCij9Mj/0iSvyHgc3FcNFDok20/q3FU1IWipN40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=QPgf2kON; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e3dac349easo5660918fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 07:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1768233502; x=1768838302; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5BPPVnFuC3L4ph0BNdt22LAHRTxbWdYhYiStNQNz6A=;
        b=QPgf2kONiDkast8bm0QzpJHyulYzL5ZXoEHbMUo8det4oV9y7jXX5ECgTlFKS+XHoW
         vpdsGUq+YuyINRmNmUnauVXKBmClljXaZVqWZOQsCRB5yhH6O6xJJB4yYXYFrSxXhTe2
         gv5VDXy0McwR3mO6QKO9HbyZGV7rlB6pax4Yn8VatIhbcvxunzZjslp+/pZwjCZMTjc7
         xSPy+VtknlXyqMGtBO5QyTCW4U6mm9KCgYxVnjynM+cvngHUdQ11hrVt9tjYFTkNnEbA
         mqkJFACMN1VoUCZkiYQt4Q9uCXnrBqS8BLi1wfglDxw5i1qcvrLVMJZ6N1LR5uWPN8/u
         nUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768233502; x=1768838302;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5BPPVnFuC3L4ph0BNdt22LAHRTxbWdYhYiStNQNz6A=;
        b=Scko5FMvJNOLWq6o/V0+JQaLfzbONij97e22OWfv+icphKPxgQ1e/WnxK4NUkd8nBX
         /Yxkm6lto7MkDRDM8KPHmVL+WXZa1gn9e4mrQHpl3bAIIr+5nIeGwOJl/bibZc8rtcIA
         Br7hWaTAA3EMU/93NFr24pa03FxCV/w0DUTP4E3IJryMEjfqOVWe4R0C7WKtT/6ILPu7
         0XgHxV7mHKZkDxtxAEYhXAfsN7+mrA+KuAIWbqaYtQfpKZy6RK73PGil7bX6rWaoqzuw
         EXMISfy37hXSl/j2iJx4osSseBfSXPj4WClSqiPaxhy+cgKTciLyTN7bgka59tg0JA4D
         qKUg==
X-Forwarded-Encrypted: i=1; AJvYcCVPu7CZKDAsOkgqGf64B96reTcfv2boGP4uRLzdgasGoLwoxnZvsxtPaUvxIOQP3NfbwIVXwynqolTnQBbJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRQBnaZl2+vtY4Vc5/zSzC3hlmqGi3/Vp7glFQ6gOMz/qsrsb
	kvDq8j4mi75FFZORUbGI8E2EyyKqBs1My1lg3mOzLbygWkRB56CvP2HloI3uH0WPsztX4bOLY7U
	C2tAnx6oRZuZvRtbFVFoCQy3/JwOrUGV+oS+tRFIEaHxq2TMSRVY=
X-Gm-Gg: AY/fxX4Hwo7mXcdW5303LiiUWmvCsCs9HyqvRp++7AJlJ5dz0eiMFZMHJzlPdeNXx4o
	2BBaj1AW3z0XVwinthI5bv25Y3uQRKh5UkREfOCsK8B9uJ0mFdKGY9nqct8ZM60dtd02LaivAgD
	DmqF4xb7LuJN2V/aZ8XOAmFLeMnJZ2OAN3Cyr7vqJm/2U5E2mK001cThQWEx5juSY6ARKqkbhYQ
	XUAVLu5JlM50dCPhHiD7Fg17AtVeVuX3ry+Bs9u6967q+OI81EIqJTTa7zBc26LHso+LYGtspQq
	nuly6oQ=
X-Google-Smtp-Source: AGHT+IHs2lxd2LMW9rGg0KUxMMNs8sQIrsP5OmwonrAGlHbQ0KvjgZuNjbx3tiByPhRg04+XV4xpdioGzRI73E37icE=
X-Received: by 2002:a4a:cf15:0:b0:65f:6582:6b23 with SMTP id
 006d021491bc7-65f65826ca9mr4635201eaf.38.1768233502404; Mon, 12 Jan 2026
 07:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222100057.633988-1-thorsten.blum@linux.dev>
In-Reply-To: <20251222100057.633988-1-thorsten.blum@linux.dev>
From: Mike Marshall <hubcap@omnibond.com>
Date: Mon, 12 Jan 2026 10:58:11 -0500
X-Gm-Features: AZwV_Qhmjb8mQqI9jLPL69ssVE-lvRiIp2UYzGXh06aZQIG-TQDiTfaC0DS57TU
Message-ID: <CAOg9mSRL1KsvcpVTRvN_Q0CTmp_t52m3UTsx2Goc7CQD+BKJSg@mail.gmail.com>
Subject: Re: [PATCH] orangefs: Replace deprecated strcpy with strscpy
To: Thorsten Blum <thorsten.blum@linux.dev>, Mike Marshall <hubcap@omnibond.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch. I have tested it and have it
on my linux-next branch. And I learned about how
you can leave out the third argument to strscpy
if the size is known at compile time...

-Mike


On Mon, Dec 22, 2025 at 5:01=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strc=
py [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/orangefs/xattr.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
> index eee3c5ed1bbb..a431aa07a229 100644
> --- a/fs/orangefs/xattr.c
> +++ b/fs/orangefs/xattr.c
> @@ -152,7 +152,7 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, =
const char *name,
>                 goto out_unlock;
>
>         new_op->upcall.req.getxattr.refn =3D orangefs_inode->refn;
> -       strcpy(new_op->upcall.req.getxattr.key, name);
> +       strscpy(new_op->upcall.req.getxattr.key, name);
>
>         /*
>          * NOTE: Although keys are meant to be NULL terminated textual
> @@ -173,7 +173,7 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, =
const char *name,
>                                      (char *)new_op->upcall.req.getxattr.=
key);
>                         cx =3D kmalloc(sizeof *cx, GFP_KERNEL);
>                         if (cx) {
> -                               strcpy(cx->key, name);
> +                               strscpy(cx->key, name);
>                                 cx->length =3D -1;
>                                 cx->timeout =3D jiffies +
>                                     orangefs_getattr_timeout_msecs*HZ/100=
0;
> @@ -220,14 +220,14 @@ ssize_t orangefs_inode_getxattr(struct inode *inode=
, const char *name,
>         ret =3D length;
>
>         if (cx) {
> -               strcpy(cx->key, name);
> +               strscpy(cx->key, name);
>                 memcpy(cx->val, buffer, length);
>                 cx->length =3D length;
>                 cx->timeout =3D jiffies + HZ;
>         } else {
>                 cx =3D kmalloc(sizeof *cx, GFP_KERNEL);
>                 if (cx) {
> -                       strcpy(cx->key, name);
> +                       strscpy(cx->key, name);
>                         memcpy(cx->val, buffer, length);
>                         cx->length =3D length;
>                         cx->timeout =3D jiffies + HZ;
> @@ -267,7 +267,7 @@ static int orangefs_inode_removexattr(struct inode *i=
node, const char *name,
>          * textual strings, I am going to explicitly pass the
>          * length just in case we change this later on...
>          */
> -       strcpy(new_op->upcall.req.removexattr.key, name);
> +       strscpy(new_op->upcall.req.removexattr.key, name);
>         new_op->upcall.req.removexattr.key_sz =3D strlen(name) + 1;
>
>         gossip_debug(GOSSIP_XATTR_DEBUG,
> @@ -361,7 +361,7 @@ int orangefs_inode_setxattr(struct inode *inode, cons=
t char *name,
>          * strings, I am going to explicitly pass the length just in
>          * case we change this later on...
>          */
> -       strcpy(new_op->upcall.req.setxattr.keyval.key, name);
> +       strscpy(new_op->upcall.req.setxattr.keyval.key, name);
>         new_op->upcall.req.setxattr.keyval.key_sz =3D strlen(name) + 1;
>         memcpy(new_op->upcall.req.setxattr.keyval.val, value, size);
>         new_op->upcall.req.setxattr.keyval.val_sz =3D size;
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>

