Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C961B9E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393452AbfIUOHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Sep 2019 10:07:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54996 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393406AbfIUOHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Sep 2019 10:07:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBg2t-0007XS-Oi; Sat, 21 Sep 2019 14:07:31 +0000
Date:   Sat, 21 Sep 2019 15:07:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190921140731.GQ1131@ZenIV.linux.org.uk>
References: <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 15, 2019 at 10:58:50AM -0700, Linus Torvalds wrote:
> On Sun, Sep 15, 2019 at 9:02 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Could be done, AFAICS.  I'm not even sure we need a flag per se - we
> > have two cases when the damn thing is not in the list and "before
> > everything" case doesn't really need to be distinguished from post-EOF
> > one.
> 
> Agreed, it looks like we could just look at f_pos and use that
> (together with whether we have a cursor or not) as the flag:
> 
>  - no cursor: f_pos < 2 means beginning, otherwise EOF
> 
>  - otherwise: cursor points to position

FWIW, #next.dcache has the straight conversion to hlist.  It definitely
wants at least nfsd, er... misconception dealt with, though: list_head
or hlist, this
static void nfsdfs_remove_files(struct dentry *root)
{
        struct dentry *dentry;
        struct hlist_node *n;

        hlist_for_each_entry_safe(dentry, n, &root->d_children, d_sibling) {
                if (!simple_positive(dentry)) {
                        WARN_ON_ONCE(1); /* I think this can't happen? */
                        continue;
                }
                nfsdfs_remove_file(d_inode(root), dentry);
        }
}
is wrong, for obvious reasons (have the victim directory opened before that
gets called and watch the fireworks)...

No "take cursors out of the list" parts yet.
