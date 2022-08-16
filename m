Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D308595326
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiHPG5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiHPG4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E890570E56;
        Mon, 15 Aug 2022 19:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 851B460BD8;
        Tue, 16 Aug 2022 02:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF819C433D6;
        Tue, 16 Aug 2022 02:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660616304;
        bh=WOl5KGSNQ3BSr9I7Gt0VEntd0vS3+xM4qeCdvz0OwGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3G2EKltD1n2xmg02F0mL7yOJNFMgoHsmOOoQ2rQ99V8z42kqAgsWz/4OdibxEjCw
         xOWGkoqG9xC90EtS5J7hDbWQpIBccyN8VvRe99N90BTOvVhqT1hZkWyr8ydVOyIelg
         +tvOJMFRVRomcd0FgGAhMRf4TNl27AI1iAOykAhnouLnaD77wcOmXjOaNm0OlFrHQQ
         GdPvhmX07Zc3AQQWMDUJCDgz+dtjcPh8Y/75oxVGhe8dq2vZ4MxBkH445vt35OhExg
         u+NRqHgkBEPXDwxUA7JQxmnceaSGqGngxPPuMu/qZEXiZztvEsoriXk/hQ/KnzBAnu
         QDusB5awPz8Lw==
Date:   Mon, 15 Aug 2022 19:18:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Subject: Re: [PATCH 03/14] xfs: document the testing plan for online fsck
Message-ID: <Yvr+cDtKcl3O8OC/@magnolia>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
 <165989702236.2495930.5556030223682318775.stgit@magnolia>
 <20220811000945.GN3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811000945.GN3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:09:45AM +1000, Dave Chinner wrote:
> On Sun, Aug 07, 2022 at 11:30:22AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Start the third chapter of the online fsck design documentation.  This
> > covers the testing plan to make sure that both online and offline fsck
> > can detect arbitrary problems and correct them without making things
> > worse.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  187 ++++++++++++++++++++
> >  1 file changed, 187 insertions(+)
> 
> 
> ....
> > +Stress Testing
> > +--------------
> > +
> > +A unique requirement to online fsck is the ability to operate on a filesystem
> > +concurrently with regular workloads.
> > +Although it is of course impossible to run ``xfs_scrub`` with *zero* observable
> > +impact on the running system, the online repair code should never introduce
> > +inconsistencies into the filesystem metadata, and regular workloads should
> > +never notice resource starvation.
> > +To verify that these conditions are being met, fstests has been enhanced in
> > +the following ways:
> > +
> > +* For each scrub item type, create a test to exercise checking that item type
> > +  while running ``fsstress``.
> > +* For each scrub item type, create a test to exercise repairing that item type
> > +  while running ``fsstress``.
> > +* Race ``fsstress`` and ``xfs_scrub -n`` to ensure that checking the whole
> > +  filesystem doesn't cause problems.
> > +* Race ``fsstress`` and ``xfs_scrub`` in force-rebuild mode to ensure that
> > +  force-repairing the whole filesystem doesn't cause problems.
> > +* Race ``xfs_scrub`` in check and force-repair mode against ``fsstress`` while
> > +  freezing and thawing the filesystem.
> > +* Race ``xfs_scrub`` in check and force-repair mode against ``fsstress`` while
> > +  remounting the filesystem read-only and read-write.
> > +* The same, but running ``fsx`` instead of ``fsstress``.  (Not done yet?)
> 
> I had a thought when reading this that we want to ensure that online
> repair handles concurrent grow/shrink operations so that doesn't
> cause problems, as well as dealing with concurrent attempts to run
> independent online repair processes.
> 
> Not sure that comes under stress testing, but it was the "test while
> freeze/thaw" that triggered me to think of this, so that's where I'm
> commenting about it. :)

Hmm.  I hadn't really given that much thought.  Let me go add that to
the test suite and see how many daemons come pouring out...

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
