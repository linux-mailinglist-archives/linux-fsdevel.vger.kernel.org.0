Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136613509D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 23:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCaV6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 17:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCaV6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:58:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E529C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 14:58:15 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id o19so113421qvu.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PFMaPm0ZSKNHLe7uWDZGAg0DS2vqUyt9JRPEDLOP+MU=;
        b=gPPf9GodbpejQiqyyWmjZBzoVUjf/cKgxfZTCeRQ7+0QXc9+O5xW0rNZpAYYi1EgUM
         yOHzSMY3N7QY9Q33Jj2ktxeHP/HgxuSCaInqtDmsJkiYjaPpJJtsGC3XeUbJUf4Bs8Ze
         SS/3o2J7tVzgNkj8PBghVrA9AIskldO/j5vbvEblbZCLZxeFMzO7eiIRu5GfTFUK8ROC
         zoiYi5ls7SMKT4SIGYRr4gt86ahg6MBPG1TYFvuzPptUD46itr64I/9cP4C9hhRMmNy0
         uposNkQoouRsSaetCJp/KcgzuPrgxQMHkjpPFvafYEaMw0G1bTxOdo7Xllgl7qK061Ng
         3g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PFMaPm0ZSKNHLe7uWDZGAg0DS2vqUyt9JRPEDLOP+MU=;
        b=QUbaPRLpfwXjlCmtfckX6srt289Gc4csH5qiVlLS0dFMnwBwKOhPR1tViERXCZG9b5
         d80W8/7F+shLuCWLAuk1FFPQiwtZNVleqh67snqDFnzTFck1vvncrmsQ5YHvl82QB7OR
         eIECEDZAHwUfdIERGo6sm7jk3Hd/Mylsu5sbXKLGtXM/REBLNdKKwGow2ADv/Wm90abP
         kW0LQud6cuIB+1fmMaXFox5BEOA0sZ/NYM378IHtYfnF6+laafEFo9wNk9kxGrVdak+J
         UCjKK4Dwp4K6t0X3Xz66Q5ZKiq/mAFbcbsAVOfht9nmT1xY09ZQIAEHGtTMqv38Iezkw
         NLoA==
X-Gm-Message-State: AOAM530sAV7mIBIzG5LgXTfO9YYvJknBIEVCivJ+8QHCegt0O4+QaLHU
        EqJTJ8oUqZPBU5RMy9cI0+4EtFEiYfwPqQ==
X-Google-Smtp-Source: ABdhPJyMeWQk1SNAy+WGG9FZXOQlYhXupuR6DDyh4pyG64dL5jvkK68dDxCXdh/+SxT35eoCgqrhbA==
X-Received: by 2002:ad4:4b0a:: with SMTP id r10mr5231949qvw.31.1617227894438;
        Wed, 31 Mar 2021 14:58:14 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s13sm2487446qkg.17.2021.03.31.14.58.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 31 Mar 2021 14:58:14 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:58:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <20210331024913.GS351017@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Mar 2021, Matthew Wilcox wrote:
> On Tue, Mar 30, 2021 at 06:30:22PM -0700, Hugh Dickins wrote:
> > Running my usual tmpfs kernel builds swapping load, on Sunday's rc4-mm1
> > mmotm (I never got to try rc3-mm1 but presume it behaved the same way),
> > I hit clear_inode()'s BUG_ON(!mapping_empty(&inode->i_data)); on two
> > machines, within an hour or few, repeatably though not to order.
> > 
> > The stack backtrace has always been clear_inode < ext4_clear_inode <
> > ext4_evict_inode < evict < dispose_list < prune_icache_sb <
> > super_cache_scan < do_shrink_slab < shrink_slab_memcg < shrink_slab <
> > shrink_node_memgs < shrink_node < balance_pgdat < kswapd.
> > 
> > ext4 is the disk filesystem I read the source to build from, and also
> > the filesystem I use on a loop device on a tmpfs file: I have not tried
> > with other filesystems, nor checked whether perhaps it happens always on
> > the loop one or always on the disk one.  I have not seen it happen with
> > tmpfs - probably because its inodes cannot be evicted by the shrinker
> > anyway; I have not seen it happen when "rm -rf" evicts ext4 or tmpfs
> > inodes (but suspect that may be down to timing, or less pressure).
> > I doubt it's a matter of filesystem: think it's an XArray thing.
> > 
> > Whenever I've looked at the XArray nodes involved, the root node
> > (shift 6) contained one or three (adjacent) pointers to empty shift
> > 0 nodes, which each had offset and parent and array correctly set.
> > Is there some way in which empty nodes can get left behind, and so
> > fail eviction's mapping_empty() check?
> 
> There isn't _supposed_ to be.  The XArray is supposed to delete nodes
> whenever the ->count reaches zero.  It might give me a clue if you could
> share a dump of the tree, if you still have that handy.

