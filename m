Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E47B4AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjJBCfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:35:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782BCE
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EbwDiolze3U4QPmXm+BW52LaQUDPZmPACbWujMd5Kfg=; b=C0fxxBfI2TW91B+ihO3RoJCuJT
        KY2O1civkUDuN2gD+Tor7JeSIKH5J5LnKLhEp3B/RQZC/lLTAfFUazAtF/Lr4ktpkkwYlW9gbuhjI
        lV2FWbf097yfCeR6FD62HvIKLCiV0NYkZ8LPVozd/UnBN416YPJRjCFhWDGjJhAalCq6VEUCUgtWw
        UjF8wAcLx/CUrxdMRF4wxeK9v3agU5Uiy2pjIYe23fjm7oO9Dk7ElhcdfWRabUI2DbjHmKQpwRS6H
        8A+s8HLSvsP8wWyUCyPKbNtv4zqI50MlMPstTWhfnFp5BpmXcGQV8JIocT0NMqwzaB1ZGyaxTyjno
        Ldi1WmYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8ls-00EDxB-1J;
        Mon, 02 Oct 2023 02:34:56 +0000
Date:   Mon, 2 Oct 2023 03:34:56 +0100
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
Subject: [PATCH 10/15] nfs: fix UAF on pathwalk running into umount
Message-ID: <20231002023456.GK3389589@ZenIV>
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

NFS ->d_revalidate(), ->permission() and ->get_link() need to access
some parts of nfs_server when called in RCU mode:
	server->flags
	server->caps
	*(server->io_stats)
and, worst of all, call
	server->nfs_client->rpc_ops->have_delegation
(the last one - as NFS_PROTO(inode)->have_delegation()).  We really
don't want to RCU-delay the entire nfs_free_server() (it would have
to be done with schedule_work() from RCU callback, since it can't
be made to run from interrupt context), but actual freeing of
nfs_server and ->io_stats can be done via call_rcu() just fine.
nfs_client part is handled simply by making nfs_free_client() use
kfree_rcu().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/client.c           | 13 ++++++++++---
 include/linux/nfs_fs_sb.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..fbdc9ca80f71 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -246,7 +246,7 @@ void nfs_free_client(struct nfs_client *clp)
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
 	kfree(clp->cl_acceptor);
-	kfree(clp);
+	kfree_rcu(clp, rcu);
 }
 EXPORT_SYMBOL_GPL(nfs_free_client);
 
@@ -1006,6 +1006,14 @@ struct nfs_server *nfs_alloc_server(void)
 }
 EXPORT_SYMBOL_GPL(nfs_alloc_server);
 
+static void delayed_free(struct rcu_head *p)
+{
+	struct nfs_server *server = container_of(p, struct nfs_server, rcu);
+
+	nfs_free_iostats(server->io_stats);
+	kfree(server);
+}
+
 /*
  * Free up a server record
  */
@@ -1031,10 +1039,9 @@ void nfs_free_server(struct nfs_server *server)
 
 	ida_destroy(&server->lockowner_id);
 	ida_destroy(&server->openowner_id);
-	nfs_free_iostats(server->io_stats);
 	put_cred(server->cred);
-	kfree(server);
 	nfs_release_automount_timer();
+	call_rcu(&server->rcu, delayed_free);
 }
 EXPORT_SYMBOL_GPL(nfs_free_server);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index cd628c4b011e..4bd16da65c05 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -124,6 +124,7 @@ struct nfs_client {
 	char			cl_ipaddr[48];
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
+	struct rcu_head		rcu;
 };
 
 /*
@@ -264,6 +265,7 @@ struct nfs_server {
 	const struct cred	*cred;
 	bool			has_sec_mnt_opts;
 	struct kobject		kobj;
+	struct rcu_head		rcu;
 };
 
 /* Server capabilities */
-- 
2.39.2

