Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372863D09B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 09:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhGUGsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 02:48:53 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59771 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234659AbhGUGsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:48:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgVICqi_1626852531;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgVICqi_1626852531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Jul 2021 15:28:52 +0800
Date:   Wed, 21 Jul 2021 15:28:51 +0800
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
Message-ID: <YPfMs2OxIwFb8QW8@B-P7TQMD6M-0146.local>
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
 <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
 <CAHpGcMJg5TOhexLdN8HgGoFhB8kbn1FdAD8Z2XEK9C7oHptFwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJg5TOhexLdN8HgGoFhB8kbn1FdAD8Z2XEK9C7oHptFwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 08:43:00AM +0200, Andreas Grünbacher wrote:
> Am Mi., 21. Juli 2021 um 04:54 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
> > Hi Andreas,
> >
> > On Wed, Jul 21, 2021 at 04:26:47AM +0200, Andreas Grünbacher wrote:
> > > Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
> > > <hsiangkao@linux.alibaba.com>:
> > > > > And since you can only kmap one page at a time, an inline read grabs the
> > > > > first part of the data in "page one" and then we have to call
> > > > > iomap_begin a second time get a new address so that we can read the rest
> > > > > from "page two"?
> > > >
> > > > Nope, currently EROFS inline data won't cross page like this.
> > > >
> > > > But in principle, yes, I don't want to limit it to the current
> > > > EROFS or gfs2 usage. I think we could make this iomap function
> > > > more generally (I mean, I'd like to make the INLINE extent
> > > > functionity as general as possible,
> > >
> > > Nono. Can we please limit this patch what we actually need right now,
> > > and worry about extending it later?
> >
> > Can you elaborate what it will benefit us if we only support one tail
> > block for iomap_read_inline_data()? (I mean it has similar LOC changes,
> > similar implementation / complexity.) The only concern I think is if
> > it causes gfs2 regression, so that is what I'd like to confirm.
> 
> iomap_read_inline_data supports one inline page now (i.e., from the
> beginning of the file). It seems that you don't need more than one
> tail page in EROFS, right?
> 
> You were speculating about inline data in the middle of a file. That
> sounds like a really, really bad idea to me, and I don't think we
> should waste any time on it.

Huh? why do you think it's a bad idea? I could give real example to you.

At least, it can be used for some encoded data or repeated pattern (such
as AABBAABBAABB...) in a packed way (marked in extent metadata).
Is that enough?

Again, I don't see what the benefits if limiting it to one tail block,
it (maybe) just modifies:
+	/* handle tail-packing blocks cross the current page into the next */
+	size = min_t(unsigned int, iomap->length + pos - iomap->offset,
+		     PAGE_SIZE - poff);

to
+	size = min_t(unsigned int, i_blocksize(inode),
+		     PAGE_SIZE - poff);

And which has the similar complexity, so why not using iomap->length
here instead?

Thanks,
Gao Xiang