Very useful suggestion: the xa_dump() may not give you more of a clue,
but just running again last night to gather that info has revealed more.

> 
> > I did wonder whether some might get left behind if xas_alloc() fails
> > (though probably the tree here is too shallow to show that).  Printks
> > showed that occasionally xas_alloc() did fail while testing (maybe at
> > memcg limit), but there was no correlation with the BUG_ONs.
> 
> This is a problem inherited from the radix tree, and I really want to
> justify fixing it ... I think I may have enough infrastructure in place
> to do it now (as part of the xas_split() commit we can now allocate
> multiple xa_nodes in xas->xa_alloc).  But you're right; if we allocated
> all the way down to an order-0 node, then this isn't the bug.
> 
> Were you using the ALLOW_ERROR_INJECTION feature on
> __add_to_page_cache_locked()?  I haven't looked into how that works,
> and maybe that could leave us in an inconsistent state.

No, no error injection: not something I've ever looked at either.

> 
> > I did wonder whether this is a long-standing issue, which your new
> > BUG_ON is the first to detect: so tried 5.12-rc5 clear_inode() with
> > a BUG_ON(!xa_empty(&inode->i_data.i_pages)) after its nrpages and
> > nrexceptional BUG_ONs.  The result there surprised me: I expected
> > it to behave the same way, but it hits that BUG_ON in a minute or
> > so, instead of an hour or so.  Was there a fix you made somewhere,
> > to avoid the BUG_ON(!mapping_empty) most of the time? but needs
> > more work. I looked around a little, but didn't find any.
> 
> I didn't make a fix for this issue; indeed I haven't observed it myself.

That was interesting to me last night, but not so interesting now
we have more info (below).

> It seems like cgroups are a good way to induce allocation failures, so
> I should play around with that a bit.  The userspace test-suite has a
> relatively malicious allocator that will fail every allocation not marked
> as GFP_KERNEL, so it always exercises the fallback path for GFP_NOWAIT,
> but then it will always succeed eventually.
> 
> > I had hoped to work this out myself, and save us both some writing:
> > but better hand over to you, in the hope that you'll quickly guess
> > what's up, then I can try patches. I do like the no-nrexceptionals
> > series, but there's something still to be fixed.
> 
> Agreed.  It seems like it's unmasking a bug that already existed, so
> it's not an argument for dropping the series, but we should fix the bug
> so we don't crash people's machines.
> 
> Arguably, the condition being checked for is not serious enough for a
> BUG_ON.  A WARN_ON, yes, and dump the tree for later perusal, but it's
> just a memory leak, and not (I think?) likely to lead to later memory
> corruption.  The nodes don't contain any pages, so there's nothing to
> point to the mapping.

Good suggestion, yes, use a WARN_ON instead of a BUG_ON.  And even when
this immediate bug is fixed, will still be necessary for so long as the
radix-tree -ENOMEM might leave intermediate nodes behind.  (An easy way
to fix that might be just to add a cleanup pass when !mapping_empty().)

I followed your suggestion and used WARN_ON instead of BUG_ON in last
night's runs (when you make that change, do remember to do what I
forgot at first - reset i_pages to NULL - otherwise anyone who inherits
that struct inode thereafter inherits these nodes - I got lots of
warnings on tiny files!).

And also printed out s_dev i_ino i_size: in the hope that they might
shed some more light.  Hope fulfilled: *every* instance, on every
machine, has been /usr/bin/ld.bfd.

