Return-Path: <linux-fsdevel+bounces-69267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B0C76213
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D39E54E193F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90336D506;
	Thu, 20 Nov 2025 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/R3ReHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E6303A22
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763668336; cv=none; b=RpOL82p29BUsclCV1UbI4o2vly296qqmsQuzPudYzUCq+GIRIeqr+rdP6+yXALdhGeABO2gbY7wtEhBWoPKoyNSDiUqxfIBCLfkDnjsMZUVBkr4J6h/kWZkAUuSNu0AXzBzarnHNsqey3004CtOfwVH/PFESzuJo2tqaBppYosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763668336; c=relaxed/simple;
	bh=u2+T1r+sWsvkftBxAcy6kHz++p4wMgmzB+K5Zky2h7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcgLpEkz4Onw0fJAJZysZdhv4eN2yBw6buV1mGAnU9wU8/ZMmMcq1hJpVvp6M6vQhivZKiHVehv+OPWq/wRcJM6sTcJGZq4dcEiLDQijdMcksVGZBEpnccqJu69xIeN/x2Hk+8BLn1qxYRBACEdnApXY1zAqfGlYuDemVK2Z+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/R3ReHN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b9d8122fdso9978801fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763668333; x=1764273133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Er2FJbbUBh6YnvwnjR3JbLaZQz/HmWBPLBBSx8YXc30=;
        b=O/R3ReHNg9yfPZePautjRzF19+lEy9Hf2j4Kpj7ri0B9WyAH7mSEGa4DT+6pBdcp7R
         jO4xtupiuCkKRKNs1tu1iaxLGriOYp+Ur+/CRimjHwICAPVMBXYa0cLkzEikFUpnxMIh
         hyrVAaIsgiCdQrviBEwnZespK4Nsm+e6TCoCxp0yue4MySR4PUOtrg22WH3yD1y8zQW6
         COEUlp5WsXCdJEDeAqhCDWgUjRBYMpQ2Pt0a866y+FzVq+GgcXoGvqAgzlLUT4MnktKj
         KxDRYolCqClZ4YGlY5B47UfY7bM/iRaLdHtWXPz3tDtYlNKvcYQL7Hhawl2tiOZzccUH
         OzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763668333; x=1764273133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er2FJbbUBh6YnvwnjR3JbLaZQz/HmWBPLBBSx8YXc30=;
        b=hYDz1rs/0SqHJXlPITTQTjA/ZbN9dQbTTp3W/aKEHYA62mKKlUnvbeL0Ae77eXw/0/
         +xOdsbaPyIsObm4TOA5sVHpX+8Qu5yFhKzOupnG7PGebExVkjHCUYjPvi4797RoGureZ
         33hwXOXsk/biZaB4VJ4X5MUqDgtUp7LpHYACkxTM7hoBJmvUMGrVYL1L1cEyE+m6zMj0
         p2W+eN9hjX0dq7usie7EEDDKGul+RoRbMqTwXqIwGZKscYfNs+EvV8vAJjYdbmJw7zre
         P5/f++osKk4JjeHmEkbKELK/ZsmNvYQObNpZsh+7biaSnove7v8+f8hH2LVwvflrVmY/
         Efyg==
X-Forwarded-Encrypted: i=1; AJvYcCWLl3qZJFILxXwAiloxyFNzGvX2Xuge7VF5wclOUfgIaxyycVQCRlWBkOGgqBW45EZZDstKHp2K1Ko9X/O6@vger.kernel.org
X-Gm-Message-State: AOJu0YyzmwdvhIMw5Mj+dNE7JGPkNrNLmdqMSHlrVguoUFlZjJdUQdbF
	bbgayqCoXRl6GUkHNjI8/tlkzXiBjbaidmyuNl+Ke/A1Bz0awIM6caCv
X-Gm-Gg: ASbGncvE+ukU2gj9KqLNd7ExH1pPWxLjYhBnEMhu076jS1U4ccLXGeNrAqBMw9PG9J6
	dyzH8uXNVudyk4a0ap9fGey1nKThgOZkm1NSKF6ibTMnUp3mjtsVmFe5O7WwOz/C9xVjA5qklzh
	TAnXQf7etSPniRhbXw8gF+VYbX+bAK3LzJoMkLx9duo3uFDgie5Vo0vHGpT8bqWXogHJgXNUrrv
	HO/JmzPstdXExtjgsmKX0ZQqyAx7blaUjcf3C9ZmY+/tUa+x1i9jCg9ewmAkj6vMiq7ueqxkGKw
	5rPbtcE310276ETKJ6qaznrOqfkvqG3IDD9VoJqy+9IcNhQ1O0+XTW7WT8OpEFMZZJguD8DO9E/
	fHs7HLK+AdT+DLO2of2hfk+jdygq80sVe+LdI8mm9OvTVij0FS5Mfm6w+hT0Q9mShwwuxoOAwja
	pSrYCty3Fq
X-Google-Smtp-Source: AGHT+IGO95a2DriC/sUFBPYgQuutgp8Cgi9UCTrUgdhkhO22s+KUmGoBKxdV94i/DlK6/m1jFIzlDQ==
X-Received: by 2002:a2e:7205:0:b0:37a:4714:ff39 with SMTP id 38308e7fff4ca-37ccecd68aemr7615261fa.23.1763668332347;
        Thu, 20 Nov 2025 11:52:12 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37cc6b4b47fsm6967301fa.2.2025.11.20.11.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 11:52:11 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: patches@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] include/linux/fs.h: trivial fix: regualr -> regular
Date: Thu, 20 Nov 2025 19:51:40 +0000
Message-ID: <20251120195140.571608-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial fix.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd3b57cfa..247e37090 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3103,7 +3103,7 @@ static inline bool inode_wrong_type(const struct inode *inode, umode_t mode)
  * file_start_write - get write access to a superblock for regular file io
  * @file: the file we want to write to
  *
- * This is a variant of sb_start_write() which is a noop on non-regualr file.
+ * This is a variant of sb_start_write() which is a noop on non-regular file.
  * Should be matched with a call to file_end_write().
  */
 static inline void file_start_write(struct file *file)

base-commit: fd95357fd8c6778ac7dea6c57a19b8b182b6e91f
-- 
2.47.3


