Return-Path: <linux-fsdevel+bounces-58882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A06B32810
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDE6AC72B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39FA23C509;
	Sat, 23 Aug 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOZsMpcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40B1F2C45;
	Sat, 23 Aug 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755943373; cv=none; b=O2PfJ8EXOu8eSGt2vgGz2J2+ZC1RgZ8jU3NuxAIX+M3qPOlkf8ZmMb8Z3ZQRf8ItsG2pN827wk+vRWSRjfL2XasVEhTgWjGMYAl9kZyv5x37gOZCESz8pmbdc4+qy8JD4Zi6s+vQIQcv7u07np2TUmpztAIx0a3FbN12gMSe7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755943373; c=relaxed/simple;
	bh=7V+riBu/TSWMv7su8MopPg5UAPNiviKLlZcwADamPos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4b7EsHEP4quyTE3OWN64QMOXL2MIYVO8m4qD2IwkFtt8axdPVeFE4UwRpWz2KiA64rPjsNCly63upWWxKNbPg/CfksLqUUzUAXjm/pWcQ/UNveQ+oVWaqWslt1yZ8TPTxMGDqfrWW3dhC8T1Ab6tAlC/SZnonqm0PTOb92f/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOZsMpcG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61c325a4d83so846754a12.0;
        Sat, 23 Aug 2025 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755943370; x=1756548170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0ZKn4qQ49gFDS9dc5vaF+XJg9oDHte3UNoENZ55Hu4=;
        b=FOZsMpcG1Av26frHeq2w6hqLbSZz/3lbOQbXqJAmc+p0v7cSxQ0XQQZLzaHRojdD6R
         c91tMg8h5oabghxDE4jcfm3Mmh83mRMPAyGPIG32OdcDXqDbCnGaSPWfGiX2bklYI3VC
         3v9kYDkaKIQcg4el8nfLpf1AipdJtWWaTO51HN507sMsoLZVWoXSjgfgn1x/9l0exueJ
         s2/qnvfpF3mJDho8d9EFPyItpQmBfwRnRtgwTikHZD25pb2nl7XOYpFEKbeUmNHn0s0r
         8aBuR0srdm93eeJWnCvUhJnni9W6/iobLjV/acj4aLbzz1nA2beo6DyWk69y6hXJV2il
         +UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755943370; x=1756548170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0ZKn4qQ49gFDS9dc5vaF+XJg9oDHte3UNoENZ55Hu4=;
        b=uBI1gNUseTpiD8UUPAF2nJ+14kxfSM+SV9HYz+j0qhmiqXDq4zaMGE4r0T5/h6H2Kr
         A83+QH/nWWUemVlIrdqYRTYuU1ODfNjvIijCyLkw3il5yM2DZJL4CqZzmZ/iS4Eoxgko
         1/wzOtY2LeHWX60S15tVLChPxCpsSdIJjX5TiCRqtEe/t7W5hCMel29Th1mTskU0KsB+
         sk/jLQ+wkYQ21h51MAt/ZSc8WgKvw8v5WFXfgfZfNkYCQEufrsl3xDrWAYbtVgztDinl
         e7TyHn1kPe4ByifnuPwYJgzGgCOTYjhxybNUNqHCGF6qOV/y6Hn8/NfIO54JY0fYAzqN
         vx0g==
X-Forwarded-Encrypted: i=1; AJvYcCVYP9DbGQZMnDDykkRZFmh6vNaftaU9isyF9qQk4ZLmV70wZuxDotD++siwvWye51fJIbdOPmPBs8fxERr0@vger.kernel.org, AJvYcCWFLB5Fs+lKWwK6QgCwE2t7vhNnhxAR+Q8m//cU5YOxaZE7Xg2ctFlcYG24q+da8vTQFky39iBbcBKvJtTV@vger.kernel.org, AJvYcCWgTKn4o1FaO3sY7tQlxrlsxmeFDrxaIO4vWXHkt2qC6Mb9cDkFiYIqKSVROgtTz+vSfNGoPTuecjGnczzgLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZEjaOqcoiwZxoBjX7n0yrAIKshTx2tGJnrJww1c6QW+Z+bTi6
	lUMCWMz8ITGp2T2/g6CL1YJMRdEhdede28vWoZPG0HGh+ouS2KV2V++jowQH7wnpczZkn5kB8Ta
	ArBf3k3xzs2RYeTqiAy/YTGmjxGQ9GOI=
