Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33965DF846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 00:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfJUWwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 18:52:41 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56174 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730399AbfJUWwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 18:52:41 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0202A363692;
        Tue, 22 Oct 2019 09:52:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMgXS-00074h-TR; Tue, 22 Oct 2019 09:52:34 +1100
Date:   Tue, 22 Oct 2019 09:52:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Message-ID: <20191021225234.GC2642@dread.disaster.area>
References: <20191021214137.8172-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021214137.8172-1-mchristi@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=rSlL4X6sGr0P-yuullEA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:41:37PM -0500, Mike Christie wrote:
> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
> amd nbd that have userspace components that can run in the IO path. For
> example, iscsi and nbd's userspace deamons may need to recreate a socket
> and/or send IO on it, and dm-multipath's daemon multipathd may need to
> send IO to figure out the state of paths and re-set them up.
> 
> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
> memalloc_*_save/restore functions to control the allocation behavior,
> but for userspace we would end up hitting a allocation that ended up
> writing data back to the same device we are trying to allocate for.

I think this needs to describe the symptoms this results in. i.e.
that this can result in deadlocking the IO path.

> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
> with prctl during their initialization so later allocations cannot
> calling back into them.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---

....
> +	case PR_SET_MEMALLOC:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;

Wouldn't CAP_SYS_RAWIO (because it's required by kernel IO path
drivers) or CAP_SYS_RESOURCE (controlling memory allocation
behaviour) be more appropriate here?

Which-ever is selected, the use should be added to the list above
the definition of the capability in include/linux/capability.h...

Otherwise looks fine to me.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
