Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A403E7B2121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjI1PXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjI1PXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:23:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D5AC;
        Thu, 28 Sep 2023 08:23:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E373218EE;
        Thu, 28 Sep 2023 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695914623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMVO4JWLEU7kHL3FVMMwI/4b1Qo5sbRkTUZ8Yb+qirM=;
        b=ySQHLJcEODl7uYvtim5VAX7ladjWz1XOh0RKHASv29BGkqkQ2mQgWfQXCkU5dL6+D4osZX
        hUqBBw+uv4odRaITlGeUW4jfKLUwHAe99FGERX+G6lTjVZweXWqiv1e9uzRkZM/axjHlto
        c6jXihZxTuS32dlyjvdUsjzNcNYSh4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695914623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMVO4JWLEU7kHL3FVMMwI/4b1Qo5sbRkTUZ8Yb+qirM=;
        b=L318WkBygjvdQ5WS2NKz2hxFQwxy+SeJlP/E5DmGlJD1IFzzj+3pnr/0D11mPt6Kb2Tn8k
        AH/hpYPp4VB2aACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B559C138E9;
        Thu, 28 Sep 2023 15:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5KaKH6aFWXoKwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 28 Sep 2023 15:23:42 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a6641159;
        Thu, 28 Sep 2023 15:23:41 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH v2] fs: simplify misleading code to remove ambiguity regarding ihold()/iput()
Date:   Thu, 28 Sep 2023 16:23:41 +0100
Message-Id: <20230928152341.303-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because 'inode' is being initialised before checking if 'dentry' is negative
it looks like an extra iput() on 'inode' may happen since the ihold() is
done only if the dentry is *not* negative.  In reality this doesn't happen
because d_is_negative() is never true if ->d_inode is NULL.  This patch only
makes the code easier to understand, as I was initially mislead by it.

Fixes: b18825a7c8e3 ("VFS: Put a small type field into struct dentry::d_flags")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Changes since v1:
Rephrased commit message to make it clear there isn't a real bug

 fs/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..156a570d7831 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4386,11 +4386,9 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (!IS_ERR(dentry)) {
 
 		/* Why not before? Because we want correct error value */
-		if (last.name[last.len])
+		if (last.name[last.len] || d_is_negative(dentry))
 			goto slashes;
 		inode = dentry->d_inode;
-		if (d_is_negative(dentry))
-			goto slashes;
 		ihold(inode);
 		error = security_path_unlink(&path, dentry);
 		if (error)
