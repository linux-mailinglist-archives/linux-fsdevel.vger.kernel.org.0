Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD826D5C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 10:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIQIIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 04:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgIQIGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:06:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EA6C061756;
        Thu, 17 Sep 2020 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lZgl1cIMN7+DBJKNz3wSb8COgVIR6YozfdX3tuODUOg=; b=BRAMO6phbmsLLmlUPGW2ypxOzy
        B2pTmY7ToP8X4oer6pk8fWW4WJHDB8FJE7wQTh934hJpnaBYGSx9L8bOsZ6gOJImuMFkmn/8ATeR5
        cDE8Xv6ZwRBN+WNAuyZipd4qpJncjr5xegrovLr12RBIluj4srVVym60qaiaclSA6GQ9MajHnmUpU
        72dum/t/XeKM6FLV62FXSiY2JE21w0C+P4yW8tQX6kk0Rg5wNgwezUiFEe5J3jSLrTuJfZMyuqfvv
        Y3sIjy0nbzcXoZUQmhyCoo6KwbRgTZt58b/F74gJrR1Aob+kcKgHSd/vZVRTeC3iqMuU9lS9PdZo/
        mVHD0VKA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIouV-0007yk-R9; Thu, 17 Sep 2020 08:04:55 +0000
Date:   Thu, 17 Sep 2020 09:04:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200917080455.GY26262@infradead.org>
References: <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
 <20200825144917.GA321765@bfoster>
 <20200916001242.GE7955@magnolia>
 <20200916084510.GA30815@infradead.org>
 <20200916130714.GA1681377@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916130714.GA1681377@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:07:14AM -0400, Brian Foster wrote:
> Dave described the main purpose earlier in this thread [1]. The initial
> motivation is that we've had downstream reports of soft lockup problems
> in writeback bio completion down in the bio -> bvec loop of
> iomap_finish_ioend() that has to finish writeback on each individual
> page of insanely large bios and/or chains. We've also had an upstream
> reports of a similar problem on linux-xfs [2].
> 
> The magic number itself was just pulled out of a hat. I picked it
> because it seemed conservative enough to still allow large contiguous
> bios (1GB w/ 4k pages) while hopefully preventing I/O completion
> problems, but was hoping for some feedback on that bit if the general
> approach was acceptable. I was also waiting for some feedback on either
> of the two users who reported the problem but I don't think I've heard
> back on that yet...

I think the saner answer is to always run large completions in the
workqueue, and add a bunch of cond_resched() calls, rather than
arbitrarily breaking up the I/O size.
