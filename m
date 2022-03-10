Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C134D3EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 02:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiCJB3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 20:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiCJB3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:29:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2CE1B50
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Jbmb4u6VqXK4vx9oK1bN9dpxNcP4pUOwtuCiFyxbZc=; b=YAxgyaTLADJKLSHclfrEToEv3Y
        Y/BkLVackaXmnQQDmHfvF6ocKztxcPmcil4myPfRN3+amfPB5yizBwlJxD9muT+SL/JyqIVASM1oL
        NnZajEQDTf1Oh9rgDr6fsOg/8gvwCUJrpSmqwoMHd7ZSd/97i0LeZPifAD+fKOenom5Q6TmY26v2O
        XjV4tqUfa4NF4fhvT/OQxRDtEepl01VwVQ5+IO+TQC/cvxoOEQ9jJgb2oh3N2XkHY+AXNS3ENyN95
        6Am0wmPGe9XNSVfjSZaWJ/UnzRs8BPyKGuEbr7aEWBKi7du/U7s3eFwlsLUEjRZnXe5eNA9qx6EQh
        Lor2+vbA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS7bQ-00AyA4-EU; Thu, 10 Mar 2022 01:28:28 +0000
Date:   Wed, 9 Mar 2022 17:28:28 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YilUPAGQBPwI0V3n@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 04:19:21PM -0500, Josef Bacik wrote:
> On Wed, Mar 09, 2022 at 11:00:49AM -0800, Luis Chamberlain wrote:
> > On Wed, Mar 09, 2022 at 01:49:18PM -0500, Josef Bacik wrote:
> > > On Wed, Mar 09, 2022 at 10:41:53AM -0800, Luis Chamberlain wrote:
> > > > On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> > > > > One of my team members has been working with Darrick to set up a set
> > > > > of xfs configs[1] recommended by Darrick, and she's stood up an
> > > > > automated test spinner using gce-xfstests which can watch a git branch
> > > > > and automatically kick off a set of tests whenever it is updated.
> > > > 
> > > > I think its important to note, as we would all know, that contrary to
> > > > most other subsystems, in so far as blktests and fstests is concerned,
> > > > simply passing a test once does not mean there is no issue given that
> > > > some test can fail with a failure rate of 1/1,000 for instance.
> > > > 
> > > 
> > > FWIW we (the btrfs team) have been running nightly runs of fstests against our
> > > devel branch for over a year and tracking the results.
> > 
> > That's wonderful, what is your steady state goal? And do you have your
> > configurations used public and also your baseline somehwere? I think
> > this later aspect could be very useful to everyone.
> > 
> 
> Yeah I post the results to http://toxicpanda.com, you can see the results from
> the runs, and http://toxicpanda.com/performance/ has the nightly performance
> numbers and graphs as well.

That's great!

But although this runs nightly, it seems this runs fstest *once* to
ensure if there are no regressions. Is that right?

> This was all put together to build into something a little more polished, but
> clearly priorities being what they are this is as far as we've taken it.  For
> configuration you can see my virt-scripts here
> https://github.com/josefbacik/virt-scripts which are what I use to generate the
> VM's to run xfstests in.
> 
> The kernel config I use is in there, I use a variety of btrfs mount options and
> mkfs options, not sure how interesting those are for people outside of btrfs.

Extremely useful.

> Right now I have a box with ZNS drives waiting for me to set this up on so that
> we can also be testing btrfs zoned support nightly, as well as my 3rd
> RaspberryPi that I'm hoping doesn't blow up this time.

Great to hear you will be covering ZNS as well.

> I have another virt setup that uses btrfs snapshots to create a one off chroot
> to run smoke tests for my development using virtme-run.  I want to replace the
> libvirtd vms with virtme-run, however I've got about a 2x performance difference
> between virtme-run and libvirtd that I'm trying to figure out, so right now all
> the nightly test VM's are using libvirtd.
> 
> Long, long term the plan is to replace my janky home setup with AWS VM's that
> can be fired from GitHub actions whenever we push branches, that way individual
> developers can get results for their patches before they're merged, and we don't
> have to rely on my terrible python+html for test results.

If you do move to AWS just keep in mind using loopback drives +
truncated files *finds* more issues than not. So when I used AWS
I got two spare nvme drives and used one to stuff the truncated
files there.

> > Yes, everyone's test setup can be different, but this is why I went with
> > a loopback/truncated file setup, it does find more issues and so far
> > these have all been real.
> > 
> > It kind of begs the question if we should adopt something like kconfig
> > on fstests to help enable a few test configs we can agree on. Thoughts?
> > 
> 
> For us (and I imagine other fs'es) the kconfigs are not interesting, it's the
> combo of different file system features that can be toggled on and off via mkfs
> as well as different mount options.  For example I run all the different mkfs
> features through normal mount options, and then again with compression turned
> on.  Thanks,

So what I mean by kconfig is not the Linux kernel kconfig, but rather
the kdevops kconfig options. kdevops essentially has a kconfig symbol
per mkfs-param-mount config we test. And it runs *ones* guest per each
of these. For example:

config FSTESTS_XFS_SECTION_REFLINK_1024
	bool "Enable testing section: xfs_reflink_1024"
	default y
	help
	  This will create a host to test the baseline of fstests using the
	  following configuration which enables reflink using 1024 byte block
	  size.

	[xfs_reflink]
	MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1,'
	FSTYP=xfs

The other ones can be found here for XFS:

https://github.com/mcgrof/kdevops/blob/master/workflows/fstests/xfs/Kconfig

So indeed, exactly what you mean. What I'm getting at is that it would
be good to construct these with the community. So it would beg the
question if we should embrace for instance kconfig language to be
able to configure fstests (yes I know it is xfstests but I think loose
new people who tend to assume that xfstest is only for XFS, so I only
always call it fstests).

  Luis
