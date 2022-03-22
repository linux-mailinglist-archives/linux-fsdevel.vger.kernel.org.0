Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C84E492A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiCVWap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiCVWan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:30:43 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3A126C5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 15:29:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-150-27.pa.vic.optusnet.com.au [49.186.150.27])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 94AD3533BF9;
        Wed, 23 Mar 2022 09:29:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nWn04-008gHP-G8; Wed, 23 Mar 2022 09:29:12 +1100
Date:   Wed, 23 Mar 2022 09:29:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <20220322222912.GF1609613@dread.disaster.area>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <Yjo0lA3DiX1fFTue@casper.infradead.org>
 <Yjo9YrxU5SpydQKy@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yjo9YrxU5SpydQKy@carbon.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=623a4dba
        a=sPqof0Mm7fxWrhYUF33ZaQ==:117 a=sPqof0Mm7fxWrhYUF33ZaQ==:17
        a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=Mo5KHSmeIGZkFYpUIgAA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:19:30PM -0700, Roman Gushchin wrote:
> On Tue, Mar 22, 2022 at 08:41:56PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > > I’d be happy to join this discussion. And in my opinion it’s going
> > > beyond negative dentries: there are other types of objects which tend
> > > to grow beyond any reasonable limits if there is no memory pressure.
> > >
> > > A perfect example when it happens is when a machine is almost idle
> > > for some period of time. Periodically running processes creating
> > > various kernel objects (mostly vfs cache) which over time are filling
> > > significant portions of the total memory. And when the need for memory
> > > arises, we realize that the memory is heavily fragmented and it’s
> > > costly to reclaim it back.
> > 
> > When you say "vfs cache", do you mean page cache, inode cache, or
> > something else?
> 
> Mostly inodes and dentries, but also in theory some fs-specific objects
> (e.g. xfs implements nr_cached_objects/free_cached_objects callbacks).

Those aren't independent shrinkers - they are part of the superblock
shrinker.  XFS just uses these for background management of the VFS
inode cache footprint - vfs inodes live a bit longer than
->destroy_inode in XFS - so these callouts from the superblock
shrinker are really just part of the existing VFS inode cache
management.

> Also dentries, for example, can have attached kmalloc'ed areas if the
> length of the file's name is larger than x. And probably there are more
> examples of indirectly pinned objects.

The xfs buffer cache has slab allocated handles that can pin up to
64kB of pages each. The buffer cache can quickly grow to hold tens
of gigabytes of memory when you have filesystems with hundreds of
gigabytes of metadata in them (which are not that uncommon). It's
also not uncommon for the XFS buffer cache to consume more memory
than the VFS dentry and inode caches combined.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
