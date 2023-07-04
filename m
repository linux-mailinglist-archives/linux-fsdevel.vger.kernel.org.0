Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1147471E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGDM5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDM5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2B12E;
        Tue,  4 Jul 2023 05:57:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 843E920571;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688475423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtayAV5T0tBVByT6zZ44nOPb8V5tXSVkxuDIXL3faJ0=;
        b=Duy5fugiJmqDcIDpwsbYTPiA4IruxmPPijcS0WaD9OElGUyAEUmlma53ORRQLV40JgzbzK
        UaFkS5V/S3hLlFh6GKsjqW/xqLk0pSE3Ngr+aBl+MmkIaomBJNnQi7QPRD3GBmNJtPUThl
        bhejAQlSvLbpYVGjYbQIHYRolrXxxK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688475423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtayAV5T0tBVByT6zZ44nOPb8V5tXSVkxuDIXL3faJ0=;
        b=pLKG5TNw/8Mra2nNSLGkoVJeHKs8nIKwgmkwbOHYCLdmNz89+ls+Siibr1V38bbFZE12gh
        o+qF3lu/O5Lrv6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F4F31346D;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xqk2Gx8XpGRAQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE456A0765; Tue,  4 Jul 2023 14:57:02 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>,
        <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/6] xfs: Block writes to log device
Date:   Tue,  4 Jul 2023 14:56:51 +0200
Message-Id: <20230704125702.23180-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
References: <20230704122727.17096-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=jack@suse.cz; h=from:subject; bh=nhXkhndcPMW2C+uoE+VwcqIIQEbUdMbuuEt4QVO2k/Q=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpBcTQayx7dbOByhLrjumejN1JUQPoK85sd4AETva TsjocFOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQXEwAKCRCcnaoHP2RA2VgoCA DQyETerLQPbUl9el+W2isQ3GPWuVGKOhq1DNPEDd2haY+G45LN9cI64qaXk8br1iB/LPwukLuPMv3Q V2ygL0uXAcCH8LzvnGBSHIQNrHqcpj6g+StWqdIrrxjY9Rs4nzXCMLLfyVv+59aVk6hzD0iiykK29c Y4AqrrZIzdXxaxLBGjyATLbJ80oPQu8ff5lhnSrMj58aCFWQX0uDYRBw8DgXOZldrSTvivy1wmtMSl BEBfwodl2YYmh8iEr9RmpbDK/vzd0ONTVOxTnRNNCsndncJ8Tqw9pBSJIL3O9vXOGVNNxba/cl78u+ RtG9pEBcwiK2qR//mTi4dz4ycxKt2s
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ask block layer to not allow other writers to open block device used
for xfs log.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b0fbf8ea7846..3808b4507552 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -396,8 +396,9 @@ xfs_blkdev_get(
 {
 	int			error = 0;
 
-	*handlep = blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
-				      mp, &xfs_holder_ops);
+	*handlep = blkdev_get_by_path(name,
+			BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_BLOCK_WRITES,
+			mp, &xfs_holder_ops);
 	if (IS_ERR(*handlep)) {
 		error = PTR_ERR(*handlep);
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
-- 
2.35.3

