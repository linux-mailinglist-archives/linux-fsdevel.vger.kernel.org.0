Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590EE4CEEE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 01:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiCGAPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 19:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiCGAPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 19:15:18 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFE9B50E36;
        Sun,  6 Mar 2022 16:14:24 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A6FE510E1656;
        Mon,  7 Mar 2022 11:14:21 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nR112-002Ofo-8x; Mon, 07 Mar 2022 11:14:20 +1100
Date:   Mon, 7 Mar 2022 11:14:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Generic per-sb io stats
Message-ID: <20220307001420.GQ3927073@dread.disaster.area>
References: <20220305160424.1040102-1-amir73il@gmail.com>
 <YiQ2Gi8umX9LQBWr@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiQ2Gi8umX9LQBWr@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62254e5f
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8
        a=awRMrf5kypXfiWRIGAcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 05, 2022 at 11:18:34PM -0500, Theodore Ts'o wrote:
> On Sat, Mar 05, 2022 at 06:04:15PM +0200, Amir Goldstein wrote:
> > 
> > Dave Chinner asked why the io stats should not be enabled for all
> > filesystems.  That change seems too bold for me so instead, I included
> > an extra patch to auto-enable per-sb io stats for blockdev filesystems.
> 
> Perhaps something to consider is allowing users to be able to enable
> or disable I/O stats on per mount basis?
> 
> Consider if a potential future user of this feature has servers with
> one or two 256-core AMD Epyc chip, and suppose that they have a
> several thousand iSCSI mounted file systems containing various
> software packages for use by Kubernetes jobs.  (Or even several
> thousand mounted overlay file systems.....)
> 
> The size of the percpu counter is going to be *big* on a large CPU
> count machine, and the iostats structure has 5 of these per-cpu
> counters, so if you have one for every single mounted file system,
> even if the CPU slowdown isn't significant, the non-swappable kernel
> memory overhead might be quite large.

A percpu counter on a 256 core machine is ~1kB. Adding 5kB to the
struct superblock isn't a bit deal for a machine of this size, even
if you have thousands of superblocks - we're talking a few
*megabytes* of extra memory in a machine that would typically have
hundreds of GB of RAM. Seriously, the memory overhead of the per-cpu
counters is noise compared to the memory footprint of, say, the
stacks needing to be allocated for every background worker thread
the filesystem needs.

Yeah, I know, we have ~175 per-cpu stats counters per XFS superblock
(we already cover the 4 counters Amir is proposing to add as generic
SB counters), and we have half a dozen dedicated worker threads per
mount. Yet systems still function just fine when there are thousands
of XFS filesystems and thousands of CPUs.

Seriously, a small handful of per-cpu counters that capture
information for all superblocks is not a big deal. Small systems
will have relatively litte overhead, large systems have the memory
to handle it.

> So maybe a VFS-level mount option, say, "iostats" and "noiostats", and
> some kind of global option indicating whether the default should be
> iostats being enabled or disabled?  Bonus points if iostats can be
> enabled or disabled after the initial mount via remount operation.

Can we please just avoid mount options for stuff like this? It'll
just never get tested unless it defaults to on, and then almost
no-one will ever turn it off because why would you bother tweaking
something that has not noticable impact but can give useful insights
the workload that is running?

I don't care one way or another here because this is essentially
duplicating something we've had in XFS for 20+ years. What I want to
avoid is blowing out the test matrix even further. Adding optional
features has a cost in terms of testing time, so if it's a feature
that is only rarely going to be turned on then we shouldn't add it
at all. If it's only rearely going to be turned off, OTOH, then we
should just make it ubiquitous and available for everything so it's
always tested.

Hence, AFAICT, the only real option for yes/no support is the
Kconfig option. If the kernel builder turns it on, it is on for
everything, otherwise it is off for everything.

> I could imagine some people only being interested to enable iostats on
> certain file systems, or certain classes of block devices --- so they
> might want it enabled on some ext4 file systems which are attached to
> physical devices, but not on the N thousand iSCSI or nbd mounts that
> are also happen to be using ext4.

That seems ... fairly contrived. Block device IO stats are not turned
on and off based on the block device type - they are generic.
Network device stats are not turned on and off based on teh network
device - they are generic. Why should per-filesystem IO stats be
special and different to everything else?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
