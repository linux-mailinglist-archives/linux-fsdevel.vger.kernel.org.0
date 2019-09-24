Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BFBC06B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 04:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404531AbfIXCwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 22:52:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbfIXCwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:52:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCaw3-000329-O6; Tue, 24 Sep 2019 02:52:15 +0000
Date:   Tue, 24 Sep 2019 03:52:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, linux-btrfs@vger.kernel.org,
        "Yan, Zheng" <zyan@redhat.com>, linux-cifs@vger.kernel.org,
        Steve French <sfrench@us.ibm.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190924025215.GA9941@ZenIV.linux.org.uk>
References: <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921140731.GQ1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[btrfs and cifs folks Cc'd]

On Sat, Sep 21, 2019 at 03:07:31PM +0100, Al Viro wrote:

> No "take cursors out of the list" parts yet.

Argh...  The things turned interesting.  The tricky part is
where do we handle switching cursors away from something
that gets moved.

What I hoped for was "just do it in simple_rename()".  Which is
almost OK; there are 3 problematic cases.  One is shmem -
there we have a special ->rename(), which handles things
like RENAME_EXCHANGE et.al.  Fair enough - some of that
might've been moved into simple_rename(), but some (whiteouts)
won't be that easy.  Fair enough - we can make kicking the
cursors outs a helper called by simple_rename() and by that.
Exchange case is going to cause a bit of headache (the
pathological case is when the entries being exchanged are
next to each other in the same directory), but it's not
that bad.

Two other cases, though, might be serious trouble.  Those are
btrfs new_simple_dir() and this in cifs_root_iget():
        if (rc && tcon->pipe) {
                cifs_dbg(FYI, "ipc connection - fake read inode\n");
                spin_lock(&inode->i_lock);
                inode->i_mode |= S_IFDIR;
                set_nlink(inode, 2);
                inode->i_op = &cifs_ipc_inode_ops;
                inode->i_fop = &simple_dir_operations;
                inode->i_uid = cifs_sb->mnt_uid;
                inode->i_gid = cifs_sb->mnt_gid;
                spin_unlock(&inode->i_lock);
	}
The trouble is, it looks like d_splice_alias() from a lookup elsewhere
might find an alias of some subdirectory in those.  And in that case
we'll end up with a child of those (dcache_readdir-using) directories
being ripped out and moved elsewhere.  With no calls of ->rename() in
sight, of course, *AND* with only shared lock on the parent.  The
last part is really nasty.  And not just for hanging cursors off the
dentries they point to - it's a problem for dcache_readdir() itself
even in the mainline and with all the lockless crap reverted.

We pass next->d_name.name to dir_emit() (i.e. potentially to
copy_to_user()).  And we have no warranty that it's not a long
(== separately allocated) name, that will be freed while
copy_to_user() is in progress.  Sure, it'll get an RCU delay
before freeing, but that doesn't help us at all.

I'm not familiar with those areas in btrfs or cifs; could somebody
explain what's going on there and can we indeed end up finding aliases
to those suckers?
