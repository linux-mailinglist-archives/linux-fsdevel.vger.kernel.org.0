Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293D46A6D57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCANqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 08:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCANqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:46:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1953BD94
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 05:46:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E833521A96;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677678401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ghw4JVQos3haE9QPfkGcEgUKzzIe6qyW/tNTldLLHJ8=;
        b=tR6tpVLckSRR0O6roMKIb3ksNEIoyVhXRhBOd+rtOD+PASFBNnruI9tirGHk2RDSqBXthA
        o88Aa2XkgNmgfULqrSkpIYz9qwNejCpnmmpNjehwy30svqF2lVN7VVW4uOtU4w1DGzJ75E
        ujxE7i2xP4jDYcVx/PZSDHcxu1njT4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677678401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ghw4JVQos3haE9QPfkGcEgUKzzIe6qyW/tNTldLLHJ8=;
        b=FArnSd1KkwhD2dXTZHKZz4cyBa0+gZlDJh0qldI6GV0cMyfVwXXo84QoYyyLsMxDXkjqHN
        sHCwyoLx/DO7btAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB32413A3E;
        Wed,  1 Mar 2023 13:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dw4BNUFX/2OaIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:46:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 484EFA0660; Wed,  1 Mar 2023 14:46:41 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] udf: Fix lost writes in udf_adinicb_writepage()
Date:   Wed,  1 Mar 2023 14:46:35 +0100
Message-Id: <20230301134641.11819-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230301133937.24267-1-jack@suse.cz>
References: <20230301133937.24267-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=jack@suse.cz; h=from:subject; bh=INfSJJlh+kEDMiZD1Gy+wYWQq66td3OL3HZp5BN3Uho=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBj/1c6r/wXPqWDyRNaR177HNP2hYa2B9D6r/0InRmk H+62kgSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY/9XOgAKCRCcnaoHP2RA2RfkB/ wNY9YL6pLmhZskSmXfyVhFQaKOdNTBHZbljOit70IJ2/EEPpo10qg6ZRYkOSmLKSqDMghRdUxDK6On qzz6Ovtgj0YYJqMRaEAlDQT864L1Surge2TNakjCD1iPT+dg8LLDKBcgsL5/tx0N56hhjp1skO/3i5 iS03GwCURUZLKhjRKiDgLKQ38sOMuPHYvb0MiRl3fIGJj723NcvDBOiG7CIGY9xjWe4yNfBegutb6d tEkVQNAf2r8p6CydUTXyQSEyYJPJTUB5fyFytyeDu9fuNe9qBPGhE1ipJAnO8ERmsR3V+BwP3YFMVZ B1OA6/CWXTLNJxeAid3EejCWqT6Alz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch converting udf_adinicb_writepage() to avoid manually kmapping
the page used memcpy_to_page() however that copies in the wrong
direction (effectively overwriting file data with the old contents).
What we should be using is memcpy_from_page() to copy data from the page
into the inode and then mark inode dirty to store the data.

Fixes: 5cfc45321a6d ("udf: Convert udf_adinicb_writepage() to memcpy_to_page()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index f7a9607c2b95..facaf3a20625 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -193,7 +193,7 @@ static int udf_adinicb_writepage(struct folio *folio,
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
 	BUG_ON(!PageLocked(page));
-	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
+	memcpy_from_page(iinfo->i_data + iinfo->i_lenEAttr, page, 0,
 		       i_size_read(inode));
 	unlock_page(page);
 	mark_inode_dirty(inode);
-- 
2.35.3

