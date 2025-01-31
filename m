Return-Path: <linux-fsdevel+bounces-40500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67233A240F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB77A4C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267201F03D2;
	Fri, 31 Jan 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="wBcsVdt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F81F03F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341708; cv=none; b=erZSHkrpU501p9zPYQtomFheDt8VjblIixm2VgIsWf7M/fvfgfyp1f1OsVBAQp4kakykXfltnYfhnphtunKMy9N52P1QX20aRc5mrDh3t7kMA3TJEmybkoNiEkbV509opZ5ekvXDrb+sIBNXxXrkhR2KJ7PmSkCRJw9GfEY9GGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341708; c=relaxed/simple;
	bh=wJUNdGYXVqVyOlcBenOV5oy6/Ed39bOIYBNj2ptd2ZU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oEQYwgEcu2luyrBWKnMkgUFhnPt639zGSUOHgtdnofaycE0Hz5rHCDyKb5T7QM0eT9o8QEmufGy0XfEhlXr/UEnny0azsk4VUgnzGCoBUbiGMry/uSa1S6et51j0PQY+fYus7zpypBAOZJ6N3Q1n4UFxrrRZW4r1QutwXSVT7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=wBcsVdt1; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso3082047a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1738341705; x=1738946505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+eEfJJcr87RnYRXAj2DBnEKk4dXdxniqCx7iRFRd+FM=;
        b=wBcsVdt1t4tRZXysBg3oYs2XU78BlRMmgP+pHo7OYPiyVxhXG63bObgWdafVNAicRv
         SAhhczQrDKrMerWCGHKIQMBMNdUSMPRYqSDcW4ertZyHaYHO1zsfa5jrOlsNP9YNDPWx
         0cTOBatgAAQdB6VMj73T6HYJ2s8UjtB0Vo3uXID04bcTNSrWMqteYN8vuz+EV4T8bf1m
         068LDgUNR7ShFvwOm9q59tR6tZN8Gr64n43TOJZLJTKXkNoRf/gtTthw98oHyQhu55fh
         gIqe18S6XGbkmPk77EoKLC0m7jZi3LkvYLBnmS04dM47YWEgG4fyMmZ7dBvCm+MUK9x8
         o12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738341705; x=1738946505;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eEfJJcr87RnYRXAj2DBnEKk4dXdxniqCx7iRFRd+FM=;
        b=dpdvmrlCUukv9UswWMTjJdeP5IFkskatwbeB1X7a6m/Q6qReOrG84AeNQvVM7U0AUI
         9mHkp9D4he8EhaOp/jLhNOQyD/V7Q0P9CsLyaWyWeE5NZMaEj+TyLblqIld+0rHxyolC
         PiVDExCvCm3H9C+tNIGQaMYBl2iAefqxZSXjzVoKuuFCfeMcUfpYdizPUMmQ4Qh+6RmG
         WIxlMCIB8vHV9v6wKp7FKsG7GO7fTcY2B0Z/cOZUBeVrKEE5KzIhAVxeEheVLaZgWZPF
         R0f5MMasVXYSKB3SInpKRZT8LNja4TIiKA62M2mzQpxBhIKVsvC0cZxIb3lmVUxr8aPY
         WdEA==
X-Gm-Message-State: AOJu0YwrAe7RH/ZaILyB6MRyu+hKDVpy8BA2I3xyXAGY7w5LAsgmC/7F
	OzBeblKUqnyIiPbI3zFASiIV+jqcf+qtKbg8WUH9+aueHbYt82/hAgGRGDkvKsWNrhDR0JJ5RTC
	zjJeN6h9D7cQRWTwve98N6tpAz4b8UQWNFQDl8FLiu97Jc7ni/A==
X-Gm-Gg: ASbGnctRwV5aVdAFKrZz/o8LzezR4uuNaL1I554rU4PvIJBq/7j8Cze+lk145b/hNJy
	j7cBiA4bHAck3Sbb2pgzlN7CA6MM/wHalhjjDTHboNKvnEU/F0WXqkERgTUfWS3xQzVX8s/8hjH
	Zysr9YEguo
X-Google-Smtp-Source: AGHT+IHH/PljsUV1KvbPnycXhYIE0cHQ+QDn8rPx+3EHhl6pLqnSAS4tzZmHF6tCsKgTFPq1c0TjHXEwoQWEsW0Ugkg=
X-Received: by 2002:a17:90b:3a08:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f83abe2135mr18428482a91.10.1738341704660; Fri, 31 Jan 2025
 08:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Fri, 31 Jan 2025 11:41:34 -0500
X-Gm-Features: AWEUYZnR4NiQXJ2cA63iwkm_loA5nyd83TSHb9GyBRYsNYddmwivKjLD9UQQVco
Message-ID: <CAOg9mSRMrw4+OJVQ_tiTcCxOi=E0XScii7uD44w846ryht1T1Q@mail.gmail.com>
Subject: [GIT PULL] orangefs syzbot fix resend....
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus... Konstantin helped me get my nitro key going, I hope this
one is OK... thanks!

-Mike

The following changes since commit 9d89551994a430b50c4fffcb1e617a057fa76e20:

  Linux 6.13-rc6 (2025-01-05 14:13:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.14-ofs4

for you to fetch changes up to f7c848431632598ff9bce57a659db6af60d75b39:

  orangefs: fix a oob in orangefs_debug_write (2025-01-08 14:35:59 -0500)

----------------------------------------------------------------
orangefs: fix a oob in orangefs_debug_write

I got a syzbot report: slab-out-of-bounds Read in
orangefs_debug_write... several people suggested fixes,
I tested Al Viro's suggestion and made this patch.

----------------------------------------------------------------
Mike Marshall (1):
      orangefs: fix a oob in orangefs_debug_write

 fs/orangefs/orangefs-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

