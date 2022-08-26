Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C15A1EB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiHZCSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbiHZCS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:18:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2775CB5F4;
        Thu, 25 Aug 2022 19:18:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 371EE20890;
        Fri, 26 Aug 2022 02:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eX7h+oQ/Kzd8hTzgXuaUbKeoxaFf+xWQvUHsGE389GE=;
        b=mqoJ2oie/UllcHJdvpPaYORL608KG8WsiDrCNMNaVkhqP8ELNE+EDHDbQsa3lzki19sahM
        /KO+ww+ZFSi9aRYweLWsOtD1k/chmhtTd82WCKf2mdrdcwr9Hk3Og46xwh1k2oDS+en8uZ
        KEx8CTCz1Cv/mWpZMcczmbATGLIuPwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480305;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eX7h+oQ/Kzd8hTzgXuaUbKeoxaFf+xWQvUHsGE389GE=;
        b=2zM7rPGe8THfQd9Q9vl/0npmgyA90lJtxXnARsi9Xkf8g+ScN03vsfz46cTsoBunTaARPm
        WDvTC4+1nxgm3LDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D107313A65;
        Fri, 26 Aug 2022 02:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RfFZI24tCGO8MQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:18:22 +0000
Subject: [PATCH 07/10] VFS: hold DCACHE_PAR_UPDATE lock across d_revalidate()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984376.25420.10279547885121512294.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

->d_revalidate() functions do not, as a rule, block renames (though 9p
does).  Several access the parent of the dentry often, but not always,
taking a reference to be sure it doesn't disappear.
It is in general possible for d_revalidate to race with rename so the
directory the d_revalidate works with may not be the parent of the
dentry by the time the call finishes.

The exact consequence of this will vary between filesystem and may not
be problematic.  However it seems safest to provide exclusion between
d_revalidate and other operations that change the dentry such as rename,
when doing so is inexpensive

The introduction of DCACHE_PAR_UPDATE does make this easy.  d_revalidate
can set this flag, or wait if it is already set.  This ensures there
will be no race, without needing to lock the whole directory.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a7c458cc787c..ef994239fa7c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -852,10 +852,37 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 
 static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
-		return dentry->d_op->d_revalidate(dentry, flags);
-	else
+	int status;
+
+	if (!unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
 		return 1;
+
+	lock_acquire_exclusive(&dentry->d_update_map, I_MUTEX_NORMAL,
+			       0, NULL, _THIS_IP_);
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_flags & DCACHE_PAR_UPDATE) {
+		/* Some other thread owns this dentry */
+		if (flags & LOOKUP_RCU) {
+			spin_unlock(&dentry->d_lock);
+			lock_map_release(&dentry->d_update_map);
+			return -ECHILD;
+		}
+		___wait_var_event(&dentry->d_flags,
+				  !(dentry->d_flags & DCACHE_PAR_UPDATE),
+				  TASK_UNINTERRUPTIBLE, 0, 0,
+				  (spin_unlock(&dentry->d_lock),
+				   schedule(),
+				   spin_lock(&dentry->d_lock))
+			);
+	}
+	dentry->d_flags |= DCACHE_PAR_UPDATE;
+	spin_unlock(&dentry->d_lock);
+
+	status = dentry->d_op->d_revalidate(dentry, flags);
+
+	d_unlock_update(dentry);
+
+	return status;
 }
 
 /**


