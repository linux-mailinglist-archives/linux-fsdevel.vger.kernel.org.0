Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344747B4AC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjJBC3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBC3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:29:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8099
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qtssQeJsjUASDuYOM8OQSYDchLVAVU547/17cTtVxo=; b=EvUU3h41JyQfOgifStLhmdnZEK
        AFDoR/DAE2GnHpOZXj4M97g2m8wRrv2eMLNsK8l+iMEhKoNuqAhzihHaMljN23SBNbYG46nXR9fGL
        2QNg8sqPpe0fM/0nNvMR8WYygEPFwHIdoh73bML35DDTl6WuyABzImFze9TknSSYK7yhZSYKBYOS3
        nVDMgKzvo0u8FT47zEvdSpNEcxf1nv087qEo4zF15j/fzEtK19wfwzLkR4wTew4/NgLZvaUKBrqxb
        LM+AgITV5t5HAi9pYAyCFBoSWkerZUWFVVpxliv/5TJmyNedkWMKGRpnQArNeyAgh9t7i2xwjHBlF
        vkz7AX6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8gb-00EDoa-2M;
        Mon, 02 Oct 2023 02:29:29 +0000
Date:   Mon, 2 Oct 2023 03:29:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 01/15] rcu pathwalk: prevent bogus hard errors from
 may_lookup()
Message-ID: <20231002022929.GB3389589@ZenIV>
References: <20231002022815.GQ800259@ZenIV>
 <20231002022846.GA3389589@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002022846.GA3389589@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If lazy call of ->permission() returns a hard error, check that
try_to_unlazy() succeeds before returning it.  That both makes
life easier for ->permission() instances and closes the race
in ENOTDIR handling - it is possible that positive d_can_lookup()
seen in link_path_walk() applies to the state *after* unlink() +
mkdir(), while nd->inode matches the state prior to that.

Normally seeing e.g. EACCES from permission check in rcu pathwalk
means that with some timings non-rcu pathwalk would've run into
the same; however, running into a non-executable regular file
in the middle of a pathname would not get to permission check -
it would fail with ENOTDIR instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 567ee547492b..2494561a21fe 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1717,7 +1717,11 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 {
 	if (nd->flags & LOOKUP_RCU) {
 		int err = inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
-		if (err != -ECHILD || !try_to_unlazy(nd))
+		if (!err)		// success, keep going
+			return 0;
+		if (!try_to_unlazy(nd))
+			return -ECHILD;	// redo it all non-lazy
+		if (err != -ECHILD)	// hard error
 			return err;
 	}
 	return inode_permission(idmap, nd->inode, MAY_EXEC);
-- 
2.39.2

