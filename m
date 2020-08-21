Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7964A24CD82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 08:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHUGBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUGBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:01:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920DC061385;
        Thu, 20 Aug 2020 23:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pMtaQn3ay+ptYcRtyTRCbYkpEwBnxB9UnKg+LUEYRH8=; b=IyN+5kWgoiB0LUFfan3Y0ec/RA
        PfrKZVDCY+Ia1MFgZE4U/08qG0GYXfJaQ/VCn9eDJnM8Fpe+AAe4D+E206rzvBU0TCElQBDoZB5PO
        ZYIeUX0M08LkEw+xnpc8B5FZB7ExH68BaD/fjyG/A9c0qpCgha/XyAAA+Oj5lCXUkIiwJEEc6nuFL
        Y6wgGdIYNXVWXgyoyIXxdfU5zHiiZzmsD4HSsNaOsXhVm5roDk57qbZREn5B2k3azZQKfJ8jqcgjC
        8CZDq3y217y1KELbmiXvNF+Yr9g/6QzjvAYkh/VYPjjfP/Gp6muiD1XiXiGX45PXCN5t+B//lyObM
        4hYnP27g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k907P-0008PR-Gh; Fri, 21 Aug 2020 06:01:39 +0000
Date:   Fri, 21 Aug 2020 07:01:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, riteshh@linux.ibm.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200821060139.GB31091@infradead.org>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820231140.GE7941@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:11:40AM +1000, Dave Chinner wrote:
> On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
> > From: Ritesh Harjani <riteshh@linux.ibm.com>
> > 
> > __bio_try_merge_page() may return same_page = 1 and merged = 0. 
> > This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 
> 
> Ummm, silly question, but exactly how are we getting a bio that
> large in ->writepages getting built? Even with 64kB pages, that's a
> bio with 2^16 pages attached to it. We shouldn't be building single
> bios in writeback that large - what storage hardware is allowing
> such huge bios to be built? (i.e. can you dump all the values in
> /sys/block/<dev>/queue/* for that device for us?)

NVMe controller should not have a problem with such huge I/O,
especially if they support SGLs (extent based I/O :)) instead of the
default dumb PRP scheme.  Higher end SCSI controller should also have
huge limits.
