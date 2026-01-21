Return-Path: <linux-fsdevel+bounces-74887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIxKCzoqcWniewAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:34:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B55C433
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B87EAADB13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A638365A0A;
	Wed, 21 Jan 2026 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IM+AY6ex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s9XsXiSM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IM+AY6ex";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s9XsXiSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768347D950
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016498; cv=none; b=BiNrzbfn9EAZvLAVuMzleP5JUE2sG2aH1QfVhEBpNQ33PR2Kwe1oacwrjyVJgTYpZTAAb9DNF3bpJIEVP81Y44jzfyq9jrR3k3GZIHLFJPupYyW9yMpPftquOCZ9+NmjJGctZ/48APQRdtVz0FFChea/UL8P/0MdVl4tl4DgV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016498; c=relaxed/simple;
	bh=sj1Txjwv+h9/f1BV2GigzRSpv5V1zPSVxhMlFy1uowk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6vC0QRFmH4ojvnyPKtgNJM7GkaUGgaq+3/YzNkK2YjfERXD7YCg3PE9VDy/9/saKO53+L6j1yV7TJMUfGf2Q1zXrot0vt+0hJTvJPb4Z4V9EGFSEZY4WZzHu+7B3I1Gwsqxd2372bQ83Gl/ni8IpkC2DrOP4vsBRBntkEz8miM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IM+AY6ex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s9XsXiSM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IM+AY6ex; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s9XsXiSM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B0615BD56;
	Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gww8G95Lkyi7dxHXzjYxL/6q2jfnvHmXDxAx80rk+eI=;
	b=IM+AY6ex6zU2xt30HxFuvYEm36k5LS2UfYwdjf79iwu0wOFcY+YxRupl0RDMa5x/RIVGSr
	hJ54vWdwYrqZQcP63Xi2/sTatAR1izI1tEWgodbCA4MIocDymRcIRovkXqTaOZh2gbfIgI
	2wPq6PIYGmpFS5eGaFFjLacQqS+WFQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gww8G95Lkyi7dxHXzjYxL/6q2jfnvHmXDxAx80rk+eI=;
	b=s9XsXiSM2Vs2zzn/WvszXJlvUVcxPhkdIxOa+8B099zKe99nHj05aKJFm2yUgJKB0fAzIq
	QoB7K1hrmIekPgAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gww8G95Lkyi7dxHXzjYxL/6q2jfnvHmXDxAx80rk+eI=;
	b=IM+AY6ex6zU2xt30HxFuvYEm36k5LS2UfYwdjf79iwu0wOFcY+YxRupl0RDMa5x/RIVGSr
	hJ54vWdwYrqZQcP63Xi2/sTatAR1izI1tEWgodbCA4MIocDymRcIRovkXqTaOZh2gbfIgI
	2wPq6PIYGmpFS5eGaFFjLacQqS+WFQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gww8G95Lkyi7dxHXzjYxL/6q2jfnvHmXDxAx80rk+eI=;
	b=s9XsXiSM2Vs2zzn/WvszXJlvUVcxPhkdIxOa+8B099zKe99nHj05aKJFm2yUgJKB0fAzIq
	QoB7K1hrmIekPgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21D93EA63;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CN/dNZkMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 6/8] SQUASH initramfs_test: expect error for "0x" prefixed header
Date: Thu, 22 Jan 2026 04:12:54 +1100
Message-ID: <20260121172749.32322-7-ddiss@suse.de>
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
X-Spam-Score: -2.80
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
	TAGGED_FROM(0.00)[bounces-74887-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 6A6B55C433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 6845da7ecb67a..c0a66d0366e80 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -499,8 +499,7 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 {
 	char *err, *fmt;
 	size_t len;
-	struct kstat st0, st1;
-	char fdata[] = "this file data will be unpacked";
+	char fdata[] = "this file data will not be unpacked";
 	struct initramfs_test_bufs {
 		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
 	} *tbufs = kzalloc(sizeof(struct initramfs_test_bufs), GFP_KERNEL);
@@ -528,28 +527,14 @@ static void __init initramfs_test_hdr_hex(struct kunit *test)
 	/*
 	 * override CPIO_HDR_FMT and instead use a format string which places
 	 * "0x" prefixes on the uid, gid and namesize values.
-	 * parse_header()/simple_str[n]toul() accept this.
+	 * parse_header()/simple_str[n]toul() accepted this, contrary to the
+	 * initramfs specification. hex2bin() now fails.
 	 */
 	fmt = "%s%08x%08x0x%06x0X%06x%08x%08x%08x%08x%08x%08x%08x0x%06x%08x%s";
 	len = fill_cpio(c, ARRAY_SIZE(c), fmt, tbufs->cpio_src);
 
 	err = unpack_to_rootfs(tbufs->cpio_src, len);
-	KUNIT_EXPECT_NULL(test, err);
-
-	KUNIT_EXPECT_EQ(test, init_stat(c[0].fname, &st0, 0), 0);
-	KUNIT_EXPECT_EQ(test, init_stat(c[1].fname, &st1, 0), 0);
-
-	KUNIT_EXPECT_TRUE(test,
-		uid_eq(st0.uid, make_kuid(current_user_ns(), (uid_t)0x123456)));
-	KUNIT_EXPECT_TRUE(test,
-		gid_eq(st0.gid, make_kgid(current_user_ns(), (gid_t)0x123457)));
-	KUNIT_EXPECT_TRUE(test,
-		uid_eq(st1.uid, make_kuid(current_user_ns(), (uid_t)0x56)));
-	KUNIT_EXPECT_TRUE(test,
-		gid_eq(st1.gid, make_kgid(current_user_ns(), (gid_t)0x57)));
-
-	KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
-	KUNIT_EXPECT_EQ(test, init_rmdir(c[1].fname), 0);
+	KUNIT_EXPECT_NOT_NULL(test, err);
 
 	kfree(tbufs);
 }
-- 
2.51.0


