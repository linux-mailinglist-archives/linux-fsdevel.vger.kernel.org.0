Return-Path: <linux-fsdevel+bounces-33603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D138E9BB763
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0181C2378E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00331AC42C;
	Mon,  4 Nov 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jn0cb5T9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ibpXTAEY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feZrq9w7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WORYPS3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F67146A69
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729894; cv=none; b=Cb9CwH1YrsMxeGhKAHXTP5Y3HZqXR/vodIbTeavdSRjsn1wZtj2NAGVgzvkduq6KFUq1Y+OJSwkDD8bmaHNLggA0fP768eu9GP/t0G8Ga+oLmaQALzaVMP3hhSKjG97wjo0bnkendxMr3+YOEMjfcVwAp9WE2suwpH+IeTlzBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729894; c=relaxed/simple;
	bh=lKQlXiydO0FLDHkQB1DCagrT+rmVw8YztNz+LzA4Dm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNmjCq3tVfr4kFZpJ2jXwWj8UsnPYbuQAkAQEeXfh472WWgG5jD+HHqh68SDIBVxGxVbrBBYdszB2ZuNs2tTB+vm6gfnuFwT/YoYRF+A6eGb5oHamOlT+XjKjIYLQbCDDQeFR6breMRTR8be6UlAlAct8eCzqldBAhGF1gau8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jn0cb5T9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ibpXTAEY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feZrq9w7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WORYPS3x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0214E1FF37;
	Mon,  4 Nov 2024 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSCi8/GW+GEkFb6RqicIMkk6MWZaHKPmhp39ORJxyS8=;
	b=jn0cb5T9cN8k6jbiFZGh4HVPxN3iH37dDQpjo4Y1F9d0NOGNt+W+xxVZJYJEWfSeuEIBCK
	CPDrL33qPMTTxhMiCgs/y9uQhMkd9f/TseonBePyLvKorYqtqAViCF35cE5HC08mt6wSJg
	pIQ624Him/RGdZ41E9yKNbAUl+Lokhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSCi8/GW+GEkFb6RqicIMkk6MWZaHKPmhp39ORJxyS8=;
	b=ibpXTAEYLddrgos7fK+BmRfw/hmFaIHd00cWomoWfWu3mqOHb9q/iiSOKP+6dejSr8i4gt
	16TPJxDbca8uZsCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=feZrq9w7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WORYPS3x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSCi8/GW+GEkFb6RqicIMkk6MWZaHKPmhp39ORJxyS8=;
	b=feZrq9w7xJQAckNJUdhy40E2ZqB0nowxvAcDP2NwoC7NP6XSX/E8sIp5xBcJ+Y4OJ6n3vk
	+PjOAEAuJuU0vNsOhxGCEmZelvtdBdF2JX1PGVDCUoOwgtc0xgvP/ppV2cxqF62q/jpKFI
	9+1rfX54tOjgKr049LBozE3+57AzB3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSCi8/GW+GEkFb6RqicIMkk6MWZaHKPmhp39ORJxyS8=;
	b=WORYPS3x/rlM9CgD70m5oBz/w+2oe6za1wfScEfD5dMsJ2Cqax2kUSk2Q6i/ICkrjCq03i
	TZ85ursw7SC3S7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3028E13736;
	Mon,  4 Nov 2024 14:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aNidNZ7XKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:06 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/9] initramfs_test: kunit tests for initramfs unpacking
Date: Tue,  5 Nov 2024 01:14:41 +1100
Message-ID: <20241104141750.16119-3-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104141750.16119-1-ddiss@suse.de>
References: <20241104141750.16119-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0214E1FF37
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Provide some basic initramfs unpack sanity tests covering:
- simple file / dir extraction
- filename field overrun, as reported and fixed separately via
  https://lore.kernel.org/r/20241030035509.20194-2-ddiss@suse.de
- "070702" cpio data checksums
- hardlinks

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/.kunitconfig     |   3 +
 init/Kconfig          |   7 +
 init/Makefile         |   1 +
 init/initramfs_test.c | 393 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 404 insertions(+)
 create mode 100644 init/.kunitconfig
 create mode 100644 init/initramfs_test.c

