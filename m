Return-Path: <linux-fsdevel+bounces-74729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJxzMBHwb2m+UQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:13:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBFE4C0F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09EBD68ED96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDB3D647A;
	Tue, 20 Jan 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ngeddXK6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQappXYR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ngeddXK6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQappXYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B93A35AE
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942052; cv=none; b=Bj49kAuepW07xcLUNUVQDPKA64M3yDsj4DeTT6f8OAThUNXjfJRpUGyHYhSKqtu9YydaqDMpADj8dMrRil8kV5XGQUtdotk3/HJu3CHbXom8qnWyxrAbwiG/307ogucPxJpMeSm8W6fZzaLuQUtK4XCV1vOmo6Nu1UoJPtZ0tN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942052; c=relaxed/simple;
	bh=tXpQm5ofeFSEsVZWxUpJvSiAia1FS37sPKUYwJYUIqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFL2ZtSOo8yNMWi73d26E22IRQfPO4lfE5KXqLMwMefCxeXa15I6NbB9ZznLY8fp3xsn8omMyjxpEbzr5KsnBGApR7RfNiijThq9yf+bFcV4J3l6vHkdKNArl0DeWGbwvMblit50r78g5okp7hPKvphuhzWNPMfp0m/TKlFQcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ngeddXK6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQappXYR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ngeddXK6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQappXYR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6346F336AE;
	Tue, 20 Jan 2026 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768942042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GCp+zoeJZNn3ANxMa8Frng0FRQ7kDeaXq79CM3mMlU=;
	b=ngeddXK6Sbb1Peu/rR/vv4CtKaHavO3YCPF/V+n6J4tu8p5u6nStH1gQBfSpIpZEcxyURQ
	ePIKtzyiAxoegxYF2BYLZjakvNN/CU0iS3t4PpWC/eXziZpZ03976w8Rlg4PEwZSxzUkqd
	5xvWFB0Z5eDaNwPjK2dkJU+ZykwnY5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768942042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GCp+zoeJZNn3ANxMa8Frng0FRQ7kDeaXq79CM3mMlU=;
	b=uQappXYR/h5MTbCsk8xzw7YV2M9nlx5Q25o3HyWn0Vf3v5wpC29qx6NdbIgrArUZ4YgZTh
	ppj/a6b0r4044yBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ngeddXK6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uQappXYR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768942042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GCp+zoeJZNn3ANxMa8Frng0FRQ7kDeaXq79CM3mMlU=;
	b=ngeddXK6Sbb1Peu/rR/vv4CtKaHavO3YCPF/V+n6J4tu8p5u6nStH1gQBfSpIpZEcxyURQ
	ePIKtzyiAxoegxYF2BYLZjakvNN/CU0iS3t4PpWC/eXziZpZ03976w8Rlg4PEwZSxzUkqd
	5xvWFB0Z5eDaNwPjK2dkJU+ZykwnY5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768942042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GCp+zoeJZNn3ANxMa8Frng0FRQ7kDeaXq79CM3mMlU=;
	b=uQappXYR/h5MTbCsk8xzw7YV2M9nlx5Q25o3HyWn0Vf3v5wpC29qx6NdbIgrArUZ4YgZTh
	ppj/a6b0r4044yBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 323143EA65;
	Tue, 20 Jan 2026 20:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJ3fCtrpb2l7UAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 20 Jan 2026 20:47:22 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/2] initramfs_test: add fill_cpio() format parameter
Date: Wed, 21 Jan 2026 07:32:32 +1100
Message-ID: <20260120204715.14529-2-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120204715.14529-1-ddiss@suse.de>
References: <20260120204715.14529-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74729-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5DBFE4C0F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fill_cpio() uses sprintf() to write out the in-memory cpio archive from
an array of struct initramfs_test_cpio. This change allows callers to
override the cpio sprintf() format string so that future tests can
intentionally corrupt the header with non-hex values.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index beb6e3cf78081..8dd752de16518 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -27,7 +27,10 @@ struct initramfs_test_cpio {
 	char *data;
 };
 
-static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
+#define CPIO_HDR_FMT "%s%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%s"
+
+static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *fmt,
+			char *out)
 {
 	int i;
 	size_t off = 0;
@@ -38,9 +41,7 @@ static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
 		size_t thislen;
 
 		/* +1 to account for nulterm */
-		thislen = sprintf(pos, "%s"
-			"%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x"
-			"%s",
+		thislen = sprintf(pos, fmt,
 			c->magic, c->ino, c->mode, c->uid, c->gid, c->nlink,
 			c->mtime, c->filesize, c->devmajor, c->devminor,
 			c->rdevmajor, c->rdevminor, c->namesize, c->csum,
@@ -102,7 +103,7 @@ static void __init initramfs_test_extract(struct kunit *test)
 	/* +3 to cater for any 4-byte end-alignment */
 	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
 			      GFP_KERNEL);
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	ktime_get_real_ts64(&ts_before);
 	err = unpack_to_rootfs(cpio_srcbuf, len);
@@ -177,7 +178,7 @@ static void __init initramfs_test_fname_overrun(struct kunit *test)
 	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
 	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 	/* overwrite trailing fname terminator and padding */
 	suffix_off = len - 1;
 	while (cpio_srcbuf[suffix_off] == '\0') {
@@ -219,7 +220,7 @@ static void __init initramfs_test_data(struct kunit *test)
 	cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
 			      GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -274,7 +275,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -284,7 +285,7 @@ static void __init initramfs_test_csum(struct kunit *test)
 
 	/* mess up the csum and confirm that unpack fails */
 	c[0].csum--;
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NOT_NULL(test, err);
@@ -330,7 +331,7 @@ static void __init initramfs_test_hardlink(struct kunit *test)
 
 	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
 
-	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, cpio_srcbuf);
 
 	err = unpack_to_rootfs(cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -371,7 +372,7 @@ static void __init initramfs_test_many(struct kunit *test)
 		};
 
 		c.namesize = 1 + sprintf(thispath, "initramfs_test_many-%d", i);
-		p += fill_cpio(&c, 1, p);
+		p += fill_cpio(&c, 1, CPIO_HDR_FMT, p);
 	}
 
 	len = p - cpio_srcbuf;
@@ -425,7 +426,7 @@ static void __init initramfs_test_fname_pad(struct kunit *test)
 	} };
 
 	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_srcbuf);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, tbufs->cpio_srcbuf);
 
 	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
 	KUNIT_EXPECT_NULL(test, err);
@@ -481,7 +482,7 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	memcpy(tbufs->fname_oversize, "fname_oversize",
 	       sizeof("fname_oversize") - 1);
 	memcpy(tbufs->fname_ok, "fname_ok", sizeof("fname_ok") - 1);
-	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_src);
+	len = fill_cpio(c, ARRAY_SIZE(c), CPIO_HDR_FMT, tbufs->cpio_src);
 
 	/* unpack skips over fname_oversize instead of returning an error */
 	err = unpack_to_rootfs(tbufs->cpio_src, len);
-- 
2.51.0


