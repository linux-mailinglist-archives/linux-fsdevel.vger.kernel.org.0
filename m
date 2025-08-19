Return-Path: <linux-fsdevel+bounces-58243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9634B2B80B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 05:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5AD4E4864
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 03:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187F2D24AF;
	Tue, 19 Aug 2025 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qLH2cOdD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AGaaHURN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qLH2cOdD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AGaaHURN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A32FB978
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755575440; cv=none; b=OOHVVA6c81dNSsKUtm7XYpJa/w33QbXIHkaVIQQuJ2oy8XiJNJ5OrMPUqFLlqbObqXTg4Zljqhm/CCkkrN7rAILDvA/BBg7kbHj24q6kX0ZrZeXMSW73PzsqNURnwMK9QYs3bs5eKlEeis4uEJA0EZBF7uEiwluT928GAgfIAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755575440; c=relaxed/simple;
	bh=nphLinl1w6ivFeTkDxu9h9ePdsivvL8MwTOW8r5M51c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDVDr/Q7fR4ocRiWh5WLTefAEqnPwo/ShZCHaJsL0wE/BSaOlWtHtxCdScKoUgrAqeiP81Zr1ahGtqxe5Vj0Z41IFizIStyJ3Kgk6zDW3V63y/9ipz6mIrBRMjIctRK/XdKGXWb8VAK0jMccLpVIo0cjis2zlyZ6NQ8GtuBTRPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qLH2cOdD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AGaaHURN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qLH2cOdD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AGaaHURN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 963C91F76B;
	Tue, 19 Aug 2025 03:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmqmOzt8e8EwkqXQEOZ1dNuIuiROh6e1lsvIiM5COQg=;
	b=qLH2cOdDZt0Rbl45t6X2OB8/QoSTRfAS7vhntW5UrG1/ueLDtXT0+su/LtXjUoXnAEW494
	BG3Xl4SWV+vQhrVWG+CfgOr/Q6h7xnwU40L2LzJyrBkPpD0Bh7BYtRLo9ClPZgLZq+PYwk
	ybLcLYLm+W7hfhwt2eSgSrEwRzxtc74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmqmOzt8e8EwkqXQEOZ1dNuIuiROh6e1lsvIiM5COQg=;
	b=AGaaHURNbzxXRd69lZMLASegx3mhfOUzTjQOhNesKDY5sR6im18ehx2rlfoPucwJemrpT+
	cm2qqnZTt9516HAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755575405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmqmOzt8e8EwkqXQEOZ1dNuIuiROh6e1lsvIiM5COQg=;
	b=qLH2cOdDZt0Rbl45t6X2OB8/QoSTRfAS7vhntW5UrG1/ueLDtXT0+su/LtXjUoXnAEW494
	BG3Xl4SWV+vQhrVWG+CfgOr/Q6h7xnwU40L2LzJyrBkPpD0Bh7BYtRLo9ClPZgLZq+PYwk
	ybLcLYLm+W7hfhwt2eSgSrEwRzxtc74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755575405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmqmOzt8e8EwkqXQEOZ1dNuIuiROh6e1lsvIiM5COQg=;
	b=AGaaHURNbzxXRd69lZMLASegx3mhfOUzTjQOhNesKDY5sR6im18ehx2rlfoPucwJemrpT+
	cm2qqnZTt9516HAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 831F713686;
	Tue, 19 Aug 2025 03:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KLG4Dmv0o2gJawAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 19 Aug 2025 03:50:03 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ddiss@suse.de,
	nsc@kernel.org
Subject: [PATCH v3 3/8] gen_init_cpio: attempt copy_file_range for file data
Date: Tue, 19 Aug 2025 13:05:46 +1000
Message-ID: <20250819032607.28727-4-ddiss@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 usr/gen_init_cpio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index ea4b9b5fed014..aa73afd3756c8 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -354,6 +354,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	int namesize;
 	unsigned int i;
 	uint32_t csum = 0;
+	ssize_t this_read;
 
 	mode |= S_IFREG;
 
@@ -429,9 +430,19 @@ static int cpio_mkfile(const char *name, const char *location,
 		    push_pad(padlen(offset, 4)) < 0)
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


