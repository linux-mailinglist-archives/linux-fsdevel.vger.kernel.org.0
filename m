Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6873D7A5962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjISFcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 01:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjISFcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:32:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FAC102;
        Mon, 18 Sep 2023 22:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11257C433C8;
        Tue, 19 Sep 2023 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695101529;
        bh=6ETapI40ei8LUIBUtJd9POMEs+mJGY9nr0kwwV+6UAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZWgoFnbj5FHaNGPXmUdLdoUyMaU7r7iEAVj4YDfEEaR1JjTiwZNXCPK8b5QlwEah
         hY0voCIGyjvY3Bnr7sgf8WbmYNYd/iez6M6lSnzZ0g5Gxv075v/4QZduM7QQ8KYAOw
         QUCRSOw6a3yUECpLhO5B5IRL2EoFPeM3d5n6sqkmWpmwijRLb40aLsNi64h4IL2P4W
         2Bh6hivEC547o0RsSWSIOmckIavNOA3s1/TsbISJvG7Bu46weZH6P5gF4JnoNEETlW
         nngCPgG/RzwPm6Sbtuh4Csgz7aP5pGRGu08q3lqKUgpaq5TqTuo+o9UwjcaTJjOoLa
         mgUHiTGW2LPfA==
Date:   Mon, 18 Sep 2023 22:32:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] iomap: don't skip reading in !uptodate folios when
 unsharing a range
Message-ID: <20230919053208.GH348018@frogsfrogsfrogs>
References: <169507872536.772278.18183365318216726644.stgit@frogsfrogsfrogs>
 <87o7hy7nhp.fsf@doe.com>
 <20230919052434.GG348018@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919052434.GG348018@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:24:34PM -0700, Darrick J. Wong wrote:
> On Tue, Sep 19, 2023 at 10:44:58AM +0530, Ritesh Harjani wrote:
> > "Darrick J. Wong" <djwong@kernel.org> writes:
> > 
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Prior to commit a01b8f225248e, we would always read in the contents of a
> > > !uptodate folio prior to writing userspace data into the folio,
> > > allocated a folio state object, etc.  Ritesh introduced an optimization
> > > that skips all of that if the write would cover the entire folio.
> > >
> > > Unfortunately, the optimization misses the unshare case, where we always
> > > have to read in the folio contents since there isn't a data buffer
> > > supplied by userspace.  This can result in stale kernel memory exposure
> > > if userspace issues a FALLOC_FL_UNSHARE_RANGE call on part of a shared
> > > file that isn't already cached.
> > >
> > > This was caught by observing fstests regressions in the "unshare around"
> > > mechanism that is used for unaligned writes to a reflinked realtime
> > > volume when the realtime extent size is larger than 1FSB,
> > 
> > I was wondering what is testcase that you are referring here to? 
> > Can you please tell the testcase no. and the mkfs / mount config options
> > which I can use to observe the regression please?
> 
> https://lore.kernel.org/linux-fsdevel/169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs/T/#m8081f74f4f1fcb862399aa1544be082aabe56765
> 
> (any xfs config with reflink enabled)

*OH* you meant which testcase in the realtime reflink patchset.

This testcase:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/commit/tests/xfs/1919?h=djwong-wtf&id=56538e8882ac52e606882cfcab7e46dcb64d2a62

And this tag:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=realtime-reflink-extsize_2023-09-12
If you rebase this branch against 6.6-rc1.

Then you need this xfsprogs:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/tag/?h=realtime-reflink-extsize_2023-09-12

and ... MKFS_OPTIONS='-d rtinherit=1, -n parent=1, -r extsize=28k,rtgroups=1'
along with a SCRATCH_RTDE.

I'm basically done porting djwong-dev to 6.6 and will likely have an
initial patchbomb of more online fsck stuff for 6.7 in a few days.

--D

> --D
> 
> > > though I think it applies to any shared file.
> > >
> > > Cc: ritesh.list@gmail.com, willy@infradead.org
> > > Fixes: a01b8f225248e ("iomap: Allocate ifs in ->write_begin() early")
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/iomap/buffered-io.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index ae8673ce08b1..0350830fc989 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -640,11 +640,13 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
> > >  	size_t poff, plen;
> > >  
> > >  	/*
> > > -	 * If the write completely overlaps the current folio, then
> > > +	 * If the write or zeroing completely overlaps the current folio, then
> > >  	 * entire folio will be dirtied so there is no need for
> > >  	 * per-block state tracking structures to be attached to this folio.
> > > +	 * For the unshare case, we must read in the ondisk contents because we
> > > +	 * are not changing pagecache contents.
> > >  	 */
> > > -	if (pos <= folio_pos(folio) &&
> > > +	if (!(iter->flags & IOMAP_UNSHARE) && pos <= folio_pos(folio) &&
> > >  	    pos + len >= folio_pos(folio) + folio_size(folio))
> > >  		return 0;
> > >  
