Return-Path: <linux-fsdevel+bounces-22683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A723591B015
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510C41F21050
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26B19B3D8;
	Thu, 27 Jun 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="Rtze/vOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA145BE4
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518753; cv=none; b=aAuUOt47166H42U0lCb4f1HxFJOGHORvfRyqNGBF0M7zxg35/ssVSvFaXLXDyk4hqDyB7ErvfTI8DKAogTNoS0oMcTbgIkN02YrgzcMv0eP1Exc/kIScDbpKDYCCobSywNF0lsYO6vnkftAoBrcsrMcoXvlbpUJdWTJ+KyYjvsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518753; c=relaxed/simple;
	bh=9Bp2wyhfY3G38iGQlj+OJY6E1AkRmxAsrfbyfRNSlys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlpEI0Bw9atd/bkrB+/12mj3OjJqdASBXKaj+2svJtxLcqrImj+JFZnmBcicpsHmtrQdPVCdtvMTyeA/Bcvct3AVTwC6QXRMdJMa89kvbkdP1vHC2+93eDCmjleiGQpJdIx2+yZOXDOi4QmCwXbWIPcBsonpyK3wy2tLUzYeb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=Rtze/vOa; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec89b67bc0so3387911fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1719518749; x=1720123549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bp2wyhfY3G38iGQlj+OJY6E1AkRmxAsrfbyfRNSlys=;
        b=Rtze/vOa3yKc4Y0yDHNqHG1vfABzMH5RBqeLjey1lcrNsPV0C9o+Ao51eCqDkFskpz
         95P355isT/7Qf1wIT2pvzT23M4RL/+I4UT26PeiH8pRQujSx2O5+JwW80WzfpqjoA1W5
         aR74hV3uKc0Nk3MsgL4Ze4kPQCdpgVihzWLEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719518749; x=1720123549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bp2wyhfY3G38iGQlj+OJY6E1AkRmxAsrfbyfRNSlys=;
        b=Z8A7ooyTLcbr0k4OlF21TUP/WNiNfX92EUtMIu59UBmBfLUVi24zqbdEDWz2CSCjbJ
         qeVCmTlKPW+i3aEn7C13HDecicmUF8TXdFpm9vrULaUvzkiDGgXphfLAF8wa5xWsSMDO
         Cj0aqUfS2BGawBdRWiC3FkosP883lR3neEf3q8xDqfrzUTGIWBiYeZceEfpfMbYlMLjC
         iCswBvyDvWIQNhb9mnR8JiomE+pnh7jjeiXpBuj11tbBXTwt7I5k0QosoFy1LZ+azeyW
         bVXZUrJJqxWgxtoJoG1tRpKOrcONYbPUYPa5KOjTlAzR9gqRg0kCxgZFi8VwvNNrKQ2k
         UrQg==
X-Gm-Message-State: AOJu0YzgW5lgoYT7wn55Rsz88sLTTc1wnSLuv6TeeHU0/cfgeE8TA3Ay
	2HlH1hKLm1QbjtKtbcnOzVhHNsGD7KHEblWp2BnlYMVYzkj3N2j+dd10Prx8o2QFYFztM2FQ0bC
	7Az53/usk5fqQ/1WK3wTVGZc0cpPy89i+abZ/s3jstj2bx3vup5YHZQ==
X-Google-Smtp-Source: AGHT+IFl+uJkuPnsoleST0l4fb7Bdev8zYq6nh80z54i/9FKwnNyz/xWlYsBq34MgYqKhFp0nCnVkyj5r73KlCChCrA=
X-Received: by 2002:a19:6456:0:b0:52c:dc76:4876 with SMTP id
 2adb3069b0e04-52cdd9ae31emr8697960e87.6.1719518748861; Thu, 27 Jun 2024
 13:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
In-Reply-To: <20240627-work-pidfs-v1-0-7e9ab6cc3bb1@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 27 Jun 2024 22:05:37 +0200
Message-ID: <CAJqdLrqmwWnSO=UbzK2eMd+i3bKEmEB-s-MoGh7ScLWdSVUKQA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] pidfs: allow retrieval of namespace descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Seth Forshee <sforshee@kernel.org>, Stephane Graber <stgraber@stgraber.org>, 
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"

Am Do., 27. Juni 2024 um 16:11 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> In recent discussions it became clear that having the ability to go from
> pidfd to namespace file descriptor is desirable. Not just because it is
> already possible to use pidfds with setns() to switch namespaces
> atomically but also because it makes it possible to interact with
> namespaces without having procfs mounted solely relying on the pidfd.
>
> This adds support from deriving a namespace file descriptor from a
> pidfd for all namespace types.

Extremely useful API. Thanks!

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

>
> Thanks!
> Christian
>
> ---
> ---
> base-commit: 2a79498f76350570427af72da04b1c7d0e24149e
> change-id: 20240627-work-pidfs-fd415f4d3cd1
>

