Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290717471E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGDM5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGDM5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:57:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247F10CA;
        Tue,  4 Jul 2023 05:57:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB6722057C;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688475423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9aPmJAEDAWDAbogCcIWe3cTfiRzCVb6wX9w2+6QkZJo=;
        b=wRw6CtHwEV6KgCi4UJsfwzELJnNLLpln2ImrjV2EqRkv4L0q21klE6LlpjtVRgxmaVv5ZQ
        vNtJzI3Xp1/Ym++j69UaqwJP7ymxYy2n7oC10BJ0GPFKD0T2TdvKx9/WotgHgv4C3N6rYG
        8GzRrreGDnZDtR3JF81cOblg7qgXyog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688475423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9aPmJAEDAWDAbogCcIWe3cTfiRzCVb6wX9w2+6QkZJo=;
        b=gla0ZUkKNuT2lUov6b1A0TRpIx3QngSeIEv2YipUn11ZvpFbt9B191ysqwcsBQxshKrIe9
        Uyg9y0hILhkdRgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF198139ED;
        Tue,  4 Jul 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oiZ4Nh8XpGRXQwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:57:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0524AA0767; Tue,  4 Jul 2023 14:57:03 +0200 (CEST)
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
Subject: [PATCH 5/6] btrfs: Block writes to seed devices
Date:   Tue,  4 Jul 2023 14:56:53 +0200
Message-Id: <20230704125702.23180-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
References: <20230704122727.17096-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=jack@suse.cz; h=from:subject; bh=O/zE5ZJNriSyJ3rTPMJSXy9rJXYRwNILAjDv6We+cuk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpBcU92ftJ81IhlIupYK00XjPLfBv/vGzXEoF7Mhb T05s0QOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQXFAAKCRCcnaoHP2RA2VarCA DeKZaEIbHcdCwD/PJ/ccAJnLaidMSFrgfnzsgxRc0O+Kgg/PlCsyChxvzbjboFWDJjVda6fLTjmm2n eO/UYTpZVDXHmtXjMpBjJP8IFcMSFg0z1I37HgjhuDy3GvGMzSegPRA+iSYNN+6AHS0kJWxiekt/SF ILQ6gqVMBM+EcU8CK1pLIki3yNLrZx9GS00EMdxRwlylrWlMLUfGsU9TFHjWCoiB2e65ixejCFgstL egjTkZiyp5IDTxnCSNYL4po6+DhFwGakKMJJSCwReivln8BvlTA2S23PJBfcFlokFjlYVvbnli29cL Tq2kK5apaeo2PCS2ouRImDoQCKdLrt
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

When opening seed devices, ask block layer to not allow other writers to
open block device.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/volumes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fb7082426498..496e0b6d86ab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6898,7 +6898,8 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
+	ret = open_fs_devices(fs_devices, BLK_OPEN_READ | BLK_OPEN_BLOCK_WRITES,
+			      fs_info->bdev_holder);
 	if (ret) {
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
-- 
2.35.3

