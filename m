Return-Path: <linux-fsdevel+bounces-45486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6861BA786E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 05:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F23D3AF443
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 03:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F418052;
	Wed,  2 Apr 2025 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c2KP4oVR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4j2Wxma";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c2KP4oVR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4j2Wxma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3441A23027D
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743565549; cv=none; b=Cw5aQxMgh2W4zOufZZvLSDLmNRe/9qna1GuFy9GwEyZT5ik4MrkJyjkL10DXbUPUFG7nPwQ+avsyWJ3gEHRZhY1D7jhnR1m5H54l0xp5BLgkwNenpbnSMId/ZMu9cs+maGuD755F6Tb4+rNq571HZGQSpdIihBvKJlEPRo1X7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743565549; c=relaxed/simple;
	bh=EUTLo/JuaeCHWovkORAR/9wFmO2bAXTkHZ8xY1bDbXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTK7yul7B4cfzsYYpSGIXcrcr7Yb16cRt85DpumhZVS6TOwS2v0zHr/a0A+9npNe5BO3cO/PHYxZLYV9krrxQeeA79gMouz8P3oOR5cTumm9iMmtVouDa6G+apiuzwSnq2Ho95u+FttXW/ovWc/EX6wUOf1lt281GUyDdUJBtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c2KP4oVR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4j2Wxma; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c2KP4oVR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4j2Wxma; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28178210F4;
	Wed,  2 Apr 2025 03:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743565545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oorjrHluL9WQ0l5dJJOLD/nGpF2hDzMTsPa9sSeXeRM=;
	b=c2KP4oVRHlNGkxSgYwYdFCApw5jUTKYq9kvOeud3T+YU/ab98/ASlqs0Pl0Jpn5+3Yfk6S
	6tK3v0haHNcfJevsuaCLjiSKe8xEIUVPRMDjJt7sY1e2pB0i5yisY+05pCNiN7Mp2CE548
	wQvaH9z+/ltVhLsaKFB/PnYkKpn1jpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743565545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oorjrHluL9WQ0l5dJJOLD/nGpF2hDzMTsPa9sSeXeRM=;
	b=X4j2Wxmat+J1fVaeEnV3gCUHZD7pHkubScR5R/6Dan+CRj1LwCoh6h3zjtccD7mbLJ7Nwt
	/rpfJPhuwJl4HDCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=c2KP4oVR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X4j2Wxma
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743565545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oorjrHluL9WQ0l5dJJOLD/nGpF2hDzMTsPa9sSeXeRM=;
	b=c2KP4oVRHlNGkxSgYwYdFCApw5jUTKYq9kvOeud3T+YU/ab98/ASlqs0Pl0Jpn5+3Yfk6S
	6tK3v0haHNcfJevsuaCLjiSKe8xEIUVPRMDjJt7sY1e2pB0i5yisY+05pCNiN7Mp2CE548
	wQvaH9z+/ltVhLsaKFB/PnYkKpn1jpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743565545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oorjrHluL9WQ0l5dJJOLD/nGpF2hDzMTsPa9sSeXeRM=;
	b=X4j2Wxmat+J1fVaeEnV3gCUHZD7pHkubScR5R/6Dan+CRj1LwCoh6h3zjtccD7mbLJ7Nwt
	/rpfJPhuwJl4HDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C61D213A4B;
	Wed,  2 Apr 2025 03:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wDP1Huay7GfFYAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 02 Apr 2025 03:45:42 +0000
From: David Disseldorp <ddiss@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] docs: initramfs: update compression and mtime descriptions
Date: Wed,  2 Apr 2025 14:39:50 +1100
Message-ID: <20250402033949.852-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28178210F4
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Update the document to reflect that initramfs didn't replace initrd
following kernel 2.5.x.
The initramfs buffer format now supports many compression types in
addition to gzip, so include them in the grammar section.
c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
Changes since v1 following feedback from Randy Dunlap:
- contents -> content
- format of the initramfs buffer format -> the initramfs buffer format

 .../early-userspace/buffer-format.rst         | 34 ++++++++++++-------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
index 7f74e301fdf35..726bfa2fe70da 100644
--- a/Documentation/driver-api/early-userspace/buffer-format.rst
+++ b/Documentation/driver-api/early-userspace/buffer-format.rst
@@ -4,20 +4,18 @@ initramfs buffer format
 
 Al Viro, H. Peter Anvin
 
-Last revision: 2002-01-13
-
-Starting with kernel 2.5.x, the old "initial ramdisk" protocol is
-getting {replaced/complemented} with the new "initial ramfs"
-(initramfs) protocol.  The initramfs contents is passed using the same
-memory buffer protocol used by the initrd protocol, but the contents
+With kernel 2.5.x, the old "initial ramdisk" protocol was complemented
+with an "initial ramfs" protocol.  The initramfs content is passed
+using the same memory buffer protocol used by initrd, but the content
 is different.  The initramfs buffer contains an archive which is
-expanded into a ramfs filesystem; this document details the format of
-the initramfs buffer format.
+expanded into a ramfs filesystem; this document details the initramfs
+buffer format.
 
 The initramfs buffer format is based around the "newc" or "crc" CPIO
 formats, and can be created with the cpio(1) utility.  The cpio
-archive can be compressed using gzip(1).  One valid version of an
-initramfs buffer is thus a single .cpio.gz file.
+archive can be compressed using gzip(1), or any other algorithm provided
+via CONFIG_DECOMPRESS_*.  One valid version of an initramfs buffer is
+thus a single .cpio.gz file.
 
 The full format of the initramfs buffer is defined by the following
 grammar, where::
@@ -25,12 +23,20 @@ grammar, where::
 	*	is used to indicate "0 or more occurrences of"
 	(|)	indicates alternatives
 	+	indicates concatenation
-	GZIP()	indicates the gzip(1) of the operand
+	GZIP()	indicates gzip compression of the operand
+	BZIP2()	indicates bzip2 compression of the operand
+	LZMA()	indicates lzma compression of the operand
+	XZ()	indicates xz compression of the operand
+	LZO()	indicates lzo compression of the operand
+	LZ4()	indicates lz4 compression of the operand
+	ZSTD()	indicates zstd compression of the operand
 	ALGN(n)	means padding with null bytes to an n-byte boundary
 
-	initramfs  := ("\0" | cpio_archive | cpio_gzip_archive)*
+	initramfs := ("\0" | cpio_archive | cpio_compressed_archive)*
 
-	cpio_gzip_archive := GZIP(cpio_archive)
+	cpio_compressed_archive := (GZIP(cpio_archive) | BZIP2(cpio_archive)
+		| LZMA(cpio_archive) | XZ(cpio_archive) | LZO(cpio_archive)
+		| LZ4(cpio_archive) | ZSTD(cpio_archive))
 
 	cpio_archive := cpio_file* + (<nothing> | cpio_trailer)
 
@@ -75,6 +81,8 @@ c_chksum      8 bytes		 Checksum of data field if c_magic is 070702;
 The c_mode field matches the contents of st_mode returned by stat(2)
 on Linux, and encodes the file type and file permissions.
 
+c_mtime is ignored unless CONFIG_INITRAMFS_PRESERVE_MTIME=y is set.
+
 The c_filesize should be zero for any file which is not a regular file
 or symlink.
 
-- 
2.43.0


