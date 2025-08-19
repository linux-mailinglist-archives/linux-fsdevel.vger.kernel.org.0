Return-Path: <linux-fsdevel+bounces-58318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5DFB2C854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEAC16C961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F91284B59;
	Tue, 19 Aug 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOSyij5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76E284883;
	Tue, 19 Aug 2025 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616782; cv=none; b=CsU3rO+aPfWHgxgnUYQgrxhiItHvCLmooFWf71Me2/+pjNE0cPZ2kj+soE4AOXX7RBqrO1rS2LEIVnm/U573x9xQrS10lXmmP1Wgk5IVQ1H0G18CpliM84XiP9+KbF0EczOqV+97uWObwNgX4mTTntXpBjQCKlWSjFo+MibLMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616782; c=relaxed/simple;
	bh=TIeo1xuKKfF1R/j1XwRimq5gSQyHHJeAjKwlW6WoV1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LxhGbXV2xnxvfYf+nRPioMgL4yta11yzzHawGqSJFk5Bhm+exYXXGBslnDt0ze1Igl84dixJ5NQOxMKNe5Z82EcBkJBxGjSL3rMj4Um00bXEat9g1vqKm4ByBvkg5/iC9vwv7me4wLeZC/QuUl2rBtYMxyRAGbSmk9lqzREuqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOSyij5e; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce5097638so5706642e87.0;
        Tue, 19 Aug 2025 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616778; x=1756221578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjfrgqJY3ktAihSvQOIHVGRGiDJldrhQiydaCwMMydc=;
        b=JOSyij5ewb/rX2x9LDSv3LNLHlFTx5/kRu8kgGVvfuHl5SnVTHzaOuGhh0b6VPf4SH
         CI0m/pdRAKIijb2/Qvx+4VTQPLc0XP52d+6g4gJ7la3XiqembsoDbaXZcZCE08NsFDtw
         o8jQ4immlbdW/hN9/Lj70qEt5/Dp/UbPDpmJVPsE5Ll2cbV0FYBszt31DMOwB+fm1xZB
         V2ke8+4UfVWemFi3EuZJZIcGAEsRLbfWNvNr0QB5Q3LiA6RyuS76sHQ74K1tsS+KnsYA
         RL3U5900rvD6lsofEHirvdZjMA49eO7OEZ8SW9l4f4eKMCLwU7Acp1o1zJ7CQjB3rG+R
         UscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616778; x=1756221578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjfrgqJY3ktAihSvQOIHVGRGiDJldrhQiydaCwMMydc=;
        b=AcQLiiba4oUBuKmj+xGuxbe1GNqreCquZeyLZoKBKnDf+7jQbXQ6EDxzwKqmh8Z+Wo
         Pdp20Wq0NMJQSYbpS5/XaZI/AwjIT3dbwiZMpl2QuHrOP1He9doNc0CCa/n24ujJZ9P6
         qedK0068KqjC16p5sd2jRBeg4CZ98ERYEcb1PlUa7NykkHa1m9ALfuBlWP8jYIECJsn7
         66miK6We1dwjaLC+OXXMWlriygj/+H1NF9q8Xxo2JVl2UBAAuykG6tEyJr5e9jRVdeFt
         F0nOlSVBhuW9O6rAvXUS6uKcK0adUpB2ZPRiGfJXCIKOJAek2yQCj/0eXs4fpJnrJbFS
         qSKg==
X-Forwarded-Encrypted: i=1; AJvYcCVfbHPqzdaqD4I7zdySx/UJjlVTD42WSfcNlMGpRKBq7Xk1MFShdLy8Pjg+Fimxwp0/lcF+s8fY86iAUC3A@vger.kernel.org, AJvYcCVm4T7ZLLF0rJIly9i7eUWNkiY9O/qNkaYyqpjjxjinBIXd9TUD3a0KZVSdl5StRF7NbHyLzuxRwv54YIMRLg==@vger.kernel.org, AJvYcCXuA5RMCTCfEXjWP5QTSDsoIjOrs5wU3hMo22f7H4UBqMhvJG5ObhPoAeEE9SLJeKHsf6iThvs7hM7CkdP+@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgMB681U8My28HdnBiyk1aJ9kavBd0nLdyIQGvltFcHYEMbFf
	bFFylJu94RnfYqF7uit1tdTyRM2oCHWo/P0oBOWj9HoG+Uy5m1pi9q7mGU4ycm15
X-Gm-Gg: ASbGnctvE9T5LcGPHBGMfRexbA/juA73j1EIoVbnqup4ca7ORBLltaqpxg9j9C9RJ1b
	KhUqobSFHxYKFaJmpeOAAOiaPAYKg1cwFOzpt4bzAjKqSIHkqy164KtSVzGgdGQe971lGs5Xm5f
	H6J88tRNFyB1qx3Q8Eh3jfFZYtar2++JOj/Ao3Kf+t4I3Iyw9jK69I9Ix/Czg57oDaYND/AK3M/
	lfBcLFF55mhSN43jeAt+kIe6KFpewkDbNF9CEuhOjZzLlb6KErqii04ZcLeAox+38DnrtA6lUii
	nwY254wY1GuF2w9FV3o5vZ5LORH2B33Ey6F/0hnoDMAmGeNnJBGEJZts2bfUUhVgysX4H2Y5cG0
	T42NC/CPtXi+knEA1MBTpdpcGiVCE3Y5vBPO9nDnZrmQKlOHRaNXO7cfg1dxxryXVl9SORKSlD/
	pRwNXRgKBiaI1q
X-Google-Smtp-Source: AGHT+IGtID1z0YmR2i4wueCGyyoAY7Kcui1N5y3waYxRkqTCDXDFmLebk42/gxigc0vQTMajTi5+vA==
X-Received: by 2002:a05:6512:3ba8:b0:55b:8e7b:8afe with SMTP id 2adb3069b0e04-55e0082d2d3mr866385e87.27.1755616778027;
        Tue, 19 Aug 2025 08:19:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef221c79sm2141266e87.0.2025.08.19.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:19:37 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.17-rc1
Date: Tue, 19 Aug 2025 17:19:33 +0200
Message-ID: <20250819151933.681698-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 6.17-rc1 with fixes for
two fallouts from Neil's directory locking changes in 6.17-rc1.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.17-rc1

for you to fetch changes up to e8bd877fb76bb9f35253e8f41ce0c772269934dd:

  ovl: fix possible double unlink (2025-08-18 13:16:49 +0200)

----------------------------------------------------------------
overlayfs fixes for 6.17-rc1

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fix possible double unlink

NeilBrown (1):
      ovl: use I_MUTEX_PARENT when locking parent in ovl_create_temp()

 fs/overlayfs/dir.c  | 2 +-
 fs/overlayfs/util.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

