Return-Path: <linux-fsdevel+bounces-43038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F47A4D386
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A09A7A5B51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7A1F4739;
	Tue,  4 Mar 2025 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qGxCwn8L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KWX/VljQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qGxCwn8L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KWX/VljQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BC1F416B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068647; cv=none; b=hmnn5hZsOctC5yjmZsSMrRzcgvev3sUyedMhLfG2R1QNZi8FfFaJL7IWTMgWAcs6DAfYdv6cs1yhP57OQsyo2YZGR0ZmqtKaH83X2mEXHe4SwuRL/V5FnvUsRSwLoN6xEGkQjnDBOPsvNcSCvE6nkrEp/x5951HvFvXrjwfADsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068647; c=relaxed/simple;
	bh=IB8jHhAB3o1fuo+OyxgWuE+tj+u7wr+4MpHd1P5eJr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRIaaucwrHhIVUwC6rRqWQHk+XwmDeWcc3pzupLex9qChU6msFoEzEszk5MEdK3ysPnNru/lgkk2SNpfSKBcQit2G3zYPz8kDqEXHLqilwY5wjt7hXf81YdHNUwI/Zb/WOKNFljBHcBzqkterwBpmTM5g8+nHhWclq7ZHd624cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qGxCwn8L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KWX/VljQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qGxCwn8L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KWX/VljQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E913C2118C;
	Tue,  4 Mar 2025 06:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=qGxCwn8L6u3o7Fhdc5g8irlcVqopuOvVnFBjNhdCu6YpP8b+XadRp0KegpJC5Hx0VVGkqD
	hCNSUqUIxOdTuju8KshZJTdbGUcRd0fjJMxTcUIMW8G8BCnZJ75g1GBzg/Pzk0StXhhPOz
	n+BBeecKXIG2sXVVaz4SQAZA10Ry5p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=KWX/VljQ7bb33TWk1lGI7Q/NmF7VksIj0f5qsYPx8ySd3ZWgNCVVbL/3/YVbaItj+5i+rN
	3BgLhYWGdgOwa9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=qGxCwn8L6u3o7Fhdc5g8irlcVqopuOvVnFBjNhdCu6YpP8b+XadRp0KegpJC5Hx0VVGkqD
	hCNSUqUIxOdTuju8KshZJTdbGUcRd0fjJMxTcUIMW8G8BCnZJ75g1GBzg/Pzk0StXhhPOz
	n+BBeecKXIG2sXVVaz4SQAZA10Ry5p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=KWX/VljQ7bb33TWk1lGI7Q/NmF7VksIj0f5qsYPx8ySd3ZWgNCVVbL/3/YVbaItj+5i+rN
	3BgLhYWGdgOwa9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3FCE1393C;
	Tue,  4 Mar 2025 06:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPSuJmGZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:41 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 4/8] initramfs: avoid memcpy for hex header fields
Date: Tue,  4 Mar 2025 16:57:47 +1100
Message-ID: <20250304061020.9815-5-ddiss@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

newc/crc cpio headers contain a bunch of 8-character hexadecimal fields
which we convert via simple_strtoul(), following memcpy() into a
zero-terminated stack buffer. The new simple_strntoul() helper allows us
to pass in max_chars=8 to avoid zero-termination and memcpy().

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 002e83ae12ac7..6dd3b02c15d7e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -189,14 +189,11 @@ static __initdata u32 hdr_csum;
 static void __init parse_header(char *s)
 {
 	unsigned long parsed[13];
-	char buf[9];
 	int i;
 
-	buf[8] = '\0';
-	for (i = 0, s += 6; i < 13; i++, s += 8) {
-		memcpy(buf, s, 8);
-		parsed[i] = simple_strtoul(buf, NULL, 16);
-	}
+	for (i = 0, s += 6; i < 13; i++, s += 8)
+		parsed[i] = simple_strntoul(s, NULL, 16, 8);
+
 	ino = parsed[0];
 	mode = parsed[1];
 	uid = parsed[2];
-- 
2.43.0


