Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993556119FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 20:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJ1SPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 14:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJ1SPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:15:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501121DF433;
        Fri, 28 Oct 2022 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZlI2chvRYb2y9PurSe5IwUlJzWP/UEWczmRM1gvoFUQ=; b=JGUnpCk9FYA0l0ezvRgHDZ2hy4
        2tNXDVQ5LJZwSEV0qCn1nBnxmC3h9Z61+miYSFLoSIPLczoznJ1LUg+uJOmzqoLtY6M3cFIbjOZMn
        La7gL6YJRrzJAaK4ZQkTDbPIE7lozSx/gPnZYnfDuZalpOc3HODFTbx+pj4YyTJuZV7BNg6g/h1/n
        2ny91/mPyWrcjLh1RotU3CEjNv/XWH+p4s/ebsflwNTDraZybo5JWRXP8ymQnBBiyDDVQySfGF8F6
        WyG1yvYffLjK7ysxrtS+gcPfzbHqgxvl+oqWcPy/pea+lRg3IyCzQsMfMasytbkQZl+5Tjol2pMWi
        ht7frLtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooTtN-001RbN-61; Fri, 28 Oct 2022 18:15:41 +0000
Date:   Fri, 28 Oct 2022 19:15:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y1wcTUxlo5zinsg3@casper.infradead.org>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <Y1wK3x7IketHl+DQ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wK3x7IketHl+DQ@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:01:19AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> > Performance testing of below fio workload reveals ~16x performance
> > improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> > FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> > 
> > <test_randwrite.fio>
> > [global]
> > 	ioengine=psync
> > 	rw=randwrite
> > 	overwrite=1
> > 	pre_read=1
> > 	direct=0
> > 	bs=4k
> > 	size=1G
> > 	dir=./
> > 	numjobs=8
> > 	fdatasync=1
> > 	runtime=60
> > 	iodepth=64
> > 	group_reporting=1
>
> Admittedly I'm not thrilled at the reintroduction of page and iop dirty
> state that are updated in separate places, but OTOH the write
> amplification here is demonstrably horrifying as you point out so it's
> clearly necessary.

Well, *something* is necessary.  I worked on a different approach that
would have similar effects for this exact workload, which was to submit
the I/O for O_SYNC while we still know which part of the page we
dirtied.

Previous discussion:
https://lore.kernel.org/all/YQlgjh2R8OzJkFoB@casper.infradead.org/

Actual patches:
https://lore.kernel.org/all/20220503064008.3682332-1-willy@infradead.org/
