Return-Path: <linux-fsdevel+bounces-55504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F406CB0AF62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 12:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F43417C9ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52E1F0E53;
	Sat, 19 Jul 2025 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="nDX41oT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B033086
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752922105; cv=none; b=b3X8dMxmqci0yuW09dz5iPEbAyc26A70gJvjBkk/sGRq2qqt2tAE4K0Pz0BN7xmhlHBkU2zuOta75zpav27+XQiG/jAW1ExmBbJkE2T7l+QQOgIw4s7Ou0C8uASiUf8OGi17hotZNEpYM7WSJPoe7v90JQcC1AeO5WWuVna0jZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752922105; c=relaxed/simple;
	bh=wRToebOgD2Bcn86y6mE+jFiOMl5OVz4jY+xI67fswZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtQ2AEgWIGfc6UY2pIQ/eW6b0eO9if4xSUZ0A1iMOdRIUkq42fFnCPblYpAIm8Q4ls+Be2mDN2zQtrshLTizTNPHmHABreLZArFBA5Qt1UNA7pDZ6yN4RtgRd3vSqpmXIWuHVK/8t58BXXo5FBwFhownhSugxiBpJ1wM6pdWtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=nDX41oT9; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bkjsF25f9zbwj;
	Sat, 19 Jul 2025 12:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1752921729;
	bh=UZjiRjH49PYgy3qE+zlhOgQ/NjKjfYpX267/9XpQles=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDX41oT9eMWV/Ukc3xq/OL+Gf+xGZCHW2wj+/yIb7k7AWMjCtwfqIZYrFHht6H65t
	 J296jPBuRXEPGYhdZk6gl/juz6CniRSNKyfJdL+gvbEZqlmjKvWrwj5xTKF0Y3jDmz
	 qWwsnE23+JrSgA3CYRTwJ96oGARhdTo2m8BwN4Bs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bkjsD1RQczbgx;
	Sat, 19 Jul 2025 12:42:08 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ben Scarlato <akhna@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	NeilBrown <neil@brown.name>,
	Paul Moore <paul@paul-moore.com>,
	Ryan Sullivan <rysulliv@redhat.com>,
	Song Liu <song@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [PATCH v3 1/4] landlock: Fix cosmetic change
Date: Sat, 19 Jul 2025 12:42:00 +0200
Message-ID: <20250719104204.545188-2-mic@digikod.net>
In-Reply-To: <20250719104204.545188-1-mic@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This line removal should not be there and it makes it more difficult to
backport the following patch.

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Fixes: 7a11275c3787 ("landlock: Refactor layer helpers")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 security/landlock/fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 6fee7c20f64d..c04f8879ad03 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -895,6 +895,7 @@ static bool is_access_to_paths_allowed(
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
 			break;
+
 jump_up:
 		if (walker_path.dentry == walker_path.mnt->mnt_root) {
 			if (follow_up(&walker_path)) {
-- 
2.50.1


