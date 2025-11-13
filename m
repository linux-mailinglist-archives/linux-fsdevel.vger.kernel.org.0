Return-Path: <linux-fsdevel+bounces-68169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C8C5543F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 02:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418603AF394
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99F28FFF6;
	Thu, 13 Nov 2025 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESTeipE0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10F288C2B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997801; cv=none; b=bdrDFDAEZzc51o5sT1ZhaOkz59CWCZEORRS+PZG1neiFofykiRDNPbpSr7KPFCCB4TdxPF0ZgM92yASvx/PKOmOul//EQGnF4XsV85IFzb2dH5Tek/Mj9DT7oVU9SSRoEtnu9XFLiHN9bEULdNfCKwniMkqhFfB7ruYR7E/sr/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997801; c=relaxed/simple;
	bh=bMdDBLNj03OoDLCv+IHb3i9hv5R5kNipckjW1y7Fk14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvfzTaWy59l9Q1yRZd7Qlvyc6R6EJ7UXrnwKgcQivG6gmFFIRFaolRCYuWpJgmcVs/qIvpOhxCRhAoUjteUeaFfll0uqH4QXR0XyGLNs+XTZhSm+qm+H9gSR8DjOJ2bBosxn6pfF/0pekhsA//NPX21Hjdb8lcORVb6U5Nq2Nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESTeipE0; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3d47192e99bso838499fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 17:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762997799; x=1763602599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jgQtlJhc0lxfymO4tKYMAAUXywVaSmij9voL4WdtpY=;
        b=ESTeipE09Ouw4aTYaFw3XMRaJHgmimxe7+5EfWsKO0aQ3Ei1YroLbVQm0wYXTc2aBf
         OG/0Z1XGaC5sAFfy5jM4qeHymMrmsSl1I5kU7zcgNHwXFPSA3MtoQdzfduFkn7Dioocg
         X81tFxOJMOP61XPZwkPDKDSd5fYegg9jN4N1d+HAZ85nNuQ1jWbgOFKGgnbsOlH88oiO
         ZCGRLg2V/mqtEfUekuwioi1Flaa1D2pgG0opmqNk40I6G3JP3QzXIGl0PbdzqtJLxy2n
         WflAqpGt9WTEF1BfiFFEilGgcue0KWSjtCRIEP+KMx8N6hKwOTVZ6zhLjiqdNQ4/7Ynf
         jjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762997799; x=1763602599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jgQtlJhc0lxfymO4tKYMAAUXywVaSmij9voL4WdtpY=;
        b=SpoztZqrw+dJ6I9uDTrpTWbABgDV5Y1akKdxUGVwJDds3WVIh+XLjeDjyfGOlwvoIX
         2qejPZ4Zl9pfJVW/XOPItFRx4mMpiyRYUoiOY+qy58rq2KmwzkbBmvAW2ZSOx1bnXB0m
         z0YMJ1H1cgIkK+r1JdGyGzdTo9nbR/HeMCP+f6hpKyzZP+9Lkf44IhqIGwZFbPoqXRk8
         u5MaztzV6ZptrVImMxJgstgvtaJgAx68YjLsSRruJ2Ts6/MSTa36sT0WRz+Q6EReA/Ww
         5JyoLEoySwuYpBMYIUtv3hNG5EaxS2FqnJ18HzyqL0d65twYk3u8PquvxFg3zhPtGPyM
         8e8A==
X-Forwarded-Encrypted: i=1; AJvYcCWXdmO72lFnV6zTHrWLPWgIfAqelMjpfftsoNKlBw1Wi4ROgKjt/wrBQ/pXGWEZV2i9BRjmQbDIT1Vksr16@vger.kernel.org
X-Gm-Message-State: AOJu0YwpodoGVwPDNzFYMgb0ugC1vH+Ppu0nNM1QqRLoghab2/+xMl/9
	Xee3grhUUKRZpt0Bsauju6OqO/HmkugmPWVA8ftWikkNmUdupuom2WQd
