Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B67471EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGDM5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGDM5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B510C1;
        Tue,  4 Jul 2023 05:57:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9CCF92057B;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688475423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kLKXbH7Z9oxrfsS86756x47zmseM1dV/Y8LiCLoy6A=;
        b=1NsHtBQvituf76wxtJwfJBbL2Tzo1neIrOUsXVd3S4gmW62PKmJDF231W0tc14xolwuPTQ
        Q/HuMw8W/32xF4JmpitZqJk0TeLJ6jlCDSi0ivycTIGg3dwGsdiO4k44XsgBx3Fg3bYlSn
        C/sZrMAG3dSQHCO72pg5HUeOHXewkYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688475423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kLKXbH7Z9oxrfsS86756x47zmseM1dV/Y8LiCLoy6A=;
        b=FLETSoCthEgeQYjbin9G95011rohTKnX2o6mkH6JhP2A286F4KRh1Q+LXhGE+3BIy5uddC
        Kx051bm0ZLvtXMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88B0413A90;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NBJ4IB8XpGRHQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E904DA0764; Tue,  4 Jul 2023 14:57:02 +0200 (CEST)
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
Subject: [PATCH 2/6] fs: Block writes to mounted block devices
Date:   Tue,  4 Jul 2023 14:56:50 +0200
Message-Id: <20230704125702.23180-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
References: <20230704122727.17096-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=jack@suse.cz; h=from:subject; bh=1Lmzs2snC1snjsNOeiGEbZLZ2ocM2Sn53OgpAZM40yE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpBcSptunr+jYP76j2WuFOQSZ56OM8jiAHFNFbohR DMY8nnuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQXEgAKCRCcnaoHP2RA2VgkCA CSAv51n2YAI4cMP2AySqWYOtRvUd1mNEWdOBjXmqplGJ6E0ilAkvrBEuY3/0bkT800N2Y70fEzPV8d 972eCWgtPG4t0zrIp0eKqAdA95NzflI8nzL8ylZnXIFd87B7hDUZ1IxGknYqo016Cjd0o4ZSuWhSML xLp1MWi2gGIP9maISY8u/bJegw8z3vuuAIuEtkt39aFWpgEPtMMsYIsUKgf02GIkIxq2/nnVDOKNZA 4g71hSna1LDpgbYa6vWZrQF03EU/XdwjxzVzjULt3j5WWuiy8L9QjMvWarV7SpkZJcOv3Ui4/FQwKC uN8DvxVq4+4HkfACWePDePzMTNKi9V
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ask block layer to block writes to block devices mounted by filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ca467525e6e4..a1fb90f3887e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1471,7 +1471,8 @@ struct blk_holder_ops {
  * as stored in sb->s_flags.
  */
 #define sb_open_mode(flags) \
-	(BLK_OPEN_READ | (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
+	(BLK_OPEN_READ | BLK_OPEN_BLOCK_WRITES | \
+	 (((flags) & SB_RDONLY) ? 0 : BLK_OPEN_WRITE))
 
 struct bdev_handle {
 	struct block_device *bdev;
-- 
2.35.3

