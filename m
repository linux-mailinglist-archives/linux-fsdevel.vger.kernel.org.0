Return-Path: <linux-fsdevel+bounces-63831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C049DBCEED9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 05:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC71D19A1D76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B33347B4;
	Sat, 11 Oct 2025 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEWhsjzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043CDE55A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153437; cv=none; b=HwA+cxDNJltfNZfIyzjKCN5Q10vUv3q8EOIG+tDymwXI/WPoDwhWdok+qaHfZSZluowfloYKPhe0boAym/ZMN/LGNLeyTSNNNPVzkiFvyFttultX+KcC+F8Ttoc4Y3tDfPQjTNjXvG2LiTsI2DJScdjMclgUxCb0tY6odGPJW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153437; c=relaxed/simple;
	bh=Z80sDuh2r2K1uwZc7/gJ2dh8n1n4WacbpmU5bYMlaSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFZoZlD+joSlafTY+FCvXRt7PW6zolIUOoz5dIZy8MDovvCU79H519QnURzRrREwmH9+Is+SUj1ovFOUVrZnjCnK/RQk3q3E75lNPi0CqeOUnxiNaUPxBjXMN0CMoz5k9ghDSkJ/fg4HZMupGfixuFMheJremoiJ/Cxd4pSKh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEWhsjzB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330469eb750so3391478a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760153435; x=1760758235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sYbk5VmU4v1pNPH+Fa3K2iS1n3qdqJuuATj2vp0zUU=;
        b=TEWhsjzB35uhN82H90B3cDx6rv6lVsu4P2BlgSHMYjIB8fXHdmvLYF0rrWom+naOiz
         eJ2CrffxyF5WmjZMEG6IVV6P88fWDdtk1CHeu5ZUAUiXeduvcHMY83eK0otF+Ll5tl2n
         QAlAURS9KY4OZncZ5buFe+rNSoGzBFeOZI+WaojG5noeV07WQ7daYUgNEKFEfniTD27f
         krcUQgsLTsr8vhuMs2ut2sOWOOdodaqUoPYjCJl0OQ9abjb5JxzXsT443eD0JiKVjnna
         21n2Id88BfTBiTrVMOrpCOp6/qU/ehgpj6UfI9MVNjGDuiSdn3AE1i5TZ1TF9P8co5M5
         0LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760153435; x=1760758235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sYbk5VmU4v1pNPH+Fa3K2iS1n3qdqJuuATj2vp0zUU=;
        b=tzjafA9vo1iL0TwEIGx6obQBX+S483JqP02n1Np4+tCc6Dp7Q0HtYDdPEdYBG439jy
         OaBUOx2PU0lMs8pNrYmFjwoTPYebjex/QvE9AFs7hjVsADK7k9k9N+zfNcLsbPpuzgOC
         PnFcf/qHBIZbAXthie9FO4c9+AwdBUNPD4ETeyIFpuK3X4IokLJjNDAGbZYeBwxwuJOI
         oGuDnfrDgyxlVoSdV/5z2LSl06soeG4b3ADL+UxSJ9Bj7gwmk2KujYJq/RCjXvzuQ/0F
         Yf2esNIC5fwuHpg4W8pKqpgIq09XvvcsWl6wgqvZm7JeUGF0qmdZ98roe242sXXt+wo1
         0f9g==
X-Forwarded-Encrypted: i=1; AJvYcCUzaMBc3d/GyYphFTRwJKKmQOkBsJvLxuX1kq7mZd+F4RQrH4m92zbmwzk/oWFmpu/UPO1CrWH3AoCbBHKu@vger.kernel.org
X-Gm-Message-State: AOJu0YwO6gFAv6t2x7tFOcUJV2SwmY03hwLMurA1rSe1VBb2rcSvmuLk
	a8IFPO6oP/FGptgfaAfikimaxVePZdHtSuJEmdLYV4loa4FKFVsBnTEeBv0MU1V5
X-Gm-Gg: ASbGnct6A/JEaBQBszm6DwjmgrlxVHLty2IwVmESbSSi7Hp4GsoUJiY8GiCZUp2+rDT
	XR9EVHZQ32btwNNfcgtbbav14XQuou+aHJldn/Se/s4Fq+69hXVNV99xBBIjqvdGuuTaVMAzJi9
	bYseto/IUHNiKOwidcozuPrW9HM+il3HeHnPRdO+aBSenednxoIPjSojcBfmleI1egzw3CQZRZT
	3dhqSnB3bZ7LHS3sY+oJBOYaP3btM9iU2PwBs7FNYi5hywBpMVlJSTJzwb1ls98mqgLsr5PKcq/
	OiO1KVoL2YZcuTOpDnftvuxGw9P2q3W8bHnPUU5sku0DXM+leAsxzjgV8ZPUJ5bzsLIbIPJuzrQ
	TDMbyTjeCrM6HJ/7/bvn5TcgnOjWH1qzaKVJO1Ez7Mmkln2Y5g59cE5oadpNXIqQZ
X-Google-Smtp-Source: AGHT+IEVIfe6WZXTqBnz7nHlm3cwkJC0ZhBYUyRpN3slh0vrMoKKnT/vtaUEkQVAZyedNiVv/bJUOA==
X-Received: by 2002:a17:90b:1e0c:b0:32e:749d:fcb6 with SMTP id 98e67ed59e1d1-33b51118ef7mr22146055a91.12.1760153435086;
        Fri, 10 Oct 2025 20:30:35 -0700 (PDT)
Received: from localhost.localdomain ([104.193.89.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm4215540a91.7.2025.10.10.20.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Oct 2025 20:30:34 -0700 (PDT)
From: Wei Gong <gongwei833x@gmail.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Cc: virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Wei Gong <gongwei09@baidu.com>
Subject: [PATCH] virtiofs: remove max_pages_limit in indirect descriptor mode
Date: Sat, 11 Oct 2025 11:30:18 +0800
Message-Id: <20251011033018.75985-1-gongwei833x@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Gong <gongwei09@baidu.com>

Currently, indirect descriptor mode unnecessarily restricts the maximum
IO size based on virtqueue vringsize. However, the indirect descriptor
mechanism inherently supports larger IO operations by chaining descriptors.

This patch removes the artificial constraint, allowing indirect descriptor
mode to utilize its full potential without being limited by vringsize.
The maximum supported descriptors per IO is now determined by the indirect
descriptor capability rather than the virtqueue size.

Signed-off-by: Wei Gong <gongwei09@baidu.com>
---
 fs/fuse/virtio_fs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 76c8fd0bfc75..c0d5db7d7504 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -12,6 +12,7 @@
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ring.h>
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
@@ -1701,9 +1702,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->sync_fs = true;
 	fc->use_pages_for_kvec_io = true;
 
-	/* Tell FUSE to split requests that exceed the virtqueue's size */
-	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
-				    virtqueue_size - FUSE_HEADER_OVERHEAD);
+	if (!virtio_has_feature(fs->vqs[VQ_REQUEST].vq->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+		/* Tell FUSE to split requests that exceed the virtqueue's size */
+		fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
+						virtqueue_size - FUSE_HEADER_OVERHEAD);
+	}
 
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
-- 
2.32.0


