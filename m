Return-Path: <linux-fsdevel+bounces-42168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447DA3DB1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624A27A8C0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369491F8BC5;
	Thu, 20 Feb 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnpeBoEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522F1F5425;
	Thu, 20 Feb 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057553; cv=none; b=BowxSsQKQgm+Ue5EiarBObx8IkGxWbgkppUbF3Vcg9bUtKsP5oT4soKA/Zt74eL8L4u+8LlDggwA1QVR9zeLZ2G4rJejy1i13v5tzHm85ejI+Wd0tN7jsfSDj4GyYSPTU1DWZqRMgEhJiyVmu74kVPfdTaKcxOoH6LjdBlmkyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057553; c=relaxed/simple;
	bh=EsMTxchL/+qRXxcJQQGMEd1C37/sV2jkPmF5oFcvccw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A6Rv4bAA7Zg+K7xVDQi+vbZ0xzg6JjVGWlVgSEUstmKYNOOzzVqGD3+drI7qPypHNtbuUr+V6fo6/hL2duo6+F2URMTa5YENR+YyiSLATRhmpfVuptR9MF4XKTgPaJj3PjxXuykGMXrvuYD86eKW80PJfFNjBZHDQXRP0bDit+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnpeBoEo; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21c2f1b610dso24067225ad.0;
        Thu, 20 Feb 2025 05:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740057551; x=1740662351; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v9P9H3YBcyOxNExufhwVnRqWtrvWAZlTnbL5BKFsIaA=;
        b=YnpeBoEoAa5I2hhbMAP6La9qvqhldvWrvpgV7pvrhql/pvF1hAPrfNCKAJ2BaTSQfg
         JIUcXFi30MxJEUt+h3hw3OaKXCBAp8iCJcKB/H7yio6Blm20Mavbv9Mu6ZbLdVjel7wx
         eHoQsm7yC7JcYfdJhtaS0i1b/pertQekBoSfTdmQduHMG5vtvt9o+vUkSSMU05RuXb8G
         1yFi3oJKkkhVdD3H/I8o/CO+KfSAUXGJvtDHGlz+7t8gFcCGUd/HHnAtXQbIpYVhws6o
         2tnlP0yVqzrBPim1JP2tHtIphC+0CZy/rC+3pDsMtclmpZJDLqTvG5C+cJ90OUgeliVd
         Z+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057551; x=1740662351;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9P9H3YBcyOxNExufhwVnRqWtrvWAZlTnbL5BKFsIaA=;
        b=F2dgt8TihC7lEljiwnNulQ0pRCcZIkR8aQtn7HrFqhyrie6E7gF/CHd61WLu558DP7
         VnXFJ68sTrXiL9hdFlrQW7wy0WJaJh9JuTlCxInpq1gfAp87v5YWrmuaAsKH36XNACpe
         Al1XDoRRulbs2CEApq482F4QdB5rD3ofvQgK7LGDLAMMDgRHQ1VrvMRnrv3wxc7nE/9s
         FX109m229WKWE2WFMt718Wd+jPpx4BPJgfqdttPFlIkq0wcNwxMJy1K5pIfdbh7AHagO
         rHfvYorSn1R+aTvoA/Y16759Goe/sWbFCo7QUy9WsLLs6knHt7ZNFT7ESzm+MycGzDKX
         9C+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtX2BzeCwrXN3Lj+DF+iHeIA2+fJq+uT4vyE8XcAHv5J6FOEKP+FIwZ56voO8cBAdk+KMjvxsY71g=@vger.kernel.org, AJvYcCXfDvD/t4vWN+xwmpyC9Y7+VI2bPUCwCWHTLni1UaaGAci1fDSkOiBqWSDR6uAnERAk8X8B6so4Ph8Bp2HT8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8Q7QVRHBNKVY2hdMocRZrxCl4L7gkvb9MUCEpxw/z6S/ucYN
	ZoAB0S1A7f10ReSoZ8vyMuTRPOqn/c+k+gHcawaLEG6XDQdl4nB8q1/BZEVkwp4BDQ==
X-Gm-Gg: ASbGncvI0+5X4mn+8KIz+3p0W/MZRN1QkVNZ4GA8yrBVVNYxmZfCcPsUzgW2y95ySCa
	zy6BLGrvDAPpNmsRPvHHaOElva1m+QoXMxAzPio7nw1kGsHoDrb6HXFYODYTm4GX9Qza0/J5n5X
	8648XezftSRPsIf7LuNJlQrPMar2KQagM/DX5KK447u4Em38WzQyQSGKGHDhqxhmqg9xHFh654u
	fdPpEb4D0RJccbQ2MLF4em8oZZtwWxprhtqSHo//O/ZF0wvNxNqoOsiBJTPuG0uAddiU9HkVK4f
	cmATzuUzutDawMlJnXw51RW9QkgjjyhXGqnlkCk=
X-Google-Smtp-Source: AGHT+IHV3IxbgmEM1wB7ObFBeZ2yaA43f2JaFF7cUg1ubdEneG9dIov6yvjHeNOJIP6aCRMznDzcmQ==
X-Received: by 2002:a05:6a20:244c:b0:1ee:d92d:f6f9 with SMTP id adf61e73a8af0-1eed92dfa33mr11913487637.31.1740057551011;
        Thu, 20 Feb 2025 05:19:11 -0800 (PST)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade083277b3sm9113400a12.27.2025.02.20.05.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:19:10 -0800 (PST)
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
Date: Thu, 20 Feb 2025 21:18:38 +0800
Message-Id: <20250220131838.10564-1-rwchen404@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20250216101729.2332-1-rwchen404@gmail.com>
References: <20250216101729.2332-1-rwchen404@gmail.com>
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


