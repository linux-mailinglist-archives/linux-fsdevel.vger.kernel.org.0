Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 139CEB4E8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfIQMya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 08:54:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53039 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfIQMy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:54:29 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8HCsNLH023664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Sep 2019 08:54:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 20CBE420811; Tue, 17 Sep 2019 08:54:23 -0400 (EDT)
Date:   Tue, 17 Sep 2019 08:54:23 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daegyu Han <hdg9400@gmail.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>, linux-fsdevel@vger.kernel.org
Subject: Re: Sharing ext4 on target storage to multiple initiators using
 NVMeoF
Message-ID: <20190917125423.GE6762@mit.edu>
References: <CAARcW+r3EvFktaw-PfxN_V-EjtU6BvT7wxNvUtFiwHOdbNn2iA@mail.gmail.com>
 <bfa92367-f96a-8a4e-71c7-885956e10d0e@sandeen.net>
 <CAARcW+pLLABT9sq5LHykKmrcNjct8h64_6ePKeVGsOzeLgG8Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARcW+pLLABT9sq5LHykKmrcNjct8h64_6ePKeVGsOzeLgG8Tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:44:00AM +0900, Daegyu Han wrote:
> It started with my curiosity.
> I know this is not the right way to use a local filesystem and someone
> would feel weird.
> I just wanted to organize the situation and experiment like that.
> 
> I thought it would work if I flushed Node B's cached file system
> metadata with the drop cache, but I didn't.
> 
> I've googled for something other than the mount and unmount process,
> and I saw a StackOverflow article telling file systems to sync via
> blockdev --flushbufs.
> 
> So I do the blockdev --flushbufs after the drop cache.
> However, I still do not know why I can read the data stored in the
> shared storage via Node B.

There are many problems, but the primary one is that Node B has
caches.  If it has a cached version of the inode table block, why
should it reread it after Node A has modified it?  Also, the VFS also
has negative dentry caches.  This is very important for search path
performance.  Consider for example the compiler which may need to look
in many directories for a particular header file.  If the C program has:

#include "amazing.h"

The C compiler may need to look in a dozen or more directories trying
to find the header file amazing.h.  And each successive C compiler
process will need to keep looking in all of those same directories.
So the kernel will keep a "negative cache", so if
/usr/include/amazing.h doesn't exist, it won't ask the file system
when the 2nd, 3rd, 4th, 5th, ... compiler process tries to open
/usr/include/amazing.h.

You can disable all of the caches, but that makes the file system
terribly, terribly slow.  What network file systems will do is they
have schemes whereby they can safely cache, since the network file
system protocol has a way that the client can be told that their
cached information must be reread.  Local disk file systems don't have
anything like this.

There are shared-disk file systems that are designed for
multi-initiator setups.  Examples of this include gfs and ocfs2 in
Linux.  You will find that they often trade performance for
scalability to support multiple initiators.

You can use ext4 for fallback schemes, where the primary server has
exclusive access to the disk, and when the primary dies, the fallback
server can take over.  The ext4 multi-mount protection scheme is
designed for those sorts of use cases, and it's used by Lustre
servers.  But only one system is actively reading or writing to the
disk at a time, and the fallback server has to replay the journal, and
assure that primary server won't "come back to life".  Those are
sometimes called STONITH schemes ("shoot the other node in the head"),
and might involve network controlled power strips, etc.

Regards,

						- Ted
