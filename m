Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23C2C8EB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 21:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgK3UKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 15:10:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57385 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727328AbgK3UKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:10:15 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AUK99nM026331
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 15:09:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4EE63420136; Mon, 30 Nov 2020 15:09:09 -0500 (EST)
Date:   Mon, 30 Nov 2020 15:09:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-fscrypt@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sebastien Buisson <sbuisson@ddn.com>
Subject: Re: backup/restore of fscrypt files
Message-ID: <20201130200909.GI5364@mit.edu>
References: <D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca>
 <X8U8TG2ie77YiCF5@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8U8TG2ie77YiCF5@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:39:08AM -0800, Eric Biggers wrote:
> Then there is the issue of ordering and how different operations would interact
> with each other.  This proposal would require the ability to open() a regular
> file that doesn't have its encryption key available, and read and write from it.
> open() gives you a file descriptor on which lots of other things could be called
> too, so we'd need to make sure to explicitly prevent a lot of things which we
> didn't have to worry about before, like fallocate() and various ioctl()s.  Then,
> what happens if someone adds an encryption key -- when does the file's page
> cache get invalidated, and how does it get synchronized with any ongoing I/O, or
> memory maps that may exist, and so on.  (Allowing only direct I/O on files that
> don't have encryption key unavailable may help...)

I had put together a draft patch series which used a combination of
ioctls to set and get the necessary encryption metadata (including the
filename), and then allowed root to allow Direct I/O to fetch the data
blocks.

But it wa a mess, especially if you were backing up a directory
hierarchy, in terms of what would need to be done on userspace side
during the restore operation --- especially if one of the requirements
is that the *restore* operation had to work if you didn't have the
encryption key at restore time.  (Think of an Android tablet that had
muliple users, and the person doing the backup and restore might not
have all of the encryption keys available to her.)

Fortunately, the business requirement for this disappeared, and the
patch series (which was super messy, and not tested because it would
have required writing some complex code on the restore side --- the
issue is with the fact that mkdir generates a new encryption key for
new directories, so we would need to have a way to reset the key for a
directory after it was freshly created, but before any filenames were
added --- like I said, it was a real mess), and so I was happy to let
that patch series die a natural death.

These days, we now have support for Direct I/O when the encrpytion is
done by hardware between the OS and the storage device, and the
addition of inline crypto and the v2 encryption keys would have made
the patch series invalid (and far more complex, if someone wanted to
reconstitute it).

So it *could* be done, but it's a huge amount of work, and without the
business justification to dedicate the software engineering time to
implement both the kernel side patches, and the userspace backup and
restore (which would be different for a traditional Linux desktop and
what might be used by say, an Android userspace application), I
suspect it's pretty unlikely to happen.

Of course, if some volunteer wants to try do all of the work, I
suspect Eric and I could provide some design help --- but it really
isn't going to be trivial to design and implement.

Cheers,

					- Ted
