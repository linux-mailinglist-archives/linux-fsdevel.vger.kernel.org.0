Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5B44679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393033AbfFMQwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:52:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfFMDX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QaIPZk5fG08PMipK2ZOjFgNMkP7/mE5EU+2hsa7y6lY=; b=VCF/wqwvWCkPBIrvCaL/D3G8l
        tHqc/P5TR0jF4odv4tFa+eZycXtANJYw8npQGw1u7+6Uv8D3dPL6PSPWSss02vOD3RMl8SN9UE9tE
        pgdev89Cvk50mX8MdLQMFzWKjT9ybPnHlvymKlhrDcAdtq9BjKibIVkW+vernB9b/39/CVM/w8KPZ
        7eNO6yjjUerdEhluGAkQcubSLK9G/8N4d5w54XxHTAPHR/5HqmRB4lPvHLnyja2+Z1QV2Pr2MBWyz
        OHrDRVCwX8aCx5s1LcyskUetCbhRrlq1e3Hk4+o+Gp2Qi2Fokqvsf6H+CAZFG91Ylp4HPDaT6v01i
        r9dkL+CUQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hbGKe-0003os-RJ; Thu, 13 Jun 2019 03:23:20 +0000
Date:   Wed, 12 Jun 2019 20:23:20 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613032320.GG32656@bombadil.infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613002555.GH14363@dread.disaster.area>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > That's rather different from the normal meaning of 'exclusive' in the
> > context of locks, which is "only one user can have access to this at
> > a time".
> 
> Layout leases are not locks, they are a user access policy object.
> It is the process/fd which holds the lease and it's the process/fd
> that is granted exclusive access.  This is exactly the same semantic
> as O_EXCL provides for granting exclusive access to a block device
> via open(), yes?

This isn't my understanding of how RDMA wants this to work, so we should
probably clear that up before we get too far down deciding what name to
give it.

For the RDMA usage case, it is entirely possible that both process A
and process B which don't know about each other want to perform RDMA to
file F.  So there will be two layout leases active on this file at the
same time.  It's fine for IOs to simultaneously be active to both leases.
But if the filesystem wants to move blocks around, it has to break
both leases.

If Process C tries to do a write to file F without a lease, there's no
problem, unless a side-effect of the write would be to change the block
mapping, in which case either the leases must break first, or the write
must be denied.

Jason, please correct me if I've misunderstood the RDMA needs here.
