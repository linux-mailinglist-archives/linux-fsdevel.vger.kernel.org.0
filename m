Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66340F9C56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLVcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 16:32:20 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59348 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfKLVcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:32:19 -0500
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 11F763A0B50;
        Wed, 13 Nov 2019 08:32:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iUdlm-0007J1-JO; Wed, 13 Nov 2019 08:32:14 +1100
Date:   Wed, 13 Nov 2019 08:32:14 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, y2038@lists.linaro.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 4/5] xfs: extend inode format for 40-bit timestamps
Message-ID: <20191112213214.GP4614@dread.disaster.area>
References: <20191112120910.1977003-1-arnd@arndb.de>
 <20191112120910.1977003-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112120910.1977003-5-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=R9Rnn_goW3qbCYCF-O0A:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 12, 2019 at 01:09:09PM +0100, Arnd Bergmann wrote:
> XFS is the only major file system that lacks timestamps beyond year 2038,
> and is already being deployed in systems that may have to be supported
> beyond that time.
> 
> Fortunately, the inode format still has a few reserved bits that can be
> used to extend the current format. There are two bits in the nanosecond
> portion that could be used in the same way that ext4 does, extending
> the timestamps until year 2378, as well as 12 unused bytes after the
> already allocated fields.
> 
> There are four timestamps that need to be extended, so using four
> bytes out of the reserved space gets us all the way until year 36676,
> by extending the current 1902-2036 with another 255 epochs, which
> seems to be a reasonable range.
> 
> I am not sure whether this change to the inode format requires a
> new version for the inode. All existing file system images remain
> compatible, while mounting a file systems with extended timestamps
> beyond 2038 would report that timestamp incorrectly in the 1902
> through 2038 range, matching the traditional Linux behavior of
> wrapping timestamps.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is basically what I proposed ~5 years or so ago and posted a
patch to implement it in an early y2038 discussion with you. I jsut
mentioned that very patch in my reposnse to Amir's timestamp
extension patchset, pointing out that this isn't the way we want
to proceed with >y2038 on-disk support.

https://lore.kernel.org/linux-xfs/20191112161242.GA19334@infradead.org/T/#maf6b2719ed561cc2865cc5e7eb82df206b971261

I'd suggest taking the discussion there....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
