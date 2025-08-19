Return-Path: <linux-fsdevel+bounces-58244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8774B2B80D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1952561D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C502D660D;
	Tue, 19 Aug 2025 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KnkHt8KQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7A+CCoI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KnkHt8KQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t7A+CCoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB225784B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575442; cv=none; b=qwByBPdCizx5kGdsk7CG+MKNkdmkB4dP3OZqzEF1lU/NttS+l1B7HJYvfst1zsYilT0FiTKYwLiQczPjPoslgtNflkskWDOBrStYxefxCIROQMGegrsbj70WhKJeAm1mCyfzIBefO3EBUXMNSJvADj6qmkp7MLjEBs9y+MgNyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575442; c=relaxed/simple;
	bh=RW4wYWIJhtqqYYBC2aKHqMhZLuAZjsN8UUSvPoQSz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4IujogUe9k/tSY5nvt06nFQdl1z1xNqXuBD8kv12+pqAF3+1K07kOOS9ilGbBl8BhI/Bovhe/l/PcujU1KImaoOjKr5uqFngaiywd735FPOZcBwDcZddQ/GoHtZ2y9QYXJeho5WfGppf9O13RBm/p9BJTN2fZ+4sfa9mF6YDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KnkHt8KQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7A+CCoI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KnkHt8KQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t7A+CCoI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A51362125E;
	Tue, 19 Aug 2025 03:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uph1rJ9889A4PIBKKjZ919Kq1UXJobYp7az5TPK9/tQ=;
	b=KnkHt8KQlUCZfFoG6ZcTPRZ6a670UGyxtB0gniCgM4qD98po3RdR5dsRnJDA1Z8UPYF4Xs
	VbwIevOMcotk8raJzjtBr35MMpr/38WkleWkba2zyqe03qEsV2O5XxrC+bWzbJSjZRroI5
	HEPzg3znUbyBGzKXU8oFtE4bOjx3GVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uph1rJ9889A4PIBKKjZ919Kq1UXJobYp7az5TPK9/tQ=;
	b=t7A+CCoIua6h+10X01n5925lmUMreQBm7WG/Z8tpYnecUxFoggtBc9SS70ZZL1Zr5GSv23
	E5xSbEXGKm5HUvBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KnkHt8KQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t7A+CCoI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uph1rJ9889A4PIBKKjZ919Kq1UXJobYp7az5TPK9/tQ=;
	b=KnkHt8KQlUCZfFoG6ZcTPRZ6a670UGyxtB0gniCgM4qD98po3RdR5dsRnJDA1Z8UPYF4Xs
	VbwIevOMcotk8raJzjtBr35MMpr/38WkleWkba2zyqe03qEsV2O5XxrC+bWzbJSjZRroI5
	HEPzg3znUbyBGzKXU8oFtE4bOjx3GVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uph1rJ9889A4PIBKKjZ919Kq1UXJobYp7az5TPK9/tQ=;
	b=t7A+CCoIua6h+10X01n5925lmUMreQBm7WG/Z8tpYnecUxFoggtBc9SS70ZZL1Zr5GSv23
	E5xSbEXGKm5HUvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97EA813686;
	Tue, 19 Aug 2025 03:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yBHME3j0o2gJawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 03:50:16 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ddiss@suse.de,
	nsc@kernel.org
Subject: [PATCH v3 8/8] initramfs_test: add filename padding test case
Date: Tue, 19 Aug 2025 13:05:51 +1000
Message-ID: <20250819032607.28727-9-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819032607.28727-1-ddiss@suse.de>
References: <20250819032607.28727-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A51362125E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

Confirm that cpio filenames with multiple trailing zeros (accounted for
in namesize) extract successfully.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 68 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 517e5e04e5ccf..da16b012322b9 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -45,8 +45,11 @@ static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
 			c->mtime, c->filesize, c->devmajor, c->devminor,
 			c->rdevmajor, c->rdevminor, c->namesize, c->csum,
 			c->fname) + 1;
+
 		pr_debug("packing (%zu): %.*s\n", thislen, (int)thislen, pos);
-		off += thislen;
+		if (thislen != CPIO_HDRLEN + c->namesize)
+			pr_debug("padded to: %u\n", CPIO_HDRLEN + c->namesize);
+		off += CPIO_HDRLEN + c->namesize;
 		while (off & 3)
 			out[off++] = '\0';
 
@@ -383,6 +386,68 @@ static void __init initramfs_test_many(struct kunit *test)
 	kfree(cpio_srcbuf);
 }
 
+/*
+ * An initramfs filename is namesize in length, including the zero-terminator.
+ * A filename can be zero-terminated prior to namesize, with the remainder used
+ * as padding. This can be useful for e.g. alignment of file data segments with
+ * a 4KB filesystem block, allowing for extent sharing (reflinks) between cpio
+ * source and destination. This hack works with both GNU cpio and initramfs, as
+ * long as PATH_MAX isn't exceeded.
+ */
+static void __init initramfs_test_fname_pad(struct kunit *test)
+{
+	char *err;
+	size_t len;
+	struct file *file;
+	char fdata[] = "this file data is aligned at 4K in the archive";
+	struct test_fname_pad {
+		char padded_fname[4096 - CPIO_HDRLEN];
+		char cpio_srcbuf[CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)];
+	} *tbufs = kzalloc(sizeof(struct test_fname_pad), GFP_KERNEL);
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.uid = 0,
+		.gid = 0,
+		.nlink = 1,
+		.mtime = 1,
+		.filesize = 0,
+		.devmajor = 0,
+		.devminor = 1,
+		.rdevmajor = 0,
+		.rdevminor = 0,
+		/* align file data at 4K archive offset via padded fname */
+		.namesize = 4096 - CPIO_HDRLEN,
+		.csum = 0,
+		.fname = tbufs->padded_fname,
+		.data = fdata,
+		.filesize = sizeof(fdata),
+	} };
+
+	memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
+	len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_srcbuf);
+
+	err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	file = filp_open(c[0].fname, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		KUNIT_FAIL(test, "open failed");
+		goto out;
+	}
+
+	/* read back file contents into @cpio_srcbuf and confirm match */
+	len = kernel_read(file, tbufs->cpio_srcbuf, c[0].filesize, NULL);
+	KUNIT_EXPECT_EQ(test, len, c[0].filesize);
+	KUNIT_EXPECT_MEMEQ(test, tbufs->cpio_srcbuf, c[0].data, len);
+
+	fput(file);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+out:
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -394,6 +459,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_csum),
 	KUNIT_CASE(initramfs_test_hardlink),
 	KUNIT_CASE(initramfs_test_many),
+	KUNIT_CASE(initramfs_test_fname_pad),
 	{},
 };
 
-- 
2.43.0


