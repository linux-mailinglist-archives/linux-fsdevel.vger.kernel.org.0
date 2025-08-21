Return-Path: <linux-fsdevel+bounces-58676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F02B306D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532F3B02297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B5B391944;
	Thu, 21 Aug 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="axh3S8PB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF50391920
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807678; cv=none; b=sZmgYl8GoXpubQeRo3oB3KehRwYq0ljHpyqH2ydmbh5DTvkD6+CuCh1NQVdcYMb7lEXgXa1bnidViSAwZuxztKr0t4+tEZ3Usfn8QkgQ3YbFDcxfuNm5YBO+xiKAH8PQwZrXfgwLEzmAGo9XBrMBB2v7LDC0dZpokKMLqGVQefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807678; c=relaxed/simple;
	bh=EA31L9PrmSa4mzObQI8v1C5H7seTrIKkp2OpM8ds5og=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/L9n+PN0wZtkbL3txX2ELAZv2bgSupHJ6zdGh/U5KuEPMTLmvqKznUOUtzinDt+MaBcYPs4zsAIv6FybvSQzXO0FkunfwgUQyUd72jh5nsaZGWfwcpxx+WAkP5ObX2GulL9ZKhJu7o0iMHrPnQOHJaw37x8IDUV38ZpcJbgxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=axh3S8PB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcac45so12465307b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807675; x=1756412475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fttr/Czssr2JLi9HILzKnlPA1YaQWhLNKR3od2b6IE4=;
        b=axh3S8PBmyjMa2pbeNgVzJkbFjsSqOPDKGpRbNdMxXclTkWl1pJmXC4ZIXyxfDD+sG
         Ovbgm9SD1UPt5XbKiTgPIRLUY6RHIvzyHY67/gExLrv3G93aHesRJto5m/oQ9G9sNYx4
         RoFU/eiotc25vyarCJqEm5alADklkOq6oSOfYKAiZ3HOE2ingdyBBf56aXAf9tFx3ZmD
         HFRnJwyBVjmr+g60SEeA5QilWn/5JSiiXWC9VpBQF6MNCJ/pXdHC2rESaIMQdyGTJkX2
         pwc9RHLW8N8KOrCLl9SYs8O5O4xs/H8haxUd6aMGDK/cuDTUE/Xy2Mfemw1u/KxVdGEw
         cjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807675; x=1756412475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fttr/Czssr2JLi9HILzKnlPA1YaQWhLNKR3od2b6IE4=;
        b=c+LLUj1bWCLQHK7dWEZ2GNXjFYrRoXWrLfE+VlHE/6E//s4bnlT7GvTubRhrkdoH//
         xo5iZUt6e5C354tnEPd+wMD6MEh96tZ29F7/afeIiiX/IUYEG/Eag7VyDhh06LT2mBlV
         FpkuYi/BM1zKWGxNggVh6s/kqtS7T/I2f0o/6NTEzSS7OA3iKBVYVF2w06nL0NjEvoXQ
         ZAbPf4WixEQBOO5uDQBIJ/PpEpXgI1wnTm+EbiHhzleICVyetuy4cDPvlFWKvY2lCwjl
         CcsvLOJk1JgMv9taYeVCsDn4Oa0VLtL/+ot9f68+Y9RD/YHTbNhLO4Qrip/05vjgBrO0
         hI6g==
X-Gm-Message-State: AOJu0Yy1GGQYeSdcaGy458+lwfPVuIvwwwE5H5/xdYqo9kQC7tcx82qD
	ricn3gJOVehJZ3gEAVaqEP7lRAwhEFPRc/YdJg7AS3JtayA5RZqDS+dkLWwQdxz/YUPtftb+M33
	4zx6i4yfIiw==
X-Gm-Gg: ASbGncuRmfrJJdueB4eL8bPpdgliaDZfwahqDt+3zwAtBT2aKSyDxhOONd4EZ2xSK3K
	pTMvxp/u5HubjteKCbOQ4Ec8RwWDuxwDnqu6LAE29kE7LIXOl50Pni5FWhXyOp5xZJKyxoJBvUC
	j7hbLrGNt3zKWVcDtZBMb7s9JiWK0aPvB68SJRJbc0Y3riGuIB24dfqWYR8itCi1I+yU4K+hewg
	RxSrpK1ZOsPPNRaqLpimCVBBmm3qrxFXpiISLTubLjFS9y5QwH7mH/fpRw67NMu7qPH0QrBmC13
	vZMflgfP8J0odgcXisTKkNHljnjn20SnN/p26RKiEg0FEQlhxvgsZAphOP30QlggiBJCWJe1avc
	LeTesORKianmx0GmZHo7XI4C8c2XYHQnWUw1PxyOYGVOpYxVqqhRlRyarIz4=
X-Google-Smtp-Source: AGHT+IGjxSgFZ9mWOECEHAMCC7m5i7vQzRMSl3lQEW4CVdSnSyB58BReHuV0rWkHihu4WR2jiQXucA==
X-Received: by 2002:a05:690c:968f:b0:71f:b944:1027 with SMTP id 00721157ae682-71fdc530cccmr6134537b3.48.1755807675427;
        Thu, 21 Aug 2025 13:21:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fae034dc0sm17871677b3.74.2025.08.21.13.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 39/50] xfs: remove I_FREEING check
Date: Thu, 21 Aug 2025 16:18:50 -0400
Message-ID: <1cc3d9429aa4aa8b5b54d5cd54f7aa27a1364b78.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can simply use the reference count to see if this inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..a32b5e9f0183 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (refcount_read(&VFS_I(ip)->i_count))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
-- 
2.49.0


