Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67FB4A9AE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359266AbiBDOY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 09:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiBDOY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:24:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF639C061714;
        Fri,  4 Feb 2022 06:24:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E3C960C5F;
        Fri,  4 Feb 2022 14:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D276EC004E1;
        Fri,  4 Feb 2022 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643984666;
        bh=XdhQZ8GTO7VGJdHlR+9N91vtFeVQcdO/YTU+px0/6XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzhJ/5BzU8d0P8p3lsoCmIZ+ZqF5Q6wFHn1ZmZmQp4DNo139fb6LVtZSkMhIY/YPZ
         BhKy3X2pU80NBI2TCutrWXex/Nuhq3U1Lb1xTWT2H83AiNtKSQz0/CZjeZgz/Tz/Qw
         s8pwra6SHJwOlY8iI16vYQb+OHIZ+LnECOsVQw0EU4Rj0KVccRN3l+/zF2d2arcWLX
         BSIkkoOFj9yNszpyJzwGKHlKb/BlqxnLqZfvdjzFiOk6faAgmsjDfTmT60QXTMU5zw
         2LMpwawXrEqNQQESTV+9wGwouKM0jsCaNgWFbUDfyop5KLC9el3JhQVSxUNq801LnZ
         O3wwG0ie+R8Jg==
Date:   Fri, 4 Feb 2022 06:24:22 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220204142422.GA627690@dhcp-10-100-145-180.wdc.com>
References: <20220203153843.szbd4n65ru4fx5hx@garbanzo>
 <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
 <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
 <20220203195155.GB249665@bgt-140510-bm01>
 <863d85e3-9a93-4d8c-cf04-88090eb4cc02@nvidia.com>
 <2bbed027-b9a1-e5db-3a3d-90c40af49e09@opensource.wdc.com>
 <9d5d0b50-2936-eac3-12d3-a309389e03bf@nvidia.com>
 <20220204082445.hczdiy2uhxfi3x2g@ArmHalley.local>
 <4d5410a5-93c3-d73c-6aeb-2c1c7f940963@nvidia.com>
 <befa49b3-7606-a3ce-24f7-e184e3df41a3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befa49b3-7606-a3ce-24f7-e184e3df41a3@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:15:02PM +0100, Hannes Reinecke wrote:
> On 2/4/22 10:58, Chaitanya Kulkarni wrote:
> 
> > and if that is the case why we don't have ZNS NVMeOF target
> > memory backed emulation ? Isn't that a bigger and more
> > complicated feature than Simple Copy where controller states
> > are involved with AENs ?
> > 
> > ZNS kernel code testing is also done on QEMU, I've also fixed
> > bugs in the ZNS kernel code which are discovered on QEMU and I've not
> > seen any issues with that. Given that simple copy feature is way smaller
> > than ZNS it will less likely to suffer from slowness and etc (listed
> > above) in QEMU.
> > 
> > my point is if we allow one, we will be opening floodgates and we need
> > to be careful not to bloat the code unless it is _absolutely
> > necessary_ which I don't think it is based on the simple copy
> > specification.
> > 
> 
> I do have a slightly different view on the nvme target code; it should
> provide the necessary means to test the nvme host code.
> And simple copy is on of these features, especially as it will operate as an
> exploiter of the new functionality.

The threshold to determine if the in-kernel fabrics target ought to
implement a feature should be if it's useful in a production.

Are users interested in copying data without using fabric bandwidth?
Yes.

Does anyone want a mocked up ZNS that has all the contraints and none of
the benefits? No.
