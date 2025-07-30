Return-Path: <linux-fsdevel+bounces-56351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D2B164EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 18:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481D01890854
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4D2DECDD;
	Wed, 30 Jul 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XznV2Mdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914784C62;
	Wed, 30 Jul 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893862; cv=none; b=aDX6K5o6oQ6wKR3sSDVWXBoBn34YZPsLUY/V4kMmRhBK3A/0NO5i6wrP5HW/C1rlgCPGJ3kjLcJ/scuvrpiln6L647FS0xmd7NcbXTH6yc4O+eBYZokMjYUbEamLllP9pTHSe+JFbpFgQKp1J28np/zWTxiFyK1s47WXGEw9Yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893862; c=relaxed/simple;
	bh=QMLIvD18q5k/AyzxrfAowYJawMX/ckycQV4knkks/tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTbL51EgMBO+HLyh7zRsvePExfjzULny97Wp2xutnb4eRi2lQeTDIfXFRo7R+yvM37EmeMYPNVW92gaOU++Kkfx9vlwv0fkToUtSd/CkoSH59R1Heb1jsGcNUS/bJ9A86t4cVDhlzxao17nsZ7UQXw44xBMNewqAav+Qb7sI2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XznV2Mdc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-240418cbb8bso236225ad.2;
        Wed, 30 Jul 2025 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893860; x=1754498660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZPUO2mFivOcWxZXzDCxvwiqepTKrGBNT8NtkFMEnaM=;
        b=XznV2MdcRNmIq9rLp8o8UukOLs6bg08d3GzcNBdOgL+/6ygLtogY5TzSXIHe9m9a9T
         4TjM/nlp0EjCxbCjdvTdkQCUWNLQwxRAA4UYwLLncJp2YEICEHgPEWBvt127QYALOAjj
         soo8SMiGJklLArtHnlVejbV43XnJKu1HRjp4jDNXVMzojJ2uYPq8llo3cJ66kVEVeghy
         K9tRiMh0REQKjJEpkj2EhC3SYPI3udG/MIzNo8NajIOc3bx02ybvGRjm2gxfPvv+EV1p
         HRUb5HRrhpiaOWY/3+jUZwsvaHh30zUS6vc0JgxPdSjrPfmuDSVU2RCRaUvklVJW9SUQ
         7vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893860; x=1754498660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZPUO2mFivOcWxZXzDCxvwiqepTKrGBNT8NtkFMEnaM=;
        b=rHNDrfkEz/ZCWzFHNvWTg1d/bmLad2AzfMtV7s414Td9Cpsb5JM8rqWHERHyliW+G8
         iTOQdX0Apvmw7R26kcP+3ukXDujM7ObsHmdi8ws9b/5iwCQDi+RfRisnvQPC9muM2m8T
         r69ABU0eUeApvT7EvEs5WYWGE8xa1hSZ8ERlwF9wLNXN9w5k7C02tgYoYPw6/6MFeDNK
         eCTXzty7W88otm1Onujc5mzJCmiRhayQQj+hxR5QzJpEx/c0ijRkEQe3Oo6fSD6qov0w
         vLKXxN+dSa6VYkjLnyrxXVDcIlFaSD0YE8c5GgbQjaV0ky48tv+/GDRMLuYZeetGL1nK
         iqtA==
X-Forwarded-Encrypted: i=1; AJvYcCVxaK8BjMB2ZXnFzeXWrHe7GH+DcDaCfG75tSMf1b3xehRE3IgzKdvs8aqGUTxLVEnObRDeCEvkxBVwT3EQ@vger.kernel.org, AJvYcCWuf35AVeJD8rlZTg778jpY6HrMTiq7r0C/jBu8g1P13Nn5O2Geo3iql7aauHsP2/yjor99Fq5CTvpXbBuk@vger.kernel.org
X-Gm-Message-State: AOJu0YxDAivSDDJPF9hMpN2ERCskUM5sYy3uo8EHk4tqNTTO3gkXbYZI
	9X1Y14utxN7+3MEmU4i3sHT8LQpkP05ff0Z1DBl7Dt+DC2TcqrQIM9XO
