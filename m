Return-Path: <linux-fsdevel+bounces-74884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLneI6UicWkPegAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:01:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD345BBA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10984B4C525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A6478E24;
	Wed, 21 Jan 2026 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GQR809nW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FwUXB7lF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GQR809nW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FwUXB7lF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6241441045
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016485; cv=none; b=iijT6UYWppvGa5D7yCVMJEqbs4q8HKtbG6B+kmBSIrUycGmbXWR/v6yQ0pvjaQkyGumFMXs6ToS0Wj81n6BrV9GSbviEwQyvPLcF2SMfw3BnDu6tRh94LabCZCSctogdP8hb/CHQWH9AmABjgLvK0PLBAfCLCqMHpoPgYczj9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016485; c=relaxed/simple;
	bh=zyRfl3uzvFep35dDBMFDygyTAjf92bLNqA4ogtU8n3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhbLav1xXL+gpqG7f+MssyUVWfrXkInPjSMekcV/y/KF0LG7ZukGNV7Jk4lQy2HQvCwzy/ZmmvSy6yuidiLTjAkt7Bf+B5Ad3bV7urVHatSeyF+ZicVNOlmrWurYepw81wAlbeGG2QwrpBOQu2SIpw2DqeDtMYfHKcYybTnlCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GQR809nW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FwUXB7lF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GQR809nW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FwUXB7lF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77A28336EF;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=756Oy4juE9nm+HDZl7NeAuEPXRikSds0Tn+8kAVrVMk=;
	b=GQR809nWl4loNw0vUgof97IPHHR8vjfUhZnazWQO9bSEnqKskhG3jtRnHV0JX2vMVw5clP
	iofPtiuOPrXbGJ8vT5y8IISnNd7Z7gglHWDX+KcqjdRiqVYYbjOMHzEd/osZnJnDaHu1vC
	b0+Y8PXGS/f6q3aCMPBE5Y9in1W0kzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=756Oy4juE9nm+HDZl7NeAuEPXRikSds0Tn+8kAVrVMk=;
	b=FwUXB7lFrjf2f9BzWWTSqbsXB2AOVTGsw4bLZ23qMyPQxOhbaFZt6vO4cL9WSVsLVz2BUE
	ggbEDBjdiiHkZaBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=756Oy4juE9nm+HDZl7NeAuEPXRikSds0Tn+8kAVrVMk=;
	b=GQR809nWl4loNw0vUgof97IPHHR8vjfUhZnazWQO9bSEnqKskhG3jtRnHV0JX2vMVw5clP
	iofPtiuOPrXbGJ8vT5y8IISnNd7Z7gglHWDX+KcqjdRiqVYYbjOMHzEd/osZnJnDaHu1vC
	b0+Y8PXGS/f6q3aCMPBE5Y9in1W0kzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=756Oy4juE9nm+HDZl7NeAuEPXRikSds0Tn+8kAVrVMk=;
	b=FwUXB7lFrjf2f9BzWWTSqbsXB2AOVTGsw4bLZ23qMyPQxOhbaFZt6vO4cL9WSVsLVz2BUE
	ggbEDBjdiiHkZaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50E1C3EA66;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAxhEpkMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/8] initramfs: Sort headers alphabetically
Date: Thu, 22 Jan 2026 04:12:51 +1100
Message-ID: <20260121172749.32322-4-ddiss@suse.de>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74884-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-fsdevel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1FD345BBA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6ddbfb17fb8f1..750f126e19a05 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,25 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
 #include <linux/async.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
 #include <linux/delay.h>
-#include <linux/string.h>
 #include <linux/dirent.h>
-#include <linux/syscalls.h>
-#include <linux/utime.h>
+#include <linux/export.h>
+#include <linux/fcntl.h>
 #include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
-#include <linux/init_syscalls.h>
-#include <linux/umh.h>
-#include <linux/security.h>
 #include <linux/overflow.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/umh.h>
+#include <linux/utime.h>
 
 #include "do_mounts.h"
 #include "initramfs_internal.h"
-- 
2.51.0