My kernels are built with CONFIG_READ_ONLY_THP_FOR_FS=y.  And checking
old /var/log/messages from last summer, when I was first playing around
with that, I see the temporary debug messages I had added for it:
"collapse_file(/usr/bin/ld.bfd, 0)" meaning that it was making a THP
at offset 0.  (Other executables too, notably cc1; but maybe ld.bfd
is the one most likely to get evicted.)

I suspect there's a bug in the XArray handling in collapse_file(),
which sometimes leaves empty nodes behind.

Here's the xa_dump() info from one of the machines:

[  348.026010] xarray: ffff88800f01eb98 head ffff88800855f2a2 flags 21 marks 0 0 0
[  348.028101] 0-4095: node ffff88800855f2a0 max 0 parent 0000000000000000 shift 6 count 1 values 0 array ffff88800f01eb98 list ffff88800855f2b8 ffff88800855f2b8 marks 0 0 0
[  348.030335] 960-1023: node ffff888023dbd890 offset 15 parent ffff88800855f2a0 shift 0 count 0 values 0 array ffff88800f01eb98 list ffff888023dbd8a8 ffff888023dbd8a8 marks 0 0 0
[  348.032736] s_dev 259:5 i_ino 935588 i_size 9112288

[ 4521.543662] xarray: ffff888003e8f898 head ffff88801256963a flags 21 marks 0 0 0
[ 4521.545683] 0-4095: node ffff888012569638 max 0 parent 0000000000000000 shift 6 count 1 values 0 array ffff888003e8f898 list ffff888012569650 ffff888012569650 marks 0 0 0
[ 4521.547889] 384-447: node ffff8880215b2088 offset 6 parent ffff888012569638 shift 0 count 0 values 0 array ffff888003e8f898 list ffff8880215b20a0 ffff8880215b20a0 marks 0 0 0
[ 4521.550151] s_dev 259:5 i_ino 935588 i_size 9112288

[17526.162821] xarray: ffff88800f09a998 head ffff88801610808a flags 21 marks 0 0 0
[17526.163936] 0-4095: node ffff888016108088 max 0 parent 0000000000000000 shift 6 count 2 values 0 array ffff88800f09a998 list ffff8880161080a0 ffff8880161080a0 marks 0 0 0
[17526.165176] 384-447: node ffff888022a5fc00 offset 6 parent ffff888016108088 shift 0 count 0 values 0 array ffff88800f09a998 list ffff888022a5fc18 ffff888022a5fc18 marks 0 0 0
[17526.167012] 960-1023: node ffff888008656188 offset 15 parent ffff888016108088 shift 0 count 0 values 0 array ffff88800f09a998 list ffff8880086561a0 ffff8880086561a0 marks 0 0 0
[17526.168225] s_dev 259:5 i_ino 935588 i_size 9112288

[27201.416553] xarray: ffff888026638a98 head ffff8880241fd14a flags 21 marks 0 0 0
[27201.418724] 0-4095: node ffff8880241fd148 max 0 parent 0000000000000000 shift 6 count 1 values 0 array ffff888026638a98 list ffff8880241fd160 ffff8880241fd160 marks 0 0 0
[27201.421067] 384-447: node ffff888026471aa8 offset 6 parent ffff8880241fd148 shift 0 count 0 values 0 array ffff888026638a98 list ffff888026471ac0 ffff888026471ac0 marks 0 0 0
[27201.423353] s_dev 259:5 i_ino 935588 i_size 9112288

[28189.092410] xarray: ffff888022468858 head ffff888016358262 flags 21 marks 0 0 0
[28189.094548] 0-4095: node ffff888016358260 max 0 parent 0000000000000000 shift 6 count 1 values 0 array ffff888022468858 list ffff888016358278 ffff888016358278 marks 0 0 0
[28189.096821] 384-447: node ffff8880124455f8 offset 6 parent ffff888016358260 shift 0 count 0 values 0 array ffff888022468858 list ffff888012445610 ffff888012445610 marks 0 0 0
[28189.099217] s_dev 259:5 i_ino 935588 i_size 9112288

935588 -rwxr-xr-x 1 root root 9112288 Dec  7 14:28 /usr/bin/ld.bfd

Hugh
