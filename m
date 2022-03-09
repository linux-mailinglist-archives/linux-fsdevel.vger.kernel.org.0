Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4374D25F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiCIBOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiCIBN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:59 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E126E160404
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 17:01:31 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 183E3530EAF;
        Wed,  9 Mar 2022 11:02:07 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nRjmH-003BUv-T7; Wed, 09 Mar 2022 11:02:05 +1100
Date:   Wed, 9 Mar 2022 11:02:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <20220309000205.GV3927073@dread.disaster.area>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6227ee81
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=c5HUopjpSe6SA2MVdLkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:32:43AM +0200, Amir Goldstein wrote:
> On Tue, Feb 12, 2019 at 7:31 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > Hi all,
> >
> > I'd like to propose a discussion about the workflow of the stable trees
> > when it comes to fs/ and mm/. In the past year we had some friction with
> > regards to the policies and the procedures around picking patches for
> > stable tree, and I feel it would be very useful to establish better flow
> > with the folks who might be attending LSF/MM.
> >
> > I feel that fs/ and mm/ are in very different places with regards to
> > which patches go in -stable, what tests are expected, and the timeline
> > of patches from the point they are proposed on a mailing list to the
> > point they are released in a stable tree. Therefore, I'd like to propose
> > two different sessions on this (one for fs/ and one for mm/), as a
> > common session might be less conductive to agreeing on a path forward as
> > the starting point for both subsystems are somewhat different.
> >
> > We can go through the existing processes, automation, and testing
> > mechanisms we employ when building stable trees, and see how we can
> > improve these to address the concerns of fs/ and mm/ folks.
> >
> 
> Hi Sasha,
> 
> I think it would be interesting to have another discussion on the state of fs/
> in -stable and see if things have changed over the past couple of years.
> If you do not plan to attend LSF/MM in person, perhaps you will be able to
> join this discussion remotely?
> 
> From what I can see, the flow of ext4/btrfs patches into -stable still looks
> a lot healthier than the flow of xfs patches into -stable.
> 
> In 2019, Luis started an effort to improve this situation (with some
> assistance from me and you) that ended up with several submissions
> of stable patches for v4.19.y, but did not continue beyond 2019.
> 
> When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> one has to wonder if using xfs on kernels v5.x.y is a wise choice.
> 
> Which makes me wonder: how do the distro kernel maintainers keep up
> with xfs fixes?

For RHEL, we actively backport whole upstream releases with a few
cycle's delay. That means, for example, A RHEL 8 kernel might have a
5.10 XFS + random critical fixes from 5.11-16 in it. We monitor for
relevant "Fixes" tags, manage all the QE of those backports
ourselves, handle all the regressions and end user bug reports
ourselves, etc. 

There is almost zero impact on upstream from the RHEL stable
kernel process - they only intersect when a bug that also affects
upstream kernels is found. At which point, the "upstream first"
policy kicks in, and then we backport the upstream fix to the RHEL
stable kernels that need it as per eveything else that is done.

IOWs, there's a whole team of ppl at RH across FS, QE and SE who are
pretty much entirely dedicated to enabling, testing and supporting
the RHEL backports. This work is largely invisible to upstream
development and developers, except for the fact we tag bug fixes
with "fixes" tags so that distro kernel maintainers know to consider
that they need to consider backporting them sooner rather than later.

Keep in mind that an LTS kernel is no different to a SLES or RHEL
kernel in terms of the number or significance of changes it
accumulates over it's life time. However, those LTS kernels they
don't have anywhere near the same level of quality control as even
.0 upstream releases, nor do LTS kernels have a dedicated QE or
support organisations that maintaining and supporting a reliable
product that has millions of end users really requires.

It sounds like there are some things the LTS maintainers have
underway that substantially change the QE equation for LTS kernels.
WE've been asking for that for a long time with limited short term
success (e.g. Luis' effort), so I'm hopeful that things coming down
the pipeline will create a sustainable long term solution that will
enable us to have confidence that LTS backports (automated or
manual) are robust and regression free.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
