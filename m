Return-Path: <linux-fsdevel+bounces-74865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C3jDGXncGmjawAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:49:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C147458BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 780376C276E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF5D2F693B;
	Wed, 21 Jan 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tonz3LCx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RHtZ6ETH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDE83A14
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004018; cv=none; b=FE6QsnLMlNlpE8UeoUXe93gnVbisLOwdT+2qNEMHm2rsm/vJrVDQ5+K93dSalRIgNnEXduMCs2HnnyOLp0rRTUOHRgx2DWCxm5Wf6TlMWdm3Y8sU7MpPD1cK5opXT2K/W42GgRD2dwN0M45anFhTWRxNBOGvzseCMUA/zt76yC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004018; c=relaxed/simple;
	bh=ic+ZTSXWQbc1YTNuKlNJrzbU0FJZ5TFelu1cLXH9AWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGOOE3958AHvXbcY/4xu9NAOgQ3ilMxQ3M5hDR9MqfJq0S3BhsZTrdp0o6V4kGV6IYgGFIoFCddgUtOdlV+MZh0L1CeMfwcebBw52cNEisQGN6WYDfxkVDwB9RTcvSXETU9vQvzg7lsxLD5XE4t3fsb0/3kRNEcHWIRT3LiuZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tonz3LCx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RHtZ6ETH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F09545BD15;
	Wed, 21 Jan 2026 14:00:00 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769004000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B+R15AZV4cQ/DjAhipDBMEG/k1AoMPlU/8x9MhHOq8=;
	b=tonz3LCxY0spSNnSPqGLKHMgYcec6IqANmEiK4xlx+mmYq4ukppR20Rs5mF3499/TO3lnK
	ey+txi15NnViBZ273yB0UYwafAkvZCxDCMh52tOEcDtTSok2tCqBPCnbsJtH5n5zmVTgDz
	iU3nDG5inwqoPBfoIHqK1cvQLRef8UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769004000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B+R15AZV4cQ/DjAhipDBMEG/k1AoMPlU/8x9MhHOq8=;
	b=RHtZ6ETHHHty4A+ZIdpjyza+dLMflRBkXuMxyDW7Uwhye/0K1FbnGlBzoF39Ufd2u3Pl6G
	gabWdCChviiCzOCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E58F83EA66;
	Wed, 21 Jan 2026 14:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OqDcN+DbcGmaTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 14:00:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE017A0A5E; Wed, 21 Jan 2026 14:59:56 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jakub Acs <acsjakub@amazon.de>
Subject: [PATCH v3 3/3] fsnotify: Shutdown fsnotify before destroying sb's dcache
Date: Wed, 21 Jan 2026 14:59:44 +0100
Message-ID: <20260121135948.8448-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121135513.12008-1-jack@suse.cz>
References: <20260121135513.12008-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=jack@suse.cz; h=from:subject; bh=ic+ZTSXWQbc1YTNuKlNJrzbU0FJZ5TFelu1cLXH9AWU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpcNvWvoRykzevoAmG7HRuZGo7FMxQ/sK1tA5S+ 0BBZbnR8m+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaXDb1gAKCRCcnaoHP2RA 2bFsB/9bgcjbgGhFS9ZxJVQVRwrgQ3rXN18o5VyxfDNZ6A5nmoq1VWbD0+NU61uShXoASwBlyf4 9TG1fbB71yAsnHfHSCEkMrqTduJAIJ0+Rs4M/7hKHi9JM/LL6E5yrbY4o89Dc48ewi2OWlJRJq6 uhUx2ri5sbFCoIjosoHjFTzaCmpdWyXnFxM7T6JTvFiPv1dUS1O5fernK1T+5v/FaIW5sdpKh07 AAGvMRABcptyIbgXC9pGhTleEhZ1s74lZ7G2mfxOuGS3QI1Er0BubzjwVtkLsp98xmXr2eKaMJW jtW+yk8+GTyoRlWa0orgiGqcuzYNUECMkhiH3Xm2dCgZQz0D
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,amazon.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74865-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid,amazon.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C147458BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently fsnotify_sb_delete() was called after we have evicted
superblock's dcache and inode cache. This was done mainly so that we
iterate as few inodes as possible when removing inode marks. However, as
Jakub reported, this is problematic because for some filesystems
encoding of file handles uses sb->s_root which gets cleared as part of
dcache eviction. And either delayed fsnotify events or reading fdinfo
for fsnotify group with marks on fs being unmounted may trigger encoding
of file handles during unmount. So move shutdown of fsnotify subsystem
before shrinking of dcache.

Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com/
Reported-by: Jakub Acs <acsjakub@amazon.de>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3d85265d1400..9c13e68277dd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -618,6 +618,7 @@ void generic_shutdown_super(struct super_block *sb)
 	const struct super_operations *sop = sb->s_op;
 
 	if (sb->s_root) {
+		fsnotify_sb_delete(sb);
 		shrink_dcache_for_umount(sb);
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
@@ -629,9 +630,8 @@ void generic_shutdown_super(struct super_block *sb)
 
 		/*
 		 * Clean up and evict any inodes that still have references due
-		 * to fsnotify or the security policy.
+		 * to the security policy.
 		 */
-		fsnotify_sb_delete(sb);
 		security_sb_delete(sb);
 
 		if (sb->s_dio_done_wq) {
-- 
2.51.0


