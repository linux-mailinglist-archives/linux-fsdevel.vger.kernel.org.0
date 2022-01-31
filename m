Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8EF4A3CAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 04:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357480AbiAaDMB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 22:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiAaDMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 22:12:01 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D450C061714;
        Sun, 30 Jan 2022 19:12:01 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEN6l-005zHw-Ce; Mon, 31 Jan 2022 03:11:59 +0000
Date:   Mon, 31 Jan 2022 03:11:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] vfs: Pre-allocate superblock in sget_fc() if !test
Message-ID: <YfdTfxtUIpKp0mUR@zeniv-ca.linux.org.uk>
References: <20220124161006.141323-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124161006.141323-1-longman@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:10:06AM -0500, Waiman Long wrote:
> When the test function is not defined in sget_fc(), we always need
> to allocate a new superblock. So there is no point in acquiring the
> sb_lock twice in this case. Optimize the !test case by pre-allocating
> the superblock first before acquring the lock.

Umm...  Do you really see the contention on that sucker?  Because if you
do, I'd expect sget_fc() to be the least of your problems.

TBH, I'd be very surprised if that had caused measurable improvement in
any setup.  Seriously, take a look at alloc_super().  If spin_lock() +
spin_unlock() + branch is noticable among all that...  And it's not
as if you were not going to dirty that cacheline shortly afterwards
anyway, so cacheline pingpong is not an issue either...

I'm not saying that the patch is broken, I'm just wondering if it's worth
bothering with.
