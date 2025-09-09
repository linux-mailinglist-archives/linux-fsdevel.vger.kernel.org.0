Return-Path: <linux-fsdevel+bounces-60674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB4B4FFCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BCD1C2585E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C80350D61;
	Tue,  9 Sep 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smiwocHe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a3N+C6eM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smiwocHe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a3N+C6eM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D4350835
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429079; cv=none; b=q5zfpmS9WjdpQx1ylqLrstq2qDRme/Wrp/LBGdPNFrxz89YpqGXdt7rG17gO75OqgHRK2R39G48oTtP/ZPtbJqgVdHaU0oMh3CffVKtLZsp6rMItW6ncN0CQMBuXjg9Q8lYiz4QcynAfGIhcteIJL1qcRPaOCOZt5wviKppH+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429079; c=relaxed/simple;
	bh=lokSPpKsVNkhctsIEkyZ5IzqSrhsQMevoC6fFM+/eJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKhcrssFvuH0wpzxYI/v1viuXEHMLa4axGsjH0H0PZeJk5s46kTBCLN1NrJbkWDmRk55QZlGHlpKjNZRcTSmoUmbr7i33ps6asO5AA0/IfunW0oplOKzOFpkbzryJhAnYLcenS2ETc7HTsJa6hW3y08U6oZnXLNgJlwIWbn+058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smiwocHe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a3N+C6eM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smiwocHe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a3N+C6eM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDACE34FEF;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/39hT10O6P59Fty5QjgEDDUND5e3nXQhgf/N4xYIKVU=;
	b=smiwocHeXwNnAJbDpfkXQbHbI0nsP/6bHQWv2rFnMQ/HWuHukCKIiQzAmtHmuw3y9huxRK
	AYpWPnxycIeNO3Dj3QKxZJra6EAu9CuA9qp73am0i6v5TP6cWo/4uGW17OsCQk4Nt4BLqt
	p1+pau6o8WV4DFgWUMBmaa8xiPQK3a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/39hT10O6P59Fty5QjgEDDUND5e3nXQhgf/N4xYIKVU=;
	b=a3N+C6eM+Es2NNLv1aJaYnNtztHrs/OQ3y4RfQgrT5aGRNEAth25Idvc6k9juR2I0AhboP
	O+6JIe43sNA8zJCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=smiwocHe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a3N+C6eM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757429070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/39hT10O6P59Fty5QjgEDDUND5e3nXQhgf/N4xYIKVU=;
	b=smiwocHeXwNnAJbDpfkXQbHbI0nsP/6bHQWv2rFnMQ/HWuHukCKIiQzAmtHmuw3y9huxRK
	AYpWPnxycIeNO3Dj3QKxZJra6EAu9CuA9qp73am0i6v5TP6cWo/4uGW17OsCQk4Nt4BLqt
	p1+pau6o8WV4DFgWUMBmaa8xiPQK3a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757429070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/39hT10O6P59Fty5QjgEDDUND5e3nXQhgf/N4xYIKVU=;
	b=a3N+C6eM+Es2NNLv1aJaYnNtztHrs/OQ3y4RfQgrT5aGRNEAth25Idvc6k9juR2I0AhboP
	O+6JIe43sNA8zJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD5E413A56;
	Tue,  9 Sep 2025 14:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id clbnNU09wGiVdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 14:44:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 76048A0A7B; Tue,  9 Sep 2025 16:44:29 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/4] writeback: Avoid softlockup when switching many inodes
Date: Tue,  9 Sep 2025 16:44:03 +0200
Message-ID: <20250909144400.2901-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909143734.30801-1-jack@suse.cz>
References: <20250909143734.30801-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=jack@suse.cz; h=from:subject; bh=lokSPpKsVNkhctsIEkyZ5IzqSrhsQMevoC6fFM+/eJY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowD0xbD4VCIx9/r269m/0taQEDSufOgqbd5xld /tyBwz+002JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMA9MQAKCRCcnaoHP2RA 2WgYCACoX4LmqBCX/vUHDMUFURgJfvVy69cc778nc0VHd5UeQ3usQjkyXQ8mlZEYGyGsk82TgLr JZJDo9P8IZ41y138bLbPbF/YCYymUBR7zEW7bYVafTiYIGctw3T8zvtEN2RTNle6cqUdhn2GCrW s9LiveaxXneMuR3NgBXNgAz5TnCPgCvA6p2nkm123n/EK2gDr0ACDWHqqKm6BR4BRaBANCpYfBQ mQXYWvQ6Xe4MK09s4IQpha2CB1aTPvuB9VlpM9ClYV7XPlRdFs/DREDq6Bbt1jq5n313J57FR0B HyNupMxwLJPbczFzGbPII2yWj6YDloAbmaqxwHBki9GmT5Vk
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EDACE34FEF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

process_inode_switch_wbs_work() can be switching over 100 inodes to a
different cgroup. Since switching an inode requires counting all dirty &
under-writeback pages in the address space of each inode, this can take
a significant amount of time. Add a possibility to reschedule after
processing each inode to avoid softlockups.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3f3e6efd5d78..125f477c34c1 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -502,6 +502,7 @@ static void process_inode_switch_wbs_work(struct inode_switch_wbs_context *isw)
 	 */
 	down_read(&bdi->wb_switch_rwsem);
 
+	inodep = isw->inodes;
 	/*
 	 * By the time control reaches here, RCU grace period has passed
 	 * since I_WB_SWITCH assertion and all wb stat update transactions
@@ -512,6 +513,7 @@ static void process_inode_switch_wbs_work(struct inode_switch_wbs_context *isw)
 	 * gives us exclusion against all wb related operations on @inode
 	 * including IO list manipulations and stat updates.
 	 */
+relock:
 	if (old_wb < new_wb) {
 		spin_lock(&old_wb->list_lock);
 		spin_lock_nested(&new_wb->list_lock, SINGLE_DEPTH_NESTING);
@@ -520,10 +522,17 @@ static void process_inode_switch_wbs_work(struct inode_switch_wbs_context *isw)
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


