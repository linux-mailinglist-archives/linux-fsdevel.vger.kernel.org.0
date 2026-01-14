Return-Path: <linux-fsdevel+bounces-73710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD9D1F288
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F004830652B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7530231845;
	Wed, 14 Jan 2026 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NOt/whE+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GU964T5Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NOt/whE+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GU964T5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F121D3CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398358; cv=none; b=JKz1H0kt9LWN03qcr5OeNYurKLQWhUraUEcLkDy6UYEo/QRSVlU8QcEnnPzoEYvzC74NGA2mGQuWXtIKtRtNJTSR4QrQLhBvlKWi4AkMUG6YEq/1TrwruQnOticUByGviutqCRDEQUtGwX+S1g9koh41sLIYKnXR+Di3J1mHGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398358; c=relaxed/simple;
	bh=BCCyCsRW7Vf4Sl/bkOLHieBKq/+dCXkKunHW/qohU9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJNk3G4GWzo6sDUOmghZcOuelB7ZEjsu2RssOcbZBdFATgAFRkb6wCeOAvQpQSaI7xqaXb/Q0D5vPPhDXjgHpFxVIy5JZ6iZgHUEzQerqgWpTzt9oiEP5og73tQDQQYCkajygUJEwhU+Cyxq6/2zWMuiYRka8fTWpKnG0nSakW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NOt/whE+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GU964T5Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NOt/whE+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GU964T5Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2C70341B9;
	Wed, 14 Jan 2026 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768398354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJ6Q4N2jna6xKyDfI7nc6YI9P3b3/bf/GJViF/rkRKg=;
	b=NOt/whE+fXHThT3QliCBkWOSLPe66ZYW3vuhEGi8cYzYbhATt9lONSJrPGS73rEWPcwKfB
	tFhNrj1aARtRE/YlH8MbgBpaHIRppC5DuATv0bOFTbbbuGbAnQ1Kws2uDoYGdQtNAxBen0
	auDkajgqx2qFqJQtqdNZCbPZ+U/zR84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768398354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJ6Q4N2jna6xKyDfI7nc6YI9P3b3/bf/GJViF/rkRKg=;
	b=GU964T5ZKy+vNFaI+HyEJWeVEgZhjNn69GFmDrr7WdWayUFcRlQ2qCjhjntr+J6sDnggrz
	gXbBqLd3JDx+03Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768398354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJ6Q4N2jna6xKyDfI7nc6YI9P3b3/bf/GJViF/rkRKg=;
	b=NOt/whE+fXHThT3QliCBkWOSLPe66ZYW3vuhEGi8cYzYbhATt9lONSJrPGS73rEWPcwKfB
	tFhNrj1aARtRE/YlH8MbgBpaHIRppC5DuATv0bOFTbbbuGbAnQ1Kws2uDoYGdQtNAxBen0
	auDkajgqx2qFqJQtqdNZCbPZ+U/zR84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768398354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JJ6Q4N2jna6xKyDfI7nc6YI9P3b3/bf/GJViF/rkRKg=;
	b=GU964T5ZKy+vNFaI+HyEJWeVEgZhjNn69GFmDrr7WdWayUFcRlQ2qCjhjntr+J6sDnggrz
	gXbBqLd3JDx+03Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4453EA63;
	Wed, 14 Jan 2026 13:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PTNFLBKeZ2l2IAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 14 Jan 2026 13:45:54 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] initramfs_test: kunit test for cpio.filesize > PATH_MAX
Date: Thu, 15 Jan 2026 00:45:46 +1100
Message-ID: <20260114134546.1691-1-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

initramfs unpack skips over cpio entries where namesize > PATH_MAX,
instead of returning an error. Add coverage for this behaviour.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 5d2db455e60c5..83f2f14387298 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -447,6 +447,52 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	kfree(tbufs);
 }
 
+static void __init initramfs_test_fname_path_max(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct kstat st0, st1;
+	char fdata[] = "this file data will not be unpacked";
+	struct test_fname_path_max {
+		char fname_oversize[PATH_MAX + 1];
+		char fname_ok[PATH_MAX];
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
+	} *tbufs = kzalloc(sizeof(struct test_fname_path_max), GFP_KERNEL);
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof(tbufs->fname_oversize),
+		.fname = tbufs->fname_oversize,
+		.filesize = sizeof(fdata),
+		.data = fdata,
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.namesize = sizeof(tbufs->fname_ok),
+		.fname = tbufs->fname_ok,
+	} };
+
+	memset(tbufs->fname_oversize, '/', sizeof(tbufs->fname_oversize) - 1);
+	memset(tbufs->fname_ok, '/', sizeof(tbufs->fname_ok) - 1);
+	memcpy(tbufs->fname_oversize, "fname_oversize",
+	       sizeof("fname_oversize") - 1);
+	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
+	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_src);
+
+	/* unpack skips over fname_oversize instead of returning an error */
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat("fname_oversize", &st0, 0), -ENOENT);
+	KUNIT_EXPECT_EQ(test, init_stat("fname_ok", &st1, 0), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -459,6 +505,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_hardlink),
 	KUNIT_CASE(initramfs_test_many),
 	KUNIT_CASE(initramfs_test_fname_pad),
+	KUNIT_CASE(initramfs_test_fname_path_max),
 	{},
 };
 
-- 
2.51.0


