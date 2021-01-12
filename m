Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1F2F385A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406134AbhALSRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 13:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390926AbhALSRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:17:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B9C0617B1;
        Tue, 12 Jan 2021 10:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9NZJmYiv3WvaLd4DekuUPhNFoe24SSZqwwyXq3L2EsE=; b=XEMEqV6SQPKTYXhyC7rWE0dTYx
        EyaCqPCtJinetgHQJ5FwZJd+9k7uHqGzbYMGURYfgC9sdoWFWX5lBbosqX9t1NNaQZHuyz6b5mj+n
        H6gwP83sjvqt1tgakFIPS6FfStjbOV21iBSCL1WwEJozn42dbIv05QSFuDusj8z6xz+OCDMSWh0wl
        wiej+sOKoAfNQoMhmmA6onM7CuJ3zM9hP5a/i/I4bB7H6TwazCqQLDHtSC/8dmtSMMzq3ChfS/sdM
        M6T4shIq6yV+/ey6IE4/t83CG/UAeS2c4/PKyo1pVgsC+ninMbpwnEUZb++z91rqzWNhYhqiSwauZ
        lBz7zrLg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzOD2-005AMI-M8; Tue, 12 Jan 2021 18:16:04 +0000
Date:   Tue, 12 Jan 2021 18:16:00 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Avi Kivity <avi@scylladb.com>
Cc:     Andres Freund <andres@anarazel.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210112181600.GA1228497@infradead.org>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 09:57:48PM +0200, Avi Kivity wrote:
> > I don't have a strong opinion on it. A complex userland application can
> > do a bit better job managing queue depth etc, but otherwise I suspect
> > doing the IO from kernel will win by a small bit. And the queue-depth
> > issue presumably would be relevant for write-zeroes as well, making me
> > lean towards just using the fallback.
> > 
> 
> The new flag will avoid requiring DMA to transfer the entire file size, and
> perhaps can be implemented in the device by just adjusting metadata. So
> there is potential for the new flag to be much more efficient.

We already support a WRITE_ZEROES operation, which many (but not all)
NVMe devices and some SCSI devices support.  The blkdev_issue_zeroout
helper can use those, or falls back to writing actual zeroes.

XFS already has a XFS_IOC_ALLOCSP64 that is defined to actually
allocate written extents.  It does not currently use
blkdev_issue_zeroout, but could be changed pretty trivially to do so.

> But note it will need to be plumbed down to md and dm to be generally
> useful.

DM and MD already support mddev_check_write_zeroes, at least for the
usual targets.
