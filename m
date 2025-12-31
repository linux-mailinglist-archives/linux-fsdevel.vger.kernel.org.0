Return-Path: <linux-fsdevel+bounces-72295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D982CEC2EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 16:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E483013977
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10326B764;
	Wed, 31 Dec 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCLwwizE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AC1DFD8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767195539; cv=none; b=Y9XLscKRBwIEUPRWWNl+uArsV+isKZNrBwtUnztxYvGoYbJuV0NllXeCRCJnOeVAgC7Dqs8pQx4xVrjxw/1S3Tg86BGnBo484nFqjb035qHpicAdaA4ARGgofaqM86kv49fdzhdz4rcR7GmyjXisc7sj2FSXJpsbD+l1N+0Qlzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767195539; c=relaxed/simple;
	bh=43UgmKUKlAPjZ/gPyh/0MaG1C7NAJcZi75DUup0/M68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf5zVfIgS174setbNfS0/K8aZ4M/R20m+b9u5E06oEWShjx0yaBgneFJwOC+f6P2DBM2zR7dVpIG4raV7McTh/xVY5yjYH3An73o3C1UTM54w8VWPbIpLgOVCmx7w49BjR5OArcrEDo6uP4eHlOBWFtQI40iSOCcon5e6ENgqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCLwwizE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d0788adaso98274415ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767195538; x=1767800338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlZrdO/Vxycwwnf1zdplwB4vLmWzt9gW5Zk9L4ZO+ec=;
        b=CCLwwizEG0gXmFeD6j44KEBxUt0yz7vmQlwiGUX5ng6qPHdsJfkVW7J6Dj1fvjigl5
         uQxhWjXt2rXcWU1QoGmX4O5Nm/h05AvkcIZfTIIlr2vUAp38qBO5WvsMU3ElZ7yt8Pk5
         D9PJ1By/TdU6k3XZof1VaM430jRCmxQTuPtcxGqucGzN0ID2Vu2KAkaaKrwmUkO3YKgD
         2wxhGPegz7OmM+vP7tU+pUXCy55GR1bs0h4HCVgyVT5zIov2vZJCMEVpitnU0sJoPhdS
         yVrVM/yKStPxnxjpyUd5hwFektojNtwc4VfZF3oIiT7gdUMwRyoDjRk1w/5I+m4udYJ2
         AYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767195538; x=1767800338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlZrdO/Vxycwwnf1zdplwB4vLmWzt9gW5Zk9L4ZO+ec=;
        b=mv+v9Mfux8Ip4PdZuTEttd9Je4RuPm3NO5LSjuBv02y2/br1oGQHWwlVpJ0Xysxdrd
         3b2ihC1bbSR3kGO+PaA156a0Ic357estqox4pFSUV9WekZ54OQM8HQAPsgZqQkS4Gi0Y
         I9bUYNNL4WytJgdKqyxOVuUbF7GbOmqATSgwg2H/ubHDfWazL/qxFUr5WXfCcEpKXVfb
         fU4QK3PVvlTsSCQh0g+MZBAQ0gmefZagVyTp6HSEEIIpsyMudE6TD6OhrN+vNh324c/B
         uL4lF0uoLg2vzB1iN4irBaposIR6pmsztdb+dQExQym11rrbx9OfLSn8jnVkl7Ak2868
         li4w==
X-Forwarded-Encrypted: i=1; AJvYcCVrVZoFo0LRdtT+2ad4pvXhvUY1uaR+XFjqRE83Bhs/Q6/Mfqkp9dxr7Av8AXDu2kqnk48tb7wscuZ13a8J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+g6+VRdSo6UW7H+u+LTgwcslAeh5bQbi7KdbGL3ZnfKE6lX7/
	wK2q/cLY4I6qmjRu9R7yA9+JMosl36cFAQIvYnAAjtCVImqtqjZLXGYy
X-Gm-Gg: AY/fxX4u9DC06SlNHQt6S3VEvNuT8UtsN0gKxzM05hopw7q6MWg4b9dAa0Unck9t4rW
	2uVCmj/YO70vYnLbh9KtcaEegWGcs3kfAMrPFNnEvB8i2vTaPeWNiit56CMuDFd6K5N5cnBokaQ
	01UW55laTJpPK+ia7YfEza8rS3CDs5/ykKGrnWncVm4A+leogLj2Pkfm5lRP7VcMVDZ/hvoOaAd
	W40zHlZyYLBqYvEj+o/Syxzckth1uOt7wlwti8KkXKhfXl41L86BW1FX1enqejeTEgmQGRMxloO
	q4QPVYk79cSNzj9/es9veTnGH6lzZjANZUO4y4SnaD+uKyQX1Y1kTB2ggg+0d7Ouk2O73NNiRex
	kXnJIQfEZJVCH0V9PAb8S81ZC1PR1OUVMn/S81yKpfGvOzU130a0TETXZJDM7fkxAqAl0uHakw9
	f01rPMalQwJOTJhUNJQ5jnD1GxdtrtzJJxGq4ZyPaKn1xbvAR3y7GXfvvR/fJOOlAG3eZweSEvz
	bxrpepmoq0=
X-Google-Smtp-Source: AGHT+IEiVfyhWCyhkgiJZ6nHYWgX91kYMxuPxlDykSRDAMl0x6Wb3ujZQFNoe5fO5xkoJZL9pubP6A==
X-Received: by 2002:a17:902:d50b:b0:2a0:f47c:cfc with SMTP id d9443c01a7336-2a2f283685amr354551265ad.34.1767195537693;
        Wed, 31 Dec 2025 07:38:57 -0800 (PST)
Received: from kforge-fedora.gk.pfsense.com (static-103-70-166-143.unpl.net. [103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm30884375a12.28.2025.12.31.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 07:38:57 -0800 (PST)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/vfs: Fix htmldocs build warning and error
Date: Wed, 31 Dec 2025 21:08:49 +0530
Message-ID: <20251231153851.7523-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running "make htmldocs" generates the following build warning and error
in fs/namei.c:

Documentation/filesystems/api-summary:56: ./fs/namei.c:4952: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/filesystems/api-summary:56: ./fs/namei.c:4942: ERROR: Unknown target name: "o". [docutils]

The error happens due to 'O_' being treated as a named reference by
docutils and the warning happens due to '*' in 'struct file *' being
treated as beginning of emphasis text.

Replace 'O_' with 'O_*' to avoid being treated as a named reference and
reword the return comment to fix the build warning and error.

Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index aefb21bc0944..852fd007187f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4939,7 +4939,7 @@ EXPORT_SYMBOL(start_creating_user_path);
 /**
  * dentry_create - Create and open a file
  * @path: path to create
- * @flags: O_ flags
+ * @flags: O_* flags
  * @mode: mode bits for new file
  * @cred: credentials to use
  *
@@ -4950,7 +4950,7 @@ EXPORT_SYMBOL(start_creating_user_path);
  * the new file is to be created. The parent directory and the
  * negative dentry must reside on the same filesystem instance.
  *
- * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * On success, returns a pointer to struct file. Otherwise a ERR_PTR
  * is returned.
  */
 struct file *dentry_create(struct path *path, int flags, umode_t mode,
-- 
2.51.0


