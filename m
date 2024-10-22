Return-Path: <linux-fsdevel+bounces-32623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514EC9AB9C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD741F23AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723811CEAA8;
	Tue, 22 Oct 2024 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEh5yFK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836E1CDFD7;
	Tue, 22 Oct 2024 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637916; cv=none; b=UAVy2p3xQjephoKrLXvO0Lw7qX+S8fSPC4d6FOIE3zdGvztH6dKeoAmvwJIfMfNTHsCNzGDg2+nwQ79HTdf3MxA3pMzGpvjkc/QA8g/wWwpskhyM96RfBffnb6vTWULpTiprdPkIXQ1UFVf/ZAulU7gxbv+eoc04XpZJZZEnb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637916; c=relaxed/simple;
	bh=x1+PEJH5Y7WfOvOGCPQDP//zahT4DuWweSV0+QGubUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozNLev8KzD+OXZvQBluZmauYRcd1sF+06i8OjnTalqMX/emq9R0IRj+6ceLtiJSV1Wc8kN0OtSwo96vsJUNOXSAdTar+Wh9abyfagug9UQKKEPZa8/fQJpfnr/5dGwnBgcjBRZtYBdrp5IOCZ6bJQnH6RyxANUfi5l5xsU8sdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEh5yFK7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so60967875e9.1;
        Tue, 22 Oct 2024 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637913; x=1730242713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTefSpBbgeOovSE9ayrYVWfLGl/T+HG9tnY15rc7RUA=;
        b=EEh5yFK7j1SkXP07A4PA1nBbzT7RRAdfgZHr38qA/OsZCqASobhqlojwR0LZlFIaJ4
         5O4U0+9gW7ffIvIaORt9hjB+rB+2Ny8dfcqy7rTKfRDgvTqOE9MVe7nZ4T7qGe2Ywcyx
         Fr/ooqDC/XJANzs0F8eMDzn+l6iDcL+3gCMHPXmY0Q+w+ar07zr+c41vtukZ6XPN0zbI
         pbh1XjzqIfDXNTw2Bs4G0P01uq5TYHcRP+67iUzDzqpcASX8NjFt1wEXur4VNpIz/V0Z
         XfZLkeeE95iUGAek//Q1vnBz/gpSK3OGX3teEs7GlaRaoLdBQ3Yn9GuOc0hnmrRLi2hk
         9roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637913; x=1730242713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTefSpBbgeOovSE9ayrYVWfLGl/T+HG9tnY15rc7RUA=;
        b=Zi024HsEdJzLWFfITs/lK2A0O5Me3wP4+OXmrCweF5bmd85TjHWrutbe+KBNzfKTYf
         t0McVn+uF9WVFpDUbCqQgPzRjBuzhr1qs7V7W2hNJ030saHiaKHGt3IWsRZE6f6K3/KH
         MzgTwPuxCFCWKE6hdb2SF/YaCFwQx8kYtF2ejsyK0o/dOGjR/rdPm3IEq9f9IPr17XNp
         IWW0f0QNrrAtc9O89PwLA/1/vrMo0i4g1t5sIL/bnPBPZRXLtCC3HY7wUdxmng63dBD0
         2FK8m/O4RNGqIAek8Ev02lqCaxkcqphmRR3IVVgBiS9Wns9AA9pKdiRNo1Ee2CMVqio7
         MzCA==
X-Forwarded-Encrypted: i=1; AJvYcCUFNN6IStnQQfhT22tJ73QZ7qp60HRiogfMME5jvMDwIejDn6O1DrZYlIoAFFUmA7KTBF0CmdjQNUE1EIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Jo5o5G9OjNcj2UuiL0+RZL3ShDBzVgAUMtF3dNqfOaLZLxa9
	OehYVGtUdUoQmjEhp4Ru9d5Ppe7rVk4KDm3OwzrChiwOGYgwZPt1
X-Google-Smtp-Source: AGHT+IFQ6O4iV768k4x9j/Zn2bH7Tum/ibsAMk0yayBcL4Qoc1RzJvTmfNiErPdLOnQ8T50ht7YN9A==
X-Received: by 2002:a5d:47ac:0:b0:37d:4d21:350c with SMTP id ffacd0b85a97d-37efcf0f6b0mr350842f8f.13.1729637913321;
        Tue, 22 Oct 2024 15:58:33 -0700 (PDT)
Received: from gi4n-KLVL-WXX9.. ([2a01:e11:5400:7400:5516:dcfb:6202:e47b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bcfdsm7563655f8f.103.2024.10.22.15.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:58:32 -0700 (PDT)
From: Gianfranco Trad <gianf.trad@gmail.com>
To: brauner@kernel.org,
	josef@toxicpanda.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Gianfranco Trad <gianf.trad@gmail.com>,
	syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
Subject: [PATCH] hfs: use kzalloc in hfs_find_init() to fix KMSAN bug
Date: Wed, 23 Oct 2024 00:57:33 +0200
Message-ID: <20241022225732.1614156-2-gianf.trad@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reports KMSAN uninit-value use in hfs_free_fork [1].
Use kzalloc() instead of kmalloc() to zero-init fd->search_key
in hfs_find_init() in order to mitigate such KMSAN bug.

[1] https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d

Reported-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
Tested-by: syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com
Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
---

Notes: since there's no maintainer for hfs I included Andrew as stated
in the Documentation. I also considered to include the top 2 commiters
to hfs subsytem given by scripts/get_maintainers.pl. Hope it's not a
problem, if so apologies.

 fs/hfs/bfind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..c74d864bc29e 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-- 
2.43.0


