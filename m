Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274F4D1D9E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbiCHQm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 11:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245216AbiCHQmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:42:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626BB527C5
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 08:41:05 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 228GeIgm001108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Mar 2022 11:40:19 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D551015C00DD; Tue,  8 Mar 2022 11:40:18 -0500 (EST)
Date:   Tue, 8 Mar 2022 11:40:18 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YieG8rZkgnfwygyu@mit.edu>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YicrMCidylefTC3n@kroah.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:08:48AM +0100, Greg KH wrote:
> > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
> 
> That's up to the xfs maintainers to discuss.
> 
> > Which makes me wonder: how do the distro kernel maintainers keep up
> > with xfs fixes?
> 
> Who knows, ask the distro maintainers that use xfs.  What do they do?

This is something which is being worked, so I'm not sure we'll need to
discuss the specifics of the xfs stable backports at LSF/MM.  I'm
hopeful that by May, we'll have come to some kind of resolution of
that topic.

One of my team members has been working with Darrick to set up a set
of xfs configs[1] recommended by Darrick, and she's stood up an
automated test spinner using gce-xfstests which can watch a git branch
and automatically kick off a set of tests whenever it is updated.
Sasha has also provided her with a copy of his scripts so we can do
automated cherry picks of commits with Fixes tags.  So the idea is
that we can, hopefully in a mostly completely automated fashion, do
the backports and do a full set of regression tests on those stable
backports of XFS bug fixes.

[1] https://github.com/tytso/xfstests-bld/tree/master/kvm-xfstests/test-appliance/files/root/fs/xfs/cfg

Next steps are to get a first tranche of cherry-picks for 5.10 and
probably 5.15, and use the test spinner to demonstrate that they don't
have any test regressions (if there are, we'll drop those commits).
Once we have a first set of proposed stable backports for XFS, we'll
present them to the XFS development community for their input.  There
are a couple of things that could happen at this point, depending on
what the XFS community is willing to accept.

The first is that we'll send these tested stable patches directly to
Greg and Sasha for inclusion in the LTS releases, with the linux-xfs
list cc'ed so they know what's going into the stable trees.

The second is that we send them only to the linux-xfs list, and they
have to do whatever approval they want before they go into the
upstream stable trees.

And the third option, if they aren't willing to take our work or they
choose to require manual approvals and those approvals are taking too
long, is that we'll feed the commits into Google's Container-Optimized
OS (COS) kernel, so that our customers can get those fixes and so we
can support XFS fully.  This isn't our preferred path; we'd prefer to
take the backports into the COS tree via the stable trees if at all
possible.  (Note: if requested, we could also publish these
backported-and-tested commits on a git tree for other distros to
take.)

There are still some details we'll need to work out; for example, will
the XFS maintainers let us do minor/obvious patch conflict
resolutions, or perhaps those commits which don't cherry-pick cleanly
will need to go through some round of approval by the linux-xfs list,
if the "we've run a full set of tests and there are no test
regressions" isn't good enough for them.

There is also the problem that sometimes commits aren't marked with
Fixes tag, but maybe there are some other signals we could use (for
example, maybe an indication in a comment in an xfstests test that
it's testing regressions for a specified kernel commit id).  Or
perhaps some other would be willing to contribute candidate commit
id's for backport consideration, with the approval of linux-xfs?
TBD...

Note: Darrick has been very helpful in geting this set up; the issue
is not the XFS maintainer, but rather the will of the whole of the XFS
development community, which sometimes can be a bit... fractious.

						- Ted
