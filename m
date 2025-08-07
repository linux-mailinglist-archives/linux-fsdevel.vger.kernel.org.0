Return-Path: <linux-fsdevel+bounces-57006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514ECB1DC04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 18:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8A1626449
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4A271471;
	Thu,  7 Aug 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkLwyS6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4D186A;
	Thu,  7 Aug 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585706; cv=none; b=mhWWGPnXmts0bqqTWI5y3MzH+U15gJ9zYw9Jq3aYygfpnnfVpKAKFsFr5Q93jnMBBbApeUuKrFOcxaZR8ZlBdFF7XcV9DsqoU9SwNoIhN8u/+E42gzKE6IVW+16FqzstQABJ91jZqhf5KBo+RrHBfAOcvU92I5HR8HG+HwgRa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585706; c=relaxed/simple;
	bh=l3DtQRpYB5RTDk46I7413GNLIhcqwBDTYZT5TpROceo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkulGndO8a56FmboK+wRUSQkHb+k76PjHCMG08SVBzhsAPFHuOcLEfQ6oc5EqePIcjtzWZ5S6cZq1aIZu0vwU6XZXJGHyQPwCU5wzN3sHNXTakF8i0Ch1NSEfH7F6evBHezOcNN/fbamA1PE0mAalp3tUQco6ESWinSdxIo5Ybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkLwyS6f; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b4281fabee0so857772a12.2;
        Thu, 07 Aug 2025 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754585704; x=1755190504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq2W53PaksP7m4jbktUk0gHJCrNmSbCmS2yXdqV7dD8=;
        b=WkLwyS6fJCpHa7oHB2kZblWzW0c9E8cCTLMP0xN2OO8pIzCdUBoD/i8M7kXLqWM2vX
         m4yFCSeZzLzuIrvot8YitOK319waIWCBkKoPXckmjgEpNxjLUVSe03a379s4KmS2lY7b
         A5I2z64Im8w/ZAzlEvdFaPa1LbK1LFrYbeP6marVKaVX3/RgppAZfFhvUZQAGOHEkI7S
         KfEMCLy/t50sKvUUbZOKvnpRrYwg/rW7P8KJNfps6RddSHZhIoB8dGEVYHXFvVumWuIA
         tvUtBBj2tcS13Vpc13GRYsH6F3A2NBeRGvTSoRAGiwXxkjUbGe6uQbKLkU8vmaY5KlVX
         JmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754585704; x=1755190504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq2W53PaksP7m4jbktUk0gHJCrNmSbCmS2yXdqV7dD8=;
        b=bNhre4uXD0ps9l714ilcDtcsW/78aSWPC4Xk7y9q4JAhBwl0nbZNIZWVlCiW+shodj
         mg6opO/0EYue1gS2zQEi3FyTgmjyosnCJIzVOmE2w7P4VC4rsSC889nz/UqZo9/SlIJC
         shdgYlfz2LFbJlmoZIHPX1VEU+q01t+dg24/kOdEMLxDDkaj9sEGQI5iY8WTVLjBzqTE
         Q5jYgyK18Jty8iMXBT2d/ZfzYtMYrcOMD5IVTjrGAGAsPfgls9PDu/ob0jchm7zlkq95
         n7bj4wp0JSMrRffhDqlnHvibu9x6PE+2w6wg+IsBl8K5yDIrwmu4SUn14/UwNyQz4OIB
         quLA==
X-Forwarded-Encrypted: i=1; AJvYcCU/uwKBrMzbbG4pHixKLx9ZPSLEN1fBCBt7hY4sIc+vOU6snz+LTW9/f2mTrTlTqeYKqadD2hOqWSiMwjnU@vger.kernel.org, AJvYcCUG+Qx0mBCNKs7JE8vxDjOd0fBoS9/j18Laqz8tN5+VzJJI5j0lnKzqyWXuyTAcN/Yflxck6puv9xChvO2r@vger.kernel.org
X-Gm-Message-State: AOJu0YxMKg3v8nP+LAnUB3jzzbwAiG0b3+I3ifEjBb20N84atTXGwdfz
	OQVhN+VFKH9Uiqy8G+fohX2een7MlLMOOsCwGZr3+Ig4D0qRCV4cZ7JR
X-Gm-Gg: ASbGncvO87/G74+vxVoXYHtbZroZ/hwzAujAYccQLDslYvuir3DsK32vx1P/EF+kBOp
	30u9JPth8x5WBAADKRH+J74ZmAYU/4O6EfRDqkPHZZjois9VCyCC1aI9IJGpXbTjPJRcvsiNs49
	TOl9Vrq2hvibykt3vePuOYD/sxufUV97Azg21PsFXktDR+qNmT5VkuxWq4VuaLGdSoPpn5FPE2i
	uiz+8xNXLl/bc8R0QGxXr7xLGNGM0CZMF5F82WMmf/lo/8RVeQtGO61gmI3I0qiBOgOgrkllmkv
	KnKCeJQMK2BPP/unIrrCoOfS5VQkenSvBvlyN7oz1AeYSo6VddTpewqhZHebmg6lsarmcZgC19l
	7o79kLCxuuw==
X-Google-Smtp-Source: AGHT+IHjGIDdfLcH/CylLSuTLaAdxW/Bxe5A/6jb2R++T/jR61KPerOxYSQMKmtbz5TClTk9H2CWsA==
X-Received: by 2002:a17:903:2347:b0:240:49e8:1d38 with SMTP id d9443c01a7336-242a0b3e6b9mr99733295ad.35.1754585704228;
        Thu, 07 Aug 2025 09:55:04 -0700 (PDT)
Received: from archlinux.lan ([117.185.160.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabdedsm190575505ad.167.2025.08.07.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 09:55:03 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: Penglei Jiang <superman.xpt@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jialin Wang <wjl.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: proc_maps_open allow proc_mem_open to return NULL
Date: Fri,  8 Aug 2025 00:54:55 +0800
Message-ID: <20250807165455.73656-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 65c66047259f ("proc: fix the issue of proc_mem_open returning NULL")
breaks `perf record -g -p PID` when profiling a kernel thread.

The strace of `perf record -g -p $(pgrep kswapd0)` shows:

  openat(AT_FDCWD, "/proc/65/task/65/maps", O_RDONLY) = -1 ESRCH (No such process)

This patch partially reverts the commit to fix it.

Fixes: 65c66047259f ("proc: fix the issue of proc_mem_open returning NULL")
Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d6d8a9f13fc..7a7ce26106ac 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -340,8 +340,8 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	if (IS_ERR(priv->mm)) {
+		int err = PTR_ERR(priv->mm);
 
 		seq_release_private(inode, file);
 		return err;
-- 
2.50.0


