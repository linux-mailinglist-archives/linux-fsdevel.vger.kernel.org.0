Return-Path: <linux-fsdevel+bounces-16325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC289B2C3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 17:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9601C21832
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2839FFB;
	Sun,  7 Apr 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7O+K/np"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E039FDD
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712505488; cv=none; b=M3PBqjprBXfVBuWPVptuEUhE0PkfkfOEtYL+nZNVgBlDk1kh7UmeVJhGcQhZp7TcTbZRQ7qE2QJyRjreGhEjlhhz3jii1XKStInAI0LDI5dCmONk0vu9USCcjRNYZIACyG3JDvyZ6H3vIo/2Njtm8mCzBKrnwucf8HQxfJNIzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712505488; c=relaxed/simple;
	bh=yCc6+e4zXT7k3MYoTLYNOYa+muLaxipbryb63SXDK4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nQ1isAgsRjFTBd4DZISPi+N0V9JYylt2DiVAetduInWXGWHnt4puzA0vjU+m1xr4CeV2DLqN0raJ9wE2/IxCfYOsBXRLKcKgNgVWftKydQzApzHnFmH4aEbRj/MmdA7xdOaChRh1vB77ncf/O/XcrMdjUgUNcLR/N5UqBAzd328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7O+K/np; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41650de9e1eso2871335e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Apr 2024 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712505485; x=1713110285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0Twl5Io0VZf42Jcw3pLhEF5klf4k5UOd6dNJsVDvuc=;
        b=L7O+K/npBjtVGaPaNTN0HcuDwy0hcfBX7Aejg4djKlrn5dwGPnwEe/8xPYWm9YbEQb
         w8FXXJjZwtmEjkQkD0kqOLfDAGgIGwQlavJi0V5FiKIyHBAWfVvKNfutxZhExAg39OyT
         ERv2YBJehRcu1vYWoVEHR27wcH0Rl3LRHScndz55cuwpBBDV22PxNX9ILjwH+cokaN4Y
         UlLC+f7BKJ3vTYCsW1MjPXFVUVblMImpXWOynvGDxfne79m7tugE0sE3fuYu3h9FW1y7
         s2L7Ieje4zpCPmLG7NDolYJxp+hoFFwT25OBseAjOfIDVwV09wSp1Hrof7drClF1FPdX
         faEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712505485; x=1713110285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0Twl5Io0VZf42Jcw3pLhEF5klf4k5UOd6dNJsVDvuc=;
        b=fa+QgmnG7tlqTTwiQlS4b4V0vy0zx4QtT9rrHPMcD9GYdBGTAqTI6iG3ut5JFck8dn
         s0vdWqGc5Cx2EAzHkuiRJEhwzPz7KIGfyb1vMNIMk72bVEVr5DkFpOEf7REJxdOv3Rsz
         xkMw9v/8uLXv35F8+6zHphI0y0esP2nFrLriVcnG2w2ypL+8tzAaZqNjV6A0U+GcILKY
         3cbmIvoEODzoZafxVfBdRGrV5rU2F0kHmVeFyiCxY7K8lxhaAnmHbzVyg8UdZuGvp0vK
         IXXoHRdb2IuII5J5uGHSj9rM0HPwLfXioRWkUsM3qTcOfNvevBdpt4rb/G2+8gEgFft3
         MleA==
X-Forwarded-Encrypted: i=1; AJvYcCWam5I9vR+pdYDVXr8S1D29mQM3XB2OP5G9PmR6ksyuv5dTL9Knvzmj6Vb2kZ1RhuonBdlnmhFfLroPRjfeeGZYsyRySa6F27zIVEO7DQ==
X-Gm-Message-State: AOJu0YzgzZHoC77CjAoKVv0XVFVekkPwAP6+AoQuC/aUwDbaTCFuHzMM
	1uRhs6OThwvGE1uHsvU2m3/kBIuHzVU4i3Q3AtDYJVeY7BH0eY1Y
X-Google-Smtp-Source: AGHT+IEf8Yarz1CuHIwFgr7wP+7LMKSA1oHLSC81/cfOaFHMhZY7tLaZKpQeDGzM5DRsRW8Lm3He+w==
X-Received: by 2002:a05:600c:3b08:b0:416:2b7a:fc44 with SMTP id m8-20020a05600c3b0800b004162b7afc44mr6880938wms.5.1712505484960;
        Sun, 07 Apr 2024 08:58:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b0041645193a55sm4600171wms.21.2024.04.07.08.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:58:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] FUSE passthrough fixes
Date: Sun,  7 Apr 2024 18:57:55 +0300
Message-Id: <20240407155758.575216-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos,

While going over the code to prepare for getattr() passthrough I
experienced a WTF moment that resulted in the two fix patches.

Patch 3/3 is included for reference and to give Sweet Tea a starting
point for getattr() passthrough.

What puzzled me is that some ff->iomode state bugs were so blunt that
I needed to figure out how I did not see any WARN_ON in my tests of rc1.
There are different reasons for different types of bugs.

1. For concurrent dio writes without any passthrough open,
fuse_file_cached_io_start() was supposed to hit
WARN_ON(ff->iomode == IOM_UNCACHED) if there is already a dio write
in-flight.

My conclusion is that the set of fstests that run on passthrough_hp,
on my small test VM do not excercise concurrent dio writes.

2. For dio write, where the file was opened passthrough, every write
was going to hit WARN_ON(ff->iomode == IOM_UNCACHED) and also
fuse_file_cached_io_end() was going to set ff->iomode == IOM_NONE
and leak the fuse_backing object.

However, the bug fixed by patch 2/3 made sure that parallel dio write
would always fallback to exclusive dio if file was open with a backing
file.

Testing:

I ran fstests with passthrough_hp with options:
1) FOPEN_PASSTHROUGH
2) FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES
3) FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES

Did not observe any regressions (not any improvments) from rc1.

Ran some multi threads aiodio tests with just patch 2/3 and the
assertions in fuse_evict_inode() from patch 3/3.

First two configs did not hit any assertion.
The passthrough+direct_io+parallel_direct_writes config always
hits the assertion in fuse_file_cached_io_start() and always hits
the leaked fuse_backing assertion in fuse_evict_inode().

Bernd do you have different tests to cover concurrent dio writes in
your setup? Any ideas on how to improve the fstests test coverage?

Thanks,
Amir.

Amir Goldstein (3):
  fuse: fix wrong ff->iomode state changes from parallel dio write
  fuse: fix parallel dio write on file open in passthrough mode
  fuse: prepare for long lived reference on backing file

 fs/fuse/file.c   | 18 +++++++-----
 fs/fuse/fuse_i.h | 10 +++++--
 fs/fuse/inode.c  |  7 +++++
 fs/fuse/iomode.c | 73 +++++++++++++++++++++++++++++++++---------------
 4 files changed, 76 insertions(+), 32 deletions(-)

-- 
2.34.1


