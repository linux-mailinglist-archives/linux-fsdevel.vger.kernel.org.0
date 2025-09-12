Return-Path: <linux-fsdevel+bounces-61037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D2B54A08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B21A580116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A62EBB8C;
	Fri, 12 Sep 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W/xN2MlN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fW2QvyRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7662EBDFD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673540; cv=none; b=KBitv42vSYtIqAbQhjaY6pOsrwu1hhhwslK8048kwBhXkAPhZAvxZH1mMt1PnhqeMAmtNGWdccSq7K26YRNxzgShzs6z6kjbvIjWnjHb4trHEjU4/rrPL9zs7YXu1sHOstlg/p0ZZX8o1jbnU8m8qFNsK6TTX2VNYRp5pbnsKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673540; c=relaxed/simple;
	bh=+Xon4y7pY5wz3y5GH3Fi5M8lJfRx6HE38Qjag0qKG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6wpDGVMdSD8CQkDx2m5xEPtlERnHWCPvhKojHu4gkp6JiC4XvmWsnYQf5ulFh5hrfoUv75NfprTWR+o4cOrwcBn8s8Xswk/sR1pPB7lnwwaqf1Z1t0sVqdfiSHbMVl1t/F+h0rr6Z/czVBGMhzMCgJxK2SiAsXdgD196Dp4LY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W/xN2MlN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fW2QvyRP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DCF11F397;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757673530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSNyNyeWmoxMtpzAwvdqZb2nM9ZEVoafxAcYZubr5YE=;
	b=W/xN2MlNj1P+kHfFy05uvKmJO+uown8O6eOUMhhjwZB/O2q0nEBTjOh21g++DJuagNMU05
	4BZTiMuvNySZGqlrFL7iGLl2yxqUNSdBc7lwu7QTSAadXRePZlZbRJID7b8x1mdkPp5NEY
	t3DrFp6rr1UAE/b7AIecWMSTi1OLUhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757673530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSNyNyeWmoxMtpzAwvdqZb2nM9ZEVoafxAcYZubr5YE=;
	b=fW2QvyRPy4fId63JTUvNKhjdzP0HH8cDGC3vEAUxTae4dQAAJyY34oOOROiFRuYVagoi8+
	te8ikvnf8LJWMgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EF6D13ABD;
	Fri, 12 Sep 2025 10:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ulrDGjr4w2gmWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Sep 2025 10:38:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 196D9A0A5E; Fri, 12 Sep 2025 12:38:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 2/4] writeback: Avoid softlockup when switching many inodes
Date: Fri, 12 Sep 2025 12:38:36 +0200
Message-ID: <20250912103840.4844-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912103522.2935-1-jack@suse.cz>
References: <20250912103522.2935-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=jack@suse.cz; h=from:subject; bh=+Xon4y7pY5wz3y5GH3Fi5M8lJfRx6HE38Qjag0qKG4A=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBow/gxJE157pHUqVbqJwmQlDIHFuAQwuS4euyfv MdTVKiLkeWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMP4MQAKCRCcnaoHP2RA 2VDfCADMg/y88HPMA3peyKFb2poAJ9m47CukpC6Qrz8E+9PfDNveCKD2IadtVLlT71MQBVXD/Dx 6mub8QuC0OgfxkXB6hmsl9HqGFJCt/h6KahEe49a03ndbnBr/xOS4sET9t0wKFawGt5xSS5A2r/ dcnhkUZYriLP4x9aNoiVyieuzMber4UFz39/kn/5QEiNTamlroBmO815USbb2qnT5wOVEeZrovU TJLjJE3xYZBc5v4oRAyIBeM2wJnc8eJBkwW7Zj5GUhBao+/lB+zU1Z8JQBTqkO0O3eAh2TJpDXa KoZ0gCkpKVq2v0AD1OyvemRXrKwt1Ui1uSXyaiLo2idyYRxg
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7DCF11F397
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

process_inode_switch_wbs_work() can be switching over 100 inodes to a
different cgroup. Since switching an inode requires counting all dirty &
under-writeback pages in the address space of each inode, this can take
a significant amount of time. Add a possibility to reschedule after
processing each inode to avoid softlockups.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f2265aa9b4c2..40b42c385b55 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -500,6 +500,7 @@ static void process_inode_switch_wbs_work(struct bdi_writeback *new_wb,
 	 */
 	down_read(&bdi->wb_switch_rwsem);
 
+	inodep = isw->inodes;
 	/*
 	 * By the time control reaches here, RCU grace period has passed
 	 * since I_WB_SWITCH assertion and all wb stat update transactions
@@ -510,6 +511,7 @@ static void process_inode_switch_wbs_work(struct bdi_writeback *new_wb,
 	 * gives us exclusion against all wb related operations on @inode
 	 * including IO list manipulations and stat updates.
 	 */
+relock:
 	if (old_wb < new_wb) {
 		spin_lock(&old_wb->list_lock);
 		spin_lock_nested(&new_wb->list_lock, SINGLE_DEPTH_NESTING);
@@ -518,10 +520,17 @@ static void process_inode_switch_wbs_work(struct bdi_writeback *new_wb,
 		spin_lock_nested(&old_wb->list_lock, SINGLE_DEPTH_NESTING);
 	}
 
-	for (inodep = isw->inodes; *inodep; inodep++) {
+	while (*inodep) {
 		WARN_ON_ONCE((*inodep)->i_wb != old_wb);
 		if (inode_do_switch_wbs(*inodep, old_wb, new_wb))
 			nr_switched++;
+		inodep++;
+		if (*inodep && need_resched()) {
+			spin_unlock(&new_wb->list_lock);
+			spin_unlock(&old_wb->list_lock);
+			cond_resched();
+			goto relock;
+		}
 	}
 
 	spin_unlock(&new_wb->list_lock);
-- 
2.51.0


