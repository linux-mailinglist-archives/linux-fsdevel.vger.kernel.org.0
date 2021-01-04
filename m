Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09452EA01B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 23:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhADWku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 17:40:50 -0500
Received: from sandeen.net ([63.231.237.45]:47872 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbhADWkt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:40:49 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 664FF483534;
        Mon,  4 Jan 2021 16:38:46 -0600 (CST)
To:     Theodore Ts'o <tytso@mit.edu>, Andres Freund <andres@anarazel.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <X/NpsZ8tSPkCwsYE@mit.edu>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <c18d3d32-9504-016a-b7e7-feeddff0cde6@sandeen.net>
Date:   Mon, 4 Jan 2021 16:40:08 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <X/NpsZ8tSPkCwsYE@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/4/21 1:17 PM, Theodore Ts'o wrote:
> On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
>>
>> Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
>> doesn't convert extents into unwritten extents, but instead uses
>> blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
>> myself, but ...
> 
> One thing to note is that there are some devices which support a write
> zeros operation, but where it is *less* performant than actually
> writing zeros via DMA'ing zero pages.  Yes, that's insane.
> Unfortunately, there are a insane devices out there....
> 
> This is not hypothetical; I know this because we tried using write
> zeros in mke2fs, and I got regression complaints where
> mke2fs/mkfs.ext4 got substantially slower for some devices.

Was this "libext2fs: mkfs.ext3 really slow on centos 8.2" ?

If so, wasn't the problem that it went from a few very large IOs to a
multitude of per-block fallocate calls, a problem which was fixed by
this commit?

commit 86d6153417ddaccbe3d1f4466a374716006581f4 (HEAD)
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Apr 25 11:41:24 2020 -0400

    libext2fs: batch calls to ext2fs_zero_blocks2()
    
    When allocating blocks for an indirect block mapped file, accumulate
    blocks to be zero'ed and then call ext2fs_zero_blocks2() to zero them
    in large chunks instead of block by block.
    
    This significantly speeds up mkfs.ext3 since we don't send a large
    number of ZERO_RANGE requests to the kernel, and while the kernel does
    batch write requests, it is not batching ZERO_RANGE requests.  It's
    more efficient to batch in userspace in any case, since it avoids
    unnecessary system calls.
    
    Reported-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>


or do I have the wrong report above?

I ask because mkfs.xfs is now also using FALLOC_FL_ZERO_RANGE

Thanks,
-Eric
