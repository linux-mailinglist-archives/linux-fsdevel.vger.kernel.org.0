Return-Path: <linux-fsdevel+bounces-56074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1222B129CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 11:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84B3189CEA0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22372248A8;
	Sat, 26 Jul 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+fh0C/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32231C5F13;
	Sat, 26 Jul 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521034; cv=none; b=hjVp9CU3f7Vd50PbPJsv75WFd7MCWXqBMaGKLWJm1mInp6PFEoeR+P5biMAx5cbHWqqfd86ejtu8QFJi3eYxweKWIjfyiTQaFIt6PazA6IVnBR+0bO1lxLHouqPmmDj3NqbtYb2XqpDybJni82QLCMdibeOBPEO3cUdYoWZ+wUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521034; c=relaxed/simple;
	bh=SfggtfGe7PB58v5DZwweW+m6rEGnnfzyw02zI8O1v5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAsaQEPW2bbzbd4li4IBaEWU7kBJP8jDOBmJbal2Yd+yqBy5AL+HbiLIYDYH0Y/cMOfgD0P2oWe4ynFCQDFfpBx8PtH2G8Kr/GrGvfnXILRUMCxTRviSIUF2OYydobsImZOTTrtjN2if3kRlnc0n03LyFzVCXWiPILlBy8VZWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+fh0C/P; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b54af901bso1947751b3a.2;
        Sat, 26 Jul 2025 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521032; x=1754125832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRyjZ/Xf4lOxF8UOomre3BOUYmwqK2BErDCowQX7LUU=;
        b=Z+fh0C/Px5RUEz2D/4pH9WdRcCWE6EqNvdR2D6vFwYIycgESmoYolRgNCdt8GBv/Cy
         8p8K+dt2TlfMIt3pCokcFIbxke/Nz1RQRJ8wEDHV7rQJcYF9g7zWSINevxkJHLb/ENHS
         DZj0qNP4xcO68Fil3JR2ze0IZElEKEoP1HNdeO0b3VgFLn0+JPzUIsgtEqq2loZ8mlW7
         eQSzsJ2eRSmjSKMDlDG/LaLgZRvwJ/iWKl+2qwU1vu+kYT6VVntx+jSEkAwToIVJsaig
         7uxVjirGSUO8TmVkcDFXfz50mxITNJ+EQWcRel1GAfNHDz+92f8KDCJMvY+Fd16n0elr
         ImfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521032; x=1754125832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRyjZ/Xf4lOxF8UOomre3BOUYmwqK2BErDCowQX7LUU=;
        b=IgHPlnGfCAASkDUgNC+QStj1Ldghy/oZVUbKGZ+Iq7BaXFbXxd23Qq/Lr2XNCdA+UH
         lioaBXBkfD3yXTwOiJEShmvdC2kLM98M0homSnjklr4L4i8CqdtTEZGxi2RmL5tjWpSn
         w8qKoXP2oOe4Ofy2ZWcJUuGKC6P2OnKET+wccGoU/RmWSTwwR6BF3q3QRH25mc5p0Aqe
         oHoyNezAzmGdtkrM8KBR94UZBN5dSwwTEttk2wY/o5p8cXG6Xvf/1Y/4ca/hJUHXn8d3
         MfbK30FFuSVbgpj0BqtdlpeHNQRNqJkd/M2Vt71/85uZqn7fXOoKQOFDi64U/qMGwEM1
         z+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWgVWWE49GvSNaTxCvzcOVRTe5jzY4ipC16007woNSo4GbFY2AMdtTC5fy4oLV76zsoJAtUJNXpOhGu7ubb@vger.kernel.org, AJvYcCXIkHeHFLTD6tMNBaAObyjYkbgPI1tPymel3k75mYve1quEdBiUm0eCo6YED6ziPydKwqqBTkNl+36vQtyw@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVVnVp588TBdlQ6KucP75n/LRQBCsywGh6hWmIge/asvqlQEc
	ljzpdJCsvAi1SX/SSb2+VDfbbwlLGE4a/pGXnMDCsP5IpuXNm2PxKneJ
X-Gm-Gg: ASbGnct5J83LlGhx6DntW9wyhzh+ja3M2gLPw1UKRI5c6UU+5zvNKOG6JvUIQfMdjy4
	QKgS+zX0Njai92wXc4A+aN9nZ4wwgv5z0J+DNl7Vx/R0uwkGibWCroaoQOx2qJtBBLJeNeOFynj
	yPG8I7PD428Fh7yZ8/ItQEwS+F8yvTeN8hz8rdJpILjf7wCrxaXzUcAiWwwT3gE2Cx+TsujKBUl
	YP/udM7fWaolUR1pZW9CXlmi6Z3LuE8G5Ke0SgVVuj9U60r9aE3cNvasTtp0hDjssC45uBFvUEN
	Qj859Forl99ENxAl20BGDeBTdZwT23QeQP6duZQBbZyVO9JmXw/b5A14rSs2ppmMVGv9Rp52oV1
	jro53SF1ythJUEOZ1X/hAEw2csYfGEI0t9l0=
X-Google-Smtp-Source: AGHT+IGZS6pTHqZ5rb7hDVsSbzXKvhMO0G9S2a0CiiBuFqmzrdodLqGIhuUumFEtrki7ydwMiFBtZw==
X-Received: by 2002:a05:6a20:939d:b0:232:4a42:dfd1 with SMTP id adf61e73a8af0-23d701e8b28mr7433231637.36.1753521031959;
        Sat, 26 Jul 2025 02:10:31 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f4ad5a7sm1056088a12.0.2025.07.26.02.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:10:31 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	dave.hansen@linux.intel.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] iomap: move prefaulting out of hot write path
Date: Sat, 26 Jul 2025 17:09:56 +0800
Message-ID: <20250726090955.647131-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Similar to commit 665575cff098 ("filemap: move prefaulting out of hot
write path"), there's no need to do the faultin unconditionally. It is
more reasonable to perform faultin operation only when an exception
occurs.

And copy_folio_from_iter_atomic() short-circuits page fault handle logics
via pagefault_disable(), which prevents deadlock scenarios when both
source and destination buffers reside within the same folio. So it's
safe move prefaulting after copy failed.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fb4519158f3a..7ca3f3b9d57e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -964,21 +964,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
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
 		status = iomap_write_begin(iter, &folio, &offset, &bytes);
 		if (unlikely(status)) {
 			iomap_write_failed(iter->inode, iter->pos, bytes);
@@ -992,6 +977,12 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
+		/*
+		 * copy_folio_from_iter_atomic() short-circuits page fault handle
+		 * logics via pagefault_disable(), to prevent deadlock scenarios
+		 * when both source and destination buffers reside within the same
+		 * folio (mmap, ...).
+		 */
 		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
 		written = iomap_write_end(iter, bytes, copied, folio) ?
 			  copied : 0;
@@ -1030,6 +1021,10 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 				bytes = copied;
 				goto retry;
 			}
+			if (fault_in_iov_iter_readable(i, bytes) == bytes) {
+				status = -EFAULT;
+				break;
+			}
 		} else {
 			total_written += written;
 			iomap_iter_advance(iter, &written);
-- 
2.49.0


