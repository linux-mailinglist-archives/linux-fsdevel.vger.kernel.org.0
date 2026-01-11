Return-Path: <linux-fsdevel+bounces-73170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB01D0F1A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE66303FE11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C458346E4F;
	Sun, 11 Jan 2026 14:22:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BAE346AD6
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141370; cv=none; b=LZjuWYkcIIjZt4ZdpORE/hvkptOzaOjhx8K/f/nK/Wk6Zk7idQSn6ULWyCNqqbEU67CzToZsrBXtXiTOUHFCHpWf+RE7kP8nWwrZ6IVmqBOgbKoNTVGMJcPwNxpnTLPXRsBLhc/+XTRipOfYWHKXnFDXrj6XK/GAOHtll0jHMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141370; c=relaxed/simple;
	bh=+3FyJvGafpuzxgntBx1JI0lkeUDVazWqSzDKuvlH3S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJvmxA1B82DQgX0g6G9hUXPyQuMzmymoHuFhYnPueU1vMKY/fJBw5dTAM1hoKF0B+HPQL/NsVwh7OZIxw5mdvx9nWTpSIguqUTJiaKMXJsT8UqwYRpOTVeBRD/uMU04uVaBQI/UZG++o2yyq3tMX6vDGh1RMivAhlCKcZVOCjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so195479b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 06:22:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768141368; x=1768746168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27oBcfaqmTyhvCVUz2GHU+cTzUPsIX00TiyzfaLQpD0=;
        b=eEcFh4rSC5biZuCjj0sl3OOeCT5cdBRMuF8qIEqne+VEqZZE0tptzsL4YuYSBhCUC9
         yvsCkiAwjnBte2ybddhmpnIldcaZmLePh5XdQAhJGt/KkR9vkD33kI88hxv/MLskgV7O
         59mz7Wiqx4Ejw/VB7wivV2x1KB0qYo8b/OAhkJAf+NMUdprENKyoyRoMM40apqMDN1Mm
         XRXD+w2u58WKSEKxiTPo5/I2D0oVbOf38ZtQXU7il9foGlOWvougLiHeZwGYPrU9mnag
         Crbxnj3GFcq4mC0MWWjCw+gIkimiAwjc1mUONbSsayPx0mY87w9JqHGFVNTort47JK2P
         rbzw==
X-Gm-Message-State: AOJu0YwHAm8wtKLKwzWJhW8+SFNCh3ShCMDm19j7brVFmYEMmW73ZIIb
	VeadCj6ZSVp88coxzmPX+2q6XOmX+fmZov+FIWyuE8dUMXlHaMoRDMcT
X-Gm-Gg: AY/fxX68a0eZ1vr34cvLrTD6O+pChyTdWAz7jGXrbuuXc5lf8MPB8zM9MxnCN/NC3KA
	jmFCuiC+TctjTJYw8oBbE4VF2zHh9nelIm2oWAaAC6IebsM51sK6SjwvU4rVuLljOMmayQBLNXc
	Xa2zBULCr3iSfzYcWlKPj0mvv75WP9QpwDYrBgfdHd8ZL6u81BH3O/IiKUlO15vmrYued+EKVQ/
	r96GEvdgX6bZacmz4vZpV0pghBuDFPhlKCTQb+Zk9SQ+oCveCX2hxwBldcMNe6QjRTw8iwwkTaJ
	tL2J4NWxi8J5njgIUJhjCSnUAwMrwsIbMBConG/xbTYNV8OGLkdvRVRPk2Ccqkxdg9rmpfvb7X0
	NZ4y3vQBUPa6J42NADLXLhQcJp1oFKE3XoMKUQRg9dS9d0I6F1mN8PDeaGZm20AP12Ff5cNvq8L
	9AyOAlCA2YUtYQmfUmQ+yqmQh9Rw==
X-Google-Smtp-Source: AGHT+IEvOqcaXN9YlexROeVdPt+YPN0fHLuBDzJJIr4LzcnpMZb5ewa9oKIWWm6i2FOtCQwjyVelYQ==
X-Received: by 2002:a05:6a20:748e:b0:37e:4396:146e with SMTP id adf61e73a8af0-3898f9f8a2amr14969931637.74.1768141368317;
        Sun, 11 Jan 2026 06:22:48 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfccsm14887077a12.13.2026.01.11.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:22:46 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>
Subject: [PATCH v5 14/14] MAINTAINERS: update ntfs filesystem entry
Date: Sun, 11 Jan 2026 23:03:44 +0900
Message-Id: <20260111140345.3866-15-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260111140345.3866-1-linkinjeon@kernel.org>
References: <20260111140345.3866-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself and Hyunchul Lee as ntfs maintainer.
Since Anton is already listed in CREDITS, only his outdated information
is updated here. the web address in the W: field in his entry is no longer
accessible. Update his CREDITS with the web and email address found in
the ntfs filesystem entry.

Cc: Anton Altaparmakov <anton@tuxera.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 CREDITS     |  4 ++--
 MAINTAINERS | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/CREDITS b/CREDITS
index 52f4df2cbdd1..4cf780e71775 100644
--- a/CREDITS
+++ b/CREDITS
@@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
 S: Belgium
 
 N: Anton Altaparmakov
-E: aia21@cantab.net
-W: http://www-stu.christs.cam.ac.uk/~aia21/
+E: anton@tuxera.com
+W: http://www.tuxera.com/
 D: Author of new NTFS driver, various other kernel hacks.
 S: Christ's College
 S: Cambridge CB2 3BU
diff --git a/MAINTAINERS b/MAINTAINERS
index a8af534cdfd4..adf80c8207f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18647,12 +18647,11 @@ T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
-M:	Anton Altaparmakov <anton@tuxera.com>
-R:	Namjae Jeon <linkinjeon@kernel.org>
-L:	linux-ntfs-dev@lists.sourceforge.net
-S:	Supported
-W:	http://www.tuxera.com/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
+M:	Namjae Jeon <linkinjeon@kernel.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
-- 
2.25.1


