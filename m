Return-Path: <linux-fsdevel+bounces-67982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C2C4F9E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32E9189CFC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 19:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE0329E5B;
	Tue, 11 Nov 2025 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn9SrFXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DD329E5C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889926; cv=none; b=Tins4mZZi6NvWyJwfzvEK7P01MEctcAukvCmadhc+EAevVXBWuTIWjMaD3qk1rjTZC1CesOQNH8ljzPBbxe+pm3OwSaEDFMxBJ8+fBBKN8fdO1CB37PhlKiXNtXgHWrabAAE98dQUkDLRlcAdemdgElh6lSIast519puDycVcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889926; c=relaxed/simple;
	bh=I8mbJun4DlToWz3wCPUi8rv1Ta8b5L/8PZDo5OtIsJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gty82VJW79hI2s6jGapRsTRXM+b69cTRJQEzqoKWoUPDT1nYIsQtsUkVjmzSI/UN0L1dDY9aRmgbR6YJ0yNSyC5u9kl1zsrE6/ptLbrVAcLpfEzrsuwPobMSV30HvbZYQP9RrQeOha7zgBo0+VkwfK/xWCqkyKJ9had0IVUmkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn9SrFXW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340e525487eso69492a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762889924; x=1763494724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJTmhBIa3GpTzi/nG7+PiSRon3GK9cePy4+3xBJOsZQ=;
        b=cn9SrFXWuKCY7Ek/dCbgKVtpZsOy61tXJFYabCul0yNTjmtUO3rCLC7r+LkrGIqjWh
         hetpjyItbtnO6tRfD7cqNDzx/WGPZoAZx8c8alaG+nQ2kOyI6+ZGqrDD+MDPe3wpg2O4
         8r7NaCZduhN81XkxxaHhxE64k6TSBGZCjt6ytAZyib5IgfLm3obtttO7+vViQs9qRFwH
         YWVgETNUPWRQrQly3Wfvpg5GW3+XI1IDydll1TPU9N0VTD8acYM1t0tjFdmY5jPCvfJQ
         X7D6HaWo+DoNJgiCQ36kjaIEWcw1uU4o03kWvJ8dWzFC7WNFFK8gJ2/JDFQTWPS8NTJI
         c3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762889924; x=1763494724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJTmhBIa3GpTzi/nG7+PiSRon3GK9cePy4+3xBJOsZQ=;
        b=Mic6Msr31JVtyexdOaKXWoWPd9zpCRxcvbg+hPDi02lQAyYX+Lqiup0xttNA6M/RlR
         uqXFJrQUyJYRtyvP6VIhjp1lbqsJvsNmZLRMR1oyeSjMN+acH+jIIyB2XV2USMINDQg/
         SYsis2J1cnIjzvx5rEfs3YW53CP9jxRT3gEeSUQJ+u1jR15OhLVpDK/sAD+rbm+yNKJo
         RmsZ9BVsBHGWK7F2VPcCOVGGlfGrMSCIbndCMdb6fay4+DooMXl6WBHk04hxmitrg7g8
         ZGlDI31gaRDyY9TuHGmTYGsEgohnIRntiTzYFgzaByDbzkUzFL1imEflZ2nI+VA/LVIC
         V5pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKLoyAwGC0fSUubQccQwttP7+7RnZus4BDSfrlenn0I1DZcNQS5XY2+E2nPRkebYkFXDg10ORpcqaQr8ZP@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6cVx84uP1zRepLRg2ddOBFNIWBkZYpaBQSeom9kudp7s1+LM
	xjME8t7wYaTvCPaLF9tWoghOHl2V/qnsAf1pp4v1iajce0hmpWHvDQI/r+mCwQ==
X-Gm-Gg: ASbGncvazgUNrh6HVRr8L/2/S+hyEZ+qxEbY/pMT6UsEaK7ynM4T9LKIkRQuxjZso6T
	JTMkiaP0vpUBCYu8r84KwlIFZntDsGaxwzxT5VJcpEFHPm0x2JedOQP67dbUiqCldPQ5y++VGvi
	5oY67PPl20YskAxrPW7PmtwQaFHm0S1hVTZSHUnUGfUVn8No3xopBKwKxFbK1mwRKiO2XqtA32B
	h6k+sC1RNjeh1kwNl3dMGzABxSyCyAMStGC8pJLPM22Nl4xHWErt3ZPn29NHgW5xLAgwK6e2aXr
	NY3+Um/3t9qXLMXecGW+slpSwdT4Cy6m/2lKOxoFWLIAEnwOeviAe9t21tzJ5LYkFTZmDPbQtnY
	DmxAIQEDi8IxnzMx2aD1QDKYbaIiWzQcay7dN01HGE3CRcAjtyVLAaerv7HDVwJYurclZgfI8zH
	/3+g9xjkRGDiA/rfoO7oEqb6Q=
X-Google-Smtp-Source: AGHT+IERv0424Jb4W4R26zOvffFFNOXDGVnvxNOsdKF5SGhht/8dp+48TEoExF1PVe+Llxq8ICjqNw==
X-Received: by 2002:a17:90b:4f45:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-343dde816f8mr654959a91.17.1762889924188;
        Tue, 11 Nov 2025 11:38:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm22011369a91.4.2025.11.11.11.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:38:43 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/9] docs: document iomap writeback's iomap_finish_folio_write() requirement
Date: Tue, 11 Nov 2025 11:36:52 -0800
Message-ID: <20251111193658.3495942-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111193658.3495942-1-joannelkoong@gmail.com>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that iomap_finish_folio_write() must be called after writeback
on the range completes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/iomap/operations.rst | 3 +++
 include/linux/iomap.h                          | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index c88205132039..4d30723be7fa 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -361,6 +361,9 @@ The fields are as follows:
     delalloc reservations to avoid having delalloc reservations for
     clean pagecache.
     This function must be supplied by the filesystem.
+    If this succeeds, iomap_finish_folio_write() must be called once writeback
+    completes for the range, regardless of whether the writeback succeeded or
+    failed.
 
   - ``writeback_submit``: Submit the previous built writeback context.
     Block based file systems should use the iomap_ioend_writeback_submit
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b1ac08c7474..a5032e456079 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -435,6 +435,10 @@ struct iomap_writeback_ops {
 	 * An existing mapping from a previous call to this method can be reused
 	 * by the file system if it is still valid.
 	 *
+	 * If this succeeds, iomap_finish_folio_write() must be called once
+	 * writeback completes for the range, regardless of whether the
+	 * writeback succeeded or failed.
+	 *
 	 * Returns the number of bytes processed or a negative errno.
 	 */
 	ssize_t (*writeback_range)(struct iomap_writepage_ctx *wpc,
-- 
2.47.3


