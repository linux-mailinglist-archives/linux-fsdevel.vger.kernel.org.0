Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132BA387D48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350583AbhERQWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 12:22:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40807 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350575AbhERQWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 12:22:41 -0400
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14IGL0w8021834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 12:21:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3B003420119; Tue, 18 May 2021 12:21:00 -0400 (EDT)
Date:   Tue, 18 May 2021 12:21:00 -0400
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
Message-ID: <YKPpbEuRmxQQ89si@mit.edu>
References: <cover.1621276134.git.osandov@fb.com>
 <CAHk-=wh74eFxL0f_HSLUEsD1OQfFNH9ccYVgCXNoV1098VCV6Q@mail.gmail.com>
 <YKLt5GyznttizBjd@relinquished.localdomain>
 <YKLyvnb19QmayJaJ@gmail.com>
 <YKL7W7QO7Wis2n8a@relinquished.localdomain>
 <YKMsHMS4IfO8PhN1@mit.edu>
 <YKN88AbnmW73uRPw@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKN88AbnmW73uRPw@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 01:38:08AM -0700, Omar Sandoval wrote:
> Thanks for the detailed response, Ted. I personally don't have a use
> case for reading and writing encrypted data. I only care about skipping
> compression/decompression, but early on it was pointed out that this API
> could potentially also be used for encrypted data. The question at this
> point is: if someone else comes along and solves the problems with
> restoring encrypted filenames, is this interface enough for them to
> restore the encrypted file data? It seems like the answer is yes, with a
> couple of additions to fscrypt. I should've been clearer that I don't
> have concrete plans to do this, I just wanted to leave the door open for
> it so that we don't need a second, very similar interface.

Well, practically speaking, we would need to have a way to extract out
the encrypted file name information; and given that an encrypted file
could have hard links, we need to be able to obtain the encrypted file
name information for the dentry that was used to open that file.  This
arguably should be separate from the encryption information for data
stream itself, so if we want to handwave how we fetch the encrypted
filename info (maybe some magic ioctl, or maybe via using some kind of
magic RWF flag used for reading encrypted directories that are opened
via O_DIRECTORY, which sorta-works like readdir() but also returns
some additional metadata information for each directory entry), sure
it should be possible to use your proposed interface as a starting
point.

I'm not sure we want to try to design all of the details of how to get
the encrypted data plus encryption metadata for the data stream, but
in theory, so long as there is a way to get the encryption metadata,
sure, it could work.  One other approach is to just abuse the xattr
interface, the way we do with Posix ACL's and Capabilities, where the
on-disk format and the format used when we query a file's ACL via the
xattr interface don't necessary have to be identical.  I'm sure that
will result in howls of outrage in some quarters, but this is
something for which we have a precedent.

Cheers,

					- Ted
