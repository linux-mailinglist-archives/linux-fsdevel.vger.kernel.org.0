Return-Path: <linux-fsdevel+bounces-51954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DFFADDAEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A113A19415F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2423B626;
	Tue, 17 Jun 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl28H49y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C763BBF2;
	Tue, 17 Jun 2025 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182880; cv=none; b=k0dfqnUcq2mi6qpAgoDMi+7LUuGweu+a76VTtlG2SqRiSR86Q04Cb4IkY6zIzMX5bwHJTZ+j4PXfSoYhhCT8VmOWcfqmMVMJ75SH316IlvQUZjsE4jnU5pe9t8IRH4NBJdjP1B4sSdkmU27wY0gwFwzaQt24ckw95R/i+hHpYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182880; c=relaxed/simple;
	bh=bgxfn7vE3uVcZL4Z/4Xgrg5I++5k5UcZdX3exMfLzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ6XKglC8jKqBzjpWSDjVHh45/a9urkJ5Q9jvw8V577n0sqN5D2l4Zr7bqzDVha0OyVvBI/UrFN3dQgySxuyVaq+04NU+cxHL+bWDe85VvlO0MR/aNDdExGbFjr9Nd4mOYooKPZx6XE/cRXxvkQgVftrIkb4G+95UmfbPY1WOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl28H49y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58f79d6e9so74439051cf.2;
        Tue, 17 Jun 2025 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750182878; x=1750787678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTi4WuiI5rSn4d0VdM5D16B62aIH3ZTDCOZvLTT0owQ=;
        b=bl28H49ygnqhyLaSjZSoas5k74rbqyepz5ij3cxt3sdyl6QOwcUbAiENyF7O3fQbzD
         i8rvicdk9RRmmjoujhP+J9Q4A7DOdE23BvRvvvDX9r7TrxzTgXdjMXTgjYXooV+KQr0i
         1N5lXR2j8GA/0OWTdEOnECaHJBdorYYK+SRiMbmRI1MqhhX7eLPE+6LV0cbH6lG/ceeV
         iktbI4L9EbtP2dM3wdpJvtkvT505rACRkVxKH9H73pSpN5jw9KUqB4cQe8GFmrSA5Sq3
         /LZXp/O9STs6XCGcXpXEwJThttvX7n0T/OCy2khD5gtWYyormoN81I8MTOZFvDOPRW8d
         3JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182878; x=1750787678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTi4WuiI5rSn4d0VdM5D16B62aIH3ZTDCOZvLTT0owQ=;
        b=Q4i02eEJvG/8VZhFBMpsqGF2pX3DmyrhLDnpzJf+wj7Setmy8odTnr2vO4KygvokCf
         WNzhMPcYssLu8gyaY4CUdQ9m5s2cMPxFPClMos+YIgTh+x8I0OTtL4Inu51EJe+eNGtr
         mEKXx2WORDk8RLKe7n7Rxt2o+upLLbFXfZhCgDjwf0EV5G6AoWLRIFnJPbRJ0Yhu5j2q
         CX2cpS0zdPxrCCemjpSyCMGveumQOvNKvTHNtGd7S6TrCHWGE7OnQlULYW66fvlrBxa9
         kcMrZ8xybr4bqfPEWz7opS3e6mSUlG90DV/QBPsoN9hK3R1OzMp1s+hzNozTJ3FMjwXP
         9tvw==
