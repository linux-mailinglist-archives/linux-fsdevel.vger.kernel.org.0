Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E53646FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbhDSPVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbhDSPVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:21:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5267DC06174A;
        Mon, 19 Apr 2021 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X/GRhw4CJTboxdqe5axLP+hiUSjTXSY9XFf13RBgI1c=; b=jTiqjKQvURfm4KhuPQGjL69O4F
        NJwPCf/+LB2cjDZinfwnIlZ8an9knhV43FzvAEadv1+Bq686DmWWqmZWZGg96OAxi4vzAtP99WUxw
        pOnaxzU2SKXwy9Fz8sctkp0Nxjp/wv/jIi+YS8JKD9RQwVXQ1HgMGU47D6AhRBCbf+4yeTzLUnzDE
        aZ2bfXYJBgVD++8tbgtDMVZWOOXN7rbzMJItFWJpysDqPbUCzWQhv5Z2w17xvhmnQ7mUMynILGUEj
        nbcADoYrSRlq9O2qk6htPZRWodpvEUbXh2uKxhGrh2uduG0HWPjAAdycNHFWCzpk2HtqNqM8imyT3
        DsuosKJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYVh2-00Dvcw-In; Mon, 19 Apr 2021 15:20:16 +0000
Date:   Mon, 19 Apr 2021 16:20:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/7 RFC v3] fs: Hole punch vs page cache filling races
Message-ID: <20210419152008.GD2531743@casper.infradead.org>
References: <20210413105205.3093-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413105205.3093-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 01:28:44PM +0200, Jan Kara wrote:
> Also when writing the documentation I came across one question: Do we mandate
> i_mapping_sem for truncate + hole punch for all filesystems or just for
> filesystems that support hole punching (or other complex fallocate operations)?
> I wrote the documentation so that we require every filesystem to use
> i_mapping_sem. This makes locking rules simpler, we can also add asserts when
> all filesystems are converted. The downside is that simple filesystems now pay
> the overhead of the locking unnecessary for them. The overhead is small
> (uncontended rwsem acquisition for truncate) so I don't think we care and the
> simplicity is worth it but I wanted to spell this out.

What do we actually get in return for supporting these complex fallocate
operations?  Someone added them for a reason, but does that reason
actually benefit me?  Other than running xfstests, how many times has
holepunch been called on your laptop in the last week?  I don't want to
incur even one extra instruction per I/O operation to support something
that happens twice a week; that's a bad tradeoff.

Can we implement holepunch as a NOP?  Or return -ENOTTY?  Those both
seem like better solutions than adding an extra rwsem to every inode.
Failing that, is there a bigger hammer we can use on the holepunch side
(eg preventing all concurrent accesses while the holepunch is happening)
to reduce the overhead on the read side?
