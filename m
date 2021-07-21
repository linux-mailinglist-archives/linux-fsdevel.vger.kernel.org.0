Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0F3D06D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 04:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhGUCNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 22:13:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44349 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhGUCNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 22:13:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgTuycl_1626836038;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgTuycl_1626836038)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Jul 2021 10:53:59 +0800
Date:   Wed, 21 Jul 2021 10:53:58 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
Message-ID: <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia>
 <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local>
 <20210721001720.GS22357@magnolia>
 <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
 <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas,

On Wed, Jul 21, 2021 at 04:26:47AM +0200, Andreas Grünbacher wrote:
> Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
> > > And since you can only kmap one page at a time, an inline read grabs the
> > > first part of the data in "page one" and then we have to call
> > > iomap_begin a second time get a new address so that we can read the rest
> > > from "page two"?
> >
> > Nope, currently EROFS inline data won't cross page like this.
> >
> > But in principle, yes, I don't want to limit it to the current
> > EROFS or gfs2 usage. I think we could make this iomap function
> > more generally (I mean, I'd like to make the INLINE extent
> > functionity as general as possible,
> 
> Nono. Can we please limit this patch what we actually need right now,
> and worry about extending it later?

Can you elaborate what it will benefit us if we only support one tail
block for iomap_read_inline_data()? (I mean it has similar LOC changes,
similar implementation / complexity.) The only concern I think is if
it causes gfs2 regression, so that is what I'd like to confirm.

In contrast, I'd like to avoid iomap_write_begin() tail-packing because
it's complex and no fs user interests in it for now. So I leave it
untouched for now.

Another concern I really like to convert EROFS to iomap is I'd like to
support sub-page blocksize for EROFS after converting. I don't want to
touch iomap inline code again like this since it interacts 2 directories
thus cause too much coupling.

Thanks,
Gao Xiang

> 
> > my v1 original approach
> > in principle can support any inline extent in the middle of
> > file rather than just tail blocks, but zeroing out post-EOF
> > needs another iteration) and I don't see it add more code and
> > complexity.
> 
> Thanks,
> Andreas
