Return-Path: <linux-fsdevel+bounces-41872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D7A38A9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7803A99A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CA229B23;
	Mon, 17 Feb 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/kgzopK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577822540F;
	Mon, 17 Feb 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813631; cv=none; b=V50pr+GFomr4m5Xe8KIhg6qAHMtBGMm/7yDtgw1A1VYyoS3h6o/Kg0cmkURPhlHkUIM6CK9tyY3UKwyC+LXI1rhWmCey297DlDmuEptfBfC2bIMqrjRnha/ozCg1izuXYnkyFhv1EPvdgE+EwE2HCwH1/0R3BU8U4qW2AOlk2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813631; c=relaxed/simple;
	bh=EsMTxchL/+qRXxcJQQGMEd1C37/sV2jkPmF5oFcvccw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lgLtwqNiFl8n10CMaCE4DKZ0EOMmCG0czUxmFTOmt8vmoWunlCSkEUn4Ppm9RIEnM7BfcUIKicyOUEyRFmh3m1U3pAharZe74w6qqloixn9NKm4hiIl7IfP8b+IZqi/Y5NbyfmmPsIEyVWIMGTwnzxCDU+m8s4LQR9gIWkLjfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/kgzopK; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-220ecbdb4c2so86874275ad.3;
        Mon, 17 Feb 2025 09:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739813629; x=1740418429; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9P9H3YBcyOxNExufhwVnRqWtrvWAZlTnbL5BKFsIaA=;
        b=B/kgzopKrDAo9DXzgTcHkforgmjCzdhZkk/+oJkkWLqIXcSPJK+pdykUf8X5NjQKHS
         nsKquSHy1RNjuQzFeeEHgQ1pb6yZYXtMigkMyLMewrWj6Hj2c20vsqsQeCKu8R2pyTpa
         yxEIHBkmSroZ14yJ3N+PzSG2RSEk5GvWwST1Vy31srhnpCkse7XKeh9+u2Z49+/MsPcx
         CGA3mfzRLRthaOVN7cs1GO8VtQRChzm2k9JcNI2NJwCEBVEsGqw+kSj6JeJEBdlvJFm1
         JRELAdSzQhuNTnxeXbur4jDUxHUvgxydKNrAGLqPyFmYzBy+VSLYwawfRbwrqzf/MFl2
         nAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813629; x=1740418429;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9P9H3YBcyOxNExufhwVnRqWtrvWAZlTnbL5BKFsIaA=;
        b=OaBCGnjdWd8DBJuyo6aoKpgy6B5ucy3yolMeWYoOt0D8QTbvd46a6I3NmoLxfb/ENP
         Fb6JWvsEQ8muvBlAqwXta7lQMSBPC1xCcUyN6ShIBJVzxC/SZMcO8Wrt/0jrBP1sEjDB
         r52WRB0lFpi5IFfdWVpE68hhKafRW6TZZcy3nAubKGxAZ2yTZrTaKAEJc5iSReTSRoMW
         nOW7qg/s6n2o+9y7eDq1PhBetaZMQE1seVn9rslNghi4BkCCsM932dJWB75uKOi93u9K
         ddSsaYbgKlpoaCchw2wUdAAhCrVSUg87xZR2otLnF0798NKzLW9FQkCoeuyCuTVn1F0w
         jquA==
X-Forwarded-Encrypted: i=1; AJvYcCUSAl2PEHXaNDHGTOxgn09ySG5qat/pEtY+451m1GLUZIHisuU8QYfIqzGUg5CQwO6cBPagooRlx98=@vger.kernel.org, AJvYcCW6oz1q5EUSQM9MupZZaivKjoyoVqCYsL5y/a7mStpIlmMVTD2usXwBaqrNLuyxWDIQn49nbhqFRIdb5y4cXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFSV0K438VtS/SuIHpmzCd67BAGCpt3zBMbdJgFpuUAMf4Gw+
	BdJFVAQ8CalTIpIRgFwmgJqIzl1Mj+I2NUeLZqMpinapHyRI7gMG8LlxDX1MfNcziA==
