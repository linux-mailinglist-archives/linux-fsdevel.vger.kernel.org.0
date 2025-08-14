Return-Path: <linux-fsdevel+bounces-57837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9024FB25B33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBDE9A2848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05CE230BD2;
	Thu, 14 Aug 2025 05:49:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FC2264A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150544; cv=none; b=aHw6jxHWt3RKXjNuyHkdJhkaDKnpjDLmAhCJhAITWhE1cP7nYYAMX6sLbmIKAY9zbqQFOix9ByZgkbdgtag1ixHSdl05nXZCXcUXXuCw8hRhTYJgt9an+fjiQlUKGnSMcnlKc5sgCaKYwYGIpwKA8TPBATbAAF88EflmKXt5zGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150544; c=relaxed/simple;
	bh=HGi17eMVCpQMU0BXMWpfsRRH5sM6D7CsU7NRp6Qh8IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrwTd8m3DQi9TPyduF+emVxAf/TiV5+bptCIYdLzX/41GCXMoYP79MNBY+4m4G65R5M23vLEnM1F6poAQfnNu8yaELFnmOky65a3KRb1wQOrY0f3TxdeSKXK+Oc/v35OHOZeupgaPj0YjhVRVTQbl8+X+ZCTLke/uUdpmgBTZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D2631F7C7;
	Thu, 14 Aug 2025 05:48:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C6513479;
	Thu, 14 Aug 2025 05:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YFyxHrx4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:44 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 3/7] gen_init_cpio: attempt copy_file_range for file data
Date: Thu, 14 Aug 2025 15:18:01 +1000
Message-ID: <20250814054818.7266-4-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814054818.7266-1-ddiss@suse.de>
References: <20250814054818.7266-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7D2631F7C7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

The copy_file_range syscall can improve copy performance by cloning
extents between cpio archive source and destination files.
Existing read / write based copy logic is retained for fallback in case
the copy_file_range syscall is unsupported or unavailable due to
cross-filesystem EXDEV, etc.

Clone or reflink, as opposed to copy, of source file extents into the
output cpio archive may (e.g. on Btrfs and XFS) require alignment of the
output to the filesystem block size. This could be achieved by inserting
padding entries into the cpio archive manifest.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 563594a0662a6..64421d410a88b 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -353,6 +354,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	int namesize;
 	unsigned int i;
 	uint32_t csum = 0;
+	ssize_t this_read;
 
 	mode |= S_IFREG;
 
@@ -428,9 +430,19 @@ static int cpio_mkfile(const char *name, const char *location,
 		 || push_pad(padlen(offset, 4)) < 0)
 			goto error;
 
+		if (size) {
+			this_read = copy_file_range(file, NULL, outfd, NULL, size, 0);
+			if (this_read > 0) {
+				if (this_read > size)
+					goto error;
+				offset += this_read;
+				size -= this_read;
+			}
+			/* short or failed copy falls back to read/write... */
+		}
+
 		while (size) {
 			unsigned char filebuf[65536];
-			ssize_t this_read;
 			size_t this_size = MIN(size, sizeof(filebuf));
 
 			this_read = read(file, filebuf, this_size);
-- 
2.43.0


