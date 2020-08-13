Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304F2433B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 07:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgHMFo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 01:44:26 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:37826 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgHMFo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:44:26 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id B48491A951B;
        Thu, 13 Aug 2020 15:44:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k662E-0001gE-Lg; Thu, 13 Aug 2020 15:44:18 +1000
Date:   Thu, 13 Aug 2020 15:44:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, khlebnikov@yandex-team.ru
Subject: Re: WARN_ON_ONCE(1) in iomap_dio_actor()
Message-ID: <20200813054418.GB3339@dread.disaster.area>
References: <20200619211750.GA1027@lca.pw>
 <20200620001747.GC8681@bombadil.infradead.org>
 <20200724182431.GA4871@lca.pw>
 <20200726152412.GA26614@infradead.org>
 <20200811020302.GD5307@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811020302.GD5307@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=F2pTjGBfAAAA:20 a=7-415B0cAAAA:8
        a=_eiJewZb4kaZAsKqs4MA:9 a=4YkHEp-ugCOE0eHm:21 a=rzLbzqL5k24iaUm9:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:03:03PM -0400, Qian Cai wrote:
> On Sun, Jul 26, 2020 at 04:24:12PM +0100, Christoph Hellwig wrote:
> > On Fri, Jul 24, 2020 at 02:24:32PM -0400, Qian Cai wrote:
> > > On Fri, Jun 19, 2020 at 05:17:47PM -0700, Matthew Wilcox wrote:
> > > > On Fri, Jun 19, 2020 at 05:17:50PM -0400, Qian Cai wrote:
> > > > > Running a syscall fuzzer by a normal user could trigger this,
> > > > > 
> > > > > [55649.329999][T515839] WARNING: CPU: 6 PID: 515839 at fs/iomap/direct-io.c:391 iomap_dio_actor+0x29c/0x420
> > > > ...
> > > > > 371 static loff_t
> > > > > 372 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
> > > > > 373                 void *data, struct iomap *iomap, struct iomap *srcmap)
> > > > > 374 {
> > > > > 375         struct iomap_dio *dio = data;
> > > > > 376
> > > > > 377         switch (iomap->type) {
> > > > > 378         case IOMAP_HOLE:
> > > > > 379                 if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
> > > > > 380                         return -EIO;
> > > > > 381                 return iomap_dio_hole_actor(length, dio);
> > > > > 382         case IOMAP_UNWRITTEN:
> > > > > 383                 if (!(dio->flags & IOMAP_DIO_WRITE))
> > > > > 384                         return iomap_dio_hole_actor(length, dio);
> > > > > 385                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > > > 386         case IOMAP_MAPPED:
> > > > > 387                 return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
> > > > > 388         case IOMAP_INLINE:
> > > > > 389                 return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
> > > > > 390         default:
> > > > > 391                 WARN_ON_ONCE(1);
> > > > > 392                 return -EIO;
> > > > > 393         }
> > > > > 394 }
> > > > > 
> > > > > Could that be iomap->type == IOMAP_DELALLOC ? Looking throught the logs,
> > > > > it contains a few pread64() calls until this happens,
> > > > 
> > > > It _shouldn't_ be able to happen.  XFS writes back ranges which exist
> > > > in the page cache upon seeing an O_DIRECT I/O.  So it's not supposed to
> > > > be possible for there to be an extent which is waiting for the contents
> > > > of the page cache to be written back.
> > > 
> > > Okay, it is IOMAP_DELALLOC. We have,
> > 
> > Can you share the fuzzer?  If we end up with delalloc space here we
> > probably need to fix a bug in the cache invalidation code.
> 
> Here is a simple reproducer (I believe it can also be reproduced using xfstests
> generic/503 on a plain xfs without DAX when SCRATCH_MNT == TEST_DIR),
> 
> # git clone https://gitlab.com/cailca/linux-mm
> # cd linux-mm; make
> # ./random 14

Ok:

file.fd_write = safe_open("./testfile", O_RDWR|O_CREAT);
....
file.fd_read = safe_open("./testfile", O_RDWR|O_CREAT|O_DIRECT);
....
file.ptr = safe_mmap(NULL, fsize, PROT_READ|PROT_WRITE, MAP_SHARED,
			file.fd_write, 0);

So this is all IO to the same inode....

and you loop

while !done {

	do {
		rc = pread(file.fd_read, file.ptr + read, fsize - read,
			read);
		if (rc > 0)
			read += rc;
	} while (rc > 0);

	rc = safe_fallocate(file.fd_write,
			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
			0, fsize);
}

On two threads at once?

So, essentially, you do a DIO read into a mmap()d range from the
same file, with DIO read ascending and the mmap() range descending,
then once that is done you hole punch the file and do it again?

IOWs, this is a racing page_mkwrite()/DIO read workload, and the
moment the two threads hit the same block of the file with a
DIO read and a page_mkwrite at the same time, it throws a warning.

Well, that's completely expected behaviour. DIO is not serialised
against mmap() access at all, and so if the page_mkwrite occurs
between the writeback and the iomap_apply() call in the dio path,
then it will see the delalloc block taht the page-mkwrite allocated.

No sane application would ever do this, it's behaviour as expected,
so I don't think there's anything to care about here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
