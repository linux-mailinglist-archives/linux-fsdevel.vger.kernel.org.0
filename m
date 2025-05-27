Return-Path: <linux-fsdevel+bounces-49909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC9AC4FD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841AC17B900
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B60E2749F0;
	Tue, 27 May 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FnQQH2nr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017C3242D79
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352785; cv=none; b=K5srntEdJ02RHCj7YFztCXvO41IJj9GPXqbdG7Xc6JJ7E4zq5xQh3Za8dVas1gxKNrIdmeq+U21uHxPdzDy/LEXQCkwT7nLBIhpy5Fxy79+D8JSR8W1iYz1KwfRKozjmep7CSzfSsMk/tvGa5AEynJ6Rl5k7w4IEL/psBQR5chc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352785; c=relaxed/simple;
	bh=cQs2umWI2l6TiHDZ0IYo90T428ms3p7EHlqq/ANx/D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daf2tktB0GPbHdZ8dVhAsf2As73rRzrzZ/86fYVOepcvTa/Ie5aDlNgGtq+u/dJZFpAuD7Js6raGk0AJRMoAm272rZHgXABy3VvXKuibfVw3lXu0hnOPpOHOtgMUU7vE8DmDQvTXm3Fr828nHzIU0yhDK10jq89+yfhQS9uW45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FnQQH2nr; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dc7ffeb9b8so12859125ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748352783; x=1748957583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQUuHzc/UgeKOW3LPTG1L3KG/+OJAtARo6jRX0LcYH4=;
        b=FnQQH2nrWZEyNcvdsW4pm4gxDjVXZx2vgExYyLlvfEN8Fs17jhxFn4dh29PtztW/31
         5eGEwQ8D5UJIGQStRTFeeKhq6wlBpaUq6/oqX3A+DQwB2V4qsbp84qf/DIczc4lWM73W
         MPbwUZxcSGttSiqlK5nzNXARNSCYoKolG3NybZvFY8qFZ2hPi7k2yVLUL34krqB4d0QX
         iFXkhzP2dITMS50AwXFw+ODyiOhYCPyjA4p7U1mUNBDwLPc1K2ORAs79O6bz5k2SrKTz
         B8khxLt187vpojUX0lozTlWP6Re0Dc2WVLhYCsQkEYq5a84tI9INDKdueMopdvkRZO12
         ddRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352783; x=1748957583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQUuHzc/UgeKOW3LPTG1L3KG/+OJAtARo6jRX0LcYH4=;
        b=hJbZ6F6EmR3zeWZGWAWu+K8rwR27N3064ITx2YCzWwKEcNp1X2ymo0e9gcssJq4s06
         oK+G0cTmuMkYnxY4BhG+VBKAjxkeLn8R0N8V5Bk6HZCARnq0oNWBNHEmtLHP5sfCwt83
         NaGHKltBON4F7WiT+8dXr5qlndBU47l/AXqYD5zACmsehELnt4TiNsPR0HRUuHA26d7i
         mxoXByZov24Kz0ctlIVxlcuXVN0ksTR4xaMrPH2DLltmmeAnjUZS8zTZ+MNaaMLXEmtm
         JLfzlXpKJQC6N9tjSBAyNaj/d478sCUC+VU/vsJL25GWdWh5Khpq8iCMT9l+DqddbbjM
         kfWg==
X-Gm-Message-State: AOJu0YwPbUmEucqTQCoQCbbKtWnBEcpa9yftaTq+JKDRVP5+5ClKgpsV
	muP5ESYYcrGj7B1tFGIcV2aWNgdYmIRCbVOLHqgNJG9eKvNAA+ucSXBRq8I2BQDPRBUqWzD3G6H
	o5LYV
X-Gm-Gg: ASbGncupswQD7u60qqBFWCSg9qwoAJKny9X8QdBtiss04lMhi9FEdGhnwbAtki5tpnp
	xkwh6cXreXwQ4DHB8X/825uDeCawN8kRLZVp/91qIh/SmDImkv43Z/DnNauLi0D9Uul9dEjW+Zc
	PORM0DIy0wLDWdfPoiEfiem4P4HqORzKnXnjbntYa8kfStDmC6e8wBmEDdMzSkPDcIoq0fVK9PU
	9ZaobvyMz1Dy/8P+O7eiGg+okIZ9ULrd7M47ewaZGoTY+6dWPfeThNYnb3Ik9xjhLVjdgf/iPvO
	jbel3os88SLAAZqUuqsd+fW0rGXMHLkQJjq6DsOGmXJRbI4fKgGZvJE=
X-Google-Smtp-Source: AGHT+IHDwNk8AB1Ub4YVbodSTYBarlUOGx57v2AKttcfXweJ7TX1h/9E3m4HClDqJG0Lhob6SqXHbw==
X-Received: by 2002:a92:ca4a:0:b0:3da:7176:81bf with SMTP id e9e14a558f8ab-3dc9b72f37amr125783805ab.21.1748352782613;
        Tue, 27 May 2025 06:33:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8298d8a2sm37404315ab.18.2025.05.27.06.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:33:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] Revert "Disable FOP_DONTCACHE for now due to bugs"
Date: Tue, 27 May 2025 07:28:54 -0600
Message-ID: <20250527133255.452431-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527133255.452431-1-axboe@kernel.dk>
References: <20250527133255.452431-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 478ad02d6844217cc7568619aeb0809d93ade43d.

Both the read and write side dirty && writeback races should be resolved
now, revert the commit that disabled FOP_DONTCACHE for filesystems.

Link: https://lore.kernel.org/linux-fsdevel/20250525083209.GS2023217@ZenIV/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0db87f8e676c..57c3db3ef6ad 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2207,7 +2207,7 @@ struct file_operations {
 /* Supports asynchronous lock callbacks */
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
-#define FOP_DONTCACHE		0 /* ((__force fop_flags_t)(1 << 7)) */
+#define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
-- 
2.49.0


