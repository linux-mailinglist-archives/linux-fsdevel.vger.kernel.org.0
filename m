Return-Path: <linux-fsdevel+bounces-72807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C565D03E74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC96A3064972
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A23444843;
	Thu,  8 Jan 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxVmBHiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DA442B14
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864516; cv=none; b=D1ceSgCf15glYIZuxmL5o3W+FTFFgDCHyNB/nYcARBgLi0HvxyhKcs806hBISyzfcjbagNuUiWchrSwOPreTwC9cwFAx0grMP/2EDQ6rn2EKN54pAsVn5y3Q/hwKPDts8N+gfb3RY4CRrSEleRF/0KfKbZaYNtq9Pxtg+Upsb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864516; c=relaxed/simple;
	bh=XAh3Wp3Fjr5Yxc70wR2442xvazPUSDriz0UDJwjVrWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utYForUIRscLf/cTpvhnnalW10D/aW/bjUUFsshKQAwr7teaMl6yiJntqZfQ4LE18F4ZIXbnGpN4CDViONNLztYW9yvQd5a72xrXqcYDkzSen4eAyLVcSLbQ/ACARGBjwPJZmtgS9Z3AcXDxj4hfFBOfj9uVwYK1hC3JPNU7wDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxVmBHiS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432d2c7c786so9465f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864504; x=1768469304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VquaFlgo888zFZ/mrAdPrnCm/DE4tEpeWYtftgl80iI=;
        b=ZxVmBHiSR1jqpF31dpoIJJmbnCppOIc7/YtgKwgMGCu7oLRhJaDIs+GbniVH5jFDRx
         dHg0eM82Sd0ltfDmlt6Xk10dKLAMYOUVa3Chuz8TZoapvdJtjq9NVdveq8oWyRgoTpl5
         sXUwP2Am4hrJAFJ5t3BtCZHPIIkzFuoMR4QXGhtYXQpdhw/O/alBST9EpqU8JL5WZNbv
         NLJ05NoGybQafFnulMJfqsRPAUcgGKJ7VsmRRRIdrMDxRcjrEptCU5nwZaayJCFv0KRZ
         1+P0+OeogbdUUeE3A0hG/ayIgrgcOSwtSU2D1YmzMT59ch+qyxUFsjcVUJ1n1r7MkC2G
         HPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864504; x=1768469304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VquaFlgo888zFZ/mrAdPrnCm/DE4tEpeWYtftgl80iI=;
        b=LBQW3TDVPVr4djqDbFiZiRHg2JuTCeL9PTnyKouHzPZKa11s4ONiyPupg8SxKE6dhG
         waU3klJ8IQ9ETxvZdvC3yNgVrodMUZFwO42eO+4It8pqEcqE2sMm4gJtC39vDAncvCxB
         +b88EIQRI4U9TrndsQOcEZRCf8KG64Tl6/SeJdNv2KLB5hW6i0fzHqPcBV576bn3ZNXS
         j1UfrCFS0USQy5w2Dbo0VBGP5iVT6pXpgNC5UINqfhFNRanoxYH+4kBJg8w0pleXgN3k
         XsLVPgodrJWTh1QeuIWr6vlMrHj7Qbdgg64D6jtPEMOWfgwqaoAQ4QmvPKDJ17IEkWJj
         4dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN256yzMZDSZ3Yjr8n0fHwfDBv2b6uLWuH2FlTsctSkb0AJZr/TX64Q4/zxxMcKbxkbbCNJy/qPXCjA3Bo@vger.kernel.org
X-Gm-Message-State: AOJu0YynhH0gQb00s54qG2KE/vX74ulZizic31l6O48rURFaoNhg00Az
	PcRh4mclwpDv90JjEWspYu2wGvlbkf14SDP4ystKwowOHjTs+lWw4AVxTKfmV1t13u1l9LbMCI9
	dwqVnwqg7X3Aw1cBnAqDZ6LSJo6QZNQs=
