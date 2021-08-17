Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED35C3EE75F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhHQHkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhHQHke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:40:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A8C061764;
        Tue, 17 Aug 2021 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KfwRHnjdRbP4ZHi0hu2qspn9wFiV5cDDqAzN3MYU9kM=; b=SJPzEtocr0pIyrOVpbBEsBp8qI
        UixtMAUf3iIYsy0aweKkYfYkBRRq/A3D6nFp4Kd8BzsZkXeIcyHjmkEkbiMbhrRykONGWqiLrSM8Y
        OWJRflRlD/9sUK00IZKiRi2QphFWnhKC7a9p/DTD1d7gSsG9UC+vvTqAi99gyBbfzzYi8ULvur4zY
        wzIYtzcVDvtjYpi6UTU7vMw6TXpHZJt2+1vm7IBWdKv4LZJ1kuihn82+U5Mj/ZzmTqP5MHwQXqC3Q
        L8B26cTMtv7wobahqGrOrlhj9uss5XFm1QS/5mROkvGgoBeiL2D4efC7oTo3JnK2zULMlZdP1toz4
        ft7/S0uQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFtga-002GQZ-F3; Tue, 17 Aug 2021 07:39:12 +0000
Date:   Tue, 17 Aug 2021 08:39:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, jane.chu@oracle.com,
        willy@infradead.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sandeen@sandeen.net
Subject: Re: [PATCHSET 0/2] dax: fix broken pmem poison narrative
Message-ID: <YRtnlPERHfMZ23Tr@infradead.org>
References: <162914791879.197065.12619905059952917229.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162914791879.197065.12619905059952917229.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:05:18PM -0700, Darrick J. Wong wrote:
> AFAICT, the only reason why the "punch and write" dance works at all is
> that the XFS and ext4 currently call blkdev_issue_zeroout when
> allocating pmem as part of a pwrite call.  A pwrite without the punch
> won't clear the poison, because pwrite on a DAX file calls
> dax_direct_access to access the memory directly, and dax_direct_access
> is only smart enough to bail out on poisoned pmem.  It does not know how
> to clear it.  Userspace could solve the problem by calling FIEMAP and
> issuing a BLKZEROOUT, but that requires rawio capabilities.
> 
> The whole pmem poison recovery story is is wrong and needs to be
> corrected ASAP before everyone else starts doing this.  Therefore,
> create a dax_zeroinit_range function that filesystems can call to reset
> the contents of the pmem to a known value and clear any state associated
> with the media error.  Then, connect FALLOC_FL_ZERO_RANGE to this new
> function (for DAX files) so that unprivileged userspace has a safe way
> to reset the pmem and clear media errors.

I agree with the problem statement, but I don't think the fix is
significantly better than what we have, as it still magically overloads
other behavior.  I'd rather have an explicit operation to clear the
poison both at the syscall level (maybe another falloc mode), and the
internal kernel API level (new method in dax_operations).

Also for the next iteration please split the iomap changes from the
usage in xfs.
