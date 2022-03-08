Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0755B4D1445
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 11:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbiCHKJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 05:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345559AbiCHKJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:09:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D39822521
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 02:08:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2097761512
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 10:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5439C340EF;
        Tue,  8 Mar 2022 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646734131;
        bh=2rouWrGlPKA6b4vo2GG+CkYIvvyfhsUYOL6ItyQoXBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4wop8tDW9jCYsMi9GKihiap1s+KCJHq6bbfql/zEvt+Ln9pSbgAnZcHoSIJNkkR5
         UtVE5poyAISs6XT7t/dhM+VU/NfUr23lNzt7nBhluNOVt2AmsVqqhk+nwswv54AniF
         4jQfLu/dwUwWhhYXpZi0gV3Xf2DIpdsWzbk64oQQ=
Date:   Tue, 8 Mar 2022 11:08:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YicrMCidylefTC3n@kroah.com>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> >From what I can see, the flow of ext4/btrfs patches into -stable still looks
> a lot healthier than the flow of xfs patches into -stable.

That is explicitly because the ext4/btrfs developers/maintainers are
marking patches for stable backports, while the xfs
developers/maintainers are not.

It has nothing to do with how me and Sasha are working, so go take this
up with the fs developers :)

> In 2019, Luis started an effort to improve this situation (with some
> assistance from me and you) that ended up with several submissions
> of stable patches for v4.19.y, but did not continue beyond 2019.
> 
> When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> one has to wonder if using xfs on kernels v5.x.y is a wise choice.

That's up to the xfs maintainers to discuss.

> Which makes me wonder: how do the distro kernel maintainers keep up
> with xfs fixes?

Who knows, ask the distro maintainers that use xfs.  What do they do?

The xfs developers/maintainer told us (Sasha and I) to not cherry-pick
any xfs "fixes:" patches to the stable trees unless they explicitly
marked it for stable.  So there's not much we can do here about this
without their involvement as I do not want to ever route around an
active maintainer like that.

> Many of the developers on CC of this message are involved in development
> of a distro kernel (at least being consulted with), so I would be very much
> interested to know how and if this issue is being dealt with.

Maybe no distro cares about xfs?  :)

thanks,

greg k-h
