Return-Path: <linux-fsdevel+bounces-9144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CBD83E807
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 01:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88081C20B3A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565C4A3D;
	Sat, 27 Jan 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eT6KPM+F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQZLtEWJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eT6KPM+F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kQZLtEWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9053A8;
	Sat, 27 Jan 2024 00:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706314245; cv=none; b=WmjI2St8FxoCB3a8RoInfJsh8utFfcJxRy3gDuTaJPKbvrcVKXByOfvD+FDOGqo2/bD349YJFI+mvJuuxV9pxfh87PQqMvNZg2vos51Ou8R6vt1ithFXXsmWMi/Uz1AHGKS/bD7MsUPzF+IdvoFOx8FRxdoK6pwKdEZGtC40cDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706314245; c=relaxed/simple;
	bh=tQnIuZs6POcxfs7tZTfV9KwuU/cnQIjacjvw31Vrbvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdB+mxFmWVDioUl9BgiTeR+yRFXVSIGuYwzyWMPjs3CFbWDL/9WgaWqRFI3+yyUoxlLzbxp1PZa0hzsK+rD6/RqZbvsizWgaTgGo/A5NR7od6PDwF3b/XYc8lxMVQiinl0bv6YMpMpSVyBu/BHN9Pw7GRDjL7UrCHc11N7FKmCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eT6KPM+F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQZLtEWJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eT6KPM+F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kQZLtEWJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 915CA1FDB8;
	Sat, 27 Jan 2024 00:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZCrOUp4n/eBPbinavPK6B+r0bHWbQ20H7Kc7iNUiVw=;
	b=eT6KPM+FMAU5IeLIpxOYN2I128O8z1jnvI2GRpwIlgqLgo/huantEdyHhXhUUrcvP+2n83
	do8oeGK06JPl322ekv9cvpObqr4CMK98jgopbLuQiYZjCxZMLtnGQqMzV2kpUP6b+qLlBQ
	qdaLKq1ZSw4V6n8kAe6hB6P6Q0DlEYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZCrOUp4n/eBPbinavPK6B+r0bHWbQ20H7Kc7iNUiVw=;
	b=kQZLtEWJo8myyfCR33d/bkax0GXApatqynGR0pEpyo+07wNlhFy4M/r0V0oPJZUCPnKsrL
	wbg/zdrM8dp9/kDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706314241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZCrOUp4n/eBPbinavPK6B+r0bHWbQ20H7Kc7iNUiVw=;
	b=eT6KPM+FMAU5IeLIpxOYN2I128O8z1jnvI2GRpwIlgqLgo/huantEdyHhXhUUrcvP+2n83
	do8oeGK06JPl322ekv9cvpObqr4CMK98jgopbLuQiYZjCxZMLtnGQqMzV2kpUP6b+qLlBQ
	qdaLKq1ZSw4V6n8kAe6hB6P6Q0DlEYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706314241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZCrOUp4n/eBPbinavPK6B+r0bHWbQ20H7Kc7iNUiVw=;
	b=kQZLtEWJo8myyfCR33d/bkax0GXApatqynGR0pEpyo+07wNlhFy4M/r0V0oPJZUCPnKsrL
	wbg/zdrM8dp9/kDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E20E013998;
	Sat, 27 Jan 2024 00:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z4aoJABKtGVtEQAAD6G6ig
	(envelope-from <krisman@suse.de>); Sat, 27 Jan 2024 00:10:40 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: ebiggers@kernel.org,
	viro@zeniv.linux.org.uk,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: amir73il@gmail.com,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v4 06/12] fscrypt: Ignore non-fscrypt volumes during d_move
Date: Fri, 26 Jan 2024 21:10:06 -0300
Message-ID: <20240127001013.2845-7-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127001013.2845-1-krisman@suse.de>
References: <20240127001013.2845-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eT6KPM+F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kQZLtEWJ
X-Spamd-Result: default: False [2.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.sourceforge.net,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[66.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.58
X-Rspamd-Queue-Id: 915CA1FDB8
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

Now that we do more than just clear the DCACHE_NOKEY_NAME in
fscrypt_handle_d_move, skip it entirely for volumes that don't need
fscrypt, to save the extra cost.

Note that fscrypt_handle_d_move is hopefully inlined back into __d_move,
so the call cost is not significant, and theefore we do the check in the
callee to avoid polluting the caller code with header guards.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 include/linux/fscrypt.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index c1e285053b3e..566362fdc3af 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -232,6 +232,10 @@ static inline bool fscrypt_needs_contents_encryption(const struct inode *inode)
  */
 static inline void fscrypt_handle_d_move(struct dentry *dentry)
 {
+	/* Ignore volumes that don't care about fscrypt. */
+	if (dentry->d_sb->s_cop)
+		return;
+
 	dentry->d_flags &= ~DCACHE_NOKEY_NAME;
 
 	/*
-- 
2.43.0


