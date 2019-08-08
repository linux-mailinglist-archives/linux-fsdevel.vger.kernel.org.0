Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB95185D0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfHHIkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 04:40:39 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3083 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfHHIki (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:40:38 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id F0C7E64C495EF3C2A2DF;
        Thu,  8 Aug 2019 16:40:36 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 8 Aug 2019 16:40:36 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 8
 Aug 2019 16:40:36 +0800
Date:   Thu, 8 Aug 2019 16:57:45 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Goldwyn Rodrigues <RGoldwyn@suse.com>, "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <miaoxie@huawei.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190808085745.GE28630@138>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190808081647.GI7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190808081647.GI7689@dread.disaster.area>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Thu, Aug 08, 2019 at 06:16:47PM +1000, Dave Chinner wrote:
> On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> 
> *nod*
> 
> Especially once we get the inline encryption support for fscrypt so
> the storage layer can offload the encrypt/decrypt to hardware via
> the bio containing plaintext. That pretty much forces fscrypt to be
> the lowest layer of the filesystem transformation stack.  This
> hardware offload capability also places lots of limits on what you
> can do with block-based verity layers below the filesystem. e.g.
> using dm-verity when you don't know if there's hardware encryption
> below or software encryption on top becomes problematic...
> 
> So really, from a filesystem and iomap perspective, What Eric says
> is the right - it's the only order that makes sense...

Don't be surprised there will be a decrypt/verity/decompress
all-in-one hardware approach for such stuff. 30% random IO (no matter
hardware or software approach) can be saved that is greatly helpful
for user experience on embedded devices with too limited source.

and I really got a SHA256 CPU hardware bug years ago.

I don't want to talk more on tendency, it depends on real scenerio
and user selection (server or embedded device).

For security consideration, these approaches are all the same
level --- these approaches all from the same signed key and
storage source, all transformation A->B->C or A->C->B are equal.

For bug-free, we can fuzzer compression/verity algorithms even
the whole file-system stack. There is another case other than
security consideration.

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
