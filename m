Return-Path: <linux-fsdevel+bounces-38410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10062A020EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC3E1627C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3401DAC83;
	Mon,  6 Jan 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RguIPiPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9315EFA0
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152574; cv=none; b=t6Tq1eFJfRvtdV/+O2dCvu/jwLRIrep2TlgDmlYVtnSfjwL/ztT1YOcXCymFjjIF5JFUtG37pWjgyPvBidyIreXPZ+eM8+JB5ZqkZyrmU4bqv5eIOmamRCRfG9+r1GRgfvN+kf6B56M7fBfRbTLO90rF0Uvdvdyt4kP/Pih7OPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152574; c=relaxed/simple;
	bh=L6s+Rwmim67+j7Ln36wa21wC3/N4uadQbHRS0sVWv20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6xvjHXYQ+8kSeBsHmY+N73yfWM80IiNn3WDvtEiX/aL/lvPkanf/IclU0R/01leyuuMICC9+1LKQCyTDREgpLP8hgs0E8YCkp/hxzUrq67oJ91Nnn7b9tdlziwRaZqVW+ZkoKMoUwMOpe7yHXDmstOwfbsa0BuOe2quctfgPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RguIPiPY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53f22fd6887so13155897e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 00:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736152569; x=1736757369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ejBNHLkaoLmmaLuycx7ZFMBKERt9Z8cTBhk9JxCnjI=;
        b=RguIPiPYvv2/MMOMfCE9c64ougfNacZPGz/MyFQmoIEHf6sf5dC99YGz01N6fC6C1I
         VJQl4U6TZ9+Ry/iihbqXadvov5BJKLJptrTpM9tBWnnTQtGH7uUxo6dWSqeM6mfeKy4r
         LsnBGVXqaevI0q3YVqJhBjfJDk9JtkN3VJt5qtTI8aJXBgcwH4RgaIh7jF5/YqTyt09j
         EhpgRiM/xMQ4BnkYSTLmA9eG9GOKTjKJqkegPWaKCmqOI8XculEiwSBWZwtySqa+ISok
         KgeKMhFmyrwjZvPW0RwRKG2HiCRB7XximHw36Hqc1NEEaCIxNOEWRErL+OND+/sSvyZV
         5Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736152569; x=1736757369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ejBNHLkaoLmmaLuycx7ZFMBKERt9Z8cTBhk9JxCnjI=;
        b=s0Xbch/lWH4Gv6K6gfjI2bQeLhtyayHS5jSHgi27v09vpJ6A9PPTLK84DVUavSalTN
         +hx1inwDeZ5PYIYnHcGDVoBITkG0ibzzgJ6DtTKyrCuNJpAqp8xXhYmkgBc/fIKrGFLQ
         tqlXdQu4R24rxuNDITmX+TU0IgfESHJBVPy6SfMgfEO19v6wweyOypprlQejGhwZl6Jd
         x+GOpv0wMkRQ5T1t+cPnV2QKqdPFpRZhfvQmQPuupYgi3x0OsJ7ba3Xp0RdxSLpSyTw5
         QXyHEn2KdxxaGTM6NSAHXEkS3ov8J8s9aC2VELzVYOX/edB8h2+sDLqR2GJOsZ5NALIW
         MVPA==
X-Gm-Message-State: AOJu0Yx36mGyjYOfLNdGI0KRgDSMsVkuLKJkb60WxUAUeutLcLfRDJ6Y
	zA+LXZEz9tDpMPzVSNUz+VujdyREQr7VxJ+Zv9t+RZCFHN1NkoiXHqd+C2Aknx/ra71TizDa2Yu
	I6soacO8zYkIUBuRc0XCeITL1lHNszuEVbll2M7xr
X-Gm-Gg: ASbGnctgyrRspeEvDkIuuxkhQxPnyTAdPJpWTLV2wZ3Bl5VsGQFt2HnI42YprSLMUvr
	fKQCgsTmED2D29M9my8xgvbvIRE85nCP7MBh2Fa0=
X-Google-Smtp-Source: AGHT+IEHD2YeFiZ+y2EW4m7i8r77cUv7Fsl9yaJ1yANFkhx9COGaKU91016BOzpPekk5rLl+Rl1UI+yNStdmO14SFfM=
X-Received: by 2002:a05:6512:6d3:b0:542:1137:611a with SMTP id
 2adb3069b0e04-54229533db1mr20364062e87.17.1736152568945; Mon, 06 Jan 2025
 00:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927065325.2628648-1-sunjunchao2870@gmail.com> <20240927-eilte-willkommen-36601271c983@brauner>
In-Reply-To: <20240927-eilte-willkommen-36601271c983@brauner>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 6 Jan 2025 16:35:58 +0800
Message-ID: <CAHB1Najz=Eiof7vSUq+MqpaSpUY5MnkfzrBggjrz-==nGVKAqQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed this patch hasn=E2=80=99t been merged into 6.13. Was it overlooke=
d
or rejected?

Christian Brauner <brauner@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=BA=94 19:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 27 Sep 2024 14:53:25 +0800, Julian Sun wrote:
> > Keep the errno value consistent with the equivalent check in
> > generic_copy_file_checks() that returns -EOVERFLOW, which feels like th=
e
> > more appropriate value to return compared to the overly generic -EINVAL=
.
> >
> >
>
> Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
> Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc.v6.13
>
> [1/1] vfs: return -EOVERFLOW in generic_remap_checks() when overflow chec=
k fails
>       https://git.kernel.org/vfs/vfs/c/53070eb468a2


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

