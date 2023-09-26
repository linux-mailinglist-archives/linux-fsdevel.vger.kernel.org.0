Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A367AEC51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 14:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjIZMS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 08:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIZMS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40D101;
        Tue, 26 Sep 2023 05:18:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D501C433CA;
        Tue, 26 Sep 2023 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695730730;
        bh=IC1gqNbWDlMOhu5zCk2ye21ZT+0MLo6x9JXH8ENjgLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DPl6/Thkz67mxty4CmevJwef/L3Ky2Sj6LBqfd8/fLVUROP55j7R//zbPfIronkch
         nf8nH+1Jco1NY8f1K/2vU344RfLbyU8iipkO2nl061xjzal+UCWtz6T257xM+HtcWq
         cgBHC2J7eQjVCNUZOxUsj+U41VP1X7bXCVQff7+7E2ZEOB9xWCVxyDyMjZ00PlFHL6
         GzxojVSSnAiAXizE+msM5Qm30M5aaYc9qZ0Cerb3Y+RxgIkyxyaXSd+aV5kOksZL7y
         J7tfKC5g1bAez5UlRrelhzVbEWRvUvQXs2COEssVz57EIVEglN9wFEvOigsIE3Rn+j
         1xKsyRXiZbMaQ==
Date:   Tue, 26 Sep 2023 14:18:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
Message-ID: <20230926-boiler-coachen-bafb70e9df18@brauner>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
 <20230924-mitfeiern-vorladung-13092c2af585@brauner>
 <169559548777.19404.13247796879745924682@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169559548777.19404.13247796879745924682@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > If there's no clear users and workloads depending on this other than for
> > the sake of NFS then we shouldn't expose this to userspace. We've tried

> 
> Some NFS servers run in userspace, and they would a "clear user" of this
> functionality.

See my comment above. We did thist mostly for the sake of NFS as there
was in itself nothing wrong with timestamps that needed urgent fixing.

The end result has been that we caused a regression for four other major
filesystems when they were switched to fine-grained timestamps.

So NFS servers in userspace isn't a sufficient argument to just try
again with a slightly tweaked solution but without a wholesale fix of
the actual ordering problem. The bar to merge this will naturally be
higher the second time around.

That's orthogonal to improving the general timestamp infrastructure in
struct inode ofc.
