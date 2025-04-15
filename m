Return-Path: <linux-fsdevel+bounces-46443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49335A89755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B323B9E37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACCE27A913;
	Tue, 15 Apr 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZgU+Y4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867171D9A5D;
	Tue, 15 Apr 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707758; cv=none; b=LG8eCGZga8UXrIQYQs57bTX2zSrunUJvQyKfx3Ipb3I21XtrjkjcHbs3jQ2sMPCCyWUREEVKiwhCSGX4TAOBQ/RRbQl2BvX9UPcC+CIYmOLgVkWf5A3Zc9n7Gu0RO56n3cJgFVcHSnlQwPmavKmX+AR6N4owufDvVi2sk0avgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707758; c=relaxed/simple;
	bh=caGUz9Z8pMCIDjkF3v8pjmkkhq4UL43aYLIpbMAOENU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAa4MYlXRZ13Jk6dg6dLcMxZot03beCVLfNUHUkWL9c/pNSDHzdvB2DaDBC8mcha7ThT3p3mdaXEOf0sgQv5Zwb/juKmwhBoOM9LCYcaN2hcTkBEiTAMtwjXP68YyoKb0CwQ6Mr5NdzixPUWaG8YuZsbRpmK0IWRla5u/eBRooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZgU+Y4A; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b074d908e56so1637169a12.2;
        Tue, 15 Apr 2025 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744707756; x=1745312556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dJDZbBMdv2ZAA+6dcm0km5N4IHnAcIL7BZj1NiKeJs8=;
        b=ZZgU+Y4A9vhtEpgp1A6YxvRSCR6A8UeVQFtJbOpq+Gbz3zR0wI3zoq118/8gbL/+hX
         AAroQb5uxKwswIh6aZU0fqLAGw+Rhi6zWF0d6vo4wHoif3Z95DnSRrt0ZbxpD9WvQimf
         PHPlG2FyX/of35y/JXBIUi422DYYFSrqR+y9WEmEc7RrLCCw/PBQn+1vWRUpXGAD1NIY
         FbhQclHUJjs1zy0PnTTdzaL61q96De7RJfgP29wPEyvdCB0r8Ls3Fw21yZyS1Ujl8jUj
         0tSlUXNWe+dMkgOqG7zkBR6V7YxghUceFE/d7zbU9shz3lwY9BDo3GAa7UihEIyjd4ZR
         DU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744707756; x=1745312556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJDZbBMdv2ZAA+6dcm0km5N4IHnAcIL7BZj1NiKeJs8=;
        b=hHwe6LMordJZHTyO+t7NiRagqwHdnFqNhGlx5lTsiEZ274IyWVwhNHUCV39YLJWL9J
         aImAOMbsT7q1xBsSgJM6EhEvI8SDjWpzw2B7dOMwu0j0qefXTru6D9ECa/SzfNJyxxay
         cPCJNcZ4mwoaFntEuoMxrFu2Ne/lpZDtZo0poXnUUDQHHsbFisQTIocsYPZGaIGOE0AH
         ORS4v4oD76sslT7+kGasNzo0KQJf3cx3VCxrVVAriYq+oq8jPE3DoNJUR5vs0ABvs7SY
         1g6JI54hE+7XBI3djM+gdRBP4b6wOAwZzJ42xL7Y65OlZJQj7fIMYHdxEsGC2rGEhpit
         lZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJAZ1w0CggwGMZyC+eFsn1we5O7Fie7ipukddwC17JL5+kI7Lmfd4eg1fpZABBEGy9Ptl1DL5D@vger.kernel.org, AJvYcCX18F/zSpR1MwzMGzooZ3/okU/y6PfkxWySRFaEC0qoi1S/2wiTYy7RzowQg0uxK0QOs+VAIa0ryWN3YGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPCVF+HxmP1FtKFa/66nY+cD+6COeN/1SXLiZ2gSbosc2VZ9H
	16an6ZU8eWy2BbUID3462YE5AUHIb4FZr5ONPzaRYE1Pi8lth+Vc
X-Gm-Gg: ASbGnct9dspIeTcBPkbrJE5gu1TTa189swwHqbTFQe4fpyXz1eMTtgRok9vU9eOrKrR
	XqfmRvv6F4CydpWEer765qBliLrmsaA0yWDXqxlsprJ8Mkl6Y/urGrldkiATsUeih6o2USZOmJ+
	AeO1SQH+pdvPDrEYokG0va2eJQSVYxJaa75kHeV/dNhu2I+yrRcyPknXyiAvqQ4QRIGZfYDpk56
	kfAd9gFsxd8Tqd/YoWDdoGtyXz4KXh/jnImzoMKRvjbEhbmpM5cd58L8GEL6eYLumvk0VvR1QAp
	cH8oCpu/BMbQsQd79/JBlIcwrnq3Ud/ONeIA/6UjYV39Fa8W3e4=
X-Google-Smtp-Source: AGHT+IEYjhNLxP37l8aYl1C4a7w6JsueacI5kZw35bhUqMjZzpBVZqyJDMJHUDXI3VVXAEqDHa7Rmg==
X-Received: by 2002:a17:90b:5190:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-30823680c10mr18676118a91.32.1744707755652;
        Tue, 15 Apr 2025 02:02:35 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccc98csm112424215ad.253.2025.04.15.02.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:02:35 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: willy@infradead.org,
	akpm@linux-foundation.org,
	andrea@betterlinux.com,
	fengguang.wu@intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mengensun@tencent.com,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: fix ratelimit_pages update error in dirty_ratio_handler()
Date: Tue, 15 Apr 2025 17:02:32 +0800
Message-ID: <20250415090232.7544-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

In the dirty_ratio_handler() function, vm_dirty_bytes must be set to
zero before calling writeback_set_ratelimit(), as global_dirty_limits()
always prioritizes the value of vm_dirty_bytes.

That causes ratelimit_pages to still use the value calculated based on
vm_dirty_bytes, which is wrong now.

Fixes: 9d823e8f6b1b ("writeback: per task dirty rate limit")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Reviewed-by: MengEn Sun <mengensun@tencent.com>
Cc: stable@vger.kernel.org
---
Changelog:
v2: A more detailed description
v1: https://lore.kernel.org/linux-fsdevel/20250415083542.6946-1-alexjlzheng@tencent.com/T/#u
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index c81624bc3969..20e1d76f1eba 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -520,8 +520,8 @@ static int dirty_ratio_handler(const struct ctl_table *table, int write, void *b
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_ratio != old_ratio) {
-		writeback_set_ratelimit();
 		vm_dirty_bytes = 0;
+		writeback_set_ratelimit();
 	}
 	return ret;
 }
-- 
2.49.0


