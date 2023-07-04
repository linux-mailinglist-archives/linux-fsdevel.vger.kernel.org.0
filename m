Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A17471DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGDM5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGDM5F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D6DE70;
        Tue,  4 Jul 2023 05:57:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 91A3722804;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688475423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aNFQKK84PQeMU0o2BrZwqCpmBRXyfLB4X6NQO+cVhGk=;
        b=b464PnUFS3a/2+VaWwFL45DNjCqS5bDW3wdH5p12pEY9dDf1eUx5rHX0kMnhEi4pQPu9OE
        ISCbSTatRa3SFnE3jXevxH4fWe6G063EsWfB0ab3s81qIxzBNNJZ/VEBi1g/Sl2jCvZEKc
        aQ1VyHgzQwb/J7WuS67VBftf/8CztAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688475423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aNFQKK84PQeMU0o2BrZwqCpmBRXyfLB4X6NQO+cVhGk=;
        b=6sa68DwCV1Y0vXgnLzTEQWJLE3dhaylF7zJF8L+/e3GObWZTxHUedkHQeB5ClMWbTxMPS8
        qly98fmlPibnPfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 813F213A26;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rRSKHx8XpGREQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F37E6A0766; Tue,  4 Jul 2023 14:57:02 +0200 (CEST)
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
Subject: [PATCH 4/6] ext4: Block writes to journal device
Date:   Tue,  4 Jul 2023 14:56:52 +0200
Message-Id: <20230704125702.23180-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
References: <20230704122727.17096-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782; i=jack@suse.cz; h=from:subject; bh=NWBGOYVyzhEFvSkBdLLt9GRq3HmyHTawgFiLLwCAWLM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpBcU6vLiCKXLfKbqhj0Vfj2Xn+cC+fHAN/x6rTa+ 9bJ+VRmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQXFAAKCRCcnaoHP2RA2ZVkB/ 9PkYH97s+87SyqxmrXaecUvErsUd5cNv05UrhvfR6NrjkaCwsK432m1QAWSO0oaxJnPAlbCUw9k6X1 CQJ7pNDtVnZg2ycu3WFyFDhR3XKbn1K9qlsgIMcAQVbcpWXXw1otA2PXF2qV5g0TU3jNzE1k6tLMj2 moEkTG41L7PHUj35bfhF27SxRfqy6m5liCh7O0khnw65f3f7YaBffmmCG94eJdHGE/ol+dgFXtaFCa M/0iI7XbnMXLkRoUuoWpyGTSmcXXf/1FR3jkw+VNjdgIjPR7x8Egm+LcZ3XvsLH6q0HmuDgVtD6Kvj DiwdnRXR+LvDOI+TsTk/KHWA9egQ0Y
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
for ext4 journal.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cbeb8a555fe3..8181285b7549 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1112,8 +1112,9 @@ static struct bdev_handle *ext4_blkdev_get(dev_t dev, struct super_block *sb)
 {
 	struct bdev_handle *handle;
 
-	handle = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
-				   &ext4_holder_ops);
+	handle = blkdev_get_by_dev(dev,
+			BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_BLOCK_WRITES,
+			sb, &ext4_holder_ops);
 	if (IS_ERR(handle))
 		goto fail;
 	return handle;
-- 
2.35.3

