Return-Path: <linux-fsdevel+bounces-1384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8E7D9DEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310EF1C2108E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E538F8E;
	Fri, 27 Oct 2023 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsX0I4kt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hy6RhRO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCA38BCC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 16:23:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3CD116
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 09:23:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB1B31FEF8;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698423823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5BooIwSB54tvmZnZk+gxHiTFBUv20KWiSFg51DMzH8=;
	b=xsX0I4ktJvdJTVwO/pE7Tfkln8CArRKd7FegHG1VmbT4Rx9YH7HZA2cZN2rSXsZ+i3l/Ll
	PSt8d2o2wO1qIH6zWG+/uKLQt/a6DAG7LmUd5e9AHhyLmL2nVLhHMAZvDrX4qX6ngawNay
	ad0/folYAMLKz6F1bIne36VQSdWBHkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698423823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5BooIwSB54tvmZnZk+gxHiTFBUv20KWiSFg51DMzH8=;
	b=Hy6RhRO9e9Xcb7IzRFrhmYmqfeJvL+pTXUAl/Is5Kf2vzaaZqtwHI1lTg76Z0Qpp0wEB2O
	bjIZBIWHNwVjm7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C362413A66;
	Fri, 27 Oct 2023 16:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RtJSLw/kO2UBNwAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 27 Oct 2023 16:23:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F3F5A06E5; Fri, 27 Oct 2023 18:23:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] quota: Remove BUG_ON in dquot_load_quota_sb()
Date: Fri, 27 Oct 2023 18:23:38 +0200
Message-Id: <20231027162343.28366-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231027161930.27648-1-jack@suse.cz>
References: <20231027161930.27648-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=jack@suse.cz; h=from:subject; bh=9UNCT2Bf4mz35j9wEx5538/pRGOgLONERvcgKTf/pqk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlO+QKa09LlphDRxMu6NavR5LUAtYpM8U3qDOs5x+5 HbGa/2yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZTvkCgAKCRCcnaoHP2RA2cLUCA ChadbASdEsgj7qWOc0nHNhwLqPKSTCvbZ6/C6eoOSYBt8r4vlwA5mIPUWZrx2DREivcESAtcbX/bnp Dqu1540krbW0xRhadpQxe3CF09XD6AacIc39zfqFA1gdDZm64BGVxUVB8Tm3rGpVThyV0g/6g6NzGt oEuUm70vr2c1OQECJXfh+jHdJcq6kbHL6SFCibSWOyrtaBr7fM657N46ixK9uQi5GpQZx9pPe0b9Pn /vz6a1Xmd0psWMvbymJfC+lZVZlWxjxv40B0+3WvEKggK7Yx41cIf+Vj0+o0t8S7YTZueLOb/VSGrR 1+YvjYc9u/2+1wmv08kt6EPAjkM2qm
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit

The case when someone passes DQUOT_SUSPENDED flag to
dquot_load_quota_sb() is easy to handle. So just WARN_ON_ONCE and bail
with error if that happens instead of calling BUG_ON which is likely to
lockup the machine.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index c0d778363435..f0bb8367641f 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2377,7 +2377,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 	lockdep_assert_held_write(&sb->s_umount);
 
 	/* Just unsuspend quotas? */
-	BUG_ON(flags & DQUOT_SUSPENDED);
+	if (WARN_ON_ONCE(flags & DQUOT_SUSPENDED))
+		return -EINVAL;
 
 	if (!fmt)
 		return -ESRCH;
-- 
2.35.3