diff --git a/init/.kunitconfig b/init/.kunitconfig
new file mode 100644
index 0000000000000..acb906b1a5f98
--- /dev/null
+++ b/init/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_TEST=y
diff --git a/init/Kconfig b/init/Kconfig
index c521e1421ad4a..cf8327cdd6739 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1431,6 +1431,13 @@ config INITRAMFS_PRESERVE_MTIME
 
 	  If unsure, say Y.
 
+config INITRAMFS_TEST
+	bool "Test initramfs cpio archive extraction" if !KUNIT_ALL_TESTS
+	depends on BLK_DEV_INITRD && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Build KUnit tests for initramfs. See Documentation/dev-tools/kunit
+
 choice
 	prompt "Compiler optimization level"
 	default CC_OPTIMIZE_FOR_PERFORMANCE
diff --git a/init/Makefile b/init/Makefile
index 10b652d33e872..d6f75d8907e09 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -12,6 +12,7 @@ else
 obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
 endif
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
+obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
 
 obj-y                          += init_task.o
 
diff --git a/init/initramfs_test.c b/init/initramfs_test.c
new file mode 100644
index 0000000000000..2f64e7bf0a1c2
--- /dev/null
+++ b/init/initramfs_test.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/file.h>
+#include <linux/init_syscalls.h>
+#include <linux/stringify.h>
+#include "initramfs_internal.h"
+
+struct initramfs_test_cpio {
+	char *magic;
+	unsigned int ino;
+	unsigned int mode;
+	unsigned int uid;
+	unsigned int gid;
+	unsigned int nlink;
+	unsigned int mtime;
+	unsigned int filesize;
+	unsigned int devmajor;
+	unsigned int devminor;
+	unsigned int rdevmajor;
+	unsigned int rdevminor;
+	unsigned int namesize;
+	unsigned int csum;
+	char *fname;
+	char *data;
+};
+
+static size_t fill_cpio(struct initramfs_test_cpio *cs, size_t csz, char *out)
+{
+	int i;
+	size_t off = 0;
+
+	for (i = 0; i < csz; i++) {
+		char *pos = &out[off];
+		struct initramfs_test_cpio *c = &cs[i];
+		size_t thislen;
+
+		/* +1 to account for nulterm */
+		thislen = sprintf(pos, "%s"
+			"%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x"
+			"%s",
+			c->magic, c->ino, c->mode, c->uid, c->gid, c->nlink,
+			c->mtime, c->filesize, c->devmajor, c->devminor,
+			c->rdevmajor, c->rdevminor, c->namesize, c->csum,
+			c->fname) + 1;
+		pr_debug("packing (%zu): %.*s\n", thislen, (int)thislen, pos);
+		off += thislen;
+		while (off & 3)
+			out[off++] = '\0';
+
+		memcpy(&out[off], c->data, c->filesize);
+		off += c->filesize;
+		while (off & 3)
+			out[off++] = '\0';
+	}
+
+	return off;
+}
+
+static void __init initramfs_test_extract(struct kunit *test)
+{
+	char *err, *cpio_srcbuf;
+	size_t len;
+	struct kstat st = {};
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.uid = 12,
+		.gid = 34,
+		.nlink = 1,
+		.mtime = 56,
+		.filesize = 0,
+		.devmajor = 0,
+		.devminor = 1,
+		.rdevmajor = 0,
+		.rdevminor = 0,
+		.namesize = sizeof("initramfs_test_extract"),
+		.csum = 0,
+		.fname = "initramfs_test_extract",
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFDIR | 0777,
+		.nlink = 1,
+		.mtime = 57,
+		.devminor = 1,
+		.namesize = sizeof("initramfs_test_extract_dir"),
+		.fname = "initramfs_test_extract_dir",
+	}, {
+		.magic = "070701",
+		.namesize = sizeof("TRAILER!!!"),
+		.fname = "TRAILER!!!",
+	} };
+
+	/* +3 to cater for any 4-byte end-alignment */
+	cpio_srcbuf = kzalloc(ARRAY_SIZE(c) * (CPIO_HDRLEN + PATH_MAX + 3),
+			      GFP_KERNEL);
+	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	if (err) {
+		KUNIT_FAIL(test, "unpack failed %s", err);
+		goto out;
+	}
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISREG(st.mode));
+	KUNIT_EXPECT_TRUE(test, uid_eq(st.uid, KUIDT_INIT(c[0].uid)));
+	KUNIT_EXPECT_TRUE(test, gid_eq(st.gid, KGIDT_INIT(c[0].gid)));
+	KUNIT_EXPECT_EQ(test, st.nlink, 1);
+	KUNIT_EXPECT_EQ(test, st.mtime.tv_sec,
+		IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME) ? c[0].mtime : 0);
+	KUNIT_EXPECT_EQ(test, st.blocks, c[0].filesize);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
+	KUNIT_EXPECT_EQ(test, st.mtime.tv_sec,
+		IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME) ? c[1].mtime : 0);
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+out:
+	kfree(cpio_srcbuf);
+}
+
+/*
+ * Don't terminate filename. Previously, the cpio filename field was passed
+ * directly to filp_open(collected, O_CREAT|..) without nulterm checks. See
+ * https://lore.kernel.org/linux-fsdevel/20241030035509.20194-2-ddiss@suse.de
+ */
+static void __init initramfs_test_fname_overrun(struct kunit *test)
+{
+	char *err, *cpio_srcbuf;
+	size_t len, suffix_off;
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
+		.namesize = sizeof("initramfs_test_fname_overrun"),
+		.csum = 0,
+		.fname = "initramfs_test_fname_overrun",
+	} };
+
+	/*
+	 * poison cpio source buffer, so we can detect overrun. source
+	 * buffer is used by read_into() when hdr or fname
+	 * are already available (e.g. no compression).
+	 */
+	cpio_srcbuf = kmalloc(CPIO_HDRLEN + PATH_MAX + 3, GFP_KERNEL);
+	memset(cpio_srcbuf, 'B', CPIO_HDRLEN + PATH_MAX + 3);
+	/* limit overrun to avoid crashes / filp_open() ENAMETOOLONG */
+	cpio_srcbuf[CPIO_HDRLEN + strlen(c[0].fname) + 20] = '\0';
+
+	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+	/* overwrite trailing fname terminator and padding */
+	suffix_off = len - 1;
+	while (cpio_srcbuf[suffix_off] == '\0') {
+		cpio_srcbuf[suffix_off] = 'P';
+		suffix_off--;
+	}
+
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NOT_NULL(test, err);
+
+	kfree(cpio_srcbuf);
+}
+
+static void __init initramfs_test_data(struct kunit *test)
+{
+	char *err, *cpio_srcbuf;
+	size_t len;
+	struct file *file;
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.uid = 0,
+		.gid = 0,
+		.nlink = 1,
+		.mtime = 1,
+		.filesize = sizeof("ASDF") - 1,
+		.devmajor = 0,
+		.devminor = 1,
+		.rdevmajor = 0,
+		.rdevminor = 0,
+		.namesize = sizeof("initramfs_test_data"),
+		.csum = 0,
+		.fname = "initramfs_test_data",
+		.data = "ASDF",
+	} };
+
+	/* +6 for max name and data 4-byte padding */
+	cpio_srcbuf = kmalloc(CPIO_HDRLEN + c[0].namesize + c[0].filesize + 6,
+			      GFP_KERNEL);
+
+	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	file = filp_open(c[0].fname, O_RDONLY, 0);
+	if (!file) {
+		KUNIT_FAIL(test, "open failed");
+		goto out;
+	}
+
+	/* read back file contents into @cpio_srcbuf and confirm match */
+	len = kernel_read(file, cpio_srcbuf, c[0].filesize, NULL);
+	KUNIT_EXPECT_EQ(test, len, c[0].filesize);
+	KUNIT_EXPECT_MEMEQ(test, cpio_srcbuf, c[0].data, len);
+
+	fput(file);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+out:
+	kfree(cpio_srcbuf);
+}
+
+static void __init initramfs_test_csum(struct kunit *test)
+{
+	char *err, *cpio_srcbuf;
+	size_t len;
+	struct initramfs_test_cpio c[] = { {
+		/* 070702 magic indicates a valid csum is present */
+		.magic = "070702",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.nlink = 1,
+		.filesize = sizeof("ASDF") - 1,
+		.devminor = 1,
+		.namesize = sizeof("initramfs_test_csum"),
+		.csum = 'A' + 'S' + 'D' + 'F',
+		.fname = "initramfs_test_csum",
+		.data = "ASDF",
+	}, {
+		/* mix csum entry above with no-csum entry below */
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFREG | 0777,
+		.nlink = 1,
+		.filesize = sizeof("ASDF") - 1,
+		.devminor = 1,
+		.namesize = sizeof("initramfs_test_csum_not_here"),
+		/* csum ignored */
+		.csum = 5555,
+		.fname = "initramfs_test_csum_not_here",
+		.data = "ASDF",
+	} };
+
+	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
+
+	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
+
+	/* mess up the csum and confirm that unpack fails */
+	c[0].csum--;
+	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NOT_NULL(test, err);
+
+	/*
+	 * file (with content) is still retained in case of bad-csum abort.
+	 * Perhaps we should change this.
+	 */
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), -ENOENT);
+	kfree(cpio_srcbuf);
+}
+
+static void __init initramfs_test_hardlink(struct kunit *test)
+{
+	char *err, *cpio_srcbuf;
+	size_t len;
+	struct kstat st0, st1;
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.nlink = 2,
+		.devminor = 1,
+		.namesize = sizeof("initramfs_test_hardlink"),
+		.fname = "initramfs_test_hardlink",
+	}, {
+		/* hardlink data is present in last archive entry */
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.nlink = 2,
+		.filesize = sizeof("ASDF") - 1,
+		.devminor = 1,
+		.namesize = sizeof("initramfs_test_hardlink_link"),
+		.fname = "initramfs_test_hardlink_link",
+		.data = "ASDF",
+	}, {
+		/* hardlink hashtable leaks when the archive omits a trailer */
+		.magic = "070701",
+		.namesize = sizeof("TRAILER!!!"),
+		.fname = "TRAILER!!!",
+	} };
+
+	cpio_srcbuf = kmalloc(8192, GFP_KERNEL);
+
+	len = fill_cpio(c, ARRAY_SIZE(c), cpio_srcbuf);
+
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
+	KUNIT_EXPECT_EQ(test, st0.ino, st1.ino);
+	KUNIT_EXPECT_EQ(test, st0.nlink, 2);
+	KUNIT_EXPECT_EQ(test, st1.nlink, 2);
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_unlink(c[1].fname), 0);
+
+	kfree(cpio_srcbuf);
+}
+
+#define INITRAMFS_TEST_MANY_LIMIT 1000
+#define INITRAMFS_TEST_MANY_PATH_MAX (sizeof("initramfs_test_many-") \
+			+ sizeof(__stringify(INITRAMFS_TEST_MANY_LIMIT)))
+static void __init initramfs_test_many(struct kunit *test)
+{
+	char *err, *cpio_srcbuf, *p;
+	size_t len = INITRAMFS_TEST_MANY_LIMIT *
+		     (CPIO_HDRLEN + INITRAMFS_TEST_MANY_PATH_MAX + 3);
+	char thispath[INITRAMFS_TEST_MANY_PATH_MAX];
+	int i;
+
+	p = cpio_srcbuf = kmalloc(len, GFP_KERNEL);
+
+	for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
+		struct initramfs_test_cpio c = {
+			.magic = "070701",
+			.ino = i,
+			.mode = S_IFREG | 0777,
+			.nlink = 1,
+			.devminor = 1,
+			.fname = thispath,
+		};
+
+		c.namesize = 1 + sprintf(thispath, "initramfs_test_many-%d", i);
+		p += fill_cpio(&c, 1, p);
+	}
+
+	len = p - cpio_srcbuf;
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	for (i = 0; i < INITRAMFS_TEST_MANY_LIMIT; i++) {
+		sprintf(thispath, "initramfs_test_many-%d", i);
+		KUNIT_EXPECT_EQ(test, init_unlink(thispath), 0);
+	}
+
+	kfree(cpio_srcbuf);
+}
+
+/*
+ * The kunit_case/_suite struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run.
+ */
+static struct kunit_case initramfs_test_cases[] = {
+	KUNIT_CASE(initramfs_test_extract),
+	KUNIT_CASE(initramfs_test_fname_overrun),
+	KUNIT_CASE(initramfs_test_data),
+	KUNIT_CASE(initramfs_test_csum),
+	KUNIT_CASE(initramfs_test_hardlink),
+	KUNIT_CASE(initramfs_test_many),
+	{},
+};
+
+static struct kunit_suite initramfs_test_suite = {
+	.name = "initramfs",
+	.test_cases = initramfs_test_cases,
+};
+kunit_test_init_section_suites(&initramfs_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.43.0


