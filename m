Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4735DFC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhDMNKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 09:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhDMNK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:10:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE25C061756;
        Tue, 13 Apr 2021 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vBa5I9cnF6gq99nwmVfNLF184LBtNaf0t/nHm2F1SjU=; b=PJNh4509S/UB/1YM3kxTa7Z8Vu
        slvZd7GxxNVfAt2IsAcpbueGzJxG8oWB0L6NOslHl1pyA0/NOMbcQj8ACitj9VV8WZz9b+hNaS7Wy
        ftKsPyRCeqC8nKu0rLxr0dYFUQSgD6OSOoF4GkYhAy9LEmZ3/YJ9SNL56ZpG9ndU3Y2ok2wcOu60C
        m0kk8q0pSfdc1QiRP6cm23bHtLYX9e8MIeoqu0GnoXgzvUzaK6Y9v+wc8d+OlTk0X/wlko71dwOkK
        fS/DO+Aiq7gMCk0HVJpF3P1Qm0lDFNJh2YNesSkzt/Wv2vEIjaMVuiWxyK1s61/w6NBAqU6g9+dQK
        utIXcUHw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWIne-005leB-9K; Tue, 13 Apr 2021 13:09:53 +0000
Date:   Tue, 13 Apr 2021 14:09:50 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/7 RFC v3] fs: Hole punch vs page cache filling races
Message-ID: <20210413130950.GD1366579@infradead.org>
References: <20210413105205.3093-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413105205.3093-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Also when writing the documentation I came across one question: Do we mandate
> i_mapping_sem for truncate + hole punch for all filesystems or just for
> filesystems that support hole punching (or other complex fallocate operations)?
> I wrote the documentation so that we require every filesystem to use
> i_mapping_sem. This makes locking rules simpler, we can also add asserts when
> all filesystems are converted. The downside is that simple filesystems now pay
> the overhead of the locking unnecessary for them. The overhead is small
> (uncontended rwsem acquisition for truncate) so I don't think we care and the
> simplicity is worth it but I wanted to spell this out.

I think all makes for much better to understand and document rules,
so I'd shoot for that eventually.

Btw, what about locking for DAX faults?  XFS seems to take
the mmap sem for those as well currently.
