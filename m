Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959166B849F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 23:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCMWPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 18:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCMWPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:15:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DD67034;
        Mon, 13 Mar 2023 15:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23BCFCE125A;
        Mon, 13 Mar 2023 22:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E58BC4339C;
        Mon, 13 Mar 2023 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678745696;
        bh=vw79fexAzk+yE0svCHr1v/BgnaY2Tly6xl5VXbAiZhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK6JKHs6m9sUCerh7e5n//h20BLNUyW/1NH6LLDt4oCBFJ18lLsJAtst3HYsL6uXH
         fNmdLHDgNVj0nU9wLa9f5lq+1yWgl9nr3s6e5KCpGMSPJw+gvw9fKtaUIkEEhbAFfD
         ABqnLHHxLNzjRHeOD9721NfZVDsvuyZno0deDky7oPxSiSgIEldJxEnhTlv1+HQX1u
         XGqVm4Hn1t9DSYxR8gGod3Sk66w1ZkGAhGkPsZzG6lmBDXef8T2WzKQfty5L3HrQyg
         54gJyMdwcu3Vd3+MxjXkP3mhABw/jpoOxrm0YhpS09XBWO4HerjCUgard6W4OaTDOs
         fCNnL60d9i01g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 3/3] fscrypt: check for NULL keyring in fscrypt_put_master_key_activeref()
Date:   Mon, 13 Mar 2023 15:12:31 -0700
Message-Id: <20230313221231.272498-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313221231.272498-1-ebiggers@kernel.org>
References: <20230313221231.272498-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It is a bug for fscrypt_put_master_key_activeref() to see a NULL
keyring.  But it used to be possible due to the bug, now fixed, where
fscrypt_destroy_keyring() was called before security_sb_delete().  To be
consistent with how fscrypt_destroy_keyring() uses WARN_ON for the same
issue, WARN and leak the fscrypt_master_key if the keyring is NULL
instead of dereferencing the NULL pointer.

This is a robustness improvement, not a fix.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keyring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index bb15709ac9a40..13d336a6cc5da 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -92,6 +92,8 @@ void fscrypt_put_master_key_activeref(struct super_block *sb,
 	 * destroying any subkeys embedded in it.
 	 */
 
+	if (WARN_ON(!sb->s_master_keys))
+		return;
 	spin_lock(&sb->s_master_keys->lock);
 	hlist_del_rcu(&mk->mk_node);
 	spin_unlock(&sb->s_master_keys->lock);
-- 
2.39.2

