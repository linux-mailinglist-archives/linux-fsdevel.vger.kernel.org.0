Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8BB7B4A35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 00:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbjJAWiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 18:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJAWiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 18:38:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14BC9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 15:38:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565e54cb93aso8697982a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Oct 2023 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696199885; x=1696804685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33/aTyyQaSBPQRJLH+G7VmXLrBqd7SSr9ClqecbFlkw=;
        b=Xmt6Nd3G5V9xTtHlUklxkgrnZ3I37bKyOjAqsTtuPvCiJY72T2ALMgd4n/7dw7/YY5
         nvMFI/As+pYHa1VqMAaOoQs+CRS5Qaz3bgegiI3WsNgGY0FQKuUht3jHRkh5yHhLBkkX
         pBqb9r9A6jo/iPq34U+JcAPN0FxTHZcrDDNqikMxQWj6vAWCtcKrNuVgdEmTz8gAs1fV
         qYDbuoqI6HyhQ/NJ8Xl6jbR+88jNQanEdEWIztAOQZUHfrJIa6U71s/sudu4paDJmEoZ
         Rw9OB83UsquJY0KKAyyZxPOLGvG0UJ6L5xmvzqnStEBUe6T5bJ9e9xshEoypB9ERFYnD
         n0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696199885; x=1696804685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33/aTyyQaSBPQRJLH+G7VmXLrBqd7SSr9ClqecbFlkw=;
        b=LsElDh6KIgzkwfLIGv4uMjkypBluqouXynMCOqMTHPxtEIIYyaD6BpxrO9EWrPz+RD
         Hb/3FJcw9aKYA2bDKs5lSgjItTqwgO9xRwav94cNZ/mKDYB3TJl4Uqj64Px+P9qXeqHK
         w4MHwR9F2yy9X/rW/GRWB+DxJOm5I6oBz6z5h/4qh757QMOAl99f3YyrDm3Hgtkt6VJI
         yUjVpEputnkibxy4UGyRB8Nqe1262UXscmXKGbDYRfgKZ1cpNvkDxSNruK7Hn29E6itW
         gBF8n6Z3uqgJ4erhDRWo1fuszJPplCvJm+ofdgV0itxNGevXOHo/CZnpiFb34qfOLviu
         ngew==
X-Gm-Message-State: AOJu0YzL9c/xng8W80iAGnylQHD/eQwVIIN4EHs+IaZlgWgzZlE4wErU
        +K0BXKWmRrTKdULSBWFREoLH1g==
X-Google-Smtp-Source: AGHT+IEPNDmJlYBnKRJkMqorQBxfTle5K4Et4feITxPrFrpzEg7FRMTgtzw/IqrHe45lWNn+Ew340Q==
X-Received: by 2002:a05:6a00:9a8:b0:690:cae9:714d with SMTP id u40-20020a056a0009a800b00690cae9714dmr9793046pfg.13.1696199884695;
        Sun, 01 Oct 2023 15:38:04 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b006875a366acfsm18446309pff.8.2023.10.01.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 15:38:03 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qn54a-008DIa-22;
        Mon, 02 Oct 2023 09:38:00 +1100
Date:   Mon, 2 Oct 2023 09:38:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Removal of KM_NOFS
Message-ID: <ZRn0yFmKa2JWaTNL@dread.disaster.area>
References: <ZRdNK39vc4TuR7g8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRdNK39vc4TuR7g8@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:18:19PM +0100, Matthew Wilcox wrote:
> I had a long plane ride yesterday, and I started on "Removing GFP_NOFS".
> TLDR: I don't know enough about XFS to do this first step.  There are
> various options and none of them are "obviously" the right thing to do.
> 
> The overall intent is to get rid of the __GFP_FS flag entirely; make
> GFP_NOFS the same as GFP_KERNEL (and a later patch could rename all
> the uses of GFP_NOFS to GFP_KERNEL).  That is, the only way to prevent
> the memory allocator from entering fs reclaim would be by calling
> memalloc_nofs_save().
> 
> XFS already calls memalloc_nofs_save() when starting a transaction.
> This is almost certainly the right thing to do; many things which
> could be freed through fs reclaim would need to start a transaction,
> and we don't want to do a nested transaction.  But it turns out there
> are several places that can't enter fs reclaim for other reasons.
> 
> Having boldly just removed __GFP_FS, I encountered problems (ie
> lockdep got chatty) in XFS and now I don't think I know enough to
> take on the prerequisite project of removing KM_NOFS.  While this is
> obviously _possible_ (simply add calls to memalloc_nofs_save() and
> memalloc_nofs_restore() around calls currently marked as KM_NOFS),
> that's not really how the scoped API is supposed to be used.  Instead,
> one is supposed to improve the understandability of the code by marking
> the sections where, say, a lock is taken as now being unsafe to enter
> fs reclaim because that lock is held.

