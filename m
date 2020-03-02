Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C51176088
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCBQ46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 11:56:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53437 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726775AbgCBQ46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:56:58 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 022Gub0E024528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 Mar 2020 11:56:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1BA5842045B; Mon,  2 Mar 2020 11:56:37 -0500 (EST)
Date:   Mon, 2 Mar 2020 11:56:37 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
Message-ID: <20200302165637.GA6826@mit.edu>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kirill,

In a couple of your comments on this patch series, you mentioned
"defragmentation".  Is that because you're trying to use this as part
of e4defrag, or at least, using EXT4_IOC_MOVE_EXT?

If that's the case, you should note that input parameter for that
ioctl is:

struct move_extent {
	__u32 reserved;		/* should be zero */
	__u32 donor_fd;		/* donor file descriptor */
	__u64 orig_start;	/* logical start offset in block for orig */
	__u64 donor_start;	/* logical start offset in block for donor */
	__u64 len;		/* block length to be moved */
	__u64 moved_len;	/* moved block length */
};

Note that the donor_start is separate from the start of the file that
is being defragged.  So you could have the userspace application
fallocate a large chunk of space for that donor file, and then use
that donor file to defrag multiple files if you want to close pack
them.

Many years ago, back when LSF/MM colocated with a larger
storage-focused conference so we could manage to origanize an ext4
developer's workshop, we had talked about ways we create kernel
support for a more powerful userspace defragger, which could also
defragment the free space, so that future block allocations were more
likely to be successful.

The discussions surrounded interfaces where userspace could block (or
at least strongly dissuade unless the only other alternative was
returning ENOSPC) the kernel from allocating out of a certain number
of block groups.  And then also to have an interface where for a
particular process (namely, the defragger), to make the kernel
strongly prefer that allocations come out of an ordered list of block
groups.

(Of course these days, now that the cool kids are all embracing eBPF,
one could imagine a privileged interface where the defragger could
install some kind of eBPF program which provided enhanced policy to
ext4's block allocator.)

No one ever really followed through with this, in part because the
details of allowing userspace (and it would have to be privileged
userspace) to dictate policy to the block allocator has all sorts of
potential pitfalls, and in part because no company was really
interested in funding the engineering work.  In addition, I'll note
that the windows world, the need and interest for defragging has gone
done significantly with the advent more sophisticated file systems
like NTFSv5, which doesn't need defragging nearly as often as say, the
FAT file system.  And I think if anything, the interst in doing work
with e4defrag has decreased even more over the years.

That being said, there has been some interest in making changes to
both the block allocator and some kind of on-line defrag which is
optimized for low-end flash (such as the kind found in android
handsets).  There, the need to be careful that we don't end up
increasing the write wearout becomes even more critical, although the
GC work which f2fs does involve extra moving around of data blocks,
and phones have seemed to do fine.  Of course, the typical phone only
has to last 2-3 years before the battery dies, the screen gets
cracked, and/or the owner decides they want the latest cool toy from
the phone manufacturers.  :-)

In any case, if your goal is really some interface to support on-line
defragmentation for ext4, you want to consider whether the
EXT4_IOC_MOVE_EXTENT interface is sufficiently powerful such that you
don't really need to mess around with new block allocation hints.

Cheers,

						- Ted
