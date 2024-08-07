Return-Path: <linux-fsdevel+bounces-25342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35894AFBD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70F81C219ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0304914386B;
	Wed,  7 Aug 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PFucV6ho";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0ENRQgi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PFucV6ho";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L0ENRQgi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012313A25F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055410; cv=none; b=kzz+UUZSAmlPOjhxrKk4Dt83a05+sifgaKcf5UTEMSGMoHhj1ttBU4jLBsWCR7d2+CjFFMs6cFMCnqI9xHhNQADAPyNcpKWRZhhOJHdrc6CtXRUJ+kUqNst+uPjOtGdNBSRHliHrp3jGCZH9ZRhMTLL38eKhyn670zuS9+MJlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055410; c=relaxed/simple;
	bh=ZxNDo9aPYuap3mVBwDH3tYSQoLhuYnF5doB8nHtl+JA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RL7u2UZ5FodTL79yfSfEqj2qmgL2WmNk1j8X/1xHLk4uL1+pMgD56Mo4cJW2oPkRkVpjMiMvHLZNang2Upx9AU8oAmABmIRV6NGk2mEx3Lt0MzJYzEP//qo7olnOYehNYQQ2JvgTObCL3TwRMMqi67zHjTve7T+Cb2PWysJgLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PFucV6ho; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0ENRQgi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PFucV6ho; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L0ENRQgi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B35A21D0A;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW2UxCUvrHl1YGAPkqecYDBFUh/CQI21/j3ziGvYNDg=;
	b=PFucV6hoTnlAXOby9AtXtQ4ZI9pLI/G476xTV6hWrQ18ipZHYjuO36Fi8gtf9RRaV9EW2t
	69fEnQKSRxaTE3pKNzMJ8cXjpxB6uNRipF3rQIUJ0DZIu1asffcjdHhRo3njL3nL5m5tGA
	CvzuhHNeLLuNzcnDJt9OxCT0xJIozW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW2UxCUvrHl1YGAPkqecYDBFUh/CQI21/j3ziGvYNDg=;
	b=L0ENRQgi6fKJ/XLgDqJ/hU+Dk2htxYbHxEdaIvbeXi7Od+ik4PgOUD4F0mxp6KsJ7UrBKW
	QkX+HhH8SvCWiVAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PFucV6ho;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L0ENRQgi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW2UxCUvrHl1YGAPkqecYDBFUh/CQI21/j3ziGvYNDg=;
	b=PFucV6hoTnlAXOby9AtXtQ4ZI9pLI/G476xTV6hWrQ18ipZHYjuO36Fi8gtf9RRaV9EW2t
	69fEnQKSRxaTE3pKNzMJ8cXjpxB6uNRipF3rQIUJ0DZIu1asffcjdHhRo3njL3nL5m5tGA
	CvzuhHNeLLuNzcnDJt9OxCT0xJIozW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW2UxCUvrHl1YGAPkqecYDBFUh/CQI21/j3ziGvYNDg=;
	b=L0ENRQgi6fKJ/XLgDqJ/hU+Dk2htxYbHxEdaIvbeXi7Od+ik4PgOUD4F0mxp6KsJ7UrBKW
	QkX+HhH8SvCWiVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87ACD13B17;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wo/rICy9s2aHNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 045B9A08AF; Wed,  7 Aug 2024 20:30:04 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/13] ext4: Replace EXT4_FLAGS_SHUTDOWN flag with a generic SB_I_SHUTDOWN
Date: Wed,  7 Aug 2024 20:29:58 +0200
Message-Id: <20240807183003.23562-13-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=jack@suse.cz; h=from:subject; bh=ZxNDo9aPYuap3mVBwDH3tYSQoLhuYnF5doB8nHtl+JA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70lzOwmwCWccOu1v76WslcFyhi1SbCUW/tC6peM YF+ERPmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9JQAKCRCcnaoHP2RA2ev5B/ 9r8kEBeEQDB0os5i6BQ3HtJIHQx2eqQStJwRMLVhBa94sorP2BUXlX765VkaUuvTwrYUVT4BpFHimY MOWD59MWrdqi7c21KnS8p2KVA6uiILp1eT5olh5L+3Rfvyy3os1Sfr67pq44UvJ6XhglWWHQ2d70+M boS1cxPyRB2qXyNhu6KVLUZl0O8MSlmGqesI1HRmUW2GQ5K+aHCIE0CA4m7AhHhcDwwRSDCpa7yQIj baqjkBrdE8JoSJRU3FKT3948NKAm6DvXA2eoDZhnj3GPwNfZStTWXQY8ih2Dv18Cg0axlVATxusnEm 58bbAcC869lQ/IQFaq7uoYEawNkRIY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8B35A21D0A
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Instead of using private ext4 EXT4_FLAGS_SHUTDOWN flag, use a generic
variant SB_I_SHUTDOWN. As a bonus VFS will now refuse modification
attempts for the filesystem when the flag is set.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  3 +--
 fs/ext4/ioctl.c |  6 +++---
 fs/ext4/super.c | 11 +++++------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd152261e..7a3ea125ec86 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2240,12 +2240,11 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
  * Superblock flags
  */
 #define EXT4_FLAGS_RESIZING	0
-#define EXT4_FLAGS_SHUTDOWN	1
 #define EXT4_FLAGS_BDEV_IS_DAX	2
 
 static inline int ext4_forced_shutdown(struct super_block *sb)
 {
-	return test_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
+	return sb_test_iflag(sb, SB_I_SHUTDOWN);
 }
 
 /*
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8bf5972dd47..086bc239ff33 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -822,18 +822,18 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
 		ret = bdev_freeze(sb->s_bdev);
 		if (ret)
 			return ret;
-		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
+		sb_set_iflag(sb, SB_I_SHUTDOWN);
 		bdev_thaw(sb->s_bdev);
 		break;
 	case EXT4_GOING_FLAGS_LOGFLUSH:
-		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
+		sb_set_iflag(sb, SB_I_SHUTDOWN);
 		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal)) {
 			(void) ext4_force_commit(sb);
 			jbd2_journal_abort(sbi->s_journal, -ESHUTDOWN);
 		}
 		break;
 	case EXT4_GOING_FLAGS_NOLOGFLUSH:
-		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
+		sb_set_iflag(sb, SB_I_SHUTDOWN);
 		if (sbi->s_journal && !is_journal_aborted(sbi->s_journal))
 			jbd2_journal_abort(sbi->s_journal, -ESHUTDOWN);
 		break;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b5b2f17f1b65..928d8eb266f0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -701,7 +701,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		WARN_ON_ONCE(1);
 
 	if (!continue_fs && !sb_rdonly(sb)) {
-		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
+		sb_set_iflag(sb, SB_I_SHUTDOWN);
 		if (journal)
 			jbd2_journal_abort(journal, -EIO);
 	}
@@ -735,11 +735,10 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 	/*
-	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
-	 * modifications. We don't set SB_RDONLY because that requires
-	 * sb->s_umount semaphore and setting it without proper remount
-	 * procedure is confusing code such as freeze_super() leading to
-	 * deadlocks and other problems.
+	 * SB_I_SHUTDOWN was set which stops all filesystem modifications. We
+	 * don't set SB_RDONLY because that requires sb->s_umount semaphore and
+	 * setting it without proper remount procedure is confusing code such
+	 * as freeze_super() leading to deadlocks and other problems.
 	 */
 }
 
-- 
2.35.3