X-Gm-Gg: ASbGncsm4xkVqPHaikYrCzbZEujfgGgEDDICAAgyv5fy9svfISkeBjetUiYG9I1pt4L
	lB30bVikA3Sy9AWRRPmx4TCbkMPJCjDq881j3fMvFcEfijyxC9q29QWjeWVbnVapZqh2OU5Qrry
	TC9ljBIUA/OcCb3ReyReoqUBMkO8axfyu7nQ46FCKhANPhODMfOWHg5nHxZcZhs3LeJzN2bO1Nw
	k/gIy5TeXrYrJ56GpgRKQgl8BNbQf7AufB31+CA+FGw1vWk7LPL+Lwl1r9CGsdh8HVwZtGNcNZD
	LSqSftGQfPoxVERGBkrM08uWjI527yrCc8z1GOM=
X-Google-Smtp-Source: AGHT+IFCpkha+YyzDli16uY7DAmxbuU6YfLZLwRKbbDveajyqZ0h54qaNzlBrLduLmU16ZHx+gCmsg==
X-Received: by 2002:a17:902:dac5:b0:21f:507b:9ada with SMTP id d9443c01a7336-2210405cc66mr168080165ad.31.1739813629392;
        Mon, 17 Feb 2025 09:33:49 -0800 (PST)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349203sm74338045ad.29.2025.02.17.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2025 09:33:49 -0800 (PST)
From: Ruiwu Chen <rwchen404@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	viro@zeniv.linux.org.uk,
	mcgrof@kernel.org,
	keescook@chromium.org,
	zachwade.k@gmail.com,
	Ruiwu Chen <rwchen404@gmail.com>
Subject: [PATCH v2] drop_caches: re-enable message after disabling
Date: Tue, 18 Feb 2025 01:33:33 +0800
Message-Id: <20250217173333.2448-1-rwchen404@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
but there is no interface to enable the message, only by restarting
the way, so I want to add the 'echo 0 > /proc/sys/vm/drop_caches'
way to enabled the message again.

Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
---
v2: - updated Documentation/ to note this new API.
    - renamed the variable.
 Documentation/admin-guide/sysctl/vm.rst | 11 ++++++++++-
 fs/drop_caches.c                        |  9 ++++++---
 kernel/sysctl.c                         |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f48eaa98d22d..1b9ae9bc6cf9 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -266,7 +266,16 @@ used::
 	cat (1234): drop_caches: 3
 
 These are informational only.  They do not mean that anything is wrong
-with your system.  To disable them, echo 4 (bit 2) into drop_caches.
+with your system.
+
+To disable informational::
+
+    echo 4 > /proc/sys/vm/drop_caches
+
+To enable informational::
+
+    echo 0 > /proc/sys/vm/drop_caches
+
 
 enable_soft_offline
 ===================
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d45ef541d848..5d02c1d99d9f 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -57,7 +57,7 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 	if (ret)
 		return ret;
 	if (write) {
-		static int stfu;
+		static bool silent;
 
 		if (sysctl_drop_caches & 1) {
 			lru_add_drain_all();
@@ -68,12 +68,15 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 			drop_slab();
 			count_vm_event(DROP_SLAB);
 		}
-		if (!stfu) {
+		if (!silent) {
 			pr_info("%s (%d): drop_caches: %d\n",
 				current->comm, task_pid_nr(current),
 				sysctl_drop_caches);
 		}
-		stfu |= sysctl_drop_caches & 4;
+		if (sysctl_drop_caches == 0)
+			silent = false;
+		else if (sysctl_drop_caches == 4)
+			silent = true;
 	}
 	return 0;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb57da499ebb..f2e06e074724 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2088,7 +2088,7 @@ static const struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_FOUR,
 	},
 	{
-- 
2.27.0


