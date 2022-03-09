Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F044D254D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 02:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiCIBF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiCIBFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:05:15 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFB0E134DEE
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 16:43:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9BC5D10E24D0;
        Wed,  9 Mar 2022 11:43:04 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nRkPv-003C7b-I4; Wed, 09 Mar 2022 11:43:03 +1100
Date:   Wed, 9 Mar 2022 11:43:03 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20220309004303.GW3927073@dread.disaster.area>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YieG8rZkgnfwygyu@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6227f819
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=NEAV23lmAAAA:8 a=7-415B0cAAAA:8
        a=G0-Vs6eqYytFQsxIBV8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> On Tue, Mar 08, 2022 at 11:08:48AM +0100, Greg KH wrote:
> > > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> > > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
> > 
> > That's up to the xfs maintainers to discuss.
> > 
> > > Which makes me wonder: how do the distro kernel maintainers keep up
> > > with xfs fixes?
> > 
> > Who knows, ask the distro maintainers that use xfs.  What do they do?
> 
> This is something which is being worked, so I'm not sure we'll need to
> discuss the specifics of the xfs stable backports at LSF/MM.  I'm
> hopeful that by May, we'll have come to some kind of resolution of
> that topic.
> 
> One of my team members has been working with Darrick to set up a set
> of xfs configs[1] recommended by Darrick, and she's stood up an
> automated test spinner using gce-xfstests which can watch a git branch
> and automatically kick off a set of tests whenever it is updated.
> Sasha has also provided her with a copy of his scripts so we can do
> automated cherry picks of commits with Fixes tags.  So the idea is
> that we can, hopefully in a mostly completely automated fashion, do
> the backports and do a full set of regression tests on those stable
> backports of XFS bug fixes.
> 
> [1] https://github.com/tytso/xfstests-bld/tree/master/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg
> 
> Next steps are to get a first tranche of cherry-picks for 5.10 and
> probably 5.15, and use the test spinner to demonstrate that they don't
> have any test regressions (if there are, we'll drop those commits).
> Once we have a first set of proposed stable backports for XFS, we'll
> present them to the XFS development community for their input.  There
> are a couple of things that could happen at this point, depending on
> what the XFS community is willing to accept.
> 
> The first is that we'll send these tested stable patches directly to
> Greg and Sasha for inclusion in the LTS releases, with the linux-xfs
> list cc'ed so they know what's going into the stable trees.
> 
> The second is that we send them only to the linux-xfs list, and they
> have to do whatever approval they want before they go into the
> upstream stable trees.

This effectively what we do with RHEL backports - the set of
proposed changes have to be backported cleanly and tested by the
proposer and it doesn't get merged until it has been reviewed.

This is pretty much what we've been asking for from the LTS kernel
process for a few years now (and what Luis did for a while), so I
see no problems with someone actually taking long term
responsibility for driving and maintaining an LTS backport process
like this.

> And the third option, if they aren't willing to take our work or they
> choose to require manual approvals and those approvals are taking too
> long, is that we'll feed the commits into Google's Container-Optimized
> OS (COS) kernel, so that our customers can get those fixes and so we
> can support XFS fully.  This isn't our preferred path; we'd prefer to
> take the backports into the COS tree via the stable trees if at all
> possible.  (Note: if requested, we could also publish these
> backported-and-tested commits on a git tree for other distros to
> take.)
> 
> There are still some details we'll need to work out; for example, will
> the XFS maintainers let us do minor/obvious patch conflict
> resolutions, or perhaps those commits which don't cherry-pick cleanly
> will need to go through some round of approval by the linux-xfs list,
> if the "we've run a full set of tests and there are no test
> regressions" isn't good enough for them.

I would expect that any proposals for backporting changes to LTS
kernels have already had this conflict/merge fixups work already
done and documented in the commit message by whoever is proposing
the backports. I.e. the commit message tells the reviewer where the
change deviates from the upstream commit.

> There is also the problem that sometimes commits aren't marked with
> Fixes tag, but maybe there are some other signals we could use (for
> example, maybe an indication in a comment in an xfstests test that
> it's testing regressions for a specified kernel commit id).  Or
> perhaps some other would be willing to contribute candidate commit
> id's for backport consideration, with the approval of linux-xfs?
> TBD...

That's not unique to XFS - every backport has this problem
regardless of subsystem. If you need a commit to be backported, then
just backport it and it just becomes another patch in the LTS
update process.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