X-Gm-Gg: ASbGncuYyWoH9ABWE71u9JdEh/LunVa/34oNcdiQh1e3zmCqnbjeQyzwyM0xeJULUMA
	FT87JQ6g5EGs15WHYi5wV7qjF+KJBDh0/cB0qc1gqHIFZ933n2mCk8VpWlVTPJ7bB0vZV2wMosH
	ZS2e8qbDh/I9vugmnCqxwE4ooekiNv1CTu6ipdrMtUK4Znbnga2lvQ7U6NaeuygDi3mw2LcsbYQ
	ltk4HeKGUA580pgCsmVFWnvjsm4pzbmgyyWh2u7L9m9KozIoAL6QcXO4rl9dziTZyYO+Dvb5vyP
	Rcn9AehdMK0nRqbwXmWguOsbAvwQzApUcnrhu8xyaSFfJuOtHEHoNr/R2REUrbZOQTX05XfareY
	I/YgFHYw8MQEHVf/kXJcGlTo+Qu8lI4KiVfU=
X-Google-Smtp-Source: AGHT+IEAPGlsRH4RQkjsmxGlo4shReiMS64QRe9ionVdAW1LTVtZJkKHURqdPOQBbXf6M7Kx6mIBtw==
X-Received: by 2002:a17:903:230c:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-24096a85e98mr55559865ad.18.1753893859846;
        Wed, 30 Jul 2025 09:44:19 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24013a51427sm81147905ad.74.2025.07.30.09.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:44:19 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	willy@infradead.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2] iomap: move prefaulting out of hot write path
Date: Thu, 31 Jul 2025 00:44:09 +0800
Message-ID: <20250730164408.4187624-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Prefaulting the write source buffer incurs an extra userspace access
in the common fast path. Make iomap_write_iter() consistent with
generic_perform_write(): only touch userspace an extra time when
copy_folio_from_iter_atomic() has failed to make progress.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
Changelog:
v2: update commit message and comment
v1: https://lore.kernel.org/linux-xfs/20250726090955.647131-2-alexjlzheng@tencent.com/

This patch follows commit faa794dd2e17 ("fuse: Move prefaulting out of
hot write path") and commit 665575cff098 ("filemap: move prefaulting out
of hot write path").
---
 fs/iomap/buffered-io.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..54e0fa86ea16 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -967,21 +967,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (bytes > iomap_length(iter))
 			bytes = iomap_length(iter);
 
-		/*
-		 * Bring in the user page that we'll copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * For async buffered writes the assumption is that the user
-		 * page has already been faulted in. This can be optimized by
-		 * faulting the user page.
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
-			status = -EFAULT;
-			break;
-		}
-
 		status = iomap_write_begin(iter, write_ops, &folio, &offset,
 				&bytes);
 		if (unlikely(status)) {
@@ -996,6 +981,12 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
+		/*
+		 * Faults here on mmap()s can recurse into arbitrary
+		 * filesystem code. Lots of locks are held that can
+		 * deadlock. Use an atomic copy to avoid deadlocking
+		 * in page fault handling.
+		 */
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		written = iomap_write_end(iter, bytes, copied, folio) ?
 			  copied : 0;
@@ -1034,6 +1025,16 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 				bytes = copied;
 				goto retry;
 			}
+
+			/*
+			 * 'folio' is now unlocked and faults on it can be
+			 * handled. Ensure forward progress by trying to
+			 * fault it in now.
+			 */
+			if (fault_in_iov_iter_readable(i, bytes) == bytes) {
+				status = -EFAULT;
+				break;
+			}
 		} else {
 			total_written += written;
 			iomap_iter_advance(iter, &written);
-- 
2.49.0


