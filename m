Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E435D4C22A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 04:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiBXDvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 22:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBXDvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:51:05 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F38720D82F;
        Wed, 23 Feb 2022 19:50:35 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21O3o9DG002766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 22:50:10 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2BFEF15C0036; Wed, 23 Feb 2022 22:50:09 -0500 (EST)
Date:   Wed, 23 Feb 2022 22:50:09 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <YhcAcfY1pZTl3sId@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
 <Yg9QGm2Rygrv+lMj@kroah.com>
 <YhbE2nocBMtLc27C@mit.edu>
 <20220224014842.GM59715@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224014842.GM59715@dread.disaster.area>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:48:42PM +1100, Dave Chinner wrote:
> > Fair enough; on the other hand, we could also view this as making ext4
> > more robust against buggy code in other subsystems, and while other
> > file systems may be losing user data if they are actually trying to do
> > remote memory access to file-backed memory, apparently other file
> > systems aren't noticing and so they're not crashing.
> 
> Oh, we've noticed them, no question about that.  We've got bug
> reports going back years for systems being crashed, triggering BUGs
> and/or corrupting data on both XFS and ext4 filesystems due to users
> trying to run RDMA applications with file backed pages.

Is this issue causing XFS to crash?  I didn't know that.

I tried the Syzbot reproducer with XFS mounted, and it didn't trigger
any crashes.  I'm sure data was getting corrupted, but I figured I
should bring ext4 to the XFS level of "at least we're not reliably
killing the kernel".

On ext4, an unprivileged process can use process_vm_writev(2) to crash
the system.  I don't know how quickly we can get a fix into mm/gup.c,
but if some other kernel path tries calling set_page_dirty() on a
file-backed page without first asking permission from the file system,
it seems to be nice if the file system doesn't BUG() --- as near as I
can tell, xfs isn't crashing in this case, but ext4 is.

					- Ted
