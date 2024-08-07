Return-Path: <linux-fsdevel+bounces-25337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D615F94AFB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B901F22E28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1734F142E79;
	Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OlIHY11o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d2RbIBSV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OlIHY11o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d2RbIBSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2659F13E41F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=eRbF3gCjiv0utgVNHt6ml4kyyD9p/x46EG3mwHgwcm7JlHcM4+I7Ju93DoxtidcFmllq5nFshYmOa8EzbVpFOkjVFcCukrIMq+fSUi6kkDutuEFNleqjVhk3s8Slf1xN7aLmS47xNMGHtButbE3IP54S/8bIZow1QQyhGJZ0wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=DenUDpj3WqoI+B4EOpl4Crt9s0SwJCelBY3MVGTT8u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pmMCcokL7WmumtJmeqCeUVYL6qAv7yVE2lIalPuio9uCGmNbnH6tLthcNL1dsZPw2P80WbqynzC0G5obj9cQx+oTg2WaZQcSvAzkcQx3UtqOMNDXHntV2qgCw98WjeRpozB2RGrnv7ao3/pXwW0ulLeALz2ADQm27eYbibzmCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OlIHY11o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d2RbIBSV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OlIHY11o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d2RbIBSV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 869FD1FB9D;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCURvdHGtOg2D85NSVbPrAOjn4jDG7r8Kn9996m3dEE=;
	b=OlIHY11o6GrrUPX9Huj+n8G246yqmGYPnEuLWBDm3NsyBBjlC7avl+xPwsbMwqoTfCBCSI
	Neqrs0ZRyhD8t42N4ptoDkCubl8UzFQlPNULFjYL9nAohg4TGubTbLhIPGLYfaa0P5+3bx
	x7DQ/jQn3NDq2vz+ylDlsnZZ83bAj1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCURvdHGtOg2D85NSVbPrAOjn4jDG7r8Kn9996m3dEE=;
	b=d2RbIBSVV8RYbRFk4Ya52yHqF29rOtmASPFBlIsg8mCPe9Cjzqf4eBx/NdkDs4VIo4MSqS
	Pd/xP26w5R7HIiBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCURvdHGtOg2D85NSVbPrAOjn4jDG7r8Kn9996m3dEE=;
	b=OlIHY11o6GrrUPX9Huj+n8G246yqmGYPnEuLWBDm3NsyBBjlC7avl+xPwsbMwqoTfCBCSI
	Neqrs0ZRyhD8t42N4ptoDkCubl8UzFQlPNULFjYL9nAohg4TGubTbLhIPGLYfaa0P5+3bx
	x7DQ/jQn3NDq2vz+ylDlsnZZ83bAj1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCURvdHGtOg2D85NSVbPrAOjn4jDG7r8Kn9996m3dEE=;
	b=d2RbIBSVV8RYbRFk4Ya52yHqF29rOtmASPFBlIsg8mCPe9Cjzqf4eBx/NdkDs4VIo4MSqS
	Pd/xP26w5R7HIiBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C10C13B0C;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qh6rGSy9s2Z5NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B7402A086C; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/13] fs: Drop old SB_I_ constants
Date: Wed,  7 Aug 2024 20:29:50 +0200
Message-Id: <20240807183003.23562-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=jack@suse.cz; h=from:subject; bh=DenUDpj3WqoI+B4EOpl4Crt9s0SwJCelBY3MVGTT8u8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70ecNm9L336fzN53aq0+RButYd43MhRyoYgUsIu QXNdXjuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9HgAKCRCcnaoHP2RA2ffwB/ 4+mBEo6BlsbvpLv3ZPib91EFBXMxYw2bJ+z6ozXve7/g6jPbp3omH1/9BrRYxss+dmkX7x7vklgyFv efU+Z0wB9SU4c5vtG9aHgMiNHCXfKWw62lujt8wDaLTmyk8xNfLN7oOMerbDMcnjl3ESOFxGSe2a1y BIxO/HIZdl6HLuqLUJF7mdoe4J8NNngaxvggnA/A9AVTFNmHoZrHrqm8dRrEcg5lZ2Ufk7dZPZy774 K7rkxbJ1tB3KIO1g7iqsFLWW4C9K/DxE60IXsBwxpiQZGoTzDzWPv0dS/wn+pUSTv91ILJcCdU6nK4 wDn5D9f09hg18jUtJn8/tQViEj71u5
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.20 / 50.00];
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
X-Spam-Score: 0.20

Nothing is using the old SB_I_ constants anymore. Remove them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ff45a97b39cb..65e70ceb335e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1173,23 +1173,6 @@ extern int send_sigurg(struct fown_struct *fown);
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
 
 /* sb->s_iflags */
-#define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
-#define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
-#define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
-#define SB_I_STABLE_WRITES 0x00000008	/* don't modify blks until WB is done */
-
-/* sb->s_iflags to limit user namespace mounts */
-#define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
-#define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
-#define SB_I_UNTRUSTED_MOUNTER		0x00000040
-#define SB_I_EVM_HMAC_UNSUPPORTED	0x00000080
-
-#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
-#define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
-#define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
-#define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
-#define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
-
 enum {
 	_SB_I_CGROUPWB,		/* cgroup-aware writeback enabled */
 	_SB_I_NOEXEC,		/* Ignore executables on this fs */
-- 
2.35.3


