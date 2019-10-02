Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398ECC9289
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJBTkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 15:40:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47490 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726087AbfJBTkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:40:00 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x92Jdspm012448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Oct 2019 15:39:55 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F245942088C; Wed,  2 Oct 2019 15:39:53 -0400 (EDT)
Date:   Wed, 2 Oct 2019 15:39:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daegyu Han <dgswsk@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: How can I completely evict(remove) the inode from memory and
 access the disk next time?
Message-ID: <20191002193953.GA777@mit.edu>
References: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
 <20191002124651.GC13880@mit.edu>
 <CA+i3KrYvp1pXbpCb_WJDCRx0COU2KCFT_Nfsgcn1mLGrVzErvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i3KrYvp1pXbpCb_WJDCRx0COU2KCFT_Nfsgcn1mLGrVzErvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:42:47PM +0900, Daegyu Han wrote:
> Thank you for your consideration.
> 
> Okay, I will check ocfs2 out.
> 
> By the way, is there any possibility to implement this functionality
> in the vfs layer?
> 
> I looked at the dcache.c, inode.c, and mm/vmscan.c code and looked at
> several functions,
> and as you said, they seem to have way complex logic.
> 
> The logic I thought was to release the desired dentry, dentry_kill()
> the negative dentry, and break the inodes of the file that had that
> dentry.

The short version is that objects have dependencies on other objects.
For example, a file descriptor object has a reference to the dentry of
the file which is open.  A file dentry or directory dentry object
references its parent directory's dentry object, etc.  You can not
evict an object when other objects have references on it --- otherwise
those references become dangling pointers, Which Would Be Bad.

There are solutions for remote file systems (network, clustered, and
shared disk file systems).  So the VFS layer can support these file
systems quite well.  Look at ceph, nfs, ofs2, and gfs for examples for
that.  But it's *complicated* because doing it in a way which is
highly performant, both for remote file systems, and as well as
supporting high-performance local disk file systems, is a lot more
than your very simple-minded, "just kill the dentry/inode structures
and reread them from disk".

Are you trying to do this for a university class project or some such?
If so, we're not here to do your homework for you.  If you want a
practical solution, please use an existing shared-disk or networked
file system.

Best regards,

					- Ted
