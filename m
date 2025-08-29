Return-Path: <linux-fsdevel+bounces-59692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4439FB3C5E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6313F1C88415
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BBA3148A7;
	Fri, 29 Aug 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOcEq9/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E235E4D4;
	Fri, 29 Aug 2025 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511914; cv=none; b=gf0t7rqSRKvoXK+6VyWRs4x9pMNuxs41iKK1kcNbwY9aZOLBE7yvRU7qF+xup7ivOTeZ6JmPv56FFMKZHe1HK42Va0hTck03s7aPXbxMrpy8NtFJ2Bg1X0YmOhPY5tQQmwVOwrcHwzHBIx51CZzvmdjsutvueA0yi5otTx02BOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511914; c=relaxed/simple;
	bh=8QEPPQi3CuhI+mo6TC40kG0qgLV0X4ohjo6GmPnqj9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYN4H9cTqC6cqo7OvC4TVWeTkQvi24Vps9MQnCZ+iTDrmvubfwrspYxNq5mLkOszsBCisnZTRMbXUSpVmpBRrLw36WwgLWp5gHFsGgGcxu1vbrl7SthPN6ncBzY9Aebp7lBFGue7+nDNoPPIShgXbPpvsRMsnO/JdO+geeHn6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOcEq9/R; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244582738b5so24087705ad.3;
        Fri, 29 Aug 2025 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511912; x=1757116712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5mI3LeFpilqPhvH8z3toCS5f7NTRhmNT5gQmu8tEhU=;
        b=gOcEq9/ReogsHP6MsIg9xAXbBZgPtAO2OJUNYd/jbB1pluDpuMiS8Qg1voHPog11VO
         LzWK+wb9iB6N+o1RitNF793+h33Cb8ZWIu5KtDgU41axar5x2Rro1veIYlFVOeeWvs0Y
         /yfQDkDZbMheYKxHgf4vSsBIZu4sKII6Y66eQKbWForHCKEK1R5xXyLFEaTLJ0FJgAn5
         Y3cKL5Tei2vGNu7gGuK8uGEoTVOySlZNvxVutqUKb+Hio6fP+nbkqghmalmwui7xC2Ds
         P6mUz0hdsiuR4iaitUEm3Ag1AnkaZVt0OJI8TAI+iYakmVC+Fz3S53l7Ocr2s5zkP0AV
         FwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511912; x=1757116712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5mI3LeFpilqPhvH8z3toCS5f7NTRhmNT5gQmu8tEhU=;
        b=NBoKeoknjkKZqf8Ew31grqVzkQG+y4MQ1LYuMJDGVMrXzAa/BANSmhihlYl/9bILRM
         jelxXzO//FshnWuteYiCBRmevvQ1WrUNIwFVwjNvv9SycUBaLAN51wiEaNxOWpaLD8fw
         m4HcibGcykz/Q+tUWNznwuQaYPggau24ZDzvLLqDp1xYtBEb4rqhc3qoa0j4+nGqDRwz
         wI4u1qTrZnE/TPrywWeERfbF9MgouBVRxK4Gb5TXSVG8PBzQpCTn5V6hLYSOY2ODQ4Oi
         p9CKifBVXS+WEbgIcI3IQgBQeVkxS0qxB7GyiBykewm3gIfvAt3jVppR7HFIJp4unUS1
         7S+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5CMSN3PrM3HUypQ0e7I663DHXn1WXKY9l9/cDkpi2vGvqL7os7a6aSnrRmmiKqSnpJaPhTA0cFbcU@vger.kernel.org, AJvYcCWXPEpu4qYiDDPWvJrHM0irklD3A/XWVQ9C9rIZ7yokKzZguBdahixQkdTWDCwPyNcVLhm62BUUfSLevbCoKQ==@vger.kernel.org, AJvYcCX8BMg9lwk+Tdy+vFmw1GGnVN2sI2WdosrJtKj+5Vu9Buvw9y/RWlle7F9RFyYAb+Hbo3W5RAdKbws=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywas5N0Dm6k9fKTcpdKkD8YwvWJrQUtzeZAPrGr0xwz+c4vTmuO
	EewRfyQvIdPxs/5FS4efexOtjkeJcQlZhcN0htL+5w5aEKIFRaBTSLgS
X-Gm-Gg: ASbGncsM9oyogcm5/DBnTEROxUUPLc1aq5Jy4XMonzN6sifonwDPZyvUNlZXvAgCSel
	Rbbv8T3jI8VKJRqcNoYM4tfXdmYs4CKEXdivgBd0ByDyCcV+yvuS4qvUPP6+EVx0gaItGTmdYGc
	o3h6eFb2tMGltnDBSh7S0bKy15XV8HFHy28x/rub8Gl4c2sUUBaDnnIp6VXQ/giKxVie/k0A6fh
	jDIjHe+s1+2jXsUx/XRlQG7iDMQ6inRaMl0f0g7VUDvFHYafaiJlTYt5r1mi9RYyk9EDCjN6I6J
	aK9j44SlBqAq1V8V8pUfl495wWLQPHketaTR8ua8j8g7oJZ2AXruDfl2gtT3v1sNO3ayqmgDSyr
	XjyhVoepHaC2C2kiNVVows1gd0Mrq
X-Google-Smtp-Source: AGHT+IGjPv8K/3sxgDEoy76AXRFbPVEeTIhcONJy9sys6E1BM6cRFN4zjfwMe0gvo4+zJex75zeaGg==
X-Received: by 2002:a17:903:40ce:b0:245:f818:70c1 with SMTP id d9443c01a7336-24944b22139mr4827445ad.57.1756511912101;
        Fri, 29 Aug 2025 16:58:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065ab343sm36148295ad.126.2025.08.29.16.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:31 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 11/16] iomap: make start folio read and finish folio read public APIs
Date: Fri, 29 Aug 2025 16:56:22 -0700
Message-ID: <20250829235627.4053234-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make iomap_start_folio_read() and iomap_finish_folio_read() publicly
accessible. These need to be accessible in order to support
user-provided read folio callbacks for read/readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 10 ++++++----
 include/linux/iomap.h  |  3 +++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6a9f9a9e591f..5d153c6b16b6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -323,8 +323,7 @@ struct iomap_readfolio_ctx {
 	struct readahead_control *rac;
 };
 
-#ifdef CONFIG_BLOCK
-static void iomap_start_folio_read(struct folio *folio, size_t len)
+void iomap_start_folio_read(struct folio *folio, size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
 
@@ -334,9 +333,10 @@ static void iomap_start_folio_read(struct folio *folio, size_t len)
 		spin_unlock_irq(&ifs->state_lock);
 	}
 }
+EXPORT_SYMBOL_GPL(iomap_start_folio_read);
 
-static void iomap_finish_folio_read(struct folio *folio, size_t off,
-		size_t len, int error)
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	bool uptodate = !error;
@@ -356,7 +356,9 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
+EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
 
+#ifdef CONFIG_BLOCK
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73dceabc21c8..0938c4a57f4c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -467,6 +467,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		loff_t pos, loff_t end_pos, unsigned int dirty_len);
 int iomap_ioend_writeback_submit(struct iomap_writepage_ctx *wpc, int error);
 
+void iomap_start_folio_read(struct folio *folio, size_t len);
+void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
+		int error);
 void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
-- 
2.47.3


