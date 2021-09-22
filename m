Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41617415031
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhIVSzY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 14:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhIVSzY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:55:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBA3C61214;
        Wed, 22 Sep 2021 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632336834;
        bh=YjHMExL18UDt48gcGEkddnz6sCij7zwLcxGU2WC74Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/o7vgPcAV93kv1dVidJaSs1JcWg+oI4FktJo9EiYMmrXO9HwPlej7+sw6olTCa3u
         mjP9iRoN4jpCjwSmrQyJj4/NcHdsuw4chPWUQtiFG/PVBKsYErCpInpYiNmvHO76lU
         4prMsMXXQU3JZ8/4SeYO4WriWSFKd2slSN1pj5Ltjq5gAZywHHl4WCJqpDA8k7q7Mj
         XpK2LiY5zFDNhlZLhvlF+6i8U9mrjOHKLfLppa1BZZmFYMrKyELMSX+m2a9u9vTmyQ
         hvAUXwSFmOvMhX0D2UPIWFZWmJLyelkY4tXHNjLDHEHbqj0tqILHpr/EsXchVf62pA
         B7Skc87Ry2ODQ==
Date:   Wed, 22 Sep 2021 11:53:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: use accelerated zeroing on a block device to
 zero a file range
Message-ID: <20210922185353.GK570615@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865577.417973.11122330974455662098.stgit@magnolia>
 <YUmX5VD7zOtWtBo8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUmX5VD7zOtWtBo8@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:29:25AM +0100, Christoph Hellwig wrote:
> On Fri, Sep 17, 2021 at 06:30:55PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a function that ensures that the storage backing part of a file
> > contains zeroes and will not trip over old media errors if the contents
> > are re-read.
> 
> I don't think this has anything to do with direct I/O, so I'd rather
> not have it clutter direct-io.c.  Also do we really want to wait
> synchronously for every bio instead of batching them up?  Especially
> as a simple bio_chain is probably all that is needed.

__blkdev_issue_zeroout looks appropriate for chaining.  I'll move the
zeroout routine into a new lowlevel.c file, since this isn't buffered io
either.

--D