Here's the problem. We have used KM_NOFS in the past just to shut up
lockdep false positives. In many cases, it is perfectly safe to take
the lock in both task context and in reclaim context and it will not
deadlock because the task context has an active reference on the
inode and so it cannot be locked in both task and reclaim context
at the same time.

i.e. This path:

> That potentially deadlocks against
> 
> -> #0 (&xfs_nondir_ilock_class#3){++++}-{3:3}:
>        __lock_acquire+0x148e/0x26d0
>        lock_acquire+0xb8/0x280
>        down_write_nested+0x3f/0xe0
>        xfs_ilock+0xe3/0x260
>        xfs_icwalk_ag+0x68c/0xa50
>        xfs_icwalk+0x3e/0xa0
>        xfs_reclaim_inodes_nr+0x7c/0xa0
>        xfs_fs_free_cached_objects+0x14/0x20
>        super_cache_scan+0x17d/0x1c0
>        do_shrink_slab+0x16a/0x680
>        shrink_slab+0x52a/0x8a0
>        shrink_node+0x308/0x7a0
>        balance_pgdat+0x28d/0x710

can only be reached when the inode has been removed from the VFS
cache and has been marked as XFS_IRECLAIM and so all new lookups on
that inode will fail until the inode has been RCU freed.

Hence anything that does a GFP_KERNEL allocation whilst holding an
inode lock can have lockdep complain about deadlocks against
locking the inode in the reclaim path.

More recently, __GFP_NOLOCKDEP was added to allow us to annotate
these allocation points that historically have used KM_NOFS to
shut up lockdep false positives. However, no effort has been made to go
back and find all the KM_NOFS sites that should be converted to
__GFP_NOLOCKDEP.

I suspect that most of the remaining uses of KM_NOFS are going to
fall into this category; certainly anything to do with reading
inodes into memory and populating extent lists (most of the KM_NOFS
uses) from non-modifying lookup paths (e.g. open(O_RDONLY), read(),
etc) can trigger this lockdep false positive if they don't use
KM_NOFS or __GFP_NOLOCKDEP...

> We could pop the nofs setting anywhere in this call chain, but _really_
> what we should be doing is calling memalloc_nofs_save() when we take
> the xfs_nondir_ilock_class#3.  But ... there are a lot of places we
> take the ilock, and it's kind of a big deal to add memalloc_nofs_save()
> calls to all of them.  And then I looked at _why_ we take the lock, and
> it's kind of stupid; we're just waiting for other callers to free it.

It's purpose has been to serialising against racing lockless inode
lockups from the inode writeback and inode freeing code (i.e.
unlink) that walks all the inodes in an on-disc cluster. That might
have grabbed the inode between the flush checks and the deletion
from the index. This is old code (dates back to before we had
lockless RCU lookups) but we've reworked how inode clusters do
writeback and how those lockless lookups work a couple of times
since they were introduced.

In general, though, we've treated this relcaim code as "if it ain't
broke, don't fix it", so we haven't removed that final ILOCK because
maybe we've missed some subtle interaction that still requires it. I
think we may have been overly cautious, but I'll need to look at the
lockless lookup code again in a bit more detail before I form a
solid opinion on that..

> ie xfs_reclaim_inode() does:
> 
>        if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
>                 goto out;
> ...
>         xfs_iunlock(ip, XFS_ILOCK_EXCL);
> ...
>         if (!radix_tree_delete(&pag->pag_ici_root,
>                                 XFS_INO_TO_AGINO(ip->i_mount, ino)))
> ...
>         xfs_ilock(ip, XFS_ILOCK_EXCL);
> 
> ie we did the trylock, and it succeeded.  We know we don't have the
> lock in process context.  It feels like we could legitimately use
> xfs_lock_inumorder() to use a different locking class to do this wait.

Unfortunately for us, this used to be only one of many lock points
that caused these lockdep issues - anywhere we took an inode lock in
the reclaim path (i.e. superblock shrinker context) could fire a
lockdep false positive Lockdep just doesn't understand reference
counted life cycle contexts.

Yes, we do have subclasses for inode locking, and we used to even
re-initialise the entire node lockdep map context when the inode
entered reclaim context to avoid false positives. However, with the
scope of all the different places in inode reclaim context that
could lock th einode, the only way to reliably avoid these reclaim
false positives was to sprinkle KM_NOFS around allocation sites
which could be run from both GFP_KERNEL and GFP_NOFS contexts with
an inode locked.

That said, now that most of the inode work needed in memory reclaim
context has been taken completely out of the shrinker context (i.e.
the per-cpu background inodegc workqueues). Hence that final
ILOCK in xfs_reclaim_inode() is likely the only place that remains
where this ILOCK false positive can trigger, so maybe it's a simpler
problem to fix than it once was....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
