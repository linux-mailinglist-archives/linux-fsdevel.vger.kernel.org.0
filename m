Return-Path: <linux-fsdevel+bounces-1386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B67D9DEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7C61C210F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A7B39848;
	Fri, 27 Oct 2023 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SIKPOSEi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8xCkyzkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145938F86
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:23:47 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8B1A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 09:23:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF4361FEF5;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698423823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHMG5d4SUaL3ruGrEo76lgOLitJ/3Da+PIxSgbLeusY=;
	b=SIKPOSEiZgBz4I/O4ey8mWQ2vkmjF8uwIrv3MzK8vIb52p9RFmo3679SkzVNzIZ7AarMzU
	qw9KtboAeEVFvJY7rYlTO65YB+mEiSKVo3ycgVrvC5Sc1KbmwhZ5Gh/xCKN6x9ocMTT6FA
	NE7skRiw+uiNrtWhbR5wEQTsKEBSEfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698423823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHMG5d4SUaL3ruGrEo76lgOLitJ/3Da+PIxSgbLeusY=;
	b=8xCkyzkJnIKAwSEVEGZ3l/VvnQ76xoZ+tcBvb+TLIaIJdRyz0Np5dkL3sd4c79m9yOuIJl
	JzdyNJP+49LWkcDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAF0A1391C;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LcAyLQ/kO2X7NgAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 16:23:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39942A06E3; Fri, 27 Oct 2023 18:23:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] quota: Replace BUG_ON in dqput()
Date: Fri, 27 Oct 2023 18:23:37 +0200
Message-Id: <20231027162343.28366-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231027161930.27648-1-jack@suse.cz>
References: <20231027161930.27648-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=jack@suse.cz; h=from:subject; bh=6t9jOcFqT4xANRA3GvWM2Ww+FIx8dlrkh721hWqR8fA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlO+QJbxOQBhE3yPjHm1iuzlupr76vMqh8M0QNrE8Z Ecf/pZaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZTvkCQAKCRCcnaoHP2RA2a31CA Daeetv07UkloIj4U0fZpZyyn8HxgBrxub6VvAB2VaUa0SZRYVqFP5WYv/cgHhX6okUJAlVbuen//g3 jgkbgKteTqHGwDG8qy+TBHtkzXpSmC2Kcd76RvRlpmENSy/M+FRvWJbExXcnimpmlqLukzLwIW0x10 50XLf4lCwXR6UP0sGLiCSDr88jDkXq1/ZoEXMW7mNEZVfAY82vszJzH1EseMslzsx6c3FxSEDxCS0y ZIbgCBR0lQOYsOWS/o9Jy3VhCKicPCLRVxVUcHlpvRxb5/D6Bg24jewYq5hc3gz+xFVLbWv98qcbuF fOgD4NXz7J9rM/CUGsCSiNkvwDPJtv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]

The BUG_ON in dqput() will likely take the whole machine down when it
hits. Replace it with WARN_ON_ONCE() instead and stop hiding that behind
CONFIG_QUOTA_DEBUG.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 31e897ad5e6a..c0d778363435 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -881,10 +881,7 @@ void dqput(struct dquot *dquot)
 	}
 
 	/* Need to release dquot? */
-#ifdef CONFIG_QUOTA_DEBUG
-	/* sanity check */
-	BUG_ON(!list_empty(&dquot->dq_free));
-#endif
+	WARN_ON_ONCE(!list_empty(&dquot->dq_free));
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-- 
2.35.3


