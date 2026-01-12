Return-Path: <linux-fsdevel+bounces-73305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB7D14BBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAFB3029E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC8338758F;
	Mon, 12 Jan 2026 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QltbuRlg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819D387341
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241978; cv=none; b=pHkcA8jb1tODt8EXG8p59IwqDatCTiEYYeDsWBff3j4F97geaMg/Eto/gIKmdBm7qEQlNtxu1kCo3/fwEo8Ix0ktzk6NiEBJx5LiXeGyyJco7Bimu7XcEc/Xd6f+fD/za6LsHWGXqGtkoj4AmqSxRYlSbNkWMSFHYf455CtRtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241978; c=relaxed/simple;
	bh=C3qiUMzMEuOjY31SACrrPBvlsaat7CwDfMVqQsdwj0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcYvEBeLOiWxcFremzvpxcmx2Bizt7vNZOeUIsbn7UOYK0ul3dyxIisXhRPO6/F7OrOiVFKeULLq1KWIO/8OK050hFAd42zE1WTAyW19J+6iCJK2d+sWyqxhLvDmsGsNWolQZiGyYY7jA6KhKoQsGvn7d8jU2+HjmNv0cckX/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QltbuRlg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so9588200a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768241975; x=1768846775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fLJ0Lc2iyO44xzPbYFsxlgxWJNnbeNeVFtSI2J+pjM=;
        b=QltbuRlgpIIOgbTTmKYbuQrUknbcpwqSxu3Q7ukNVu9+wNbdqE6LACfYqvQLzQMi4B
         rQB4YSw/Rd8ndBbF2Oe026avOSErBTImZjEHreItuiKjkH5dGPhWKJll0jlvGmudNW3b
         CEDSUrFSv3xtZHKPd/qBsKgZYyBJunZo14KaCq+GS5dgKyuiPckTg3am790TTZSRf1s1
         q2eeMumhWDAOPklmrrMViD2kHmAMvwTtVhBqBdNewLiA+/wLBxJgZQpMxXFozJLHBYWT
         GuI2Z2tnP0WIfki6qoGYNiJduTYVE+aBl3s2xIQVNhIbyX2kVG1hr8UHaVbG9oNl0GzH
         d3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768241975; x=1768846775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fLJ0Lc2iyO44xzPbYFsxlgxWJNnbeNeVFtSI2J+pjM=;
        b=WguEZWWCNZtmbRWUWPT5g8LFOuqJZYC+2tArLITP7LyUXuck/cQSv4+z1Ydx67ME3U
         sYdxqAYHH6Lek253eDln2pdAs65NGwuia0M5BSE1vpThlD5dKq2v9QOW9Iwg6GXgVuOv
         WDvv92oGRK+OUPT+Ymucp8Uqnp+nd4aJtz3A2WPQBKrd3oGQgD9PY8EW3w3ea77XhpgY
         mEyAvdqcgg/3UakKYxVufgacUQ+xTwRYEyLXVxONquw72qmjU8AlnrL6f4hkzM/3oqyK
         w7A1TU9DEimNswV2ZoXanNKlheYHvQO7K+Mp93pDgdtlxQLh8FnFZDNhRy/+nKDnE3+3
         e7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUJfK2R7NQO4cBJSpcdHdRm1sF8nB9SrP8nC6O7bH21wnsAlS+VCmojFHb4Mg/Ii2ND0O1Kfna2yCxr84g@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPl4kU2y/dPPe16lORPhl8Fmvz7+ULzoKZATfpb2OiuC1e1X8
	JLNfLAqfA7cEw5y05fTwXIPGf0Zks3sFc8kVWt2OQZFEwJUsQZhjM1k5fs8CqrXbILxejhh+xW+
	Tfq1aALThXvTnhC1Uu0vSTQv2NloNiX4=
X-Gm-Gg: AY/fxX6jcqz49OuJXEUxn3FcB4HT7fH5zutihXJSHaw4uyqH/ajftlJ4v8rgpy6+0rN
	37gQZV3EtkIxXJPdm4w5NU3hdGvcyMLATrecXzCWOo21OPuYptqnBdxIKkEmSOVenf1jzu7pyZm
	l1D/giGdd/qRd2EhJBh9pLQqecfVo2UgPdeLy1pGQBW8MmZz10hynC/6xp3e6hC9aRE1F/V+p8j
	uXEKlVZM9U0+T2VA20q6ZNiCsKg6OkOs6HunrgPO/VvVx49dPYpNgu+HpsLflB+Sxi/zckooDWw
	Piv8ctbZaQqgbYziiCaavaxiGQ==
X-Google-Smtp-Source: AGHT+IFpZWnjTprZGuoNM7i9rZy5+TnHhXPDyXjqZv3nNIDc4Y60vx+dmcifi+liSYYm1b3xV0rR0DhyEwiVEZRykTI=
X-Received: by 2002:a17:907:25c4:b0:b84:2070:201c with SMTP id
 a640c23a62f3a-b8445420557mr1881707966b.54.1768241974705; Mon, 12 Jan 2026
 10:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112181443.81286-1-ytohnuki@amazon.com>
