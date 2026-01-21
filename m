Return-Path: <linux-fsdevel+bounces-74882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEnmINIScWlEcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:54:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB9A5ACD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 18:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD8B0DE5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E16A1FAC42;
	Wed, 21 Jan 2026 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fV9WrCwD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GMH7W1lz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fV9WrCwD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GMH7W1lz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EB31987D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016477; cv=none; b=Cf89ZwuDQgjPb1Exc7f491hGIpRZcQ+AMf5glj5DMIt5imODBbN4utHxEOURNZbUS8cniO8y3IDVBxJmlT1HSujMEHiI0WCxhCS/DwOBGlDgjqKzQLPRVgrs9oaQjEsc4jnEyOw0sN7mC9zu2x8CgUIhA5J2eKoMNPG38tSSqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016477; c=relaxed/simple;
	bh=zLcarTEzAJgPmUPq7wqcluiAvqYXwXt2NcGyUHb/cf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHTre0AT9NA9/mfg/39kTkXxvyPE+FFnP0fdeK7jdr+Ybm9SChqwoRbXVYP0qbjdQof6piVbDpPaIf9eCjMDnKo22oZvOxiKR1NF8z9qRTTMMJT8DvFTwjI5XOJy31J7Qn8p/AZE6Kxoyo1ZsgVKGJr1fQaHqpBho58J20rx+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fV9WrCwD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GMH7W1lz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fV9WrCwD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GMH7W1lz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BC42336EE;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW0cU+d/5V/D109wjrcVgTiJRCl3fWqu6+fZZdPYz6s=;
	b=fV9WrCwDV+NrvZWxjtLbSF8KeKv6pEp34gAC3wdDw6+zwBdiwOzH8JQ5lZ7qWbN0+0/S1O
	ACIbC249G/jAl11C/alGhUPBQPv/LSasQzJ1Xo2qqKKsh9Mrqg3AWTwttVyL2BPHGDP4/v
	5QqE3A0bwE4nSOfTSv90hCzFQ9rSJ8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW0cU+d/5V/D109wjrcVgTiJRCl3fWqu6+fZZdPYz6s=;
	b=GMH7W1lz1QXwdJP1vHj5deUZQButmDQmeOJSwFDgjJ7PNkBC032FH7CYDASS/AQOAX4sCR
	EOt0pMKRfZWrVECA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fV9WrCwD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GMH7W1lz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW0cU+d/5V/D109wjrcVgTiJRCl3fWqu6+fZZdPYz6s=;
	b=fV9WrCwDV+NrvZWxjtLbSF8KeKv6pEp34gAC3wdDw6+zwBdiwOzH8JQ5lZ7qWbN0+0/S1O
	ACIbC249G/jAl11C/alGhUPBQPv/LSasQzJ1Xo2qqKKsh9Mrqg3AWTwttVyL2BPHGDP4/v
	5QqE3A0bwE4nSOfTSv90hCzFQ9rSJ8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW0cU+d/5V/D109wjrcVgTiJRCl3fWqu6+fZZdPYz6s=;
	b=GMH7W1lz1QXwdJP1vHj5deUZQButmDQmeOJSwFDgjJ7PNkBC032FH7CYDASS/AQOAX4sCR
	EOt0pMKRfZWrVECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C0D23EA63;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GDdqBZkMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 2/8] initramfs_test: test header fields with 0x hex prefix
Date: Thu, 22 Jan 2026 04:12:50 +1100
Message-ID: <20260121172749.32322-3-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121172749.32322-1-ddiss@suse.de>
References: <20260121172749.32322-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-74882-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EEB9A5ACD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cpio header fields are 8-byte hex strings, but one "interesting"
side-effect of our historic simple_str[n]toul() use means that a "0x"
(or "0X") prefixed header field will be successfully processed when
coupled alongside a 6-byte hex remainder string.

"0x" prefix support is contrary to the initramfs specification at
Documentation/driver-api/early-userspace/buffer-format.rst which states:

  The structure of the cpio_header is as follows (all fields contain
  hexadecimal ASCII numbers fully padded with '0' on the left to the
  full width of the field, for example, the integer 4780 is represented
  by the ASCII string "000012ac"):

Test for this corner case by injecting "0x" prefixes into the uid, gid
and namesize cpio header fields. Confirm that init_stat() returns
matching uid and gid values.

This test can be modified in future to expect unpack_to_rootfs() failure
when header validation is changed to properly follow the specification.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 8dd752de16518..6845da7ecb67a 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -495,6 +495,65 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	kfree(tbufs);
 }
 
+static void __init initramfs_test_hdr_hex(struct kunit *test)
+{
+	char *err, *fmt;
+	size_t len;
+	struct kstat st0, st1;
+	char fdata[] = "this file data will be unpacked";
+	struct initramfs_test_bufs {
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
+	} *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
+	struct initramfs_test_cpio c[] = { {
+		.magic = "070701",
+		.ino = 1,
+		.mode = S_IFREG | 0777,
+		.uid = 0x123456,
+		.gid = 0x123457,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_hdr_hex_0"),
+		.fname = "initramfs_test_hdr_hex_0",
+		.filesize = sizeof(fdata),
+		.data = fdata,
+	}, {
+		.magic = "070701",
+		.ino = 2,
+		.mode = S_IFDIR | 0777,
+		.uid = 0x000056,
+		.gid = 0x000057,
+		.nlink = 1,
+		.namesize = sizeof("initramfs_test_hdr_hex_1"),
+		.fname = "initramfs_test_hdr_hex_1",
+	} };
+	/*
+	 * override CPIO_HDR_FMT and instead use a format string which places
+	 * "0x" prefixes on the uid, gid and namesize values.
+	 * parse_header()/simple_str[n]toul() accept this.
+	 */
+	fmt = "%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s";
+	len = fill_cpio(c, ARRAY_SIZE(c), fmt, tbufs->cpio_src);
+
+	err = unpack_to_rootfs(tbufs->cpio_src, len);
+	KUNIT_EXPECT_NULL(test, err);
+
+	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
+	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
+
+	KUNIT_EXPECT_TRUE(test,
+		uid_eq(st0.uid, make_kuid(current_user_ns(), (uid_t)0x123456)));
+	KUNIT_EXPECT_TRUE(test,
+		gid_eq(st0.gid, make_kgid(current_user_ns(), (gid_t)0x123457)));
+	KUNIT_EXPECT_TRUE(test,
+		uid_eq(st1.uid, make_kuid(current_user_ns(), (uid_t)0x56)));
+	KUNIT_EXPECT_TRUE(test,
+		gid_eq(st1.gid, make_kgid(current_user_ns(), (gid_t)0x57)));
+
+	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
+	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+
+	kfree(tbufs);
+}
+
 /*
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
@@ -508,6 +567,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
 	KUNIT_CASE(initramfs_test_many),
 	KUNIT_CASE(initramfs_test_fname_pad),
 	KUNIT_CASE(initramfs_test_fname_path_max),
+	KUNIT_CASE(initramfs_test_hdr_hex),
 	{},
 };
 
-- 
2.51.0


