Return-Path: <linux-fsdevel+bounces-40825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB1A27DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B77A2B4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898121A45D;
	Tue,  4 Feb 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyWqDN3O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1552B9BB;
	Tue,  4 Feb 2025 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705618; cv=none; b=lcp4z9UkRZ2L/1DLzc4mVGGMNwuXD84XGz4oxE0XJXMC/yFCHQ8PIDODzwTwDmKFkqaW4yC+bwjEmm5ZP2//AkCkb4qdnHEAbJ4T6x/87Olcw0E/xDsIrQgGMVMV3wSjTvfYUXhiKcH2MtAmZlnHSDvlnx+o4rQ7/aZ5QW8H1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705618; c=relaxed/simple;
	bh=JjhuPkKNcjzAnfKQTHVScZupTpgy7iGo2qUuEmzt6VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+0Ot/S1toclAZmPwmI8TDMVwQBcXOh00VpwlgOUnqioUjXDXMdYSQyA+DR0c/wZYgAaHvzbVs/1YDNHa2+zky1RZG4WpbSAXD9MLiVCWCTY1Vhvf6gEl0PfdQiwpoUWqQLVzN1tOkZAo0cfZBXyp2qb63RPzued5y/PqUl+8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyWqDN3O; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso398112a12.1;
        Tue, 04 Feb 2025 13:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738705614; x=1739310414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCs/stC+vilf+cOlw+yPA6998K6fgcOyKITvHgatZ44=;
        b=KyWqDN3OZg4BPJaxnNQC3e0ifHD6sKvSS0d8VnVZhxfr/GCweWlzCasSNgSxrAoc7o
         YslQYofowrz16PKIedh0l0oUb2YouLsZ0KCkXLQFju+z6+VkTWpQNO3mxI/m6JnBeAwZ
         9pdzo/fAccPRReYfvnD5M55FMt9pIIx5gAjKApwP1LntdDG5jslG3FiISSQ2pCQ/6q77
         6qAhhQKzvk4TGm8PVNEqypqO+/N/ptEfqSagkLN+e1au1jLHJlaSIbWtfg0OQYkrKq89
         lPtOwHNmvdkCd1Y8wLztTLw+yZvh1yBzLln69r0a6MQ/fviThadRphHmf6xklTaMCqbv
         HbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738705614; x=1739310414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCs/stC+vilf+cOlw+yPA6998K6fgcOyKITvHgatZ44=;
        b=SiVUs9h3ItMrHefW9WkE+xf7RRE+bDnGrUaABWlZfS6xQs4lzkkfV38u77uq2wywcC
         7OgHy2XP0Jv1sWI6PeJJKeeL0uQ01ArVuVDps5aLtC8/Ug08zGgTGaJuU6nhZg+BA35d
         zKuO6e/X2J+VztZuVhOhDoVOKHAVmuVRllQwUlJZXo/SuvGEBR3GNw6eC5zepsnBTBnX
         Y6rgngPBTxVPwb6kDTa4fi8damr+jtxRGRLPd1pPPqz02wwwISsfMLAA9rE1CqQoRUI5
         w8PdqzXt8Ny21aMOtmyN8Cv3Jpbu7pYzGhPtzwsL3B1WOLUa1ewuZco9ggst7TidGKFc
         KQlw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqdeFV2OqsLYxCsdh4ykHfa6V/wRrBHUnVDmasMbaNC5saA+STrTLi9iE8fubEOkmhg+6B7U4hoBpdD9J@vger.kernel.org, AJvYcCW6XFLQAnSpdf2tUBGOQxr/+byIgjo0R2W+J/uxfKszjtkSbhjhJwDAooe5YTvB8DMaeo6pHxM7B4BbimxP@vger.kernel.org