X-Forwarded-Encrypted: i=1; AJvYcCUmyg6rDd4NACPSaT7aQ3btfyrHDcfyGddEtw8ovB5ayEdA1Vzel1EHG7ibRDQALI3LhhsACoAUQsSMRg==@vger.kernel.org, AJvYcCWaZZfDXQ9MQuPKiqDZey/0ePxIQZ1cCOtWqwuwLqFf5BW0TDOeU6I+FBxes6k+7ufrdxfgMbwZfkC6@vger.kernel.org, AJvYcCWv7O5yx95Ism81Hzx5T44dLqg1+Rnyn6fMhf186Q0WP8KE9Q3Jltn7ljrEQ03C4agUQtEOayRf9qPt@vger.kernel.org, AJvYcCXPidGJTuFoRqLBPdO7CaEW3SAspt4ueekyMglfcfwCYi7OZps9SoxpaVgcKyK4BEG9+0w1sJtdxR+zcQN3Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWIxCRsdC3c9sudO5jkkUVi3lJKmnhQChg5Ixv/OIVcSYu2IeZ
	im5Ihif2WklpQnNqqNv9BvMugmVlhuXLkHFHdlbjOd/ZFCftb9kDSH2pcSSsLIrRcPmxTHmIBZS
	4WI8gBBR4xA+tbdi+ob2Sqr76vtvm9xI=
X-Gm-Gg: ASbGncueH4EjHZS9mhnWMFKrp3GvWdUGOgV7AFC5uocBZDElza1EVquwFD9LgclT4iH
	CTe5xnPas18lcmhWvoIQSAdoMUMtImCgaKg8NNAQZ8UyA1gWS/oxMHtUfAI5pplakhS1sL7Dkcm
	+S6Iq/ZMdOHhbFfa1Huh215yiiC2sILOgtL5VfFfrpdxng68jSrSAKXkGHUS0CUMSKBTMvHA==
X-Google-Smtp-Source: AGHT+IGex4UWv+HoV/9Li0Bva7BreKI2nwwf5CqKk1rUMlIevgG5vGMpxGPPINpdgZlO5LfDN26J5rEEDluUxSQJBGM=
X-Received: by 2002:a05:622a:18a1:b0:476:7b0b:30fb with SMTP id
 d75a77b69052e-4a73c560deamr198293591cf.22.1750182877938; Tue, 17 Jun 2025
 10:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-2-hch@lst.de>
In-Reply-To: <20250617105514.3393938-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 10:54:26 -0700
X-Gm-Features: AX0GCFsDdji5vutx2f9J16YcANLgGsyfwdscogvNs6WP3czKu7_D_i2PrHBn32E
Message-ID: <CAJnrk1YZyuAX+OjuGdRWq1QpNj7R2BU5+Zx8mam6k+VfT9bULQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] iomap: pass more arguments using struct iomap_writepage_ctx
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Add inode and wpc fields to pass the inode and writeback context that
> are needed in the entire writeback call chain, and let the callers
> initialize all fields in the writeback context before calling
> iomap_writepages to simplify the argument passing.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  block/fops.c           |  8 +++++--
>  fs/gfs2/aops.c         |  8 +++++--
>  fs/iomap/buffered-io.c | 52 +++++++++++++++++++-----------------------
>  fs/xfs/xfs_aops.c      | 24 +++++++++++++------
>  fs/zonefs/file.c       |  8 +++++--
>  include/linux/iomap.h  |  6 ++---
>  6 files changed, 61 insertions(+), 45 deletions(-)
>
> diff --git a/block/fops.c b/block/fops.c
> index 1309861d4c2c..3394263d942b 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -558,9 +558,13 @@ static const struct iomap_writeback_ops blkdev_write=
back_ops =3D {
>  static int blkdev_writepages(struct address_space *mapping,
>                 struct writeback_control *wbc)
>  {
> -       struct iomap_writepage_ctx wpc =3D { };
> +       struct iomap_writepage_ctx wpc =3D {
> +               .inode          =3D mapping->host,
> +               .wbc            =3D wbc,
> +               .ops            =3D &blkdev_writeback_ops

Would it be worth defining the writeback ops inside the wpc struct as
well instead of having that be in a separate "static const struct
iomap_writeback_ops" definition outside the function? imo it makes it
easier to follow to just have everything listed in one place

> +       };
>
> -       return iomap_writepages(mapping, wbc, &wpc, &blkdev_writeback_ops=
);
> +       return iomap_writepages(&wpc);
>  }

