Return-Path: <linux-fsdevel+bounces-44440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75003A68D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DE4177983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9DA25524F;
	Wed, 19 Mar 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiLlfyIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F31A2C04;
	Wed, 19 Mar 2025 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388573; cv=none; b=k0O0OObTQV3YGrhyt45mGfp02iQy6IAucqr/9C5SA0DEJRufcpRCMprDmz8IWLZ1iHO0SBlKJIoVPNam63ZMjU48wluhxJoj16jk7EW4UCBLwpArohQV3DNTOkVmGe03TrGW5byXzgEwo9xuMCNhxJqEQUJvolLC9D4Oq/UOIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388573; c=relaxed/simple;
	bh=yj+WBH+4j/d4WV53YewKZkY4W7w96sftwbrm6Tk1RxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvL23aDgyYLgzMd9K2IM+SV6xZrHtLW06mVGb4ApiTsc3bOi1M2HVbJoJezQaceAHJBxivxc9OqGvxjN8+mV3L/SvL+NRPPvdGoi4Jt1gI8tQpPJJqJrLsqQiY4vZIn+CHbyhHkAxG6UpMUJIaIyaiMt0uT37vi0LN9ekf9+t+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiLlfyIo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394036c0efso30256415e9.2;
        Wed, 19 Mar 2025 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742388570; x=1742993370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+tgFCOzjmy/n85jIehmP3zViNNZ7s4CsuHXNnd4OWk=;
        b=EiLlfyIon/0h+wMIGTP2r8xhLzI9ifVA8DuJ35ONREHAvxvyBHsCnRoB+bwUZblNy3
         EFFuiwSBK98+/wkqEuzoRfoB7R7pSglrdSYCojtSmN9QgYngEy2ceqIkNXKkjfYmmySK
         Y6/GYaUWVNROKDzoddr3Fa+hDy+nq8eY0+Ots0jVW4IP1zV78zT7wU2pNuEnXXlpMSWz
         vSUliYs3yGKgN8lqilSVesj/lAnJfFs9HHl8cTL8raR3po+m2BgAjRPi+hS1hDnBKLEK
         Kff86f0obz3RCKXeQkykPkRslz3P5MWWWsLnzxtJ7xLcPn+Su/D5Nv0Y3lp5EXLpaYEg
         cOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388570; x=1742993370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+tgFCOzjmy/n85jIehmP3zViNNZ7s4CsuHXNnd4OWk=;
        b=TgUt7JOipe2uDtEl3cxv8DdVWJyGyriskdq6lahIP3o1cdo+um7sgz1ldefzcz80nn
         tiGLqlx5NrKWHtA3UoW8GcHGhEHlBU8yDJrfm8CKvPhftBfZ9q4EVVmDBviI5aK1tSg/
         yA1X0NvP9hVpRy6No5GCOaAIRz6OmCQr1lmNBNdISkKGdp6gAM7mMvmYqSF44r9dx4nc
         GBr9DnMu+NaNykwO6BojOEMIK+RnH2Yw7/A9U6vU1o0m/2B4NLJi6FOJ5lRwP5iDgNTo
         y3065YkJHBnItGsZSodYDkKdf6RYbWgAAe+58+gV/oL+OBbVFeuiHxbX1zPWkAGO9OPC
         rkJw==
X-Forwarded-Encrypted: i=1; AJvYcCW7AwxlBoy2/ihq1TPvrKSbf7/UkL1piay0Y9eud4mGQVNaHjp46EsqvLQU6oiZ0uKRrOEPgbkNB/zIvhTA@vger.kernel.org, AJvYcCWKqr/7OJsB7F+/ivJDFEji1/NEMJMEuJe5osDMCG2s3DJ9g6KZaLedHu+9+pb2Ji3wm14p/tSzXUzjTQjQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyWaQQ7RsBzUXJ+Vvyvkwq1Fo0F+0OXodNuCYT3UJan0onv0PRP
	2RiWF603tKmIWl2Nu3A7dU6yhZCkSSo0WzO+qobPXanpdlGbqQiLh5r588YQ
X-Gm-Gg: ASbGncu/edyJEdvhDfdVOfpiQAeHYN3LeB5bV3lT/y+j32Y6req6mv8yHCJ1AN4G1Ws
	9hlxwu6SWNdWpeUDTWYjBYrAb+tEwhfCCxeeGlRjLn+S4RElkBVHXvg/TGAUxaeuuX6eLg+GqGw
	JKtFaDEsmz0B0zCFhVYfut7fyHEFCRYBU9L8LklHY/KlWHejm36CphcwE6xVBUKRKB9X5v5JS9z
	kCBLZ1/f9zGQLKfDhzOCQ+EET+D1/B1xV0fE+BPwIuBXU95yy+JqRCn+/C9hTCsuVIJKwzL9Gp+
	zQJRsIdtm2jy3EfLg4ZN6d7K1XvNgzIoWAbNOz6y2o9llZqhEcRc0CfiUS4/Yik=
X-Google-Smtp-Source: AGHT+IFfYcpZS6kZroLg/+mwYKmxuljIM2FFGphtp2lJxswWFtQmXW9kZSBtSOY3Ojn5AkeHD7dBWg==
X-Received: by 2002:a5d:5985:0:b0:391:39bd:a361 with SMTP id ffacd0b85a97d-399739ed7c9mr2416137f8f.18.1742388569421;
        Wed, 19 Mar 2025 05:49:29 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaa5sm20805476f8f.87.2025.03.19.05.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:49:28 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: predict not reaching the limit in alloc_empty_file()
Date: Wed, 19 Mar 2025 13:49:23 +0100
Message-ID: <20250319124923.1838719-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminates a jump over a call to capable() in the common case.

By default the limit is not even set, in which case the check can't even
fail to begin with. It remains unset at least on Debian and Ubuntu.
For this cases this can probably become a static branch instead.

In the meantime tidy it up.

I note the check separate from the bump makes the entire thing racy.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file_table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 5b4cc9da1344..c04ed94cdc4b 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -221,7 +221,8 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 	/*
 	 * Privileged users can go above max_files
 	 */
-	if (get_nr_files() >= files_stat.max_files && !capable(CAP_SYS_ADMIN)) {
+	if (unlikely(get_nr_files() >= files_stat.max_files) &&
+	    !capable(CAP_SYS_ADMIN)) {
 		/*
 		 * percpu_counters are inaccurate.  Do an expensive check before
 		 * we go and fail.
-- 
2.43.0


