Return-Path: <linux-fsdevel+bounces-25339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558C94AFB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4171E283195
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475F142E78;
	Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6B36gbt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpCMzDHn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6B36gbt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lpCMzDHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246A13E409
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=OwDSflcEN5QPGcx8dQaY9W3eX8O0JahY0VL8uNAEbDG2+zfwWlZLOaBMZg4BkC8eyAtIzOHoR1YAUlqjbiTdAe/ezxCiIy5n78jIavZe/liJpsGQRsxqNPb07qBAC1z+dPkF9AhFkHtF99O7TT6rblx+xNH1iNM4QjrwBsFKEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=HOKhGw7DbSaMYcuyuRIgbMmniRdO/9MZVJ+cfyWXltQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcRrktlYZFYHno6NZosuCmTav6g6n3/8pP0IfeSE2PYWW0Ek2wD1WclGOofLD25h3QvZa8U5blqkTye7iZLHzuUiQDA2rmgMLGLPGfQwfkqfMW9rbw9z9YSzt2Pvy6p//t3flis/MWxkURd1nwSkFgvOFmg2iy6bk+SGGHl5p/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6B36gbt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpCMzDHn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6B36gbt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lpCMzDHn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8800521CF9;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuZxlJ5CLM+kZvC3aVZwUhGn9HRKek4wGQ8oh/oAzK8=;
	b=g6B36gbtdC3mHFa3mb1fPdQB1LxB4g5lDw9u097hp9gs/+JmDrYfRTaj5kym6/R9MElA3j
	+8AH8HjgsJzFeMyi5Q24KYVxP3m5+tKkYHMKyL08jeCI1ste1jUa6M9TlGbQUoHSYK72p/
	cKlAdq4zIAS3RTWX66db2A+3fZyVqmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuZxlJ5CLM+kZvC3aVZwUhGn9HRKek4wGQ8oh/oAzK8=;
	b=lpCMzDHnLLTlkfuBxE13mijSyFOzatsqZ0lTQAFQwXDtNbygZPmbdYn9YKG/4i6zXDABYA
	Njt/oOgi8dWvQNCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuZxlJ5CLM+kZvC3aVZwUhGn9HRKek4wGQ8oh/oAzK8=;
	b=g6B36gbtdC3mHFa3mb1fPdQB1LxB4g5lDw9u097hp9gs/+JmDrYfRTaj5kym6/R9MElA3j
	+8AH8HjgsJzFeMyi5Q24KYVxP3m5+tKkYHMKyL08jeCI1ste1jUa6M9TlGbQUoHSYK72p/
	cKlAdq4zIAS3RTWX66db2A+3fZyVqmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuZxlJ5CLM+kZvC3aVZwUhGn9HRKek4wGQ8oh/oAzK8=;
	b=lpCMzDHnLLTlkfuBxE13mijSyFOzatsqZ0lTQAFQwXDtNbygZPmbdYn9YKG/4i6zXDABYA
	Njt/oOgi8dWvQNCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 781BD13B14;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +8lRHSy9s2aANAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E072CA0894; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/13] fs: Add __must_check annotations to sb_start_write_trylock() and similar
Date: Wed,  7 Aug 2024 20:29:55 +0200
Message-Id: <20240807183003.23562-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=jack@suse.cz; h=from:subject; bh=HOKhGw7DbSaMYcuyuRIgbMmniRdO/9MZVJ+cfyWXltQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70icVtioNbWtGj4yW6SpWJjT3RyFHjgBANQgHoT fJcUHVuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9IgAKCRCcnaoHP2RA2b6eCA C2XvrQWBz4W+GVErx8fCD8EVekwye4AYQPXcNohifAqM4XdFCfg+80MV315SLhnmCOrNvfugi/B3BQ TW7P78dw+uVXG5EUifEryqD3hJoeJjnlW3h6v3e7hanymWgG36jisk6zT9WwIBLE3olM5IQvu2Fhgy cVFeaUYn/lWsfSrHtmcmAQw5zmBzmsT6T/xoeGyO6BYExfs8H6lhdniVWjI+FTvrg6/wv6x86yaGkp qIqhkCa0eJHbmwVxqDrj7f93iiGKgVTEMP/YwYmu6TrdLN01BPkONlpQUXpoLkBCBvp+Pxp2ZHQk6Q 6cJ+0E63NctEIEnS0x2bl5rRQ9h885
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spam-Level: 

The callers of sb_start_write_trylock(), sb_start_intwrite_trylock(),
file_start_write_trylock() must check the return value to figure out
whether the protection has been acquired (and thus must be dropped) or
not. Add __must_check annotation to these functions to catch forgotten
checks early.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 952f11170296..755a4c83a2bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1828,7 +1828,7 @@ static inline void sb_start_write(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_WRITE);
 }
 
-static inline bool sb_start_write_trylock(struct super_block *sb)
+static inline bool __must_check sb_start_write_trylock(struct super_block *sb)
 {
 	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);
 }
@@ -1875,7 +1875,8 @@ static inline void sb_start_intwrite(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_FS);
 }
 
-static inline bool sb_start_intwrite_trylock(struct super_block *sb)
+static inline bool __must_check sb_start_intwrite_trylock(
+						struct super_block *sb)
 {
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
@@ -2894,7 +2895,7 @@ static inline int __must_check file_start_write(struct file *file)
 	return 0;
 }
 
-static inline bool file_start_write_trylock(struct file *file)
+static inline bool __must_check file_start_write_trylock(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return true;
-- 
2.35.3


