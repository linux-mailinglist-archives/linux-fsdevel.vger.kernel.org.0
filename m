Return-Path: <linux-fsdevel+bounces-52424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF05CAE3251
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320CB3A7960
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B11E1E16;
	Sun, 22 Jun 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="QZUrQXn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52521EAC6
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627383; cv=none; b=L01TuVCbcH4WMlB2HgMaEEL6MyYtNnUayFtkhaWRCfZwb+nPXVdFcXtmA+SIL1av1yw1BUlmPCYpQnf5kMbcczCYo9Ol80/sO/bWlleJj3DqqVGsC7eCMwJNtyGLmSbNsC6feF5d8VEPEFfuTc+iBknU3TqmAkbzZ4a49/LawU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627383; c=relaxed/simple;
	bh=vnyvkIoMYqAGRYtf0DXR5YIDTgIIpW5y0bmstrpHBpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofGMsdaelvVLAyXQc2Y6rvWyGrpUn6aRLPTqAu2S6bWoHK1B4jBpJbn0GNy30aRZXIyn7mMURnGGyxg6odbV6TtPZXzoV4axTov5QBN0anoEgHCqUP8AmnzYd6njdS7vxp+dQOF8Ki13LEum7B+oFX50pSaT9z8lzIZ0jqO5bP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=QZUrQXn0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b855b468bso33377331fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750627379; x=1751232179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIpVlzk/USL+y+Sads/ZaaqTMm0AheK2hTj4ugRKadU=;
        b=QZUrQXn0adu/ijcrHZ8PD0gTK29FvLCCqWIO1Qb5E1uqm/YkYGu1RUy9w4WuevAxZV
         iep8c9L0EPJN3gDPglbMyyS6jDdLpSzZBM5kJgE8eJU9jxEPlVIoCLTlKV6FzeFc6Mra
         RJFr6WJ8NOatb1Po4zLTjnwnGVpYWEsBzl7hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750627379; x=1751232179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIpVlzk/USL+y+Sads/ZaaqTMm0AheK2hTj4ugRKadU=;
        b=UJb8y0RvvBtjnjMsN9L0xdgD8IcBlBDr7X4QF7m5TybAdGlsXL9PmVFilwWXyJABsw
         /UNkaENrQI8arD0qYvVxknuZQeVzyqiNYGaACtLDSUUNRXqszYTk72lKZDGd+/m0lS2/
         /DPhSjlfO41AHOTfEBWYABQ3jzKovzD9MWC7jiWsaydVtADveCkHnugBsjm/zdtGLAjy
         3IMJjl++hBi86WrcMbGbhzubuhz4iywJ4k42W176xaIWMJwcMfcY3dCG4FmbaxFMB8Nw
         qj54AhmNZh5/bxAdSiksr4WMNUXjAz/GOMtiZT3DO1lSZmzsC8Y6gffPCs4fpBksrJrz
         ij+w==
X-Gm-Message-State: AOJu0Yx9QqIo5Xn2tQPHBFxgJDwgVj1Oafn+jXNf/Ib+L3du+w1uIGi8
	c2BCzCfubrZP2sR9NvHPEoXbcnw8fERwdFybNyNZoPlyhkwQy1uyVdnsPwKI4HmAqEL0caWSvM6
	D3wg6LUj/04kLdb9vu0If8ADpAIL7Ojq0IroqupWl4Q==
X-Gm-Gg: ASbGnctlHuPcgx2/SqFOXHlrhF25mlVSe0u3SrsIydHY09prvsUHNyHLNfYrNpZuVCP
	yZX2/5Nylba8NWgqUdkKmtTnqf2oX3ljklRvCpzVBFOv5seUSz2a+ta6NvngUI4kBZa7k+B7B88
	vtVp0XOsg5Chp+UqLAToca9y1l0uQOlG5iULI3gBqYJSd2QbA5Ia/+F9I=
X-Google-Smtp-Source: AGHT+IGSI+nuzrLLEJo9C58XLxx5K9i/rnstbbgu76hx1ty4jGPojxki3EkH4psB1WPlCc9R+qybIgwRawKFW5q9N4s=
X-Received: by 2002:a05:651c:2128:b0:32b:4fd4:f1b5 with SMTP id
 38308e7fff4ca-32b9905eaefmr25193101fa.27.1750627379153; Sun, 22 Jun 2025
 14:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-16-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-16-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:22:48 +0200
X-Gm-Features: Ac12FXzgjMu5R9AFrHBEKSKsD19zE_9Lunh0swy3eWBXRn6iMPrL0_0GYLnz-NI
Message-ID: <CAJqdLrpWACE2CSObFi-JvPwz81DxsSR7eCjkevgMVyqmDcQ7JQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] pidfs: add some CONFIG_DEBUG_VFS asserts
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Allow to catch some obvious bugs.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 15d99854d243..1cf66fd9961e 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -809,6 +809,8 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
>         if (ret < 0)
>                 return ERR_PTR(ret);
>
> +       VFS_WARN_ON_ONCE(!pid->attr);
> +
>         mntput(path.mnt);
>         return path.dentry;
>  }
> @@ -1038,6 +1040,8 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
>         if (ret < 0)
>                 return ERR_PTR(ret);
>
> +       VFS_WARN_ON_ONCE(!pid->attr);
> +
>         flags &= ~PIDFD_STALE;
>         flags |= O_RDWR;
>         pidfd_file = dentry_open(&path, flags, current_cred());
>
> --
> 2.47.2
>

