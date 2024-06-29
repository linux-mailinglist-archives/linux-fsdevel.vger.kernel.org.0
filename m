Return-Path: <linux-fsdevel+bounces-22802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3BA91CB2B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 07:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6031C20E51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 05:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8852262B;
	Sat, 29 Jun 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2+ddMbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC420B35;
	Sat, 29 Jun 2024 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719637503; cv=none; b=ePnYVzMToU0eidGwHgrl9J8wDhabrNWNgGqGIBv22mzt0DXIGZPKWQsef0nc3vXgYh7R90OCXzrlU2hzmd8TV5+5OEUfKtdtwq/Gh501A2iZn/61KdoRhy35pgn8HNKk8iGipnqa6dEyGl+NuVP7ikA3Rnr9X+sHhKv8MwT2VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719637503; c=relaxed/simple;
	bh=dcuuKpRBJkzahdCUleBRJIOWFY0m/bOzt2kKx03OwIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Es7yf1o8wRxuX2uKvE1+YEkyhC8DhDG4NbQrOUmfPet0xssc67XsZ+1s1VIosIQ3WVU9Aiuvt5derNdjsPJ5n+9bFOkwF9AITWyCpQTPy1EXjOz1GFrTIEINZ1pKNMzPZtv4ezEEnwj3Wi7KpbEF2WamsZBDsR3JgXouEWcSDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2+ddMbG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c7c61f7ee3so867418a91.1;
        Fri, 28 Jun 2024 22:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719637501; x=1720242301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z53dvUQas2/LeQSNt0ulxXzxs8xmrLPBhov07vOe5GM=;
        b=b2+ddMbGJfLVacd0Cz8s60mb9/eMwvvGpCgqw9B3mBsTBtHkYPTR6vDFk/tRipQN8D
         xUtr1OUXFipF6nD3BB8phWm2LSbGC1jxbYdEwjMT++Kv23vf7G3IQ4dNBcxu0Mg2557+
         qcrccGfFSdbVKZlCqS12X3IIousdNE3dBmWiqUma6kBR1JcHCNOs5dorYBWI9uH+7TIf
         rduccIM9hCzuGI5z5QHIW7XF78WrEoa42fLt/Fz7cJ8Ufx6V2C7bEz61W2Bzn1b7wnIj
         /2mjlCJTn5cqW7RZEOzhhAaBPNl8bDVG1b3IhNkpq70om+Yhbx/iIMnXrkmdk7LzLkjZ
         OKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719637501; x=1720242301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z53dvUQas2/LeQSNt0ulxXzxs8xmrLPBhov07vOe5GM=;
        b=YS8QbGIYukdk6eHv6apkLe2E5jor2R2ZU0ldM8zS6rv6x0t/hpCjcNErbFCYhGZFPq
         sQiDZf66WRbIeWJJcSw7He/pbdAPVrC3Goxe3bnn5DpwbHqwpV+eQ0YLgKXFpaY1uMD/
         rTqM2o3vBKu6RwTKfK8A+XE/pe9FuoTOEKLk+PDTrpMMmY/Y+DVMMSXZJRNC3looLUcZ
         D+bfebdyKfjA6L9L+WmBsgFfFaquVkHfeoqmYRNWtGuk0gFLAj130d3NlQXDhcaBeiAV
         O58RZyjmD8pYs4VKx+Qz+KiuLDZA4d+RWAOnSrGN9jhJtDD08q1b+r5yQdtShjzCqwYI
         HS9w==
X-Forwarded-Encrypted: i=1; AJvYcCWeR6dTdgSr06LsTgtT1ZA+lDt+hWrHu/EpzRYuePk6BC3JJGpv00I3i8JZUB3VjU/9QJritDJV+XzKo9ZHVDGnHWvPObXpc40zwdT18MH672YBTcd/p8SS8c/uri/Hxiwv/Ndosy3TkUFA79DXxlDK77yn5PQfcyEOi+e4b5HQ+twUgl5MoidZRnbjog==
X-Gm-Message-State: AOJu0Yyq8rOBBDR7DMukCFdjcO6pRljK5VL8Ker4UUcHQGr3Hgs6eMps
	asDCtYhpQcj69EVbj/Eu0v5uQ4crfPIjtInky0UmnxCfZMUlhLvU
X-Google-Smtp-Source: AGHT+IFRMNDfDRD4MGWAFPeQqoKwYS3XnqzyiW25OH/ue7Q8AC6nf6xgVn8uJ+GINtni9oAtTQfcXQ==
X-Received: by 2002:a17:90b:4b4b:b0:2c1:9892:8fb with SMTP id 98e67ed59e1d1-2c93d6d4a44mr90763a91.5.1719637501221;
        Fri, 28 Jun 2024 22:05:01 -0700 (PDT)
Received: from dev0.. ([49.47.68.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce16865sm2548236a91.4.2024.06.28.22.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 22:05:00 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH v2] selftests/proc: fix unused result warning during test compilation
Date: Sat, 29 Jun 2024 05:04:49 +0000
Message-Id: <20240629050449.990451-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Check the return value from write function to get rid of the warning
during test compilation, shared below.
Tested by compiling after the change, the warning disappears.

proc-empty-vm.c:385:17: warning: ignoring return value of ‘write’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  385 |                 write(1, buf, rv);

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
Changes since v1:
 - Remove the redundant if(0) block as per the feedback
 - Patch v1:
https://lore.kernel.org/all/20240625152139.16412-1-jain.abhinav177@gmail.com/
---
 tools/testing/selftests/proc/proc-empty-vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index 56198d4ca2bf..123c622cd816 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -381,8 +381,12 @@ static int test_proc_pid_statm(pid_t pid)
 
 	assert(rv >= 0);
 	assert(rv <= sizeof(buf));
-	if (0) {
-		write(1, buf, rv);
+
+	ssize_t bytes_written = write(1, buf, rv);
+
+	if (bytes_written != rv) {
+		perror("write");
+		return EXIT_FAILURE;
 	}
 
 	const char *p = buf;
-- 
2.34.1


