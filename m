Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD434A8914
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 17:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352440AbiBCQwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 11:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiBCQwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:52:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F338C061714;
        Thu,  3 Feb 2022 08:52:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D7046155C;
        Thu,  3 Feb 2022 16:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6E2C340E8;
        Thu,  3 Feb 2022 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643907162;
        bh=iaJxhtwIma6dUrbx3J2yiskIUAG+/AQHCMEnNS5R1Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ObXVLD8ZVfN8qLcAA/cwoT+F0WWY34fjcADHx5mxOicfMCp8LmOGroDLA0lzLs2+b
         Szc599IvtTtOtG5u3jWUjJia4KUNl++iTz8H9EtbTS8+8ihtbUNLjCQz8bBNy6zEhW
         tJ/k1LRfKEKD/xNnBjpj1Y90bf9/d8eACkulsewXmQ+dI70vPQfQJJe38hpojfYcBi
         +cYzFIxxxvCItLLi907bFuQgWEak+eRpVROajgoWHfmOqFSCwPBJWZbiAfVVIc1bgQ
         ocAeiEZLhJSmQ3RJ2JgSQsCmFy6VhcH9r3hvQ/7f6brbnG7hwKcBtPGM+YF8UnNvux
         WHcaWzUgxRwag==
Date:   Thu, 3 Feb 2022 08:52:38 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
 <20220203153843.szbd4n65ru4fx5hx@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203153843.szbd4n65ru4fx5hx@garbanzo>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 07:38:43AM -0800, Luis Chamberlain wrote:
> On Wed, Feb 02, 2022 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> > Mikulas,
> > 
> > On 2/1/22 10:33 AM, Mikulas Patocka wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > This patch adds a new driver "nvme-debug". It uses memory as a backing
> > > store and it is used to test the copy offload functionality.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > 
> > 
> > 
> > NVMe Controller specific memory backed features needs to go into
> > QEMU which are targeted for testing and debugging, just like what
> > we have done for NVMe ZNS QEMU support and not in kernel.
> > 
> > I don't see any special reason to make copy offload an exception.
> 
> One can instantiate scsi devices with qemu by using fake scsi devices,
> but one can also just use scsi_debug to do the same. I see both efforts
> as desirable, so long as someone mantains this.
> 
> For instance, blktests uses scsi_debug for simplicity.
> 
> In the end you decide what you want to use.

Can we use the nvme-loop target instead?
