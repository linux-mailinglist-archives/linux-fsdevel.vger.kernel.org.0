Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE1685CA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 10:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfHHIR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 04:17:58 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47740 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731281AbfHHIR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:17:57 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2411843E618;
        Thu,  8 Aug 2019 18:17:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hvdbL-0001Bg-NE; Thu, 08 Aug 2019 18:16:47 +1000
Date:   Thu, 8 Aug 2019 18:16:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Goldwyn Rodrigues <RGoldwyn@suse.com>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, miaoxie@huawei.com
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808081647.GI7689@dread.disaster.area>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808054936.GA5319@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=TBOsBtRu_f-vuJ8yFLgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> FWIW, the only order that actually makes sense is decrypt->decompress->verity.

*nod*

Especially once we get the inline encryption support for fscrypt so
the storage layer can offload the encrypt/decrypt to hardware via
the bio containing plaintext. That pretty much forces fscrypt to be
the lowest layer of the filesystem transformation stack.  This
hardware offload capability also places lots of limits on what you
can do with block-based verity layers below the filesystem. e.g.
using dm-verity when you don't know if there's hardware encryption
below or software encryption on top becomes problematic...

So really, from a filesystem and iomap perspective, What Eric says
is the right - it's the only order that makes sense...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
