Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D788E533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfHOHIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:08:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3531 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730220AbfHOHIa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:08:30 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D21833C0005A2CC6FB3C;
        Thu, 15 Aug 2019 15:08:27 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 15 Aug 2019 15:08:27 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 15
 Aug 2019 15:08:26 +0800
Date:   Thu, 15 Aug 2019 15:25:35 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Pavel Machek <pavel@denx.de>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v7 08/24] erofs: add namei functions
Message-ID: <20190815072534.GA38177@138>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
 <20190813091326.84652-9-gaoxiang25@huawei.com>
 <20190813114821.GB11559@amd>
 <20190813122332.GA17429@138>
 <20190815070132.GB3669@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190815070132.GB3669@amd>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pavel,

On Thu, Aug 15, 2019 at 09:01:32AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > +	/*
> > > > +	 * on-disk error, let's only BUG_ON in the debugging mode.
> > > > +	 * otherwise, it will return 1 to just skip the invalid name
> > > > +	 * and go on (in consideration of the lookup performance).
> > > > +	 */
> > > > +	DBG_BUGON(qd->name > qd->end);
> > > 
> > > I believe you should check for errors in non-debug mode, too.
> > 
> > Thanks for your kindly reply!
> > 
> > The following is just my personal thought... If I am wrong, please
> > kindly point out...
> > 
> > As you can see, this is a new prefixed string binary search algorithm
> > which can provide similar performance with hashed approach (but no
> > need to store hash value at all), so I really care about its lookup
> > performance.
> > 
> > There is something needing to be concerned, is, whether namei() should
> > report any potential on-disk issues or just return -ENOENT for these
> > corrupted dirs, I think I tend to use the latter one.
> 
> -ENOENT is okay for corrupted directories, as long as corrupted
> directories do not cause some kind of security bugs (memory
> corruption, crashes, ...)

Yes, I am certain that it will return -ENOENT for such corrupted
directories and it will certainly not crash the kernel as well.

I have fuzzed it for several months and it seems fine after
commit 419d6efc50e9 ("staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()")

Don't worry about that :)

Thanks,
Gao Xiang

> 
> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


