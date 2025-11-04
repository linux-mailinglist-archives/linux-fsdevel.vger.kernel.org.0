Return-Path: <linux-fsdevel+bounces-66993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0EC32F7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E69E18C316D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B06224AE0;
	Tue,  4 Nov 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgoN0nHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B249BD27E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289506; cv=none; b=DHJltOBsPflYm93WNGPrw034HMY2NJ8Zsf3Grjl/awRcqixdFx79w95bllls89FXL3HUNQZWgo2XMhZeoRRtLOQC91fr91NobEXeNAPtDfg+d8VdXPnecehycsej3iEVMTOQslRsX5lhMMi3RfyEA6HmARgDCHC7VVZ3hoO/Yhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289506; c=relaxed/simple;
	bh=1P8q/BVxPopRuJvSHpCrpU/bP9wejEevxDKqxBxuuy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdOyQWonmats2UTDWPY0fJ0VaQmV6slTzG3ovP/ZCI4+fKbNirpUnwbpPyhBolIO7ONZ+7R3DFzsQKA1YRwcBl7fcq0ZifEBwW3ZjS835zWcBVm/9PvQ82bE8ksfjNQvw1Z6ai5sPkd++a0/Hzlq4ySXwkgTFXRYQX1Nd3Synhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgoN0nHE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aad4823079so2580023b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289504; x=1762894304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV8GDhF8HP6tYpYgmWWiwSTLFf7Qm0yWymP5cDfuwus=;
        b=kgoN0nHEfaK/13g5ptHI/vS+34h2zhEycfzTL2O/nu+7li4YXf7hgB7XYUzbhWDafQ
         ghxIDyR7WK4zHv9iyAxm3CX4T1cRTiCvHQOgeD8QiX1TQA5un6iBlsUaKbsSqmtJVPl9
         ienrWLLI2MbFmhD98Sivs9fPxy0ITL3KgCtF68JQ4BF0swKVZdfYUr8qJ+P9e5dRImN+
         db9L8u4QDxkQqWPxXMh41lsakZ4oGaUffp5TC3F20qsFnhWqfVjC4SY+Q7gmFM3tFZT0
         yxH8ipMGZtS5+Bw2ebSOk/d0USHg7YGd4BGVtZMq+wD3ZkwsrM71qhzDJtA/j39bdZ61
         Mxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289504; x=1762894304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV8GDhF8HP6tYpYgmWWiwSTLFf7Qm0yWymP5cDfuwus=;
        b=tUaTF/kmqTzRZGBCtXooHTvM8p2tgRWZ+ww7mO8sGeakXrYXqTHd1GE5VQLL0VbK1h
         moFJlEKfZh1AmxeIC0NNXPQ6wSV/y8KEMn2jU3DuNHW/VeIrkkwL/IzS3GMO4qp9f6dM
         YNbfs1dQcphUA+cIZwRoCTIP4c4LSJOgQ2GQnLUVKwZoH4fZiLYfd3p34MJ0zphEkx6V
         3pzz+Z/x0NJh+jeLXlaEaoB2MueRl9kP5vJLCKtWQ/E5MVly/5JPcUAEb3rkCaa39pGc
         J2C0IW5GlPv3htnnKXN9YbkmA+C9Oz6WpxHKMtHcQkJBz73mhscGkwMWH5Fo8j5c6G5l
         /Q8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmZIXCgM9aCBFvaN3x45IUubPP2Nts/m6fhmoBXf7FGje7PufADltGOa0ea3O+WgqykMFhI0RhWzFe68M4@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgwE0errTQ8s1VQnGvdeaKjOOIgvTs2jsy53ugfW4j+LQqxIi
	MkKKbto9vgSUQcOFDYyD1/JTo6Ofbyv6JEdNx6hTgBIxqOaj5/0sUaKx
X-Gm-Gg: ASbGncu4TGzpCXwNnyr1hrUA6xax8VZcjRtmWnSFpI+UymmrxllXIsmCugnJOn3XJgO
	8kQQODpKO3JjIQqviB1kQg08HhISH3V8F5Ug3kMnZQDlTLKCgcwy3GcFgzhZW7PPG6Z5SnsEn1U
	gRnWl7oHhmbDvH+rKp222+ZQJOWdeJICh4B5V5n8JmdIUw5RUT0zlNl/gERj6408afAzEFHL55B
	HptU4l7/8uqG++nrovNv3maxFVZCIL1zC5vNAqmaNWu3DHvfngc+fNaVyG+dC4bV9VbITsPQo/D
	g9LNRHfAdPKTMj39newHMONq1aqG2AQ0TG2bxTjh5epVkcLKiB2IESk8OxUUjk9pqBQNTepxf0o
	slajdPCOa5GnsX63jvBPjOirA9SzZhxGZ1XZOBP89H3CHumdnBbXrD9SCPlft6XCL27j2JG9VA9
	YNRVKihIg5gn2Z8yrPP3dZR5pvcSQ=
X-Google-Smtp-Source: AGHT+IHQoVrNbvyJSJ1jub+diHAbwmzuI1+icZdC2l35abyXkHMnzswaXPiv7fBfePNCzdBKWq825g==
X-Received: by 2002:aa7:888a:0:b0:7ae:d1d:d500 with SMTP id d2e1a72fcca58-7ae1cb64cadmr799648b3a.4.1762289503837;
        Tue, 04 Nov 2025 12:51:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd39213bbsm3976896b3a.28.2025.11.04.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:43 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 2/8] docs: document iomap writeback's iomap_finish_folio_write() requirement
Date: Tue,  4 Nov 2025 12:51:13 -0800
Message-ID: <20251104205119.1600045-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251104205119.1600045-1-joannelkoong@gmail.com>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
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


