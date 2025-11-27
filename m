Return-Path: <linux-fsdevel+bounces-70068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B065FC8FB5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B67F4ED159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FDF2EC094;
	Thu, 27 Nov 2025 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2MnWhdz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SVvozyYx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cCca6WIR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bufGjOP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20B3B2A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264687; cv=none; b=o09gK1JB2vw/7bn+IdfgMLqBTa3L45kg/KrDy2EdaikckUYADO4qlIyoW82PPbK7yh/UcU1VKGUx66UEwusdy31PRYbPTz1r5Z/uGWPPM5/EBPEpgPV1JreRGmFWA+qcCsQNcGdUCpWqSKWvhzqru3SZgG3xhlD7LR5PxoLt+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264687; c=relaxed/simple;
	bh=KkWwoGFhTV1dpHdkHONopXIoUYEXgtEzEx2FRmJy+rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guG7j8y4oRS3xWZyAhWXGizSrNsdkC3OyhQzgNhEzpUT80FFA+OszcJNfTPbAplLaXuLdzgGCnRhz3PSVcrMmpFm2b6ElFsv4m7j69UAAIpCYnYFdvGYeplHj2+sGihZiCeU52hh8mn2EuheJPM5txYPQaSfYUxZF/WENwdN8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2MnWhdz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SVvozyYx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cCca6WIR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bufGjOP+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B6F133698;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsABcWF3ZQx+hfnZZTwlhFAAQbXrDF5RvdR2H9cJd2A=;
	b=T2MnWhdzvNNw5MfywWhzd3QPs8txJLattwEUea7mfhXfIcafdSjBb94QaFu2gEld5Cl5WO
	aB4NM3dTNQAbXjIT5s6NdmKNcn3uLq4cpZXyW1qQqmKOHrJBo6/hZgCJ2FG+RAKmtVJvpk
	LoxgnVBD2d6KABbzAvOfi1pDE/Y98bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsABcWF3ZQx+hfnZZTwlhFAAQbXrDF5RvdR2H9cJd2A=;
	b=SVvozyYxcHrQetwgUmN8d0vtE3G6BG+oACL0/8lzEGNO+kxUCNkqcozNHLNqkhMVOpVcum
	EmqaOdyKI2wayNDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cCca6WIR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bufGjOP+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsABcWF3ZQx+hfnZZTwlhFAAQbXrDF5RvdR2H9cJd2A=;
	b=cCca6WIRv5lHPWRr0boXRdRh2t1u4NaaDpyN6zz0AQZNfny53zXnSGdMjy10uAih5KjOmX
	1aTwvnHzHjsV4yhhJGmftWRYQZjCTuAcyGgzyzVZXtcYdX21Zu9nHv/lh2eaFpXZ6bsko2
	eSVDWeeL+00Q1YkA7nTkcFEVgUUwxhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsABcWF3ZQx+hfnZZTwlhFAAQbXrDF5RvdR2H9cJd2A=;
	b=bufGjOP+ETQsBKrZFKnf5neDq+lzkSK9CcZA4G/hNUVoeASNYE6IWn9wKmQwPGIIxtaHH+
	PVIEbxpMH/v9C4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E8903EA6B;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +eP1GrKKKGmQPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 411B9A0CAE; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jakub Acs <acsjakub@amazon.de>
Subject: [PATCH 08/13] fsnotify: Shutdown fsnotify before destroying sb's dcache
Date: Thu, 27 Nov 2025 18:30:15 +0100
Message-ID: <20251127173012.23500-21-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=jack@suse.cz; h=from:subject; bh=KkWwoGFhTV1dpHdkHONopXIoUYEXgtEzEx2FRmJy+rA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqqP32UJjmbm2FYJQu/uXELQnyyTbeaZC3Bp xIvTMrVC3uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKqgAKCRCcnaoHP2RA 2UrrB/9kBise8t1QmLPeUmg8XQPFgKDPPdZrCucILLum09S8Zbx4tQnolXsaM2Co+RkbFZolZep r2RHxQRA+ssSVqtg+LasGW4JcYP0ZY8Lx1kd0WTapkY8Yh7n1OY0DFEQ2l69TnLL5ruIkJ011P2 xHCBnN3UfvvIO2iW1aX28iZecs2sYiDT1pgqpzi0QnESRNwN6V8KpuVqJc4Fe9F+sUHt1Nqjgq9 eY6/2VScffjy8bMfp7KzF6ONDkfglI4PLe11mq34ga18a4lgoGKyfmkMX07xiQU0vSgesb/WgB3 sOFWxfwtYxodKiLl5SBDCTgIhyOVpXrckbf2EIj5dzaTYVR7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,amazon.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,amazon.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3B6F133698
X-Rspamd-Action: no action
X-Spam-Flag: NO

Currently fsnotify_sb_delete() was called after we have evicted
superblock's dcache and inode cache. This was done mainly so that we
iterate as few inodes as possible when removing inode marks. However, as
Jakub reported, this is problematic because for some filesystems
encoding of file handles uses sb->s_root which gets cleared as part of
dcache eviction. And either delayed fsnotify events or reading fdinfo
for fsnotify group with marks on fs being unmounted may trigger encoding
of file handles during unmount. So move shutdown of fsnotify subsystem
before shrinking of dcache.

Reported-by: Jakub Acs <acsjakub@amazon.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 7f876f32343a..d1045bce0741 100644
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


