Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B24A3CD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357550AbiAaEEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:04:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38114 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357535AbiAaEEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:04:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E18DD1F37B;
        Mon, 31 Jan 2022 04:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643601859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvEfPPeht+6m2tsZLWgUEFf5HAsVvo5FwysookxUClM=;
        b=pWLJsZQNiOZbmu3eHyMn/kzxEXxEDEFjwUaAFNCgalKi2l2pg/Kyz1XB4Ug4fvmkcYL69j
        MZqqyni/ZnMvg3P9IUpG5zl6SYCa8+Pm4oyJppurBjd8a0Ssqu1z0Kcg5i3XbqQbZOu7Wh
        rITudZlWMGA2T0ZLrgSx5ys/XVr3KfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643601859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TvEfPPeht+6m2tsZLWgUEFf5HAsVvo5FwysookxUClM=;
        b=u+H/QuonS17YLO3VoRbzj2f8Ql1DJ8PA4qG9qwIyYO3JFIvSJsBoYhRdZUsgK2hLzNwIDz
        iTGQ7ht98k8zONDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFA8A133A4;
        Mon, 31 Jan 2022 04:04:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id spA/H8Bf92GcCQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 04:04:16 +0000
Subject: [PATCH 2/3] nfs: remove reliance on bdi congestion
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:03:53 +1100
Message-ID: <164360183350.4233.691070075155620959.stgit@noble.brown>
In-Reply-To: <164360127045.4233.2606812444285122570.stgit@noble.brown>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 fs/nfs/write.c            |   12 ++++++++++--
 include/linux/nfs_fs_sb.h |    1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 987a187bd39a..b7c6721dd36d 100644
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


