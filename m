Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F50445C30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 23:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhKDWkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 18:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhKDWkU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:40:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B13666112E;
        Thu,  4 Nov 2021 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636065461;
        bh=d0SlTjW092+hNldgcKqMvjRj8A4fH3dQeSYxjCXIE+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2Z1NXGFJcrDHRSJ4YsljTKXDwTIDfXjPxjuw4cAkJqfDVc7cASUlgwflC88tOweV
         JFP5arOcXbccjl5/V+EMbowyZTqn0MQ4afVsp5xV3ebPz89zxsZB5eQJoiOoRAUyM3
         vuWV/QVVj/EJhT6iJoToF4AGQnqZIXLhmWwXYe+0wuAmdxpFNjA+HlW8qMhcs90gRl
         XhCLuHp8KdWMvBLiFUBTKBvwZgadkK57w6drNa6+5g6puakjnWhz/GhxocC1DYtZh0
         IicrB7Jg7pWPnaBNvAuE6xBflXcJyk8Y1t2dmz+iFrFE+plPRYZ2Ly3cgts6eM5evQ
         uI+hx3W5popiw==
Date:   Thu, 4 Nov 2021 15:37:36 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Message-ID: <20211104223736.GA2655721@dhcp-10-100-145-180.wdc.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
 <20211104173235.GI2237511@magnolia>
 <20211104173431.GA31740@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104173431.GA31740@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 06:34:31PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 10:32:35AM -0700, Darrick J. Wong wrote:
> > I also wonder if it would be useful (since we're already having a
> > discussion elsewhere about data integrity syscalls for pmem) to be able
> > to call this sort of thing against files?  In which case we'd want
> > another preadv2 flag or something, and then plumb all that through the
> > vfs/iomap as needed?
> 
> IFF we do this (can't answer if there is a need) we should not
> overload read with it.  It is an operation that does not return
> data but just a status, so let's not get into that mess.

If there is a need for this, a new io_uring opcode seems like the
appropirate user facing interface for it.
