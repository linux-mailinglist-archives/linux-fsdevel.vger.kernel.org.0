Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFB9C5D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Aug 2019 21:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfHYTjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 15:39:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41185 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfHYTjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:39:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so15984161qtj.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2019 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IcftYbtF8hmiS81ypdWg52goznYue2k46OBNV8xIDyo=;
        b=jY1JCn+ldE3+NTo3VG4D8ssjZZ/12uHiNC485pYaAlQaG8pq2px0AOjE6MH3L2daUE
         OBQQMbkBAQx1ajmooyQh4PWVjIdt6ikqEPLDm20L670hA8QUe1IDUU8Cq7RXHKvaCJs6
         htKXA0TQcvkuZNBGS9+1p2d+L62V+4CGU22UmkrAkD8MZulxOHzPTTFZ136Y5UdWTW5x
         idbHVJEbZfo8m9QYHUrZMB8nBu9bO4c81G3htyFqwzCZfcFCkUU0+OO9AT3zsqJ59i9L
         HxpSOEcHwKnDcvmLtQNemKrtsmfjrFYpGaWhT4ebFkdejRPPm33Mc2qKmXCed7vAMCi4
         f5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IcftYbtF8hmiS81ypdWg52goznYue2k46OBNV8xIDyo=;
        b=rEJW9JgszuIAvpVyT9EG2Cv05sSDwSEMp5T5IxkzUseB+VR7jpg7k6KCZaUDszhEyJ
         77uWFXTwYhDtwo9yVYoN5YGcddd8NCPanpc45ynBwoRWdtPJm1xd15cYVG39zk6DF2U2
         9lDEw5qvUkSs8IT5oua0/O1GNDDf4OwOow9nTz7LwKKRCjY+sFFSgM5MQcBLcSuqdK0l
         7ovD/Upft0fY+UvegYWa0268tmACIpzESvblbD6+avae5OSfRV8rQkyg0eLDxR+8JTf+
         3+3l9Bfo7DbvXCSP9CMTWnBHAOByvc4off6RZa05aZZfUovucDoE5nAfqZz48KTow8pc
         +gBg==
X-Gm-Message-State: APjAAAX/VLJEJw7svcGr/w4EVgClfL7GR2wHEkDHgn5fxOqzOyzAs+TP
        LCSIfeLkAJUtjVo58NFQ+xKzxw==
X-Google-Smtp-Source: APXvYqxGjNntfiQL8TISYg5BInHS+cQ0ODQq/4ockdGbt/O3U8AzybLVwFgyx4YCA0QWh5oy2S8plQ==
X-Received: by 2002:ac8:450c:: with SMTP id q12mr14722642qtn.298.1566761942403;
        Sun, 25 Aug 2019 12:39:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id m10sm4699826qka.43.2019.08.25.12.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2019 12:39:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1yLs-0005oN-Oc; Sun, 25 Aug 2019 16:39:00 -0300
Date:   Sun, 25 Aug 2019 16:39:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190825193900.GA21239@ziepe.ca>
References: <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824001124.GI1119@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
> On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 23, 2019 at 01:23:45PM +1000, Dave Chinner wrote:
> > 
> > > > But the fact that RDMA, and potentially others, can "pass the
> > > > pins" to other processes is something I spent a lot of time trying to work out.
> > > 
> > > There's nothing in file layout lease architecture that says you
> > > can't "pass the pins" to another process.  All the file layout lease
> > > requirements say is that if you are going to pass a resource for
> > > which the layout lease guarantees access for to another process,
> > > then the destination process already have a valid, active layout
> > > lease that covers the range of the pins being passed to it via the
> > > RDMA handle.
> > 
> > How would the kernel detect and enforce this? There are many ways to
> > pass a FD.
> 
> AFAIC, that's not really a kernel problem. It's more of an
> application design constraint than anything else. i.e. if the app
> passes the IB context to another process without a lease, then the
> original process is still responsible for recalling the lease and
> has to tell that other process to release the IB handle and it's
> resources.

It is a kernel problem, the MR exists and is doing DMA. That relies on
the lease to prevent data corruption.

The sanest outcome I could suggest is that when the kernel detects the
MR has outlived the lease it needs then we forcibly abort the entire
RDMA state. Ie the application has malfunctioned and gets wacked with
a very big hammer.

> That still doesn't work. Leases are not individually trackable or
> reference counted objects objects - they are attached to a struct
> file bUt, in reality, they are far more restricted than a struct
> file.

This is the problem. How to link something that is not refcounted to
the refcounted world of file descriptors does not seem very obvious.

There are too many places where struct file relies on its refcounting
to try to and plug them.

Jason
