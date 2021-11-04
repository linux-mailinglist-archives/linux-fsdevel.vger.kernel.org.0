Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21510445882
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhKDRif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhKDRif (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:38:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167F6C061714;
        Thu,  4 Nov 2021 10:35:57 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id p17so5312760qkj.0;
        Thu, 04 Nov 2021 10:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=RrScSAJInVUyX3m9B+p8OuvdefmlGWgtsVCND68Y7O0=;
        b=VMT5lfUmFCy9htxTghfwPbxgAiK3Vx/kxD66hbuJYs+kWKgRJd8M5Nx/hXIXt1LvEQ
         5HeM8cvq8ppZfNwGKSyCAt+leYK3qCx+5uVMv1uuA0JgRmnvwwbGkZ9kPUElIS5Axc9H
         hgvRkHKM1RS4y09NGpkuUdUelOIvA1w+wfApOgYIKkodeyhVazNNBQTDSFno/nl/RnBS
         gkPhRzkkNPJS6SHZJkIWvpXeYU2Wkq593Zj/mz6/KPlvFpdXA2mEAaD/cLsT5yqvHqFi
         z22SajvWtjdCRCiguh3PKJP1nItL6/osoxRpZyV14beB8v8RNbtWc02fKfRiBtUSM7cQ
         mDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=RrScSAJInVUyX3m9B+p8OuvdefmlGWgtsVCND68Y7O0=;
        b=V5tcn9+cVc6rfCZtjL+uKBxiweSeAPGEkgTD05EF1YKJMjTbwdHMiIpITqgEuUQw4F
         j9QLxn8A8puy4bRBKfinASW8cwck1+jNc1EPO4VA1dn5ku5MlG25krtPPWJLkZjQl80k
         sHf48ewbunCCnQpGu/WPBypEx8ZFVJaKBLkChpLp6pOZyN4bokF1xE4caQ7q4qFl5wGR
         4gr36vvLk2D34UAw+o3IvB7+AQXa5nMbCAsuT4DpWv1aIUUn08rFCtC9lYNqRvF6SRu3
         XCgTmylTWxq7Y2CxhIZi5U1KEoqsUC0tZGqSpvVtaaTseaGipwgS3s4UxiGZm1MRecLZ
         NLJw==
X-Gm-Message-State: AOAM532Np81Dhp3LNVN7puUwXfIE3bTIsUYedLSc/cQVJE3+vTTKNYM0
        +Hw5TlSpvox8Cdk615mCLWZzYae/qg==
X-Google-Smtp-Source: ABdhPJxqlAEbmyh423GT+Nu5xA8dj5f1k4/LBpHgUO9h0rCjokqhfPqm37qRFzSHizJuVECbiUGzng==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr4152137qko.387.1636047355795;
        Thu, 04 Nov 2021 10:35:55 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y14sm909743qta.86.2021.11.04.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:35:54 -0700 (PDT)
Date:   Thu, 4 Nov 2021 13:35:53 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: bcachefs status update - current and future work
Message-ID: <YYQZ+QmATIgKfzZ8@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Time to try and summarize everything that's been going on in bcachefs land since
my last lkml posting, and my thoughts on what's next.

Core btree improvements:
 - Updates to interior btree nodes are now journalled.

 - We're now updating parent btree node pointers on every btree write. This was
   a pretty major improvement - it means we can now always detect lost btree
   btree writes, which was a hole in encrypted mode and also turned out to be a
   robustness issue in RAID mode. It also means we can start to drop the journal
   sequence number blacklist mechanism and closed some rare corner case issues.
   And thanks to the previous item, it didn't cost us any performance.

 - We no longer have to mark every journal write as flush/fua - stole this idea
   from XFS, it was a pretty nice performance improvement.

 - Lots of btree locking improvements: notably, we now have assertions that we
   never hold btree locks while doing IO. This is really good for tail latency.

 - The transaction model is steadily improving and gaining more and more
   assertions; this makes it easier to write upper level FS code without
   worrying about locking considerations. We've started requiring every btree
   transaction to start with bch2_trans_begin(), and in particular there's
   asserts that this is the next thing called after a transaction restart.
   Catching random little bugs with new assertions is a good feeling.

 - The btree iterator code has now been split up into btree_iter and btree_path;
   btree_path implements the "path to a particular position in the btree" code,
   and btree_iter sits on top of that and implements iteration over keys,
   iteration over slots, iteration over extents, iteration for snapshots (that's
   a whole thing), and more - this refactoring came about during the work for
   snapshots and it turned out really nicely.

Recovery:
 - All alloc info is now updated fully transactionally. Originally we'd have to
   regenerate alloc info on every mount, then after every unclean shutdown -
   then for a long time we only had to regenerate alloc info for metadata after
   unclean shutdown. With updates to interior btree nodes being fully
   journalled, that makes updates to alloc info fully transactional and our
   mount times fast.

   Currently we still have to read all alloc info into memory on mount, but that
   too will be changing.

Features:
 - Reflink: I believe all the bugs have finally been shaken out. The last bug to
   be found was a refcount leak when we fragmented an existing indirect extent
   (by copygc/rebalance), and a reflink pointer only pointed to part of it. 

 - Erasure coding - we're still popping some silly assertions, it's on my todo
   list

 - Encryption: people keep wanting AES support, so at some point I'll try and
   find the time to add AES/GCM.

 - SNAPSHOTS ARE DONE (mostly), and they're badass. 

   I've successfully gotten up to a million snapshots (only changing a single
   file in each snapshot) in a VM. They scale. Fsck scales. Take as many
   snapshots as you want. Go wild.

   Still todo:
   - need to export a different st_dev for each subvolume, like btrfs, so that
     find -xdev does what you want and skips snapshots

   - we would like better atomicity w.r.t. pagecache on snapshot creation, and
     it'd be nice if we didn't have to do a big sync when creating a snapshot -
     we could do this by getting the subvolume's current snapshot ID at buffered
     write time, but there's other things that make this hard

   - we need per-snapshot ID disk space accounting. This is going to have to
     wait for a giant disk space accounting rework though, which will move disk
     space accounting out of the journal and to a dedicated btree.

   - userspace interface is very minimal - e.g. still need to implement
     recursive snapshotting.

   - quota support is currently disabled, because of interactions with
     snapshots; re-enabling that is high on my todo list.

   - the btree key cache is currently disabled for inodes, also because of
     interactions with snapshots: this is a performance regression until we get
     this solved.
   
