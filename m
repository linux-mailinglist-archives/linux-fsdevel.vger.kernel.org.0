Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130A467979A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjAXMSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjAXMSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:18:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1944BD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:18:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 775461FE4F;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674562695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsT4aRefnQBpHkUR2ma5N39hyZqd1flLstMAiZLHU3k=;
        b=zIWJ8c/szjh9QIe0G6m6ZL0/UCz1Q+XwxewrMolvHvgoFsAUrXVeXyteUlPczqCWpNtBIS
        8KAfFrUX/a1EctFyNZpjg9sQVrmEhHUKwQQun9I3eGb/d6p6jtJ6gx/QjvS6WunwJDfhiY
        KYPFxhAFc+2QpQ1QBdjQGHZg95e5UN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674562695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsT4aRefnQBpHkUR2ma5N39hyZqd1flLstMAiZLHU3k=;
        b=apEnnHu2yGn3oKSnGjX5e5QHy1NUI++1IKtfbry7nrOQeRK36Ip7e2/+7NorOuI0SJhA5A
        pDStt3xopN8nygDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D2C4139FF;
        Tue, 24 Jan 2023 12:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rAOnGofMz2P8NwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Jan 2023 12:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 642E8A0700; Tue, 24 Jan 2023 13:18:14 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 17/22] udf: Simplify error handling in udf_file_write_iter()
Date:   Tue, 24 Jan 2023 13:18:03 +0100
Message-Id: <20230124121814.25951-17-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230124120835.21728-1-jack@suse.cz>
References: <20230124120835.21728-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=jack@suse.cz; h=from:subject; bh=sd/yUBk+uX8ZycxHsGvjqS2//3XacFWnk0rKsjk47Ss=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjz8x77JKt1HENs4hcTBLHjIIYJc/SUNIKXGoBWywW 0L9JHayJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY8/MewAKCRCcnaoHP2RA2TajCA CC1FiimTLGp63iG/2qlX23NzWcJQur/8m509Z4e4Iqp9Z326asPPHUZpm8fRZOpEY+VsLv2wnwH8GS IEI4oHuwCqEs1xQhULxi9E//3TbLRW21zAs+8GHI46OLgXMAWxh20GROuy+fiL/JdfEsIyjm9IEJDD QhApsKhdJbO1z9CSt6XonURBzc4hcNff3vZOuE+Z4M2p6mLt5LGJZXB8XyxJycbmAGKbcgscm/H2SH nRGiS47X9sROIbU6J8fXsVAEr3eIsVh9V6P9zJo27pGmpsXElDW9RvQwVUHd6CIP76DSj7Cf6Fclwl PQTpKZXevCSy5zKE8PfVD8MhouRpyx
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

When udf_expand_file_adinicb() fails, we can now use the standard exit
path instead of implementing our own.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/udf/file.c b/fs/udf/file.c
index 60524814c594..596d703fb6c8 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -140,7 +140,6 @@ static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	int err;
 
 	inode_lock(inode);
 
@@ -151,12 +150,9 @@ static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB &&
 	    inode->i_sb->s_blocksize < (udf_file_entry_alloc_offset(inode) +
 				 iocb->ki_pos + iov_iter_count(from))) {
-		err = udf_expand_file_adinicb(inode);
-		if (err) {
-			inode_unlock(inode);
-			udf_debug("udf_expand_adinicb: err=%d\n", err);
-			return err;
-		}
+		retval = udf_expand_file_adinicb(inode);
+		if (retval)
+			goto out;
 	}
 
 	retval = __generic_file_write_iter(iocb, from);
-- 
2.35.3

