Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A4D7B4AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjJBCdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:33:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8422199
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jr3LRvkagY6xKaUxMwPrFP/7310J+gLk9DTRF6npBoc=; b=SGE2uq4Go7mJVGzis76cGzY5Nt
        OZwAwKqlJ6jIHRyfs7yHvZ5YDdeH+6x7QWTg96Luy2sXC3W2almmCEIYvdm5OR2s0+58YKQwt4GWA
        ZSKZG4T+vl9HMr8ad1zp8PkdoODfBC55rpWRra02SjjGlxqcpH/9Arfw5qgOuBFLp4r1pDapAGD+Q
        tKwih81Zmg4aeKyGv2fiyO7RdaXhV6xIOA5RGsRldtQjM+P5kA5UvqO5j1VC0StHfN1X2c3xucXrs
        6x9ETCzBfvW33/FOkxjSgdpnRfwhvvcuVerCEUgAfnSET6Kqlw7NJ/libRyZkRtDzVWbRGcuP4FcS
        TL/zrN6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8k8-00EDuS-2q;
        Mon, 02 Oct 2023 02:33:08 +0000
Date:   Mon, 2 Oct 2023 03:33:08 +0100
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
Subject: [PATCH 07/15] procfs: make freeing proc_fs_info rcu-delayed
Message-ID: <20231002023308.GH3389589@ZenIV>
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

makes proc_pid_ns() safe from rcu pathwalk (put_pid_ns()
is still synchronous, but that's not a problem - it does
rcu-delay everything that needs to be)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/root.c          | 2 +-
 include/linux/proc_fs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 9191248f2dac..d3148e1d883b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -271,7 +271,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
-	kfree(fs_info);
+	kfree_rcu(fs_info, rcu);
 }
 
 static struct file_system_type proc_fs_type = {
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index de407e7c3b55..0b2a89854440 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -65,6 +65,7 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	struct rcu_head rcu;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.39.2

