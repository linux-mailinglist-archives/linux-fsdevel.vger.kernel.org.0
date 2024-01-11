Return-Path: <linux-fsdevel+bounces-7772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93782A77F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 07:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD5AB24535
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533882591;
	Thu, 11 Jan 2024 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DQ9BnO9/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2hI3TVul";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lDbfuXmN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PVX3jxHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16623C1;
	Thu, 11 Jan 2024 06:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 41443221E8;
	Thu, 11 Jan 2024 06:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704954079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GhgTsGSYZqMlLkF6ctTWj2wKU/kDUrvtJ+VkGRpxij8=;
	b=DQ9BnO9/AjVn8onMqZnchn5gPvt/80svfZQh1zrGNEgOqet0hXnQoBLimBX/Qe89QEmfv2
	7CcgoAWwLo+KiB+1E8Ond9rI5kioWHnMT0ZnOT2Oekaydr/xK52GOkpANFf60k3w3SeD4d
	u6vNLw+q5lM6pLh/16wZM+0R/jyeNko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704954079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GhgTsGSYZqMlLkF6ctTWj2wKU/kDUrvtJ+VkGRpxij8=;
	b=2hI3TVulZ73IfMXUKy26ToHCqfoOxoynWwQiQporQYsV9XMC88hRmgCuRaXnrsBfVu5KiI
	F2KRwGl/MTuV0/DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704954155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GhgTsGSYZqMlLkF6ctTWj2wKU/kDUrvtJ+VkGRpxij8=;
	b=lDbfuXmNZvbVsaFNEJtyMz8S/yvRnBrgrGEuNysTbSb+2OIdPNivoKputDTiwVcIqWIeQR
	gnWq7X3Ze8wTw5kuFU9GXxX7gUjUjvqZVU2gi3DHozNRO57fhmKugT6s0s6Ncb/96V5BVr
	ScvrK5I5ZHi3q3D/3WS7Bi3Hft50ljs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704954155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GhgTsGSYZqMlLkF6ctTWj2wKU/kDUrvtJ+VkGRpxij8=;
	b=PVX3jxHNS+reAC05gT3M2xsrCvl48A47PLSnmtMTpc1BBzHknVI/iHdrJuXTHoKCUJS/sX
	V0gFomUoZ9MjoEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2931B13635;
	Thu, 11 Jan 2024 06:21:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ff2MtyIn2WjTgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 11 Jan 2024 06:21:16 +0000
From: David Disseldorp <ddiss@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] initramfs: remove duplicate built-in __initramfs_start unpacking
Date: Thu, 11 Jan 2024 17:22:40 +1100
Message-Id: <20240111062240.9362-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lDbfuXmN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PVX3jxHN
X-Spamd-Result: default: False [3.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.52%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.19
X-Rspamd-Queue-Id: 41443221E8
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

If initrd_start cpio extraction fails, CONFIG_BLK_DEV_RAM triggers
fallback to initrd.image handling via populate_initrd_image().
The populate_initrd_image() call follows successful extraction of any
built-in cpio archive at __initramfs_start, but currently performs
built-in archive extraction a second time.

Prior to commit b2a74d5f9d446 ("initramfs: remove clean_rootfs"),
the second built-in initramfs unpack call was used to repopulate entries
removed by clean_rootfs(), but it's no longer necessary now the contents
of the previous extraction are retained.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 8d0fd946cdd2b..2edd3007a6857 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -669,8 +669,6 @@ static void __init populate_initrd_image(char *err)
 	struct file *file;
 	loff_t pos = 0;
 
-	unpack_to_rootfs(__initramfs_start, __initramfs_size);
-
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
 	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
-- 
2.35.3


