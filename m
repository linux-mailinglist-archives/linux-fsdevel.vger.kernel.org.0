Return-Path: <linux-fsdevel+bounces-25343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB894AFBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E581F22DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87F14389E;
	Wed,  7 Aug 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vyhgFbx7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F34hjzrQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="emaJVXh4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WP9BL+1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016E13CFA3
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055410; cv=none; b=qaeyrbdc9ulVZWRP76MIMcQWCdZvqN22bi9OreMrIfClHXOickb2lJEQJ8BVWQsNBCskETsajWEQM4KrIV8SniLVUTjBWN4OY1kUQ4rFUMPXnEdjKX+1RazISPbv8tN88xi5PB9ei4KhWqzdOJKsEbfVbotKjrar6PdhIx/Dl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055410; c=relaxed/simple;
	bh=K832h4ryVz+4yV7IucFzPLYGb+qGK8QI2p+mXEAWgCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sd7poqOjUD8JqdDaCn/9SO//MHgHiC96482Z9jxlJYyWnHI3P3OaUcyvymrC7KWLD9qKDSHqO+dnFWRSEv5MjGTYYRlatAXAoKUTyN9CuTwZvb1SnNOh/vSDxQmzn5TlQaJpxIa91S4M4Y9pZGd50Y7dWTkuS7vOlRWQ1pQ/WwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vyhgFbx7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F34hjzrQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=emaJVXh4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WP9BL+1E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C3E421C46;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MeDJ1VqQPReP+MdvN1Ue94VZEOCQEN5UAxnZWI5lRE=;
	b=vyhgFbx7q/0Rodzykh72pinyiXrOHOVTqDPtKb3F16oXgAR2iEDE95fj+YTt7y7cyyC2d0
	fLauzTOJFE0EUcGM3mHxts4cQYxPkaU5Wc8qeiyPU2zAsRclbOAPqztms56ByW5yiVTiVJ
	EzLQuTmNAc97l8ex/bhjZ3kDLuGbXS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MeDJ1VqQPReP+MdvN1Ue94VZEOCQEN5UAxnZWI5lRE=;
	b=F34hjzrQTjzNMUHx120i/xgUu3aWaHtn724mxADkbQnX7GTt94PUV8/lWuWL4YFE8m//Q/
	OweZPQavywXh3+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MeDJ1VqQPReP+MdvN1Ue94VZEOCQEN5UAxnZWI5lRE=;
	b=emaJVXh4UPlmoYcFKGSKTKgoFh0D/pl8KFZqmVtQaT162QU4mK37EFhS7V+FRucj3vw6Yi
	03b5pJqRXBG3Mv6GVNiubufThqByrSNz2El3vEGOzDx/9va7vuwdZsq/HiMHihZHGHIVwL
	dtJQslR+B0ZZoq08wZhCHQD1j84NaT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MeDJ1VqQPReP+MdvN1Ue94VZEOCQEN5UAxnZWI5lRE=;
	b=WP9BL+1EsAogfKTp3kHXBu/EWarsIoieWCckmnyuSykQ93tkyBnTaoZ4uJPxguKc8AxTG1
	2FguB06N/Ko4I4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C28813B06;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PQXyAiy9s2ZpNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7777A0853; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/13] fs: Convert mount_too_revealing() to new s_iflags handling functions
Date: Wed,  7 Aug 2024 20:29:48 +0200
Message-Id: <20240807183003.23562-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=jack@suse.cz; h=from:subject; bh=K832h4ryVz+4yV7IucFzPLYGb+qGK8QI2p+mXEAWgCU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70ctlWwsjzJ7w8sEny5iKEvPCtcFB7x5PJTgULW bpkt/TuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9HAAKCRCcnaoHP2RA2W23CA DAjJR2iHxbn65VUs+wNkK4w2DjwBA3s+jrEHyG8NjDKnq67AtRRAPrHTabdODLrimNBlvq5yK8v+7X nDDoeP1iqEfHsahnOHdmTZWwKjJf6GvGgr1LEA7a39iE6bu5RX4oz2lK6JKBZx72HACnoVIlVSHb3p kQ0RyR3VzJZxLSuGikAKBPH4FMikSMnY8l4UjVLR1aQCUs5PDPCdxupIpsRrNz51b5Z3h/keap4XSP 4eu00fkryUBlATTT6y3S+qiRqWbQK13E0xAqux6RmKwhiRNZAE/SGBrprLNBS4IrNFTAqwW6GSXxSd bXbFF4FO/x+sAwOHR4my+IRBBIrA6G
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Convert mount_too_revealing() to use the new functions for handling
sb->s_iflags and new bit constants.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/namespace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..75153f61a908 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5623,21 +5623,18 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
-	const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
-	unsigned long s_iflags;
 
 	if (ns->user_ns == &init_user_ns)
 		return false;
 
 	/* Can this filesystem be too revealing? */
-	s_iflags = sb->s_iflags;
-	if (!(s_iflags & SB_I_USERNS_VISIBLE))
+	if (!sb_test_iflag(sb, _SB_I_USERNS_VISIBLE))
 		return false;
 
-	if ((s_iflags & required_iflags) != required_iflags) {
-		WARN_ONCE(1, "Expected s_iflags to contain 0x%lx\n",
-			  required_iflags);
+	if (!sb_test_iflag(sb, _SB_I_NOEXEC) || !sb_test_iflag(sb, _SB_I_NODEV)) {
+		WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC and "
+			  "SB_I_NODEV\n");
 		return true;
 	}
 
-- 
2.35.3


