Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FF6C98EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 02:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjC0AEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 20:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC0AEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:04:51 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018544494
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 17:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gYPyitMwH1XD+qGUZZi80jHgOsGcHKk+FkqZSf7d3xs=; b=Q/pzdhQ0bX9mm+VrDcRxFP2Xv0
        WIuPwc0xdcjsgdEv2+loLtAeXG+bux4Sl+b3jGuSn4DgFoSXQ6EhGwlffdSlOqFAwX7QhGX/+XZ4K
        09vY47yk38N2PUJ+Dw3H8Bpu9g10sTd3elBwVLubhh9F4jgV//JiAjuQg316dY3F4NVgkoLC7MzI3
        3T5MXFoEuoAjx8RMQn0e8c9votZRv5IkneJRLahzUaO76mcMtBYttywoB+ae+Zm2sMjHBuoRVMCee
        jjsSb+Cnk59fP5qdeylUVYdcU2RP2fk5Nf+cfFGUMw8vxMfQhkTGzepN+FYMig/lqzVfyWLD1perS
        G2SEMu+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgaLo-002BAW-2z;
        Mon, 27 Mar 2023 00:04:41 +0000
Date:   Mon, 27 Mar 2023 01:04:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] sysv: convert pointers_lock from rw_lock to rw_sem
Message-ID: <20230327000440.GF3390869@ZenIV>
References: <0000000000000ccf9a05ee84f5b0@google.com>
 <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:24:25AM +0900, Tetsuo Handa wrote:
> syzbot is reporting that __getblk_gfp() cannot be called from atomic
> context. Fix this problem by converting pointers_lock from rw_lock to
> rw_sem.
> 
> Reported-by: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>

Hmm...  The bug is real, all right (introduced back in 2002 during the
conversion away from BKL;
commit 3ba77f860fa7f359660e9d498a5b35940021cfba
Author: Christoph Hellwig <hch@sb.bsdonline.org>
Date:   Thu Apr 4 00:25:37 2002 +0200

    Replace BKL for chain locking with sysvfs-private rwlock.
is where it had happened).

However, I don't think this is the right fix.  Note that the problem is
with get_branch() done under the rwlock; all other places are safe.  But
in get_branch() we only need the lock (and only shared, at that) around
the verify+add pair.  See how it's done in fs/minix/itree_common.c...
Something like this:

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index b22764fe669c..cfa281fb6578 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -104,15 +104,18 @@ static Indirect *get_branch(struct inode *inode,
 		bh = sb_bread(sb, block);
 		if (!bh)
 			goto failure;
+		read_lock(&pointers_lock);
 		if (!verify_chain(chain, p))
 			goto changed;
 		add_chain(++p, bh, (sysv_zone_t*)bh->b_data + *++offsets);
+		read_unlock(&pointers_lock);
 		if (!p->key)
 			goto no_block;
 	}
 	return NULL;
 
 changed:
+	read_unlock(&pointers_lock);
 	brelse(bh);
 	*err = -EAGAIN;
 	goto no_block;
@@ -214,9 +217,7 @@ static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *b
 		goto out;
 
 reread:
-	read_lock(&pointers_lock);
 	partial = get_branch(inode, depth, offsets, chain, &err);
-	read_unlock(&pointers_lock);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -287,10 +288,11 @@ static Indirect *find_shared(struct inode *inode,
 	for (k = depth; k > 1 && !offsets[k-1]; k--)
 		;
 
-	write_lock(&pointers_lock);
 	partial = get_branch(inode, k, offsets, chain, &err);
 	if (!partial)
 		partial = chain + k-1;
+
+	write_lock(&pointers_lock);
 	/*
 	 * If the branch acquired continuation since we've looked at it -
 	 * fine, it should all survive and (new) top doesn't belong to us.
