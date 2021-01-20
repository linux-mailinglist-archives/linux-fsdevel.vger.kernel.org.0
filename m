Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40B2FD73B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 18:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbhATRew (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 12:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731826AbhATRaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:30:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F4C0613C1;
        Wed, 20 Jan 2021 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nSCkCp7YbB4uesa+BF93Kdx2zRiFf+kQ6K3+ROxstYk=; b=PjwfNj17vL8C+/os7kashumdUO
        xfy8+dT1bMxbszF7XBJrgqBjxjICa1Z2VAsW8RQnKvhD74uBVtJPW/HqmuPin+ctk+Jral4+qESit
        kzXk1voEnafeYgpPyAvxfbK95iGBLt2mAZ0mY4S37VMAXfB21bGCJscMV8YLwsiXqWHd0kCXUrKf1
        LWcnZlr6uYQlbK2l0QBZ4y2cy87mv5oYBnrUiyWuuQiDSHLCWzxHfM04Py85MEXa+fA4jLyYom42z
        BJ5bVov4G4MjZG/wKCy2RYQWQ11PY3Zp6G48XLQPrDqP+DI+F2PEl5EtWUz8e66QEcwFAemU+18Z6
        Ue0FATTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2HHY-00FzDt-Mo; Wed, 20 Jan 2021 17:28:49 +0000
Date:   Wed, 20 Jan 2021 17:28:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: Provide address_space operation for filling
 pages for read
Message-ID: <20210120172836.GA3809508@infradead.org>
References: <20210120160611.26853-1-jack@suse.cz>
 <20210120160611.26853-3-jack@suse.cz>
 <20210120162001.GB3790454@infradead.org>
 <20210120172705.GC24063@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120172705.GC24063@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:27:05PM +0100, Jan Kara wrote:
> This would mean pulling i_mmap_sem out from ext4/XFS/F2FS private inode
> into the VFS inode. Which is fine by me but it would grow struct inode for
> proc / tmpfs / btrfs (although for btrfs I'm not convinced it isn't
> actually prone to the race and doesn't need similar protection as xfs /
> ext4) so some people may object.

The btrfs folks are already looking into lifting it to common code.

Also I have a patch pending to remove a list_head from the inode to
counter the size increase :)
