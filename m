Return-Path: <linux-fsdevel+bounces-57345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EFEB20A09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD61D18A5F10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64A2DCF56;
	Mon, 11 Aug 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JML8hIvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE701F5820;
	Mon, 11 Aug 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918622; cv=none; b=BSN1mhjMU4PZf5wEonaXVK9H5e1S+Z0qN/Ezt6Y993O54+cW7cjHEPAvgw4fpJxcWImwzN3YaGBskZKq3tvLW/hASd8JPzBjVpp3Tt9uaofSmE+2zRi3wM0tCgHm+NRHJhogRuFYrQ++F6boOswj0PmCvPRlFtyj2Ed5yH0DvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918622; c=relaxed/simple;
	bh=wHW3BD/OhOcrPu7KFCVJOURhRRyzQJLJFCVQAcdkFF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNv4L2lgCsxboCfNshG+hIIDYYq1Qn8JTPhFRvN7vc/FbRRVWO0pkivyYH7+/AN6NlMmbBFDtr8gU7XYSqb9/vtgRZxknL9TFRC3x/d8ZoWa5rnecoWzLZ5W5WjLWdvCknX3WOS1ofRldDyEUlEwtwHDNsqwfFFd4+GtBME0mKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JML8hIvK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b786421e36so2324349f8f.3;
        Mon, 11 Aug 2025 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754918617; x=1755523417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3i1TwRw5PXH9PjVgIN+9fLGelO+SfMaHlVr07PGn1u4=;
        b=JML8hIvKHB9/V6tEpgNpWXvslFCMnGIsIblRvvYFTnfHsGqXA9iAcyppTL8kOd9vQi
         DnaEy0e05IuvJ4+UDrSebtcULb0YUlzy/Ddc8nUJXtt6q54e6doFwz9s+gmBM4YpDb0F
         +eGnezsm5MJpvw5tIPiuAKj1J0BL7TU4l4GAqKRORE5POJ6XFIj06zi8l1rSozueR/u4
         izt33C4qciMX3fWup8XxfnP/CSNGLN2mhJB0Sz7GOaBaYiI682N/DVU7alcgy/Us+3Pc
         culJ4d4C9snrNWqIx02tcFB2o8TT9RM51Gnit0GuyRflc1DxYIjXUXo4pltVdDKoIfok
         rxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754918617; x=1755523417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3i1TwRw5PXH9PjVgIN+9fLGelO+SfMaHlVr07PGn1u4=;
        b=u5WD2ZnwpM6jkTqGrDXm7Z26DkKPTlhFJ6Az7/vVydyCpd/1KkPoJd+kW/a7asJnwK
         cuCG5j+Yr5TBCotwCyGk/ptFA354zPP0/yAv/45DyECgHeAbCTDrFDYQIyHcx6QMvj0Y
         XMJHNMiEBKtjdmJUsM6iINuec+QrXw5dKp7bkWFTW+iJmbbeA440eTpXNtA19WzqFXCO
         Q2MRv2SwGZSneugnV+glhcV2P81srAUYiLVS6CWSYtBdW/5QX1vqcrQdZsAa6v5KE5lk
         eUatYi7imuQDacqBP92fpCJd/BiZ2vT+Hy8eXDkT2OA5qqAspz+1dpEC82rIiOR/onor
         c0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq5Wj3VnauejqG3EZhMEDLiP6qD9QsFev6FUTQ4ZXH9m6EImzWuVAMOwuwwILL2fGJWK1XUbRiE3Rb0EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXckqGe90gLhRVGLdVq8FYgCqOnd4UV4LRFtdNi8xB8cYJfsvq
	CWIVpOZ0zGF4DGbyhvFWGseT6hoPMGxsZ7j+UayHqPkaMkjk8AMBUXNat5M4kQ==
X-Gm-Gg: ASbGncsTQGo3Y+as6u+bap4GgOCfhqHqlnItWSm4G9TTDh9nyQKFxk6APRpjkzqcNJo
	z6FSNiFSwthceqPiJB6UDDXjpaYiPdl9vOn3U3dBUzq8m4nZ26fD59cd0g0C+gs7w7Sn6NNCOjE
	exFX2cRFOLFFpvlBXywMYyDT/eCLEOBihT8wKXEbgbMa5cdvBiCLjsAzrUhmPfPTV82KKvYnC/r
	bM0KmEM/zYnSqGAgXJyTTbNY9GwsdEt8wavoE/I7fBDCc3kdVyQZQ7uqsZtO/W3cO7uwsLgRWni
	fZYxG2n342s4jMNBC4eXH0xD4Gl8dKuri34RY4sTkhjeQnKZ/G1hASEZxdSKo7yJ62Yxy8EJqTQ
	PNcaSRFKDrTWyKo78xeX5BQ==
X-Google-Smtp-Source: AGHT+IGBHoj4ms524wUd0zko8zHozOF0t+LhhO65J3aM5sG0taiXoz6QgxsNwY8QbsjLVlUpoADWPg==
X-Received: by 2002:a05:6000:2886:b0:3b8:2cb1:5f8f with SMTP id ffacd0b85a97d-3b900b35ab9mr9247412f8f.25.1754918617223;
        Mon, 11 Aug 2025 06:23:37 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm40983617f8f.44.2025.08.11.06.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:23:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Use try_cmpxchg() in sb_init_done_wq()
Date: Mon, 11 Aug 2025 15:23:03 +0200
Message-ID: <20250811132326.620521-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use !try_cmpxchg() instead of cmpxchg(*ptr, old, new) != old.

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after CMPXCHG.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 7f876f32343a..e91718017701 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2318,13 +2318,15 @@ int sb_init_dio_done_wq(struct super_block *sb)
 						      sb->s_id);
 	if (!wq)
 		return -ENOMEM;
+
+	old = NULL;
 	/*
 	 * This has to be atomic as more DIOs can race to create the workqueue
 	 */
-	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
-	/* Someone created workqueue before us? Free ours... */
-	if (old)
+	if (!try_cmpxchg(&sb->s_dio_done_wq, &old, wq)) {
+		/* Someone created workqueue before us? Free ours... */
 		destroy_workqueue(wq);
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
-- 
2.50.1


