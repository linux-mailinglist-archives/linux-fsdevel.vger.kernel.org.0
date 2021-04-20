Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9C365989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhDTNLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTNLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:11:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F91AC06174A;
        Tue, 20 Apr 2021 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5H40PE5FcAXJU/1G1fCYEUxn7MUJo40J/cmcx9Vjp6w=; b=h7rhL0AzG0XZAn3uA00HxKS2gn
        yU+d2LbmMY9S6yr8REVTlnMRYlvIDeu3I0FZ6Fbr0dbFqcgEw1kfzlxhqPs3r0q1/Wy0GiKJkvPrQ
        KkmrZhN6lLJkEXb19wsDdOQb/5FyE8ytcamAsPKaA/vf0512Okjj8ICplUF0ZyxX+d4UwRjcQf1oN
        Soy2Irdjht2QLrSzEWaPJxl2QAPohrp+2A9qxxSKS+xgnpbaq1MD3lsiC15sO8UH/pQtlYAFkP2Nv
        HEqKpzZxzaZ/07LTuqWe6LKVIyfeFc+Mcs+ezAWfEMAY3k/+r2Jgmzg8TXJoDwRbwy5vn2aGbty0t
        larHU3og==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYq7N-00FBfz-7j; Tue, 20 Apr 2021 13:08:59 +0000
Date:   Tue, 20 Apr 2021 14:08:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
Message-ID: <20210420130841.GA3618564@infradead.org>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
 <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:00:48PM +0800, Zhang Yi wrote:
> Now, we use already use "if (bdev->bd_super)" to prevent call into
> ->bdev_try_to_free_page unless the super is alive, and the problem is
> bd_super becomes NULL concurrently after this check. So, IIUC, I think it's
> the same to switch to check the superblock is active or not. The acvive
> flag also could becomes inactive (raced by umount) after we call into
> bdev_try_to_free_page().

Indeed.

> In order to close this race, One solution is introduce a lock to synchronize
> the active state between kill_block_super() and blkdev_releasepage(), but
> the releasing page process have to try to acquire this lock in
> blkdev_releasepage() for each page, and the umount process still need to wait
> until the page release if some one invoke into ->bdev_try_to_free_page().
> I think this solution may affect performace and is not a good way.
> Think about it in depth, use percpu refcount seems have the smallest
> performance effect on blkdev_releasepage().
> 
> If you don't like the refcount, maybe we could add synchronize_rcu_expedited()
> in ext4_put_super(), it also could prevent this race. Any suggestions?

I really don't like to put a lot of overhead into the core VFS and block
device code.  ext4/jbd does not own the block device inode and really
has no business controlling releasepage for it.  I suspect the right
answer might be to simply revert the commit that added this hook.
