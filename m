Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FE2F1895
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbhAKOpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbhAKOpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:45:07 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA47C061794;
        Mon, 11 Jan 2021 06:44:26 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kyyQ1-009I2g-Bx; Mon, 11 Jan 2021 14:43:41 +0000
Date:   Mon, 11 Jan 2021 14:43:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Mikulas Patocka' <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [RFC v2] nvfs: a filesystem for persistent memory
Message-ID: <20210111144341.GZ3579531@ZenIV.linux.org.uk>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110162008.GV3579531@ZenIV.linux.org.uk>
 <c26db2b0ea1a4891a7cbd0363de856d3@AcuMS.aculab.com>
 <alpine.LRH.2.02.2101110641490.4356@file01.intranet.prod.int.rdu2.redhat.com>
 <57dad96341d34822a7943242c9bcad71@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57dad96341d34822a7943242c9bcad71@AcuMS.aculab.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:57:08AM +0000, David Laight wrote:
> > > > 		size = copy_to_iter(to, ptr, size);
> > > > 		if (unlikely(!size)) {
> > > > 			r = -EFAULT;
> > > > 			goto ret_r;
> > > > 		}
> > > >
> > > > 		pos += size;
> > > > 		total += size;
> > > > 	} while (iov_iter_count(to));
> > >
> > > That isn't the best formed loop!
> > >
> > > 	David
> > 
> > I removed the second "while" statement and fixed the arguments to
> > copy_to_iter - other than that, Al's function works.
> 
> The extra while is easy to write and can be difficult to spot.
> I've found them looking as the object code before now!

	That extra while comes from editing cut'n'pasted piece of
source while writing a reply.  Hint: original had been a do-while.

> Oh - the error return for copy_to_iter() is wrong.
> It should (probably) return 'total' if it is nonzero.

	copy_to_iter() call there has an obvious problem
(arguments in the wrong order), but return value is handled
correctly.  It does not do a blind return -EFAULT.  RTFS...
