Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C13667EE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 20:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbjALTTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 14:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240172AbjALTT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:19:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7524FCFA
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 11:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/0LfEs3dQk5/tKo4Lpal+kMbUMz2Vp7jtf2oGU751vI=; b=bwAohEGxD+6tU/6xRxgd8Uu1/K
        dmoMxX1RyLg61XwSIC0m+adLPV9j5+Wdq9g50NtHKHqpy9hSfLlAi9j5EvzwX00qlfmwnBurrP9CR
        6AT1MD47sT8DgD4eLTGYacIHK1XHD6WszZqZqH1hR+XC3KoBpQCuTNAoW+pCpYQYdbneLLaApPCFs
        PEsrmGaixiUkfROsySBW2Hg7ps6ydnwF+RVHx1yf/euA6m2shLoE4XLOKSSLz8qnYVrOSE2ascpIg
        8KBDCduhFszUVG0U9zT5yKKXE21blfVbm3MC+UWMES9G9P1fwErEVWOWpmJ4+gZmgTQY4sxThY5Xs
        Uu6QPQBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pG2v2-001XBX-3A;
        Thu, 12 Jan 2023 19:07:21 +0000
Date:   Thu, 12 Jan 2023 19:07:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] gfs2: Shut down frozen filesystem on last unmount
Message-ID: <Y8BaaFGGi7UybSg3@ZenIV>
References: <20221129230736.3462830-1-agruenba@redhat.com>
 <20221129230736.3462830-4-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129230736.3462830-4-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:07:35AM +0100, Andreas Gruenbacher wrote:
> So far, when a frozen filesystem is last unmouted, it turns into a
> zombie rather than being shut down; to shut it down, it needs to be
> remounted and thawed first.
> 
> That's silly for local filesystems, but it's worse for filesystems like
> gfs2 which freeze a filesystem cluster-wide when fsfreeze is called on
> one of the nodes.  Only the node that initiated a freeze is allowed to
> thaw the filesystem it again.  On the other nodes, the only way to shut
> down the remotely frozen filesystem is to power off.
> 
> Change that on gfs2 so that frozen filesystems are immediately shut down
> when they are last unmounted and removed from the filesystem namespace.
> This doesn't require writing to the filesystem, so the remaining cluster
> nodes remain undisturbed.

	So what are your preferred rules wrt active references vs. bdev
freeze depth vs. actual frozen state of fs?  The current situation is
already headache-inducing (and I wouldn't bet on correctness - e.g.
FITHAW vs. XFS_IOC_GOINDOWN is interesting).  And the variety of callbacks
(->thaw_super() vs. ->unfreeze_fs(), etc.) also doesn't help, to put it
mildly...

	Sure, gfs2 has unusual needs in that area, but it would be really
nice to get that thing regularized to something that would work for
all users of that machinery.
