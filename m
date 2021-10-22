Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3949B437107
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 06:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhJVEqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 00:46:33 -0400
Received: from p3plsmtp05-06-02.prod.phx3.secureserver.net ([97.74.135.51]:51999
        "EHLO p3plwbeout05-06.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhJVEq3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 00:46:29 -0400
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id dmHzm4fT2VDBpdmI0mldmt; Thu, 21 Oct 2021 21:36:20 -0700
X-CMAE-Analysis: v=2.4 cv=A4qpg4aG c=1 sm=1 tr=0 ts=61723fc4
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10
 a=A-M8zVwSJslglwQpLHsA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  dmHzm4fT2VDBp
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp01.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1mdmHy-0007Zy-7e; Fri, 22 Oct 2021 05:36:19 +0100
Subject: Re: Readahead for compressed data
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
From:   Phillip Lougher <phillip@squashfs.org.uk>
Message-ID: <69359b86-9999-e484-8ca4-ed34b64e65c7@squashfs.org.uk>
Date:   Fri, 22 Oct 2021 05:36:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXHK5HrQpJu9oy8w@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfOox4aIG2Y366RuPFHj/mqUVZybfwARrqBahgKkFSm+2htF7JdCtnmzytpqVfJyKpo+vFw4BgNPq+bEdTZPsEBiZAByosy0bwWr9hiip+H2NZ7IyKo/c
 16GaMUcymgXk7NrnDuMsaVrWkHuoRjg4Li3FcSsoBG6SGX5GDONgowUbrKvK4DuXjMRgAqSq7A0e3W/f6zGBJoeLCFccY89jjCY=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/10/2021 21:17, Matthew Wilcox wrote:
 > As far as I can tell, the following filesystems support compressed data:
 >
 > bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
 >
 > I'd like to make it easier and more efficient for filesystems to
 > implement compressed data.  There are a lot of approaches in use today,
 > but none of them seem quite right to me.  I'm going to lay out a few
 > design considerations next and then propose a solution.  Feel free to
 > tell me I've got the constraints wrong, or suggest alternative solutions.
 >
 > When we call ->readahead from the VFS, the VFS has decided which pages
 > are going to be the most useful to bring in, but it doesn't know how
 > pages are bundled together into blocks.  As I've learned from talking to
 > Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
 > something we can teach the VFS.
 >
 > We (David) added readahead_expand() recently to let the filesystem
 > opportunistically add pages to the page cache "around" the area requested
 > by the VFS.  That reduces the number of times the filesystem has to
 > decompress the same block.  But it can fail (due to memory allocation
 > failures or pages already being present in the cache).  So filesystems
 > still have to implement some kind of fallback.
 >
 > For many (all?) compression algorithms (all?) the data must be mapped at
 > all times.  Calling kmap() and kunmap() would be an intolerable overhead.
 > At the same time, we cannot write to a page in the page cache which is
 > marked Uptodate.  It might be mapped into userspace, or a read() be in
 > progress against it.  For writable filesystems, it might even be dirty!
 > As far as I know, no compression algorithm supports "holes", implying
 > that we must allocate memory which is then discarded.
 >
 > To me, this calls for a vmap() based approach.  So I'm thinking
 > something like ...
 >
 > void *readahead_get_block(struct readahead_control *ractl, loff_t start,
 > 			size_t len);
 > void readahead_put_block(struct readahead_control *ractl, void *addr,
 > 			bool success);
 >
 > Once you've figured out which bytes this encrypted block expands to, you
 > call readahead_get_block(), specifying the offset in the file and length
 > and get back a pointer.  When you're done decompressing that block of
 > the file, you get rid of it again.

Hi Matthew,

I quite like this new interface.  It should be fairly straight-forward
to make Squashfs use this interface, and it will simplify some of the
code, and make some of the decompressors more efficient.

As I see it, it removes many of the hoops that Squashfs has to go
through to push the additional uncompressed data into the page cache.

It is also a generic solution, and one which doesn't rely on a 
particular decompressor API or way of working, which means it shouldn't 
break any of the existing decompressor usage in the kernel.

The one issue with this generic solution is I fear a lot of people
will complain it is too generic, and prevents some optimisations
which they could have made on their particular decompressor or
filesystem.  The issue that it requires temporary pages to be
allocated upfront (if the page cannot be added to the page cache) has
already been brought up.

At this point I will try to play devil's advocate.  What is the
alternative to passing back a vmapped area of memory to the
filesystem?  The obvious alternative is to pass back an array
of pointers to the individual page structures, or a NULL pointer
representing a hole where the page could not be allocated in the
cache.

This alternative interface has the advantage that a NULL pointer is
passed representing a hole, rather than temporary memory being allocated
upfront.  It is then up to the filesystem and/or decompressor to
deal with the NULL pointer hole which may avoid the use of so
much temporary memory.

But the fact is in the kernel there are many different decompressors
with different APIs and different ways of working.  There are some
(like zlib, zstd, xz) which are "multi-shot" and some (like lzo, lz4)
which are "single-shot".

Multi-shot decompressors allow themselves to be called with only a small
output buffer.  Once the output buffer runs out, they exit and ask to be
called again with another output buffer.  Squashfs uses that to pass in
the set of discontiguous PAGE sized buffers allocated from the page
cache.  Obviously, if Squashfs got a NULL pointer hole, it could switch
to using a single temporary 4K buffer at that point.

But single-shot decompressors expect to be called once, with a single
contiguous output buffer.  They don't work with a set of discontiguous 
PAGE sized buffers.  Due to this Squashfs has to use a contiguous 
"bounce buffer" which the decompressor outputs to, and then copy it to 
the page cache buffers.

The vmap based interface proposed is a generic interface, it works with
both "multi-shot" and "single-shot" decompressors, because it presents
a single contiguous output buffer, and avoids making the filesystem
work with page structures.  There is a lot to like about this approach.

Avoiding using page structures also ties in with some of the other
work Matthew has been doing to clean up the kernel's over reliance
on page structures.  This is something which I am in agreement.

Phillip

