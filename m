Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D684BF0CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 05:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbiBVDTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 22:19:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbiBVDTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:19:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631312AF8;
        Mon, 21 Feb 2022 19:19:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D6B21210E8;
        Tue, 22 Feb 2022 03:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645499948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBfA0J1VAN4vDciFet8kyITCSUUXphOKJM0dbNgQDlg=;
        b=i/NDtzyku1VotL27Yt5ND5uuuQDGX4tAL44NUrr7an8PugkHaqoNxoBxn6WhY9Zt0cJN06
        IrmlVgKZlFI4eGKB2RklR3Dt6IF7R1G7GZaellr0Kq8CN0od6q7uHbJ4mgOfhhW7zJkzqA
        rO1bQkI32VQdA/pTUNRUBAt4x9JjlcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645499948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBfA0J1VAN4vDciFet8kyITCSUUXphOKJM0dbNgQDlg=;
        b=G4azxQs3m/GiCNS1OtSNXkwOgWeZkHdPwA5vsNLp+pc6nW6/NFnKo60Ie1EuGO1FdMHYZw
        2sGIrCV+BV9wnGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE2DB13BA7;
        Tue, 22 Feb 2022 03:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rd8AIyVWFGLCWgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 22 Feb 2022 03:19:01 +0000
Subject: [PATCH 06/11] ceph: remove reliance on bdi congestion
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
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Feb 2022 14:17:17 +1100
Message-ID: <164549983739.9187.14895675781408171186.stgit@noble.brown>
In-Reply-To: <164549971112.9187.16871723439770288255.stgit@noble.brown>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
User-Agent: StGit/0.23
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

The bdi congestion tracking in not widely used and will be removed.

CEPHfs is one of a small number of filesystems that uses it, setting
just the async (write) congestion flags at what it determines are
appropriate times.

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
 fs/ceph/addr.c  |   22 +++++++++++++---------
 fs/ceph/super.c |    1 +
 fs/ceph/super.h |    1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c98e5238a1b6..dc7af34640dd 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -563,7 +563,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
-		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
+		fsc->write_congested = true;
 
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode), page_off, &len, 0, 1,
 				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE, snapc,
@@ -623,7 +623,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	if (atomic_long_dec_return(&fsc->writeback_count) <
 	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
-		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
+		fsc->write_congested = false;
 
 	return err;
 }
@@ -635,6 +635,10 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	BUG_ON(!inode);
 	ihold(inode);
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    ceph_inode_to_client(inode)->write_congested)
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	wait_on_page_fscache(page);
 
 	err = writepage_nounlock(page, wbc);
@@ -707,8 +711,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			     CONGESTION_OFF_THRESH(
 					fsc->mount_options->congestion_kb))
-				clear_bdi_congested(inode_to_bdi(inode),
-						    BLK_RW_ASYNC);
+				fsc->write_congested = false;
 
 			ceph_put_snap_context(detach_page_private(page));
 			end_page_writeback(page);
@@ -760,6 +763,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 	bool done = false;
 	bool caching = ceph_is_cache_enabled(inode);
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fsc->write_congested)
+		return 0;
+
 	dout("writepages_start %p (mode=%s)\n", inode,
 	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
 	     (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
@@ -954,11 +961,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (atomic_long_inc_return(&fsc->writeback_count) >
 			    CONGESTION_ON_THRESH(
-				    fsc->mount_options->congestion_kb)) {
-				set_bdi_congested(inode_to_bdi(inode),
-						  BLK_RW_ASYNC);
-			}
-
+				    fsc->mount_options->congestion_kb))
+				fsc->write_congested = true;
 
 			pages[locked_pages++] = page;
 			pvec.pages[i] = NULL;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index bf79f369aec6..4a3b77d049c7 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -802,6 +802,7 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	fsc->have_copy_from2 = true;
 
 	atomic_long_set(&fsc->writeback_count, 0);
+	fsc->write_congested = false;
 
 	err = -ENOMEM;
 	/*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 67f145e1ae7a..0bd97aea2319 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -121,6 +121,7 @@ struct ceph_fs_client {
 	struct ceph_mds_client *mdsc;
 
 	atomic_long_t writeback_count;
+	bool write_congested;
 
 	struct workqueue_struct *inode_wq;
 	struct workqueue_struct *cap_wq;


