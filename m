Return-Path: <linux-fsdevel+bounces-79690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLB2LJ8GrGkxjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5632A22B58F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2929301A2C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4093321C8;
	Sat,  7 Mar 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE9jpdQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE23446C7
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881559; cv=none; b=AER+PyuoMYquGvy5/L77u8W9eH5eZbMxt+/hzOstEkoOu9K/rEZZZjHQvKR9V5N8fy3D4dkAIjMnmKePCm9SVfTr+e4uMqqeDBajGriNtGYxDqNbnwYGOMvWNw1iox5JHZU1lIpQSwNXWaaFNvy6GOV8CruzahxaWxhUIfzG9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881559; c=relaxed/simple;
	bh=WR4uXt1HnY4438jBRKBAW+wDMglfPiVb7m/G1xDACjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFX0/hyFIDlZ2XYwU5na61IJVk+RKSMemFz6LgdqgfjxJpKNDFzcYsTc/i+l73dZWT/aecTqMFAt22qdBqgghOBQCiI0h3KkldAE9zTX2RtFZanQ7AzKFK2amgC0c42NE8xtGlWoa+wBfwUTt5QHR/0FFz8CGyXMygJZjx8MGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE9jpdQY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-661568ce781so4111071a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 03:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881556; x=1773486356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EeWxALgWg5+UdkFUkTOHoGNgYBMU5QKe1yAPPPcbxs=;
        b=KE9jpdQYdOt2p+jgbWPHN+e3vtmRx8jvNLyf5KUPu2IHotBAV6fFqi1BmD3IzsbnZK
         JOxc3be3Bk9LimvzstcbvbLH4ZMWvZZDsV5vQ3aQQHUoBd23r9+jQxQBKjdZ6cpH2oyp
         M+yoW/umkz5CXzwm8hK1Qktc/buha1JvCkQF/2uaE4qt3WPeYU7c2gp4o8CwWRHj+A/U
         +/w6w1Ru3vFNPyGgf47Cmzg3k/YXAOcBDcTwVgzPktDeGzMm33n0ONNbOGfSHJVVR4co
         mEfy+e1W/HEnufnajKerOINLLaKK6htSQIfBl7HBDWbx1ECAG6bDmzFm659QTjsyuPYm
         bHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881556; x=1773486356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0EeWxALgWg5+UdkFUkTOHoGNgYBMU5QKe1yAPPPcbxs=;
        b=FBMIAZzaMKbc18UC+qqLXejqc3N5S8U1ZGz/QU36+fDJkaptBf87K7fH0VNvIOoGSm
         sOHZxpXm8Y+5r9O5FSW1WtZrU6bhpkeFzDZzPG62FcLWkki5X4IkvJNZw3UeB3q6pLc6
         /HsBRjo2aHsY+uCmJv1KQqbjMC/yS5NSQ/a2IqYwZQ2zb/nnLSmr+dc0/hdZfjPp2rmP
         cDIVUsgkinNHYYR4BDWsgc2ui6tAKXxwvtfU3OpJ1F7YznW2mVVDLkBusmBNHNEQFqw+
         OF0lh8G5LvQJHHSQETGvm0Xj7Cp/GCk3aSzA3F6dtWmEZdMfpBL8F+vv+j2Z9bJ65XCq
         GFwg==
X-Forwarded-Encrypted: i=1; AJvYcCXa7OXbtCVCrRytab1EyXu8hJN6qITMjSpDDVUsY7IxmIY2h+Qpe7ZA1IHShjWLKlztySOTafn5g1BFRcPq@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCYlMtHtz0JvDK9LqlcLLkOAuo4TFIQ2bWghglURuUocxXtFE
	Gx8pdhm3Cv39OHn/UjkeQtyz/cJtQKiD/FLjaKfKhc8/l0qmsVNeJNxzu8RK7LUw
X-Gm-Gg: ATEYQzw+a9152WEVSruwqJKgQVd+1xCavibSB3hk8f+U1FXiOo3s8rQkKxCivuuwEeu
	pSjTf9KZZBKa7wZhxXsVyAlqIpkEYW0vmqbWhtPo7IeTxY4s/HAyC5rsOheszzxXbUVOEPm2tQW
	wHGVexairogX/SV5HOyFKW6m7k+miSH1e+UJR/D3+2m0wORFJQ2spIBeNOdS5r2YFmKmSdfYWY0
	nG09zvfWtNp2zKFmczsw13Xazl/0ZtoAEmMq28fRY0ag5SHzYp/e5Htdi9xuNhIjtcuzgKcPfUM
	jDsbeKcps6oJcTz/gin5O2xVklBjcZxcMGE3JZJecbRvlMHQSfvW8bSq2SxWMX1wVBs/weOgQ9y
	tG3+g310QgszvwuiDg/fqcAF1rVFvf1jF5grHxUYVH8ZU4Xm/3DBzmOZBWKldYw+6vgXgTaJV+m
	gHCgA6P9jtmsNTFEbNj8n64qnkRO12Xxp8gvMt1mG01xpllgBRL7j0m1nAHfleniucqYERzN2pj
	e8xpd4s6rX8o4KXJMH8OOgckr1i
X-Received: by 2002:a05:6402:2755:b0:661:7c59:9e0d with SMTP id 4fb4d7f45d1cf-6619d56b788mr2896725a12.32.1772881556102;
        Sat, 07 Mar 2026 03:05:56 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7ad4-b88c-4d95-6756.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7ad4:b88c:4d95:6756])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a559b992sm1150512a12.25.2026.03.07.03.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:05:55 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Tejun Heo <tj@kernel.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 3/5] selftests/filesystems: create fanotify test dir
Date: Sat,  7 Mar 2026 12:05:48 +0100
Message-ID: <20260307110550.373762-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307110550.373762-1-amir73il@gmail.com>
References: <20260307110550.373762-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5632A22B58F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79690-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Rename the dir mount-notify with two fanotify mount notify tests
to fanotify before adding more fanotify tests.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/testing/selftests/Makefile                                | 2 +-
 .../selftests/filesystems/{mount-notify => fanotify}/.gitignore | 0
 .../selftests/filesystems/{mount-notify => fanotify}/Makefile   | 0
 .../filesystems/{mount-notify => fanotify}/mount-notify_test.c  | 0
 .../{mount-notify => fanotify}/mount-notify_test_ns.c           | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/.gitignore (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/Makefile (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test.c (100%)
 rename tools/testing/selftests/filesystems/{mount-notify => fanotify}/mount-notify_test_ns.c (100%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca9..dd48b69c1b21d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,7 +36,7 @@ TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
-TARGETS += filesystems/mount-notify
+TARGETS += filesystems/fanotify
 TARGETS += filesystems/fuse
 TARGETS += firmware
 TARGETS += fpu
diff --git a/tools/testing/selftests/filesystems/mount-notify/.gitignore b/tools/testing/selftests/filesystems/fanotify/.gitignore
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/.gitignore
rename to tools/testing/selftests/filesystems/fanotify/.gitignore
diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/fanotify/Makefile
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/Makefile
rename to tools/testing/selftests/filesystems/fanotify/Makefile
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
rename to tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
similarity index 100%
rename from tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
rename to tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
-- 
2.53.0


