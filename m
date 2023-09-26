Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB967AEEB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjIZO3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjIZO3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:29:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04A9116;
        Tue, 26 Sep 2023 07:29:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79ABC433C7;
        Tue, 26 Sep 2023 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695738558;
        bh=22WbUSTzDFZtNSTnSpdGaIa4ukPHk261XSW0L+7aAmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPXuvpuGbS3BApG8lSaFENYjlLDjp2BJzmZut8Myvrm3Hgl+Wd8d2g24lEKL+0Zvy
         6P78ta2Apoo95MNZJfG3gF8ksIq3FRlXUF6jN8COhi48yL/u7o8iipUL3PTo5cWJUa
         2nm13TxPzKb/OBIU9YkPwZA6G18oWNmXrWde7ZZbFEF5E/djQ8fQc864IEyxBOHSfn
         iU4t2qpaRGKUiz9Hdlz1eOVYOu2HEmi3ZTGNH6geJlFdKCV02TzZwzdAWnZ2WemlSI
         2fZFeb45YOf/1pKiZpGeoiHeUc8O4WbaA+ew0Hdu7TWMBL1ylvne+tA7UbxQNkFLQ8
         aSfzmSUjTzI1w==
Date:   Tue, 26 Sep 2023 16:29:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>,
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
Message-ID: <20230926-handpuppen-biegung-0e303925ccd1@brauner>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
 <20230924-mitfeiern-vorladung-13092c2af585@brauner>
 <169559548777.19404.13247796879745924682@noble.neil.brown.name>
 <20230926-boiler-coachen-bafb70e9df18@brauner>
 <9fb2dfe83772ef16a93030cdba6bd575c828d0fb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fb2dfe83772ef16a93030cdba6bd575c828d0fb.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 08:51:32AM -0400, Jeff Layton wrote:
> On Tue, 2023-09-26 at 14:18 +0200, Christian Brauner wrote:
> > > > If there's no clear users and workloads depending on this other than for
> > > > the sake of NFS then we shouldn't expose this to userspace. We've tried
> > 
> > > 
> > > Some NFS servers run in userspace, and they would a "clear user" of this
> > > functionality.
> > 
> > See my comment above. We did thist mostly for the sake of NFS as there
> > was in itself nothing wrong with timestamps that needed urgent fixing.
> > 
> > The end result has been that we caused a regression for four other major
> > filesystems when they were switched to fine-grained timestamps.
> > 
> > So NFS servers in userspace isn't a sufficient argument to just try
> > again with a slightly tweaked solution but without a wholesale fix of
> > the actual ordering problem. The bar to merge this will naturally be
> > higher the second time around.
> > 
> > That's orthogonal to improving the general timestamp infrastructure in
> > struct inode ofc.
> 
> There are multiple proposals in flight here, and they all sort of
> dovetail on one another. I'm not proposing we expose any changes to the
> timestamps to users in any way, unless we can fix the ordering issues,
> and ensure that we can preserve existing behavior re: utimensat().

Yeah, I know you're aware of that and I'm mostly clarifying the
conditions for this work for the ones not that closely involved.

> I think it's possible to do that, but I'm going to table that work for
> the moment, and finish up the atime/mtime accessor conversions first.

That sounds great.

> That makes experimenting with all of this a lot simpler. I think I can

Oh that's good then.
