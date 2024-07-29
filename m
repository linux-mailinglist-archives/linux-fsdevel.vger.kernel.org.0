Return-Path: <linux-fsdevel+bounces-24520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9813940159
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839DFB21D79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36513DBA7;
	Mon, 29 Jul 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="EV09GjUD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BC7641E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722293302; cv=none; b=XPfbA5kNmPY8k0qmfuWkH8yVfAPtD0l5BzEbgSVBccAxtW4cBDhYzGljq2/Z9X0iA2gSSWhmt3nIhGf3LzFkyPB+7y1+Aqao6ZkDoXpbeTRiJZSxQaFYQ3IlALHE5DYzsil3UtXBsd27lS8is5d1D6RVaMtuEVGjsU1lAG7C3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722293302; c=relaxed/simple;
	bh=/Ct+oKN8zzRsmgd/uPvJL8seFIZJDgy2RpqFOD9c+TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhp/OUjHJOcB2PtSr/j8GtTai3X/Ub0s6ciL5DhtzoLkCiuYTx0gcxC1zflyEcwScrwqgJW6WI1RutrCKMPxBGix+ZxnDVNUn+Y4tdmR+LJ2qLewErWA4h7F4t1HxfBF+Uo55/fjZha2ChPoSEjjl7Nr3lh7CGoJU8g01g7r0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=EV09GjUD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc566ac769so21693105ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1722293300; x=1722898100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkfRectvbXP2WvgQCNMz09l8lgvhqhAJunfeEU3XPo4=;
        b=EV09GjUDpX8k0h6eIOyftr9z8Ml5mgOFmG0adaPOqbIpMlgTsWg4JRK5SQ5RIjxJgI
         rBgjqZdLI6JKz4FQ42mHldAOJeD5/KWWHMhuFE4tSVsNNPilT1Puj9l7PzGG7+3PXHc+
         b+DMVmHZG7Y4MwNPVU8dEuaaAVzKCuIwIexSHZ/Hj4lcvvpnAHcu218XJjIZPbj5Gab7
         EXBMzZK4IXw7/ZerAOHoebwE4tbx6j/ylT1WvZdc2tNkihGPmNO1yzZPFm7ugrsCnBYG
         zyzyPnmMgTg5hEIGk36ym6AHvg4jL6M8wlmOUzxykH0kY9B+yc6bY6j3gB5/h/n+Nu0a
         HQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722293300; x=1722898100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkfRectvbXP2WvgQCNMz09l8lgvhqhAJunfeEU3XPo4=;
        b=EBP2kuOJax418/8T/Y8UjvS8vnbqOgfYo++E2PCQevdpf4Ij0oqGDOjOc/UoIbPn6M
         wt2vQjRnO5s7B0oRVKgZnpMldZgdCt0HgJ3X8K9xi0pbotUuFtP852CXvOR97WQFLSKP
         dkDjrNEwc/tV5JZbBi4pAxbcIOWVgyt8FdyIWB8fZmSQeOuGOEUmIkwy/oMq+3h/2RLh
         acVzU7wwZ08CrheMNsbwOqmULi46XlnGyNUx0lhWGb0r1Nt5Jzbu6Obrm2ezZC003JtC
         BVl95bgYzu4NdBwBKQXvEY920ljoAEprAk0i7G4UW8iBVJpSKii/rogpfhKroL3vPGf/
         bC+w==
X-Forwarded-Encrypted: i=1; AJvYcCVM4fdWw/X0mYpU2dbIwtpvaD7vD1ZBx+weQz9rA94XTiltBKsZuzpzZN7VVMcMumAmDVCZz8oNhH3Hy1qrXAiqL8OXLEjsSUVdCQhGqA==
X-Gm-Message-State: AOJu0YzQ6ur5vdKtC3wYOMWe0YRCs5+7J1Nq44A8YuOeGhHNwv1oqwJ3
	YYlPCRIKMKEDS/9KQBbDNdtT+Tqns9q5t0kTrUwwoGNQbOAJiFkY8R6Di+MDtbM=
X-Google-Smtp-Source: AGHT+IE+VCBKH0MHOpEUufDU0eHXth9e6Pq2jjxwkL8+zsC+46JWyZiG/FUqXYw1G6UjWEKc5br9fg==
X-Received: by 2002:a17:903:41ce:b0:1fd:9e88:e4d1 with SMTP id d9443c01a7336-1ff04842174mr67808195ad.51.1722293300269;
        Mon, 29 Jul 2024 15:48:20 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2620:10d:c090:400::5:a8be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c85c70sm88177095ad.23.2024.07.29.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:48:19 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] filelock: fix name of file_lease slab cache
Date: Mon, 29 Jul 2024 15:48:12 -0700
Message-ID: <2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

When struct file_lease was split out from struct file_lock, the name of
the file_lock slab cache was copied to the new slab cache for
file_lease. This name conflict causes confusion in /proc/slabinfo and
/sys/kernel/slab. In particular, it caused failures in drgn's test case
for slab cache merging.

Link: https://github.com/osandov/drgn/blob/9ad29fd86499eb32847473e928b6540872d3d59a/tests/linux_kernel/helpers/test_slab.py#L81
Fixes: c69ff4071935 ("filelock: split leases out of struct file_lock")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9afb16e0683f..e45cad40f8b6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2984,7 +2984,7 @@ static int __init filelock_init(void)
 	filelock_cache = kmem_cache_create("file_lock_cache",
 			sizeof(struct file_lock), 0, SLAB_PANIC, NULL);
 
-	filelease_cache = kmem_cache_create("file_lock_cache",
+	filelease_cache = kmem_cache_create("file_lease_cache",
 			sizeof(struct file_lease), 0, SLAB_PANIC, NULL);
 
 	for_each_possible_cpu(i) {
-- 
2.45.2


