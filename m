Return-Path: <linux-fsdevel+bounces-26028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D41952B34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA0F281B1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DBE1C7B77;
	Thu, 15 Aug 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI2rqNL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95C19ADAC;
	Thu, 15 Aug 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710803; cv=none; b=HKqEbarCD/76l2fT84kh+s5c5+9QsaibG510l+ybAhHshgE0Ro3oe9hXS/Q81U7rG6Nn3cl4FOHYoe63ykTQ1L5+NozUAh1XgKcrvSXC5RFebud/C7lFXIfixO1YfL9NHBFhHwjzx5Fgbf8wdV0tkRzVq2ZfFgnwE1ldOAUVNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710803; c=relaxed/simple;
	bh=GMzzota/QZ0aheGCs5gsIslxm2Am5d0pOVDpyY8JbVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZBLC1X3avZ/EzHhD5DpArCYigzoCh6umcKI5xD3bz/hVtbnquiZvtUuHDBBwqnq8TZyZavsXRB6DbrJP5+9GCh7b3LOyZg4t+OmyGxjJlfRv4Wc5OIhObotfbzvIgSS1vaF4IAOfzgNw/2ApDWXybb6GMh1ejRq6cFNN+ojoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI2rqNL6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso4224815e9.1;
        Thu, 15 Aug 2024 01:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723710800; x=1724315600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOUgcV0PdB7WRC4oxjKNSTuSQWbV/DMgAxLwybn5b9M=;
        b=RI2rqNL68AmwHu3jkEh35n41Esm9ixwKZhW/Zp5vIshJVrYFS0VroWqUBilp+v1o22
         1iE40cmKDH1yNzaUPCwwD/8DzyG9lXuSr9q0VuOxF2YAwMljAeR7uAH50RzGU/g8vrAf
         LmOwby8J0l0lvGVkLotf6fDvdflMutQ2V+anhKIG415LHPZu3XOKgTPJvx6/67iBQINO
         rIWKoRBB+EuQVenE6o/Llr61n9Hk/wG/w1JyK+cOmDwxryCQOgJ7a79XdiWa8UGLVOPo
         RZw6zH4BtI6yBpidxtTW/yj0/g1KYGEmHZ8q58oLeer8Nho8+65Ihg8RA0y5mfjq6cmj
         FG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723710800; x=1724315600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOUgcV0PdB7WRC4oxjKNSTuSQWbV/DMgAxLwybn5b9M=;
        b=Q4S0cpAaQ/jkBdn7wQ6k6EvOZkYE98mVcuKwAWbhBatt81NclN9mMLMtY+EKFtqBWO
         clACaqsqR+yxTnfv1YvKCOnPcrhLSm037CDns0ulYXb9b5oyGxei95HNigD66/pXcBZ/
         wRYFy88UePxdtd/p0HR4PNSBVARP3HxDFx/wwcAtgn9lZSwxAuynVZWYMNWcItMXqbbD
         6lLq/ni7qajvVRN0CkzvGiEw12mWoVCoQL5nCRXDUL7gpPFfvuQpSaLEbTSDYVqY/N+8
         Kg/qgv+jTHKktUvg4HXG1mrlB4aNPYE6W9UYM4FLD21ZgV0aP+NhXiby+KOPZE7M/plZ
         k6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU3AQvKM1NaWJQsYYgWGaaw9MCAhsYYf83x0TF9WifsRAawSDufGZhiZ2uuHN0Xc78Q26WkGoEtNvAakNxKgtS6ZcWJ6e/YJZXvjPCCOcJzHk75kblkLDGfq4W3tDNkaPpLBfhfb1kdIYHh7w==
X-Gm-Message-State: AOJu0YyrCc2EwL/m3Biskiq0vPZdzLwMvqaaJYQxws+9BFcSKjUB7JZH
	a9w8n7GccQhlJKPI2tBR5d/TsVglJxRR27Q1JE2Y8ptGvoXYnrLz
X-Google-Smtp-Source: AGHT+IHQzn/DXetZMa7WOlQ//oiqNh7mgiStObblGepgQWWz58K6W1c+r0bHJt/+boiDUWeMcKHv/w==
X-Received: by 2002:a05:600c:5246:b0:428:f79:1836 with SMTP id 5b1f17b1804b1-429dd25fb5emr37201705e9.26.1723710799904;
        Thu, 15 Aug 2024 01:33:19 -0700 (PDT)
Received: from f.. (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7c03b71sm12567475e9.14.2024.08.15.01.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 01:33:19 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: elide smp_mb in iversion handling in the common case
Date: Thu, 15 Aug 2024 10:33:10 +0200
Message-ID: <20240815083310.3865-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to bpftrace on these routines most calls result in cmpxchg,
which already provides the same guarantee.

In inode_maybe_inc_iversion elision is possible because even if the
wrong value was read due to now missing smp_mb fence, the issue is going
to correct itself after cmpxchg. If it appears cmpxchg wont be issued,
the fence + reload are there bringing back previous behavior.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

chances are this entire barrier guarantee is of no significance, but i'm
not signing up to review it

I verified the force flag is not *always* set (but it is set in the most common case).

 fs/libfs.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8aa34870449f..61ae4811270a 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1990,13 +1990,19 @@ bool inode_maybe_inc_iversion(struct inode *inode, bool force)
 	 * information, but the legacy inode_inc_iversion code used a spinlock
 	 * to serialize increments.
 	 *
-	 * Here, we add full memory barriers to ensure that any de-facto
-	 * ordering with other info is preserved.
+	 * We add a full memory barrier to ensure that any de facto ordering
+	 * with other state is preserved (either implicitly coming from cmpxchg
+	 * or explicitly from smp_mb if we don't know upfront if we will execute
+	 * the former).
 	 *
-	 * This barrier pairs with the barrier in inode_query_iversion()
+	 * These barriers pair with inode_query_iversion().
 	 */
-	smp_mb();
 	cur = inode_peek_iversion_raw(inode);
+	if (!force && !(cur & I_VERSION_QUERIED)) {
+		smp_mb();
+		cur = inode_peek_iversion_raw(inode);
+	}
+
 	do {
 		/* If flag is clear then we needn't do anything */
 		if (!force && !(cur & I_VERSION_QUERIED))
@@ -2025,20 +2031,22 @@ EXPORT_SYMBOL(inode_maybe_inc_iversion);
 u64 inode_query_iversion(struct inode *inode)
 {
 	u64 cur, new;
+	bool fenced = false;
 
+	/*
+	 * Memory barriers (implicit in cmpxchg, explicit in smp_mb) pair with
+	 * inode_maybe_inc_iversion(), see that routine for more details.
+	 */
 	cur = inode_peek_iversion_raw(inode);
 	do {
 		/* If flag is already set, then no need to swap */
 		if (cur & I_VERSION_QUERIED) {
-			/*
-			 * This barrier (and the implicit barrier in the
-			 * cmpxchg below) pairs with the barrier in
-			 * inode_maybe_inc_iversion().
-			 */
-			smp_mb();
+			if (!fenced)
+				smp_mb();
 			break;
 		}
 
+		fenced = true;
 		new = cur | I_VERSION_QUERIED;
 	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
 	return cur >> I_VERSION_QUERIED_SHIFT;
-- 
2.43.0


