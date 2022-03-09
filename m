Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B14D395E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 20:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiCITB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 14:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiCITB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:01:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86C9E57D
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 11:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xhr2CmmYZuf5RbJ/cVs+BdGvtRZIFC9nUre+0XVD3Oo=; b=Q5YVn6JZjJ5pUlfyDeMlQssP89
        Z7PLSx34b/w/9o3rU/721oHkXK/xSDsI8MdtjABmL2q5hp/eed3SdNJ+n8ABA2/UxB6EhM9i4m2U5
        hLYdq+/dTbrGgygOGDXZUa82HQ5FDUPgLOnP7Ll7UV7a8CKEryoKZYRSB0NRPAaladoqrIVVPttT1
        egGUVMayVEvzJUErBsMEfCgxBtwUU0ZAN1vL2BKhVY3k5zuJQXeOjMRxYxLTOMS29QBN/E0g/mV+y
        s3cdP1mi6Knn9GP1E9QK9JOzM6wr3DSMkgJm9IV20PpgvB3YIVRAuGUrDnrsrp7nEj4VXoJS1nAXv
        wY5x4J8A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS1YH-00AAp0-Qp; Wed, 09 Mar 2022 19:00:49 +0000
Date:   Wed, 9 Mar 2022 11:00:49 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yij2rqDn4TiN3kK9@localhost.localdomain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:49:18PM -0500, Josef Bacik wrote:
> On Wed, Mar 09, 2022 at 10:41:53AM -0800, Luis Chamberlain wrote:
> > On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> > > One of my team members has been working with Darrick to set up a set
> > > of xfs configs[1] recommended by Darrick, and she's stood up an
> > > automated test spinner using gce-xfstests which can watch a git branch
> > > and automatically kick off a set of tests whenever it is updated.
> > 
> > I think its important to note, as we would all know, that contrary to
> > most other subsystems, in so far as blktests and fstests is concerned,
> > simply passing a test once does not mean there is no issue given that
> > some test can fail with a failure rate of 1/1,000 for instance.
> > 
> 
> FWIW we (the btrfs team) have been running nightly runs of fstests against our
> devel branch for over a year and tracking the results.

That's wonderful, what is your steady state goal? And do you have your
configurations used public and also your baseline somehwere? I think
this later aspect could be very useful to everyone.

Yes, everyone's test setup can be different, but this is why I went with
a loopback/truncated file setup, it does find more issues and so far
these have all been real.

It kind of begs the question if we should adopt something like kconfig
on fstests to help enable a few test configs we can agree on. Thoughts?

I've been experimenting a lot with this on kdevops. So the Kconfig logic
could easily just move to fstests.

  Luis
