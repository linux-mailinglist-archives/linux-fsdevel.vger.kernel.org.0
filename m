Return-Path: <linux-fsdevel+bounces-33604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BBD9BB764
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB7282155
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7201B392A;
	Mon,  4 Nov 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKoI4DvO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lu2jguoE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KKoI4DvO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lu2jguoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7E1B0F13
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729897; cv=none; b=ph+ScPcQpMUAwXEJ5dEuHFPI0g28R1SXBAJFozN38klvbFDSYboPNi0hGggjYbJV3vzQ+ufeoHomZu8IPHNHdOQRZV0SNZ8C3nMLTG/YS3u81BYrGzCLkT5HebWrRe1uqBXfZ3alF40SjcuXelPDtzTU78dzTnQGbznwiIsmdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729897; c=relaxed/simple;
	bh=IB8jHhAB3o1fuo+OyxgWuE+tj+u7wr+4MpHd1P5eJr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbJUlKM96d7I0cFV2MMpinbTS+hHHb6jAo37O0qmHq9fr76LnRbb5+DANmg7ogWYOiVCSL5DDfnTSfK0jsu2slmXx+p8lTJuXbUW3pbhnxIseoRr9sKG4dYqmTZYqt4oEJHHMqtaakQ5aeWt9J27nwoYlB5wn7607IJ6ZlpWGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKoI4DvO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lu2jguoE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KKoI4DvO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lu2jguoE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE89921B79;
	Mon,  4 Nov 2024 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=KKoI4DvOqBjAy2daYA5fPNiP7TOmY4yABEEfJTwtxhTQNUAjRtEQENjVV6JElLNki2HDqi
	vcygeOFy17WODWjeLZP6427RP6A3X/hi3Hahs0d1A7D0X2kNPvlknJfEJzmUaYHFZCGY++
	rrs0G93wr3U+UHYURGUW4mJBYzGuPcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=Lu2jguoEHdHLiRZu+AjyNvcKeJZ30xYECsCvtrvZ50+NhNd3wKI8B4NTH6Es0C12LA23WV
	PBe7aTPql7AA1sBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=KKoI4DvOqBjAy2daYA5fPNiP7TOmY4yABEEfJTwtxhTQNUAjRtEQENjVV6JElLNki2HDqi
	vcygeOFy17WODWjeLZP6427RP6A3X/hi3Hahs0d1A7D0X2kNPvlknJfEJzmUaYHFZCGY++
	rrs0G93wr3U+UHYURGUW4mJBYzGuPcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=Lu2jguoEHdHLiRZu+AjyNvcKeJZ30xYECsCvtrvZ50+NhNd3wKI8B4NTH6Es0C12LA23WV
	PBe7aTPql7AA1sBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDEFC13736;
	Mon,  4 Nov 2024 14:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4JxLKKPXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:11 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 4/9] initramfs: avoid memcpy for hex header fields
Date: Tue,  5 Nov 2024 01:14:43 +1100
Message-ID: <20241104141750.16119-5-ddiss@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
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


