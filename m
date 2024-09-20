Return-Path: <linux-fsdevel+bounces-29774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500AA97DAD1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 01:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0AC1C21437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E7018D647;
	Fri, 20 Sep 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="T+M4tN9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A361C693
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726875691; cv=none; b=BeiDVHCk0G03FG1xe+3qoV/OThs9V+2zaN8OUxraJ47x2nkxp1sHICNVEryDhbw2Oy8IRjtLOZJppvglEQKunqLI6fMx4NYVhYHSLiOx8x4a4IlORBTcoMtaOU0fQyTLS1VxpkFabkPXo7gXvYCecAls1Qor5gD7vfKFyW8DE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726875691; c=relaxed/simple;
	bh=BWbr7lgRbE1fc81eCV90O8aJB7YrFzUOlrsqNgjVbO0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mIOqMiyP4yY/UJebiwkZgT3yBsv0p4mq3r5aYl8KBgWzC2NhkPie5/t7LZmAVO5KPGE9vb3QjhdzJwuMr3A8mjCdlLRWpgqKtA4TssJa0pBZGkTnbcEeRfqiZJNVMif/+wNEUBnV/wWEfe4a86eUPRtwexv6MkoyrcW/6klRvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=T+M4tN9r; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581f44b9b4so17458491cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1726875689; x=1727480489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CS7nHL0YpSltim+yTiE07vu+ADr6RRyFUsXhX72Lm08=;
        b=T+M4tN9rsIqP1ECpVdZEWRUiGtvH2ad2nApcqaPb4h1HwSTtcgYrWXh1fdKwQBWZJZ
         K8KkfrFRlyauLJJIKEOXBDfAGXl/2/RJY+8VXMcRLN7wV4I35Q+NRWAjmqQfOL1uVr+a
         nlP15TPD6Vkhl0xwRiGcj1encmIt3V0y37XduMqUCce2AEb5GPB2V5EOI42xqLnBRH6+
         SW+yq9Cun2gNUcm8ZvjQOUbyZecVCI0BY/Jx/nX7sqYp9bkh7JjMoM1CefXPPcNzAQmT
         sOz+ryjaPgoXpmbcpOIOkyyFa/RtH+8j/KmHpXHBkqhMmZ7ewa7nJo/pnrKGY0u6vo8b
         l1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726875689; x=1727480489;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CS7nHL0YpSltim+yTiE07vu+ADr6RRyFUsXhX72Lm08=;
        b=hryweEr672sp0iQjcK3fOzdOGc5t2AhqVeEyLAcNog/y1eKyLgxyCbD21s/cB+01+n
         jhrSR+heUwtm2kPTWRSG7aQL5T5waVpk6kyN16Irac/TAypSplogN7/ToYnbyIgrf0W6
         1DIvVHKDthSp07T6j+HAvuj/0zh/0hO540BXJ3g3zrXu40twrVxVPlt1QDmO5ceJA+rb
         iRpeMs1Ok52O+7QaXkTwcuJi3WQIi0CkS6232O9WQjlny74r0tkQtuqEYqYScU2a5EMu
         rrD88cA/bk8yWayFACs0YSKGZq3/2BrkcBiO/+e0JfaJXdLOI8i+kSd3TXA2eJk+PlIn
         04Qw==
X-Gm-Message-State: AOJu0Yw2+QSFjLLD14S53VQs854MGoTK5uAqw7JIowztThGUfpFEZDCK
	+xixkcyBE8oAQuJayEkwWv6VEhUqtUf4JkgG+ZQdNUKOJ0EXxpcUTGpuFKx1x33w8F/c/e6rOMX
	sZsjDoWx4Q6jZHuC4rpSbQnls+m+TBr7WK5UxAI8uunnfIFTf8w==
X-Google-Smtp-Source: AGHT+IG+Ixo9qjTFl2HOI5Xkq6nqqBs1gxciRek3ByfdYFARKrNFjKypDa9WFze+Mti4qvm3q73n7+DnFzd8+TnDO1g=
X-Received: by 2002:ac8:5d8a:0:b0:458:a70:d9b5 with SMTP id
 d75a77b69052e-45b204f133amr71475171cf.15.1726875688686; Fri, 20 Sep 2024
 16:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Fri, 20 Sep 2024 19:41:17 -0400
Message-ID: <CAOg9mSSU61P0en4i0aLF=+CiTXkV7LzkB9XGuJ3FTQBrq52BQA@mail.gmail.com>
Subject: [GIT PULL] orangefs changes for 6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus...

Sorry I fat-fingered my tag...

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linux-6.12-ofs1

for you to fetch changes up to 96319dacaf15f666bcba7275953d780e23fe9e75:

  orangefs: Constify struct kobj_type (2024-09-06 10:18:17 -0400)

----------------------------------------------------------------
orangefs: Constify struct kobj_type

----------------------------------------------------------------
Huang Xiaojia (1):
      orangefs: Constify struct kobj_type

 fs/orangefs/orangefs-sysfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

