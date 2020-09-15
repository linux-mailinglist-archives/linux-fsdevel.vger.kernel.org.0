Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5503826A223
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIOJ1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 05:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:40574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIOJ1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BE5DAC24;
        Tue, 15 Sep 2020 09:27:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4AD6B1E12EF; Tue, 15 Sep 2020 11:27:19 +0200 (CEST)
Date:   Tue, 15 Sep 2020 11:27:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200915092719.GI4863@quack2.suse.cz>
References: <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <20200913004057.GR12096@dread.disaster.area>
 <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
 <20200913234503.GS12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913234503.GS12096@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-09-20 09:45:03, Dave Chinner wrote:
> I have my doubts that complex page cache manipulation operations
> like ->migrate_page that rely exclusively on page and internal mm
> serialisation are really safe against ->fallocate based invalidation
> races.  I think they probably also need to be wrapped in the
> MMAPLOCK, but I don't understand all the locking and constraints
> that ->migrate_page has and there's been no evidence yet that it's a
> problem so I've kinda left that alone. I suspect that "no evidence"
> thing comes from "filesystem people are largely unable to induce
> page migrations in regression testing" so it has pretty much zero
> test coverage....

Last time I've looked, ->migrate_page seemed safe to me. Page migration
happens under page lock so truncate_inode_pages_range() will block until
page migration is done (and this covers currently pretty much anything
fallocate related). And once truncate_inode_pages_range() is done,
there are no pages to migrate :) (plus migration code checks page->mapping
!= NULL after locking the page).

But I agree testing would be nice. When I was chasing a data corruption in
block device page cache caused by page migration, I was using thpscale [1]
or thpfioscale [2] benchmarks from mmtests which create anon hugepage
mapping and bang it from several threads thus making kernel try to compact
pages (and thus migrate other pages that block compaction) really hard. And
with it in parallel I was running the filesystem stress that seemed to
cause issues for the customer... I guess something like fsx & fsstress runs
with this THP stress test in parallel might be decent fstests to have.

								Honza

[1] https://github.com/gormanm/mmtests/blob/master/shellpack_src/src/thpscale/thpscale.c
[2] https://github.com/gormanm/mmtests/blob/master/shellpack_src/src/thpfioscale/thpfioscale.c

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
