Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22567B4AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjJBCgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:36:18 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC853CE
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CnyoubvrTYwdXJkYsciRIhEb5IygrGOOq4H2i/Xv+rA=; b=UFn+Awi3DErcvTV1wvHcTbtrs3
        OTSnsxC8r017Vs9422JIn+t29GCysTBk7pVoshBKjPHrpWiGHWTUpFmG+iZJUjU9hdn8iFI1sUIp6
        8qWowzh1SfnpGESp0635gIzkVZQnRJeh2hCTJGUI2vne9xs4KixHBe2N1So9sbkdRq/N/5pXMxiD+
        fSTiEjc+grMT+oiXsc4AcEtSb4FPcMLkUmnQJTBOdFC3cKHkuXEmpYVgm4sYK3GzwXHNjCoyQABU5
        FQE6IolsW1eTWhy7LAURKaKV/V4BQpZC38bjFl7DqwFMbOy1ve8/hXI0oU42Y2p0fS6zacO/HD90f
        LQU1GPdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8n7-00EDz8-14;
        Mon, 02 Oct 2023 02:36:13 +0000
Date:   Mon, 2 Oct 2023 03:36:13 +0100
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
Subject: [PATCH 13/15] overlayfs: move freeing ovl_entry past rcu delay
Message-ID: <20231002023613.GN3389589@ZenIV>
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

... into ->free_inode(), that is.

Fixes: 0af950f57fef "ovl: move ovl_entry into ovl_inode"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index def266b5e2a3..f09184b865ec 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -167,6 +167,7 @@ static void ovl_free_inode(struct inode *inode)
 	struct ovl_inode *oi = OVL_I(inode);
 
 	kfree(oi->redirect);
+	kfree(oi->oe);
 	mutex_destroy(&oi->lock);
 	kmem_cache_free(ovl_inode_cachep, oi);
 }
@@ -176,7 +177,7 @@ static void ovl_destroy_inode(struct inode *inode)
 	struct ovl_inode *oi = OVL_I(inode);
 
 	dput(oi->__upperdentry);
-	ovl_free_entry(oi->oe);
+	ovl_stack_put(ovl_lowerstack(oi->oe), ovl_numlower(oi->oe));
 	if (S_ISDIR(inode->i_mode))
 		ovl_dir_cache_free(inode);
 	else
-- 
2.39.2

