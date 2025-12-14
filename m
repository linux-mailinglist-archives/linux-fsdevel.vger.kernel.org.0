Return-Path: <linux-fsdevel+bounces-71268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4EACBBC96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 16:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC2C0300CAE7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8766C288C25;
	Sun, 14 Dec 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZEDzy2NH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F55F20ADF8
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765726345; cv=none; b=lmwtRwtn+gUBjBNC1qria8GZcufpX9NvvH7yJOUo3VuP/WB5hwBzky94n5AQc8/j4zAFzhIF2CMHdalYxhSmA/rZX1bqXpU5PxRVoCCSMYtyYHyja34QESojDOAEHOCjEf2ebJpj0rZ/vORr58sAJeyKuRpgEVrZ7gGZbIWR9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765726345; c=relaxed/simple;
	bh=Z9rFZA0pSS0lqSIo5S0dvhHqpgQtwqAPtP/IqtMG1Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnnxI+UA5LlupbKi8Uls9NMKqkP87dWp3InLkzHEBDSoerpps7RqGU3j3baGFc7CS7U/2rhViIXwvaDEFRZPYhHjNgsemwGX4bqeINGLIDU84z4aV7Z2PAkZsRPaZqlYZn2YVgWQhlqLlmuwaepbYCjN6hq8O6IyJqhnPlwLsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZEDzy2NH; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765726328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9xx1fqAW3dfvCXG5+4q/Ki6oBzGLhoeu96umkb5NnBA=;
	b=ZEDzy2NHG9NTqEDW1C9yWaRm7C4n17XfQto7/YMi3tsVlQV1e+78RkEWhkzjZeYaOnSXwj
	w/F+wErEyy4rdCqWGEEQxYQ1qe0hev2aGQYr0SRFUYh91Az6Z3c+UdRQPVlGd7Dn072TUO
	YHXTvIsD3AmVldLHy+PLv/JESLdidI0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] namespace: Replace simple_strtoul with kstrtoul to parse boot params
Date: Sun, 14 Dec 2025 16:31:42 +0100
Message-ID: <20251214153141.218953-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtoul() for parsing the
'mhash_entries=' and 'mphash_entries=' boot parameters.

Check the return value of kstrtoul() and reject invalid values. This
adds error handling while preserving behavior for existing values, and
removes use of the deprecated simple_strtoul() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/namespace.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..a548369ddb9c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -49,20 +49,14 @@ static unsigned int mp_hash_shift __ro_after_init;
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
-	if (!str)
-		return 0;
-	mhash_entries = simple_strtoul(str, &str, 0);
-	return 1;
+	return kstrtoul(str, 0, &mhash_entries) == 0;
 }
 __setup("mhash_entries=", set_mhash_entries);
 
 static __initdata unsigned long mphash_entries;
 static int __init set_mphash_entries(char *str)
 {
-	if (!str)
-		return 0;
-	mphash_entries = simple_strtoul(str, &str, 0);
-	return 1;
+	return kstrtoul(str, 0, &mphash_entries) == 0;
 }
 __setup("mphash_entries=", set_mphash_entries);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


