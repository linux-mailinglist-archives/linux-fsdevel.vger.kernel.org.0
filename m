Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9012705
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 07:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfECFRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 01:17:23 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:40834 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbfECFRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 01:17:23 -0400
Received: from dread.disaster.area (pa49-181-171-240.pa.nsw.optusnet.com.au [49.181.171.240])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id C38023DBEE7;
        Fri,  3 May 2019 15:17:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hMQZS-0007iC-Mh; Fri, 03 May 2019 15:17:18 +1000
Date:   Fri, 3 May 2019 15:17:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Davidlohr Bueso <dbueso@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20190503051718.GM29573@dread.disaster.area>
References: <20190404165737.30889-1-amir73il@gmail.com>
 <20190404211730.GD26298@dastard>
 <20190408103303.GA18239@quack2.suse.cz>
 <1554741429.3326.43.camel@suse.com>
 <20190411011117.GC29573@dread.disaster.area>
 <20190416122240.GN29573@dread.disaster.area>
 <20190418031013.GX29573@dread.disaster.area>
 <1555611694.18313.12.camel@suse.com>
 <20190420235412.GY29573@dread.disaster.area>
 <20190503041727.GL29573@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503041727.GL29573@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=LhzQONXuMOhFZtk4TmSJIw==:117 a=LhzQONXuMOhFZtk4TmSJIw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=E5NmQfObTbMA:10
        a=7-415B0cAAAA:8 a=_g67QGjv7U8_NgNo6WAA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 03, 2019 at 02:17:27PM +1000, Dave Chinner wrote:
> Concept proven.
> 
> Next steps are:
....
> 	- work out whether RCU read locking and kfree_rcu() will
> 	  work with the requirement to do memory allocation while
> 	  holding rcu_read_lock(). Alternative is an internal
> 	  garbage collector mechanism, kinda like I've hacked up to
> 	  simulate kfree_rcu() in userspace.

Internal RCU interactions are now solved. Actually very simple in
the end, should be very easy to integrate into the code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
