Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895007B1D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjI1NLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 09:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjI1NLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:11:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936DB180;
        Thu, 28 Sep 2023 06:11:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D59421902;
        Thu, 28 Sep 2023 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695906692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sQse0ToDMpwewQdDE7yKhrAOT7WYcaPTU5OIWsPVcgM=;
        b=OK+lbIcjxBjHWwc61nh64vp9qLYNn8N2SPJO+Ljopy4iTIK7mKgtx745/r7gVy2fTnSy+w
        Cw5OHq+2UBwxYEDbu6AuetVyc4+0YGN3YXRHG6BQ7zstm+YHoXoIh1b0fFwlBrdK9bF0oy
        Lwv7fi58Dd5iRz0qJZ9ShzP08QhSktk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695906692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sQse0ToDMpwewQdDE7yKhrAOT7WYcaPTU5OIWsPVcgM=;
        b=GYulgtrzvdxvHTDJB7S8xKObEa1aO3wVm0XUj87rLNIekZVmjmpgy1T7euQnoqUlioP3Yq
        ggOVLLarlNLwIBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D612A138E9;
        Thu, 28 Sep 2023 13:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wNI3MYN7FWW5ZgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 28 Sep 2023 13:11:31 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id cc60902a;
        Thu, 28 Sep 2023 13:11:31 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] fs: fix possible extra iput() in do_unlinkat()
Date:   Thu, 28 Sep 2023 14:11:29 +0100
Message-Id: <20230928131129.14961-1-lhenriques@suse.de>
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

Because inode is being initialised before checking if dentry is negative,
and the ihold() is only done if the dentry is *not* negative, the cleanup
code may end-up doing an extra iput() on that inode.

Fixes: b18825a7c8e3 ("VFS: Put a small type field into struct dentry::d_flags")
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
Hi!

I was going to also remove the 'if (inode)' before the 'iput(inode)',
because 'iput()' already checks for NULL anyway.  But since I probably
wouldn't have caught this bug if it wasn't for that 'if', I decided to
keep it there.  But I can send v2 with that change too if you prefer.

Cheers,
--
Luís

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
