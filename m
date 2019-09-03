Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB65A76C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 00:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfICWQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 18:16:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39935 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbfICWQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:16:47 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x83MGcB2011727
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 18:16:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4638F42049E; Tue,  3 Sep 2019 18:16:38 -0400 (EDT)
Date:   Tue, 3 Sep 2019 18:16:38 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
Message-ID: <20190903221638.GF2899@mit.edu>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
 <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:31:06PM -0700, Deepa Dinamani wrote:
> > We need to drop this commit (ext4: Initialize timestamps limits), or
> > at least the portion which adds the call to the EXT4_INODE_SET_XTIME
> > macro in ext4.h.
> 
> As Arnd said, I think this can be fixed by warning only when the inode
> size is not uniformly 128 bytes in ext4.h. Is this an acceptable
> solution or we want to drop this warning altogether?

If we have a mount-time warning, I really don't think a warning in the
kernel is going to be helpful.  It's only going to catch the most
extreme cases --- specifically, a file system originally created and
written using ext3 (real ext3; even before we dropped ext3 from the
upstream kernel, most distributions were using ext4 to provide ext3
support) and which included enough extended attributes that there is
no space in the inode and the external xattr block for there to make
space for the extra timestamp.  That's extremely rare edge cases, and
I don't think it's worth trying to catch it in the kernel.

The right place to catch this is rather in e2fsck, I think.

> We have a single mount time warning already in place here. I did not
> realize some people actually chose to use 128 byte inodes on purpose.

Yes, there are definitely some people who are still doing this.  The
other case, as noted on this thread, is that file systems smaller than
512 MiB are treated as type "small" (and file systems smaller than
4MiB are treated as type "floppy"), and today, we are still using 128
byte inodes to minimize the overhead of the inode table.  It's
probably time to reconsider these defaults, but that's an e2fsprogs
level change.  And that's not going to change the fact that there are
people who are deliberately choosing to use 128 byte inode.

Changes that we could consider:

1)  Change the default for types "small" and "floppy" to be 256 byte inodes.

2)  Add a warning to mke2fs to give a warning when creating a file
system with 128 byte inodes.

3)  Add code to e2fsck to automatically make room for the timestamp if
possible.

4)  Add code to e2fsck so that at some pre-determined point in the
future (maybe 5 years before 2038?) have it print warnings for file
systems using 128 byte inodes, and for file systems with 256+ byte
inodes and where there isn't enough space in the inode for expanded
timestamps.

Cheers,

						- Ted
