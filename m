Return-Path: <linux-fsdevel+bounces-44817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D51A6CDD6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 04:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17187A2721
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 03:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE70A1FFC40;
	Sun, 23 Mar 2025 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbOFabvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD1719D072;
	Sun, 23 Mar 2025 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742701652; cv=none; b=LaR+oU3F0E5vr+l+bQN9V9X3NqkZZWvc1f9aUKJGVERysSfIJq6eDs+soeIV0VDJm95KPPNMw14eW9xlyU7Qzho2UDrbE625toG/q1HTHp7rQM4sRLwAHHvDak3RnUmmNxHgywCtwrn9kLo0Uk386dqD1OChlHrBeaC3KUQE4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742701652; c=relaxed/simple;
	bh=WEU78p+4ISCb1u0XqjPlV+IporpqnM/H0CSjyncfgQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0ggCx4GvECzZAjeMw5dMwTm7AwVwQXy2R8SrDpWG84tkX7Q6O1owMYxhkkRTUkJP12J7pVN9bxxBUf1eEZlsXrDBdSUtvwzhrfdH6Z/m3XdHlwVAfu/py8F1E7DAy4IWhVfMEqbaU6Tv6gJy1pJkvJxBf8N5IcFWm257I35eXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbOFabvT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso68247465ad.2;
        Sat, 22 Mar 2025 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742701650; x=1743306450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6XOCol3u2a6nPObOOGbkI8Fg5Rq3rgeqOQ9YANUzBs=;
        b=LbOFabvTW1KVcepOiVhzCJGyY9caNXxR0Mes6H0oIDaVD0h1A64oGaAv5ppxw1uhwC
         S1NWKNLgqfkR0zP716PKUC4xPoDApKr1qzYRbtk8+8X4NDV4NtI22+o3yadiHs5ywEMc
         7UbFq2RrTf4bvGmsSm1I/gPeHfw3tpP47OUIDMe9RAMzIQzpTAP54QwSaOkkFNhnBxbk
         A1CQSCm2BhBLNr4FJm5vMXvKopQiIavQpRCInpS/e9VKFaHpxKyeJpLIOjRZEpGLR6sS
         vBiSSu6+1uE05eqKg4+ExoQmAxki5XYcg8x+tJoNWwxyX8EkR1550jw44cvFtJkOPTzw
         eVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742701650; x=1743306450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6XOCol3u2a6nPObOOGbkI8Fg5Rq3rgeqOQ9YANUzBs=;
        b=lGPfzcCu+Ff55c7L8f1ScI7SETl/VQD7JawCMcANSb7rx81f2EGmE8+NX52+WQx2A1
         F2Fo88FSa8/r27jWNRnuZrdU1+0TbgZGroY3X8sDDG0XKpAeVVnQEWiOO9badjD5z60J
         SHc72+EuojWTSHiNwvRxI4CsC6b0olran1JwdUU+JLhf+G+UW4KsTTcNagXwhimPpwJe
         fRYAp74XViBmng9SRvzGtRoUU6dkg+AVynk+lxK1mPlg05bfKxDZMLMIgp1BFv38KSIF
         x4wrcR2q+WQlgwMuyVe8oPJ1cPXASVYjGAtymB2cv1mX9s8jUIxWJ/phKQ0VOT7TVJWN
         F+ig==
X-Forwarded-Encrypted: i=1; AJvYcCUuhRIP2OF1WOFMp2SWSbaCTBUB0iDXl92CJL+vwEyt+g5IYBaJr1d5hNbFtEe5kgme1YOczIMfkcY=@vger.kernel.org, AJvYcCVu0jbu7YGhvr1OqoFuDQAFayX6eEAaTe14ZpG4hkgNGKbMMrM/9x1ZjetScAUApQMQQUgenzh9mz3ncXbx@vger.kernel.org, AJvYcCXKwwGbsU4DbJRB4xIEQ8xWsWGMx+zuXnAvfw8rx9Ly2BNrSOBSy93Csq/N7jZdAKwFD2pLWcpsIUCVRkhavA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHA0tIg5kSFLcJuGCPsxMFVFQ9A82Rxjey1jneT4CO5HNLp6To
	+ShrWJ34iEXG+7FghMp9bi4t9Is3Cy/wkXM5hpddf1At62tZXkHu
X-Gm-Gg: ASbGncve6QnqsQ3Guo5xCxpP6rFmVjxIq6wfDyrChoHXtN0Gcr7VSkYfcP9PsNeeQ6Z
	KCgivLnUE1KteOUlAomYYhDmCe1dosTKvHtu3ckmS20Rm1fAu4Pf+Edmx1yYpPV/KeW6v4eMJdh
	DAD8U9FSmk/US8YCXkXxUFDu2bRxi1ErAYULrJJgj7nTiSYo5IGsmXcEZHzwiSJS2qhQmFqxP+6
	Dz5/6nLmsg9l57k/Z5K34v7/mVo1dALR+CAgDKrhWTaxFINeywDM7ltB2HSmsDEFkp/0uMRsjjV
	sUCLxjA/ViKAo1FrDlxXdl9LKWqoLhO667HzgEOFrWOseoM8EZw8GOkMgqbTO504lgTlUKFOG1s
	=
X-Google-Smtp-Source: AGHT+IGUsaWLVZsiSf2Nx/UAovAOD7/IzjSlUccrMhNTRIciOQVi+kOE55M63M4IOxnqDRElDxhI9g==
X-Received: by 2002:a17:902:f54e:b0:223:fb3a:8647 with SMTP id d9443c01a7336-22780e0a4b3mr137083985ad.41.1742701650031;
        Sat, 22 Mar 2025 20:47:30 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:ea7b:3f3b:ca04:6bed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3962esm43771985ad.4.2025.03.22.20.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 20:47:29 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: corbet@lwn.net
Cc: willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] docs: vfs: Update struct file_system_type
Date: Sun, 23 Mar 2025 11:47:25 +0800
Message-ID: <20250323034725.32329-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure definition now in the kernel adds macros defining the
value of "fs_flags", and the value "FS_NO_DCACHE" no longer exists,
update it to an existing flag value.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 Documentation/filesystems/vfs.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 31eea688609a..4e7fa09ffb6d 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -115,6 +115,14 @@ members are defined:
 	struct file_system_type {
 		const char *name;
 		int fs_flags;
+	#define FS_REQUIRES_DEV		1
+	#define FS_BINARY_MOUNTDATA	2
+	#define FS_HAS_SUBTYPE		4
+	#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+	#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+	#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+	#define FS_MGTIME		64	/* FS uses multigrain timestamps */
+	#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 		int (*init_fs_context)(struct fs_context *);
 		const struct fs_parameter_spec *parameters;
 		struct dentry *(*mount) (struct file_system_type *, int,
@@ -140,7 +148,7 @@ members are defined:
 	"msdos" and so on
 
 ``fs_flags``
-	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
+	various flags (i.e. FS_REQUIRES_DEV, FS_BINARY_MOUNTDATA, etc.)
 
 ``init_fs_context``
 	Initializes 'struct fs_context' ->ops and ->fs_private fields with
-- 
2.43.0


