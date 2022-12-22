Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B5C653E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 11:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiLVKQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 05:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiLVKQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:16:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F664E4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 02:16:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7EC9A44F2;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671704174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0q3+yIxhP6B4IWiv038KzQr+jMC/MRZWST7+qxNvchY=;
        b=rPM8MgcMgiXONHkC7/8NuSncLADsmiU6BffDfXrOMyGGwQoob3zKd6zj0sfb65qm8Xl89c
        qalN1KkYJb367rJQdo6zTDEwCECOMYQ+5rTlZiD/hAKf0lgp5dLElY0ahk3hjeURFBhDQD
        crMfilmTTDtq2z5bo2HViEjeH8hmH+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671704174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0q3+yIxhP6B4IWiv038KzQr+jMC/MRZWST7+qxNvchY=;
        b=tLWEvWJ5uft0GBvcrLsv6NfzUacq+eJWHTtE1pQ4yrS2OFkwgHiwqRNdZngTqa/fveK9mZ
        YrLYTzKqjNUiqyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BA5913919;
        Thu, 22 Dec 2022 10:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHCRFW4upGMrWwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Dec 2022 10:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 10A06A0735; Thu, 22 Dec 2022 11:16:12 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] udf: Handle error when adding extent to symlink
Date:   Thu, 22 Dec 2022 11:15:59 +0100
Message-Id: <20221222101612.18814-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221222101300.12679-1-jack@suse.cz>
References: <20221222101300.12679-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=jack@suse.cz; h=from:subject; bh=qSBuG4kED5vLXelZ+uZNkeJm+Ss6athpPpTDDWNhsX4=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJKX6MWzcpmUhcv9+FEjHTenvz/rgdFNLcf45lcx38Ommopr s/Z1MhqzMDByMMiKKbKsjryofW2eUdfWUA0ZmEGsTCBTGLg4BWAiu+rZ/7ut46t5Jjp7bnLq4xNyt1 7UxHRkSZoZbTI/PV/2n5herMvdvymzz/n+YSzLXejbuF9YY8lHi8ZPzd+Y/NUsztY86/svOunv7qlc 8wWPiNtqMF6eemLvB+6rO3qY7+6Mawo7q6vp81ZE7mQTQ5DBualsC7JvP/s6c2Hwiu+Xpc/ICbCy1E 3jutft12A7NzpIYPmbbzZMBq4LDaNdpWQWFFjlpy7Zssz/mXCT2x2baiUJs99fbyumn+Xlr1K8s/i7 mmiJn8f5CcaK8pc8Hqmpc3+KKci8Wcsl1B9gvqRu3eu0lFIB7WWJhU8qWSduWF0gNE3wyYcl0ow8qh 8YexbNTVoUaSZjyfh2j1vxrqclAA==
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

When adding extent describing symlink data fails, make sure to handle
the error properly, propagate it up and free the already allocated
block.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index de169feacce9..2ade040483a1 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -609,8 +609,12 @@ static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 				iinfo->i_location.partitionReferenceNum;
 		bsize = sb->s_blocksize;
 		iinfo->i_lenExtents = bsize;
-		udf_add_aext(inode, &epos, &eloc, bsize, 0);
+		err = udf_add_aext(inode, &epos, &eloc, bsize, 0);
 		brelse(epos.bh);
+		if (err < 0) {
+			udf_free_blocks(sb, inode, &eloc, 0, 1);
+			goto out_no_entry;
+		}
 
 		block = udf_get_pblock(sb, block,
 				iinfo->i_location.partitionReferenceNum,
@@ -618,6 +622,7 @@ static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		epos.bh = udf_tgetblk(sb, block);
 		if (unlikely(!epos.bh)) {
 			err = -ENOMEM;
+			udf_free_blocks(sb, inode, &eloc, 0, 1);
 			goto out_no_entry;
 		}
 		lock_buffer(epos.bh);
-- 
2.35.3

