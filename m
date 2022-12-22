Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB75653E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiLVKQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiLVKQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35765AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BD6D22431;
        Thu, 22 Dec 2022 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snnrX7j+v4I0SEwzHgq5qUOKMs2mEe8i5HfsO1Rlcpg=;
        b=2aToEuozG7L2C6QF/uy5gP5d8iTm+PBlnuE6bo+6ahLijSWym4DBCZ/5IWXjWQN6hTjglv
        uUv5nadRBLF4y+G5tcJZXha3s7cxbq2rYqSHb+25bT+8MCuQkqd/x58b0VBtFCKek+PrrO
        yOe7XvOKIxZE8rNP5OD7qg5CChKZKWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snnrX7j+v4I0SEwzHgq5qUOKMs2mEe8i5HfsO1Rlcpg=;
        b=ORCwr5EgKgb9YKX+F8DLMBZDty7jtfYnA1vj55NleDsWBX85WVMvAFCI2w/zTksuPQfAmi
        oWNkfEgN11lUtSBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19A9E13918;
        Thu, 22 Dec 2022 10:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ajM/BnAupGM8WwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DBA0A0745; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 7/7] udf: Keep i_lenExtents consistent with the total length of extents
Date:   Thu, 22 Dec 2022 11:16:04 +0100
Message-Id: <20221222101612.18814-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221222101300.12679-1-jack@suse.cz>
References: <20221222101300.12679-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=jack@suse.cz; h=from:subject; bh=TpB7iJJb9gSlGK+ncASJniTQ93lcdUtZsZwfMOU7G14=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjpC5kXNPENnyKX68ceCjkbTDf6fDearkM/erPGdcJ GsWKuRiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY6QuZAAKCRCcnaoHP2RA2QwyB/ 0XBZtRCzKyk8xqljOQcrUdgzKTup86uy9BAzOuUxcvjUawzxlOsDweXbyNQlfATWDFcN5iQ89iEKOZ /cFt7D6L1pJDAAZBsvJumkzJxcVbVAcbK1l+6uqhxpjlH9CvwtS2Rq+5O7qAR+4EldWEmQLXwKELqg vJPTmqbVlWom9ewj0tlywThcQpwBz7MUoimttZb7rmjU14YkC7bMT0BQkNDynK4RqmLCl3INbZ7OIH W0b1Dinzb/wlRt0AjLZa/aVrT1ahnuidMhvfqygdH9xnLdii823hkT675P9GAR3GCaDC5/otMDZwCW dXQ7nr9ZXpudHTBhi1JZI0MBBQN76T
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

When rounding the last extent to blocksize in inode_getblk() we forgot
to update also i_lenExtents to match the new extent length. This
inconsistency can later confuse some assertion checks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 075e0a9d766c..3621dd7fe5a7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -677,6 +677,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 			elen = EXT_RECORDED_ALLOCATED |
 				((elen + inode->i_sb->s_blocksize - 1) &
 				 ~(inode->i_sb->s_blocksize - 1));
+			iinfo->i_lenExtents =
+				ALIGN(iinfo->i_lenExtents,
+				      inode->i_sb->s_blocksize);
 			udf_write_aext(inode, &cur_epos, &eloc, elen, 1);
 		}
 		newblock = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
-- 
2.35.3

