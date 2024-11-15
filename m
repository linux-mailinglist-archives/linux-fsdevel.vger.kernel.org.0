Return-Path: <linux-fsdevel+bounces-34934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A79CF019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C801F264B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ADE1E2826;
	Fri, 15 Nov 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uKQ/P9Pu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85441E260C
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684694; cv=none; b=OYn7XPz5Rgor3RvXu20wDNNzMuOhd5GjPviAX2gzv+gLe/jZwjH6NhaTYi6OXffcSZi0uCnS8U/FueUYJP9jRjBnD2XIgp5CnNXj5hEYqSrHf360elKb1s8IJHtuP/IHfcMnyOn8P92+yExulSHM1lUx7YhV/41Bmpcu1yfey8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684694; c=relaxed/simple;
	bh=6M2usmJQkSj6QxVwbWiMg28e+rwVNQY/NgVhiKLrG4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FioqhaoFNmbohXHV2z/rutYluIH2DtqZIO0zm8unNzmzSX0Us7QRmvVFkOWFdW6KhMRce2EodKVTyYKWpCzLa2AFlsm2TGFRwXHTT//QKF1Y5H9oCp0po8AIopyoTZCGrpVlfZ+KAxnY6GLbuX9uT6vM9uBMgt7U6KZHDQ7DsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uKQ/P9Pu; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e38193093a7so1569182276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684692; x=1732289492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU0dZL52CuS55HBpnlFc9Ffg6kvih/VgFXFf1fJzIbE=;
        b=uKQ/P9PuFqn2v7/y0fPda/iahcVOvKuurxOPKOGMxz9eSY4nXNQDVsnvDGU2Ec8mjZ
         v89OE1RLsZdFLxGDqwUJktUi8JyMhBAkBylNKxz/f250qEWPWI31Yap7XI9JWr5W28Nn
         A+lur0VaWwtsm+zcVfUrp7E8nIwdQK9/g/9M1d3v+XDOB4oHPKT3BFokosAtiAj5ZvWr
         SbSYUgLs8vEpzWW1WUbOqwOfC1zktamhOQuDGWodGqjORQmXMoxvtDoSID4YA9fKlEwW
         XUAT9ZuW5tqUDv6tzOGdWM9A6S2AmccWeMvZczUHR1fWVk++64ofO1Id/eIiMg2BHMEK
         TC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684692; x=1732289492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU0dZL52CuS55HBpnlFc9Ffg6kvih/VgFXFf1fJzIbE=;
        b=iBKogP5HpvxGkGp2EJpgZKAZ7Ohz3E7DG/lQsIcmpyD2jT/P+YgfE2YCQN/t7jYVw+
         gFBygHMuzTnfL4XPJgaKKJvWr0Ua4sOx4o/Djh88Y5JGuv4HjY1ENpblpgbRCkZsT3J3
         40CKiufg6Kq6xt1hWLff77B7/et0Q0pi3Vs9EM/1Ut5iamD3ZHjGnRwGaYb4HOvt7cuh
         cGER+0xmBufXukxJzgCYYWsBuGgfPBdthClFs+mBgdXfNb6DVaQF8MLIxcPQWl1q3qjR
         oPqmP8V9B3fskxl04lkMTl3NzNqB/ZyicB135xJlOsc5cqZssJusFVwIw9Cf1CXKlt3m
         f4ag==
X-Forwarded-Encrypted: i=1; AJvYcCU7bEVUnPI8n4pxNH5FZtHapPv3YjoJ+99cpRue8wJUprZ7ixA4ujyF6spIbu+m0yPvqQcKKckq/zV139QG@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtgVyJme61ZRJR5w1dlT0CD8IGWQ4zTDKqokQF+iohZ6gp3vT
	iOuwH4gQp3XBPOSpH9B6gqvYchrm32B4iGJV9eEOAmOUSNThEAxvpHhvHRNvHOc=
X-Google-Smtp-Source: AGHT+IGL1oUEZJ3rWhtkHzcHN//l4Kwa6WIU+uMQ5VnS4NxAxx6XDhapJjpe9N68qs8G4gEKoRwuyw==
X-Received: by 2002:a05:6902:1825:b0:e28:fa51:634a with SMTP id 3f1490d57ef6-e382615f44fmr2204741276.31.1731684691641;
        Fri, 15 Nov 2024 07:31:31 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152caccdsm1011626276.14.2024.11.15.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 06/19] fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
Date: Fri, 15 Nov 2024 10:30:19 -0500
Message-ID: <632d9f80428e2e7a6b6a8ccc2925d87c92bbb518.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Avoid reusing it, because we would like to reserve it for future
FAN_PATH_MODIFY pre-content event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify_backend.h | 1 +
 include/uapi/linux/fanotify.h    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 99d81c3c11d7..2dc30cf637aa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -55,6 +55,7 @@
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
+/* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 /*
  * Set on inode mark that cares about things that happen to its children.
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..79072b6894f2 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,6 +25,7 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.43.0


