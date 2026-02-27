Return-Path: <linux-fsdevel+bounces-78718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP3yNQWroWm1vQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:32:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE481B9026
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2BFA3019CAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 14:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D572C1598;
	Fri, 27 Feb 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBkMZQY0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/yUo8dPI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBkMZQY0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/yUo8dPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE2238C1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202487; cv=none; b=U0UoyOhV74CuvaDX9GS0zb6zev2M0dzm5wsDrOQOKXyYiZEN9mXEPy0oqGxZQDWH1G47MkPBHCK/8YJQVOmWXc3zDN6WtWmDE96cc+CBns3cG10hYHbFwbRQeUTsYNVcgz/PWRRcIX4gdSHKDqmF8zd6BgR572xYwQZUDNxIwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202487; c=relaxed/simple;
	bh=+nVEdOmJkGJZNjkDjRddOwBhEMoZVl51iafnz5c2Wrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+Il7vJwN0yKBY1fjwg9KoMq3SC5ZxA4DWH3Wvt6fJo3oaMrLWHLIuD8oBYOT/R901uwSgZefDjtkUqx4urb3rWhQLSSDGQx805LLGTp0H38yVpQI1Qhl2ol8QsvLMH4ioqBlPbf6bzq+w3VoVs3i1uUGmMb9GTIDEMcLiZfVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBkMZQY0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/yUo8dPI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBkMZQY0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/yUo8dPI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 012665D6C8;
	Fri, 27 Feb 2026 14:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772202483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IzUdZpCslYW9KcHYK/QEaOL7KjWpgGG717+tFDlnDxo=;
	b=wBkMZQY0VmHFt2nfVt08SaJEaz1uTItmEHrwWyXPK0BNAEqbUQi1W5c5GODtt89EtmL/5Y
	GZQYffRgSaV29oK21SpRf2y/vVK87MWgY95E9NV2cgv6FZ6UcSzz8zQ2bgOXVqI+yn3D7q
	K8YEqcypA1pBfpb1O7+vfqsm7ZN5bTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772202483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IzUdZpCslYW9KcHYK/QEaOL7KjWpgGG717+tFDlnDxo=;
	b=/yUo8dPI/eeVXV8UancZkJSi4LjKLzcaBLGMsgbuwdxEAaGgiRdnLZN2yHkXMd5sMQlr0k
	CpvMeFoXUIG/MYCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772202483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IzUdZpCslYW9KcHYK/QEaOL7KjWpgGG717+tFDlnDxo=;
	b=wBkMZQY0VmHFt2nfVt08SaJEaz1uTItmEHrwWyXPK0BNAEqbUQi1W5c5GODtt89EtmL/5Y
	GZQYffRgSaV29oK21SpRf2y/vVK87MWgY95E9NV2cgv6FZ6UcSzz8zQ2bgOXVqI+yn3D7q
	K8YEqcypA1pBfpb1O7+vfqsm7ZN5bTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772202483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IzUdZpCslYW9KcHYK/QEaOL7KjWpgGG717+tFDlnDxo=;
	b=/yUo8dPI/eeVXV8UancZkJSi4LjKLzcaBLGMsgbuwdxEAaGgiRdnLZN2yHkXMd5sMQlr0k
	CpvMeFoXUIG/MYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E01C63EA69;
	Fri, 27 Feb 2026 14:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pHayNvKpoWkyaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 14:28:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9A66A06D4; Fri, 27 Feb 2026 15:28:02 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Sam Sun <samsun1006219@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] quota: Fix race of dquot_scan_active() with quota deactivation
Date: Fri, 27 Feb 2026 15:27:43 +0100
Message-ID: <20260227142742.18396-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5063; i=jack@suse.cz; h=from:subject; bh=+nVEdOmJkGJZNjkDjRddOwBhEMoZVl51iafnz5c2Wrc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpoane/E1dVf7RQcUgsbae4IScbl+C09cT2JEuP onEl60GcjuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaGp3gAKCRCcnaoHP2RA 2fR2B/wIp4hDyRfAK4hurb3ezPvf1djGHNXx2EwjNolwpXucTEoXC9hLM/tJr+8+9grBz4aJQfF 29AzMHgg2d4c3DsowNmfCXpAi3vK7P3c5+Ecchk9TVNwRR0LIo736FjiasizUHIm1tWed2twwXb 3jziNPvWxotBaKs8DkKaDA01OTCGz40CXxZ5P6Kwb0Darhy3SgSD/NsKas9fQKHchTf4tkh/b/6 CnrQMhFnRA7rjUN3qeYrEj9ycz7DqS3CP/Aq6SxEKpxL7v+lQdg15vCNHCgTnnLLtEDapWAQODz 305rGnpzM71Jlhnp8+xNJOVrkH4TRMZJl3nu9hTptXyuM27j
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78718-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6EE481B9026
X-Rspamd-Action: no action

