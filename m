Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEAB8B7F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfHMMG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 08:06:29 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3087 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726935AbfHMMG2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:06:28 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id CF558F30528089ECDCC9;
        Tue, 13 Aug 2019 20:06:26 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 13 Aug 2019 20:06:26 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 13
 Aug 2019 20:06:25 +0800
Date:   Tue, 13 Aug 2019 20:23:32 +0800
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
Message-ID: <20190813122332.GA17429@138>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
 <20190813091326.84652-9-gaoxiang25@huawei.com>
 <20190813114821.GB11559@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190813114821.GB11559@amd>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Pavel,

On Tue, Aug 13, 2019 at 01:48:21PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +	/*
> > +	 * on-disk error, let's only BUG_ON in the debugging mode.
> > +	 * otherwise, it will return 1 to just skip the invalid name
> > +	 * and go on (in consideration of the lookup performance).
> > +	 */
> > +	DBG_BUGON(qd->name > qd->end);
> 
> I believe you should check for errors in non-debug mode, too.

Thanks for your kindly reply!

The following is just my personal thought... If I am wrong, please
kindly point out...

As you can see, this is a new prefixed string binary search algorithm
which can provide similar performance with hashed approach (but no
need to store hash value at all), so I really care about its lookup
performance.

There is something needing to be concerned, is, whether namei() should
report any potential on-disk issues or just return -ENOENT for these
corrupted dirs, I think I tend to use the latter one.

The reason (in my opinion) is if you consider another some another
complicated non-transverse ondisk implementation, it cannot transverse
all the entires so they could/couldn't report all potential issues
in namei() (For such corrupted dir, they can return -ENOENT due
to lack of information of course, just avoiding crashing the kernel
is OK).

Therefore, in my thought, such issue can be reported by fsck-like
tools such as erofs.fsck. And actually readdir() will also report
all issues as well, thus we can have performance gain on lookup.

> 
> 
> > +			if (unlikely(!ndirents)) {
> > +				DBG_BUGON(1);
> > +				kunmap_atomic(de);
> > +				put_page(page);
> > +				page = ERR_PTR(-EIO);
> > +				goto out;
> > +			}
> 
> -EUCLEAN is right error code for corrupted filesystem. (And you
>  probably want to print something to the syslog, too).

Yes, you are right :) -EUCLEAN/EFSCORRUPTED is actually for such thing,
nowadays, EROFS treats all EFSCORRUPTED cases into EIO, and I will
update that in one patch... (Yes, it needs to print something of course :))

Thanks,
Gao Xiang

> 
> 								Pavel
> -- 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


