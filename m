Return-Path: <linux-fsdevel+bounces-21458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C4E904295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1551F24813
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A60C74267;
	Tue, 11 Jun 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7KbS9CI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6496EB74;
	Tue, 11 Jun 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127643; cv=none; b=o6eZ4vMtlebfIispvYMHDARLJkKs7c9v9pNSJmM8LqLxI3oNoD9Isy1k15uAEA0tyVFCr5xdgzFd8XaRbEo1zLKb9zLAYnGvWrOvMVmehWXAExr4e/En6NTsVnK7wySIVxXjCaG1nJA2s4KDduWMMFI/6tTw1Mu/jzDLpv+O0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127643; c=relaxed/simple;
	bh=UnS1GN+RmVwgTfDVRx+f1OGHK29jr7UNoQi9kGafAa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Id8ybWcA+HIsbRW5vXVXKEmW1gnPpNmYpWbVXzQUEFadoH1Zt9ixU2n83spWOWVdiU7/c+L4nnZxW7BKSqUX+Tby1DRDGyrToIGXIOUc/YmWYJ/RzmBSU3/NT9Cja+y/zIDC4pR+LYLkiOrSO2aSbXWdIpQo3qq/iJo0tuAfvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7KbS9CI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52bc1261f45so4528648e87.0;
        Tue, 11 Jun 2024 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718127640; x=1718732440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIOb5A0u41dXH2Few4c7nOgBOybu9BYcELSZMwnL+lM=;
        b=E7KbS9CI9CG/25lBjki/iCTWUZJ1PjiZIPtUTYN0dEBsKgrHI3i195+eLCs9YEwpYo
         9qHMCw1fiSEaH53yG1NQ8OqGJgFy43DdNO53vUi2vFCUgos+VMFTHFGkkV4qVq5h18Fu
         Vsbmi+Y4wyuHvYk0HrJrq1784KHK5GbeLdk0Qsbx8uRXMcTVzQalz3LixvNTmHqzmUz5
         TKsKxhq1HUD9aHyqcXVcVU2T0MhlmhEGfdD14SxGK33MW92jTK4B5wTTwZGK/yJ5Cutq
         tZV63lJD+PmW4RN5TM6VEHlsuMIWqcSPeNPFK5hQ34OnOoXqhber1Iy3IxGmoHj7c8Q5
         Cxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718127640; x=1718732440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIOb5A0u41dXH2Few4c7nOgBOybu9BYcELSZMwnL+lM=;
        b=PAy9QruEIR/I64uQ0tQkwm5+b4Lyrmd5VzriDQ/E3KnIxjnAsVSGXBTctjaF0sMVMU
         eGPmtMJ6m93e9Cz1R3OfaRN6yWga7SGAPsuttRfbG2yopgESNzcowxcDiY/8+iybmXVo
         WTNj284C5A+lAxV2liVk1/ecO3yPTUR5T0WksHgvRXkBwwko2CQ0fYh34Lpfiphl8ZyV
         GSwZ0eP8ph/Ee5YMZYlMSmruMP0uOOmmhNnkSJY1sQSp9ySltyYNL84Tgj7bTVeX1dw7
         NJ2l/ORHm2f+9t3adSU80BOxw5lFPQJjO4xzu4CvD4UgGesa8th/5WHiD+3mIYDVr9Ok
         ocyA==
X-Forwarded-Encrypted: i=1; AJvYcCUq9xbKFRc7YeRL7qiuFsylEBuZR8qo/EOYtFGE6TmBAzeK4jMhTXndIKZ6khgYXK1OkvQnV1nIDvJ8dIYpNQo9gNn7ZjtA4Zx0Gc3uuHxGvcOE5/qv6C3uuYWstfmFvUd8z8j5gvyDjoPBuNasFMo58iyLMHnA4Y3VH5UwhNiZmtDSFJa+nlKD
X-Gm-Message-State: AOJu0YyAieTJCuvL3EtKNGBb3BByidP+lNHg66RAw92Y72Azo14J3Dbp
	mTgh81VxDGf37ZnRcnsr2hKbTsazIAz8eDvqr2thn2EclKmF1pBC
X-Google-Smtp-Source: AGHT+IHYdhIJFF4+t28qVNumSkPBzpQLGirbGaQ8gkqgr72rmGkaw0V6016CSHTlsHPEeV6rp7rJzQ==
X-Received: by 2002:a05:6512:118a:b0:52c:8e17:cfe1 with SMTP id 2adb3069b0e04-52c8e17d527mr3349573e87.45.1718127639765;
        Tue, 11 Jun 2024 10:40:39 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421be4f0a06sm87232435e9.21.2024.06.11.10.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:40:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	hch@infradead.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 2/2] btrfs: use iget5_locked_rcu
Date: Tue, 11 Jun 2024 19:38:23 +0200
Message-ID: <20240611173824.535995-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611173824.535995-1-mjguzik@gmail.com>
References: <20240611173824.535995-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 20 threads each walking a dedicated 1000 dirs * 1000 files
directory tree to stat(2) on a 32 core + 24GB ram vm:

before: 3.54s user 892.30s system 1966% cpu 45.549 total
after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)

Benchmark can be found here: https://people.freebsd.org/~mjg/fstree.tgz

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4883cb512379..457d2c18d071 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5588,7 +5588,7 @@ static struct inode *btrfs_iget_locked(struct super_block *s, u64 ino,
 	args.ino = ino;
 	args.root = root;
 
-	inode = iget5_locked(s, hashval, btrfs_find_actor,
+	inode = iget5_locked_rcu(s, hashval, btrfs_find_actor,
 			     btrfs_init_locked_inode,
 			     (void *)&args);
 	return inode;
-- 
2.43.0


