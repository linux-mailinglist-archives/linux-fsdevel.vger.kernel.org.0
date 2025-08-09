Return-Path: <linux-fsdevel+bounces-57166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93DB1F3AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 11:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5EA1C22A47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868127FB3A;
	Sat,  9 Aug 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5GamyQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DC1F3BB5;
	Sat,  9 Aug 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754731093; cv=none; b=lyzyqf73Mqdqz24uNYLBW0do19FDULl1DlbbhiEeL6Novbjdh5PyZaZaK+/u5yuqMwtIn2GZD1e8OKBXvAzNLGRVYGrWEsdee4dBGG4Ci6wZgVf/v3xlNcTxOHmDbqA47ljPsjjnETAxDkfqj6GUBd3Nl3nMGOA1YQBwCTJZm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754731093; c=relaxed/simple;
	bh=gtSkMso/o/GfAYvjSW3Od/adSsCyuPRvcnBMFZRwZEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxT9tdxQmzOWkelyhX5lvUhvIDpY45QWJyVkhQC9l+SCxmfbyyA8LYD3UMUCmI3g9sXC0pxqI80tIYMrHxrOP0U1Ym0xk/iTdef3itvtEDKJcp9tPP7fcq/DQTxr2vVpQ2GTbKqe5WCyWT7bx7rkejhVapW0HAL/KLNBluuUXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5GamyQX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adfb562266cso403536366b.0;
        Sat, 09 Aug 2025 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754731089; x=1755335889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLioedDZ6s8OvScXkSFc7rQMQaBQ5wXltVrCPHP7G0Q=;
        b=h5GamyQXzSokKVG/K6+iFd2u/w+yNucxc8EI5N69vAWQ14CCK0Gq05KiVBMYoTdRti
         NSOZhUwNmSJpOyifBtCxKX/Y+HPGlrK7HVxtBuI3ftIRmWnatLo5LnAInYrb/y0Iv6mV
         dWcUF5sVwavvMk9wfaJg4vc/Fk8ulBKN0UkV3cd346WPWpetxCDjNr6+e7ICmoGMPrcY
         34R8WEMnUscll3r56rreonYHxdThBhi2y5BgAXyBqnzr51ueQ1nd1Ybbn00qWhTe7RQc
         qo0h4b7Sf8I4gWEgsbX2kb7NW0hWP7kZq+tLugSo2oEJu2WcNBOV7cjo89jwapTpK24h
         I1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754731089; x=1755335889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLioedDZ6s8OvScXkSFc7rQMQaBQ5wXltVrCPHP7G0Q=;
        b=OQ8eRSiLm3xmIzx3pQ7hbtvellcFzZUui9FEoxnd9260MJoVLmi2l42fkWizQzR68S
         zizXiQVGmQp8eqckqTPxJUnyrtN9rxcahlGxTLzzlqpQfjljxHvh61GCSxyDpmHHsJIm
         n94nxUiBZdiuca/byrZtMZJJxOb7JENzwS6GjUvCfDkHpPooQyhl+AE5IGUp3gnMhdiP
         jksrwSsYCHEgRPNh3O8Dgq/If0Rjj2qdVHNOE+mfKpkLiGTAVQ6c3le7G1ErILr53g/h
         MQ/+AehthBpPqX8mVi817WXfygMhQjaOYM+EBH4SGsGBlJAdu8W8AnfTUApgkC+CSEeQ
         ChqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+HXT2YnqrLZTBJD9LxtMwmZ6mVGX9CGYdPOKPFbjlbpKOrwsE6WQlJEo2I6aJEeGkz6NMUkkmEbrMg+tLsA==@vger.kernel.org, AJvYcCVG170QkMZkRgrEpqgpaCuySn6vgQqAiGlLgGdBMdkjvPRq6Zrn1tgNMrg7GrUOtuGSyNaidaD4BnY2Kixb@vger.kernel.org, AJvYcCXdsCiqvV/7Fs/HBNrcSapt5HrNLC/FmPMvllK+ZrE62+Qtvt6SMnPFcotQ9cZO8Rgwjr6KNn+EMN++H2sa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UBy8j0sRgWOokb9YaanS2pjENmrnFliDuPltiPb+7ZE+yN6e
	FBpa25a1e3G2v6hYCjCMtg+evomsUA0nTZUQql7NyM/R1yDCAO03lZIinvEyiiW7bx3HE1WlSln
	q59W21CURva8UM3oJBjzLXo2GEchu0+c=
X-Gm-Gg: ASbGnctflLrfPwJQw3lRQdxqKMwytGufsTNK4jo7T+pUA1LaUb7JbWUDQec8qk+9baY
	TDCtW7QT6mmGunQMACrgfahJYeiG2fyoOcsXvOvFcwufUc0F7CP3dYBHk7HbbOqqWkKJjB+OzBA
	3yE7awbUkPbU734rU5YCfFAg/0wRQkEznwLnK1TDWEka5HNxdRiaAwHyjazbTKN7elPpwmJ0cyg
	o9vfOE=
