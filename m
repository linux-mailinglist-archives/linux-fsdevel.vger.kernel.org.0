Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1E2EF954
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 21:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbhAHUgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 15:36:24 -0500
Received: from casper.infradead.org ([90.155.50.34]:50312 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbhAHUgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0BDgIONn6TjjQMsa9yNHOZnzgJZxqty6jQ95csWbZak=; b=VqtzpDEUiHiNIlsNu1O/yx6KxX
        LbBd4nXTprs9jRxCfiLT8qrfTU68eKVlHiCFzq3vgfnIntYgs9WeDxbYsFpYFzp0TYe1z/UrbyqnX
        Z+gprP/3UA3U+ecTAdgGFDt+6i/tGrbEzWXSu3VHz+sIZHQGE8S00RLosjrGr3KyKHbJeRL8kYZ1E
        v53WctRMSqqioV0Vp+ylJrjmE1x19psmquRxI3q+noZne4ZljZHRSqcweQd5i3S+lPqkoH3ZN+lf+
        ovW9vu3XH/DUFguJG2ZgT6hIJS8d2VvA7jxwPdBG2YtE4jjL13TWA+qgbZ/1XObAeenKM4TNPvlJx
        VEfhfjXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kxWwf-000A25-U4; Thu, 07 Jan 2021 15:12:09 +0000
Date:   Thu, 7 Jan 2021 15:11:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Expense of read_iter
Message-ID: <20210107151125.GB5270@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 08:15:41AM -0500, Mikulas Patocka wrote:
> I'd like to ask about this piece of code in __kernel_read:
> 	if (unlikely(!file->f_op->read_iter || file->f_op->read))
> 		return warn_unsupported...
> and __kernel_write:
> 	if (unlikely(!file->f_op->write_iter || file->f_op->write))
> 		return warn_unsupported...
> 
> - It exits with an error if both read_iter and read or write_iter and 
> write are present.
> 
> I found out that on NVFS, reading a file with the read method has 10% 
> better performance than the read_iter method. The benchmark just reads the 
> same 4k page over and over again - and the cost of creating and parsing 
> the kiocb and iov_iter structures is just that high.

Which part of it is so expensive?  Is it worth, eg adding an iov_iter
type that points to a single buffer instead of a single-member iov?

+++ b/include/linux/uio.h
@@ -19,6 +19,7 @@ struct kvec {
 
 enum iter_type {
        /* iter types */
+       ITER_UBUF = 2,
        ITER_IOVEC = 4,
        ITER_KVEC = 8,
        ITER_BVEC = 16,
@@ -36,6 +36,7 @@ struct iov_iter {
        size_t iov_offset;
        size_t count;
        union {
+               void __user *buf;
                const struct iovec *iov;
                const struct kvec *kvec;
                const struct bio_vec *bvec;

and then doing all the appropriate changes to make that work.
