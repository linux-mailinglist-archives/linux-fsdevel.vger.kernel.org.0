Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC549D865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiA0CtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:49:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55004 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiA0CtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:49:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D36CF1F45F;
        Thu, 27 Jan 2022 02:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643251746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZDgYM8qwS7cEjgCZQh3dYscA/4Dgjn5wr47tYjWHxQ=;
        b=OabKjx61FrTXFFxOiTH9E0UU6VNFC44VWp7PWLnKiKXP6g2ugD0tfQ02c4R1eM0eHNLx9S
        G2jSPZ8PxVtwKkHPLyq1DoOJE8/o9xInUSEIPNVQw3bZ9rdhv0nRfFw1T3aU0HrltaTx4Z
        Wl5jPTVqSxQVC9k6/tLDDrT2ibDEDcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643251746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZDgYM8qwS7cEjgCZQh3dYscA/4Dgjn5wr47tYjWHxQ=;
        b=D98bulEbZ/C02MAVX9285ZaaoqlEkffCcUaXh/N7JqN3KhqQHCrwZ5n3haM36DVFvGMwjK
        I4U0mIHIzRrzrODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ED9513E46;
        Thu, 27 Jan 2022 02:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KeWrOhgI8mFFLAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 02:48:56 +0000
Subject: [PATCH 7/9] NFS: remove congestion control.
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 27 Jan 2022 13:46:29 +1100
Message-ID: <164325158959.29787.14903007819591774556.stgit@noble.brown>
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linux no longer uses the bdi congestion tracking framework.
So remove code from bdi which tries to support it.

Also remove the "nfs_congestion_kb" sysctl.  This is a user-visible
change, but unlikely to be a problematic one.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/sysctl.c           |    7 ------
 fs/nfs/write.c            |   53 +--------------------------------------------
 include/linux/nfs_fs.h    |    1 -
 include/linux/nfs_fs_sb.h |    1 -
 4 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/fs/nfs/sysctl.c b/fs/nfs/sysctl.c
index 7aea195ddb35..18f3ff77fd0c 100644
--- a/fs/nfs/sysctl.c
+++ b/fs/nfs/sysctl.c
@@ -22,13 +22,6 @@ static struct ctl_table nfs_cb_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{
-		.procname	= "nfs_congestion_kb",
-		.data		= &nfs_congestion_kb,
-		.maxlen		= sizeof(nfs_congestion_kb),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 	{ }
 };
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 987a187bd39a..1c22ea6f23c3 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -397,33 +397,8 @@ static int wb_priority(struct writeback_control *wbc)
 	return ret;
 }
 
-/*
- * NFS congestion control
- */
-
-int nfs_congestion_kb;
-
-#define NFS_CONGESTION_ON_THRESH 	(nfs_congestion_kb >> (PAGE_SHIFT-10))
-#define NFS_CONGESTION_OFF_THRESH	\
-	(NFS_CONGESTION_ON_THRESH - (NFS_CONGESTION_ON_THRESH >> 2))
-
-static void nfs_set_page_writeback(struct page *page)
-{
-	struct inode *inode = page_file_mapping(page)->host;
-	struct nfs_server *nfss = NFS_SERVER(inode);
-	int ret = test_set_page_writeback(page);
-
-	WARN_ON_ONCE(ret != 0);
-
-	if (atomic_long_inc_return(&nfss->writeback) >
-			NFS_CONGESTION_ON_THRESH)
-		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
-}
-
 static void nfs_end_page_writeback(struct nfs_page *req)
 {
-	struct inode *inode = page_file_mapping(req->wb_page)->host;
-	struct nfs_server *nfss = NFS_SERVER(inode);
 	bool is_done;
 
 	is_done = nfs_page_group_sync_on_bit(req, PG_WB_END);
@@ -432,8 +407,6 @@ static void nfs_end_page_writeback(struct nfs_page *req)
 		return;
 
 	end_page_writeback(req->wb_page);
-	if (atomic_long_dec_return(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
-		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 }
 
 /*
@@ -617,7 +590,7 @@ static int nfs_page_async_flush(struct nfs_pageio_descriptor *pgio,
 	if (IS_ERR(req))
 		goto out;
 
-	nfs_set_page_writeback(page);
+	set_page_writeback(page);
 	WARN_ON_ONCE(test_bit(PG_CLEAN, &req->wb_flags));
 
 	/* If there is a fatal error that covers this write, just exit */
@@ -1850,7 +1823,6 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 	struct nfs_page	*req;
 	int status = data->task.tk_status;
 	struct nfs_commit_info cinfo;
-	struct nfs_server *nfss;
 
 	while (!list_empty(&data->pages)) {
 		req = nfs_list_entry(data->pages.next);
@@ -1891,9 +1863,6 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		/* Latency breaker */
 		cond_resched();
 	}
-	nfss = NFS_SERVER(data->inode);
-	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
-		clear_bdi_congested(inode_to_bdi(data->inode), BLK_RW_ASYNC);
 
 	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
 	nfs_commit_end(cinfo.mds);
@@ -2162,26 +2131,6 @@ int __init nfs_init_writepagecache(void)
 	if (nfs_commit_mempool == NULL)
 		goto out_destroy_commit_cache;
 
-	/*
-	 * NFS congestion size, scale with available memory.
-	 *
-	 *  64MB:    8192k
-	 * 128MB:   11585k
-	 * 256MB:   16384k
-	 * 512MB:   23170k
-	 *   1GB:   32768k
-	 *   2GB:   46340k
-	 *   4GB:   65536k
-	 *   8GB:   92681k
-	 *  16GB:  131072k
-	 *
-	 * This allows larger machines to have larger/more transfers.
-	 * Limit the default to 256M
-	 */
-	nfs_congestion_kb = (16*int_sqrt(totalram_pages())) << (PAGE_SHIFT-10);
-	if (nfs_congestion_kb > 256*1024)
-		nfs_congestion_kb = 256*1024;
-
 	return 0;
 
 out_destroy_commit_cache:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 02aa49323d1d..17045c229277 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -569,7 +569,6 @@ extern void nfs_complete_unlink(struct dentry *dentry, struct inode *);
 /*
  * linux/fs/nfs/write.c
  */
-extern int  nfs_congestion_kb;
 extern int  nfs_writepage(struct page *page, struct writeback_control *wbc);
 extern int  nfs_writepages(struct address_space *, struct writeback_control *);
 extern int  nfs_flush_incompatible(struct file *file, struct page *page);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ca0959e51e81..3444ebbc63b6 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -137,7 +137,6 @@ struct nfs_server {
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
 	struct nlm_host		*nlm_host;	/* NLM client handle */
 	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
-	atomic_long_t		writeback;	/* number of writeback pages */
 	unsigned int		flags;		/* various flags */
 
 /* The following are for internal use only. Also see uapi/linux/nfs_mount.h */


