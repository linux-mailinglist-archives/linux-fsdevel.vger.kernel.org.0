Return-Path: <linux-fsdevel+bounces-28713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A67196D603
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C013DB26C52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466DE19B3EC;
	Thu,  5 Sep 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W65BjEy3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D11991BE
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531873; cv=none; b=GwwKuJWrDxFuS5809wOdhg7+fAJ2MEGd0UE2DqC8+8CcKmiGzyVzTBgveRnNuiwv+7uaKmVGxSyA1zqRLd5YvPGWOnE7lEzOQPDV0c1PjUTCj2ejiAN2+8LjDPoeMA+4smQHUAOdISQdxPDwFxf8C4SeDeuExRNsDCqvojjSQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531873; c=relaxed/simple;
	bh=4QvaNv53VwpQxmWKJaO0cd5rVlygGoaLzyfS2iQQVtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EqqfdqTWl8jpWkaL6BHACzFKwaJ/vChKFzORZ6I0SNFGZMwl33UT9O0VnQ1cpy5nPFm8UHaldLsO1YErvQSKtristC/j9Z8TJVvxfy7bLNckojEgqvt4ce6TlzKbShUqaRL4O2mfeURKfxMvJzAKK0a8ocItowrn8uhp4tdcr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W65BjEy3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-717849c0dcaso483346b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 03:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531871; x=1726136671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxh5ie7x+NlOqhRmkSQ2AsfzKM+eGqwQ9HCS3rFoI4Y=;
        b=W65BjEy3SAK/QrEnF/9WyPF/ZESl76lhRJIdbDzWOf/TZ0YX2QEKommmdwQ5wmKER7
         DizMhFw2dMc76BKoyre0U+u0msH55Xdim3XM5qb6R2CuROoOA9thQvxghQxA3OuDFavy
         FAT605fSOeKIhJsum3OAviojmhqMxtCww2z5RKu4ygm2CKX1q+xdKuuhBNkJXmBnAFs3
         8d6S0DySFxow64sG7ORpf71Qq9doJrGpESyCcz+62OCUeFplkN6DlaS6bKd0Yr0ASbBh
         p6uvCuULtCMD7o1oIWbg57DnKTf49ffyZvK6/QILA/89oQ8R2zYxHVS+kniAwA5hKbQF
         9ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531871; x=1726136671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pxh5ie7x+NlOqhRmkSQ2AsfzKM+eGqwQ9HCS3rFoI4Y=;
        b=YWo6jzf7lZhbNb+3VgGWQ5YqqOT1BDxtmwWUlDOJMkvpjjevuJNBJwASEFW3+DP36d
         cL3pEACoDaM7bpXpIxzfcXnSZgehO5K1jz9BoI9SANosaJy1i5daK0hVDIslKk+i1yw2
         v0T5XVB14GqRASs7Hkl6d6kx+IiscsiIKOqt4NS6vUMU/8uf/hQ/LtZqIGFIrdi1BkLm
         7/D2N5vnKE2uyEgDxBxMfNCzg5c9GuDdtM9onLXQ4GciR9GROUkcj9gcoN4ePuB/QosR
         b0YyI7cH6SWTEzVYtPYugjZfo13ZCKQS/34lC4J8HKfZ4NzNB7yM4cGVzCVmWkaEmXe9
         zRJw==
X-Gm-Message-State: AOJu0Yxp9wuVR88wF7jubQX5OCJZp/zM5TLGa7OQi1F7jsJIramFaYD0
	b1VyaPYr7ZKWKGqTkcwHDXou49w1bCfvxEnAsdEDqb8n0T2PJkBdPTIuJ7IqcPQ=
X-Google-Smtp-Source: AGHT+IG6ImsUGLlwJS0dY12oSBPr+k8B5FCnlj6nHL4vaETzyuptME4i1E8PpH46+1alwKNPDqHQsw==
X-Received: by 2002:a05:6a21:3510:b0:1ca:c673:9793 with SMTP id adf61e73a8af0-1cecdf2956amr22417785637.23.1725531870696;
        Thu, 05 Sep 2024 03:24:30 -0700 (PDT)
Received: from localhost ([123.113.110.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea38cecsm26247245ad.177.2024.09.05.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:24:30 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	david@fromorbit.com,
	hch@lst.de,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
Date: Thu,  5 Sep 2024 18:24:24 +0800
Message-Id: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to unshare extents beyond EOF will trigger
the need zeroing case, which in turn triggers a warning.
Therefore, let's skip the unshare process if extents are
beyond EOF.

Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
Inspired-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86ac..8898d5ec606f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 	/* don't bother with holes or unwritten extents */
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
 		return length;
+	/* don't try to unshare any extents beyond EOF. */
+	if (pos > i_size_read(iter->inode))
+		return length;
 
 	do {
 		struct folio *folio;
-- 
2.39.2


