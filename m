Return-Path: <linux-fsdevel+bounces-44339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D0A678F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DB819C4149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E435E212B3D;
	Tue, 18 Mar 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="vg9QND59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99477210F44
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314510; cv=none; b=pzW13LC8wcx6iATHXQbGZI4fP5Ru3wYg4q8Kx4p8mTUgjJztCEUTqgLiX7L/ebdKTcgsvo2cd49CU3TqsewsAZLINxPmjBkuw5eCnwTLusQUlUZt/fUSvHCHruqGDoxWL/vP8tdWZHQBixHfmX/QCA4FbCC/oTmGp1ILMxufAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314510; c=relaxed/simple;
	bh=JIXfcRnOc2NsgTREu0brY0eFsywSqCuOtFh/aDiOzuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJRh7rmPtarLucPK1179XOttwzVGjXA8W375ngW7AZIF7DHi+DS5wZZIqS3kLupcIT/bQaDiVqeW+GPZGqiH5s/OWqk2hCvH36GBPL+95I3MpSj0a+3QbLpypyZg6SqS98XxL0XpF7Y4bwMSUYFiSuaTsHe5Md9DNQkqiXtceZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=vg9QND59; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH4540cGzFpr;
	Tue, 18 Mar 2025 17:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314501;
	bh=TAanqdbmi/XehtIUQzZvwwXbsMighDnqKc1rhhGRDAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vg9QND59PMWzfBPWgQ7qHUm2QRgBm38IISEoW272yiB4ftP2voTwZC6yP1S/ZY+Pm
	 G+yqZJq9MMNZFXw800mqKfRbg60xjaj0kuUWfpWgd+m+GV2iUaHRh79QG/bdbVRz57
	 6k27WtDvY5L++56zwaiSP9szNgm/ZCKU3VQEaHUc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH446ZD2zHwt;
	Tue, 18 Mar 2025 17:15:00 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 8/8] landlock: Document errata
Date: Tue, 18 Mar 2025 17:14:43 +0100
Message-ID: <20250318161443.279194-9-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Explain errata use case and include documentation from each errata file.

This is a dedicated commit to avoid backporting issues.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-9-mic@digikod.net
---

Changes since v1:
- New patch.
---
 Documentation/userspace-api/landlock.rst | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index ad587f53fe41..80b090729975 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: January 2025
+:Date: March 2025
 
 The goal of Landlock is to enable restriction of ambient rights (e.g. global
 filesystem or network access) for a set of processes.  Because Landlock
@@ -663,6 +663,28 @@ To be able to explicitly allow TCP operations (e.g., adding a network rule with
 ``EAFNOSUPPORT`` error, which can safely be ignored because this kind of TCP
 operation is already not possible.
 
+Errata
+======
+
+These errata identify visible fixes (e.g., loosen restrictions) that should be
+applied to any kernel according to their supported Landlock ABI.  Because user
+space updates and kernel updates might not be applied at the same time, user
+space may need to check if specific features are fixed and can now be leveraged
+with the running kernel.  To get these errata, use the
+``LANDLOCK_CREATE_RULESET_ERRATA`` flag with sys_landlock_create_ruleset().
+
+ABI v4
+------
+
+.. kernel-doc:: security/landlock/errata/abi-4.h
+    :identifiers: erratum_1
+
+ABI v6
+------
+
+.. kernel-doc:: security/landlock/errata/abi-6.h
+    :identifiers: erratum_2
+
 Questions and answers
 =====================
 
-- 
2.48.1


