Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302A4B055C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 06:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiBJFkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 00:40:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiBJFjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:39:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CACD25DD;
        Wed,  9 Feb 2022 21:39:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE7C2210F6;
        Thu, 10 Feb 2022 05:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644471582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRQpTl6gU6MaBAdfwSalgYu+ynBw18B3JAwgtU5P7zs=;
        b=ChcdrxYihvrPbp5PVjckJeU5yNZ5WNA9eaF6g57ACzDLD8aukwAyGJrE1Dhoh0nTjp4vt2
        nDZOwS43Pd9e6ZAdWcXKM87utZEcMZseQwKBd8oSmVwF8lztvA4i8ChJRD3pTLDlnc1Nh1
        YE2K6gLKx5L2TOpAPctUhAL+S56F5Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644471582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CRQpTl6gU6MaBAdfwSalgYu+ynBw18B3JAwgtU5P7zs=;
        b=GFA0nCwwuMbxx5Xi7mI/VTbiRQlokeaPReGyF7/os614XAwf1Ti7o9FLajEb3ztekE66ra
        kxZ9tHN6H4q9aqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 844C313519;
        Thu, 10 Feb 2022 05:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TtwLERelBGIEOQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 10 Feb 2022 05:39:35 +0000
Subject: [PATCH 05/11] nfs: remove reliance on bdi congestion
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
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
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 10 Feb 2022 16:37:52 +1100
Message-ID: <164447147259.23354.17010890548107181818.stgit@noble.brown>
In-Reply-To: <164447124918.23354.17858831070003318849.stgit@noble.brown>
References: <164447124918.23354.17858831070003318849.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The bdi congestion tracking in not widely used and will be removed.

NFS is one of a small number of filesystems that uses it, setting just
the async (write) congestion flag at what it determines are appropriate
times.

The only remaining effect of the async flag is to cause (some)
WB_SYNC_NONE writes to be skipped.

So instead of setting the flag, set an internal flag and change:
 - .writepages to do nothing if WB_SYNC_NONE and the flag is set
 - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
    and the flag is set.

The writepages change causes a behavioural change in that pageout() can
now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
be called on the page which (I think) wil further delay the next attempt
at writeout.  This might be a good thing.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/write.c            |   14 +++++++++++---
 include/linux/nfs_fs_sb.h |    1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 987a187bd39a..7c986164018e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -417,7 +417,7 @@ static void nfs_set_page_writeback(struct page *page)
 
 	if (atomic_long_inc_return(&nfss->writeback) >
 			NFS_CONGESTION_ON_THRESH)
-		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
+		nfss->write_congested = 1;
 }
 
 static void nfs_end_page_writeback(struct nfs_page *req)
@@ -433,7 +433,7 @@ static void nfs_end_page_writeback(struct nfs_page *req)
 
 	end_page_writeback(req->wb_page);
 	if (atomic_long_dec_return(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
-		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
+		nfss->write_congested = 0;
 }
 
 /*
@@ -672,6 +672,10 @@ static int nfs_writepage_locked(struct page *page,
 	struct inode *inode = page_file_mapping(page)->host;
 	int err;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    NFS_SERVER(inode)->write_congested)
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0,
 				false, &nfs_async_write_completion_ops);
@@ -719,6 +723,10 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	int priority = 0;
 	int err;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    NFS_SERVER(inode)->write_congested)
+		return 0;
+
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
 
 	if (!(mntflags & NFS_MOUNT_WRITE_EAGER) || wbc->for_kupdate ||
@@ -1893,7 +1901,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
-		clear_bdi_congested(inode_to_bdi(data->inode), BLK_RW_ASYNC);
+		nfss->write_congested = 0;
 
 	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
 	nfs_commit_end(cinfo.mds);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ca0959e51e81..6aa2a200676a 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -138,6 +138,7 @@ struct nfs_server {
 	struct nlm_host		*nlm_host;	/* NLM client handle */
 	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
 	atomic_long_t		writeback;	/* number of writeback pages */
+	unsigned int		write_congested;/* flag set when writeback gets too high */
 	unsigned int		flags;		/* various flags */
 
 /* The following are for internal use only. Also see uapi/linux/nfs_mount.h */


