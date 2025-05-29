Return-Path: <linux-fsdevel+bounces-50019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83163AC75F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 04:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B82C1BC7BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 02:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B35245032;
	Thu, 29 May 2025 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0BwHQe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EF38FB0;
	Thu, 29 May 2025 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487040; cv=none; b=f6prdqTjyFy/q/LPg8VnRwrKporcXngGN5/M+hultZjBiE6RYE+bxwCf3D0/rTcVtRhb87b8mHn1tFkXfAXpti/2GZxF/u9zb6otHkRgejWruEo6g7A2z5X+ugyg5hRRymcExNg634YpF+GWNFZ8qvWlB+4P0jucxAQR1ZQb/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487040; c=relaxed/simple;
	bh=OIYYzBxVvXV7UHgv08yIY2bJA4d/7tejDfn8ryPAX00=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b5mRJ49SZBWLwxsRVpw6F+nTjnnAUPH13IRQDdKCj2gR2/slK0chDN3LZvrO98gwk0akKj1+tvNfVsJZA7TPu6tiI21e0d2nGJ/pmSzfq2thJQOUt87fDwQHV0gdqrSbbPGz+x9Hy96Paa1UNYfpfCRBtEmGVZHpGK7Xwxau+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0BwHQe9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6faa4307e15so7932016d6.3;
        Wed, 28 May 2025 19:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748487037; x=1749091837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cvw4A3xzickVLamMZUkHhwLnEO1ZDHT3S3EbHdVjHEM=;
        b=P0BwHQe9dZRdn6Ukt4o7bLZ4YktckzK2F1ngAhCPwoK9blOtVNrgTdSlaPuL4DtjJh
         z9gCZeRO0bis+8iiOlMLrZIKvzpMz0ZbmbmtmS0zJmE99Y4YJq+NHfjZKpt8U5LN+sNg
         Z9STAIfHxQwbPz3pT0fformzrBHXdm9oKolBFUc7ulfnNX0gRujsB4deeMHnGa2byYLy
         gvBKtRr8Ctbx9MMuvyFmJ9EI90Q51B9J7vOhG1YH/GHmttIHJQuPYUB0L2fAI0/y9D5O
         ReK5ZEXYovBrPK0aN3GYFcoaUslgMupWw6b2P7x67HafR7cT3QtzAS7+mT1PVX2apk29
         0Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748487037; x=1749091837;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cvw4A3xzickVLamMZUkHhwLnEO1ZDHT3S3EbHdVjHEM=;
        b=To7peszzxvtRmkkIH1owlpLVcnVv7+zIJRf76F0JnpZ8Te3ZiPTOSZdMIQZG6nySxj
         N1yn9/HBWE6wj5ee0O2pQEPeTAKeWlMPbh9ORfnAXsJKA39aHcCiRFWi9BdBFInjt7KU
         sEwjDinYO5JYzGq5sBPe7TusQPHEqgneQUpyibu3wb/R6lF771VHTirRUQoXQQvPFqnB
         m7/L7N92x5vOdTmoCxcfwmKm49c7OLGsarLbauzH1XPP9xXvUbqvKIhgJS4eFaDxYh/c
         NWx/QcstQF40M1IMZOycXdrntEY2od8PDDO3EPbP63oFBo10FbVBxyoRJoFK5yiXPqub
         2qFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmygNusMpash5490+T+KK41zCs3dcwni6Yr7DdzDY4Ad6NOobR9RMY0auNKrnl+BYoNteDXUhYXZ80PeTe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9goaK24dWmjr+r5AQgpX7WlWXQrDo7lDWh4EOJkgnA33LI8uF
	LpeYSP/hsrcTVA5KrXkyFqDdN8nXC3RoNohexBqiDy4WAPXKWTXMeIIgXBcCHePgflFXYe86a61
	IaN7Y4/XLWu84q0VcmpwchLc83DuHZ9C4bp840qVWBQ==
X-Gm-Gg: ASbGncs0QAyuI7UkVJJfxaeX5wyzIKL2vxbHxcArtlBiS18AsunoEDhcG1XAtBUjhOk
	GFXVHf3SfUpEDXLmLj5TsB31VFfvhJdnznjF2D77Vzf/zVr4L+C3RYZnLZbgUp4MpeuAdfH+1Ih
	yB7Yz+N8YcFmejofqGisLlOSbEd1S+wwNH35P1c5ZGpZkt
X-Google-Smtp-Source: AGHT+IHNv+27X+ad3RGnHOWM3qs9F6U8qFDBCpke/Zy4sa9Ke/SXihylOkXKlJE7LVpXgOhR3U/AO38f5nE9g6qUN2Y=
X-Received: by 2002:ad4:5bad:0:b0:6f2:c88a:50c5 with SMTP id
 6a1803df08f44-6fa9d28772fmr325926786d6.32.1748487037302; Wed, 28 May 2025
 19:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 May 2025 10:50:01 +0800
X-Gm-Features: AX0GCFtzE1GshfG-pFFSJor8rl1xgkwNQKknC_RQQockKdTlq7LmFDYJ_ymtvb0
Message-ID: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
Subject: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent data corruption
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Recently, we encountered data loss when using XFS on an HDD with bad
blocks. After investigation, we determined that the issue was related
to writeback errors. The details are as follows:

1. Process-A writes data to a file using buffered I/O and completes
without errors.
2. However, during the writeback of the dirtied pagecache pages, an
I/O error occurs, causing the data to fail to reach the disk.
3. Later, the pagecache pages may be reclaimed due to memory pressure,
since they are already clean pages.
4. When Process-B reads the same file, it retrieves zeroed data from
the bad blocks, as the original data was never successfully written
(IOMAP_UNWRITTEN).

We reviewed the related discussion [0] and confirmed that this is a
known writeback error issue. While using fsync() after buffered
write() could mitigate the problem, this approach is impractical for
our services.

Instead, we propose introducing configurable options to notify users
of writeback errors immediately and prevent further operations on
affected files or disks. Possible solutions include:

- Option A: Immediately shut down the filesystem upon writeback errors.
- Option B: Mark the affected file as inaccessible if a writeback error occurs.

These options could be controlled via mount options or sysfs
configurations. Both solutions would be preferable to silently
returning corrupted data, as they ensure users are aware of disk
issues and can take corrective action.

Any suggestions ?

[0] https://lwn.net/Articles/724307/

-- 
Regards
Yafang

