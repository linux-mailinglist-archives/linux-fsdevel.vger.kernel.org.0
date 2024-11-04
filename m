Return-Path: <linux-fsdevel+bounces-33606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973D9BB766
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3CC1C23B77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF99D1B0F13;
	Mon,  4 Nov 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqSYG7jZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yc+VLUD5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gqSYG7jZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yc+VLUD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E91B3939
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729899; cv=none; b=pxUZvtu+OuDA2AoK9XfLOR+4ipvg35OiAaNOvUkoDBVzv8PO3Yuoype1qc8JCB4DHUhszZiMEZuyXRlH/RylFQbFJUyDC8QEYwkuXli11kr0/6ximFfR6zdkIpg3omFwl4vd5pzIrLaZDqPYIBqp1aiejMAQvnMiwYNAuxmRi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729899; c=relaxed/simple;
	bh=m5hJjlSJ1opmfVlIWfPqkvhhmAI65ZdzM180nHf+/VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpaEZuBAvR1q36jUobsjDyUYWQVc1X4wRN2B7y93PhyElHu5UkQjIRXO4hP+JqJHMXqB20qmvlSSrOssDaCOX311AZYBU4orjD3OO/yS9qAMTlo68Ehblliq485K887hM8b1SZk/MetV0y1oU+rVvXm4AHBmcphNi5XqzlylGa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqSYG7jZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yc+VLUD5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gqSYG7jZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yc+VLUD5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2962A21F03;
	Mon,  4 Nov 2024 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=gqSYG7jZtOo/z5+DJpt4zt13kUv0a1PqplYvgRgURQ5No2uuiuthYTk/OPNLHDWve4TqiV
	SD2wPFe3cJfo5yzm25rV24+hqoVi/3/bd6vPknIid4RmWRhv2YN025CCASsr7YXR3GHFWU
	jHHeOY0LbHydU+W/Y4bK6XRnkbzPUVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=yc+VLUD5oh2TnX9JqJ3Pjtte4GOW2SdwkTllEOpfZ4MI57SV8H7xagDArfvPhKS3g5FAW9
	KFz76DMcKukaAnDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=gqSYG7jZtOo/z5+DJpt4zt13kUv0a1PqplYvgRgURQ5No2uuiuthYTk/OPNLHDWve4TqiV
	SD2wPFe3cJfo5yzm25rV24+hqoVi/3/bd6vPknIid4RmWRhv2YN025CCASsr7YXR3GHFWU
	jHHeOY0LbHydU+W/Y4bK6XRnkbzPUVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZr/lXIGLYGUZg9KDqFPOpqG1qTICHUflUpZQFG9iGg=;
	b=yc+VLUD5oh2TnX9JqJ3Pjtte4GOW2SdwkTllEOpfZ4MI57SV8H7xagDArfvPhKS3g5FAW9
	KFz76DMcKukaAnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57CC813736;
	Mon,  4 Nov 2024 14:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oKC7A6bXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:14 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 5/9] initramfs: remove extra symlink path buffer
Date: Tue,  5 Nov 2024 01:14:44 +1100
Message-ID: <20241104141750.16119-6-ddiss@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

A (newc/crc) cpio entry with mode.S_IFLNK set carries the symlink target
in the cpio data segment, following the padded name_len sized file
path. symlink_buf is heap-allocated for staging both file path and
symlink target, while name_buf is additionally allocated for staging
paths for non-symlink cpio entries.

Separate symlink / non-symlink buffers are unnecessary, so just extend
the size of name_buf and use it for both.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6dd3b02c15d7e..59b4a43fa491b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -250,7 +250,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *name_buf;
 
 static int __init do_start(void)
 {
@@ -294,7 +294,7 @@ static int __init do_header(void)
 	if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
 			return 0;
-		collect = collected = symlink_buf;
+		collect = collected = name_buf;
 		remains = N_ALIGN(name_len) + body_len;
 		next_state = GotSymlink;
 		state = Collect;
@@ -512,10 +512,9 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	static __initdata char msg_buf[64];
 
 	header_buf = kmalloc(CPIO_HDRLEN, GFP_KERNEL);
-	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
-	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
-
-	if (!header_buf || !symlink_buf || !name_buf)
+	/* 2x PATH_MAX as @name_buf is also used for staging symlink targets */
+	name_buf = kmalloc(N_ALIGN(PATH_MAX) + PATH_MAX + 1, GFP_KERNEL);
+	if (!header_buf || !name_buf)
 		panic_show_mem("can't allocate buffers");
 
 	state = Start;
@@ -561,7 +560,6 @@ char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	}
 	dir_utime();
 	kfree(name_buf);
-	kfree(symlink_buf);
 	kfree(header_buf);
 	return message;
 }
-- 
2.43.0


