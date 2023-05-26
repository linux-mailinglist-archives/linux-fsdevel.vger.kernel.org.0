Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95622711B68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbjEZAjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjEZAjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:39:41 -0400
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FF194
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 17:39:38 -0700 (PDT)
Date:   Thu, 25 May 2023 20:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685061577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAij41UNtGpWYUDu6iAwvqbyiSleyjppykUtqBTUdmw=;
        b=Iq5WwXiffblb+kMf4YgSJILtg49ZkoeBlkvd4Sn6fK4FUaZzfflDGR7GR6nnqzXUEOKfvY
        xBCxOT1GV52keCCM74XBRB6BqZ8oQ5uRa0ENTb7EnJqM7CE2QYLugDMVdsuyQUKsIftfjw
        l+3e1I9MTs4wRZPpzoGErmgkvZn07as=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        cluster-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [Cluster-devel] [PATCH 06/32] sched: Add
 task_struct->faults_disabled_mapping
Message-ID: <ZG//xK/QSp1Wm72M@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev>
 <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan>
 <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzoJLCRLk+pCKAk@infradead.org>
 <CAHpGcML0CZ1RGkOf26iYt_tK0Ux=cfdW8d3bjMVbjXLr91cs+g@mail.gmail.com>
 <ZG/tTorh8G2919Jz@moria.home.lan>
 <CAHpGcMKQke0f5-y6fg3O5dBwcTYX69dEbxZgDiFABgOLCc+zGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMKQke0f5-y6fg3O5dBwcTYX69dEbxZgDiFABgOLCc+zGw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 02:05:26AM +0200, Andreas Grünbacher wrote:
> Oh, it's just that gfs2 uses one dlm lock per inode to control access
> to that inode. In the code, this is called the "inode glock" ---
> glocks being an abstraction above dlm locks --- but it boils down to
> dlm locks in the end. An additional layer of locking will only work
> correctly if all cluster nodes use the new locks consistently, so old
> cluster nodes will become incompatible. Those kinds of changes are
> hard.
> 
> But the additional lock taking would also hurt performance, forever,
> and I'd really like to avoid taking that hit.
> 
> It may not be obvious to everyone, but allowing page faults during
> reads and writes (i.e., while holding dlm locks) can lead to
> distributed deadlocks. We cannot just pretend to be a local
> filesystem.

Ah, gotcha. Same basic issue then, dio -> page fault means you're taking
two DLM locks simulateously, so without lock ordering you get deadlock.

So that means promoting this to the VFS won't be be useful to you
(because the VFS lock will be a local lock, not your DLM lock).

Do you have trylock() and a defined lock ordering you can check for or
glocks (inode number)? Here's the new and expanded commit message, in
case my approach is of interest to you:

commit 32858d0fb90b503c8c39e899ad5155e44639d3b5
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Wed Oct 16 15:03:50 2019 -0400

    sched: Add task_struct->faults_disabled_mapping
    
    There has been a long standing page cache coherence bug with direct IO.
    This provides part of a mechanism to fix it, currently just used by
    bcachefs but potentially worth promoting to the VFS.
    
    Direct IO evicts the range of the pagecache being read or written to.
    
    For reads, we need dirty pages to be written to disk, so that the read
    doesn't return stale data. For writes, we need to evict that range of
    the pagecache so that it's not stale after the write completes.
    
    However, without a locking mechanism to prevent those pages from being
    re-added to the pagecache - by a buffered read or page fault - page
    cache inconsistency is still possible.
    
    This isn't necessarily just an issue for userspace when they're playing
    games; filesystems may hang arbitrary state off the pagecache, and so
    page cache inconsistency may cause real filesystem bugs, depending on
    the filesystem. This is less of an issue for iomap based filesystems,
    but e.g. buffer heads caches disk block mappings (!) and attaches them
    to the pagecache, and bcachefs attaches disk reservations to pagecache
    pages.
    
    This issue has been hard to fix, because
     - we need to add a lock (henceforth calld pagecache_add_lock), which
       would be held for the duration of the direct IO
     - page faults add pages to the page cache, thus need to take the same
       lock
     - dio -> gup -> page fault thus can deadlock
    
    And we cannot enforce a lock ordering with this lock, since userspace
    will be controlling the lock ordering (via the fd and buffer arguments
    to direct IOs), so we need a different method of deadlock avoidance.
    
    We need to tell the page fault handler that we're already holding a
    pagecache_add_lock, and since plumbing it through the entire gup() path
    would be highly impractical this adds a field to task_struct.
    
    Then the full method is:
     - in the dio path, when we take first pagecache_add_lock, note the
       mapping in task_struct
     - in the page fault handler, if faults_disabled_mapping is set, we
       check if it's the same mapping as the one taking a page fault for,
       and if so return an error.
    
       Then we check lock ordering: if there's a lock ordering violation and
       trylock fails, we'll have to cycle the locks and return an error that
       tells the DIO path to retry: faults_disabled_mapping is also used for
       signalling "locks were dropped, please retry".
    
    Also relevant to this patch: mapping->invalidate_lock.
    mapping->invalidate_lock provides most of the required semantics - it's
    used by truncate/fallocate to block pages being added to the pagecache.
    However, since it's a rwsem, direct IOs would need to take the write
    side in order to block page cache adds, and would then be exclusive with
    each other - we'll need a new type of lock to pair with this approach.
    
    Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
    Cc: Jan Kara <jack@suse.cz>
    Cc: Darrick J. Wong <djwong@kernel.org>
    Cc: linux-fsdevel@vger.kernel.org
    Cc: Andreas Grünbacher <andreas.gruenbacher@gmail.com>
