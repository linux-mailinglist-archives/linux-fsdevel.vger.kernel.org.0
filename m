Return-Path: <linux-fsdevel+bounces-15229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD9488AC31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A12B1C3AD35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C0137C4D;
	Mon, 25 Mar 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnSSrZj9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C53137C3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385844; cv=none; b=gh8y1BsYvWeTXk2La6QQNN5VMMADnnAGy4KLN1uxrQ3viPn85ymgn5dmjoviOhkpK81QpjvgBQUEyZApMQpzOxgGxjMTGcltvUIuWI484SueIEo4XkH8o+JG/jsq3eNR1oFEaIBGBVULuy3HD5qMOwbuB7y/AD1o9YYRH+KcQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385844; c=relaxed/simple;
	bh=XoEQkSXuzxq7fBduGmuSvMQOeBqqt+zhrQ0AYChY5Q4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Um5y7HD9sqD99fCWWrNyX7LkDD+MSLpXGf+DJJwneEJ3TjSbDoxFn3ItknPA439cTB3U2g0jYRuPzrcUfH1nh05XIHqs/EOxDLHTYhxbUXTqHDv1YxexaQOM3c0E+vVlRTp6Uc+ZJghluQ7l1yJ8lcnlxYZ2e3ZnOgareYWLd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnSSrZj9; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-476605ec78bso1448990137.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711385842; x=1711990642; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hLwz6AT7i9SFQR1PFmCOZMN76wf8IMXdZo0Hdboi05Q=;
        b=RnSSrZj9FUXQRqh8D+i6AptOmnTV+PGPOtUBEMLxdBrdXxqKL7bkl0+rgIQRkA0Geh
         TBl53mUzPSp27aZ0CsctRSCVvhMCkhR/V3jp4KNfZUAY2fAe4XiYGjC15cAACgBMw0k+
         SaT9tsAS8tsylX5lFT+OlogDePtgGD3z3i9FtsgXV0ahUJzx4uj8/LZJrfqemb1Xhdfy
         6DCBQLah7ndWkxk8jxovUNlcBUcgohgiWRqcYLLGiZ48s48TtT/zsrpMXujgW3ib0bW5
         EizN0z4t1/d62nrIGVw5tiIQpK7IIcH8W4MH4ceWQrHHSYYDU8ry0IyROqpqAE+mue1V
         5foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711385842; x=1711990642;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLwz6AT7i9SFQR1PFmCOZMN76wf8IMXdZo0Hdboi05Q=;
        b=TQbwOu3Qlj3rSpetoWXoLU4gxJLBYrqoGK3ZBIUJypA2hom806GCvdT0byKbPfwptl
         r2F05Z6QGINnpnVEQ5n5aQsGdeVqR8Kr8KxAQJDv7qj8Ab03mDCA+0qzI5hUNWsH/geG
         cakkE82YnkFzqSEnksXvMkF2xJlLXJ7VhUxhfiLRxWR3cC4AxCjVCc8xZ/LFbuvuQvmg
         aO7YQjbl7CRP+bUrHEOIbmyHitshp5ceswNXz5WvU0Uf4uDsfXMWLL80BWt9VDcQYoqO
         yMO7shyITPYNaAYTxBEGQ+GuIvdKYtch93jZtd3n3O8i5FkgnAs2Fn/YnqKQCkRXdi2o
         HNeg==
X-Forwarded-Encrypted: i=1; AJvYcCWis/ZceeKipS6BHGKDSJp5zQh3yNk4+FNZWKhE8wcBKJKd67fAIeJlFRvfFeBrmCW6OSLzKPWeHxidrO3QXQnSpOd/uHWwStIhX0y2Gg==
X-Gm-Message-State: AOJu0YwNqrpVAJFfTa2qb2Lp7ooiSEg6UXREHjudzW9B9HKFBhp6keTJ
	ct85Gba6R+WsuFEyAV0pFAekNEmOtPyKq3IL5Z9wX/iSwxXDgWuZSSC/fyQgQvG1MkpIy99A0Cf
	s+bxE+tSVGgBtEBVLedqs54Rq8+Q=
X-Google-Smtp-Source: AGHT+IFDmJdILhbZ1B94DyCMDj2TYfzSPnPxFtvwQYnsGy1X4FTKrtyhTl7tP84FRTNDOfm8Dn6ti6PAATMB1IWu3qc=
X-Received: by 2002:a67:cd15:0:b0:478:222a:5303 with SMTP id
 u21-20020a67cd15000000b00478222a5303mr1398631vsl.14.1711385841975; Mon, 25
 Mar 2024 09:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Mon, 25 Mar 2024 22:27:10 +0530
Message-ID: <CAOuPNLjQPo8hoawK73H7FOVitQHp21HHODExO+7cguGrtURKWg@mail.gmail.com>
Subject: linux-mtd: ubiattach taking long time
To: linux-fsdevel@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, artem.bityutskiy@linux.intel.com, 
	Richard Weinberger <richard.weinberger@gmail.com>, ezequiel@collabora.com, 
	Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

We are using arm64, quad-core, with Linux Kernel 5.15 with 1GB NAND.
We have A/B partitioning and around 9 ubi volumes.

During boot-up we observed that the ubiattach alone is taking around
1.2 secs (either user space or kernel space).
The snapshot of the log is shown below.

I have tried using fastmap as well, but still no difference.
Are there any other techniques to improve the ubiattach timing ?

Logs:
----------
Doing from initramfs:
{{{
[    6.949143][  T214] ubi0: attaching mtd54
[    8.023766][  T214] ubi0: scanning is finished
[    8.035901][  T214] ubi0: attached mtd54 (name "system", size 867 MiB)
[    8.042635][  T214] ubi0: PEB size: 262144 bytes (256 KiB), LEB
size: 253952 bytes
[    8.050423][  T214] ubi0: min./max. I/O unit sizes: 4096/4096,
sub-page size 4096
[    8.058134][  T214] ubi0: VID header offset: 4096 (aligned 4096),
data offset: 8192
[    8.066011][  T214] ubi0: good PEBs: 3470, bad PEBs: 0, corrupted PEBs: =
0
[    8.072995][  T214] ubi0: user volume: 10, internal volumes: 1,
max. volumes count: 128
[    8.081225][  T214] ubi0: max/mean erase counter: 3/0, WL
threshold: 4096, image sequence number: 302691963
[    8.091242][  T214] ubi0: available PEBs: 0, total reserved PEBs:
3470, PEBs reserved for bad PEB handling: 80
[    8.101544][  T215] ubi0: background thread "ubi_bgt0d" started, PID 215
UBI device number 0, total 3470 LEBs (881213440 bytes, 840.3 MiB),
available 0 LEBs (0 bytes), LEB size 253952 bytes (248.0 KiB)
[    8.136907][  T227] block ubiblock0_0: created from ubi0:0(rootfs_a)
}}}

Doing from Kernel using cmdline: ubi.mtd=3D54,0,30 :
{{{
[    6.702817][    T1] ubi0: default fastmap pool size: 170
[    6.702822][    T1] ubi0: default fastmap WL pool size: 85
[    6.702826][    T1] ubi0: attaching mtd54
[=E2=80=A6]
[    7.784955][    T1] ubi0: scanning is finished
[    7.797135][    T1] ubi0: attached mtd54 (name "system", size 867 MiB)
}}}


Thanks,
Pintu

