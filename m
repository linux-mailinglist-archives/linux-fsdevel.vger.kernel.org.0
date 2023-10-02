Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D47B4AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjJBCfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 22:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:35:49 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4AA7
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 19:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EewcqI+Ox5ekxQxUglqzLiq/FvSzeoK/B4dyiwaADCs=; b=PsJIJ3ivSQByKwOMBtumcyoupc
        g6mhCPrAp7S+NeEjzIY8xVp+ob2NWWEduzl/83qwOCOtb4XTOfCIi4ZxNV4CZPVHj0YX0IkANY2yR
        17P+NL3LCfTaMci4RdXH6s0IkQN69NgyLODWAgzJvtB8gxtBMIm91MgsTwcN/oE604HZPrcWP/c82
        2sopADg6YhH+tRPSAg4tmzr8VQpTMcsG/4solf5Ljpc26+vqLLNze57rkwAEsutLPpWD4z0Z5BrAb
        UozVoxLlycd3hybAEnzOyCgd0m9bCccNQMNLTyNIxelcJPuD4+Vqx1DP73P/go/u93eqmfiLoDZRG
        g1ScOkbg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qn8mf-00EDyN-1d;
        Mon, 02 Oct 2023 02:35:45 +0000
Date:   Mon, 2 Oct 2023 03:35:45 +0100
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
Subject: [PATCH 12/15] afs: fix __afs_break_callback() / afs_drop_open_mmap()
 race
Message-ID: <20231002023545.GM3389589@ZenIV>
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

In __afs_break_callback() we might check ->cb_nr_mmap and if it's non-zero
do queue_work(&vnode->cb_work).  In afs_drop_open_mmap() we decrement
->cb_nr_mmap and do flush_work(&vnode->cb_work) if it reaches zero.

The trouble is, there's nothing to prevent __afs_break_callback() from
seeing ->cb_nr_mmap before the decrement and do queue_work() after both
the decrement and flush_work().  If that happens, we might be in trouble -
vnode might get freed before the queued work runs.

__afs_break_callback() is always done under ->cb_lock, so let's make
sure that ->cb_nr_mmap can change from non-zero to zero while holding
->cb_lock (the spinlock component of it - it's a seqlock and we don't
need to mess with the counter).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/afs/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index d37dd201752b..0012ea300eb5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -529,13 +529,17 @@ static void afs_add_open_mmap(struct afs_vnode *vnode)
 
 static void afs_drop_open_mmap(struct afs_vnode *vnode)
 {
-	if (!atomic_dec_and_test(&vnode->cb_nr_mmap))
+	if (atomic_add_unless(&vnode->cb_nr_mmap, -1, 1))
 		return;
 
 	down_write(&vnode->volume->cell->fs_open_mmaps_lock);
 
-	if (atomic_read(&vnode->cb_nr_mmap) == 0)
+	read_seqlock_excl(&vnode->cb_lock);
+	// the only place where ->cb_nr_mmap may hit 0
+	// see __afs_break_callback() for the other side...
+	if (atomic_dec_and_test(&vnode->cb_nr_mmap))
 		list_del_init(&vnode->cb_mmap_link);
+	read_sequnlock_excl(&vnode->cb_lock);
 
 	up_write(&vnode->volume->cell->fs_open_mmaps_lock);
 	flush_work(&vnode->cb_work);
-- 
2.39.2

