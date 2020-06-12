Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025321F71FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 03:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFLB6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 21:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgFLB6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 21:58:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03143C03E96F;
        Thu, 11 Jun 2020 18:58:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jjYxu-007MwO-TA; Fri, 12 Jun 2020 01:58:42 +0000
Date:   Fri, 12 Jun 2020 02:58:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
Message-ID: <20200612015842.GC23230@ZenIV.linux.org.uk>
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612004644.255692-1-mike.kravetz@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 05:46:43PM -0700, Mike Kravetz wrote:
> The routine is_file_hugepages() checks f_op == hugetlbfs_file_operations
> to determine if the file resides in hugetlbfs.  This is problematic when
> the file is on a union or overlay.  Instead, define a new file mode
> FMODE_HUGETLBFS which is set when a hugetlbfs file is opened.  The mode
> can easily be copied to other 'files' derived from the original hugetlbfs
> file.
> 
> With this change hugetlbfs_file_operations can be static as it should be.
> 
> There is also a (duplicate) set of shm file operations used for the routine
> is_file_shm_hugepages().  Instead of setting/using special f_op's, just
> propagate the FMODE_HUGETLBFS mode.  This means is_file_shm_hugepages() and
> the duplicate f_ops can be removed.

s/HUGETLBFS/HUGEPAGES/, please.

> While cleaning things up, change the name of is_file_hugepages() to
> is_file_hugetlbfs().  The term hugepages is a bit ambiguous.

Don't, especially since the very next patch adds such on overlayfs...

Incidentally, can a hugetlbfs be a lower layer, while the upper one
is a normal filesystem?  What should happen on copyup?
