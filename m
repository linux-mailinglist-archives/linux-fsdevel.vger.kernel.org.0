Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5187B3616DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhDPAoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 20:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbhDPAoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 20:44:04 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E0C061574;
        Thu, 15 Apr 2021 17:43:40 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXCa3-005daQ-S7; Fri, 16 Apr 2021 00:43:31 +0000
Date:   Fri, 16 Apr 2021 00:43:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Chao Yu <yuchao0@huawei.com>, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH] direct-io: use read lock for DIO_LOCKING flag
Message-ID: <YHjds1kY6h2kzIZ+@zeniv-ca.linux.org.uk>
References: <20210415094332.37231-1-yuchao0@huawei.com>
 <20210415102413.GA25217@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415102413.GA25217@quack2.suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 15, 2021 at 12:24:13PM +0200, Jan Kara wrote:
> On Thu 15-04-21 17:43:32, Chao Yu wrote:
> > 9902af79c01a ("parallel lookups: actual switch to rwsem") changes inode
> > lock from mutex to rwsem, however, we forgot to adjust lock for
> > DIO_LOCKING flag in do_blockdev_direct_IO(),

The change in question had nothing to do with the use of ->i_mutex for
regular files data access.

> > so let's change to hold read
> > lock to mitigate performance regression in the case of read DIO vs read DIO,
> > meanwhile it still keeps original functionality of avoiding buffered access
> > vs direct access.
> > 
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks for the patch but this is not safe. Originally we had exclusive lock
> (with i_mutex), switching to rwsem doesn't change that requirement. It may
> be OK for some filesystems to actually use shared acquisition of rwsem for
> DIO reads but it is not clear that is fine for all filesystems (and I
> suspect those filesystems that actually do care already don't use
> DIO_LOCKING flag or were already converted to iomap_dio_rw()). So unless
> you do audit of all filesystems using do_blockdev_direct_IO() with
> DIO_LOCKING flag and make sure they are all fine with inode lock in shared
> mode, this is a no-go.

Aye.  Frankly, I would expect that anyone bothering with that kind of
analysis for given filesystem (and there are fairly unpleasant ones in the
list) would just use the fruits of those efforts to convert it over to
iomap.

"Read DIO" does not mean that accesses to private in-core data structures used
by given filesystem can be safely done in parallel.  So blanket patch like
that is not safe at all.