About a year of my life went into snapshots and I'm _really_ proud with how they
turned out - in terms of algorithmic complexity, snapshots has been the biggest
single feature tackled and when I started there were a lot of big unknowns that
I honestly wasn't sure I was going to find solutions for. Still waiting on
more people to start really testing with them and banging on them (and we do
still need more tests written) but so far shaking things out has gone really
smoothly (more smoothly than erasure coding, that's for sure!)
   
FUTURE WORK:

I'm going to start really getting on people for review and working on
upstreaming this beast. I intend for it to be marked EXPERIMENTAL for awhile,
naturally - there are still on disk format changes coming that will be forced
upgrades. But getting snapshots done was the big goal I'd set for myself, so
it's time.

Besides that, my next big focus is going to be on scalability. bcachefs was
hitting 50 TB volumes even before it was called bcachefs - I fully intend for it
to scale to 50 PB. To get there, we need to:

 - Get rid of the in-memory bucket array. We're mostly there, all allocation
   information lives in the btree, but we need to make more improvements to the
   btree representation before we can ditch the pure in memory representation.

   - We need new persistent data structures for the allocator, so that the
     allocator doesn't have to scan buckets. First up will be implementing a
     persistent LRU, then probably a free space btree.

 - We need a backpointers btree, so that copygc doesn't have to scan the
   extents/reflink btrees.

 - Online fsck. This will come in stages: first, theres's the filesystem level
   fsck code in fs/bcachefs/fsck.c. The recent work improving the btree
   transaction layer and adding assertions there has been forcing the fsck code
   to change to be more rigorously correct (in the context of running
   concurrently with other filesytem operations); a lot of that code is most of
   the way there now. We'll need additional locking vs. other filesystem code
   for the directory structure and inode nlinks passes, but shouldnt't for the
   rest of the passes.

   After fsck.c is running concurrently, it'll be time to bring back concurrent
   btree gc, which regenerates alloc info. Woohoo.


-------------
End brain dump, thank you kindly for reading :)
