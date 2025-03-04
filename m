Return-Path: <linux-fsdevel+bounces-43039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80E4A4D37B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A41172FAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203A1F4735;
	Tue,  4 Mar 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2MHABOUD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fdYSsdlE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2MHABOUD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fdYSsdlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F451F416B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068655; cv=none; b=sWI8h+9Hx/VAPlRZiB4kBq4J49Xg4R0xHZbr9CzybM/uSRuFMUWFC3rXzKj8/LJMMn1Fu/+shHtgrAp1sPSHmiVWLwprwj2lrKTFm7W/SiDCgiKiQWefuJKje0+i1bWQKAj/dijkDcnlWx+mxzvAf3UoM9XCBnEXOsjlb2WgAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068655; c=relaxed/simple;
	bh=BBxCyeVGRvsfYdQkQmP91qqvswmcQkuWdgruNq3YUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnvnT29drlQnyPy7KOK3ILMJOExKPYA6VHnxZzugdLoFhkxiiBiQrRK9I5uibI1NO+F737QKbWWEAvSEA8u2lLqtr4iKK8JRZSTlxEnByeSReH1m0FlJH6KMV8ulI5gXIYlKu9LrE6kphy2PxPr4mKxv2jFqwZzfSOBUukKx+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2MHABOUD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fdYSsdlE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2MHABOUD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fdYSsdlE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3DE01F387;
	Tue,  4 Mar 2025 06:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqMfjFtv9nVFxvCeAQ3yOna3votNNdrRaYMBGUXGM2Q=;
	b=2MHABOUDP+duapfS+TrR9Htipvmkb5pf9cf8jlyDDhqzbo1dmtBbYecFoSe/RFTM9SBLD9
	KvtxeDYi1KJpF4z76AeLOvNRPJHfVQBnNQ+HoaCB5IVvXJdcJ0FQkjicQrExD+onIR46ch
	5oRedI0qmVmZsMNHxYjdyFbR/IH7Dm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqMfjFtv9nVFxvCeAQ3yOna3votNNdrRaYMBGUXGM2Q=;
	b=fdYSsdlEhgUGqR4DH5z1dE5PWMIiJeX2VCG2xYyzJUcnuX0qLn5hxwfrdGODTmUPvEJTuE
	fqM2PaZxzwzZqIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqMfjFtv9nVFxvCeAQ3yOna3votNNdrRaYMBGUXGM2Q=;
	b=2MHABOUDP+duapfS+TrR9Htipvmkb5pf9cf8jlyDDhqzbo1dmtBbYecFoSe/RFTM9SBLD9
	KvtxeDYi1KJpF4z76AeLOvNRPJHfVQBnNQ+HoaCB5IVvXJdcJ0FQkjicQrExD+onIR46ch
	5oRedI0qmVmZsMNHxYjdyFbR/IH7Dm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqMfjFtv9nVFxvCeAQ3yOna3votNNdrRaYMBGUXGM2Q=;
	b=fdYSsdlEhgUGqR4DH5z1dE5PWMIiJeX2VCG2xYyzJUcnuX0qLn5hxwfrdGODTmUPvEJTuE
	fqM2PaZxzwzZqIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEC281393C;
	Tue,  4 Mar 2025 06:10:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FeDHVyZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:36 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 2/8] initramfs_test: kunit tests for initramfs unpacking
Date: Tue,  4 Mar 2025 16:57:45 +1100
Message-ID: <20250304061020.9815-3-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304061020.9815-1-ddiss@suse.de>
References: <20250304061020.9815-1-ddiss@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Provide some basic initramfs unpack sanity tests covering:
- simple file / dir extraction
- filename field overrun, as reported and fixed separately via
  https://lore.kernel.org/r/20241030035509.20194-2-ddiss@suse.de
- "070702" cpio data checksums
- hardlinks

These tests introduce new modpost warnings for initramfs_test_cases
section=.data -> section=.init.text run_case() hooks. The
kunit_case/_suite struct cannot be marked as __initdata as this
will be used in debugfs to retrieve results after a test has run.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/.kunitconfig     |   3 +
 init/Kconfig          |   7 +
 init/Makefile         |   1 +
 init/initramfs_test.c | 407 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 418 insertions(+)
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
index d0d021b3fa3b3..ded64f6c949ed 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1454,6 +1454,13 @@ config INITRAMFS_PRESERVE_MTIME
 
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
index 0000000000000..6231fe0125831
--- /dev/null
+++ b/init/initramfs_test.c
@@ -0,0 +1,407 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <linux/fcntl.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init_syscalls.h>
+#include <linux/stringify.h>
+#include <linux/timekeeping.h>
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
+	struct timespec64 ts_before, ts_after;
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
+	ktime_get_real_ts64(&ts_before);
+	err = unpack_to_rootfs(cpio_srcbuf, len);
+	ktime_get_real_ts64(&ts_after);
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
+	if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
+		KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[0].mtime);
+	} else {
+		KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
+		KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
+	}
+	KUNIT_EXPECT_EQ(test, st.blocks, c[0].filesize);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st, 0), 0);
+	KUNIT_EXPECT_TRUE(test, S_ISDIR(st.mode));
+	if (IS_ENABLED(CONFIG_INITRAMFS_PRESERVE_MTIME)) {
+		KUNIT_EXPECT_EQ(test, st.mtime.tv_sec, c[1].mtime);
+	} else {
+		KUNIT_EXPECT_GE(test, st.mtime.tv_sec, ts_before.tv_sec);
+		KUNIT_EXPECT_LE(test, st.mtime.tv_sec, ts_after.tv_sec);
+	}
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
+/*
+ * hardlink hashtable may leak when the archive omits a trailer:
+ * https://lore.kernel.org/r/20241107002044.16477-10-ddiss@suse.de/
+ */
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
+MODULE_DESCRIPTION("Initramfs KUnit test suite");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0


