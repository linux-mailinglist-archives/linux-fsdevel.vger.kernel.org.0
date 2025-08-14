Return-Path: <linux-fsdevel+bounces-57878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8DB2653A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1EC7BF446
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6302FCC09;
	Thu, 14 Aug 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKsC7ERx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902631F582A;
	Thu, 14 Aug 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173899; cv=none; b=XlAwzHb5VAQdmWtO8RAMXdrIrDzXtO1AqVUZxLsgOxUQUTfp/eLHmAy9ZGdSoKm53hzJjFRvaTZMstpCoVJiFVsi2zSvfG6gtTmNXmlZHuQtixzUxQTpxkyjB2/NuH6DFUF9i88EgdMLgdoPYXgd2YyY+A74PNclxLWzYMS0dVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173899; c=relaxed/simple;
	bh=rG65okKoFpgh0ntBtWkN4bBGiZib+OQ9PCjDIPdhNNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcxjUaraE3Vmrg+w4h1stvA/6wwqdzmBhlxtWB1fIAqB00YSrq0PCVt4/vkwcvIgRmha7au7VQA0kmpEnon9RjnwkmM2lgARQ3HgOraf0mD1k4I60Um4dbYnTfyJnDO9idtZVFxtA2HKh4AYXX7hnoF6Wrc7+xhXGmCOT3/MYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKsC7ERx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b656159so1412380a12.1;
        Thu, 14 Aug 2025 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755173895; x=1755778695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9CxANSd8rSrynYMla6NC0InsSWgkTj6hq+rmg4nZc8=;
        b=iKsC7ERxisSdavqZy2KqngvLKb2UegPb8ylfYJRksrmkolHG5YuPz93P2TT1LH/laf
         SPtQPSwkE+HeaP2W3TrrODuMHVHMCOy78z3BROk+rCD7rnf3l+BVg/febK3srySVH6Ml
         F/isTu77wVrGms/Pn2DBCzLm3e6uSWB/N7TlJ2mhlRacG2zHLwhgGuKgRaKNEPCjRBrA
         /XeJO99d7PrukjNYRTnZKIZfoxex5KIDzbm/NiilUR3pHJq2ylGkcZDF/+wGxjr5WesM
         j2Dw8/hybSUHXp90l7Ui3tkPsqKC6cTAR6O9e6GLvxGAFu0ibLUNo9NQyFJrMkGTkQoV
         Ah3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755173895; x=1755778695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9CxANSd8rSrynYMla6NC0InsSWgkTj6hq+rmg4nZc8=;
        b=SboghADZ49awys20t2AtGebJ9L4LZOLgowdmjyvqsT3w1w9bRPZ66F2NM1R6MzbxEk
         x7AleCkRVxU2aZKpa5wTPcOrhHDt5CstkLAUsoSTSNnIM+scdNkFccd/c4iBC9VNfa6j
         77dn803Ngl2/YKthNFF2JFMHzVkWMTwXwkcfDk10OJYg93xQT3o3pzwIp+1mNMWHHeaQ
         ZGiAmPLt4gGYMwgniUh9gHvoTusMuL1HxUmtEbJpqyNE9WLMFLZsW8/JmnrQyrPAHbfp
         VScazzzcPk98Zke0/cXJRCtEPe2NNVHjRKPv4cKHEzyJfBoGiIoTvVk7+ltT7THj+kl2
         i/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVGFRftsUZxnaE9RdVgFs9CS9T4XFZnmQta3CMUSwT9YRnUL6XPJvep1aSljTrZoWEgrSsEyieEBrJsYDqG@vger.kernel.org, AJvYcCWR3ElBG2F80TZKwNmA5ciqrQ5R0nwS/mfcyIp1ycHuL46SFwTLHctWKpweIECLCFTb+1AITrk+pj8mYXCOCg==@vger.kernel.org, AJvYcCXBukNRPz+DKLvxn/28VV0qJjSzxaVgMxn/bzFWBaFUUHKu7wdzpZwex9LOJNP6V57f/Sgny2/fMiQ7KHcp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ifgncCHLbCA0GlFil8OJyVNKrZPj0icu7sllDIdinYkaYSoR
	onGGl15eUk+uOitTucaRPXb0tYBaG3hJf7uabinszaLCXDZZgg/FaU47GPm/eioFXsz2JlPI+GD
	SdKDzCVk+GSVuuQZY2oANCAxYlYYqV1w=
