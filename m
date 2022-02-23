Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A24C0677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 01:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiBWA4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 19:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWA4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:56:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067742494;
        Tue, 22 Feb 2022 16:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UHKUXaQs83hzUDt8v+U00kEJvR6ZOsIIGcwG7EVaZYM=; b=ZZ8XaVHr7DtXsF4mq/JhD+5e19
        PTQkrxYd2u/tKyqslo/SH7ec5rFaZ4v251YwFUYA4y1psL20VLIJ3+gxLLpZ7KaaOy8EIwgg16Urb
        o7cyMzQa6dLO9oLH4usZX17Z4/TP3HAUiVQXi5ZK5jrNaIwWFywVM8LCGcsSlR1Ouao5988oG8pJ6
        fMnQLJYRyyCbUT4M2ag1lWIhqdUuu8oQylCt9m6iMM4oDa1NwxKH2Cq+PYQGORzHbZvXh7BIYGcPT
        OoQQLhBr4cW8bmu7IwxukZ+cYv3EPK4sVSKCaIHulOY2QHYiLI6nVQOsFhzg4cuQxeMIEADaX/rcY
        PdsLQGqA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMfwT-00C2dS-Pt; Wed, 23 Feb 2022 00:55:41 +0000
Date:   Tue, 22 Feb 2022 16:55:41 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     hch@lst.de, javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <YhWGDUyQkUcE6itt@bombadil.infradead.org>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
 <20220217125901.GA3781@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217125901.GA3781@test-zns>
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

On Thu, Feb 17, 2022 at 06:29:01PM +0530, Nitesh Shetty wrote:
>  Thu, Feb 17, 2022 at 01:07:00AM -0800, Luis Chamberlain wrote:
> > The subject says limits for copy-offload...
> > 
> > On Mon, Feb 14, 2022 at 01:29:52PM +0530, Nitesh Shetty wrote:
> > > Add device limits as sysfs entries,
> > >         - copy_offload (RW)
> > >         - copy_max_bytes (RW)
> > >         - copy_max_hw_bytes (RO)
> > >         - copy_max_range_bytes (RW)
> > >         - copy_max_range_hw_bytes (RO)
> > >         - copy_max_nr_ranges (RW)
> > >         - copy_max_nr_ranges_hw (RO)
> > 
> > Some of these seem like generic... and also I see a few more max_hw ones
> > not listed above...
> >
> queue_limits and sysfs entries are differently named.
> All sysfs entries start with copy_* prefix. Also it makes easy to lookup
> all copy sysfs.
> For queue limits naming, I tried to following existing queue limit
> convention (like discard).

My point was that your subject seems to indicate the changes are just
for copy-offload, but you seem to be adding generic queue limits as
well. Is that correct? If so then perhaps the subject should be changed
or the patch split up.

> > > +static ssize_t queue_copy_offload_store(struct request_queue *q,
> > > +				       const char *page, size_t count)
> > > +{
> > > +	unsigned long copy_offload;
> > > +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> > > +
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> > > +		return -EINVAL;
> > 
> > 
> > If the kernel schedules, copy_offload may still be true and
> > max_hw_copy_sectors may be set to 0. Is that an issue?
> >
> 
> This check ensures that, we dont enable offload if device doesnt support
> offload. I feel it shouldn't be an issue.

My point was this:

CPU1                                       CPU2
Time
1) if (copy_offload 
2)    ---> preemption so it schedules      
3)    ---> some other high priority task  Sets q->limits.max_hw_copy_sectors to 0
4) && !q->limits.max_hw_copy_sectors)

Can something bad happen if we allow for this?

