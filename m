Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3DBCC82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfIXQdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 12:33:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52086 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfIXQdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:33:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCnkL-0005pD-Ec; Tue, 24 Sep 2019 16:33:01 +0000
Date:   Tue, 24 Sep 2019 17:33:01 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>, linux-btrfs@vger.kernel.org,
        "Yan, Zheng" <zyan@redhat.com>, linux-cifs@vger.kernel.org,
        Steve French <sfrench@us.ibm.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190924163301.GG26530@ZenIV.linux.org.uk>
References: <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <20190924025215.GA9941@ZenIV.linux.org.uk>
 <20190924133025.jeh7ond2svm3lsub@macbook-pro-91.dhcp.thefacebook.com>
 <20190924145104.GE26530@ZenIV.linux.org.uk>
 <20190924150144.6yqukmzwc3xlnfql@macbook-pro-91.dhcp.thefacebook.com>
 <20190924151107.GF26530@ZenIV.linux.org.uk>
 <20190924152627.kmbvxb4elpxfoybf@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924152627.kmbvxb4elpxfoybf@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:26:28AM -0400, Josef Bacik wrote:
> On Tue, Sep 24, 2019 at 04:11:07PM +0100, Al Viro wrote:
> > On Tue, Sep 24, 2019 at 11:01:45AM -0400, Josef Bacik wrote:
> > 
> > > Sorry I mis-read the code a little bit.  This is purely for the subvolume link
> > > directories.  We haven't wandered down into this directory yet.  If the
> > > subvolume is being deleted and we still have the fake directory entry for it
> > > then we just populate it with this dummy inode and then we can't lookup anything
> > > underneath it.  Thanks,
> > 
> > Umm...  OK, I guess my question would be better stated a bit differently: we
> > have a directory inode, with btrfs_lookup() for lookups in it *and* with
> > dcache_readdir() called when you try to do getdents(2) on that thing.
> > How does that work?
> 
> Sorry I hadn't read through the context.  We won't end up with things under this
> directory.  The lookup will try to look up into the subvolume, see that it's
> empty, and just return nothing.  There should never be any entries that end up
> under this dummy entry.  Thanks,

Er...  Then why not use simple_lookup() in there?  Confused...
