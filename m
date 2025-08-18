Return-Path: <linux-fsdevel+bounces-58185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CCB2AC49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05472189E580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3F624BBE4;
	Mon, 18 Aug 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jX7xqJLs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECE019F135
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529882; cv=none; b=UQqtgtAXhtSHGfPBn3RT5fgx+nvQLagFwsnk0U3RDR8eoljK0Gy9mMqPpgJweVgG1CJ5TKcOfwyLz1U1Huy/nzwlY0AUR4qSiKsDy3BIh/bUqkK8hKgto2HR8mnWGGP0b1Q1j7VovYpqRuzu1cxuhKmRi6JfX0Fr4wI5/Ju+xhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529882; c=relaxed/simple;
	bh=bucQ2vx4LDNgwg7D5wab9kp7Clo+Q8ReHCnb0ABeloU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXrgih9H6UvpCfMf3k12rREuPkXCPFIOlsoXxxjCaWYoWlXKQjAsE9N2aRhMPu1UfFZMcEjlGEMZPvdiipH+78PMWp+KeTRUThIQ//XaJ6HwS1cpVeroNbwJ1A/52f6WsN8b9ubphgapLQeBlhQtOOu7XyaWm+bSzLH9w83xHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jX7xqJLs; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b134aa13f5so16510931cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755529879; x=1756134679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=265Bx2NGLxtSNJrl9oC2kw27ekUKmHo2m+KXlQNbKAQ=;
        b=jX7xqJLsIWVk3MZOlBEwf8bFdU3M610DzHPcV5LtWhchW5KWDeWZI4wfSRWiDsoewD
         u3mrYkbOEVh1GL55ADLBYyRaTyEuyp1nxMFDpFRPSbC9TkhQ+St0DICxcmjjfY95vmtM
         VWQSxSbS8xBWIKvVCcYTLVhD5xwx8lA8Zpfos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529879; x=1756134679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=265Bx2NGLxtSNJrl9oC2kw27ekUKmHo2m+KXlQNbKAQ=;
        b=S5QjGPmyJ+lzp7e+gPTRA846kZqdZ6H2cXsvb1bIiNJ3SO5WCuXNwMbi8o+uD80Abt
         dv3Q6aleq7E3LdIoGtKUYTY3d+49xG5VXPf3aM10CNAF+yJ3vrDPW9g+l4pzQkf90miy
         sGJ3vF+RKJUK4gebh8L+FHp4TugOLqfVLXpRSynrGX/CGqQknh6Wx0HEn4M9SVrUiycu
         9iBd+sbynJdT0mReuEU07nwVy3D4sYur67z00N5uAX1PTXDrodxleFWQhhKqOsu51pWB
         7ABPy5ozCS08UFp+tH5flCxG/68tA3YVUZKiQ6+FhdvFheCcnCpS0bOoMzqhDVJu1F2p
         KL6w==
X-Gm-Message-State: AOJu0YwS5f7vUr/JEIoZ5I0Zx7I3+4UAiANT1B3DEkEy52ou6wzPfK41
	nkf929djNRiC+ft0j7kPlOEAg16K5wMbKHV7ltaAsYgVfD8tKhEGyOwziomWqyksEDxdIjg/YF3
	sY1z6qn7hAGEwI/WC688ue4wNS/3YBlZ/k08Oqa5zHw==
X-Gm-Gg: ASbGncvTOGw879JYrPhwrSYP5hvAsi9IHgWJQePN1xGaDwcZ6NLTQPTNuirAL+J6zGJ
	caF3c9Y7KwhN0o1YFHW+Y+RQUktsEjuviKFPECCNPoQCaYr9EC4+DegcHP70TwIDFxdTbd3GAwD
	LkGAJPOqP7BV6tHowLhstfbeCVGCZ9Ip1EzxebZP9lX8CelM89J/PvmGF5HvPsOnJNu6CijRZp5
	UBE8cV5SA==
X-Google-Smtp-Source: AGHT+IFYjuaE8bjq4IgwMmNXMJ7+DaJ1UdAOriWAGek2oPoFl/+69NWlEaRmEnzDJ4PqijKdmQyqkUf+wXgLX4znY2I=
X-Received: by 2002:a05:622a:1b05:b0:4b1:2783:ab99 with SMTP id
 d75a77b69052e-4b12783ad2fmr128468251cf.39.1755529878695; Mon, 18 Aug 2025
 08:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs> <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Aug 2025 17:11:07 +0200
X-Gm-Features: Ac12FXwvYnZ2WlCPgT7VWz3Pd39zYAmbTr9SxeJn5u1xYPjWo2N6XcSIRTLvjuE
Message-ID: <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 01:27, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Actually copy the attributes/attributes_mask from userspace.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/dir.c |    2 ++
>  1 file changed, 2 insertions(+)
>
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 45b4c3cc1396af..4d841869ba3d0a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1285,6 +1285,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
>                 stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
>                 stat->btime.tv_sec = sx->btime.tv_sec;
>                 stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
> +               stat->attributes = sx->attributes;
> +               stat->attributes_mask = sx->attributes_mask;

fuse_update_get_attr() has a cached and an uncached branch and these
fields are only getting set in the uncached case.

Thanks,
Miklos

