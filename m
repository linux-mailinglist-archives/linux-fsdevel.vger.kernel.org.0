Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7F8DCCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 20:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfHNSPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 14:15:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35676 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfHNSPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:15:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34so11856942qte.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2019 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yv3o7B3UHsHqSeSF1eawcreZUewpnoCKBkRqVbvZv+Y=;
        b=b1+hpPlsUllmS55yStmayLIczHkh/gs2U6xTQjHLoJzP6BS9rrpQYU/Q+zjEtqYpZJ
         bUfdxFnv/io/njD4H81VOrB5HpxoX0UpCfWVJE3iMK6BRX+7xz2/qyYNYBY1s0aQv9oC
         57OzZnbd2E8pHcIPyMI3M38ltO867icv9pCABQ2nRkA4GhB4x8TTEWzbIIEp3I5Bu9v8
         1j7u4CiNFmqOJmrgun4bWFv3s4L2PKJsY5MMwj8yq7JCEFqVNh4FZN9aCdeS6xLd4vsG
         tzdz7jPh3keJQnQMNdxfDM5IWfs75T0jwE2SLAPsGzMCYk/egYJiAQxgc739HbYg2Btp
         tbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yv3o7B3UHsHqSeSF1eawcreZUewpnoCKBkRqVbvZv+Y=;
        b=VjwuZx8lfroy7tQdvq0TNzqcMXwAcTFebg6zqGNteFV3sUkl0DatZJtkVKu6w/Zlu1
         PF4VMvlccIGFs0kW9fseKI68x9XI1Pj7XyJ2Y4gbLyM6NWB0fAzpzH5NpqENH+SIzAlU
         fuv58taapb6qnSIGDBADNKcaH7LakdrtxyQc3f2vOIv8jY3Yk/s05BHT7VQ9x6Ga8dVn
         bjnNyP/7VJ7zzCCTLrKZ38a9HNu7CdN3Fjxgjitf1dh/dHJQAdnRtzv++3/msu6gkUIP
         EgSbi951cLDHW7rq9SjCNVa3VYw7WbMeVOqVp+aKKQuDtDHSFh8+r1+rqmPNbWdNEcYd
         y7Sg==
X-Gm-Message-State: APjAAAUMWETw3JSFuBcjeeeWkEGQ4kOHfDB9z64XazEhgWjOTJIHRDQv
        tizUFKD0+dNfWTZihXVtifNXfw==
X-Google-Smtp-Source: APXvYqwQg84mNfjabrjxPWgnQFA0kP85o9/bjBwuu/n1RL4RSpA12tlrWJldmQ90D3a9zEfF7PDYNg==
X-Received: by 2002:ac8:34ea:: with SMTP id x39mr609754qtb.311.1565806530924;
        Wed, 14 Aug 2019 11:15:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h66sm253461qke.61.2019.08.14.11.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 11:15:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxxo2-00028Y-0t; Wed, 14 Aug 2019 15:15:30 -0300
Date:   Wed, 14 Aug 2019 15:15:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 16/19] RDMA/uverbs: Add back pointer to system
 file object
Message-ID: <20190814181529.GD13770@ziepe.ca>
References: <20190812130039.GD24457@ziepe.ca>
 <20190812172826.GA19746@iweiny-DESK2.sc.intel.com>
 <20190812175615.GI24457@ziepe.ca>
 <20190812211537.GE20634@iweiny-DESK2.sc.intel.com>
 <20190813114842.GB29508@ziepe.ca>
 <20190813174142.GB11882@iweiny-DESK2.sc.intel.com>
 <20190813180022.GF29508@ziepe.ca>
 <20190813203858.GA12695@iweiny-DESK2.sc.intel.com>
 <20190814122308.GB13770@ziepe.ca>
 <20190814175045.GA31490@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814175045.GA31490@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:50:45AM -0700, Ira Weiny wrote:
> On Wed, Aug 14, 2019 at 09:23:08AM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 13, 2019 at 01:38:59PM -0700, Ira Weiny wrote:
> > > On Tue, Aug 13, 2019 at 03:00:22PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Aug 13, 2019 at 10:41:42AM -0700, Ira Weiny wrote:
> > > > 
> > > > > And I was pretty sure uverbs_destroy_ufile_hw() would take care of (or ensure
> > > > > that some other thread is) destroying all the MR's we have associated with this
> > > > > FD.
> > > > 
> > > > fd's can't be revoked, so destroy_ufile_hw() can't touch them. It
> > > > deletes any underlying HW resources, but the FD persists.
> > > 
> > > I misspoke.  I should have said associated with this "context".  And of course
> > > uverbs_destroy_ufile_hw() does not touch the FD.  What I mean is that the
> > > struct file which had file_pins hanging off of it would be getting its file
> > > pins destroyed by uverbs_destroy_ufile_hw().  Therefore we don't need the FD
> > > after uverbs_destroy_ufile_hw() is done.
> > > 
> > > But since it does not block it may be that the struct file is gone before the
> > > MR is actually destroyed.  Which means I think the GUP code would blow up in
> > > that case...  :-(
> > 
> > Oh, yes, that is true, you also can't rely on the struct file living
> > longer than the HW objects either, that isn't how the lifetime model
> > works.
> > 
> > If GUP consumes the struct file it must allow the struct file to be
> > deleted before the GUP pin is released.
> 
> I may have to think about this a bit.  But I'm starting to lean toward my
> callback method as a solution...
> 
> > 
> > > The drivers could provide some generic object (in RDMA this could be the
> > > uverbs_attr_bundle) which represents their "context".
> > 
> > For RDMA the obvious context is the struct ib_mr *
> 
> Not really, but maybe.  See below regarding tracking this across processes.
> 
> > 
> > > But for the procfs interface, that context then needs to be associated with any
> > > file which points to it...  For RDMA, or any other "FD based pin mechanism", it
> > > would be up to the driver to "install" a procfs handler into any struct file
> > > which _may_ point to this context.  (before _or_ after memory pins).
> > 
> > Is this all just for debugging? Seems like a lot of complication just
> > to print a string
> 
> No, this is a requirement to allow an admin to determine why their truncates
> may be failing.  As per our discussion here:
> 
> https://lkml.org/lkml/2019/6/7/982

visibility/debugging..

I don't see any solution here with the struct file - we apparently
have a problem with deadlock if the uverbs close() waits as mmput()
can trigger a call close() - see the comment on top of
uverbs_destroy_ufile_hw()

However, I wonder if that is now old information since commit
4a9d4b024a31 ("switch fput to task_work_add") makes fput deferred, so
mmdrop() should not drop waiting on fput??

If you could unwrap this mystery, probably with some testing proof,
then we could make uverbs_destroy_ufile_hw() a fence even for close
and your task is much simpler.

The general flow to trigger is to have a process that has mmap'd
something from the uverbs fd, then trigger both device disassociate
and process exit with just the right race so that the process has
exited enough that the mmdrop on the disassociate threda does the
final cleanup triggering the VMAs inside the mm to do the final fput
on their FDs, triggering final fput() for uverbs inside the thread of
disassociate.

Jason
