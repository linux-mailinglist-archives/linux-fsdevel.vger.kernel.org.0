Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B468E827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 07:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBHGVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 01:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHGVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:21:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FAC16322;
        Tue,  7 Feb 2023 22:21:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB030614E6;
        Wed,  8 Feb 2023 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C28C433A0;
        Wed,  8 Feb 2023 06:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675837296;
        bh=yjmeR+HuHfvezqUObRjW0JmkMkN4qqziD8/F7kQFQoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hT9wbh5lvDI4fsinMVQlijsAmGKYTa8mpzuBKjJvZdcI59ojR9Cc8Y0JeTfP6EcUW
         gnmWte7KXT5+7DMRhWstF+GOYeEdc0mWM3C9q2/d/uS++ZXpPcKaWFLMX+5Bz0KcXV
         svLKcryv3OwMsB3NjgUpy1TI4h79P4ZvpFk8EY2LMpMMK4U8+/AEy4nESn4eHgVt2Q
         LDB5rnitSdhws3R/f5wYRp6nIbFdruxxBqVUbwNsv97kpoCbHw1Myev+E+sNUpoVfR
         qJTkvr0Y+k9p1FoLAfA1PRBrCLIYncTqVpO0qbIa2pNsuyBF39Uj5wCQbAp8HfXVcz
         N+FuuAq++dH3g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/5] fs/super.c: stop calling fscrypt_destroy_keyring() from __put_super()
Date:   Tue,  7 Feb 2023 22:21:06 -0800
Message-Id: <20230208062107.199831-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
References: <20230208062107.199831-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that the key associated with the "test_dummy_operation" mount option
is added on-demand when it's needed, rather than immediately when the
filesystem is mounted, fscrypt_destroy_keyring() no longer needs to be
called from __put_super() to avoid a memory leak on mount failure.

Remove this call, which was causing confusion because it appeared to be
a sleep-in-atomic bug (though it wasn't, for a somewhat-subtle reason).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 12c08cb20405d..ce45b7fd27f90 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -291,7 +291,6 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
 		security_sb_free(s);
-		fscrypt_destroy_keyring(s);
 		put_user_ns(s->s_user_ns);
 		kfree(s->s_subtype);
 		call_rcu(&s->rcu, destroy_super_rcu);
-- 
2.39.1

