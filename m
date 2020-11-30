Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5652C8D02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 19:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgK3Sjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 13:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388154AbgK3Sjv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:39:51 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB7C20725;
        Mon, 30 Nov 2020 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606761550;
        bh=iyiVXouYuLi8CR86GzyUdOgKT90WbpSteoJW5M4oEVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXy2QaN2MB+nWvfSaoJBWlS6qrs0U5NvQwY+332G7XNAe4FwosH+SNz7wPXVbNa/U
         8cpYTs4w421Ab3JmQ4JYYMBNqH+VWqSiI28EqPoL3V3zlKDxwHSP+oZPJlAIrvhPzM
         wf04wz61EO5+cSNbuIxLWXFNc3DxWAHE1Ufapupw=
Date:   Mon, 30 Nov 2020 10:39:08 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sebastien Buisson <sbuisson@ddn.com>
Subject: Re: backup/restore of fscrypt files
Message-ID: <X8U8TG2ie77YiCF5@sol.localdomain>
References: <D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas,

On Thu, Nov 26, 2020 at 12:12:26AM -0700, Andreas Dilger wrote:
> Currently it is not possible to do backup/restore of fscrypted files without the
> encryption key for a number of reasons.  However, it is desirable to be able to
> backup/restore filesystems with encrypted files for numerous reasons.
> 
> My understanding is that there are two significant obstacles for this to work:
> - the file size reported to userspace for an encrypted file is the "real" file size,
>   but there is data stored beyond "i_size" that is required for decrypting the file
> - the per-inode 16-byte nonce that would need to be backed up and restored for
>   later decryption to be possible
> 
> I'm wondering if it makes sense for stat() to report the size rounded up to the end
> of the encryption block for encrypted files, and then report the "real" size and
> nonce in virtual xattrs (e.g. "trusted.fscrypt_size" and "trusted.fscrypt_nonce")
> so that encrypted files can be backed up and restored using normal utilities like
> tar and rsync if the xattrs are also copied.
> 
> A (small) added benefit of rounding the size of encrypted files up to the end of the
> encryption block is that it makes fingerprinting of files by their size a bit harder.
> Changing the size returned by stat() is not (IMHO) problematic, since it is not
> currently possible to directly read encrypted files without the key anyway.
> 
> The use of "trusted" xattrs would limit the backup/restore of encrypted files to
> privileged users.  We could use "user" xattrs to allow backup by non-root users, but
> that would re-expose the real file size to userspace (not worse than today), and
> would corrupt the file if the size or nonce xattrs were modified by the user.
> 
> It isn't clear whether there is a huge benefit of users to be able to backup/restore
> their own files while encrypted.  For single-user systems, the user will have root
> access anyway, while administrators of multi-user systems need privileged access for
> shared filesystems backup/restore anyway.
> 
> I'm probably missing some issues here, but hopefully this isn't an intractable problem.
> 

There would be a lot more to it than what you describe.

First, filenames are encrypted too.  As a result, there would have to be new
ioctls to allow backing up and restoring encrypted filenames.  The existing
no-key names (the names the kernel shows when you list an encrypted dir) don't
work for this, as due to the NAME_MAX limit, they don't necessarily encode the
whole ciphertext.  There would have to be new APIs which operate on raw
ciphertexts (which may contain the '/' or '\0' bytes) of up to NAME_MAX bytes.

Similarly for symlinks; there would have to be new ioctls to read and create
them, as the existing readlink() and symlink() system calls won't necessarily
work.  Granted, handling symlinks correctly is less critical than filenames, as
we *could* just encode the whole symlink target in base64 and say that if you
create a symlink target over 3072 bytes you're out of luck.  That would be
problematic, but less so than limiting encrypted filenames to ~180 bytes...

So for that and various other reasons such as the ordering of different
operations (when restoring a directory, will it be marked as encrypted before or
after the files are created in it, etc.), I think allowing 'rsync' or 'tar' to
work transparently isn't going to be possible.  Instead, a new tool that knows
how to use ioctls to back up and restore encrypted files would be needed.

Then there is the issue of ordering and how different operations would interact
with each other.  This proposal would require the ability to open() a regular
file that doesn't have its encryption key available, and read and write from it.
open() gives you a file descriptor on which lots of other things could be called
too, so we'd need to make sure to explicitly prevent a lot of things which we
didn't have to worry about before, like fallocate() and various ioctl()s.  Then,
what happens if someone adds an encryption key -- when does the file's page
cache get invalidated, and how does it get synchronized with any ongoing I/O, or
memory maps that may exist, and so on.  (Allowing only direct I/O on files that
don't have encryption key unavailable may help...)

Or what happens if an encrypted directory is "under construction", and someone
tries to access it with the key, but its fscrypt_nonce hasn't been restored yet.
And how are such directories represented on-disk -- what does the encryption
xattr actually contain.  Requiring the encryption policy and nonce to be set
*before* anything is created in the directory would make things simpler, I
think...  Also similarly for setting the real file size -- requiring that it be
set before anything can be written to the file may help.

As for changing the i_size reported to userspace on encrypted files without the
key to include the whole final encrypted block, I don't think that would be an
issue by itself.  Note that it doesn't really "make fingerprinting of files by
their size a bit harder", as i_size would still be unencrypted on-disk.

- Eric