X-Gm-Message-State: AOJu0YxUVPE8Sh9Xyz6vghRNmhYW27dGjut8OGCaDTzgvvgwSToKNajH
	zhBRYScm2L3FYrq0cDfH+riL6vfR7VXRU3Y/FAuL26C64A/bXm7Rpfz7qtRU1UO6WbWZ4nin5CW
	w8fCqgtZsmw6XrWX84lv7i+2WUBs=
X-Gm-Gg: ASbGncs7aIFyq4MdaOjCzkzH0bmj3Gj6u9A4ItFcxKMpscQWGWi9Eq2VxTKP6s9epVi
	mpIAg5hqkl6rFeSg9W3T+2wnI7FuhkTiOJpjDDxvlOIQAZY/WOBzRUdmGGQPGbVdP9tMtt2Q=
X-Google-Smtp-Source: AGHT+IGNjNeztA1P1gJGuOIV4wo/4rJUriwiaXy8pMVRqVuY0kPZIqQ1GtgdjiFY3UVJ2xwi4cjh6FIIEPAwbyhxrAg=
X-Received: by 2002:a05:6402:1cc1:b0:5d3:eb50:4e33 with SMTP id
 4fb4d7f45d1cf-5dcc14a5279mr4464184a12.5.1738705614409; Tue, 04 Feb 2025
 13:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213207.337980-1-mjguzik@gmail.com>
In-Reply-To: <20250204213207.337980-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Feb 2025 22:46:42 +0100
X-Gm-Features: AWEUYZkMl_cq9jGPNH4z9dP8zuBMScbdulmIVCzPaTWmepncdZfjxqUjx-6BlzE
Message-ID: <CAGudoHEcCetJSE6rEquEOKAsWhZXKL+32JbdtVUcfYgRP_GuFg@mail.gmail.com>
Subject: Re: [PATCH] vfs: sanity check the length passed to inode_set_cached_link()
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:32=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> This costs a strlen() call when instatianating a symlink.
>
> Preferably it would be hidden behind VFS_WARN_ON (or compatible), but
> there is no such facility at the moment. With the facility in place the
> call can be patched out in production kernels.
>
> In the meantime, since the cost is being paid unconditionally, use the
> result to a fixup the bad caller.
>
> This is not expected to persist in the long run (tm).
>
> Sample splat:
> bad length passed for symlink [/tmp/syz-imagegen43743633/file0/file0] (go=
t 131109, expected 37)
> [rest of WARN blurp goes here]
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> This has a side effect of working around the panic reported in:
> https://lore.kernel.org/all/67a1e1f4.050a0220.163cdc.0063.GAE@google.com/
>
> I'm confident this merely exposed a bug in ext4, see:
> https://lore.kernel.org/all/CAGudoHEv+Diti3r0x9VmF5ixgRVKk4trYnX_skVJNkQo=
TMaDHg@mail.gmail.com/#t
>
> Nonethelss, should help catch future problems.
>
>  include/linux/fs.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index be3ad155ec9f..1437a3323731 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -791,6 +791,19 @@ struct inode {
>
>  static inline void inode_set_cached_link(struct inode *inode, char *link=
, int linklen)
>  {
> +       int testlen;
> +
> +       /*
> +        * TODO: patch it into a debug-only check if relevant macros show=
 up.
> +        * In the meantime, since we are suffering strlen even on product=
ion kernels
> +        * to find the right length, do a fixup if the wrong value got pa=
ssed.
> +        */
> +       testlen =3D strlen(link);
> +       if (testlen !=3D linklen) {
> +               WARN_ONCE(1, "bad length passed for symlink [%s] (got %d,=
 expected %d)",
> +                         link, linklen, testlen);

I just remembered that path_noexec thing got a CVE.

I suspect someone may try to assign one here for user-mountable disk
images triggering this warn.

Can be patched to "printk_once", but then it does not implicitly tell
which fs is messing up due to lack of a backtrace.

> +               linklen =3D testlen;
> +       }
>         inode->i_link =3D link;
>         inode->i_linklen =3D linklen;
>         inode->i_opflags |=3D IOP_CACHED_LINK;
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

