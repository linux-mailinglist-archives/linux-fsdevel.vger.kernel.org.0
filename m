Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C3B2F3919
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392272AbhALSof (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 13:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbhALSoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:44:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA3C061575;
        Tue, 12 Jan 2021 10:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ouV8q9+PTUftcxRx8suqz3Pt46rr9u55Qwc5eoB9EWs=; b=a9dsEmwcFBYk5KRd9MJAYDC+L7
        kBhJ/E8w/SrixuwI3x8Q6AzWMA97H4rS7B7Vx5Bqv+RdBP5W5BB+2w2Ti0pVGVeARU2HoOK9o8HtL
        rPOnLEMTPIa+mvC0l0dzhX0JO9V6uhFsb9zSLwUH2An7Gi4rAcfzVwLADxbbVEszGkO+INTmu4EWU
        /n/gRDU3VhIks8huG8Ji5mzSdu2a7ln2WZhw5J3voZWL/clq01ND2FaXGnedzQf+tj3HbYsfqvP5z
        6sXxTQXAgTe9nTEu9j4StkGpFZAThX496OlhESHYBwPKg1btB99j/GWBRlweul51W8nNYd2NYfGtg
        NkKi5Lnw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzOdn-005CNS-OA; Tue, 12 Jan 2021 18:43:44 +0000
Date:   Tue, 12 Jan 2021 18:43:39 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        Andres Freund <andres@anarazel.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210112184339.GA1238746@infradead.org>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
 <20210112181600.GA1228497@infradead.org>
 <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:39:58AM -0700, Andreas Dilger wrote:
> > XFS already has a XFS_IOC_ALLOCSP64 that is defined to actually
> > allocate written extents.  It does not currently use
> > blkdev_issue_zeroout, but could be changed pretty trivially to do so.
> > 
> >> But note it will need to be plumbed down to md and dm to be generally
> >> useful.
> > 
> > DM and MD already support mddev_check_write_zeroes, at least for the
> > usual targets.
> 
> Similarly, ext4 also has EXT4_GET_BLOCKS_CREATE_ZERO that can allocate zero
> filled extents rather than unwritten extents (without clobbering existing
> data like FALLOC_FL_ZERO_RANGE does), and just needs a flag from fallocate()
> to trigger it.  This is plumbed down to blkdev_issue_zeroout() as well.

XFS_IOC_ALLOCSP64 actually is an ioctl that has been around since 1995
on IRIX (as an fcntl).
