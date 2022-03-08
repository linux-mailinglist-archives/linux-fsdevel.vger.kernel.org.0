Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62B4D153D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346017AbiCHKy7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 05:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346037AbiCHKy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:54:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5142EF1
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 02:54:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A0E881F397;
        Tue,  8 Mar 2022 10:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646736841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XG0DWnDd4jeD71fY0oj7zwjEjQ7LGAppVBJhoBEptOk=;
        b=bs9wbXYLpZbQAwtxUWPhTh5HZwtRFACTS+Hjz0q1dWauBF2tt31JoYO3J9MrqrVkbyrg+0
        B6MknIB5ZA5zqaLXcIjDCN91ymW+0rlDRFEmDGEu9EPyHPOtOS1muXSbL8/E2xtQEzGp8Y
        J8cJ9iV9sbJ9J/yN7tzxkRjBB4kHoN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646736841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XG0DWnDd4jeD71fY0oj7zwjEjQ7LGAppVBJhoBEptOk=;
        b=Upd/XmAtoQWukf27Qzl/7UAgdoaV3FdxLC5GriX5SiTYKizNNsConE9mDGnEJS6eluS2qQ
        XIog4hEgrBPFflAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 87C94A3B85;
        Tue,  8 Mar 2022 10:54:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D59FA0609; Tue,  8 Mar 2022 11:54:01 +0100 (CET)
Date:   Tue, 8 Mar 2022 11:54:01 +0100
From:   Jan Kara <jack@suse.cz>
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
Message-ID: <20220308105401.67ixo7upkazsadsd@quack3.lan>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-03-22 11:32:43, Amir Goldstein wrote:
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
> 
> Many of the developers on CC of this message are involved in development
> of a distro kernel (at least being consulted with), so I would be very much
> interested to know how and if this issue is being dealt with.

So I can explain for SUSE I guess. We generally don't use long-term stable
kernels for our distro releases (and short term -stable kernel is long
finished before it passes through our development cycle and is released as
an enterprise distro kernel - so e.g. base for the next SLES kernel is
5.14.21). We have infrastructure which tracks Fixes tags and also long-term
stable kernels and from that generates a feed of patches that may be
interesting for us to push into enterprise kernels. The feed is actually
split by kernel areas so you get patches in your area of expertise (so for
example I get this feed for ext4, udf, fs/notify, writeback, fs-mm
boundary, ...) Then we judge whether each patch makes sense for us or not,
backport what makes sense, run the result through tests (e.g. I usually do
general fstests runs and then some targetted testing if needed for
peculiar bugs) and push it out. The result then goes through another round
of general QA testing before it gets released.

So for XFS in particular we do carry somewhat more patches than stable
trees.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
