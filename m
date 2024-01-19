Return-Path: <linux-fsdevel+bounces-8341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AE832FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 21:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21566B220C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605556772;
	Fri, 19 Jan 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NuBCT0gx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FnaO4Nth";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NuBCT0gx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FnaO4Nth"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D256458
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695963; cv=none; b=UiKvxDCSQRZd0gqyc4k9rc4gFGXnJI/B983uVtfQXKwZp5ymivI1tCVms4GO2X1FSWBLgI2A/6wZ5dJAzNB7US6X2UpRU2AX/K7SrEDegVUY7W2/px+llSb5em+c4viFPBLDCSi4LpH0FUJJccGNagvw/rvbN9XOtxtXV+w4tZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695963; c=relaxed/simple;
	bh=Mc8CBDiB4yATaOh86WRiahFjBbWe5v1+w6wOAcDs/wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEc2ucKEfieTCOy5GgRCK9dMQM+eLw/W9WHzdDbLiFXnfQWe9suuuaPuue0E7F33dKQuG9NXWvJ8+rOI++4uwOijjLj7aA6BPaVYZ5zXVK+hmvX0bqXdyJ5acPeqWjXQ61lgb2jgEUGcS4jIW+gz0ZbsYR/uliIhA4RAyRRnb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NuBCT0gx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FnaO4Nth; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NuBCT0gx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FnaO4Nth; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF0641F80F;
	Fri, 19 Jan 2024 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705695953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzhYK5257tj7nerNni5RjTEj4MkS2cYXOTpWiBCZtdQ=;
	b=NuBCT0gxhAQIG1GWFAxIWwgaq1YRpKX+mGIguW7JFUPnQWZfDladNhbmk8wlbPdSp/YpDX
	Att9MiIrhA9ZY+jtIAw3aavKGyISfYtSkNCdy/rDhMUVw08IBL7z9DHIG3bFiOv96ToD0R
	xdyuKxgfFV6MW1LlP0WmkYiJYF0jc2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705695953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzhYK5257tj7nerNni5RjTEj4MkS2cYXOTpWiBCZtdQ=;
	b=FnaO4NthDrzC8Z9XPPGaKElpdb6CXDnnBlCltCWsc3B/YSSoCzv2Inb9s2gCTQlixTFy+S
	fw1STosADfZ/XuBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705695953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzhYK5257tj7nerNni5RjTEj4MkS2cYXOTpWiBCZtdQ=;
	b=NuBCT0gxhAQIG1GWFAxIWwgaq1YRpKX+mGIguW7JFUPnQWZfDladNhbmk8wlbPdSp/YpDX
	Att9MiIrhA9ZY+jtIAw3aavKGyISfYtSkNCdy/rDhMUVw08IBL7z9DHIG3bFiOv96ToD0R
	xdyuKxgfFV6MW1LlP0WmkYiJYF0jc2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705695953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzhYK5257tj7nerNni5RjTEj4MkS2cYXOTpWiBCZtdQ=;
	b=FnaO4NthDrzC8Z9XPPGaKElpdb6CXDnnBlCltCWsc3B/YSSoCzv2Inb9s2gCTQlixTFy+S
	fw1STosADfZ/XuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 209E4136F5;
	Fri, 19 Jan 2024 20:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1heaM9DaqmXyJQAAD6G6ig
	(envelope-from <krisman@suse.de>); Fri, 19 Jan 2024 20:25:52 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	torvalds@linux-foundation.org
Cc: tytso@mit.edu,
	linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v3 1/2] dcache: Expose dentry_string_cmp outside of dcache
Date: Fri, 19 Jan 2024 17:25:42 -0300
Message-ID: <20240119202544.19434-2-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119202544.19434-1-krisman@suse.de>
References: <20240119202544.19434-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

In preparation to call these from libfs, expose dentry_string_cmp in the
header file.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/dcache.c            | 53 ------------------------------------------
 include/linux/dcache.h | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b813528fb147..7bb17596d0ad 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -201,59 +201,6 @@ static int __init init_fs_dcache_sysctls(void)
 fs_initcall(init_fs_dcache_sysctls);
 #endif
 
-/*
- * Compare 2 name strings, return 0 if they match, otherwise non-zero.
- * The strings are both count bytes long, and count is non-zero.
- */
-#ifdef CONFIG_DCACHE_WORD_ACCESS
-
-#include <asm/word-at-a-time.h>
-/*
- * NOTE! 'cs' and 'scount' come from a dentry, so it has a
- * aligned allocation for this particular component. We don't
- * strictly need the load_unaligned_zeropad() safety, but it
- * doesn't hurt either.
- *
- * In contrast, 'ct' and 'tcount' can be from a pathname, and do
- * need the careful unaligned handling.
- */
-static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
-{
-	unsigned long a,b,mask;
-
-	for (;;) {
-		a = read_word_at_a_time(cs);
-		b = load_unaligned_zeropad(ct);
-		if (tcount < sizeof(unsigned long))
-			break;
-		if (unlikely(a != b))
-			return 1;
-		cs += sizeof(unsigned long);
-		ct += sizeof(unsigned long);
-		tcount -= sizeof(unsigned long);
-		if (!tcount)
-			return 0;
-	}
-	mask = bytemask_from_count(tcount);
-	return unlikely(!!((a ^ b) & mask));
-}
-
-#else
-
-static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
-{
-	do {
-		if (*cs != *ct)
-			return 1;
-		cs++;
-		ct++;
-		tcount--;
-	} while (tcount);
-	return 0;
-}
-
-#endif
-
 static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *ct, unsigned tcount)
 {
 	/*
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 1666c387861f..0f210a396074 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -592,4 +592,57 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
 }
 
+/*
+ * Compare 2 name strings, return 0 if they match, otherwise non-zero.
+ * The strings are both count bytes long, and count is non-zero.
+ */
+#ifdef CONFIG_DCACHE_WORD_ACCESS
+
+#include <asm/word-at-a-time.h>
+/*
+ * NOTE! 'cs' and 'scount' come from a dentry, so it has a
+ * aligned allocation for this particular component. We don't
+ * strictly need the load_unaligned_zeropad() safety, but it
+ * doesn't hurt either.
+ *
+ * In contrast, 'ct' and 'tcount' can be from a pathname, and do
+ * need the careful unaligned handling.
+ */
+static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
+{
+	unsigned long a,b,mask;
+
+	for (;;) {
+		a = read_word_at_a_time(cs);
+		b = load_unaligned_zeropad(ct);
+		if (tcount < sizeof(unsigned long))
+			break;
+		if (unlikely(a != b))
+			return 1;
+		cs += sizeof(unsigned long);
+		ct += sizeof(unsigned long);
+		tcount -= sizeof(unsigned long);
+		if (!tcount)
+			return 0;
+	}
+	mask = bytemask_from_count(tcount);
+	return unlikely(!!((a ^ b) & mask));
+}
+
+#else
+
+static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char *ct, unsigned tcount)
+{
+	do {
+		if (*cs != *ct)
+			return 1;
+		cs++;
+		ct++;
+		tcount--;
+	} while (tcount);
+	return 0;
+}
+
+#endif
+
 #endif	/* __LINUX_DCACHE_H */
-- 
2.43.0


