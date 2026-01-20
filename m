Return-Path: <linux-fsdevel+bounces-74640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDKlEb2NcWkLJAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 03:38:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1FE61012
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 03:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACAEF887E41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8B42B734;
	Tue, 20 Jan 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yhccgM+O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOcN25Qs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yhccgM+O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOcN25Qs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095F42981C
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915412; cv=none; b=ByLnkrI1Cz9JD0WyY3WFpAbD7ompuT+6kgtNrR7BMEQjSRshys/AgTbRh7tieUWSMB/TL9OvBerzyASVVI108wBy1Jj35NibyX4hWX34lxfLvhBo7pL5RlB941VB0BqCEQ9DIvNYMsK29lYILIE9fUvhHl6XbfwpoH90l6tkw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915412; c=relaxed/simple;
	bh=ic+ZTSXWQbc1YTNuKlNJrzbU0FJZ5TFelu1cLXH9AWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq28MCGQG+HFHNYtmUtblHcZVHMAx0S+OCyV/InA8AABTu1iROAr1fx4hHXonySP7vwCqRIhG+1DcF0yHHJA42IoJcIiBpXSyYPcMuQFfuRY6jhoX2yjWI7eNE5CPSgyC6QNqivKWNrgihx6YQvV/dOve9uyteg2PQcq17Q5kzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yhccgM+O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOcN25Qs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yhccgM+O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOcN25Qs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE2495BCC3;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768915401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B+R15AZV4cQ/DjAhipDBMEG/k1AoMPlU/8x9MhHOq8=;
	b=yhccgM+OKIdsJDlc5bqpZb8OBjojd2cEtOEprMNVjgat7r1L4h0O3BGVt7dYE6eE384fx+
	tCSk/bjJo6yEaTlYatH3G5u/vomk41vm6MzoiyLL7bplW8e+eVRtYLNvipVJRmqYIXK87e
	VMN3SVKocR0rbS8V/TBx7QWpS4BfoY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768915401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B+R15AZV4cQ/DjAhipDBMEG/k1AoMPlU/8x9MhHOq8=;
	b=xOcN25QsABBlf3uFM2VYw2nRPUYxJtB5ca5qPARbzIm1M6TjLmWrVNUWkn9SrRWCUcvyup
	tjT9VS96EmndLBAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768915401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B+R15AZV4cQ/DjAhipDBMEG/k1AoMPlU/8x9MhHOq8=;
	b=yhccgM+OKIdsJDlc5bqpZb8OBjojd2cEtOEprMNVjgat7r1L4h0O3BGVt7dYE6eE384fx+
	tCSk/bjJo6yEaTlYatH3G5u/vomk41vm6MzoiyLL7bplW8e+eVRtYLNvipVJRmqYIXK87e
	VMN3SVKocR0rbS8V/TBx7QWpS4BfoY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768915401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B+R15AZV4cQ/DjAhipDBMEG/k1AoMPlU/8x9MhHOq8=;
	b=xOcN25QsABBlf3uFM2VYw2nRPUYxJtB5ca5qPARbzIm1M6TjLmWrVNUWkn9SrRWCUcvyup
	tjT9VS96EmndLBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B08183EA67;
	Tue, 20 Jan 2026 13:23:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BpGIJ8mBb2knHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 13:23:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55C87A0A69; Tue, 20 Jan 2026 14:23:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jakub Acs <acsjakub@amazon.de>
Subject: [PATCH v2 3/3] fsnotify: Shutdown fsnotify before destroying sb's dcache
Date: Tue, 20 Jan 2026 14:23:11 +0100
Message-ID: <20260120132313.30198-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120131830.21836-1-jack@suse.cz>
References: <20260120131830.21836-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=jack@suse.cz; h=from:subject; bh=ic+ZTSXWQbc1YTNuKlNJrzbU0FJZ5TFelu1cLXH9AWU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpb4HDvoRykzevoAmG7HRuZGo7FMxQ/sK1tA5S+ 0BBZbnR8m+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW+BwwAKCRCcnaoHP2RA 2aeZCACufUhUtqzUbC91x41d0P/Tu1wODHfoArTMskVtMpRoYVpLAighjm+VsuBJ+izZkzeyiFP 2PKVP/XORJwvHyossnUECc8nP7KSwen8EOYBbqbKugpE1yEul4+L7QCHEDfPhXcyny2NuXxTg1k DCAuY3RSjwKSBrUvZ1Xl/fCFmHhdEsIVL+LgQwWDfvetqoklNfaq0sNAWHgeQnxsN6xkJfIAE1A WSqHgkhiHaialof7TuLoFUK8U6KtYLj0RjobC+OjbrjxdqrpFRB+LLeJeV00UKwETxz58kEbui3 Ncl0oCHArfpVmqJgPcC1jt3vdEy91A1Mcnns2gxLn4MRpDzp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	DATE_IN_PAST(1.00)[37];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,amazon.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74640-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B1FE61012
X-Rspamd-Action: no action

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


