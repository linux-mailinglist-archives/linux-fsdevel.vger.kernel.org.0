Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042413EB095
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 08:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhHMGth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 02:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbhHMGtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:49:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A27AC061756;
        Thu, 12 Aug 2021 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:References;
        bh=QntW9YkTv8ZU+uI5wcn3XbzryXxg0k6b6Hd1UlmKabk=; b=HZrWsXiYdFlwx1mYTQhQNlYurB
        KLZ9rty2Rqu8riDncRkbwbavggeU7m/Pd3s66nKjKl68tvuSCQTzUFMUhdkjV3etGWsBA1ZiFv5xQ
        /PHLmJ+QVWkxOK5ndEDEyw2ZO/Ob6BCEkfNL+AY5v2DcvdB2t+F7lojW2f3AepSPrXvfC/XNWBriu
        Et6rACAtu5BXspJ8Q4DOjxIEpJ7r099XND2EYKRIHis/NFSvpowBSzHqA2x9+JQHiUZp+g50Q0sXQ
        HMeR7XBWw4fKt+0cLG09o20uZHf4rId4K3XONkL7SWkazQb7ESWWH5+G7m7W0deJiq6GE51xc3w5j
        T8yT8kVA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEQyo-00FPlo-Em; Fri, 13 Aug 2021 06:47:58 +0000
Date:   Fri, 13 Aug 2021 07:47:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, sfrench@samba.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Testing swap
Message-ID: <YRYVktE3RpRR2bOm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRUgDfwHNrcL47xu@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 02:20:13PM +0100, Matthew Wilcox wrote:
> All the current xfstests for swap only test setting up a swap partition,
> not actually doing swap to it.  That's why this bug went unnoticed for
> two years and why Steve French is still under the impression that
> swap-over-CIFS works (it doesn't).  Could somebody adapt Dave's test
> into the xfstests framework?

Dave, can you just submit your test to xfstests?

> ----- Forwarded message from David Howells <dhowells@redhat.com> -----
> 
> Date: Thu, 12 Aug 2021 12:57:50 +0100
> From: David Howells <dhowells@redhat.com>
> To: willy@infradead.org
> Cc: dhowells@redhat.com, trond.myklebust@primarydata.com,
> 	darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
> 	sfrench@samba.org, torvalds@linux-foundation.org,
> 	linux-nfs@vger.kernel.org, linux-mm@kvack.org,
> 	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] nfs: Fix write to swapfile failure due to
> 	generic_write_checks()
> User-Agent: StGit/0.23
> 
> Trying to use a swapfile on NFS results in every DIO write failing with
> ETXTBSY because generic_write_checks(), as called by nfs_direct_write()
> from nfs_direct_IO(), forbids writes to swapfiles.
> 
> Fix this by introducing a new kiocb flag, IOCB_SWAP, that's set by the swap
> code to indicate that the swapper is doing this operation and so overrule
> the check in generic_write_checks().
> 
> Without this patch, the following is seen:
> 
> 	Write error on dio swapfile (3800334336)
> 
> Altering __swap_writepage() to show the error shows:
> 
> 	Write error (-26) on dio swapfile (3800334336)
> 
> Tested by swapping off all swap partitions and then swapping on a prepared
> NFS file (CONFIG_NFS_SWAP=y is also needed).  Enough copies of the
> following program then need to be run to force swapping to occur (at least
> one per gigabyte of RAM):
> 
> 	#include <stdbool.h>
> 	#include <stdio.h>
> 	#include <stdlib.h>
> 	#include <unistd.h>
> 	#include <sys/mman.h>
> 	int main()
> 	{
> 		unsigned int pid = getpid(), iterations = 0;
> 		size_t i, j, size = 1024 * 1024 * 1024;
> 		char *p;
> 		bool mismatch;
> 		p = malloc(size);
> 		if (!p) {
> 			perror("malloc");
> 			exit(1);
> 		}
> 		srand(pid);
> 		for (i = 0; i < size; i += 4)
> 			*(unsigned int *)(p + i) = rand();
> 		do {
> 			for (j = 0; j < 16; j++) {
> 				for (i = 0; i < size; i += 4096)
> 					*(unsigned int *)(p + i) += 1;
> 				iterations++;
> 			}
> 			mismatch = false;
> 			srand(pid);
> 			for (i = 0; i < size; i += 4) {
> 				unsigned int r = rand();
> 				unsigned int v = *(unsigned int *)(p + i);
> 				if (i % 4096 == 0)
> 					v -= iterations;
> 				if (v != r) {
> 					fprintf(stderr, "mismatch %zx: %x != %x (diff %x)\n",
> 						i, v, r, v - r);
> 					mismatch = true;
> 				}
> 			}
> 		} while (!mismatch);
> 		exit(1);
> 	}
> 
> ----- End forwarded message -----
---end quoted text---
