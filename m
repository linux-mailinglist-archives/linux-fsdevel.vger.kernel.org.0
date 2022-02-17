Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3F4BA773
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbiBQRuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 12:50:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237904AbiBQRuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:50:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74152291FBF;
        Thu, 17 Feb 2022 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1zFqRS7lGsUI9447tPjr+UyxcPBpVVJrIYKaMONuEZQ=; b=ewn0IO8WBPwCjs00l2ERqN87rx
        TnPixZQ79w+f2vyXxPD272rHyYhd4n34SnMTkkaAc1lF2qb29ZnhRYcjDLxXkLbhjovlJEeY+ptmq
        VZUqXNYiMoayFdyqZ/ViOfBwX7Ox/aNAhjSrXbYukmlqJacF3N2uVBdv8r09orglvU0dCQa0Fr+A5
        lO8Uwv4d3zVKyGthoyN2N4Yn+Atj0F6UAmYuAIFISPxnEbFrbqkak4B3h38opGuCzUCHTOSZyxk1d
        W6UpYIhwPlgCj9UIURHoiqFAuVPN48BRGsOQljMpo9QxPUnxEq/a6tFKqKHXjgBsK0pmxFKtl2UFC
        vJAM1VDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKkua-00BdTP-0U; Thu, 17 Feb 2022 17:49:48 +0000
Date:   Thu, 17 Feb 2022 09:49:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "arnav.dawn@samsung.com" <arnav.dawn@samsung.com>,
        "nitheshshetty@gmail.com" <nitheshshetty@gmail.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3 02/10] block: Introduce queue limits for copy-offload
 support
Message-ID: <Yg6Ku8XqnTjvNCrC@bombadil.infradead.org>
References: <20220214080002.18381-1-nj.shetty@samsung.com>
 <CGME20220214080605epcas5p16868dae515a6355cf9fecf22df4f3c3d@epcas5p1.samsung.com>
 <20220214080002.18381-3-nj.shetty@samsung.com>
 <20220217090700.b7n33vbkx5s4qbfq@garbanzo>
 <f0f9317f-839e-2be2-dec6-c5b94d7022b7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f9317f-839e-2be2-dec6-c5b94d7022b7@nvidia.com>
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

On Thu, Feb 17, 2022 at 10:16:21AM +0000, Chaitanya Kulkarni wrote:
> On 2/17/22 1:07 AM, Luis Chamberlain wrote:
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index efed3820cbf7..792e6d556589 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -254,6 +254,13 @@ struct queue_limits {
> >>   	unsigned int		discard_alignment;
> >>   	unsigned int		zone_write_granularity;
> >>   
> >> +	unsigned long		max_hw_copy_sectors;
> >> +	unsigned long		max_copy_sectors;
> >> +	unsigned int		max_hw_copy_range_sectors;
> >> +	unsigned int		max_copy_range_sectors;
> >> +	unsigned short		max_hw_copy_nr_ranges;
> >> +	unsigned short		max_copy_nr_ranges;
> > 
> > Before limits start growing more.. I wonder if we should just
> > stuff hw offload stuff to its own struct within queue_limits.
> > 
> > Christoph?
> > 
> 
> Potentially use a pointer to structure and maybe make it configurable,

Did you mean to make queue limits local or for hw offload and make that
a pointer? If so that seems odd because even for hw copy offload we
still need the other limits no?

So what I meant was that struct queue_limits seems to be getting large,
and that hw copy offload seems like an example use case where we should
probably use a separate struct for it. And while at it, well, start
adding kdocs for these things, because, there's tons of things which
could use kdoc love.

> although I'm not sure about the later part, I'll let Christoph decide
> that.

  Luis
