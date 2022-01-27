Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56649D83F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiA0Crw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:47:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55138 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiA0Cru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:47:50 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D50621901;
        Thu, 27 Jan 2022 02:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643251668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8NYMcBcZD8GUv0cDvsP1eePtGigG8J8np/yV6nLjQQ=;
        b=lpTMtDdgzXu6IXlWF2Cla7JZeA4O6IZP0tjrp8fZaU7ivDos+PHoL/XQMfCABF+bEfNOP4
        asGZxs7WKvGfhEBJWG6JTtSILEhDDfyUZDxdz3isEFlXeNYP4t4z60IMGMWtpxXKM9DXAB
        qZWJthZJaYv1R8Swu1zG6SDpKtDJcMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643251668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8NYMcBcZD8GUv0cDvsP1eePtGigG8J8np/yV6nLjQQ=;
        b=GajJ1CW7bGmknt+eypyqRIr6NQ5RkVudFMz7+fbL2W6FyuUKWG82yY6INCh5zJBg+nHfCU
        1tfjV2LY/eskY2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5662613E46;
        Thu, 27 Jan 2022 02:47:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1653BcwH8mHgKwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 02:47:40 +0000
Subject: [PATCH 3/9] f2fs: change retry waiting for
 f2fs_write_single_data_page()
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
Message-ID: <164325158956.29787.7016948342209980097.stgit@noble.brown>
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

f2fs_write_single_data_page() can return -EAGAIN if it cannot get
the cp_rwsem lock - it holds a page lock and so cannot wait for it.

Some code which calls f2fs_write_single_data_page() use
congestion_wait() and then tries again.  congestion_wait() doesn't do
anything useful as congestion is no longer tracked.  So this is just a
simple sleep.

A better approach is it wait until the cp_rwsem lock can be taken - then
try again.  There is certainly no point trying again *before* the lock
can be taken.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/f2fs/compress.c |    6 +++---
 fs/f2fs/data.c     |    9 ++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d0c3aeba5945..58ff7f4b296c 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1505,9 +1505,9 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				if (IS_NOQUOTA(cc->inode))
 					return 0;
 				ret = 0;
-				cond_resched();
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				/* Wait until we can get the lock, then try again. */
+				f2fs_lock_op(F2FS_I_SB(cc->inode));
+				f2fs_unlock_op(F2FS_I_SB(cc->inode));
 				goto retry_write;
 			}
 			return ret;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c417864c66a..1d2341163e2c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3047,9 +3047,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
-						cond_resched();
-						congestion_wait(BLK_RW_ASYNC,
-							DEFAULT_IO_TIMEOUT);
+						/* Wait until we can get the
+						 * lock, then try again.
+						 */
+						f2fs_lock_op(F2FS_I_SB(mapping->host));
+						f2fs_unlock_op(F2FS_I_SB(mapping->host));
+
 						goto retry_write;
 					}
 					goto next;


