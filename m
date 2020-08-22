Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0819624E794
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHVNNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Aug 2020 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHVNNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Aug 2020 09:13:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9912C061573;
        Sat, 22 Aug 2020 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W7icbdrjXIMjEIuPepc0EKhRXc/76Hvc8/WClwhuPEY=; b=iTfHddlfukLpE8OPjam/73lwat
        Co5qhCkH1ok53KdJjF15cQ+6VVRx2sX8go2p8vEZAJVXb7nmdctqb/wcJBZ3ECDpeyBbByBFiDfFk
        ibnHWaKau2hb5v2Bbs4Ty8c3/k/SLWdQijHR4hzrSaFd6CYe9udAad3XhRJoxOTj/TfTqz/fLzInQ
        e2pmszP0jSl4eSoRujZzznOd8aupwNj6WyTtbkhZh14Am1hZKzl1FAjNOsDC16b021I6ukuFfalmp
        3uFUVbo01VL91mhXWHtjjIDa51Kt3Bj1M9YRb0VmGG0dePYDNXR6mWtIoyg8PThBtxMfG+cT8yj22
        ZmtmDXTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9TKa-0004jA-Ez; Sat, 22 Aug 2020 13:13:12 +0000
Date:   Sat, 22 Aug 2020 14:13:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200822131312.GA17997@infradead.org>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821215358.GG7941@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 22, 2020 at 07:53:58AM +1000, Dave Chinner wrote:
> but iomap only allows BIO_MAX_PAGES when creating the bio. And:
> 
> #define BIO_MAX_PAGES 256
> 
> So even on a 64k page machine, we should not be building a bio with
> more than 16MB of data in it. So how are we getting 4GB of data into
> it?

BIO_MAX_PAGES is the number of bio_vecs in the bio, it has no
direct implication on the size, as each entry can fit up to UINT_MAX
bytes.
