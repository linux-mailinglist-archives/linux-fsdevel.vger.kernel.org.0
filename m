Return-Path: <linux-fsdevel+bounces-57860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C215B25F65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70005A20193
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25CD2E7F1F;
	Thu, 14 Aug 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xeh0Mgod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73748289376;
	Thu, 14 Aug 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161107; cv=none; b=Jl3Y7h8HIZkqU1Z2hez86zo4icrwtpnUNgzAfbodzY34QPfwjSOLlnqlp1MUlPnh+fYU32VC8NvZMkuxX32BVt94I+fIC3z8J4JTcS0HT5RJkOyZdLQBSTV6vMADy7FVnZnbAOY38y6RV/o1l1gK7uRP2T3kb6fAg79sxaIq6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161107; c=relaxed/simple;
	bh=10IwBC/WvFs9XL+JDSUaSxNjsB4hNPa15Nw1/P4iZBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbUCoNBg1IkeR4mOhLBxBFEpL8DZQ7dZ7jY6UfIzZJlbAqkfJ5k5vrvW7geCdvhJ7ULvsLlf9vt7aDbvqoPDcPGoSoXDtv+quEY2vQvEjEuctckk3+HhYekY/FJvCd1ATfOE++WaOTm1VBGMBrypaAC43xACWrYWQ2IpKRxZHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xeh0Mgod; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b7949f6so1380026a12.3;
        Thu, 14 Aug 2025 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755161103; x=1755765903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYJNHNsyuuYBBv1uPrAiNz0Qv3N2mB6wq1CNl2jnaSw=;
        b=Xeh0MgodIBMEm2hE08a8r2cbp4IzzuRCWEdFKGe2TEO4aSjQCjW6ai0NcctjxBFUkl
         vJJVBsaOwwE56wFgs+0rnOL8L1p9cbKUNfcZbR82zeZ/iGmDyr50rh7oIXKCbUq7VxKG
         3qUBq6waMUgTXXAMvKz8hylLcHse5wjkrzkwFan1Dq5P+IVL+bXmextF22FwdLkXkJKE
         6hPhxxIis4Mywk0YAFgf7iImD8SGw82EMXea5Nw7fIMlg9GcC1/GSt7A3oT1owkwUrPp
         pitN4keeceQm2W9a/bGK45SMHVJahxaq5nAbA6g60WfRE0+SKzMLA+Omzqcprigs34Ir
         miXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161103; x=1755765903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYJNHNsyuuYBBv1uPrAiNz0Qv3N2mB6wq1CNl2jnaSw=;
        b=LaD3e3l55kBUsN1C/8lItMvrDpgc2oBSKxU9uo/ofm35yJYQQOIY1Fu6/vELoRUsuC
         EMl4d8uyWPnBqacKD5qE9dBY4TPoJLiLWst56RZBjkhDBiZeZzFeoKYLpSl5E/zct2Uf
         moiVz02yMi4Q5sypUpEDQTJdfvgLqigN4m6jsk7o1jWyaBB8MY7Tn69JNtLgaAj4StgH
         +M5n5MbeZwRXQzondwN/AQtwywaAPb3AERr3tJwiuazwkoRAjGdD7gRS2pgB0e8+Rtki
         YMsId11igYQnd4nwnAx4gysAWx9VLq0BVI0EhW1VZzAlS/u9TQUAyy0jthtMJnXnzcuk
         P64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCxqJuwJwu84mCOs+m371G6eQlG+8gEDvy4D1hFNrYNbHy+i2R49bR3VqEH1xZ5VoZT+Gzx1grtZbL4NlC@vger.kernel.org, AJvYcCVRBTvdpX2tW35sL9Xjnj/dHoBulb4KD/yMd3SiK9p1XRLvvhVxykmZ6AGueOdbsezLu1nPwQZ63jok8gr2hQ==@vger.kernel.org, AJvYcCXdwNNIVR1kVngdN+O+D0LIxYnfLzp4xIUMYONixk584X6ejHGABrf/1S6F3HZA2wHZTF0LbIravmHrh7gR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9jPtPalItbqgXSMgTWJD5di2BGMwcuEpTxzqjYl1jYo1IiBdc
	nTTY1wtYFiL5THNCDK7EKJ5tHq8G9XbtEtjpKT8fI79xqMnHllJMPW2kjU1qD366fJX7CMhujyf
	NLHank1rw9AvNBL1p8zgDfXCYigW9z4U=
