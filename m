Return-Path: <linux-fsdevel+bounces-71477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695ACC3C08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83D65300887A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175334AAE3;
	Tue, 16 Dec 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f98E1pah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FC28030E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896778; cv=none; b=t6l9gJ6wVaQQQF9a+NRsmdE8AloPEPgGVONzbJvYaiiYi4+DStGMWpR56JumTT8UP2FYgwuo871TuTFU9lFcPx2XYNUaVfEglopLxUD+cu7LRd4HbgYhHMO0ZqrKWaDm0dLo0OwarOzHN0fGPnrVUteMb0PQJSQ6yx4ijNQL9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896778; c=relaxed/simple;
	bh=dqD3qZSjcbSnh5gCbahmUSEok9esyhLdBnatHULtqKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=STWpK7qZlOJ3B5FZpvvwiSaIrXi86NdAqFVlUkqFgkdjllQZXoL6P2IBQPdlmcDk48VbXYZwsSig/PeQYBFiwgEb0xQdg1gEf+BHnc/AB10WkgRiPyLdra/DJsbD1tvQKHOfK1Bocu2tD2jJFurabHqsvXQ6mYC/qnxPz2xFAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f98E1pah; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765896775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+xfxZPHc4yJJ1NHFfvbKujleBGkMgd2FNdpQr/zDwwM=;
	b=f98E1pahqTI6HD+oH0cUYeOl8AWFJaSKCuMK5TJbAr3+ufUC04rb5L2A0NR/cEyYeYLwNy
	gdlDGXmlByugy/RRYo2NbChHoY9nKnkYX/aiEvnI6AWFtFvmvnarz6u8ArVxnE8B0mptfg
	1OATkHsoVBd/G83By78pzhCKrhzq0eY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dcache: Replace simple_strtoul with kstrtoul in set_dhash_entries
Date: Tue, 16 Dec 2025 15:52:37 +0100
Message-ID: <20251216145236.44520-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtoul() for parsing the
'dhash_entries=' boot parameter.

Check the return value of kstrtoul() and reject invalid values. This
adds error handling while preserving behavior for existing values, and
removes use of the deprecated simple_strtoul() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/dcache.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index dc2fff4811d1..ec275f4fd81c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3227,10 +3227,7 @@ EXPORT_SYMBOL(d_parent_ino);
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
-	if (!str)
-		return 0;
-	dhash_entries = simple_strtoul(str, &str, 0);
-	return 1;
+	return kstrtoul(str, 0, &dhash_entries) == 0;
 }
 __setup("dhash_entries=", set_dhash_entries);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


