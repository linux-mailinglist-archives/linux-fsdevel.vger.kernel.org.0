Return-Path: <linux-fsdevel+bounces-23817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4B933C09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AB72816CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16C17F4F3;
	Wed, 17 Jul 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bUQUacIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4E17F398;
	Wed, 17 Jul 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214890; cv=none; b=ZdgCVAURmqgA+MI5j7Vvx+ZI9uv72sNlG1TybEScNvy1TdfRJujOQ2u6Z6XTFp5UfBhdk9gJLaRDQeSBbm9xH4xTAKLd7X94I20iD4lG1/V9mx3dCak+twwhqTstpL4fpkqCZF2fPnEh1spPkifqrt/yS9DVVRuxUXEqpr8iyxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214890; c=relaxed/simple;
	bh=uKIQZyZb4wlIcTIQWuj2eLj1eh0WA1HrCO/Syb8iJB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GW4Z/gz36gAcX+ta0JvROYGPsTTrMyU6NT6gG0DAIlxLKNuYfoBiWQIDkZkeFaeqkysEPx1kULUdZ6D21bRm4yDCFc+ASO4EW+dyCAw4P755IgNN5xLEgbdvuNNF31ey3yNJB6/epNrfGFDIdyfCFUQtJhqBSI0MeAV56+a3t/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bUQUacIO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721214887;
	bh=uKIQZyZb4wlIcTIQWuj2eLj1eh0WA1HrCO/Syb8iJB0=;
	h=From:To:Cc:Subject:Date:From;
	b=bUQUacIOuc8/IUKEzBK2agauSMgBeqCeJFsxJaqgc+V/GEvsdu/w9/9ZVNqms9hNJ
	 cQo2YzK5acaY/F1sonOsvh/XYBh6LLNv/8I7fKQP6WN0AEUramlOsNLuL5+gS4uHfy
	 8VN25xoqih5K51nogszVpR+dVUI82J+eRDM/8EWLpmgkAW43zTtqHH3DzEw/rtyaV/
	 R72O3dIaU6Iq3pDky9s2S+oXY3P9Quz9Dci55SVJYl8TJh6pejFEwGIsZ4xJr0Jc1D
	 UDG1YDABJygqh3M0QVfNnmvMcVh7e+Rj3GbZXWBC/mkTr6KEOhzhjWr1Ibx+ChbY1p
	 EbaRRqKxs458Q==
Received: from gentoo.ratioveremundo.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1B7043780C11;
	Wed, 17 Jul 2024 11:14:46 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kernel@collabora.com,
	gbiv@google.com,
	inglorion@google.com,
	ajordanr@google.com,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Doug Anderson <dianders@chromium.org>,
	Jeff Xu <jeffxu@google.com>,
	Jann Horn <jannh@google.com>,
	Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] proc: add config to block FOLL_FORCE in mem writes
Date: Wed, 17 Jul 2024 14:13:58 +0300
Message-ID: <20240717111358.415712-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simple Kconfig option removes the FOLL_FORCE flag from
procfs write calls because it can be abused.

Enabling it breaks some debuggers like GDB so it defaults off.

Previously we tried a more sophisticated approach allowing
distributions to fine-tune proc/pid/mem behaviour via both
kconfig and boot params, however that got NAK-ed by Linus [1]
who prefers this simpler approach.

Link: https://lore.kernel.org/lkml/CAHk-=wiGWLChxYmUA5HrT5aopZrB7_2VTa0NLZcxORgkUe5tEQ@mail.gmail.com/ [1]
Cc: Doug Anderson <dianders@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 fs/proc/base.c   |  6 +++++-
 security/Kconfig | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..53ad71d7d785 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -855,7 +855,11 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = (write ? FOLL_WRITE : 0);
+
+#ifndef CONFIG_SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE
+	flags |= FOLL_FORCE;
+#endif
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..24053b8ff786 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,20 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE
+	bool "Remove FOLL_FORCE usage from /proc/pid/mem writes"
+	default n
+	help
+	  This restricts FOLL_FORCE flag usage in procfs mem write calls
+	  because it bypasses memory permission checks and can be used by
+	  attackers to manipulate process memory contents that would be
+	  otherwise protected.
+
+	  Enabling this will break GDB, gdbserver and other debuggers
+	  which require FOLL_FORCE for basic functionalities.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
-- 
2.44.2


