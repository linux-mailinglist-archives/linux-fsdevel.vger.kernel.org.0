Return-Path: <linux-fsdevel+bounces-31983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBAC99ED89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D593B229D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520114EC47;
	Tue, 15 Oct 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tT8MBG5n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Be++y2SS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tT8MBG5n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Be++y2SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B21FC7FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999034; cv=none; b=YSvY8kWiODD4IvfhRYhBfv7K292wCXqzl4XKvh1M3hHYmzPuC+vsBKWgRmKBIhbdCPFlzgd1E/tV3kI86isNIbog7dIlot1sze4ePLHqOE0BCaBP5cK++fpqtZq+oZ0Fr9CjarKO7T5jhn70MWt5nV5kJHznkHJAML6idSdpkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999034; c=relaxed/simple;
	bh=O+KBLKM6Yf9s5KLhm3OfZRWcBrBo+IyLs7NfN0hMrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAeykw36W6x2hVFLe5HghFFdxcyeFaczeXxbWpVahRTMxz/hwRs9u0CwOfKaSoUt7IpbEMRk+kyeRykbrsuU9Fv5SInsimi16AO6DgYaLmXvr8HRh6WmDOw9kUGLzKnxiWLPRFOXhsATd3ugVp1kua1n6EWHPZFKgNxXysm1Eg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tT8MBG5n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Be++y2SS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tT8MBG5n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Be++y2SS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 693141FE5F;
	Tue, 15 Oct 2024 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDNb8oDu2lGdm5lXbyvY3SJ/EskAXqrEHvs4ykIAALo=;
	b=tT8MBG5nIM03OIsZmjz/xT5ncEs5e+CxNVbpHw/6XLk9FqJ2azes4vIaGnqc7tqk+zpMz5
	YHCUDWQuW+UR70nF7ki0qyTAuRge+2tNcJA/7H72m8DiYX1CPTjjiEp1H0aiMSvnwXZQqV
	ffMH4v4WXOU1Hr4LyisAQ4YQs8yF3QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDNb8oDu2lGdm5lXbyvY3SJ/EskAXqrEHvs4ykIAALo=;
	b=Be++y2SSNaFLRiPxfhV6uCEtwPXQWqS2SWhQimh5yCXsFeMovzfZ5WKR7+Rj0qsIIBf5kR
	qL4axNULa6c8DsAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDNb8oDu2lGdm5lXbyvY3SJ/EskAXqrEHvs4ykIAALo=;
	b=tT8MBG5nIM03OIsZmjz/xT5ncEs5e+CxNVbpHw/6XLk9FqJ2azes4vIaGnqc7tqk+zpMz5
	YHCUDWQuW+UR70nF7ki0qyTAuRge+2tNcJA/7H72m8DiYX1CPTjjiEp1H0aiMSvnwXZQqV
	ffMH4v4WXOU1Hr4LyisAQ4YQs8yF3QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDNb8oDu2lGdm5lXbyvY3SJ/EskAXqrEHvs4ykIAALo=;
	b=Be++y2SSNaFLRiPxfhV6uCEtwPXQWqS2SWhQimh5yCXsFeMovzfZ5WKR7+Rj0qsIIBf5kR
	qL4axNULa6c8DsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 881D113A42;
	Tue, 15 Oct 2024 13:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MGv7DnVuDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:29 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 2/6] initramfs: avoid memcpy for hex header fields
Date: Tue, 15 Oct 2024 13:11:59 +0000
Message-ID: <20241015133016.23468-3-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015133016.23468-1-ddiss@suse.de>
References: <20241015133016.23468-1-ddiss@suse.de>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
index bc911e466d5bb..c35600d49a50a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -188,14 +188,11 @@ static __initdata u32 hdr_csum;
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


