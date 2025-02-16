Return-Path: <linux-fsdevel+bounces-41784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C2A373BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 11:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9962A3AFAE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305418DB10;
	Sun, 16 Feb 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSeH+YX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB678F35;
	Sun, 16 Feb 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739700337; cv=none; b=fnRLvyuCbMR0JKxK2dsg4OZPkgUt+GCPjrcU5XV300d7ahvCax3h139zotoh4FeQn0Mk9NN7WDiT+ggIEETAbxpF4Z8QitNaJvntNCoNHAkdL19EvCtsBv0UGPLuCG5EMff2GXxvf4PQ5OBvek6T3U8Dz8Wsfd+RQtF1aOX1CUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739700337; c=relaxed/simple;
	bh=tqJVl5DhtR6Hj4AawCnDQ8amMkD89+pB31g7/EzN0ME=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s9kycupXFD2Lc9LWFGMeaA1kgP4L1WFxKI6uJuCZ1HDKsm81D17MZ3+ziwd+Ef467OHYPX0gu+desXZbgIIK46ZIgzIjvA6eo4UR7Tuid+6ZDprUH7ouNnhJ9QR1V1BmlRVba5V8zsH6F47gUCmEKYQczPzdlQyA3CVal+ZrDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSeH+YX8; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2fa48404207so7012047a91.1;
        Sun, 16 Feb 2025 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739700333; x=1740305133; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKzOCwt4IxRDcmvUepogrVZ5T3y6zj2RdmgaYQlzscE=;
        b=aSeH+YX8PdrYTIC4oXZtGkWX1jnQeN1/28eBlzsm/ZVdmCMoXBfdu0QckfFVPBetGJ
         Pk9UHst+FOnd6gIPe/xzHcqh+s8OBYoCtLNUEiouI+QmxdOZxd0TJDSmq0ajGefH2Piz
         TmYqhbfCaCRadhyM5H4X3Z5xU4LjOhVjzrVM979wU6Uzv0fJEy9uPSUKuqaVD+Vebr+Z
         9/JQZtoVJEoNq9O+KxckLb8VjHUY2XD5kTZLPP1isZaJxzXJNyrcnq1sQu829XPjWi8H
         uLkYr1Xxsef2JdFI1G1AkoVd4DcRcFHIx0Qx0UjbBPBHDC9VVrC+ID77TI0YVKIKDXr7
         LH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739700333; x=1740305133;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKzOCwt4IxRDcmvUepogrVZ5T3y6zj2RdmgaYQlzscE=;
        b=aXe78fa7oDUXdAq1/8s6VHn80PcoMk6iXjYFcTiLHHOX2BKvnujMzHRypiNoNJGpq6
         ytAOBa/1+gN8LwL3u74UQJpYks2eyWjQmvrJ3iFiek15yLc++URJSVUJHBX/5F/EfufG
         MbaN/yxKBodNRguG+qQZfPkL81SaBFC0590ouYzMq0r3LDpvPOMY1n1GfF6RdChYQ+AV
         wR8qyn3NP18Ik7rljqfZw3imMiAFSrrgu+qMNW9AGAdpFJfYV8+gbd7mRouZh1UNxFGJ
         jnxZ5AdhYIsPhp3st+GpCt/+7w/9llx1+Zo1KR2OwOoLZ7Qjsaaradrf7Z2w9JcSYbBh
         T0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWPCx+k9k1wqgbrAEe0G3ROZqnSWhfHk5uJQ/bbsAg1Nh9KLSp3+EZSArrrbbRE+no9hEreZ9C7THSxKHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIodqG9MYuPr0br+tAb/Xa9K1M3B3ShWbw1Q6y/aAHkTpFz6N
	EpTu3mvkV2giB6v8e/qht5RpBlqR/p9xD0YKAsSY9NDB9n3H9smeQwrE9ngXRDsro9OTOFE=
X-Gm-Gg: ASbGncubVud3FXo21Azs3VewdcKivkP9qyd6IfrO+HqeQXXgTAvS2b6+67do/1HLJId
	0apVzHVpnHgMPaDId9+jfdWWjcs1Tk+ZmRoakr4x9+3GnhkpxpXG24VaaF+sNpw9ZXXDGje/Zta
	nSSvfkqZuFNoNRJLX9CQc6pMcRd1w3X9XpJmyJDhu1QHaafOQLb0e/zCURcncwJVTIMGtBHSrUt
	wks8e8G5TzaE1cjoUXYsN+R53s/ChtCGSZAEYYaylRm65Q52h/A/2AClo35H+hGJf8vA9jXd7jJ
	CiDtK4NAwgX4lSmzuiOrXivIESCp/2ZsRQzJZ+I=
X-Google-Smtp-Source: AGHT+IEKSGLYnVFCJ0g9zRTeysJUboWR2ZoEuSItqi1WANCUHO4bJ8QCvGansUWaYb3qZVwQA/OtYQ==
X-Received: by 2002:a17:90b:4d8b:b0:2ee:8ea0:6b9c with SMTP id 98e67ed59e1d1-2fc40f0ecb4mr10158677a91.12.1739700331753;
        Sun, 16 Feb 2025 02:05:31 -0800 (PST)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ac0a06sm6013794a91.15.2025.02.16.02.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2025 02:05:31 -0800 (PST)
From: Ruiwu Chen <rwchen404@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	joel.granados@kernel.org,
	Ruiwu Chen <rwchen404@gmail.com>
Subject: [PATCH] drop_caches: re-enable message after disabling
Date: Sun, 16 Feb 2025 18:05:14 +0800
Message-Id: <20250216100514.3948-1-rwchen404@gmail.com>
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