In-Reply-To: <20260112181443.81286-1-ytohnuki@amazon.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 12 Jan 2026 19:19:21 +0100
X-Gm-Features: AZwV_QhYFMLFdZM1KfHEckVVl2_nOygGiawKK4PBr_YJF3gs8jSf16b9LsqiTr4
Message-ID: <CAGudoHGcOciFD4MeEn-G7DP7vtrig1czi-saqmpB8_oQxvro7A@mail.gmail.com>
Subject: Re: [PATCH v3] fs: improve dump_inode() to safely access inode fields
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 7:14=E2=80=AFPM Yuto Ohnuki <ytohnuki@amazon.com> w=
rote:
>
> Use get_kernel_nofault() to safely access inode and related structures
> (superblock, file_system_type) to avoid crashing when the inode pointer
> is invalid. This allows the same pattern as dump_mapping().
>
> Note: The original access method for i_state and i_count is preserved,
> as get_kernel_nofault() is unnecessary once the inode structure is
> verified accessible.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
> Changes in v3:
> - Avoided pr_warn duplication for long-term maintainability.
> - Changed "invalid inode" to "unreadable inode", and clearly denote the
>   situation where sb is unreadable as suggested by Mateusz Guzik.
> - Added passed reason to all pr_warn outputs.
> - Used %# format specifier for printing hex values, verified to
>   work as expected.
> - Link to v2: https://lore.kernel.org/linux-fsdevel/20260109154019.74717-=
1-ytohnuki@amazon.com/
>
> Changes in v2:
> - Merged NULL inode->i_sb check with invalid sb check as pointed out
>   by Jan Kara.
> - Link to v1: https://lore.kernel.org/linux-fsdevel/20260101165304.34516-=
1-ytohnuki@amazon.com/
> ---
>  fs/inode.c | 47 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 521383223d8a..440ae05f9df5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2984,24 +2984,45 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  EXPORT_SYMBOL(mode_strip_sgid);
>
>  #ifdef CONFIG_DEBUG_VFS
> -/*
> - * Dump an inode.
> - *
> - * TODO: add a proper inode dumping routine, this is a stub to get debug=
 off the
> - * ground.
> +/**
> + * dump_inode - dump an inode.
> + * @inode: inode to dump
> + * @reason: reason for dumping
>   *
> - * TODO: handle getting to fs type with get_kernel_nofault()?
> - * See dump_mapping() above.
> + * If inode is an invalid pointer, we don't want to crash accessing it,
> + * so probe everything depending on it carefully with get_kernel_nofault=
().
>   */
>  void dump_inode(struct inode *inode, const char *reason)
>  {
> -       struct super_block *sb =3D inode->i_sb;
> +       struct super_block *sb;
> +       struct file_system_type *s_type;
> +       const char *fs_name_ptr;
> +       char fs_name[32] =3D {};
> +       umode_t mode;
> +       unsigned short opflags;
> +       unsigned int flags;
> +       unsigned int state;
> +       int count;
> +
> +       if (get_kernel_nofault(sb, &inode->i_sb) ||
> +           get_kernel_nofault(mode, &inode->i_mode) ||
> +           get_kernel_nofault(opflags, &inode->i_opflags) ||
> +           get_kernel_nofault(flags, &inode->i_flags)) {
> +               pr_warn("%s: unreadable inode:%px\n", reason, inode);
> +               return;
> +       }
>
> -       pr_warn("%s encountered for inode %px\n"
> -               "fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count=
 %d\n",
> -               reason, inode, sb->s_type->name, inode->i_mode, inode->i_=
opflags,
> -               inode->i_flags, inode_state_read_once(inode), atomic_read=
(&inode->i_count));
> -}
> +       state =3D inode_state_read_once(inode);
> +       count =3D atomic_read(&inode->i_count);
>
> +       if (!sb ||
> +           get_kernel_nofault(s_type, &sb->s_type) || !s_type ||
> +           get_kernel_nofault(fs_name_ptr, &s_type->name) || !fs_name_pt=
r ||
> +           strncpy_from_kernel_nofault(fs_name, fs_name_ptr, sizeof(fs_n=
ame) - 1) < 0)
> +               strscpy(fs_name, "<unknown, sb unreadable>");
> +
> +       pr_warn("%s: inode:%px fs:%s mode:%ho opflags:%#x flags:%#x state=
:%#x count:%d\n",
> +               reason, inode, fs_name, mode, opflags, flags, state, coun=
t);
> +}
>  EXPORT_SYMBOL(dump_inode);
>  #endif

nice, thank you

Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>

> --
> 2.50.1
>
>
>
>
> Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembou=
rg, R.C.S. Luxembourg B186284
>
> Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlin=
gton Road, Dublin 4, Ireland, branch registration number 908705
>
>
>