X-Gm-Gg: ASbGncuYOQ5XLnPwB+IWOpH/wrO+nQfUV5MYLGRGSV4/yU7VG5yerSugJfsvKY+hNF5
	Zx7KCyQSMd7s5ytpLDx3HnLf3dWhSIB9mXhcCUEaod3o8yKmafwcC3cvaV3jxsxVB1ybPDOzoFm
	Zpl7mhj4cTVB+zXXDSdTENpXHHW0WkW+WHCCAl7570aJ/xULjg7e9vcuXWYoI+1Zu0TjN/Ab0Ut
	Trtg3k=
X-Google-Smtp-Source: AGHT+IEauU8m2BdtqSKmNgRpfLNxmaeRfuSlppvxj9GEgCH+4HabNXlJVBqLmqFcwSAAKZ+8c4xXI01A6oExeUK0ajU=
X-Received: by 2002:a17:907:3da8:b0:ad8:ae51:d16 with SMTP id
 a640c23a62f3a-afcb98cd783mr256792766b.55.1755173894576; Thu, 14 Aug 2025
 05:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com> <20250813-tonyk-overlayfs-v4-2-357ccf2e12ad@igalia.com>
In-Reply-To: <20250813-tonyk-overlayfs-v4-2-357ccf2e12ad@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 14:18:03 +0200
X-Gm-Features: Ac12FXxbk9H0i4frjkJeXJZqsXYusQRvkC2xQmgn1gjQTaFrhgoeS-2KekTmvwk
Message-ID: <CAOQ4uxjKoBbyUNR=1yOdb2fy9iZjReWkF7y7nmFivXORH1F=gQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] fs: Create new helper sb_encoding()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:37=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Filesystems that need to deal with the super block encoding need to use
> a if IS_ENABLED(CONFIG_UNICODE) around it because this struct member is
> not declared otherwise. In order to move this if/endif guards outside of
> the filesytem code and make it simpler, create a new function that
> returns the s_encoding member of struct super_block if Unicode is
> enabled, and return NULL otherwise.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Andre,

I know I suggested starting the series with ofs->casefold patch,
but I meant the ovl patches series.

The two vfs helper patches should come before the ovl patches,
because Christian might prefer to carry them separately via vfs tree.

Thanks,
Amir.

> ---
> Changes from v3:
> - New patch
> ---
>  include/linux/fs.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 796319914b0a063642c2bd0c0140697a0eb651f6..20102d81e18a59d5daaed0685=
5d1f168979b4fa7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3739,15 +3739,20 @@ static inline bool generic_ci_validate_strict_nam=
e(struct inode *dir, struct qst
>  }
>  #endif
>
> -static inline bool sb_has_encoding(const struct super_block *sb)
> +static inline struct unicode_map *sb_encoding(const struct super_block *=
sb)
>  {
>  #if IS_ENABLED(CONFIG_UNICODE)
> -       return !!sb->s_encoding;
> +       return sb->s_encoding;
>  #else
> -       return false;
> +       return NULL;
>  #endif
>  }
>
> +static inline bool sb_has_encoding(const struct super_block *sb)
> +{
> +       return !!sb_encoding(sb);
> +}
> +
>  int may_setattr(struct mnt_idmap *idmap, struct inode *inode,
>                 unsigned int ia_valid);
>  int setattr_prepare(struct mnt_idmap *, struct dentry *, struct iattr *)=
;
>
> --
> 2.50.1
>