X-Gm-Gg: ASbGncsr0MbZocKivkV/L+7n1wW6anWoqH3usTq5WIAZZEZx8x8GlGmzEVetjel8IFZ
	eljstKl23UFJsNOa9BU7WJfntKa6vwj0oSbvTTgneDQY5qPq5QlvdydEkYesLKn4kT+z7zlvK6+
	TVv1ofjvTJe7BK2toURZauejZ+n8C+12IwKjDWSKeW1/Y5J/Fh3FDOYF8r6RPkRIZi3GJO1lVpr
	VtiosMeXyS1SaSqWA==
X-Google-Smtp-Source: AGHT+IGueSDVfR8eJHyiBOfKvqb5OZh+6j+LyzHYKOTPDC4Lgyc4CzAt29Eso4AG2gaSNLnFDcx6p6g4+98YgsocFl0=
X-Received: by 2002:a05:6402:26cb:b0:61a:89aa:8d16 with SMTP id
 4fb4d7f45d1cf-61c1b4f8650mr5425039a12.23.1755943369647; Sat, 23 Aug 2025
 03:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com> <20250822-tonyk-overlayfs-v6-2-8b6e9e604fa2@igalia.com>
In-Reply-To: <20250822-tonyk-overlayfs-v6-2-8b6e9e604fa2@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Aug 2025 12:02:38 +0200
X-Gm-Features: Ac12FXyINJJg90278Mh_WCb6o_3c6fPm-nNtHCmRYx1ro6IP3nRWY_W0jN26xe0
Message-ID: <CAOQ4uxjjjYy2eg14J_267R5x+un_zGRNdESYjbRve4TYBb5sCw@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] fs: Create sb_same_encoding() helper
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Christian Brauner <brauner@kernel.org>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 4:17=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> For cases where a file lookup can look in different filesystems (like in
> overlayfs), both super blocks must have the same encoding and the same
> flags. To help with that, create a sb_same_encoding() function.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  include/linux/fs.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a4d353a871b094b562a87ddcffe8336a26c5a3e2..7de9e1e4839a2726f4355ddf2=
0b9babb74cc9681 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3747,6 +3747,24 @@ static inline bool sb_has_encoding(const struct su=
per_block *sb)
>         return !!sb_encoding(sb);
>  }
>
> +/*
> + * Compare if two super blocks have the same encoding and flags
> + */
> +static inline bool sb_same_encoding(const struct super_block *sb1,
> +                                   const struct super_block *sb2)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +       if (sb1->s_encoding =3D=3D sb2->s_encoding)
> +               return true;
> +
> +       return (sb1->s_encoding && sb2->s_encoding &&
> +              (sb1->s_encoding->version =3D=3D sb2->s_encoding->version)=
 &&
> +              (sb1->s_encoding_flags =3D=3D sb2->s_encoding_flags));
> +#else
> +       return true;
> +#endif
> +}
> +
>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>                 unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *)=
;
>

Christian,

I am planning to stage this series for v6.18 [1].
I think it would be better to avoid splitting the two minor vfs helpers
in first two patches from this series into a stable vfs branch and
would be better to get you RVB on the two vfs patches and let them
go upstream via the ovl tree.

WDYT?

Gabriel,

It would be great if you could also provide RVB for the vfs helpers
and of course, review for the entire series would be most welcome as well.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20250822-tonyk-overlayfs-v6-0-8b6=
e9e604fa2@igalia.com/

