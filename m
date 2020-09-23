Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390AC2754B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWJpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 05:45:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:42618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIWJpA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 05:45:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EFD8BACB8;
        Wed, 23 Sep 2020 09:45:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A3561E12E3; Wed, 23 Sep 2020 11:44:57 +0200 (CEST)
Date:   Wed, 23 Sep 2020 11:44:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: A bug in ext4 with big directories (was: NVFS XFS metadata)
Message-ID: <20200923094457.GB6719@quack2.suse.cz>
References: <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
 <20200922050314.GB12096@dread.disaster.area>
 <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
 <20200923024528.GD12096@dread.disaster.area>
 <alpine.LRH.2.02.2009230459450.1800@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009230459450.1800@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On Wed 23-09-20 05:20:55, Mikulas Patocka wrote:
> There seems to be a bug in ext4 - when I create very large directory, ext4 
> fails with -ENOSPC despite the fact that there is plenty of free space and 
> free inodes on the filesystem.
> 
> How to reproduce:
> download the program dir-test: 
> http://people.redhat.com/~mpatocka/benchmarks/dir-test.c
> 
> # modprobe brd rd_size=67108864
> # mkfs.ext4 /dev/ram0
> # mount -t ext4 /dev/ram0 /mnt/test
> # dir-test /mnt/test/ 8000000 8000000
> deleting: 7999000
> 2540000
> file 2515327 can't be created: No space left on device
> # df /mnt/test
> /dev/ram0        65531436 633752 61525860   2% /mnt/test
> # df -i /mnt/test
> /dev/ram0        4194304 1881547 2312757   45% /mnt/test

Yeah, you likely run out of space in ext4 directory h-tree. You can enable
higher depth h-trees with large_dir feature (mkfs.ext4 -O large_dir). Does
that help?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
