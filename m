Return-Path: <linux-fsdevel+bounces-19095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B88BFEC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DA01C22B86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC527CF16;
	Wed,  8 May 2024 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DFQkHr59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37777658
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 13:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175020; cv=none; b=ue6qlMgc6gQkBDjMGHumrwoKrjsQi3HdFQEaFiMjOoU7/LSKU/Qb4BlVRwyV6DXUKcmGHmWWmAA97dzgNU9UQGRdCO2kHzuExHS8srmMoin3RlVLuqdvjBdVfp+uwRTUGR7h96OYdtW6Jt+3+ITxyxKFgA1eEFL8N3Hyun26vaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175020; c=relaxed/simple;
	bh=akmpdCt9PZJBsPQVJ9q8HZ+ova6kEltuOv/AcpY1sBE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mgPq3VOPYaGBUOD+3p//D+5DQ6Nhfb6oXWr0Y5ZAb8eV0HgS3sR5veonvSa8tsy4NFfjTqVDchBDvfY0+KMTulIz7aEj3nlBHK3Tv5awOUdePRx+CY19s/KyaZnosIgBdEU2pFUZDlv1wDnmVlEsE1Ki5oi/ImLm0hwuozYuWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DFQkHr59; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso1457225a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715175016; x=1715779816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nTmp2G2dqhkUnf1OiPwHt6oMVXv2UiakGWOKDLhbP8A=;
        b=DFQkHr593W0pqz9TF3KYSgrbxQ+3dGHpsdKJD1MvbUs6cTxFPzTENCHgT9baTxu7aH
         S7Dn4qAV98zIoMI/OKlAx8AWiwsd+rOOG7twZcNkNsJjOWoFsSDN5bxutQarl5EEUem+
         79XQ5eS1Jho5atBhETvTbO9QTtsMLaAIUD40s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715175016; x=1715779816;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTmp2G2dqhkUnf1OiPwHt6oMVXv2UiakGWOKDLhbP8A=;
        b=f8yTdxEbhZ0jJ5MuZCvb6Wmh/I0xBup3vUEsdCkilFbLW6SqIDNueb96GmWbS1Qf4v
         d7iNa4T432BFGoJwKtV44uyACMw3jQp8vn+VQ9viMioz0CDUI1bWTAakevf2ATL+IdgX
         A6Rc4FtyyWQ2WQynIMVNbKAs1++JVVx0KjirA3F86OJGKqC7hnzxX3Skm8HZBA4E0pa7
         ht62rm5mCvI/HOsDfvV3btiB4irxDh8SwUsyalwoCmIIX3ipOOX6n8otBi4moi2aarF4
         DfbHT1qLxT3FL3mXOUlga0RqYjIfE3IkOLsTFyNmm0KZMfnkG/soKL6i42zRcSNmHUXk
         GOjA==
X-Forwarded-Encrypted: i=1; AJvYcCWAUC7wYaRykE7G4b3QxSEYTZLfhDoT60VD6JxzW28/HZ7AWLTbcbET8Mi6VHcpJ1VlRrFcomtIUXYuLDyiPVTKczbolF+47HQTk0VIYw==
X-Gm-Message-State: AOJu0YwCwdUrO56vvJbQYpdbQMLXxZY/p0Me6by3kouYJ3G/vXEK0wbd
	zGhpNYdp9+athqeYz45V9DBhmsK0YfhH4dxDsMdYcacjqjpLGnbpjVijMQhjlTCX7SlRsNDGOM+
	Au8XwZAvbAZMXFxj2IeFF8aX7xG6FIEluNn75Cw==
X-Google-Smtp-Source: AGHT+IEniMP8c35DPg+c32/P+V27cSLn810RvFXG8aas43eYWQa/g100+wlMJIeD1q9cFqtyRt9cPoNAkSKL4zOBDpM=
X-Received: by 2002:a17:907:367:b0:a59:9db2:e2c9 with SMTP id
 a640c23a62f3a-a59fa88999dmr234427966b.15.1715175015612; Wed, 08 May 2024
 06:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 May 2024 15:30:04 +0200
Message-ID: <CAJfpegvtjodd03R4KjaMg=V9gcCHK3Js3GP-s-8QRcpTJ_TMQA@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.9 final
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.9-final

Two one-liner fixes for issues introduced in -rc1.

Thanks,
Miklos

---
Amir Goldstein (1):
      fuse: verify zero padding in fuse_backing_map

Brian Foster (1):
      virtiofs: include a newline in sysfs tag

 fs/fuse/passthrough.c | 2 +-
 fs/fuse/virtio_fs.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

