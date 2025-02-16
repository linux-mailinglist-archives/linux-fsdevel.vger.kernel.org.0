Return-Path: <linux-fsdevel+bounces-41785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBDFA373C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 11:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8937A3B8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB018DB12;
	Sun, 16 Feb 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrgWiaLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03054F8C;
	Sun, 16 Feb 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739701102; cv=none; b=CJTrytUWmuGiWlEA5kpPGEqda435cvT/N+KFZyud5KVdG6cIcUp4aFGw7gaHgrwyvbBazl6XUkzgkKPRHgxPY0WPXOA07b5XTfkmzHZn4CCYj7GeyOQB0d/W2rO5/h6YaSxesccwE5UMw88yuE44aWLP5la5ST7U9fdjn40/ZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739701102; c=relaxed/simple;
	bh=tqJVl5DhtR6Hj4AawCnDQ8amMkD89+pB31g7/EzN0ME=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OIKj/GmZxAN0Wjw4OBJXSKP0Hqg+4RQu5yTOMweJkp/d1mWjd9eUqcayF9/t8qherDBtQ/r04+bcSOz8FJGOskDV5UauAMNCmD70ktzhCm32Hxog9h9ynBc8JY26LYPs+MX4KIR9AMhmkeF3zCG+uGUx4MDz7TC+1WphcagIuOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrgWiaLi; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-220c8f38febso61983295ad.2;
        Sun, 16 Feb 2025 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739701100; x=1740305900; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKzOCwt4IxRDcmvUepogrVZ5T3y6zj2RdmgaYQlzscE=;
        b=DrgWiaLiyjrrskXYCjmxaYm2NzEwmv7ncvlEsE1eU1aO/4t02yUa6IgD+1NjrDjKSp
         Qucsrx8sCWQVFTZTJh15WalAMsOSP2HzJGn1y5cVKnbnxUg5128Aujk/5LHwtq2MQBuc
         iIrnztQ4na78pf+45ZS2ULDkVFQncjmjjNcboaYwp6eeMmms7OqjG/adWZSzbaNoGD2C
         shHXYfnTZSRaQU0zq35gG0R5KbdA+neJlk+SkGRV7re0YP9vNjSQX/DGWZqBK4CjRs/w
         uEyb/xLHROnLh2VQf1NU8xPciJXdHrsI0BAX/x2RfC94OoUWJ/QJSjLTHszzHdrhbOQS
         pjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739701100; x=1740305900;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKzOCwt4IxRDcmvUepogrVZ5T3y6zj2RdmgaYQlzscE=;
        b=h6vpJ/1jTC0bONp8c/y8tbPzoNXIg5CDyxIdm2G8IqsMU3GmJoV7sxFeet/AaF4DQD
         sAHWs3q6W7/YimCzR2nTBVsMXPvSPWd2Mrg35Kmy8VSTDGi+QHvDfZ2ea4kqU88oDP22
         dKYOpFqDpOJ4b0AFKw3/EHXAAOP7dUoaqmvBgUNYD87qLJhHE4k/ccqIXrRVHs6nchfB
         c8DhPBpMTOtPyyCTlX6tLAhk3bDtGcjzpS/vA7ubrLfbwG2EeN+JR1TgRGl2mEj9ltNd
         gtZOo0VgStiLhQ2Cf18H09DbbE7hMj+0eD6Uc04ZgDMVz23oa9hc0DW+B97Di8TmGZKD
         63jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbUEZ/Zxv+uS4MG2RARWTBo/4ZRrX+ocqEiRNkx3LBV9ULjq1DBW6Oly5IjKN6xizF9a/8nulqB0/Htls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/7Bj/k7l7O19tPyP0nFH0h+cZSIejn3U6XWyKeFmY7fuS59T
	uK/K5qqmi48ci36xNWll/AxYmCkhWllyDLEfd29q8kQVJML09dFD0QAU6zyGLcEt6N9vI3s=
X-Gm-Gg: ASbGncuV4eyKVCZqHWJQdH+GmYlHo6Z9sDxamyaqU5hsJ9YCSxyad8kHom0fIfCHl4n
	jarWhHxp55IHPvyNx529KVE9H8zLapQ8ARFqpbaApN26s+Kqm/LhB7pvDxoD2EankPD9OULaWOb
	tjIB1ltWfp1ZRC01y9JsTONpkBzsXPPxNoSpesoepraqokg3SxZwBTR/RsPh3BBOnn7kVgT28zq
	Up2oPDE/jtQJTeUAL2IzBr94zL26kZwAa32sEVUln4xc410aZve/T+IdRwVNAzdOx8xy3MiiQgW
	eVnmRwr2ooQEeQuhY4B7hxjl8Yh7ytBO51Se0Qk=
X-Google-Smtp-Source: AGHT+IF0u64WYToousabG9iApOQg4koz5I9AuilKa7Rx6Ug+aeLX3ZP8f1kY9rBu2m2aPxEZS24+IQ==
X-Received: by 2002:a17:902:db10:b0:21f:164d:93fa with SMTP id d9443c01a7336-22103efa6d8mr80960225ad.6.1739701100427;
        Sun, 16 Feb 2025 02:18:20 -0800 (PST)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536457esm54196695ad.85.2025.02.16.02.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 02:18:20 -0800 (PST)
From: Ruiwu Chen <rwchen404@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	joel.granados@kernel.org,
	zachwade.k@gmail.com,
	Ruiwu Chen <rwchen404@gmail.com>
Subject: [PATCH] drop_caches: re-enable message after disabling
Date: Sun, 16 Feb 2025 18:17:29 +0800
Message-Id: <20250216101729.2332-1-rwchen404@gmail.com>
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
 fs/drop_caches.c | 7 +++++--
 kernel/sysctl.c  | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d45ef541d848..c90cfaf9756d 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -57,7 +57,7 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 	if (ret)
 		return ret;
 	if (write) {
-		static int stfu;
+		static bool stfu;
 
 		if (sysctl_drop_caches & 1) {
 			lru_add_drain_all();
@@ -73,7 +73,10 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 				current->comm, task_pid_nr(current),
 				sysctl_drop_caches);
 		}
-		stfu |= sysctl_drop_caches & 4;
+		if (sysctl_drop_caches == 0)
+			stfu = false;
+		else if (sysctl_drop_caches == 4)
+			stfu = true;
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


