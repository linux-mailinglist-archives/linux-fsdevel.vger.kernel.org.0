Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3ED679792
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjAXMSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjAXMST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762C442EA
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32D8E1FE4A;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mh3HPeY/Udj549kPdT4KFYHO0Njbl/e+zxjftPCfC7c=;
        b=Xrzth2bhmfwk39z9zHH3x++pZnu29R7df+r8VPQJBQD2eqo0UjXcxhFe52XRsZVWeSEhOG
        04uTZREuqB8er3Gznxfv3Hkkzmo6gd29zasfAimR5KQcztRRsrBMP49m2j+dzv//85SCQd
        7J3fmG1exw7Sk9ro6XjV4cC0I9p2GkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mh3HPeY/Udj549kPdT4KFYHO0Njbl/e+zxjftPCfC7c=;
        b=60+ByVUjdzKA11VTijfy3k3J49jZuWZQqRkxCT331iPojhjBUBuLJKNDzw6WZ804mU2Gx2
        OqrqOua6rRjLRtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20DDA13A08;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 65UACIfMz2PsNwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46736A06E1; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 12/22] udf: Use udf_map_block() in udf_getblk()
Date:   Tue, 24 Jan 2023 13:17:58 +0100
Message-Id: <20230124121814.25951-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=jack@suse.cz; h=from:subject; bh=879ZWrfUCtr1ZKR4De4Adoug45It2BMNyLZBEVFtb0s=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x39Ci8th1ObO1LKa+XsqIDfxJ2A85gzzVtzw22 OqQsP5uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MdwAKCRCcnaoHP2RA2fC2CA DGS84ZNMLSqwoGNlfd4KmujQrlxa4oC2CK41sWZHVbTSKswiNe3M591pgRdYvK3tf9P9hN+qVoawTa i+67x2+EK9OvEvUT3sb3u88mDjOEWBTlHvHtJyZxITRv0YsEZykFNhmYFG5N2ZU00qk6EdF1eU+/K4 Hd8uNXBUBePYv6TRPn+WpV8x0E1QVu9LCAByZI4rn/i3IVlYanK/YD+8VRpkMCcOzotSszAOZhk7RF XwZUOMw31G3/m6iIcoIqHVx7TA4oHtAqzRBqdYcdq8SHwKhZr+CYy5w1xDQwaM0PL5yVIsNkOEMgRw 3BKoI7So0G287e1h8RA4G+D4NmJ6NC
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new function udf_map_block() in udf_getblk().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index daacb793f6f1..4e6b855ffd02 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -405,14 +405,15 @@ static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
 				      int create, int *err)
 {
 	struct buffer_head *bh;
-	struct buffer_head dummy;
-
-	dummy.b_state = 0;
-	dummy.b_blocknr = -1000;
-	*err = udf_get_block(inode, block, &dummy, create);
-	if (!*err && buffer_mapped(&dummy)) {
-		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
-		if (buffer_new(&dummy)) {
+	struct udf_map_rq map = {
+		.lblk = block,
+		.iflags = create ? UDF_MAP_CREATE : 0,
+	};
+
+	*err = udf_map_block(inode, &map);
+	if (!*err && map.oflags & UDF_BLK_MAPPED) {
+		bh = sb_getblk(inode->i_sb, map.pblk);
+		if (map.oflags & UDF_BLK_NEW) {
 			lock_buffer(bh);
 			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
 			set_buffer_uptodate(bh);
-- 
2.35.3