X-Google-Smtp-Source: AGHT+IF4W5MakFaKE4MYw2hiiCbAxpJ6gfkigkfSISNCbAWZlQgbenoNQXP1SGbzOukUvN5IBTSyaJTYRVhE9P27WRE=
X-Received: by 2002:a17:907:1c28:b0:af9:885e:d36c with SMTP id
 a640c23a62f3a-af9c6501598mr550701766b.51.1754731088688; Sat, 09 Aug 2025
 02:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 9 Aug 2025 11:17:57 +0200
X-Gm-Features: Ac12FXyaYf5mm6Hcb-gDBw3kHvz3IDxUAgcdNvwXRkcFmzVxV4p_t_qz7CWGLxg
Message-ID: <CAOQ4uxgPiANxXsfnga-oa1ccx3KKc1qeVWLkyv=PPczY-m9zhg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/7] ovl: Enable support for casefold filesystems
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 10:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Hi all,
>
> We would like to support the usage of casefold filesystems with
> overlayfs to be used with container tools. This use case requires a
> simple setup, where every layer will have the same encoding setting
> (i.e. Unicode version and flags), using one upper and one lower layer.
>
> * Implementation
>
> When merge layers, ovl uses a red-black tree to check if a given dentry
> name from a lower layers already exists in the upper layer. For merging
> case-insensitive names, we need to store then in tree casefolded.
> However, when displaying to the user the dentry name, we need to respect
> the name chosen when the file was created (e.g. Picture.PNG, instead of
> picture.png). To achieve this, I create a new field for cache entries
> that stores the casefolded names and a function ovl_strcmp() that uses
> this name for searching the rb_tree. For composing the layer, ovl uses
> the original name, keeping it consistency with whatever name the user
> created.
>
> The rest of the patches are mostly for checking if casefold is being
> consistently used across the layers and dropping the mount restrictions
> that prevented case-insensitive filesystems to be mounted.
>
> Thanks for the feedback!

Hi Andre,

This v3 is getting close.
Still some small details to fix.
With v4, please include a link to fstest so I can test your work.
I already had a draft for the casefold capable and disabled layers
in 6.17 but I did not post it yet.
Decide it would be better to test the final result after your work.
I'd started to adapt the test to the expected behavior for 6.18,
but it's just an untested draft for you to extend:
https://github.com/amir73il/xfstests/commits/ovl-casefold/

Please make sure that you run at least check -overlay -g overlay/quick
sanity check for v4 and that you run check -g casefold,
which should run the new generic test.

>
> ---
> Changes in v3:
> - Rebased on top of vfs-6.18.misc branch
> - Added more guards for casefolding things inside of IS_ENABLED(UNICODE)

There are too many ifdefs in overlayfs c code to my taste.
Need to see how we can reduce them a bit..

Thanks,
Amir.

> - Refactor the strncmp() patch to do a single kmalloc() per rb_tree opera=
tion
> - Instead of casefolding the cache entry name everytime per strncmp(),
>   casefold it once and reuse it for every strncmp().
> - Created ovl_dentry_ci_operations to not override dentry ops set by
>   ovl_dentry_operations
> - Instead of setting encoding just when there's a upper layer, set it
>   for any first layer (ofs->fs[0].sb), regardless of it being upper or
>   not.
> - Rewrote the patch that set inode flags
> - Check if every dentry is consistent with the root dentry regarding
>   casefold
> v2: https://lore.kernel.org/r/20250805-tonyk-overlayfs-v2-0-0e54281da318@=
igalia.com
>
> Changes in v2:
> - Almost a full rewritten from the v1.
> v1: https://lore.kernel.org/lkml/20250409-tonyk-overlayfs-v1-0-3991616fe9=
a3@igalia.com/
>
> ---
> Andr=C3=A9 Almeida (7):
>       ovl: Store casefold name for case-insentive dentries
>       ovl: Create ovl_casefold() to support casefolded strncmp()
>       fs: Create sb_same_encoding() helper
>       ovl: Ensure that all mount points have the same encoding
>       ovl: Set case-insensitive dentry operations for ovl sb
>       ovl: Add S_CASEFOLD as part of the inode flag to be copied
>       ovl: Support case-insensitive lookup
>
>  fs/overlayfs/namei.c     |  17 +++---
>  fs/overlayfs/overlayfs.h |   2 +-
>  fs/overlayfs/ovl_entry.h |   1 +
>  fs/overlayfs/params.c    |   7 +--
>  fs/overlayfs/readdir.c   | 133 +++++++++++++++++++++++++++++++++++++++++=
+-----
>  fs/overlayfs/super.c     |  39 ++++++++++++++
>  fs/overlayfs/util.c      |   8 +--
>  include/linux/fs.h       |  19 +++++++
>  8 files changed, 195 insertions(+), 31 deletions(-)
> ---
> base-commit: 0fdf709a849f773c9b23b0d9fff2a25de056ddd5
> change-id: 20250409-tonyk-overlayfs-591f5e4d407a
>
> Best regards,
> --
> Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>

