Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC6B49FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfIQJCk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 05:02:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfIQJCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iqBZEA4YTCWclU3x+SYwFnPkWSOVdw1g4J1I3clqTLE=; b=aVrQFxVba+3Rx3+yG7OtGYsdZ
        n1kze3ps11lG523KPTva5+UDPD/dNFluJsIEavLSEYgmpF0jdbM+/MGI3d6mnZPempVk5AbrbA9Ml
        SHYI6dcEbW16ABJaS2do1FyEhvBan5UNzLy1RCrcIaKQe62HUyUDEJGsIimHy/eVr115DEfCCrl7W
        zGzOC3XMcQoDhCkOXchau7UY8Bsv5DNmYsQlZBWFkRLybCY5E1HEwnD2s1eSusQLPXVZZ2IH4ChZq
        j9NGlDVRR8XECwUDBJo4CuQOZWI7DqtRbE64xAOPFGkhuyGcThX7mRAnaQAasPzHISOY2dK877F8M
        mhVBk4h8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iA9NZ-0000mW-NH; Tue, 17 Sep 2019 09:02:33 +0000
Date:   Tue, 17 Sep 2019 02:02:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190917090233.GB29487@infradead.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
 <20190916223741.GA5936@bobrowski>
 <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:30:15PM +0530, Ritesh Harjani wrote:
> So if we have a delayed buffered write to a file,
> in that case we first only update inode->i_size and update
> i_disksize at writeback time
> (i.e. during block allocation).
> In that case when we call for ext4_dio_write_iter
> since offset + len > i_disksize, we call for ext4_update_i_disksize().
> 
> Now if writeback for some reason failed. And the system crashes, during the
> DIO writes, after the blocks are allocated. Then during reboot we may have
> an inconsistent inode, since we did not add the inode into the
> orphan list before we updated the inode->i_disksize. And journal replay
> may not succeed.
> 
> 1. Can above actually happen? I am still not able to figure out the
>    race/inconsistency completely.
> 2. Can you please help explain under what other cases
>    it was necessary to call ext4_update_i_disksize() in DIO write paths?
> 3. When will i_disksize be out-of-sync with i_size during DIO writes?

None of the above seems new in this patchset, does it?  That being said
I found the early size update odd.  XFS updates the on-disk size only
at I/O completion time to deal with various races including the
potential exposure of stale data.