X-Gm-Gg: ASbGnctgE7o5ycylT3/VICsXnwSPBFrPUwe+dJfSXl8g/wDqZGLygLpr3VmLupzgL9N
	e2PO7DtjT9ol2BcGaBtNzFsekh6Z0c39jiwOhL1kvQaE3qCwzzLn3xyYNd67aE6Tep8uhCePzUJ
	E1h6OikMSxuBLg5UkiXEpqZujk+D72lgucmMkj4EGQ27Jjo2+oryF8ZrCup91v2+Q8XiC90A0Zz
	74tMcc=
X-Google-Smtp-Source: AGHT+IED8T4lGIr3XBwn+rDYu37L+rQPjk8mJsBqCCcbjUvIdGd0rYEOqkLoxX/tb73gyEtV4gXB9RscYwa/XOI8xMQ=
X-Received: by 2002:a50:cc81:0:b0:618:150e:7f3e with SMTP id
 4fb4d7f45d1cf-618919b584amr1201591a12.22.1755161102471; Thu, 14 Aug 2025
 01:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-9-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-9-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 10:44:51 +0200
X-Gm-Features: Ac12FXznxloeoD2GxuVcDCMTO71nnDt0KiG-wsDggqz_qDIkKbDcUL54QuPhn2E
Message-ID: <CAOQ4uxjbCN6NGmDECFRKK_1Auq7RTfT+ZmVfVxgatMVav1EfAA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] ovl: Allow case-insensitive lookup
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This last commit title should be like the title you gave patch 1:

ovl: Support mounting case-insensitive enabled layers

Because this is the commit that de-facto enabled the feature,
which is why I also asked to move the ovl_dentry_weird() change to this com=
mit.

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Drop the restriction for casefold dentries lookup to enable support for
> case-insensitive filesystems in overlayfs.
>
> Support case-insensitive filesystems

This is a problematic terminology
Please use the word "layers" instead of "filesystems" because casefolding i=
s
not enabled at  the filesystem level. Could also say "subtrees"

Same for the rest of the commit messages, e.g.

"ovl: Prepare for mounting case-insensitive enabled layers"


Thanks,
Amir.


> with the condition that they should
> be uniformly enabled across the stack and the layers (i.e. if the root
> mount dir has casefold enabled, so should all the dirs bellow for every
> layer).
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> Changes from v3:
> - New patch, splited from the patch that creates ofs->casefold
> ---
>  fs/overlayfs/namei.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 76d6248b625e7c58e09685e421aef616aadea40a..e93bcc5727bcafdc18a499b47=
a7609fd41ecaec8 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -239,13 +239,14 @@ static int ovl_lookup_single(struct dentry *base, s=
truct ovl_lookup_data *d,
>         char val;
>
>         /*
> -        * We allow filesystems that are case-folding capable but deny co=
mposing
> -        * ovl stack from case-folded directories. If someone has enabled=
 case
> -        * folding on a directory on underlying layer, the warranty of th=
e ovl
> -        * stack is voided.
> +        * We allow filesystems that are case-folding capable as long as =
the
> +        * layers are consistently enabled in the stack, enabled for ever=
y dir
> +        * or disabled in all dirs. If someone has modified case folding =
on a
> +        * directory on underlying layer, the warranty of the ovl stack i=
s
> +        * voided.
>          */
> -       if (ovl_dentry_casefolded(base)) {
> -               warn =3D "case folded parent";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(base)) {
> +               warn =3D "parent wrong casefold";
>                 err =3D -ESTALE;
>                 goto out_warn;
>         }
> @@ -259,8 +260,8 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ovl_dentry_casefolded(this)) {
> -               warn =3D "case folded child";
> +       if (ofs->casefold !=3D ovl_dentry_casefolded(this)) {
> +               warn =3D "child wrong casefold";
>                 err =3D -EREMOTE;
>                 goto out_warn;
>         }
>
> --
> 2.50.1
>