dquot_scan_active() can race with quota deactivation in
quota_release_workfn() like:

  CPU0 (quota_release_workfn)         CPU1 (dquot_scan_active)
  ==============================      ==============================
  spin_lock(&dq_list_lock);
  list_replace_init(
    &releasing_dquots, &rls_head);
    /* dquot X on rls_head,
       dq_count == 0,
       DQ_ACTIVE_B still set */
  spin_unlock(&dq_list_lock);
  synchronize_srcu(&dquot_srcu);
                                      spin_lock(&dq_list_lock);
                                      list_for_each_entry(dquot,
                                          &inuse_list, dq_inuse) {
                                        /* finds dquot X */
                                        dquot_active(X) -> true
                                        atomic_inc(&X->dq_count);
                                      }
                                      spin_unlock(&dq_list_lock);
  spin_lock(&dq_list_lock);
  dquot = list_first_entry(&rls_head);
  WARN_ON_ONCE(atomic_read(&dquot->dq_count));

The problem is not only a cosmetic one as under memory pressure the
caller of dquot_scan_active() can end up working on freed dquot.

Fix the problem by making sure the dquot is removed from releasing list
when we acquire a reference to it.

Fixes: 869b6ea1609f ("quota: Fix slow quotaoff")
Reported-by: Sam Sun <samsun1006219@gmail.com>
Link: https://lore.kernel.org/all/CAEkJfYPTt3uP1vAYnQ5V2ZWn5O9PLhhGi5HbOcAzyP9vbXyjeg@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c         | 38 ++++++++++++++++++++++++++++++--------
 include/linux/quotaops.h |  9 +--------
 2 files changed, 31 insertions(+), 16 deletions(-)

I plan to merge this fix through my tree.

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 376739f6420e..64cf42721496 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -363,6 +363,31 @@ static inline int dquot_active(struct dquot *dquot)
 	return test_bit(DQ_ACTIVE_B, &dquot->dq_flags);
 }
 
+static struct dquot *__dqgrab(struct dquot *dquot)
+{
+	lockdep_assert_held(&dq_list_lock);
+	if (!atomic_read(&dquot->dq_count))
+		remove_free_dquot(dquot);
+	atomic_inc(&dquot->dq_count);
+	return dquot;
+}
+
+/*
+ * Get reference to dquot when we got pointer to it by some other means. The
+ * dquot has to be active and the caller has to make sure it cannot get
+ * deactivated under our hands.
+ */
+struct dquot *dqgrab(struct dquot *dquot)
+{
+	spin_lock(&dq_list_lock);
+	WARN_ON_ONCE(!dquot_active(dquot));
+	dquot = __dqgrab(dquot);
+	spin_unlock(&dq_list_lock);
+
+	return dquot;
+}
+EXPORT_SYMBOL_GPL(dqgrab);
+
 static inline int dquot_dirty(struct dquot *dquot)
 {
 	return test_bit(DQ_MOD_B, &dquot->dq_flags);
@@ -641,15 +666,14 @@ int dquot_scan_active(struct super_block *sb,
 			continue;
 		if (dquot->dq_sb != sb)
 			continue;
-		/* Now we have active dquot so we can just increase use count */
-		atomic_inc(&dquot->dq_count);
+		__dqgrab(dquot);
 		spin_unlock(&dq_list_lock);
 		dqput(old_dquot);
 		old_dquot = dquot;
 		/*
 		 * ->release_dquot() can be racing with us. Our reference
-		 * protects us from new calls to it so just wait for any
-		 * outstanding call and recheck the DQ_ACTIVE_B after that.
+		 * protects us from dquot_release() proceeding so just wait for
+		 * any outstanding call and recheck the DQ_ACTIVE_B after that.
 		 */
 		wait_on_dquot(dquot);
 		if (dquot_active(dquot)) {
@@ -717,7 +741,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
 			 * use count */
-			dqgrab(dquot);
+			__dqgrab(dquot);
 			spin_unlock(&dq_list_lock);
 			err = dquot_write_dquot(dquot);
 			if (err && !ret)
@@ -963,9 +987,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 		spin_unlock(&dq_list_lock);
 		dqstats_inc(DQST_LOOKUPS);
 	} else {
-		if (!atomic_read(&dquot->dq_count))
-			remove_free_dquot(dquot);
-		atomic_inc(&dquot->dq_count);
+		__dqgrab(dquot);
 		spin_unlock(&dq_list_lock);
 		dqstats_inc(DQST_CACHE_HITS);
 		dqstats_inc(DQST_LOOKUPS);
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index c334f82ed385..f9c0f9d7c9d9 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -44,14 +44,7 @@ int dquot_initialize(struct inode *inode);
 bool dquot_initialize_needed(struct inode *inode);
 void dquot_drop(struct inode *inode);
 struct dquot *dqget(struct super_block *sb, struct kqid qid);
-static inline struct dquot *dqgrab(struct dquot *dquot)
-{
-	/* Make sure someone else has active reference to dquot */
-	WARN_ON_ONCE(!atomic_read(&dquot->dq_count));
-	WARN_ON_ONCE(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
-	atomic_inc(&dquot->dq_count);
-	return dquot;
-}
+struct dquot *dqgrab(struct dquot *dquot);
 
 static inline bool dquot_is_busy(struct dquot *dquot)
 {
-- 
2.51.0


