Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF85538700F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbhERCzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 22:55:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34096 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345671AbhERCzP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 22:55:15 -0400
Received: from callcc.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14I2rHfd027550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 22:53:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 29672420119; Mon, 17 May 2021 22:53:16 -0400 (EDT)
Date:   Mon, 17 May 2021 22:53:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RERESEND v9 0/9] fs: interface for directly
 reading/writing compressed data
Message-ID: <YKMsHMS4IfO8PhN1@mit.edu>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
 <YKLt5GyznttizBjd@relinquished.localdomain>
 <YKLyvnb19QmayJaJ@gmail.com>
 <YKL7W7QO7Wis2n8a@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKL7W7QO7Wis2n8a@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 04:25:15PM -0700, Omar Sandoval wrote:
> > Well, assuming we're talking about regular files only (so file contents
> > encryption, not filenames encryption),
> 
> Yes, I was thinking of regular files. File operations using encrypted
> names sounds... interesting, but I think out of scope for this.

So the question I have is why would you want to get the raw encrypted
data?  One possible reason (and this is what Michael Halwcrow and I
had tried designing years ago) was so you could backup a device that
had multiple users' files without having all of the users' keys ---
and then be able to restore them.  So for example, suppose you had a
tablet that is shared by multiple family members, and you want to be
backup all of the data on the shared device so that it could be
restored in case one of the kids drop the tablet in the swimming pool....

But in order to do that, you need to be able to restore the encrypted
files in the encrypted directories.  In practice, encrypted files
generally exist in encrypted directories.  That's because the typical
way fscrypt gets used is we set a policy on an empty directory, and
then all of the newly files created files have encrypted file names,
inherit the directory's encryption policy, and then have encrypted
file contents.

So do you have the encryption key, or not?  If you do have the
encryption key, then you can ignore the issue of the file name when
you open the file, but what's the reason why you would want to extract
out the raw encrypted data plus the raw encryption metadata?  You're
not going to be able to restore the encrypted file, in the encrypted
directory name.  Perhaps it's because you want to keep the data
encrypted while you're tranferring it --- but the filename needs to be
encrypted as well, and given modern CPU's, with or without
inline-crypto engines, the cost of decrypting the file data and then
re-encrypting it in the backup key isn't really that large.

If you don't have the encryption key, then you need to be able to open
the file using using the encrypted name (which fscrypt does support)
and then extract out the encrypted file name using another bundle of
encryption metadata.  So that's a bit more complicated, but it's
doable.

The *really* hard part is *restoring* an encrypted directory
hierarchy.  Michael and I did create a straw design proposal (which is
too small to fit in the margins of this e-mail :-), but suffice it to
say that the standard Posix system calls are not sufficient to be able
to create encrypted files and encrypted directories, and it would have
been messy as all hell.  Which is why we breathed a sign of relief
when the original product requirement of being able to do
backup/restore of shared devices went away.   :-)

The thing is, though, just being able to extract out regular files in
their raw encrypted on-disk form, along with their filename metadata,
seems to be a bit of a party trick without a compelling use case that
I can see.  But perhaps you have something in mind?

						- Ted