X-Gm-Gg: AY/fxX4g/D96BWw11fH2gjmrPesr4vz/2zvK3neBTm1NIdQqHWZjkivjwT63qJ2Xn4k
	c6hSu0Kc74K++HMp6bT0nI5c+C8CxzWn1PYMdd6I5L2iWPltSRofR1bhLtB2ZvH90JKjdGFLJ05
	VSVaTMGxo2L+wsaCCjZ1faxR8w6TH2pGo8776D8wYpWhsiGc7OijZ4ptTw/QYAE4HF8W4UEZcag
	6LIh9j60PRYAPaswKmFmeapHw8Bt4oPQLDeEO7ikmbnLm52JCx+247ekx59hDtsQDzOly/S9+L3
	GtU6KpA=
X-Google-Smtp-Source: AGHT+IFxBGDIvKAQDqCu4tFy0rBh9d1EPIGf3v8mEMOIMMFor2CZPGFuumsPbdFh1FIttpjECNN55C7d0N5T0B+FVv0=
X-Received: by 2002:a05:6000:2312:b0:430:f431:c0e0 with SMTP id
 ffacd0b85a97d-432c37bf78dmr4224841f8f.8.1767864503876; Thu, 08 Jan 2026
 01:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com> <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 8 Jan 2026 17:28:12 +0800
X-Gm-Features: AQt7F2qIbpf1nLYZMia2xqWz_GyswXTO8PxjpXWOwik2P1KsOZZD46XvR8aFhag
Message-ID: <CAHJ8P3LMqKYZjmMdSWyKv5EQvWvvycfidJiTi02UUBoEhgtXzQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>, 
	=?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Sheng Yong <shengyong1@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gao Xiang <hsiangkao@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=888=
=E6=97=A5=E5=91=A8=E5=9B=9B 11:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
>
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
>
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
>
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
>
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
>
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
>
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
>
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
>
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-back=
ed mounts")
> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timoth=C3=A9e Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Aleks=C3=A9i Naid=C3=A9nov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1wtYN=
=3Dz0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2->v3 RESEND:
>  - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
>    as pointed out by Sheng Yong (APEX will rely on this);
>
>  - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.
>
>  fs/erofs/super.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..5136cda5972a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
>                  * fs contexts (including its own) due to self-controlled=
 RO
>                  * accesses/contexts and no side-effect changes that need=
 to
>                  * context save & restore so it can reuse the current thr=
ead
> -                * context.  However, it still needs to bump `s_stack_dep=
th` to
> -                * avoid kernel stack overflow from nested filesystems.
> +                * context.
> +                * However, we still need to prevent kernel stack overflo=
w due
> +                * to filesystem nesting: just ensure that s_stack_depth =
is 0
> +                * to disallow mounting EROFS on stacked filesystems.
> +                * Note: s_stack_depth is not incremented here for now, s=
ince
> +                * EROFS is the only fs supporting file-backed mounts for=
 now.
> +                * It MUST change if another fs plans to support them, wh=
ich
> +                * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>                  */
>                 if (erofs_is_fileio_mode(sbi)) {
> -                       sb->s_stack_depth =3D
> -                               file_inode(sbi->dif0.file)->i_sb->s_stack=
_depth + 1;
> -                       if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPT=
H) {
> -                               erofs_err(sb, "maximum fs stacking depth =
exceeded");
> +                       inode =3D file_inode(sbi->dif0.file);
> +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
> +                            !inode->i_sb->s_bdev) ||
> +                           inode->i_sb->s_stack_depth) {
> +                               erofs_err(sb, "file-backed mounts cannot =
be applied to stacked fses");
Hi Xiang
Do we need to print s_stack_depth here to distinguish which specific
problem case it is?
Other LGTM based on my basic test. so

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Thanks=EF=BC=81
>                                 return -ENOTBLK;
>                         }
>                 }
> --
> 2.43.5
>

