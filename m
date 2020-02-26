Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16851170345
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgBZPzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 10:55:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgBZPzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fzv0zma6qNHzEymKrEWyqTitusIASlSI8vJyXmG2rJc=; b=D7H2FzbBGfi2n+JNeba/gdYqyy
        bIjC1RC6wR8orJYPP9f8xd8bov3RjjVYOnJzPe4diHk1oURUDw4BV87duYPM2LJJrWdTBqmzpMF6r
        9X2a5sGhpu0+buC9IRIR1bBaMIOAXeLtrATuvG+kr0DrATZKcq4PSvGuIAwRUaiK5inwJmAqaoAOM
        YINQWRRM41eE9hnRno5tCSxgMLPD2IOINRAp6v/scLRjaH5rOK4h3Hb/xRyMOMzVvARLqj0KljAoZ
        7ICJnrM6/FvMGFtaePismAf6+PJGACByG2yuJ9/sf046zxiIcfgjPWk5Feob+HTJIp05kw9i6hMj5
        Z3yvlKsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6z1t-0007rU-Kj; Wed, 26 Feb 2020 15:55:21 +0000
Date:   Wed, 26 Feb 2020 07:55:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
Message-ID: <20200226155521.GA24724@infradead.org>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
> This adds a support of physical hint for fallocate2() syscall.
> In case of @physical argument is set for ext4_fallocate(),
> we try to allocate blocks only from [@phisical, @physical + len]
> range, while other blocks are not used.

Sorry, but this is a complete bullshit interface.  Userspace has
absolutely no business even thinking of physical placement.  If you
want to align allocations to physical block granularity boundaries
that is the file systems job, not the applications job.
