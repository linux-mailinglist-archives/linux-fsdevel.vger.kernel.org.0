Return-Path: <linux-fsdevel+bounces-67694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93EFC4747A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5773188F81C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB862313542;
	Mon, 10 Nov 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cThjWDBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050631280E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785788; cv=none; b=KUeQhR/6lOzx4h/+g69oNbZpX6B3lnKUr2HA6o6ZykzdqPzh5sdYu2Bmi8eOHGqPa4acepOZPMpDH0LAoBcpinaeTb9EHY05rPty9J7wvjNQx0o3sCrafPHo9Tz5q9i4JgxDRFUqwJrytN/irD6Iol+jXtAtCeSUVvcmoE9VB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785788; c=relaxed/simple;
	bh=rq8inUEioFPmuMEK5dyLyp/Z5EEtZ4ialpzlvE8Z8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcf2IXXE5BQjka8w08gLngd9KQsy8xBDI4aSreMyfcMtU3Mtt+Jq1W5Ky710UHzcPyl37vLJmazXnEfZV4H74hK+AjY9OuZaqF8YyOuJGYLaTExkw/LVEPrpa6NiPGDNz5fnfR1ksYbw/r2lqAolEq2lm51WAeedt8Vfv35B/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cThjWDBI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340ef0e6c06so275135a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785785; x=1763390585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JikY8RUWAS87/Uf8jcHZAVFCfs9UYHP3mbI5XvHhWpo=;
        b=cThjWDBIb0kUXiKtQ9CYWWUBhosJFcZ2VEnYBhTU35Ofl5N8xdl/eeDcAqmdtjvdvO
         FuZqwbpkLuYMq/TcdfA1OSbWoTaiAP+DcIsQb6k7kr7nJ+oOmKu9h4UsCdPALXNwj1el
         7D8Kk8Qqi04s1FZXIAJx72qrUQjq1tQ1e7RHmGB0vVqQ9oRxKMEDA5ksyHbqVW8rdaFt
         jcGs7fWzCv4eL3zVAtuzh5yBCPN0FuRKFIoEN91wxLYDZE21OHTcgZ7RVmAUFGqVHAmf
         5PXNs5hFUXIniLzk2+E9xE9R5dKYXFsNhJ/WSPRU3hhF2ewM0gtjzwzUTRLObi+4d//P
         Jjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785785; x=1763390585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JikY8RUWAS87/Uf8jcHZAVFCfs9UYHP3mbI5XvHhWpo=;
        b=gMdwtI/4XsEaGbdt65/xG/73c+ptM0YPtKSopQ3kWOo6uR/avK84aW5k3c//kqA7wg
         LgQ6YyQw/8ZBipXGKoCNjC1Q7yvfAMmaDv1fq+tOQgoLYcVLpdEsjk4fQqb4RNM3pGlq
         eB2WNCNfqqeZtEQgsqm4lzbRBiZO99Eleh+9SgA6XBtQDGqbxlQxogfdBPH5lHNmB8Nf
         YsKLxhXWRzcNBpu+ABjZ6wQmSEfhPNiXZDWmqd+x7G83b2tGzlKXYxS3hHcBvGmUm1ct
         VShNMjGKVk049zMzsE0iIX4z8h/UsCPlyZ0MG5awhbbG66WMXLFORbrCz70lXL4ReEsM
         B+Og==
X-Forwarded-Encrypted: i=1; AJvYcCXSSQCyANnSw1b0gl4ioW7HjTzcyQsE1HroAliriHedunczDxwuVv6PkY4sEXD+ri7V9kvddXNEumE9wrRi@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyxeytnGs9tFhXD2GHljDoDwNkxJbpv8LK3IdcYH6vX4Jz7ia
	2AmlypvQtp6T2uwQz3xQ+54PK2M8CRqnjgV0kcvGHjdCken8W+wrKXK7
X-Gm-Gg: ASbGncvWZiPL0O0JOSWMnf+H/tjSjOXb8HwyJmEe/A6TPpbSCuzJ2ByhY1yULgL6iP9
	5Wr/PbPW5hQKrWDWs1xYNFZLuUAxy6Sa3Gc36IqmimcTHrah2IKZ/mGKDxSk1HNAnSPmIIybQHb
	r+dSs5EpWzuHQ3cnk6kr4AltLyO40xgROm1ZalXin42rBK4ojvKHhJH/g4b/EtykoHYa7yir4oj
	KMto7OtyGVXEKA0aQKJKLpxgVKVLLcygC8wifeT3oXBMDxSv1LKv+0+pYvv2OXxZgUMY3E2Ude4
	M+sBDVxEDLyXlIMKobLUel9aFLWbgOFZ1ssFrlrTYzc1auENsfb+GB+K28QnrYlJrj7loyb2g4t
	TuzKWQY4+NNvnnLyCLbAKjd8sg0eiP9mtd4VXcdCXl1szTFYlfbWqNYPS1Bg4FkUYLz72dwhV+K
	nt5c9JtvSYW7f/l7JZuvh3DhP5uPO9
X-Google-Smtp-Source: AGHT+IHBa1xJTFMz8fhGb7BKgNk6MKI2wokPJ0JpH1QYJDJFAVfq7908wrIU2cRPDlRk2m4QFg8smA==
X-Received: by 2002:a17:90b:1d11:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-3436ca72a20mr5911655a91.0.1762785784925;
        Mon, 10 Nov 2025 06:43:04 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343abec3836sm2163308a91.18.2025.11.10.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:43:04 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jesper Juhl <jesperjuhl76@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH v2 1/2] uapi: fcntl: guard AT_RENAME_* aliases
Date: Mon, 10 Nov 2025 23:42:31 +0900
Message-ID: <20251110144232.3765169-2-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110144232.3765169-1-nogunix@gmail.com>
References: <20251110144232.3765169-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Including <linux/fcntl.h> after libc headers such as stdio.h may leave
the renameat2() flag macros defined to libc's values.  That leaks the
wrong numbers into user space even though the kernel header tries to
provide its own aliases.

Check whether AT_RENAME_* is already defined and whether the value
matches what the uapi header expects.  If not, drop the old definition
and replace it with the kernel one so the exported flags stay stable
regardless of include order.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 include/uapi/linux/fcntl.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 3741ea1b73d8..8b667550e44a 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -156,10 +156,23 @@
  * as possible, so we can use them for generic bits in the future if necessary.
  */
 
-/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+/* Flags for renameat2(2) (must match legacy RENAME_* flags).
+ * stdio.h may define these differently, so check explicitly.
+ */
+#if !defined(AT_RENAME_NOREPLACE) || AT_RENAME_NOREPLACE != 0x0001
+#undef AT_RENAME_NOREPLACE
 #define AT_RENAME_NOREPLACE	0x0001
+#endif
+
+#if !defined(AT_RENAME_EXCHANGE) || AT_RENAME_EXCHANGE != 0x0002
+#undef AT_RENAME_EXCHANGE
 #define AT_RENAME_EXCHANGE	0x0002
+#endif
+
+#if !defined(AT_RENAME_WHITEOUT) || AT_RENAME_WHITEOUT != 0x0004
+#undef AT_RENAME_WHITEOUT
 #define AT_RENAME_WHITEOUT	0x0004
+#endif
 
 /* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
-- 
2.51.1


