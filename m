Return-Path: <linux-fsdevel+bounces-1385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FB97D9DEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C931C210B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFDC39846;
	Fri, 27 Oct 2023 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xuBMh8NN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4mcm1SZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A838BD9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:23:47 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB23129
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 09:23:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D43E521CA3;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698423823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx/Nf9CxSU9qwDuTJtA10LvYYXvqXuRU4zJwoIDPysA=;
	b=xuBMh8NNcH6ly+LiZl+jpZR+v2w+JaReziJFzJ1ict5VnowVnkaRfWXtiLsRtq2T0uHhkc
	UF5572fufrqtsFL0VkPthzz7lXfwQp2JEMiEYQ5OJ0iFiK8S2scnTHoqGKbnC8nrY7ks0N
	0MA3cTNHM/HHnjHdRnTsjGtTNzypU9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698423823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gx/Nf9CxSU9qwDuTJtA10LvYYXvqXuRU4zJwoIDPysA=;
	b=4mcm1SZKQag5+BIfXcXqOa2woTifRlt3ZLR4EREcPy0WbmV1nBJP4Z53piaR5dokWuvK4X
	VYW+2FvPXYnJd2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEB2E13A0E;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id F2CELg/kO2X/NgAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 16:23:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45894A0759; Fri, 27 Oct 2023 18:23:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] quota: Remove BUG_ON from dqget()
Date: Fri, 27 Oct 2023 18:23:39 +0200
Message-Id: <20231027162343.28366-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231027161930.27648-1-jack@suse.cz>
References: <20231027161930.27648-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=jack@suse.cz; h=from:subject; bh=DJbutlkZS0y3a0YtTt0KLHQV01Gte9tgl6SyrWn4RAM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlO+QLBLdsrJTpqZ10nfXDwLMc29ccR8Urdf9LqjFq yu2rkciJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZTvkCwAKCRCcnaoHP2RA2VYwB/ 0Tod7UhnNla/eGwWbYH3MolwXrIyKI2xX6o4NsyxcMMElhAUY9vH+QSDKIrYnq9WRaSN0kxdsjgvL2 bwZiWnkRGqsSsEc1kGAHgZt6W0bw4C8mNIBsXvfEIDQPfdmSMyfOEPy1VkvGGZ5V9wDmbcOFkNtw/Z gkU8PtqkY4aVjd6yaQgPQjX/k6D2yjdMQ/tXKgaoBz1lc71McnqiQ1I/9fWvjsTWLoa0oTXw188/1A qH6rhCt3xDmn59xkC5EIRGIZkFCOe4WLjy1pqZNnNC4T8u8eDCKMyg2MncxYWOJq9popt0UvsImPIR uTp8RsUmuKyC7wF8rDbECytIETlC3w
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
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

dqget() checks whether dquot->dq_sb is set when returning it using
BUG_ON. Firstly this doesn't work as an invalidation check for quite
some time (we release dquot with dq_sb set these days), secondly using
BUG_ON is quite harsh. Use WARN_ON_ONCE and check whether dquot is still
hashed instead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f0bb8367641f..7cd83443e3eb 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -990,9 +990,8 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * smp_mb__before_atomic() in dquot_acquire().
 	 */
 	smp_rmb();
-#ifdef CONFIG_QUOTA_DEBUG
-	BUG_ON(!dquot->dq_sb);	/* Has somebody invalidated entry under us? */
-#endif
+	/* Has somebody invalidated entry under us? */
+	WARN_ON_ONCE(hlist_unhashed(&dquot->dq_hash));
 out:
 	if (empty)
 		do_destroy_dquot(empty);
-- 
2.35.3


