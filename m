Return-Path: <linux-fsdevel+bounces-19994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD568CBEFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6491D1F22FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C97A715;
	Wed, 22 May 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NiXbxpWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17418172A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372441; cv=none; b=dKBv0BvwDD88JzNRCIrVaN9tkK109is/S05uZU8UiBan/w10wtkcrdSbeUIiWpNNb6G+q5Wn6T8R3x5sS9UKEHltFDgEGNvyIC1gRjaOxf1Z+PspHClXTR2ViGX/sEj0HLreCv/O3rUN2XU03DjCNcr8U01oc2L5clzohYF16DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372441; c=relaxed/simple;
	bh=RqePpTznJ6Hg/lj+jQxcOKg1VXZcl9fRFJo9qAUvH/w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ENMEEvXRYs26qqLj5QStBAiIvC2yIsM+F5IQDQWbm8kt2uShZ2CGODZuOxEHFhBOPnawzbZ2jigEKjRXyCESEg6aTdpL1pfiyJQ57jDvl7Vxw7FregsGRZmxiO9j4I7n+a5gOJ7NlzRw+Omb+Tz31vz3WxYYo4E7ZVLRi15KYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NiXbxpWa; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57825ff689bso1881910a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716372438; x=1716977238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I+PGeb1jwb4dMj4ZXBFkbCVxNbnh5wpO/o6oygTVLc4=;
        b=NiXbxpWaHS84polxmTTph/o3pAqschY1zxuTeIN4LjkXzGQfGrRZ4E9igJT6m+pWHb
         I31jntXPVvAzcFRgYmAFCCEDJkuBbkyUa/J7WW3kim2/D8MYvf1KQVmoDG0Z94m1FMv5
         I2PFGZl8pZmGxKdxZ7Um5PXNFA30eJ0hcySLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372438; x=1716977238;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+PGeb1jwb4dMj4ZXBFkbCVxNbnh5wpO/o6oygTVLc4=;
        b=h6VcX3II0c9ChZAAYchZJFTNB3Z46q4+0JUnSoJwZalCl/SsAjrFwxojYrkCD4JLuo
         ucxWikHP0TliE/7KTVsTlvryRInUBm3CntWHj5Gnt5KhQZ8GPkJI89i6TbX1Cd6Ul5/B
         IxZB8v+HBBuQYxXnmqhMc4aEuCcKfgYEkI4Oj54bMBKnWadpknqg84cujJuwj8PZ2Th1
         6BLiciKRrJBfh2z4Yra39Ha6dYXt+ZhbR9lQTa0e6IgdlU6T2mjPtbs9T/8E7r8WHuHK
         oNRHS5jtnSnj4zG85Xo9zRjRxHEeXvy2h0+KykyKPiJze6Ag+xPg7270FEeGLQnrqMj4
         c0lA==
X-Gm-Message-State: AOJu0YyVcP1WdGBlWp2pt4IzOcvk6QYjYH7XgoZluJQ9SGkt7H3/Tsuv
	8PfwIxDrtkqTubnC96BZU0xsFgg1UQ3XZ9TIVGl6pRLG7lUXH+GQN/sZe8O6rt8WE6VDY7IWgjB
	ncS/BLMj7NlskDfUbVdbDbpnwY2auQqgRmtQTVL3Zk7kQcMgH1UU=
X-Google-Smtp-Source: AGHT+IHqv6bB6B3rMDBM8tHyL/Ss0Wbypm81kMKQwLrRqQgLiEOBdPj2vhCsgl87SQZa5eRQlt2eyNe1Gg/8uqBdEpo=
X-Received: by 2002:a17:907:7847:b0:a5c:e2ea:ba59 with SMTP id
 a640c23a62f3a-a622807cb10mr76782966b.29.1716372438209; Wed, 22 May 2024
 03:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 May 2024 12:07:06 +0200
Message-ID: <CAJfpegs9w+yNAvFCj9Ne54H6WMCJ9T16CrNDO-NRJwb9V5ieTw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-6.10

- Add fs-verity support (Richard Fung)

- Add multi-queue support to virtio-fs (Peter-Jan Gootzen)

- Fix a bug in NOTIFY_RESEND handling (Hou Tao)

- page -> folio cleanup (Matthew Wilcox)

Thanks,
Miklos

---
Hou Tao (2):
      fuse: set FR_PENDING atomically in fuse_resend()
      fuse: clear FR_SENT when re-adding requests into pending list

Matthew Wilcox (Oracle) (1):
      fuse: Convert fuse_readpages_end() to use folio_end_read()

Peter-Jan Gootzen (2):
      virtio-fs: limit number of request queues
      virtio-fs: add multi-queue support

Richard Fung (1):
      fuse: Add initial support for fs-verity

---
 fs/fuse/dev.c       |  3 ++-
 fs/fuse/file.c      | 10 +++-----
 fs/fuse/ioctl.c     | 60 +++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/virtio_fs.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 130 insertions(+), 16 deletions(-)

