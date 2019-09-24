Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07CABCA9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfIXOvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 10:51:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50448 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfIXOvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:51:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCm9g-0002aV-7b; Tue, 24 Sep 2019 14:51:04 +0000
Date:   Tue, 24 Sep 2019 15:51:04 +0100
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
Message-ID: <20190924145104.GE26530@ZenIV.linux.org.uk>
References: <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk>
 <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk>
 <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk>
 <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk>
 <20190924025215.GA9941@ZenIV.linux.org.uk>
 <20190924133025.jeh7ond2svm3lsub@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924133025.jeh7ond2svm3lsub@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 09:30:26AM -0400, Josef Bacik wrote:

> > We pass next->d_name.name to dir_emit() (i.e. potentially to
> > copy_to_user()).  And we have no warranty that it's not a long
> > (== separately allocated) name, that will be freed while
> > copy_to_user() is in progress.  Sure, it'll get an RCU delay
> > before freeing, but that doesn't help us at all.
> > 
> > I'm not familiar with those areas in btrfs or cifs; could somebody
> > explain what's going on there and can we indeed end up finding aliases
> > to those suckers?
> 
> We can't for the btrfs case.  This is used for the case where we have a link to
> a subvolume but the root has disappeared already, so we add in that dummy inode.
> We completely drop the dcache from that root downards when we drop the
> subvolume, so we're not going to find aliases underneath those things.  Is that
> what you're asking?  Thanks,

Umm...  Completely drop, you say?  What happens if something had been opened
in there at that time?

Could you give a bit more background?  How much of that subvolume remains
and what does btrfs_lookup() have to work with?