X-Gm-Gg: ASbGnctGAgkqPpU8AQ+EQfzNuYZroMhCM1IPnBe40AHNA+0/kTMWZckkOvrsBXt9MsH
	7LF2wcd1wbfh/gxbwxAhkeCDnHmjaAnv73/HA4M5JFJaBTEEioei+nC/6EferrJzuqeaRljlk6Y
	xAVak33LUouKB/Q1Qz7CfCuhATxajn5VtDUoRkxyvQcx7GLwgUeW+YDzKfU+PAeNhxlqz7Wde07
	46TOVhjtwb/Q2qKz0rYdfHHK4BiC9DeHYkBTsdAy0rrnOjNQxDzJO2FSv79O7qt5WvPArL89DHo
	YLcCgCzIIXsPlNgK6GUrinni2V3aXObWvfRuulTYag+IBUHvMyDNa+mtg/TLyCdlUUP+wjnh1XF
	zqjHXUoupTyB94sZkBXzAiciEQ2/+LAdMcBO0gZx++NtVw7NDnMjxDIuJkUnmDtIPaKUSw3/snp
	orrdp6gmxQmuTrqp0t/p5PovvHDyAJO+qeZeghSsktzVbKpnBUGi0kuB8W8rZqz667gc/yYFTI/
	t8BjOgLWlHGyTSG1L+Ow1bViu0f
X-Google-Smtp-Source: AGHT+IENjRfB0Wr8Tt+t2GzNl6io0GJSBGW6XHcXIqQoB6ahGHC1gEyI5aGELtUaPn+tkI9HjmtyHA==
X-Received: by 2002:a05:6870:247:b0:314:faa7:931b with SMTP id 586e51a60fabf-3e84c6ffc66mr1042812fac.25.1762997799104;
        Wed, 12 Nov 2025 17:36:39 -0800 (PST)
Received: from uacde259c55d655.ant.amazon.com (syn-071-040-000-058.biz.spectrum.com. [71.40.0.58])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e852058dcesm486754fac.9.2025.11.12.17.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:36:38 -0800 (PST)
From: jayxu1990@gmail.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayxu1990@gmail.com,
	rdlee.upstream@gmail.com,
	avnerkhan@utexas.edu
Subject: [PATCH] fs: optimize chown_common by skipping unnecessary ownership changes
Date: Thu, 13 Nov 2025 09:34:49 +0800
Message-Id: <20251113013449.3874650-1-jayxu1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Xu <jayxu1990@gmail.com>

Add early return optimization to chown_common() when the requested
uid/gid already matches the current inode ownership. This avoids
calling notify_change() and associated filesystem operations when
no actual change is needed.

The check is performed after acquiring the inode lock to ensure
atomicity and uses the kernel's uid_eq()/gid_eq() functions for
proper comparison.

This optimization provides several benefits:
- Reduces unnecessary filesystem metadata updates and journal writes
- Prevents redundant storage I/O when files are on persistent storage
- Improves performance for recursive chown operations that encounter
  files with already-correct ownership
- Avoids invoking security hooks and filesystem-specific setattr
  operations when no change is required

Signed-off-by: Jay Xu <jayxu1990@gmail.com>
---
 fs/open.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..82bde70c6c08 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -761,6 +761,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	struct iattr newattrs;
 	kuid_t uid;
 	kgid_t gid;
+	bool needs_update = false;
 
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
@@ -779,6 +780,17 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	error = inode_lock_killable(inode);
 	if (error)
 		return error;
+
+	/* Check if ownership actually needs to change */
+	if ((newattrs.ia_valid & ATTR_UID) && !uid_eq(inode->i_uid, uid))
+		needs_update = true;
+	if ((newattrs.ia_valid & ATTR_GID) && !gid_eq(inode->i_gid, gid))
+		needs_update = true;
+
+	if (!needs_update) {
+		inode_unlock(inode);
+		return 0;
+	}
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
 				     setattr_should_drop_sgid(idmap, inode);
-- 
2.34.1


