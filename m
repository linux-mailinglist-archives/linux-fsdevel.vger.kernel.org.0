Return-Path: <linux-fsdevel+bounces-42332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC092A40676
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 09:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CACA19C370E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DB2066E5;
	Sat, 22 Feb 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrhDTwlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ABA20011F;
	Sat, 22 Feb 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213944; cv=none; b=B9SplqtyuaMPjUW7tf/sCnbG+En720nCh5kvblGkB7cODcXdfo6/LNTh5lR+CoWxY5dyGNrLBUiaePu0mUMB05j1SCxvKye7h99kp+kN7LZeG80GB/bgL3hwXKhpaLqsIu64Cy2cLNupjcVVgwt99LAlEnBF4143gCkcxQ7HuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213944; c=relaxed/simple;
	bh=x3IFcmUoUMMOpJ0B8j70hwoxBrXAvL5JzktmNavcH3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YhPg6EDl1223cwJTU2QmEbAi5KkWHzt0pJQNuYO/aHwb/gx/MVPBH4XxOQANXUHiR1qdFHm84pMF+uoXRrzVOiRep7rPGwO6FipVPzNCixU9wrHFXvJtEn83fHciuIqjtXRGVsqhvO+kFLqMVdKyPPP29KZ3UQNU8eZj45bOAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrhDTwlp; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so4733813a91.2;
        Sat, 22 Feb 2025 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740213942; x=1740818742; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EUCyDvVDqz1r39is3ixWn/47Q4kmfyjZJP4iPVKQKto=;
        b=nrhDTwlpF/ia3QpPvRm/9oglaGR8Nk7a5ML9GbkOWMwlmBk4U0lpNJCdvuCF1bKOjg
         SiQA91byz1idthyTw0X9Q+6eoB3+jMmRsYooKmbcPtV/Pty6wyXLoFFu+wBlAzwqrUgd
         elpB+iRfzY+Kq+Ep5iNCjaKJfhquRpRfMuyFmFUuSXu3p2zSMavFWU4pZc0xlJEcxTfj
         XyfTSPxuvkkxOeKcZPokCvsgW9UGxmApvuD6DRPrKglz3D8wbhYl1d1uO2rRDT4O2Zyj
         lsWAGju4nxObPf+v9MoXI0Q/Kq6vtLLsLmqDKtoWgmKQsthpBKMFwaB1UJ0OBbosOcHR
         oEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740213942; x=1740818742;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUCyDvVDqz1r39is3ixWn/47Q4kmfyjZJP4iPVKQKto=;
        b=dEzsNQ99+3YsahrXOZjsv6lPq2zJUxnhY/4H7q9eXy15HURQW99M0j/aJzYaVneX+V
         h1gLS9bAfsYI8RvxvnlcZ1PEwG+ag339xYzYl+68VT17kq5cIY4eCLWX0WoJIkkt1Xmv
         CRmatEucE93ydEb3e80JF0MSporKQuUze/Q8eI67/zkiDbJoBRWAwRKvBYSQn2XWyYq3
         d4MNxZE4JcJdZFpKLvVqbj/L4T9pDQAECotn4fEkTR+VCNQd8r2zjjVTnqbekh66i7jR
         PfKp/q0WoP16e8/galxNJyzpvCmg47jLgbH6lcm7AS1fGtF2c6THujfifuLKJ+3e+fsn
         GfUA==
X-Forwarded-Encrypted: i=1; AJvYcCXKYNa4KPLKUKaMWwbdWZz2GFwv5tOVIZDuZwexr4bQl3DG4Wc3wwM2AIURTXdwRb1NrwaURCKH5rToB9Er0g==@vger.kernel.org, AJvYcCXQ3+Er3Z5nFDGblchInPXu3uIbMKKk6//26Kib0OdNxH9n3Ut+p4ZfkGpdB/b0T5q+A8ikBgjsxQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XUyi12Rcd91eOzXTBeWt+KaxcbQ2ByU/GAL0ZEftnHnP6qKn
	7rupOsZHQDTVyE4GT/a0z6xBQUqVSeGjHgkVmDrEbm/GS0pr3Qm627l3mlILkdQnKiyb
X-Gm-Gg: ASbGncuQHlYZp/Edf5oSTLK6PPm/LvhWrrVf6XpugtOe24Y/2/wVcmTvu0IeYYsX6B6
	Y5GsMrQl8mwDc/Em6LD2x4LwUFakYOEVyHihwfhrbNXn4VI/I8IW0BWi/QyMvHXm8FJG6EZNcHy
	ZUuawY2myUHXCSnrNaQyZFyi9iP8KUywUEh4gu4xojlyJc8LVNaqTBGyYpN/l/ahXf/CCNjzkrq
	Imtsbk9066rPezlr5qqCMmbstzghk75uyAfeQQZQeJE+3lxkr67Xf6x0nDh7Q1QFiWWOVqFHAo4
	o3mdnXAjr7P/Dr4J0fR8yjesOSoxO9EE3mQ/IwxeOoSLwaNt1g==
X-Google-Smtp-Source: AGHT+IH0oaJdTfRKXSJDhoZRAjswW5hGltdPhAalmnHKCcj8OE5j1Aqgi64LvPMhsMewSPaNNDR29Q==
X-Received: by 2002:a05:6a00:1892:b0:730:8386:6078 with SMTP id d2e1a72fcca58-73426af0e93mr9623095b3a.0.1740213941663;
        Sat, 22 Feb 2025 00:45:41 -0800 (PST)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324277f388sm17582793b3a.174.2025.02.22.00.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Feb 2025 00:45:41 -0800 (PST)
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
Date: Sat, 22 Feb 2025 16:45:13 +0800
Message-Id: <20250222084513.15832-1-rwchen404@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <virvi6vh663p5ypdjr2v2fr3o77w5st3cagr4fe6z7nhhqehc6@xb7nqlop6nct>
References: <virvi6vh663p5ypdjr2v2fr3o77w5st3cagr4fe6z7nhhqehc6@xb7nqlop6nct>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
but there is no interface to enable the message, only by restarting
the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
enabled the message again.

Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
---
v2: - updated Documentation/ to note this new API.
    - renamed the variable.
    - rebase this on top of sysctl-next [1].
[1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next

 Documentation/admin-guide/sysctl/vm.rst | 11 ++++++++++-
 fs/drop_caches.c                        | 11 +++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f48eaa98d22d..ef73d36e8b84 100644
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
+	echo 4 > /proc/sys/vm/drop_caches
+
+To enable informational::
+
+	echo 0 > /proc/sys/vm/drop_caches
+
 
 enable_soft_offline
 ===================
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..a49af7023886 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -57,7 +57,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 	if (ret)
 		return ret;
 	if (write) {
-		static int stfu;
+		static bool silent;
 
 		if (sysctl_drop_caches & 1) {
 			lru_add_drain_all();
@@ -68,12 +68,15 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
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
+			silent = true;
+		else if (sysctl_drop_caches == 4)
+			silent = false;
 	}
 	return 0;
 }
@@ -85,7 +88,7 @@ static const struct ctl_table drop_caches_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
+		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_FOUR,
 	},
 };
-- 
2.27.0


