Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736B82C95BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 04:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgLADVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 22:21:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43110 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727521AbgLADVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:21:46 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B13KpaT016251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 22:20:51 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3A4EC420136; Mon, 30 Nov 2020 22:20:51 -0500 (EST)
Date:   Mon, 30 Nov 2020 22:20:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     David Howells <dhowells@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <20201201032051.GK5364@mit.edu>
References: <20201125212523.GB14534@magnolia>
 <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <1942931.1606341048@warthog.procyon.org.uk>
 <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb47ab08-67fc-6151-5669-d4fb514c2b50@sandeen.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:29:47PM -0600, Eric Sandeen wrote:
> On 11/25/20 3:50 PM, David Howells wrote:
> > Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > 
> >> mask=1 bit=0: "attribute not set on this file"
> >> mask=1 bit=1: "attribute is set on this file"
> >> mask=0 bit=0: "attribute doesn't fit into the design of this fs"
> > 
> > Or is "not supported by the filesystem driver in this kernel version".
> 
> For a concrete example, let's talk about the DAX statx attribute.
> 
> If the kernel is configured w/o DAX support, should the DAX attr be in the mask?
> If the block device has no DAX support, should the DAX attr be in the mask?
> If the filesystem is mounted with dax=never, should the DAX attr be in the mask?
> 
> About to send a patch for xfs which answers "no" to all of those, but I'm still
> not quite sure if that's what's expected.  I'll be sure to cc: dhowells, Ira, and
> others who may care...

So you're basically proposing that the mask is indicating whether or
not the attribute is supported by a particular on-disk file system
image and/or how it is currently configured/mounted --- and not
whether an attribute is supported by a particular file system
*implementation*.

For example, for ext4, if the extents feature is not enabled (for
example, when the ext4 file system code is used mount a file system
whose feature bitmask is consistent with a historic ext2 file system)
the extents flag should be cleared from the attribute mask?

This adds a fair amount of complexity to the file system since there
are a number of flags that might have similar issues --- for example,
FS_CASEFOLD_FL, and I could imagine for some file systems, where
different revisions might or might not support reflink FS_NOCOW_FL,
etc.

We should be really clear how applications are supposed to use the
attributes_mask.  Does it mean that they will always be able to set a
flag which is set in the attribute mask?  That can't be right, since
there will be a number of flags that may have some more complex checks
(you must be root, or the file must be zero length, etc.)  I'm a bit
unclear about what are the useful ways in which an attribute_mask can
be used by a userspace application --- and under what circumstances
might an application be depending on the semantics of attribute_mask,
so we don't accidentally give them an opportunity to complain and
whine, thus opening ourselves to another O_PONIES controversy.

> >> mask=0 bit=1: "filesystem is lying snake"
> > 
> > I like your phrasing :-)
> > 
> >> It's up to the fs driver and not the vfs to set attributes_mask, and
> >> therefore (as I keep pointing out to XiaoLi Feng) xfs_vn_getattr should
> >> be setting the mask.

... or maybe the on-disk file system is inconsistent....

       	     	 	      	     	- Ted
