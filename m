Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B9436FA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhJVCAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 22:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhJVCAe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED74B610A4;
        Fri, 22 Oct 2021 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634867898;
        bh=c8L9yqtOQno8QSB3ULMQffUkwUDJVg6kdYBJfcJdcMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g96XX9a9mSzi+2Kx8RQ65PHbUXgZ2eHNAQIWuMSIRrTBzOUvQPgi5vg7LPK9jBGam
         lhTH6OnHe8C4q0Z0fffRat2tjJm11r4Xl3d1NN3AtZ/bcJsob4EBmVShieUBmddcQC
         JnE8VxHAUpAJ2fpmr//vA/LJG/GzeUD+AyrZnVWFMo1H4oneozj04Es+3/SQuZ0S6a
         TYQiwROwM/MjigR9TyUx0DfDMbS1p67KpKym7AGZUF/QgzOdMtAyXjl99x9/YoDQuo
         Y7iuj0g//1S/3IbkzGZ2auNMbJoHshMwMUyWtSyav15RFt3KksZ4m+wBYIA/tMw03e
         UIYh/NQ7wXFUg==
Date:   Thu, 21 Oct 2021 18:58:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <20211022015817.GY24307@magnolia>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 01:37:28AM +0000, Jane Chu wrote:
> On 10/21/2021 4:31 AM, Christoph Hellwig wrote:
> > Looking over the series I have serious doubts that overloading the
> > slow path clear poison operation over the fast path read/write
> > path is such a great idea.

Why would data recovery after a media error ever be considered a
fast/hot path?  A normal read/write to a fsdax file would not pass the
flag, which skips the poison checking with whatever MCE consequences
that has, right?

pwritev2(..., RWF_RECOVER_DATA) should be infrequent enough that
carefully stepping around dax_direct_access only has to be faster than
restoring from backup, I hope?

> Understood, sounds like a concern on principle. But it seems to me
> that the task of recovery overlaps with the normal write operation
> on the write part. Without overloading some write operation for
> 'recovery', I guess we'll need to come up with a new userland
> command coupled with a new dax API ->clear_poison and propagate the
> new API support to each dm targets that support dax which, again,
> is an idea that sounds too bulky if I recall Dan's earlier rejection
> correctly.
> 
> It is in my plan though, to provide pwritev2(2) and preadv2(2) man pages
> with description about the RWF_RECOVERY_DATA flag and specifically not
> recommending the flag for normal read/write operation - due to potential
> performance impact from searching badblocks in the range.

Yes, this will help much. :)

> That said, the badblock searching is turned on only if the pmem device
> contains badblocks(i.e. bb->count > 0), otherwise, the performance
> impact is next to none. And once the badblock search starts,
> it is a binary search over user provided range. The unwanted impact
> happens to be the case when the pmem device contains badblocks
> that do not fall in the user specified range, and in that case, the
> search would end in O(1).

(I wonder about improving badblocks to be less sector-oriented and not
have that weird 16-records-max limit, but that can be a later
optimization.)

--D

> Thanks!
> -jane
> 
> 
