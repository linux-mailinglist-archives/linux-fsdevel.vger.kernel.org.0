Return-Path: <linux-fsdevel+bounces-37438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259729F2332
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 11:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5513C16563D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 10:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A214A635;
	Sun, 15 Dec 2024 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAWnGyyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8E139D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259754; cv=none; b=AjmceUpGdRH0j6t5F92E09mSt52YwzmHFgLlhcIkQ67+/RPAEogTPqm9CtfT2MDLANknqpdC+Xrd6U8bBsXsgmVMGrRX2urM64VKsMwTqewzdf9upjeuXxw446FtZoRq4roPryEGbpCikCcjm6+HQFZkzc1Sk6RRXZgd4RWGypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259754; c=relaxed/simple;
	bh=XqDLQTpKYGYEtyw/pCgmSmXvWOXMfeUC0ciBGw9+x7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gefqC1dwDrp1q8sEyuVCFkrXxhzeboJmLoVW1V7JSAXLbrMmzA2EeyyLPML7n4AcZ1CDiiYhz+65Y6hcMMbos90LbyBxsrfa9NCboIZEX4d/Jj4F/OMBQDryHvQ8B/tDw0UOFgkHNu0VuarXbQk5PNnyi5LCMVgEIc4TwbZ5684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAWnGyyo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f006748fd1so24771357b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 02:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734259752; x=1734864552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzRbWRd2aMlKYAfc83gLPIN2ZnuzAs8whbPbbuRN444=;
        b=hAWnGyyomx6IhYYq4E0LVFlyj2X9iJoWpmhkOxixObyKMIg+4A5zqfumvf7Bviib8u
         ajWfEThXxOj8fMaH9fDaxxQEmtygaJaH4thsGFtQeYe3IgOE+QJkp0SZBcBLnB4vr+1i
         8jGg+kyGrn3aqTCmP91aIjoeOhZPUc6xHRIc6UKUN4CkSz8nVOQiNKeOtNe0snwOHjjl
         XaFLzNuGGbUhGA3EoPrBSKV3ac5JF6zou2/J9MolygrQfLsfJ4n0GOEEADzlLiuQja3l
         +mnmo0BNvakaLWylkUIv+qS3oHDmUhlSAv8rynOMs5mljOaUA/XT6W8JlWSKGMy6CPEC
         nUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734259752; x=1734864552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzRbWRd2aMlKYAfc83gLPIN2ZnuzAs8whbPbbuRN444=;
        b=w2Bt4qFwo7q+bCGeN14fPG4MqNHKK1WqAucvnlpeDsJfusNIZww8uyqG1WNIPPYSmE
         LwgL9OJCSiyXkpi/VBZtc0yuuf1ivVYQtf34UkHVBt0a+YOu4ac4vAJ00UQbiVsayFhU
         gqaeu2Ibr06nx/hRlQYBIX3OqRmKwUNIRRovJ7qWoGL/2qSErsCI65odEfQXf57WGRtf
         uuY+oHaWfTJFobQWuQwounD+/jAWBn0+VzOK5K87lbRd8H7Ur5qtKAMghZ4V9yEWT8Kl
         GfJOS8aMlP/F/DJeT4/NAcv/9uUrWEy9f9NlUPD9DUyg9xwEQTj+jncT6pkZjBOMWZmq
         mpNw==
X-Forwarded-Encrypted: i=1; AJvYcCXwgeDB0p8DsBqgPzp7LiQUBCVPZjUVeXSQIGo92JiGL2iS+93nHJ/dfzi+1ZbUXWpZti7CfxNF5p0isojQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLagozV5BJbQFq2/wUoBlSyc85f0d8N1WPX8x2DsE510cNzND
	d0Q1QB3rM7jX28TFtu0VnOGUQCJf5GtINjL4iBZxY364OzwRIwq51gZd5ftIbCh454cK2qUol+T
	vdrkS9xySEieTDJGK3jiDV6Dr8LdoGsni
X-Gm-Gg: ASbGncvrWWjucZ/maejw7Wo8Tgeeu5KbetkMT7JO0F0h9WcF412Ospo3ekDMBXwu2eC
	OvlA5iBH6TiSeYMJOt1pFYMiFASCqYtZ0pTWKFXSiF8sBZfYVxwlGP6ygxPt/cPIUBg4=
X-Google-Smtp-Source: AGHT+IEUGoz26z27Oqqu7Nc91KAOV+BqykFExL9yVma1ox19h8oRqFOMFfXK+UnNZ7EdwPPNU1QriY1LCakSTRyYgyU=
X-Received: by 2002:a05:690c:d8c:b0:6ee:6e71:e6d6 with SMTP id
 00721157ae682-6f279b16651mr74227107b3.23.1734259752092; Sun, 15 Dec 2024
 02:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com> <20241213-fuse_name_max-limit-6-13-v2-2-39fec5253632@ddn.com>
In-Reply-To: <20241213-fuse_name_max-limit-6-13-v2-2-39fec5253632@ddn.com>
From: Shachar Sharon <synarete@gmail.com>
Date: Sun, 15 Dec 2024 12:49:01 +0200
Message-ID: <CAL_uBtfaxW=xd40tyKm_DP_djeZyjgyuggsUcDrw=6vkM-g-7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Large file-names (up to 4095) may cause the encoded input of
FUSE_SYMLINK and FUSE_RENAME to exceed the default value of
FUSE_MIN_READ_BUFFER (8192). Whoever implements such a FUSE
file-system should keep this in mind.

- Shachar.


On Fri, Dec 13, 2024 at 6:02=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> Our file system has a translation capability for S3-to-posix.
> The current value of 1kiB is enough to cover S3 keys, but
> does not allow encoding of %xx escape characters.
> The limit is increased to (PATH_MAX - 1), as we need
> 3 x 1024 and that is close to PATH_MAX (4kB) already.
> -1 is used as the terminating null is not included in the
> length calculation.
>
> Testing large file names was hard with libfuse/example file systems,
> so I created a new memfs that does not have a 255 file name length
> limitation.
> https://github.com/libfuse/libfuse/pull/1077
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/fuse_i.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f286003251564d1235f4d2ca8654d661b..a47a0ba3ccad7d9cbf105fcae=
728712d5721850c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -38,8 +38,8 @@
>  /** Bias for fi->writectr, meaning new writepages must not be sent */
>  #define FUSE_NOWRITE INT_MIN
>
> -/** It could be as large as PATH_MAX, but would that have any uses? */
> -#define FUSE_NAME_MAX 1024
> +/** Maximum length of a filename, not including terminating null */
> +#define FUSE_NAME_MAX (PATH_MAX - 1)
>
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
>
> --
> 2.43.0
>

