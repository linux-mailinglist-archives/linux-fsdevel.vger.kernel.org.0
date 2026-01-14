Return-Path: <linux-fsdevel+bounces-73723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD161D1F354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EC4D301ABA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766FF274641;
	Wed, 14 Jan 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEyszNiu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="46b+lA5E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEyszNiu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="46b+lA5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB326ED45
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398800; cv=none; b=iudNnPaCCkJbff01PhGBlsIUcZ7NReB6Kdk5+fv7zMZRHcYTMGdIbS8jUjxdRkJVOB51hynbWAtlTVq53eJws0+1Kowod93Z9COGPTW/UZu8nyn3m+IFjkCdco2ooxziW4wT+6JqRsYQ/epl7MrekKshazVRf5bxAGFjTuJEqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398800; c=relaxed/simple;
	bh=NYuATEDtPH2aw9cPHIwnlBKQQE0gAXIc9vN+OjXg2o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I09Z8Oa/rcRMJYIQTKJfVLzmpQIa2z1zkqjHh/zBvEwENav1bOgsb5/dNFU2s3HUlCtgvAd+j9+ZZOJ2B3q4Cgxjc+UOkk1W+lHdR1WuMlf5Yw9sUdT2ToiT9o7cz8yoMdq9G3Bq680si1+Rt/5BBIl0GeeH/Ve4jslDFye/h64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEyszNiu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=46b+lA5E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEyszNiu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=46b+lA5E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA8A35C6FA;
	Wed, 14 Jan 2026 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768398797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRalBx4IMiovVrwX+MoHGW1nxZPUsjhYLeGPYJTQdl8=;
	b=lEyszNiuUGP2UlejGmXbKL3qwFH7hV8fBgrRMEE7HMSrUMAqbLkf5l6tdja4Poj/xr2w4j
	B8kxG0/cSnSzW60J+HTBQMrQnIlqxYqHUzqAWZraLZRLi4drGQY8jUIaHKtQfHzXXr4N4I
	ahAEa6WZ7ifG6EDFyJl6Mlpy+YNjdjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768398797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRalBx4IMiovVrwX+MoHGW1nxZPUsjhYLeGPYJTQdl8=;
	b=46b+lA5E2swG5i+zyK6xTiVAZXPvWVKccS/Y2o2xRS+kBdm1VNDT/YWLloocDRbmoDCMb+
	/Ompp0AJQEzOjtDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768398797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRalBx4IMiovVrwX+MoHGW1nxZPUsjhYLeGPYJTQdl8=;
	b=lEyszNiuUGP2UlejGmXbKL3qwFH7hV8fBgrRMEE7HMSrUMAqbLkf5l6tdja4Poj/xr2w4j
	B8kxG0/cSnSzW60J+HTBQMrQnIlqxYqHUzqAWZraLZRLi4drGQY8jUIaHKtQfHzXXr4N4I
	ahAEa6WZ7ifG6EDFyJl6Mlpy+YNjdjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768398797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRalBx4IMiovVrwX+MoHGW1nxZPUsjhYLeGPYJTQdl8=;
	b=46b+lA5E2swG5i+zyK6xTiVAZXPvWVKccS/Y2o2xRS+kBdm1VNDT/YWLloocDRbmoDCMb+
	/Ompp0AJQEzOjtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B2573EA63;
	Wed, 14 Jan 2026 13:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 14c0HM2fZ2mBJwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 14 Jan 2026 13:53:17 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] initramfs_test: kunit test for cpio.filesize > PATH_MAX
Date: Thu, 15 Jan 2026 00:50:52 +1100
Message-ID: <20260114135051.4943-2-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114134546.1691-1-ddiss@suse.de>
References: <20260114134546.1691-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

initramfs unpack skips over cpio entries where namesize > PATH_MAX,
instead of returning an error. Add coverage for this behaviour.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
v2:
- clean up created directory

 init/initramfs_test.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 5d2db455e60c5..beb6e3cf78081 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -447,6 +447,53 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
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
+	KUNIT_EXPECT_EQ(test, init_rmdir("fname_ok"), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -459,6 +506,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_hardlink),
 	KUNIT_CASE(initramfs_test_many),
 	KUNIT_CASE(initramfs_test_fname_pad),
+	KUNIT_CASE(initramfs_test_fname_path_max),
 	{},
 };
 
-- 
2.51.0


