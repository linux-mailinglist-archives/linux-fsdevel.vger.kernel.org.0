Return-Path: <linux-fsdevel+bounces-33846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD19BFAB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B16CB22467
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71845C2ED;
	Thu,  7 Nov 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3DeOblU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iQJWT7R+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3DeOblU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iQJWT7R+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8EE567D;
	Thu,  7 Nov 2024 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938921; cv=none; b=P53ykWzHZUqohqw4OtkZrN026SBgyB5R3ZG62URUupnXXyctAv6UlAgdMNwS1xZcJz8e0/nS5J63vIB/Izoe9Uj5MEkOyv7o1bJ+s3EyRUONROL3BS4fEUsYNnNB0GpUCd4Rirqhov1kx+/3sLZQ3qGxKTvR1VkHhhsozgXFgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938921; c=relaxed/simple;
	bh=IB8jHhAB3o1fuo+OyxgWuE+tj+u7wr+4MpHd1P5eJr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMN8MOaq7vsVDplLMAFz2d0udHGvhO92CHP/R/mIeOTbOc5PYK1hvBZ0jo93lo3SfD5jmZ8bmSKhYW4svN7u5SZU3Sv7wVXvJnS+VNhPiXmrG844WvI43rzVvhNp9guJvsDMWsI6qT1N2cipCyTaMJPpfUA50yT1G/eZihoLm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3DeOblU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iQJWT7R+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3DeOblU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iQJWT7R+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A396821CBD;
	Thu,  7 Nov 2024 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=B3DeOblUtkbyCG8qxdJhBBp+E9FTQBJijk21xDUtqFbayGEE81IAtz8AYsI2CFvbivb8x/
	Sl1p2D+Iy8doM7IYptVmUQ29/Y2LEvBnE6mpXsqtYIGmUg2bG6l6ZF4O/2CaFPeLafV5nd
	x9MCjou0inreI1iZIgLcGe6c528Zikc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=iQJWT7R+j67APTsL2G4gNxVy2bkgFLnNur6uEKGHn8E0X7e97cPeMYObpFj1AIrTLj15YI
	z2aNKqJ0kCXDOoCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=B3DeOblUtkbyCG8qxdJhBBp+E9FTQBJijk21xDUtqFbayGEE81IAtz8AYsI2CFvbivb8x/
	Sl1p2D+Iy8doM7IYptVmUQ29/Y2LEvBnE6mpXsqtYIGmUg2bG6l6ZF4O/2CaFPeLafV5nd
	x9MCjou0inreI1iZIgLcGe6c528Zikc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJruo/PUqbsUiEslLAkM0UfjgrJI2RP7fQOA1xVkfsI=;
	b=iQJWT7R+j67APTsL2G4gNxVy2bkgFLnNur6uEKGHn8E0X7e97cPeMYObpFj1AIrTLj15YI
	z2aNKqJ0kCXDOoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A71D1394A;
	Thu,  7 Nov 2024 00:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJDyCyQILGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:21:56 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 4/9] initramfs: avoid memcpy for hex header fields
Date: Thu,  7 Nov 2024 11:17:23 +1100
Message-ID: <20241107002044.16477-6-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107002044.16477-1-ddiss@suse.de>
References: <20241107002044.16477-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.964];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
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


