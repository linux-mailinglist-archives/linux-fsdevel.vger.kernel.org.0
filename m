Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AED7B4AC9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjJBCay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjJBCax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:30:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F81CE
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ug2Y34xz5+mbpB8ClVi23teq0mMkMZtGfWZr82RpmBQ=; b=XKsIvh7OqmANv2S3hQQOts+npj
        lngoZ8szVr4NNYSzdeu12RXhtWNdd0/RSlG0I/eiTe1cVuuzkMlBznQpvjGyvUOyWI5hci/p40rzp
        vLv+RSk7yqps70ywFEPyyDK9KL/q7AXNOKuqQktNP5rhpXMk1puDbrSOGHmAG3XGNlD/RMnBcStjT
        /hguLELyVjpfmxieNDNi9R9fTrIqy56xXvxSHbfbec3Ydlvl5OTQdarZZaqWlVJuHw7UI3fa0KBH+
        w1BxTEkcJFMI6ZGOaOm+VaIo37oh7qNuWupvUiDEoYdwAcpwm99vTIFYUDV6c17zuQe6S6V9kyzSD
        TOiXkVdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8ht-00EDql-1S;
        Mon, 02 Oct 2023 02:30:49 +0000
Date:   Mon, 2 Oct 2023 03:30:49 +0100
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
Subject: [PATCH 03/15] affs: free affs_sb_info with kfree_rcu()
Message-ID: <20231002023049.GD3389589@ZenIV>
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

one of the flags in it is used by ->d_hash()/->d_compare()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/affs/affs.h  | 1 +
 fs/affs/super.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 60685ec76d98..2e612834329a 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -105,6 +105,7 @@ struct affs_sb_info {
 	int work_queued;		/* non-zero delayed work is queued */
 	struct delayed_work sb_work;	/* superblock flush delayed work */
 	spinlock_t work_lock;		/* protects sb_work and work_queued */
+	struct rcu_head rcu;
 };
 
 #define AFFS_MOUNT_SF_INTL		0x0001 /* International filesystem. */
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 58b391446ae1..b56a95cf414a 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -640,7 +640,7 @@ static void affs_kill_sb(struct super_block *sb)
 		affs_brelse(sbi->s_root_bh);
 		kfree(sbi->s_prefix);
 		mutex_destroy(&sbi->s_bmlock);
-		kfree(sbi);
+		kfree_rcu(sbi, rcu);
 	}
 }
 
-- 
2.39.2

