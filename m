Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4AE263E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 00:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436705AbfJWWNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 18:13:44 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39940 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436687AbfJWWNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:13:44 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 00C6E43EE24;
        Thu, 24 Oct 2019 09:13:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iNOsm-0006fc-Rc; Thu, 24 Oct 2019 09:13:32 +1100
Date:   Thu, 24 Oct 2019 09:13:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
Message-ID: <20191023221332.GE2044@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=iEe7G1TxEPlCt2B0xWcA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:09:50PM +0300, Boaz Harrosh wrote:
> On 22/10/2019 14:21, Boaz Harrosh wrote:
> > On 20/10/2019 18:59, ira.weiny@intel.com wrote:
> Please explain the use case behind your model?

No application changes needed to control whether they use DAX or
not. It allows the admin to control the application behaviour
completely, so they can turn off DAX if necessary. Applications are
unaware of constraints that may prevent DAX from being used, and so
admins need a mechanism to prevent DAX aware application from
actually using DAX if the capability is present.

e.g. given how slow some PMEM devices are when it comes to writing
data, especially under extremely high concurrency, DAX is not
necessarily a performance win for every application. Admins need a
guaranteed method of turning off DAX in these situations - apps may
not provide such a knob, or even be aware of a thing called DAX...

e.g. the data set being accessed by the application is mapped and
modified by RDMA applications, so those files must not be accessed
using DAX by any application because DAX+RDMA are currently
incompatible. Hence you can have RDMA on pmem devices co-exist
within the same filesystem as other applications using DAX to access
the pmem...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
