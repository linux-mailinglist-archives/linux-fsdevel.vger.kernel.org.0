Return-Path: <linux-fsdevel+bounces-43040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B83A4D37E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5303AB7E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE241F4E47;
	Tue,  4 Mar 2025 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Srci8OfD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3z+CF+bE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Srci8OfD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3z+CF+bE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246551F4CA2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068658; cv=none; b=aGFX8U7qTUCPX/dW/9FBe/cfUmdZX9xLFWfviW45ZEg8Wz+QrVyq+yN9WIje5/ZtELBKlOEB2AZFUunuGdARhBY77B6orlAOLXbbQeVEY0xz+2gKY61hRNr7PiIxo9qwGg6Sfael3b6BUURPnp3XWYG/tvgiPcmctITauYM9m1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068658; c=relaxed/simple;
	bh=IJb9BCL0fvFyjFj+jNLIUwjZZVJpr2BxFohFhME8Q8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejYJfvoqRScS0JORkEvqjWTrWeWveMUKp+d2p7qTVnVEGqwzKEJsXKEhnXbAk4n5qFQU+dw9YuD1fIp27PMOOHp+3QHqPwfkCdTAEullvsLPfEtlqaQhthLP0fRbjHCbMPQtarJpRum24+KFjySfl9IGIW9kvlnh2fmR+GFlCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Srci8OfD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3z+CF+bE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Srci8OfD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3z+CF+bE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CEC22119A;
	Tue,  4 Mar 2025 06:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNHgs/Y5Rw7AB5TGLo8Fi2TkoEkW78DdXu96ZTCeRBo=;
	b=Srci8OfD9E3870lSf6d1of0LAC09tbrWiytgcvSt7YxTfgw15Bq2LVuzMwcD9NKyv2cVZE
	zHTUnan4bAn8X7QRx9mzVxOvNSbUIlEz82VK9oM1imA3GiwtdxxHG4iaAbdmLnfzEC1gjW
	L2EmjyaZmyETSGicBupt05o53h+oSm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNHgs/Y5Rw7AB5TGLo8Fi2TkoEkW78DdXu96ZTCeRBo=;
	b=3z+CF+bEKkcyeBF9BHXRDrKbToK+JgawZUFG5r0Qct0KcLr8H7H1HTeUtoMP/LK6wtZiCE
	A1IvARJwNQTL4yBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNHgs/Y5Rw7AB5TGLo8Fi2TkoEkW78DdXu96ZTCeRBo=;
	b=Srci8OfD9E3870lSf6d1of0LAC09tbrWiytgcvSt7YxTfgw15Bq2LVuzMwcD9NKyv2cVZE
	zHTUnan4bAn8X7QRx9mzVxOvNSbUIlEz82VK9oM1imA3GiwtdxxHG4iaAbdmLnfzEC1gjW
	L2EmjyaZmyETSGicBupt05o53h+oSm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNHgs/Y5Rw7AB5TGLo8Fi2TkoEkW78DdXu96ZTCeRBo=;
	b=3z+CF+bEKkcyeBF9BHXRDrKbToK+JgawZUFG5r0Qct0KcLr8H7H1HTeUtoMP/LK6wtZiCE
	A1IvARJwNQTL4yBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 397D01393C;
	Tue,  4 Mar 2025 06:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKmnOGuZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:51 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 8/8] initramfs: avoid static buffer for error message
Date: Tue,  4 Mar 2025 16:57:51 +1100
Message-ID: <20250304061020.9815-9-ddiss@suse.de>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RLrijaiqibj4nu9fhpyh5651a8)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The dynamic error message printed if CONFIG_RD_$ALG compression support
is missing needn't be propagated up to the caller via a static buffer.
Print it immediately via pr_err() and set @message to a const string to
flag error.

Before:
   text    data     bss     dec     hex filename
   8006    1118       8    9132    23ac init/initramfs.o

After:
   text    data     bss     dec     hex filename
   7938    1022       8    8968    2308 init/initramfs.o

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index e0b11f8d6f3d6..72bad44a1d418 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -511,7 +511,6 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	long written;
 	decompress_fn decompress;
 	const char *compress_name;
-	static __initdata char msg_buf[64];
 	struct {
 		char header[CPIO_HDRLEN];
 		char symlink[PATH_MAX + N_ALIGN(PATH_MAX) + 1];
@@ -552,12 +551,9 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 			if (res)
 				error("decompressor failed");
 		} else if (compress_name) {
-			if (!message) {
-				snprintf(msg_buf, sizeof msg_buf,
-					 "compression method %s not configured",
-					 compress_name);
-				message = msg_buf;
-			}
+			pr_err("compression method %s not configured\n",
+			       compress_name);
+			error("decompressor failed");
 		} else
 			error("invalid magic at start of compressed archive");
 		if (state != Reset)
-- 
2.43.0


