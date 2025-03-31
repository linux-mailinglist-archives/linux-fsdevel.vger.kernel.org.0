Return-Path: <linux-fsdevel+bounces-45312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D624A75E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 07:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D92D3A7CD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 05:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A9158218;
	Mon, 31 Mar 2025 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U5P6y/Ob";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ol79eBre";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U5P6y/Ob";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ol79eBre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8486338
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743397430; cv=none; b=XG1+77N9ZJkK13rpeoNNBtq3ocdQ1IpZHtGpN+uZXOZv3GAjNv/Lj4jX9dxnigbFgREC2JA13IOYtmCnBpvEzt9Ib2Bmm7ecpz7fpOO2DpFDbPPmaSlpOZVFCXKmHc+ZZ0mT/Mn+bnuzj7z3LvbgiykNTQExSVsrG8HwMbJQQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743397430; c=relaxed/simple;
	bh=kM0h3uBUOPgkpJ5JBHLk/JkyxoqZM3lgR27h3GeCfzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWPWmilHhfPwoBUuLKbF8u0+Wjovod12Ix9gML55WvDXEHGAO6JvFr9EIKXdyWQojLqV3mbf065qLBx3BdFEjRFkxGgyfTJsoBrdYZq/f3yJbPc/4iOJmBH9UUMwbzUy7arvi88OUOzT4tB3ncpj5fgoCsLu9vR1qHLiMbOqYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U5P6y/Ob; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ol79eBre; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U5P6y/Ob; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ol79eBre; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0439A21186;
	Mon, 31 Mar 2025 05:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743397427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HmWKMkt9Y89ko/jG/wBS1+lg6w+9nyUnY4rWTTkWcsg=;
	b=U5P6y/OblGif2sfeKs7gdURDx2QiSqsHpDVUm0tAfTsX63gQpJndR9AbbM3rV/zsS7grwu
	07s2M5y6iRDlkUBx9OMNpMfjJTBPf/633WFKy5PftuZVJUDjTvj0fV18/SyUa9BpnEEe4e
	gsCoNNtnz687nt/J/ycI+kaNgOg74nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743397427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HmWKMkt9Y89ko/jG/wBS1+lg6w+9nyUnY4rWTTkWcsg=;
	b=ol79eBrezz0BNfdcCiv7uwMMnj9X5Pm1AMfd0wp9mf+oCu5BM2DY+KJIJ4SC9ss9y2nfSn
	W7TwvfWwTB/xMjBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743397427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HmWKMkt9Y89ko/jG/wBS1+lg6w+9nyUnY4rWTTkWcsg=;
	b=U5P6y/OblGif2sfeKs7gdURDx2QiSqsHpDVUm0tAfTsX63gQpJndR9AbbM3rV/zsS7grwu
	07s2M5y6iRDlkUBx9OMNpMfjJTBPf/633WFKy5PftuZVJUDjTvj0fV18/SyUa9BpnEEe4e
	gsCoNNtnz687nt/J/ycI+kaNgOg74nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743397427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HmWKMkt9Y89ko/jG/wBS1+lg6w+9nyUnY4rWTTkWcsg=;
	b=ol79eBrezz0BNfdcCiv7uwMMnj9X5Pm1AMfd0wp9mf+oCu5BM2DY+KJIJ4SC9ss9y2nfSn
	W7TwvfWwTB/xMjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02AE813927;
	Mon, 31 Mar 2025 05:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8TlxKzAi6meTfQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 31 Mar 2025 05:03:44 +0000
From: David Disseldorp <ddiss@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] docs: initramfs: update compression and mtime descriptions
Date: Mon, 31 Mar 2025 16:03:30 +1100
Message-ID: <20250331050330.17161-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
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
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Update the document to reflect that initramfs didn't replace initrd
following kernel 2.5.x.
The initramfs buffer format now supports many compression types in
addition to gzip, so include them in the grammar section.
c_mtime use is dependent on CONFIG_INITRAMFS_PRESERVE_MTIME.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 .../early-userspace/buffer-format.rst         | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/buffer-format.rst b/Documentation/driver-api/early-userspace/buffer-format.rst
index 7f74e301fdf35..cb31d617729c5 100644
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
+with an "initial ramfs" protocol.  The initramfs contents is passed
+using the same memory buffer protocol used by initrd, but the contents
 is different.  The initramfs buffer contains an archive which is
 expanded into a ramfs filesystem; this document details the format of
 the initramfs buffer format.
 
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


