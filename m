Return-Path: <linux-fsdevel+bounces-14764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB1287EFED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 19:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A4F1C21555
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557FA38DD9;
	Mon, 18 Mar 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="FdjGk33A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA92837D
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787419; cv=none; b=qSHaSn9e7udIQ1265Xpx9Ik22UqjpFmbYxX329LMtFVJiPeaZk+oLDYgj9VjD4j51pIZtOtxPK8v5EDqXsPM4gveKZrdZ6KDTf/S8ZV5CxycgldPbxddc3c8jqiBa5sNdpV6bQ81Dmlrjvrmk0XV7qjO28WEdoYKJg27kYTTsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787419; c=relaxed/simple;
	bh=r1LSqF/JinUQWJSsN0OUELOLOFK8eHrasFlFpPDIwEs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Bx+OdtZepf1v25i91m9MfGBBSdUp2afLMZHovJD3tCYsJ0cYPo3/pgZrkd380qaZYMcsvvE8QJFmiFmviRjHIXWjq4URm2Y2TcYDxysJL2F2FOHfldrHknOe43XkEizFCuMyo+rKJfaUkrkPvqBDA74M9Md9ayO5Yj2vw+FRHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=FdjGk33A; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4340509276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1710787417; x=1711392217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwfNzMrPyHMimoiUInuyyd0VhXrOiwGqLq6Wr7mPq0c=;
        b=FdjGk33APToC4oySOc4zwnTLA6dk1c9E/YEwSpcH4vG9tGD/l6B2yup+PiYiG9ezFs
         QzArTOC4wuy/JhnQNtCMjPNIjCyh51xiSiTBNdI7YWdsRQPb32I8DLCBlundg+1/kRhM
         nLbOGVUKgb9nhI+K7NpSUhdrLS5Lce+uso/ytaDFiJN2x6JVSUUxoLpr/wZbZBq240Us
         wGNGrdWkE/MF1UbsHmfUh1x98Ch4vBpJN9JArKKu73/DBkxCbFz1bwIofVd8CHa7VWZU
         CLrlAYWNd3tVo8FXmPXxVo8hwmMaLIrwXHC17HMiamsf/aoTtCIOTPGw/YCW3ENHbYdv
         nVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787417; x=1711392217;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwfNzMrPyHMimoiUInuyyd0VhXrOiwGqLq6Wr7mPq0c=;
        b=PV+8JJs5CwbQGUQ6s5yS2w95EFnQCJYh7qfDHBa+zx38elt4RT1rdkJwgB6jqFAB0O
         pgyPxSVis2+gJRdxEeKaA61A8gwl4yqSpAxNmQ8dySI7c5/sQ66dG/E0zP3OrFfzm7ww
         g2thKiyM0m7HxqlJNfswEXh6I1grOb9sF+rt06/DZH2GWQ7Ax9rKWXp9F8i3ae18HzWM
         JpuJYWb93EhfTZqwBE+o5X12F1Tpo6Yb7TYD3Mk7oLMs52gDnhodoPo82vOcvpuERojr
         PmLvKrFrw1u/vto9Fpwj0EW9j6nHPwa/AV3hkA+3a7tInFn5Nsw53EiO8W2FDrQBDDgc
         hL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMw6utIjARRFX4mYXH3xHMoNQXKKdaAjO4rc9nrZdCdi8U0J7as+g2KzQ1SmOsSwIIR+lXU266S/Mn5Kp/xGY2XFeQLUMtEI0raxq08g==
X-Gm-Message-State: AOJu0Yz3f/trN5aN3pbYx6qviZn9TddWP+g6bHQiGO6s5/JBqc6EhsWT
	sMAmx+Dl9+CAk2AN1leU1y3xqxDhfqpp9x5EtW1OYGJamalzBzdMreMPywa921rKdYwZX1MGtpO
	dwpvGyQ/+gjTP5sjC5cIhtBEmxQ4dWyroNyGb
X-Google-Smtp-Source: AGHT+IFPTSoVQeCl4K23xshVdS96dFIPuzVHsWtZw7eVBSoCmRhr1VSbq6A5pcTy4zBjjeNZBFeHgRiOT0pOZqD6nDM=
X-Received: by 2002:a5b:9cf:0:b0:dc6:f055:c16d with SMTP id
 y15-20020a5b09cf000000b00dc6f055c16dmr9959522ybq.36.1710787416946; Mon, 18
 Mar 2024 11:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Mon, 18 Mar 2024 14:43:26 -0400
Message-ID: <CAOg9mSSsSvVzxVfkyv2vNoYNE50pLpnm040K1eA+2KV281ugGA@mail.gmail.com>
Subject: [GIT PULL] orangefs updates for 6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Marshall <hubcapsc@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-6.9-ofs1

for you to fetch changes up to 9bf93dcfc453fae192fe5d7874b89699e8f800ac:

  Julia Lawall reported this null pointer dereference, this should fix
it. (2024-02-14 15:57:53 -0500)

----------------------------------------------------------------
One fix, one cleanup...

Fix:
Julia Lawall pointed out a null pointer dereference.

Cleanup:
Vlastimil Babka sent me a patch to remove some SLAB related code.

----------------------------------------------------------------
Mike Marshall (1):
      Julia Lawall reported this null pointer dereference, this should fix it.

Vlastimil Babka (1):
      fs/orangefs: remove ORANGEFS_CACHE_CREATE_FLAGS

 fs/orangefs/orangefs-cache.c  |  2 +-
 fs/orangefs/orangefs-kernel.h | 10 ----------
 fs/orangefs/super.c           |  4 ++--
 3 files changed, 3 insertions(+), 13 deletions(-)

