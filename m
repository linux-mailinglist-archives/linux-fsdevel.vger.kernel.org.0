Return-Path: <linux-fsdevel+bounces-25336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8394AFB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9E11F22A51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EBB1428E6;
	Wed,  7 Aug 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QEv2/WA0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDgWZ+MC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W+zS8Szm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ho95xB0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020313E02E
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=CI6VXvTYmYH5XdSrFXHA+82IuC0G1vNcmLjlQhqFYXI9H57ni2rLSwuDO1pjju1Ip1lTxuEeVSR6zQBic80ypD9NJqhsSP90RKRwtgDKmvd40B/v38MVZc0TDYd1hRgq3yH6Y0kWfPxO9gP2Vv1qUhbdtlDZiTAz/UhrvPx0Cj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=NLbcVKvoZUnAjBOjxoi6Qb73AMZJY/JT/HFFKPHAeoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0OpYEqSq8E3w7vwiYyYjUjYDkyTB9jindY46bTdG5N8sz2prDxCdNDtZD90lj+9eWfrS2+pfvbw4m4VbrjEson+0DbWNFoSIlC6fzHVI4sGmbWpXsS9HGLZ+9UtGzOzTwthx7JBSXOVYGWoKEXbz2xVcyRRE7KnewwonLa1e5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QEv2/WA0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDgWZ+MC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W+zS8Szm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ho95xB0D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12F4A21C09;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2m+YEtDH4Y6yWo4pxzfKf/t1yicZeM+HgMLdn3QS2Q=;
	b=QEv2/WA0oWddAdux7iScEWG1hrtUtWRjwmyDyXceQi2scxi97irsxCYmhhUMHZbNq9EcnM
	93h6ifC9J2SSKs8zt5SXSLKhoEZmR+2TwA1ZmZlBTRbATh/uQvCCaRmq1B7gAEiOEYvGqI
	i6RtFm+4sQk30PZWTUY7VC21Lodpr8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2m+YEtDH4Y6yWo4pxzfKf/t1yicZeM+HgMLdn3QS2Q=;
	b=kDgWZ+MCDB2DqiI5dv3XqL8XQUQ0eExeqMG6XLSTWN9XDO8uc87ZRIlrumBbwcucGIvG2O
	mQR1HwnAH7/J6JDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2m+YEtDH4Y6yWo4pxzfKf/t1yicZeM+HgMLdn3QS2Q=;
	b=W+zS8Szm4RtgKo2+hS5GtIhJDVK9fkOcdZ1VSxGmTvdjzGxGKZ1SxOCDGOmPmEVSWXUr5I
	sP3n3XCDSmvxZTh9WOFs4xm1G6WJ/mZ1K7BmfonXzgD60y/WfYBwb7T/2aLhjyq0r04U6g
	/56w6nJ0cYgppsUcpqvQVP09oG1n+A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2m+YEtDH4Y6yWo4pxzfKf/t1yicZeM+HgMLdn3QS2Q=;
	b=Ho95xB0DXem6cAaiF66ImQXhGoEnPBtC23ByJHiGeh/3Pkq+1NJUrVneE21yC2hZ1kTRf7
	frw8axAuY4DRNeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0173A13B03;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G6AFACy9s2ZjNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 978B3A083F; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/13] fs: Define bit numbers for SB_I_ flags
Date: Wed,  7 Aug 2024 20:29:46 +0200
Message-Id: <20240807183003.23562-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=jack@suse.cz; h=from:subject; bh=NLbcVKvoZUnAjBOjxoi6Qb73AMZJY/JT/HFFKPHAeoI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70afo9cS29RY9ZnlVQR44SRDWP8Jh6kMj3mSZ7l w8hGs+eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9GgAKCRCcnaoHP2RA2RtMCA CG/Qz7t7j1RDHC978+XmKcLXuCSSGbMBTe9bETd5veCuWb3KomqgHIH8i9t6gLZ1wQNUnJgJwT+Ou/ fr6WF+mWvi6dgwOcrTq9k+iDIlV3okTd6vVO1kTNL+XY28+aSzHxYOwIWXuaqdAUul3huzj4Op2qaG Oi5RtNMDckz7OMClw7F5gIpESTAOsK2mmPRpfR+Ht+iwbB0xRjSl9Zhv7TBWlACvjXrBAnWPBA21KI Y37hgyRFuTeUm/49XEly6sFl1Kxxln3jNg7qdTQTz6rIy+MbvQtYIiZ7D1mCGWceEPQkf9vORIE2Da QCTV82wXeAKeRPP+nqUQuyEkPuw/Y6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
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
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spam-Level: 

sb->s_iflags has unclear locking rules. Some users modify it under
sb_lock, some under sb->s_umount rwsem, some without any lock.  Readers
are generally not holding any locks either. The flags are rarely
modified so this does not lead to any practical problems but it is a
mess. To reconcile the situation, handle sb->i_flags without any locks
by using atomic bit operations. Since the flags are rarely modified,
this does not introduce any noticeable performance overhead and resolves
all possible issues when different users of sb->s_iflags could possibly
stomp on each other's toes. Define new constants using bit numbers and
functions to tests, set and clear the flags.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..ff45a97b39cb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1190,6 +1190,25 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 
+enum {
+	_SB_I_CGROUPWB,		/* cgroup-aware writeback enabled */
+	_SB_I_NOEXEC,		/* Ignore executables on this fs */
+	_SB_I_NODEV,		/* Ignore devices on this fs */
+	_SB_I_STABLE_WRITES,	/* don't modify blks until WB is done */
+
+	/* sb->s_iflags to limit user namespace mounts */
+	_SB_I_USERNS_VISIBLE,	/* fstype already mounted */
+	_SB_I_IMA_UNVERIFIABLE_SIGNATURE,
+	_SB_I_UNTRUSTED_MOUNTER,
+	_SB_I_EVM_HMAC_UNSUPPORTED,
+
+	_SB_I_SKIP_SYNC,	/* Skip superblock at global sync */
+	_SB_I_PERSB_BDI,	/* has a per-sb bdi */
+	_SB_I_TS_EXPIRY_WARNED,	/* warned about timestamp range expiry */
+	_SB_I_RETIRED,		/* superblock shouldn't be reused */
+	_SB_I_NOUMASK,		/* VFS does not apply umask */
+};
+
 /* Possible states of 'frozen' field */
 enum {
 	SB_UNFROZEN = 0,		/* FS is unfrozen */
@@ -1351,6 +1370,21 @@ struct super_block {
 	struct list_head	s_inodes_wb;	/* writeback inodes */
 } __randomize_layout;
 
+static inline bool sb_test_iflag(const struct super_block *sb, int flag)
+{
+	return test_bit(flag, &sb->s_iflags);
+}
+
+static inline void sb_set_iflag(struct super_block *sb, int flag)
+{
+	set_bit(flag, &sb->s_iflags);
+}
+
+static inline void sb_clear_iflag(struct super_block *sb, int flag)
+{
+	clear_bit(flag, &sb->s_iflags);
+}
+
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
 {
 	return inode->i_sb->s_user_ns;
-- 
2.35.3


